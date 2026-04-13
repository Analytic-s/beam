# Domain Strategy Brief — April 5, 2026

Answering Steve's three questions from progress.txt (2026-04-05).

---

## Q1: Why is beamanalytics.io shutting down? Is there an opportunity?

### Confirmed Facts

- **Homepage banner**: "Unfortunately, Beam is going to be closing down. We will continue running for the next 6 months to help users migrate. Official shutdown date: September 1, 2026."
- **Founders**: JR (TheBuilderJR) and Leng Lee. Launched January 2023, started building October 2022.
- **Revenue at launch**: $20/month, 100 users (Starter Story interview, February 2023)
- **Startup costs**: $3.5K total. Zero employees — 2-person founder team.
- **Free tier**: 100,000 pageviews/month free. Paid plan: $11/month for overages.
- **Features**: Web analytics, user funnels, custom events, GDPR/CCPA/PECR compliant, cookie-free.
- **Product Hunt**: #4 daily ranking at launch. 3 reviews, all 5/5.
- **HN reception**: Mixed. One comment called it "a copycat of Plausible."
- **No public explanation for shutdown** — no blog post, no founder tweet found explaining why.

### Likely Reasons (Inferred)

1. **Unsustainable economics**: 100K free pageviews/month is the most generous free tier in the space. Most users likely never paid. $11/month paid tier with low conversion = not enough revenue to sustain a 2-person team.
2. **Crowded market**: Plausible ($9/mo, 17K+ paying customers), Fathom ($15/mo), Umami (35K+ GitHub stars, free OSS), Rybbit (11K+ stars), Simple Analytics, GoatCounter ($5/mo), Counterscale (free on CF), PostHog, Matomo — at least 10 serious competitors.
3. **Positioning challenges**: "Plausible copycat" perception from HN. Hard to differentiate as a closed-source paid tool when open-source alternatives (Umami, Rybbit) offer more for free.
4. **Two-person team burnout**: Building, marketing, and supporting a SaaS with minimal revenue is exhausting.

### Opportunity Assessment

**YES — there is a real, time-limited opportunity.**

- beamanalytics.io users are **pre-qualified privacy-analytics buyers** who must migrate by September 1, 2026. They've already opted out of Google Analytics.
- **Uneed.best** already has a "Best Beam Analytics Alternatives in 2026" page listing 10 tools. Beam (our product) is NOT listed. This is a direct acquisition surface.
- **No other tool is specifically targeting this migration** — Plausible, Fathom, Umami aren't creating "switch from Beam Analytics" content.
- **Our migration page exists**: beam-privacy.com/migrate/beam-analytics is already live.
- **Potential actions**:
  1. **Steve submits to Uneed.best** (5 minutes, free): Get listed on the alternatives page where beamanalytics.io users are already looking.
  2. **Steve reaches out to founders** (30 minutes): Ask about acquiring domain, user list, or a redirect. Even a blog post from them mentioning beam-privacy.com as an alternative would be valuable.
  3. **SEO play**: beam-privacy.com/migrate/beam-analytics and the blog post are already targeting "beam analytics shutdown" searches. But they won't rank without Google indexing (see below).

**Risk**: beamanalytics.io's user base was likely small (started at $20/mo revenue). The opportunity is real but modest — perhaps dozens to low hundreds of migration-ready users, not thousands.

---

## Q2: Is the name collision still a real risk?

### Two Separate Collisions

**Collision A: beam-privacy.com vs. Beam Privacy cryptocurrency (SEVERE)**

| Signal | Beam Privacy Crypto | beam-privacy.com |
|--------|-------------------|------------------|
| Domain | beamprivacy.com, beam.mw | beam-privacy.com |
| GitHub | github.com/BeamMW (active since 2019) | github.com/scobb/beam.js |
| Medium | medium.com/beam-mw (active) | — |
| Podcast | "Beam Privacy Podcast" on Apple Podcasts | — |
| CoinMarketCap | Listed as BEAM | — |
| Google results for "beam privacy" | Dominates all results | Zero results |

- Searching "beam privacy" returns **exclusively** the cryptocurrency project
- beam-privacy.com literally contains the crypto project's brand identity
- Voice search: "beam privacy dot com" could easily be confused with the crypto project
- **Verdict: SEVERE collision. beam-privacy.com faces a permanent, structural SEO disadvantage on its core brand terms.**

**Collision B: "Beam" vs. beamanalytics.io (TEMPORARY, becoming an opportunity)**

- beamanalytics.io is shutting down September 1, 2026
- After shutdown, their SEO presence will gradually decay over 6-12 months
- By late 2026, "beam analytics" as a search term will have less competition
- Their Product Hunt page, HN discussion, and review sites will persist as historical references but won't be actively maintained
- **Verdict: This collision is resolving itself. After September 2026, using "Beam" in analytics context becomes less confusing, not more.**

### Bottom Line

**beam-privacy.com is NOT fine.** The domain's problem is not beamanalytics.io — it's the Beam Privacy cryptocurrency. This collision is permanent, affects the exact search terms our product needs, and cannot be resolved by waiting.

---

## Q3: Domain Recommendation

### Option A: Keep beam-privacy.com (NOT recommended)

- Pro: Already paid for ($11.56), already deployed, all URLs work
- Con: Permanent SEO collision with Beam Privacy crypto. "beam privacy" searches will never surface our product. Voice search ambiguity. Undermines the brand every time someone tries to find us.
- Recommendation: **Use as operational domain but do not invest in building brand equity here.**

### Option B: Acquire beamanalytics.io (RECOMMENDED if feasible)

- Pro: Inherits their SEO authority, backlinks, Product Hunt page, review site listings, and brand recognition in the privacy analytics space. Their users already know the domain. "Beam Analytics" as a brand becomes available after September 2026.
- Con: Over budget if expensive. HN called them a "Plausible copycat" — some negative association. Requires negotiation with founders.
- Cost estimate: Likely $500-2,000 for the domain alone. Could be less if founders want a clean exit. User list/redirect would be more valuable but harder to negotiate.
- Recommendation: **Steve should reach out to JR/Leng Lee. Even if the domain is too expensive, a blog post from them recommending Beam as an alternative would be valuable. Draft outreach email provided in launch/beamanalytics-outreach.md.**
- Risk: $100 budget is too small. This would require Steve's personal investment or a budget increase.

### Option C: Register a clean brand domain (RECOMMENDED as fallback)

- Pro: No collisions, fresh start, full brand control
- Con: Loses work on beam-privacy.com, another domain migration, zero SEO authority
- Examples (check availability):
  - `getbeamanalytics.com` — leverages the shutting-down brand with a clear differentiator
  - `trybeam.dev` or `usebeam.dev` — short, developer-friendly, but "beam" still has crypto noise
  - Something that avoids "beam" entirely — cleanest but requires full rebrand
- Cost: ~$10-15/year for a .com or .dev
- Recommendation: **Only pursue if Option B fails. A clean domain without "beam" avoids ALL collisions but requires rebranding effort.**

### Option D: Keep beam.keylightdigital.dev as canonical

- Pro: Already working, no cost, no collision
- Con: Subdomain looks less professional, harder to market, doesn't build independent brand equity
- Recommendation: **Not recommended for long-term, but acceptable as interim while deciding.**

### Recommended Path

1. **Immediate** (this week): Steve reaches out to beamanalytics.io founders about domain acquisition.
2. **If acquisition succeeds**: Migrate to beamanalytics.io after their September 1 shutdown. Redirect beam-privacy.com there.
3. **If acquisition fails or is too expensive**: Register a clean domain (Steve's choice on brand direction). Keep beam-privacy.com as redirect.
4. **Regardless**: Stop investing in beam-privacy.com SEO — the crypto collision makes it a dead end for organic search.

---

## Appendix: Competitive Landscape (April 2026)

| Tool | Price | Free Tier | GitHub Stars | Status |
|------|-------|-----------|-------------|--------|
| Plausible | $9/mo | 30-day trial | 22K+ | Market leader |
| Fathom | $15/mo | 30-day trial | — | Established |
| Umami | $9/mo | 100K events | 35K+ | OSS leader |
| Rybbit | $13/mo | — | 11K+ | Fast-growing |
| Simple Analytics | $9/mo | 14-day trial | — | EU-focused |
| GoatCounter | $5/mo | Free for personal | 5K+ | Indie |
| Counterscale | Free (self-host) | Unlimited | 2K+ | CF-native competitor |
| **Beam (ours)** | **$5/mo** | **50K pageviews** | **—** | **0 users** |
| beamanalytics.io | $11/mo | 100K pageviews | — | **Shutting down Sep 1** |

Beam's $5/mo with 50K free pageviews is competitive on price. The product is feature-complete. The ONLY missing ingredient is distribution.
