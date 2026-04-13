# Beam — 30-Minute Launch Playbook

Open this file. Follow each step in order. Do not improvise.
Total time: ~35 minutes.

---

## Before You Start

Confirm you have accounts on all these platforms before step 0.

- [ ] Uneed.best account at uneed.best (free sign-up, do this first — highest-intent migration traffic)
- [ ] Hacker News account at news.ycombinator.com (must be aged ≥ 1 week for "Show HN")
- [ ] Reddit account at reddit.com (must be aged ≥ a few days for r/webdev)
- [ ] npm account at npmjs.com with 2FA configured
- [ ] SaaSHub account at saashub.com (free sign-up takes 2 min if not already registered)
- [ ] AlternativeTo account at alternativeto.net (free sign-up, can do inline)

---

## Step 0 — Submit to Uneed.best (~5 min) ← DO THIS FIRST

**Why this is first:** Uneed.best has a live page — **uneed.best/alternatives/beam_analytics** —
listing 10 "Beam Analytics alternatives." beam-privacy.com is NOT on that list. beamanalytics.io
users searching for a replacement will land there. This is the highest-leverage 5-minute action
available: qualified migration intent, zero effort, no time-sensitive ranking like HN.

**Open this URL:**
```
https://www.uneed.best/submit-a-tool
```

**Fill in these exact values** (full details in `launch/uneed-submission.md`):

| Field | Value |
|-------|-------|
| Tool name | Beam |
| URL | https://beam-privacy.com?ref=uneed&utm_source=uneed&utm_medium=directory&utm_campaign=beam_analytics_migration |
| Tagline | Privacy-first web analytics — no cookies, no consent banners |
| Category | Analytics |
| Pricing model | Freemium |
| Alternatives to | Google Analytics, Plausible Analytics, Fathom Analytics, Beam Analytics (beamanalytics.io) |

**Full description to paste:**
```
Beam is a lightweight, privacy-first analytics platform built on Cloudflare Workers. It tracks
pageviews, referrers, countries, devices, and custom events without cookies or fingerprinting —
GDPR-compliant by design. If you're migrating from Beam Analytics (beamanalytics.io, shutting down
September 1, 2026), Beam has a migration guide and CSV import tool at
beam-privacy.com/migrate/beam-analytics. Free tier: 1 site, 50,000 pageviews/month. Pro: $5/month,
unlimited sites, 500,000 pageviews/month.
```

**Click "Submit".**

- [ ] Step 0 done. Check your email for Uneed.best confirmation: ___________________________

---

## Step 1 — Post "Show HN" to Hacker News (~8 min)

**Time:** Do this first. HN posts rank by velocity in the first 30 min.

**Open this URL:**
```
https://news.ycombinator.com/submit
```

**Paste this exact title:**
```
Show HN: Beam – Cookie-free analytics on Cloudflare Workers, sub-2KB script
```

**Paste this exact body:**
```
I built Beam, a privacy-first analytics platform that runs entirely on the
Cloudflare Workers edge. Here's the technical story.

Context: beamanalytics.io announced it will shut down September 1, 2026. Beam
isn't affiliated, but if you're a beamanalytics.io user looking for a
privacy-first replacement, we built a migration guide + CSV import:
https://beam-privacy.com/migrate/beam-analytics

The tracking problem: Most analytics tools use cookies or fingerprinting to
track unique visitors. Both require consent banners under GDPR/CCPA. I wanted
something that required neither.

The approach: daily field hashing
Instead of cookies, Beam generates a daily hash from non-PII fields:
  SHA-256(date + path + country + browser + screen_width)
The hash changes every UTC day, so visitors can't be tracked across sessions.

The stack:
- Cloudflare Workers for compute (edge-distributed, ~0ms cold start)
- D1 (SQLite at the edge) for pageview and event storage
- KV for session caching and badge counters
- Tracking script: 543 bytes gzipped
- No npm dependencies in the tracking script

What it does:
- Pageview analytics: visitors, bounce rate, pages, referrers, countries, browsers
- Custom event tracking via beam('event', 'name', { properties })
- Public shareable dashboards (live demo below)
- $5/mo Pro, free tier included (1 site, 50K pageviews/month)

Live demo: https://beam-privacy.com/demo
Tracking script (open-source): https://github.com/scobb/beam.js

Landing: https://beam-privacy.com?ref=show-hn&utm_source=hackernews&utm_medium=community&utm_campaign=hn_launch_apr_2026
```

**Click "Submit".**

- [ ] Step 1 done. Bookmark the live post URL: ___________________________

---

## Step 2 — Post to r/webdev (~5 min)

**Open this URL:**
```
https://www.reddit.com/r/webdev/submit
```

**Select:** "Text" post type (not "Link")

**Paste this exact title:**
```
Beam: cookie-free web analytics on Cloudflare Workers (sub-2KB script)
```

**Paste this exact body:**
```
I built Beam, a privacy-first analytics tool for web devs who want simple
traffic visibility without adding cookies or consent-banner complexity.

Timely context: beamanalytics.io is shutting down September 1, 2026. If you
use it, we have a migration guide + CSV import at:
https://beam-privacy.com/migrate/beam-analytics

What makes it different technically:
- Tracking script is ~543B gzipped (sub-2KB)
- No cookies, no localStorage, no fingerprinting
- Runs on Cloudflare Workers + D1 + KV
- Custom events, goals, API access, and plain-English weekly digest emails

Free tier: 1 site, 50K pageviews/month — no credit card.
Pro: $5/month — unlimited sites, 500K pageviews/month.

Live demo (click around before signing up):
https://beam-privacy.com/demo

Landing page:
https://beam-privacy.com?ref=reddit-webdev&utm_source=reddit&utm_medium=community&utm_campaign=launch_apr_2026&utm_content=webdev_post

Open-source tracking script:
https://github.com/scobb/beam.js

I'd love feedback from web devs on two things:
1) Is the integration/docs clear enough for Next.js/WordPress/Astro users?
2) What's the biggest missing feature that blocks you from trying this?
```

**Click "Post".**

- [ ] Step 2 done. Bookmark the live post URL: ___________________________

---

## Step 3 — Submit to SaaSHub (~5 min)

**Open this URL:**
```
https://www.saashub.com/submit
```

**Fill in the form with these exact values:**

| Field | Value |
|-------|-------|
| Product name | Beam |
| URL | https://beam-privacy.com?ref=saashub&utm_source=saashub&utm_medium=directory&utm_campaign=launch_apr_2026 |
| Category | Analytics |
| Short description | Privacy-first web analytics on Cloudflare Workers — no cookies, no consent banners, GDPR-compliant. |
| Long description | Beam is a lightweight analytics platform built on Cloudflare Workers and D1. It tracks pageviews, referrers, countries, and custom events without cookies or fingerprinting. Free tier: 1 site, 50,000 pageviews/month. Pro: $5/month, unlimited sites, 500,000 pageviews/month. GDPR-compliant by design — no consent banner needed. |
| Pricing | Freemium |
| Pricing detail | Free: 1 site / 50K pageviews/mo. Pro: $5/mo, unlimited sites, 500K pageviews/mo. |
| GitHub | https://github.com/scobb/beam.js |

**Click "Submit".**

- [ ] Step 3 done.

---

## Step 4 — Publish beam.js to npm (~5 min)

**Open a terminal and run these exact commands:**

```bash
cd ~/repos/ralph-bootstrap/beam-js
cat package.json | grep '"version"'   # note current version
npm login                              # log in if needed (2FA prompt)
npm publish --access public
```

**Expected output:** `+ @scobb/beam.js@x.x.x` (or whatever the package name is)

**If `npm login` shows you're already logged in:** skip it and just run `npm publish`.

- [ ] Step 4 done. Version published: ___________________________

---

## Step 5 — Submit to AlternativeTo (~5 min)

**Open this URL:**
```
https://alternativeto.net/manage/
```

**Click "Add software" and fill in:**

| Field | Value |
|-------|-------|
| Name | Beam |
| URL | https://beam-privacy.com?ref=alternativeto&utm_source=alternativeto&utm_medium=directory&utm_campaign=launch_apr_2026 |
| Tagline | Privacy-first web analytics — no cookies, no consent banners |
| Description | Beam is a lightweight, cookie-free web analytics platform built on Cloudflare Workers. It tracks pageviews, referrers, countries, devices, and custom events without using cookies or fingerprinting — GDPR-compliant by design. Free tier includes 1 site and 50,000 pageviews/month. Pro plan is $5/month for unlimited sites and 500,000 pageviews/month. |
| License | Commercial |
| Category | Web analytics |
| Alternatives to | Google Analytics, Plausible, Fathom Analytics |

**Click "Save".**

- [ ] Step 5 done.

---

## Step 6 — Post the HN link to your communities (~2 min)

**Share the HN link (from Step 1) in:**

- [ ] Twitter/X: `Just posted on HN: [paste HN link]` — no "please upvote"
- [ ] Any Slack/Discord communities you're in (indie hackers, web devs, privacy, Cloudflare)

**Rules:**
- Share the HN link, not the product link directly
- Do NOT ask anyone to upvote (HN bans for vote manipulation)
- Do NOT ask friends to upvote

---

## You're Done

Total time: ~30 minutes.

**Where to watch results:**

| What | URL |
|------|-----|
| Your own analytics | https://beam-privacy.com/dashboard |
| HN post ranking | https://news.ycombinator.com/newest (search "Beam") |
| Stripe signups | https://dashboard.stripe.com/customers |
| Acquisition breakdown | https://beam-privacy.com/dashboard/acquisition |

**For the next 2 hours:** reply to HN comments. Velocity in the first 2 hours matters most for HN ranking. Technical questions first — don't be defensive, be honest about limitations.
