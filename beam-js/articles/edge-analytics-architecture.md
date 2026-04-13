# Building Privacy-First Web Analytics on Cloudflare Workers and D1

*Originally published on [Beam](https://beam-privacy.com/blog/edge-analytics-architecture)*

---

I recently shipped [Beam](https://beam-privacy.com) — a privacy-first analytics tool that runs entirely on Cloudflare's edge network. This post covers the architecture in detail: how tracking works, how data flows, why D1 made sense for storage, and how we count unique visitors without cookies or fingerprinting.

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

A few design choices worth calling out:

**`sendBeacon` with fallback to `fetch`.**
`sendBeacon` is preferred because it fires-and-forgets — it doesn't block page unload and doesn't require a response. The `fetch` fallback with `keepalive: true` serves the same purpose for browsers that don't support `sendBeacon` (rare, but worth handling).

**DNT respected.**
If `navigator.doNotTrack === '1'`, the script exits immediately. No data is sent.

**No IP address in the payload.**
The client never sends its IP to the `collect` endpoint. The Workers runtime sees the IP on inbound requests, but we deliberately don't write it to D1. The country is derived server-side from Cloudflare's `cf.country` header, which is based on IP geolocation but returns only the country code — not the IP itself.

**UTM parameters captured.**
`utm_source`, `utm_medium`, and `utm_campaign` are pulled from the query string and sent with the pageview. This powers traffic channel attribution in the dashboard.

---

## The Collection Endpoint: Workers

The `/api/collect` endpoint runs as a Cloudflare Worker written with [Hono](https://hono.dev/) — a lightweight TypeScript-native framework well-suited to Workers:

```ts
// Simplified — production version includes validation, rate limiting, and bot detection
app.post('/api/collect', async (c) => {
  const body = await c.req.json()
  const cf = c.req.raw.cf  // Cloudflare context

  const country = cf?.country as string | undefined
  const browser = detectBrowser(c.req.header('user-agent') ?? '')
  const timestamp = new Date().toISOString()

  // Generate daily hash for unique visitor counting (no cookies)
  const today = timestamp.slice(0, 10)  // YYYY-MM-DD
  const raw = `${today}:${body.path}:${country ?? ''}:${browser}:${body.screen_width ?? ''}`
  const hashBuffer = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(raw))
  const visitorHash = Array.from(new Uint8Array(hashBuffer))
    .map(b => b.toString(16).padStart(2, '0'))
    .join('')

  await c.env.DB.prepare(`
    INSERT INTO pageviews (
      site_id, path, referrer, country, browser,
      screen_width, language, timezone,
      utm_source, utm_medium, utm_campaign,
      visitor_hash, timestamp
    ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
  `).bind(
    body.site_id, body.path, body.referrer || null,
    country || null, browser,
    body.screen_width || null, body.language || null, body.timezone || null,
    body.utm_source || null, body.utm_medium || null, body.utm_campaign || null,
    visitorHash, timestamp
  ).run()

  return c.json({ ok: true })
})
```

Workers give us:
- **~0ms cold start** compared to container-based functions (which can be 100–500ms).
- **Global distribution** — the request is handled at the Cloudflare PoP nearest to the visitor. A user in Singapore hits a Singapore edge node, not a US origin server.
- **Web Crypto API** — `crypto.subtle.digest` is available natively in the Workers runtime. No npm crypto dependencies needed.

---

## Unique Visitor Counting Without Cookies

This is the core privacy mechanism. Instead of assigning each visitor a persistent ID (cookie or localStorage key), we generate a daily hash from non-PII fields:

```
SHA-256(UTC_date + page_path + country + browser_family + screen_width)
```

Each of these fields individually is not personal data. Combined, they produce a reasonably distinct daily fingerprint that:

1. **Expires at UTC midnight.** The hash changes every day, so a visitor can't be tracked across sessions.
2. **Is one-way.** You can't reverse the hash to recover the individual fields.
3. **Is never stored as an identifier.** We write the hash to D1, then count `COUNT(DISTINCT visitor_hash)` per time window. The hash is the value, not a key we look up.

Counting unique visitors then becomes:

```sql
SELECT COUNT(DISTINCT visitor_hash) AS unique_visitors
FROM pageviews
WHERE site_id = ?
  AND timestamp >= ?
  AND timestamp < ?
```

**Accuracy trade-offs.** This approach undercounts people who use multiple devices (no cross-device linking) and slightly overcounts if the same person visits multiple paths in a day (different paths = different hashes). For aggregate traffic metrics, these are acceptable approximations. We don't claim "unique user" — we say "unique visitor estimate."

---

## D1: SQLite at the Edge

D1 is Cloudflare's managed SQLite service, designed to run alongside Workers. For Beam, D1 handles:

- `pageviews` — every tracked pageview and custom event
- `users` — accounts and hashed password credentials
- `sites` — registered properties
- `goals` — user-defined conversion patterns
- `api_keys` — hashed API credentials for the REST API

D1 uses standard SQLite syntax, which means:
- TEXT for dates (ISO 8601 strings like `2026-04-01T09:00:00.000Z`)
- No native UUID type — we use TEXT with `crypto.randomUUID()` values
- `AUTOINCREMENT` for integer primary keys, `TEXT PRIMARY KEY` for UUIDs

**The performance story.** D1 is single-region under the hood (you pick a location hint, and Cloudflare replicates reads globally). For read-heavy dashboards, this works well — the globally distributed read replicas mean dashboard queries are fast from anywhere. For writes (pageview ingestion), the write goes to the primary region, which adds latency for visitors physically far from your D1 region. In practice, this is invisible to the end user because the `collect` endpoint returns immediately — we don't wait on the D1 write to respond.

**Write throughput ceiling.** D1's documented limit is around 1,000 writes/second per database. For small-to-medium sites, this is fine. At high pageview rates, you'd want to buffer writes via Cloudflare Queues or Durable Objects before committing to D1. Beam hasn't hit this ceiling yet.

---

## KV: Ephemeral State

Cloudflare KV handles everything that doesn't need to be queryable:

- **Rate limiting.** Each `site_id` gets a per-minute write counter in KV. If an IP exceeds the threshold, `collect` returns 429 and skips the D1 write.
- **Public dashboard badge counts.** Badges served as SVGs to third-party pages cache the visitor count in KV with a 1-hour TTL rather than running a D1 aggregation on every badge request.
- **One-time API key reveal.** When a user generates an API key, the raw key is stored in a short-lived KV entry. The dashboard reads and deletes it on the first request — a read-once reveal pattern. D1 only stores the hashed version.
- **Scanner report cache.** The site scanner tool fetches and analyzes URLs; results are cached in KV for a short TTL to avoid hammering third-party sites.

KV is eventually consistent — writes may take up to 60 seconds to propagate globally. For rate limiting and badge counts, this is acceptable. For anything that requires strong consistency (billing state, subscription status), we read from D1 or Stripe directly.

---

## The Dashboard

The dashboard is server-rendered HTML from Workers — no client-side framework. Pages are built with Hono's JSX support and styled with Tailwind via CDN. This keeps the deployment simple: no build step, no bundler, just `wrangler deploy`.

Most dashboard queries look like this:

```sql
SELECT
  path,
  COUNT(*) AS pageviews,
  COUNT(DISTINCT visitor_hash) AS unique_visitors
FROM pageviews
WHERE site_id = ?
  AND timestamp >= ?
  AND timestamp < ?
GROUP BY path
ORDER BY pageviews DESC
LIMIT 20
```

D1's SQLite engine handles these aggregations efficiently for the data volumes involved (tens of thousands to a few hundred thousand rows per site per month).

---

## Custom Events

Custom events use the same `collect` endpoint with a `type: 'event'` field:

```js
window.beam.track('signup_complete', { plan: 'pro' })
```

They're stored in a separate `custom_events` table with a `properties` TEXT column (JSON). Property breakdowns use SQLite's `json_each`:

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

Goal conversion tracking works by matching pageview paths or event names against user-defined goal patterns, then computing a conversion rate against the total visitor count for the same window.

---

## Deployment

The entire backend deploys with:

```bash
cd beam && npx wrangler deploy
```

Wrangler handles bundling, uploading, and route assignment. D1 migrations run with:

```bash
npx wrangler d1 migrations apply beam-db --remote
```

No Docker, no Kubernetes, no load balancer config. The Cloudflare network handles global distribution, SSL termination, DDoS mitigation, and auto-scaling automatically.

---

## What I'd Do Differently

**Durable Objects for write buffering.** At high write rates, D1's single-region primary becomes the bottleneck. A Durable Object per site as a write buffer — batching pageviews before committing to D1 — would push the ceiling significantly higher.

**Open-source the backend.** The tracking script (`beam.js`) is open-source so the privacy claims are auditable. The SaaS backend isn't yet. I'd like to open it if the SaaS reaches sustainable revenue.

**More aggressive caching.** Right now, dashboard queries run against D1 on every page load. Pre-aggregating hourly rollups into a separate table would speed up the slowest queries and reduce D1 read units.

---

## Try It

If you want to see the product:

- **[Live demo](https://beam-privacy.com/demo)** — seeded sample data, no signup required
- **[Sign up free](https://beam-privacy.com/signup)** — 1 site, 50K pageviews/month on the free tier
- **[Tracking script source](https://github.com/scobb/beam.js)** — the client-side code is MIT licensed

Questions about the architecture, the hashing approach, or D1's limitations at scale are welcome. I'm still in early stages and interested in feedback from people who've run production workloads on Cloudflare's stack.
