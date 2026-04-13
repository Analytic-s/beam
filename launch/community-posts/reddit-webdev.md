# r/webdev Launch Post

## Platform
- Reddit: r/webdev
- Submission URL: https://www.reddit.com/r/webdev/submit

## Suggested Title
Beam: cookie-free web analytics on Cloudflare Workers (sub-2KB script)

## Post Body (ready to paste)
I built Beam, a privacy-first analytics tool for people who want simple traffic and conversion visibility without adding cookies or consent-banner complexity.

**Timely context:** beamanalytics.io announced it's shutting down September 1, 2026. If you or your team uses it, we built a migration guide with CSV import support: https://beam-privacy.com/migrate/beam-analytics

What makes it different technically:
- Tracking script is tiny (sub-2KB target, currently ~543B gzipped)
- No cookies, no localStorage, no fingerprinting
- Runs on Cloudflare Workers + D1 + KV
- Custom events, goals, API access, and plain-English weekly insights

I also put up a live interactive demo so you can click around before signing up:
https://beam-privacy.com/show-hn?ref=reddit-webdev&utm_source=reddit&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=webdev_post

Open-source tracking script repo:
https://github.com/scobb/beam.js

I'd love feedback from web devs on two things:
1) Is the integration/docs clear enough for Next.js/WordPress/Astro/Remix users?
2) What's the biggest missing feature that blocks you from trying this on a real project?

## Posting Tips
- Keep the first comment ready with this tracked URL plus the GitHub repo.
- Expect immediate questions about Plausible/Umami differences; answer with trade-offs, not hype.
- Best time: weekday morning US time.
