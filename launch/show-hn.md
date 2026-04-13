# Show HN Launch Kit — Beam

Tracked launch URL for this post:
`https://beam-privacy.com/show-hn?ref=show-hn&utm_source=hackernews&utm_medium=community&utm_campaign=hn_launch_apr_2026&utm_content=post_body`

## Drafted Show HN Post

### Title

```
Show HN: Beam – Cookie-free analytics on Cloudflare Workers, sub-2KB script
```

*Alternative titles (choose based on what's trending that day):*
- `Show HN: Beam – Privacy-first analytics built entirely on the Cloudflare edge`
- `Show HN: I built an analytics tool with no cookies, no GDPR banners, $5/mo`
- `Show HN: Beam – privacy-first analytics (beamanalytics.io is shutting down Sep 2026)`

---

### Body

```
I built Beam, a privacy-first analytics platform that runs entirely on the
Cloudflare Workers edge. Here's the technical story.

**Context: beamanalytics.io is shutting down**

If you're a beamanalytics.io user: the service announced it will shut down on
September 1, 2026. Beam isn't affiliated, but we built a migration guide and
CSV import flow if you're looking for a drop-in privacy-first replacement:
https://beam-privacy.com/migrate/beam-analytics

**The tracking problem**

Most analytics tools use cookies or fingerprinting to track unique visitors.
Both require consent banners under GDPR/CCPA and store personal data. I wanted
something that required neither.

**The approach: daily field hashing**

Instead of cookies, Beam generates a daily hash from non-PII fields:
  SHA-256(date + path + country + browser + screen_width)

The hash changes every UTC day, so visitors can't be tracked across sessions.
The fields individually aren't personal data, and combined they're only retained
as a one-way hash. No cookies, no fingerprint stored, no consent banner required.

**The stack**

- Cloudflare Workers for compute (edge-distributed, ~0ms cold start)
- D1 (SQLite at the edge) for pageview and event storage
- KV for session caching and badge counters
- Tracking script: 543 bytes gzipped (under the sub-2KB target)
- No npm dependencies in the tracking script

**What it does**

- Pageview analytics: visitors, bounce rate, pages, referrers, countries, browsers
- Custom event tracking via beam('event', 'name', { properties })
- Public shareable dashboards (live demo below)
- Stripe-billed subscriptions ($5/mo Pro, free tier included)
- Badge embeds showing live visitor counts

**Launch page (tracked for attribution)**

Use this exact link in the post/comments so signups keep source attribution:
https://beam-privacy.com/show-hn?ref=show-hn&utm_source=hackernews&utm_medium=community&utm_campaign=hn_launch_apr_2026&utm_content=post_body

**Code**

Tracking script (the part that runs on your site):
https://github.com/scobb/beam.js

The SaaS backend is not yet open-source, but the tracking script and its
protocol are documented in the repo.

**Pricing**

- Free: 1 site, 50K pageviews/month
- Pro: $5/month, unlimited sites, 500K pageviews/month

Comparable tools charge $9-19/month for the same tier.

Happy to answer questions about the edge architecture, the hashing approach,
or why I chose D1 over something like PlanetScale or Turso.
```

---

## Optimal Posting Time

**Best windows (all times EST):**

| Day       | Time window    | Notes                                              |
|-----------|----------------|----------------------------------------------------|
| Tuesday   | 8:00–9:30 AM   | Best overall: high traffic, US morning front-page  |
| Wednesday | 8:00–9:30 AM   | Second best; avoid if big tech news cycle          |
| Thursday  | 8:00–10:00 AM  | Good fallback; Friday drop-off starts Thu evening  |

**Avoid:**
- Monday (weekend hangover, lower engagement)
- Friday (traffic drops after noon EST)
- Any day with major tech news (OpenAI/Google announcements, etc.)
- US holidays and the week between Christmas–New Year

**Why 8–10 AM EST?**
HN's front page is dominated by the US West Coast (11 PM–7 AM PST is dead).
Posts that hit front page during 8–11 AM EST have the most hours of US prime
time ahead of them before they age off.

---

## Pre-Launch Checklist

### Technical (do the day before)

- [ ] `curl -s -o /dev/null -w "%{http_code}" https://beam-privacy.com/` returns 200
- [ ] Tracking script loads: `https://beam-privacy.com/js/beam.js` returns 200
- [ ] Public dashboard loads and shows real data: `https://beam-privacy.com/public/dfa32f6b-0775-43df-a2c4-eb23787e5f03`
- [ ] Signup flow works end-to-end (create account, verify site is created, tracking works)
- [ ] Checkout flow works (Stripe test mode → Pro upgrade → dashboard shows Pro)
- [ ] Error logs clean: `wrangler tail --env production` shows no 5xx errors at idle
- [ ] beam.js GitHub repo is public and README is clear

### Content

- [ ] Landing page copy is sharp and loads fast (run Lighthouse, aim for >90)
- [ ] The HN post body is finalized (see above — tailor for what's trending)
- [ ] GitHub repo README links to the live product
- [ ] `/about` page explains the hashing approach clearly (technical audience)

### Monitoring

- [ ] Open Cloudflare dashboard → Workers & Pages → Beam → Metrics tab
- [ ] Open the public Beam dashboard (your own dogfood) in a second tab
- [ ] Have wrangler tail ready: `cd beam && npx wrangler tail`

---

## Launch-Day Checklist

### T-30 minutes

- [ ] Final smoke test: load landing, sign up with a fresh email, add a site, verify the script tag appears, watch the public dashboard register a pageview
- [ ] Close unnecessary tabs; open: HN, Cloudflare dashboard, public Beam dashboard, wrangler tail terminal

### Post submission

- [ ] Submit the Show HN post — copy from the drafted body above
- [ ] Bookmark the submission URL immediately
- [ ] Keep the tracked URL exactly as written (do not drop `ref`/`utm_*`)
- [ ] Do NOT upvote your own post (HN penalizes this)
- [ ] Do NOT ask friends to upvote (HN call it vote manipulation)
- [ ] Share the HN link to Twitter/X and any Slack/Discord communities — only the link, no "please upvote"

### While the post is live

- [ ] Reply to every comment within the first 2 hours — velocity matters for HN ranking
- [ ] Prioritize technical questions over compliments
- [ ] Be honest about limitations (single-region D1, not open-source backend yet, etc.)
- [ ] Monitor error rate in wrangler tail — spike traffic can expose edge cases
- [ ] Watch the Stripe dashboard for signups
- [ ] Watch `/dashboard/acquisition` for source/campaign signup lift

---

## Prepared Responses for Likely HN Comments

### "Why not just self-host Plausible / Umami / Matomo?"

> Fair question — self-hosting is a great option if you have a VPS you're already
> paying for. Beam is for people who want **zero infrastructure**. It runs on
> Cloudflare's free tier (up to 100K requests/day for Workers), so there's nothing
> to manage, patch, or scale. The trade-off is you're trusting my SaaS instead of
> running your own box, which is a legitimate concern.

### "How is this different from Plausible?"

> Plausible is excellent and I respect what they've built. The main differences:
> 1. **Architecture**: Beam runs on the Cloudflare edge (Workers + D1), not a
>    dedicated server. Latency from your visitors' nearest Cloudflare PoP is near-zero.
> 2. **Script size**: Beam's script is ~543B gzipped; Plausible's is ~1KB.
> 3. **Price**: $5/mo vs Plausible's $9/mo entry tier.
> 4. **Open source**: Plausible is fully open-source; Beam's SaaS backend isn't yet
>    (tracking script is open-source).
>
> If you're already happy with Plausible, there's no strong reason to switch.

### "What about Umami?"

> Umami is open-source and self-hostable, which is its main differentiator.
> If you want to run your own analytics with full control of the database,
> Umami is a better fit than Beam. Beam is a managed service — you don't touch
> the infrastructure. Different trade-offs.

### "How do you count unique visitors without cookies?"

> Each pageview request generates a daily hash from:
> `SHA-256(UTC_date + page_path + country + browser_family + screen_width)`
>
> The date component makes the hash expire daily at UTC midnight. The other fields
> are widely available without storing them. A "unique visitor" in Beam is a unique
> hash value per day — not across sessions or days. This means:
>
> - It undercounts people who visit from different devices (no linking across devices)
> - It overcounts people who visit from the same device+browser after UTC midnight
>
> Both are acceptable approximations for aggregate traffic metrics without requiring
> consent. The hash is never persisted — only the count of distinct hashes per time window.

### "Is this GDPR-compliant?"

> Beam doesn't set cookies, doesn't use localStorage, doesn't send IP addresses
> to its database, and doesn't generate persistent identifiers. The daily hash is
> derived from non-PII fields and is one-way (no reversal possible). Under GDPR,
> analytics that don't process personal data don't require consent.
>
> That said, I'm an engineer, not a lawyer. For high-stakes compliance decisions,
> get legal advice. The architecture is designed to avoid personal data, but your
> DPA's interpretation may vary.

### "How does Cloudflare D1 perform under load?"

> D1 is SQLite at the edge — it's not designed for high write throughput (the
> limit is ~1000 writes/second per database). For the traffic levels a typical
> small-to-medium site sees, it's fine. At scale, you'd want to batch writes
> (we buffer via a queue or use Durable Objects). I haven't hit this limit yet.
> It's a legitimate concern and something I'd address before this is enterprise-grade.

### "Why not open-source the backend?"

> Honest answer: I want to see if the SaaS is viable before open-sourcing it.
> Open-sourcing means competing with self-hosted deployments of my own product.
> The tracking script is open-source so the privacy claims are verifiable. If the
> SaaS doesn't gain traction, I'll open-source everything.

### "Your pricing is too cheap / how do you make money?"

> Cloudflare Workers is extremely cheap at these scales. $5/month gives me
> healthy margins at 500K pageviews/mo on the free/Pro plan. If I get to
> enterprise scale, pricing scales too. The goal is to be affordable for indie
> developers and small projects.

### "I can build this in a weekend"

> You probably can! The core is not complex. I'd encourage you to do it —
> privacy-respecting analytics is a solved problem architecturally. The hard
> part is operations, support, billing, and staying running. This is my attempt
> to solve that so others don't have to.

---

## Additional Notes

- **Don't delete and resubmit** if the post doesn't gain traction immediately. Let it run its natural course. Resubmitting is a bannable offense.
- **Respond to critical comments with specifics**, not defensiveness. HN rewards intellectual honesty.
- **If you get flagged**, post in `hn.algolia.com` to ask for context; don't publicly argue about flagging.
- **Front page ≠ success**. Even a 20-upvote Show HN can bring hundreds of signups if the product resonates with that niche audience.
