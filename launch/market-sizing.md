# Beam: Privacy-First Web Analytics — Market Sizing Analysis

*Prepared: April 5, 2026 | Requested by Steve Cobb*

---

## 1. TAM — Total Addressable Market

**Privacy-preserving analytics market**: $2.14B in 2026, projected to reach $4.11B by 2030 (17.7% CAGR).

**Broader web analytics market**: $7.36B in 2026, projected to reach $25.7B by 2034 (16.93% CAGR).

These are the broadest possible envelopes, including enterprise, self-hosted, embedded analytics, and CDP-adjacent tools. Beam operates in a tiny sliver of this.

---

## 2. SAM — Serviceable Available Market

The realistic addressable market is **privacy-first SaaS web analytics for SMBs, indie makers, and content sites**. This excludes enterprise tools (PostHog, Mixpanel, Amplitude), self-hosted-only tools (Matomo self-hosted), and general-purpose analytics platforms.

### Known Competitor Revenue/Scale

| Competitor | Pricing | Subscribers/Orgs | Est. ARR | Notes |
|---|---|---|---|---|
| **Plausible** | $9/mo+ | 17,000+ paying | ~$4M+ | Category leader. Profitable. No investors. |
| **Fathom** | $15/mo+ | ~15,000 companies | ~$3-4M est. | Established brand. 2-person team. |
| **Simple Analytics** | $9/mo+ ($19 monthly) | Undisclosed | <$1M est. | EU-focused. Smaller. |
| **Umami** | Free OSS / $9/mo cloud | 35.8K GitHub stars | Minimal cloud revenue | Primarily self-hosted. VC-backed. |
| **Rybbit** | $13/mo+ | 4,000+ orgs | <$500K est. | Launched 2025. 11K+ GitHub stars. Fastest-growing. |
| **GoatCounter** | Donation-supported | Unknown | Negligible | Solo developer. Minimalist. |
| **Counterscale** | Free (MIT, CF-native) | Unknown | $0 | Open source on Cloudflare. Direct architectural competitor. |
| **Swetrix** | $19/mo+ | Unknown | <$500K est. | A/B testing, error tracking. |

**Total SAM estimate**: ~$10-15M ARR currently across all privacy-first analytics SaaS providers. Growing 25-30% annually as GDPR enforcement and cookie deprecation drive migration from Google Analytics.

### Key Insight
This is a **small market** dominated by 2 players (Plausible + Fathom account for ~70%+ of revenue). It's growing, but the ceiling for any individual new entrant is modest.

---

## 3. SOM — Serviceable Obtainable Market

### At Beam's $5/mo price point:

| Pro Users | MRR | ARR | What it means |
|---|---|---|---|
| 50 | $250 | $3,000 | Covers infrastructure. Hobby project. |
| 200 | $1,000 | $12,000 | Modest income supplement. |
| 500 | $2,500 | $30,000 | Meaningful side business. |
| 2,000 | $10,000 | $120,000 | Serious full-time business. |
| 5,000 | $25,000 | $300,000 | Strong indie SaaS. |

### Realistic 12-month projections (from today):

**Scenario A — Strong human distribution** (Steve posts Show HN, gets front page, submits to 10+ directories, does consistent weekly content marketing):
- 6-month: 50-100 Pro users, $250-500/mo
- 12-month: 150-300 Pro users, $750-1,500/mo
- Probability: 15% (requires sustained human effort)

**Scenario B — Moderate human distribution** (Steve does Show HN + 3-4 directory submissions, then occasional maintenance):
- 6-month: 10-30 Pro users, $50-150/mo
- 12-month: 30-80 Pro users, $150-400/mo
- Probability: 30% (requires initial effort, then organic takes over)

**Scenario C — Current trajectory** (zero human distribution, agent-only):
- 6-month: 0-5 Pro users, $0-25/mo
- 12-month: 0-10 Pro users, $0-50/mo
- Probability: 55% (this is what has been happening)

### Reference benchmark
- **Plausible** took ~2 years to reach $1M ARR with 2 full-time founders doing constant distribution, blogging, Hacker News, Reddit, and community engagement.
- **beamanalytics.io** launched Jan 2023 with similar positioning (privacy, generous free tier, low price). Revenue at launch: $20/month. Now shutting down Sep 1, 2026. 2-person team.
- **Rybbit** reached 11K GitHub stars in months by going open-source and heavily engaging developer communities. Different model (self-hosted + cloud).

---

## 4. Competitive Landscape Assessment

### Beam's Advantages
- **Lowest price**: $5/mo vs $9-15/mo for Plausible/Fathom/Simple Analytics
- **Most generous free tier**: 50K pageviews/mo vs 0 (Plausible), 0 (Fathom), 100K (beamanalytics.io)
- **Zero infrastructure cost**: Cloudflare free tier means near-100% margins
- **Feature-competitive**: Goals, custom events, channels, insights, anomaly alerts, API, migration tools

### Beam's Disadvantages
- **Zero distribution**: 0 users, 0 indexed pages, 0 backlinks, 0 community presence
- **No human operator**: The single most important differentiator in this market is consistent human community engagement. Plausible and Fathom were built on years of blog posts, HN threads, Reddit engagement, and conference talks.
- **Brand confusion**: "beam privacy" returns cryptocurrency results. beam-privacy.com collides with Beam Privacy (Web3).
- **Late entrant**: The market already has 10+ competitors, several well-established
- **No social proof**: Zero users, zero testimonials, zero reviews, zero stars

### Honest Assessment
**Beam is a good product in a bad position.** The features and pricing are competitive. The distribution is nonexistent. In a market where distribution is the primary differentiator, Beam's greatest weakness is its only weakness — but it's fatal without human intervention.

---

## 5. Is Beam Worth Ongoing Investment?

### The math
- At current trajectory (0 human distribution): **No.** The expected 12-month revenue is $0-50.
- With moderate distribution effort (10 hrs/month from Steve): **Maybe.** $150-400/mo is possible but doesn't justify the time.
- With serious distribution effort (20+ hrs/month from a dedicated person): **Possibly.** $750-1,500/mo within 12 months is achievable but requires finding or becoming that person.
- As an open-source play (full backend open-source like Rybbit): **Higher upside.** GitHub discovery could drive 1,000+ stars and cloud conversions. But fundamentally changes the business model.

### Recommendation
Beam as a **standalone business requiring ongoing investment** is not justified at current trajectory. The product is done. The question is whether Steve wants to invest 10-20 hours into a launch push (Show HN, directories, GSC) to test market response. If a strong Show HN post + 3 directory listings don't produce 50+ signups in the first week, the market has spoken.

The alternative: use Beam's codebase and infrastructure as **proof of capability** and redirect effort to a product in a hotter market with better distribution characteristics.

---

*Analysis based on web research conducted April 5, 2026. Revenue figures are estimates unless cited.*
