# r/privacy Launch Post

## Platform
- Reddit: r/privacy
- Submission URL: https://www.reddit.com/r/privacy/submit

## Suggested Title
I built a cookie-free analytics tool that avoids persistent identifiers  -  feedback welcome

## Post Body (ready to paste)
I'm sharing a project I built called Beam: a web analytics product designed to avoid personal data collection patterns common in traditional analytics.

**Relevant context:** beamanalytics.io, another privacy-focused analytics service, announced it will shut down on September 1, 2026. If anyone here was using it, we built a migration guide: https://beam-privacy.com/migrate/beam-analytics — it includes a CSV import flow for historical data.

Core privacy choices:
- No cookies
- No localStorage identifiers
- No cross-session user IDs
- No IP addresses stored in application database
- Aggregate reporting (traffic sources, pages, countries, devices, events)

Instead of persistent identity tracking, unique visitors are approximated from non-PII request context in short windows to keep reporting useful while minimizing user-level traceability.

Live demo:
https://beam-privacy.com/show-hn?ref=reddit-privacy&utm_source=reddit&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=privacy_post

Product site:
https://beam-privacy.com/show-hn?ref=reddit-privacy&utm_source=reddit&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=privacy_link

If you're privacy-focused, I'd especially value critique on:
- Any edge cases where the current model still feels too invasive
- Better ways to explain limitations/trade-offs transparently to site owners

## Posting Tips
- Lead with architecture choices, not pricing.
- Be explicit about limitations and that legal interpretation can vary.
- If asked about compliance guarantees, avoid legal claims and stick to technical behavior.
