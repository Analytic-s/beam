# Privacy Design — Cookie-Free Tracking Architecture

> **Keywords:** cookie-free tracking privacy, cookieless analytics how it works, GDPR analytics no consent, privacy-first tracking design

Beam collects meaningful analytics without cookies, fingerprinting, or personal data storage. This page explains exactly how.

## The Core Problem with Cookie-Based Analytics

Traditional analytics (Google Analytics, Mixpanel, etc.) set cookies to track users across sessions and devices. This creates two problems:

1. **Legal requirement** — GDPR, CCPA, and ePrivacy Directive require explicit consent before setting tracking cookies in the EU and California.
2. **Accuracy loss** — consent banners result in 20-40% opt-out rates, making data unreliable.

Beam solves both by not using cookies at all.

## How Beam Identifies Unique Visitors Without Cookies

Beam uses a **daily session hash** instead of persistent identifiers:

```
hash = SHA-256(date + path + country + browser + screen_width)
```

This hash is:
- Computed fresh each day — cannot track users across days
- Derived from non-PII fields only — no IP, no email, no user agent string
- Never stored anywhere — only the count is recorded

The result: Beam can count unique visitors per day without storing any data that would require consent.

## What Beam Collects

| Data Point | Stored? | Why |
|-----------|---------|-----|
| Page URL | Yes | Core analytics — which pages are popular |
| Referrer URL | Yes, normalized | Traffic source attribution |
| Country code | Yes | Geographic breakdown (derived from IP, IP discarded) |
| Browser type | Yes, bucketed | Browser breakdown (Chrome/Firefox/Safari/Other) |
| Screen width | Yes, bucketed | Desktop/mobile/tablet breakdown |
| IP address | **No** | Discarded immediately after country lookup |
| User ID | **No** | No login required, no cross-session tracking |
| Personal data | **No** | Nothing that identifies a natural person |

## What Beam Does NOT Do

- No cookie setting — not first-party, not third-party
- No fingerprinting — no canvas, WebGL, font, or audio fingerprinting
- No cross-site tracking — data stays scoped to your domain
- No selling data — your analytics data is only yours
- No IP storage — country is derived then IP is discarded

## GDPR Compliance

Because Beam collects no personal data, it falls outside GDPR's scope for most use cases. Specifically:

- **No consent banner required** for the tracking script itself
- **No data subject rights** apply (no personal data = nothing to delete or export)
- **No DPA required** between you and Beam for core analytics

You should still mention Beam in your privacy policy for transparency — see [beam-privacy.com/privacy](https://beam-privacy.com/privacy) for sample privacy policy language.

## Infrastructure Privacy

Beam is built on Cloudflare's global edge network:

- Analytics events are processed at the edge closest to the visitor
- Data is stored in Cloudflare D1 (SQLite-compatible, US-based)
- No third-party analytics services are involved
- The Beam dashboard is served from [beam-privacy.com](https://beam-privacy.com)

## Open Source Transparency

The tracking script (`beam.js`) is fully open source under the MIT license. You can audit exactly what data is sent:

- [View beam.js source](https://github.com/scobb/beam.js/blob/main/beam.js)
- The script sends a `POST` request to `/api/collect` with the fields described above
- No obfuscation, no minification surprises, no phone-home behavior beyond the analytics endpoint

## Questions?

- [Live Demo](https://beam-privacy.com/demo) — see the dashboard without signing up
- [Sign Up Free](https://beam-privacy.com/signup) — start collecting privacy-respecting analytics
- [Open a Discussion](https://github.com/scobb/beam.js/discussions) — ask the community
