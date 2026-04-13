---
title: "Building privacy-first web analytics on Cloudflare Workers and D1"
published: false
description: "How Beam uses Cloudflare Workers, D1 (SQLite at the edge), and a cookie-free daily hashing approach to deliver privacy-respecting analytics in a 1,592-byte tracking script."
tags: cloudflare, typescript, webdev, privacy
canonical_url: https://beam-privacy.com/blog/edge-analytics-architecture
cover_image: https://beam-privacy.com/og/blog-edge-analytics
---

I recently shipped [Beam](https://beam-privacy.com/show-hn?ref=devto-article&utm_source=devto&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=intro_link) — a privacy-first analytics tool that runs entirely on Cloudflare's edge network. This post covers the architecture in detail: how tracking works, how data flows, why D1 made sense for storage, and how we count unique visitors without cookies or fingerprinting.

If you've worked with Cloudflare Workers before, some of this will be familiar ground. If you haven't, hopefully it's a useful look at what "edge-native" actually means for a real product.

---

## The Problem With Existing Analytics

Most analytics tools fall into one of two failure modes:

1. **They're too invasive.** Google Analytics, Mixpanel, and similar tools use cookies, localStorage IDs, or device fingerprinting to track users persistently across sessions and domains. This requires GDPR/CCPA consent banners and creates a compliance burden for every site that uses them.

2. **They're too heavy.** The Google Analytics 4 script is ~90KB. Even "lightweight" alternatives like Segment's analytics.js can hit 30–70KB. For performance-conscious developers, this is a non-starter.

Beam's design goals were:

- No cookies. No localStorage. No persistent identifiers.
- Tracking script under 2KB raw (we're at 1,592 bytes).
- No consent banner required under GDPR (because no personal data is processed).
- Useful analytics: pageviews, referrers, countries, browsers, custom events, goal conversions.

---

## The Stack

```
Tracking script (browser) → Cloudflare Workers (edge) → D1 (SQLite) + KV (cache)
                                                          ↕
                                              Stripe (billing) + Resend (email)
```

Everything runs on Cloudflare's infrastructure:

| Layer | Technology | Purpose |
|---|---|---|
| Compute | Cloudflare Workers | Request handling, API, server-rendered HTML |
| Storage | D1 (SQLite at edge) | Pageviews, custom events, users, sites |
| Cache/state | KV | Rate limiting, badge counts, one-time secrets, scan cache |
| CDN/DNS | Cloudflare Zones | Static assets, routing |
| Billing | Stripe | Subscription management |
| Email | Resend | Weekly digests, anomaly alerts |

---

## The Tracking Script

The entire client-side piece is `beam.js` — 1,592 bytes, no dependencies, no transpilation required:

```js
(() => {
  const currentScript = document.currentScript
  const siteId = currentScript?.getAttribute('data-site-id')

  if (!siteId || navigator.doNotTrack === '1') {
    return
  }

  const endpoint = '/api/collect'
  const urlParams = new URLSearchParams(location.search)
  const timezone = Intl.DateTimeFormat().resolvedOptions().timeZone

  function send(payload) {
    const body = JSON.stringify(payload)

    if (navigator.sendBeacon) {
      navigator.sendBeacon(endpoint, new Blob([body], { type: 'application/json' }))
      return
    }

    fetch(endpoint, {
      method: 'POST',
      body,
      headers: { 'Content-Type': 'application/json' },
      keepalive: true,
    })
  }

  const beam = window.beam || {}

  beam.track = (eventName, properties) => {
    if (!eventName) return
    send({
      type: 'event',
      site_id: siteId,
      event_name: String(eventName).slice(0, 64),
      path: location.pathname,
      referrer: document.referrer,
      language: navigator.language,
      timezone,
    })
  }

  window.beam = beam

  send({
    site_id: siteId,
    path: location.pathname,
    referrer: document.referrer,
    screen_width: screen.width,
    language: navigator.language,
    timezone,
    utm_source: urlParams.get('utm_source') || undefined,
    utm_medium: urlParams.get('utm_medium') || undefined,
    utm_campaign: urlParams.get('utm_campaign') || undefined,
  })
})()
```

Key design choices:

**`sendBeacon` with fallback to `fetch`.**
`sendBeacon` fires-and-forgets — it doesn't block page unload and doesn't require a response. The `fetch` fallback with `keepalive: true` covers browsers that don't support `sendBeacon`.

**DNT respected.**
If `navigator.doNotTrack === '1'`, the script exits immediately. No data is sent.

**No IP address in the payload.**
The client never sends its IP. Country is derived server-side from Cloudflare's `cf.country` header (geolocation-based country code, not the IP itself).

---

## Unique Visitor Counting Without Cookies

This is the core privacy mechanism. Instead of assigning each visitor a persistent ID, we generate a daily hash from non-PII fields:

```
SHA-256(UTC_date + page_path + country + browser_family + screen_width)
```

Each of these fields individually is not personal data. Combined, they produce a distinct daily fingerprint that:

1. **Expires at UTC midnight.** The hash changes every day — visitors can't be tracked across sessions.
2. **Is one-way.** The hash can't be reversed to recover the individual fields.
3. **Is never used as an identifier.** We write the hash to D1, then count `COUNT(DISTINCT visitor_hash)` per time window.

Counting unique visitors:

```sql
SELECT COUNT(DISTINCT visitor_hash) AS unique_visitors
FROM pageviews
WHERE site_id = ?
  AND timestamp >= ?
  AND timestamp < ?
```

**Accuracy trade-offs.** This approach undercounts people who use multiple devices (no cross-device linking) and slightly overcounts if the same person visits multiple paths in a day (different paths = different hashes). For aggregate traffic metrics, these are acceptable approximations.

The Web Crypto API makes this straightforward in Workers:

```ts
const raw = `${today}:${path}:${country ?? ''}:${browser}:${screenWidth ?? ''}`
const hashBuffer = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(raw))
const visitorHash = Array.from(new Uint8Array(hashBuffer))
  .map(b => b.toString(16).padStart(2, '0'))
  .join('')
```

No npm crypto packages. `crypto.subtle` is available natively in the Workers runtime.

---

## D1: SQLite at the Edge

D1 is Cloudflare's managed SQLite service. D1 uses standard SQLite syntax:
- TEXT for dates (ISO 8601 strings)
- No native UUID type — we use TEXT with `crypto.randomUUID()` values
- `AUTOINCREMENT` for integer primary keys

**The performance story.** D1 is single-region under the hood, but global read replicas make dashboard queries fast from anywhere. Writes go to the primary region, which adds latency for distant visitors — but the `collect` endpoint returns immediately without waiting on the D1 write, so this is transparent to users.

**Write throughput ceiling.** D1 documents ~1,000 writes/second per database. For small-to-medium sites, this is fine. At higher rates, buffering writes via Cloudflare Queues before committing to D1 is the right approach.

---

## Custom Events and Goal Tracking

Custom events extend the same `collect` endpoint:

```js
window.beam.track('signup_complete', { plan: 'pro' })
```

They're stored with a `properties` TEXT column (JSON). Property breakdowns use SQLite's `json_each`:

```sql
SELECT
  json_each.value AS property_value,
  COUNT(*) AS count
FROM custom_events, json_each(custom_events.properties, '$.plan')
WHERE event_name = 'signup_complete'
  AND site_id = ?
GROUP BY property_value
ORDER BY count DESC
```

Goals support both URL path patterns and event name matching (e.g., `event:signup_complete`). Conversion rate is the goal matches divided by total unique visitors for the same time window.

---

## Deployment

The entire backend deploys with one command:

```bash
cd beam && npx wrangler deploy
```

D1 migrations:

```bash
npx wrangler d1 migrations apply beam-db --remote
```

No Docker, no Kubernetes, no load balancer config. Cloudflare handles global distribution, SSL, DDoS mitigation, and auto-scaling.

---

## What I'd Do Differently

**Durable Objects for write buffering.** A Durable Object per site as a write buffer — batching pageviews before committing to D1 — would push the write throughput ceiling significantly higher.

**Open-source the backend.** The tracking script is MIT licensed so the privacy claims are auditable. I'd open the backend once the SaaS is sustainable.

**Pre-aggregated rollups.** Dashboard queries run against raw pageview rows today. Hourly rollups would speed up the slowest queries and reduce D1 read units at scale.

---

## Try It

- **[Launch page (tracked)](https://beam-privacy.com/show-hn?ref=devto-article&utm_source=devto&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=article_launch_cta)** — includes demo, proof points, and onboarding links
- **[Sign up free from launch page](https://beam-privacy.com/show-hn?ref=devto-article&utm_source=devto&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=article_signup_cta)** — 1 site, 50K pageviews/month free tier
- **[Tracking script source](https://github.com/scobb/beam.js)** — MIT licensed

Questions about the architecture, the hashing approach, or D1's write ceiling welcome in the comments.

---

## Dev.to Posting Notes

- **Tags to use:** `cloudflare`, `typescript`, `webdev`, `privacy`
- **Cover image:** Upload a screenshot of the Beam dashboard or architecture diagram
- **Canonical URL:** Set to `https://beam-privacy.com/blog/edge-analytics-architecture` so Google treats beam-privacy.com as the primary source
- **Post after:** Show HN submission (so HN post and Dev.to can cross-promote)
- **Engagement tip:** End comments should ask a direct technical question ("Have you hit D1's write limit? How did you work around it?") to prompt replies
