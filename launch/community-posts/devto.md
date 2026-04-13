# Dev.to Launch Article

## Platform
- Dev.to
- Submission URL: https://dev.to/new

## Suggested Title
How I built cookie-free analytics on Cloudflare Workers (with a tiny tracking script)

## Post Body (ready to paste)
I just shipped Beam, a privacy-first analytics app built on Cloudflare's edge stack, and wanted to share the implementation approach.

## Why I built it
Most analytics setups are either overkill for small projects or push teams into cookie/consent complexity they don't want.

Goal: useful analytics with minimal tracking surface area.

## Architecture
- Cloudflare Workers (API + server-rendered pages)
- D1 (event + pageview storage)
- KV (rate limits, cache, one-time secret reveal)
- Stripe (subscription billing)
- Resend (digest + alert emails)

## Tracking model
- No cookies
- No localStorage IDs
- Beacon/fetch delivery from a lightweight client script
- Aggregated reporting: pages, sources, countries, devices, events, goal conversion

## Product links
- Launch page (tracked): https://beam-privacy.com/show-hn?ref=devto&utm_source=devto&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=article_post
- Live demo from launch page: https://beam-privacy.com/show-hn?ref=devto&utm_source=devto&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=demo_link
- Tracking script repo: https://github.com/scobb/beam.js
- API docs from launch page: https://beam-privacy.com/show-hn?ref=devto&utm_source=devto&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=docs_link

## What I'd change next
1. Improve distribution loops (community + SEO + integrations)
2. Expand framework-specific docs and examples
3. Tighten onboarding to first-value under 5 minutes

If you've built on Workers + D1, I'd love your feedback on trade-offs and scaling boundaries.

## Posting Tips
- Add tags: `webdev`, `cloudflare`, `typescript`, `saas`, `privacy`.
- Include one architecture diagram or screenshot near the top.
- End with explicit questions to prompt technical comments.
