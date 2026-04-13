# BEAM-074 Branding and Domain Differentiation Plan

Date: 2026-04-04  
Owner: Ralph (Keylight Digital LLC)

## Decision Memo

### Recommended path
Choose **Option 2**: keep product name **Beam**, stop using **"Beam Analytics"**, and migrate to a dedicated product domain with a differentiated descriptor in copy (for example, "Beam for Privacy Analytics").

This keeps existing brand equity ("Beam"), removes the highest-confusion phrase, and avoids the cost/risk of a full rename.

### Decision needed from Steve before implementation
1. Confirm brand direction: `Option 2` or override with `Option 1`/`Option 3`.
2. Approve the exact public domain to migrate to (and purchase/ownership if needed).
3. Approve whether npm package/repo names stay as-is short term or get renamed in phase 2.

---

## Audit: Current Naming and Domain Surfaces

### 1) Product UI and public pages
- "Beam Analytics" appears in multiple user-facing titles/copy:
  - `beam/src/routes/blog.ts`
  - `beam/src/routes/legal.ts`
  - `beam/src/routes/changelog.ts`
  - `beam/src/scheduled.ts` (email sender display name)
  - `beam/src/routes/for.ts` (comments/copy)
- `beam-privacy.com` is hardcoded across canonical URLs, OG tags, script snippets, dashboards, and sitemap:
  - `beam/src/index.ts`
  - `beam/src/landing.ts`
  - `beam/src/routes/{about,api,auth,billing,blog,dashboard,demo,digest,for,legal,vs}.ts`

### 2) Launch and community assets
- Launch kit still uses "Beam Analytics" in prominent headings:
  - `launch/show-hn.md`
  - `launch/community-posts/show-hn.md`
- Launch URLs throughout assets point to `beam-privacy.com`:
  - `launch/community-posts/*.md`
  - `launch/show-hn.md`

### 3) npm / package metadata
- Tracking package is named `beam-analytics`:
  - `beam-js/package.json`
- Package README and typings point to `.dev` domain and current script URL:
  - `beam-js/README.md`
  - `beam-js/index.d.ts`

### 4) Email templates and sender identity
- Transactional/welcome emails use `Beam <beam@keylightdigital.dev>`:
  - `beam/src/routes/auth.ts`
- Scheduled digest/alert email sender uses `Beam Analytics <ralph@keylightdigital.dev>`:
  - `beam/src/scheduled.ts`

### 5) Webhooks, API docs, and integration surfaces
- Webhook endpoint docs/history include product host assumptions:
  - `beam/src/routes/billing.ts` (`/api/webhooks/stripe`)
  - `blockers.log` historical endpoint entries
- API docs and examples use `.dev` base URL:
  - `beam/src/routes/api.ts`
  - `beam-js/README.md`
  - launch/dev docs references

### 6) GitHub and OSS references
- Public script repo and links:
  - `https://github.com/scobb/beam.js` referenced in `beam/src/landing.ts`, `beam/src/routes/about.ts`, `launch/community-posts/*.md`, `beam-js/package.json`

### 7) Additional direct naming/domain conflicts discovered
- **External conflict (validated 2026-04-04):** `https://beamanalytics.io` is live and uses `<title>Beam Analytics ...</title>`.
- **Internal trust inconsistency:** repo guidance and docs mix `.dev` and `.com` targets (for example `CLAUDE.md`, `launch/release-checklist.md`, historic blocker entries), making the "official" product URL unclear.

---

## Confusion Risk Summary

1. **Search and direct-name collision risk**
   - "Beam Analytics" maps directly to an existing competitor site (`beamanalytics.io`) in the same category.
   - Using that exact phrase in Beam's title tags, launch copy, and email sender increases misrouting and brand ambiguity.

2. **Trust/conversion risk**
   - `beam-privacy.com` reads like an internal/dev subdomain to many buyers.
   - Mixing `.dev` and `.com` in docs/checklists creates uncertainty about canonical URL and ownership maturity.

3. **Operational migration risk if delayed**
   - Domain/name is embedded in many surfaces (API docs, webhook docs, email copy, launch templates, package docs).
   - Delaying a coordinated migration increases later cleanup cost and external inconsistency.

---

## Options and Tradeoffs

| Option | Description | Searchability | Legal/Confusion Risk | Implementation Effort | Trust/Conversion Impact | Operational Migration Risk | Rollout Complexity |
|---|---|---|---|---|---|---|---|
| 1 | Keep "Beam", stop all use of "Beam Analytics"; keep existing domain for now | Medium | Medium | Low | Medium | Low | Low |
| 2 | Keep "Beam", adopt differentiated descriptor + dedicated product domain | High | Low-Medium | Medium | High | Medium | Medium |
| 3 | Full rename (new product name + new domain + package/repo rebrand) | Medium (short term dip, long-term high) | Low | High | Medium-High (after transition) | High | High |

### Option notes
- Option 1 is fastest but leaves domain trust debt and weak differentiation.
- Option 2 balances risk reduction and implementation cost.
- Option 3 is cleanest long term but highest migration risk and likely requires larger launch reset.

---

## Preferred Plan (Option 2) and Staged Rollout

### Phase 0: Decision and Guardrails (1 day)
- Confirm canonical naming policy:
  - Product name: `Beam`
  - Avoid phrase: `Beam Analytics` in customer-facing copy
  - Descriptor format: `Beam for Privacy Analytics` (or approved variant)
- Select final dedicated product domain and canonical host policy.
- Define redirect policy from legacy hosts.

### Phase 1: Highest-impact trust surfaces first (1-2 days)
- Landing page and metadata:
  - Page title/OG/meta/canonical branding normalization
- Footer and email sender/display names:
  - Replace legacy sender display "Beam Analytics"
- GitHub/README trust surfaces:
  - `beam-js/README.md` canonical URL text, install snippets, docs links
- Community launch copy:
  - `launch/show-hn.md`, `launch/community-posts/show-hn.md`, plus shared launch README language
- API/docs copy:
  - `/docs/api`, public snippets, canonical API base examples

### Phase 2: Operational migration surfaces (2-4 days)
- Cloudflare routes/custom domains:
  - Add new domain route(s), retain legacy host, implement 301/canonical strategy
- Webhook-facing URLs/docs:
  - Keep old webhook endpoint active during transition; update docs and Stripe endpoint guidance
- API base URLs/docs:
  - Support old+new host for transition window and update all docs/snippets
- Public dashboard branding:
  - Ensure shared/public pages align with final brand string
- npm package and repo naming decision:
  - If keeping package short term: keep `beam-analytics`, update description/tagline
  - If renaming package: publish new package, deprecate old package with migration notice, update script docs
- GitHub repo naming:
  - Keep `beam.js` repo with updated README now; optional repo rename later with redirects

### Phase 3: De-risk and clean up (1-2 days)
- Verify 301/canonical behavior and search-console properties for new domain.
- Remove remaining public "Beam Analytics" strings from product/launch/docs.
- Publish migration changelog entry and short customer-facing note.

---

## Rename-Sensitive Surfaces Checklist (Explicit)

- Webhook endpoint URLs and webhook-facing docs/copy
- Email sender/display names and from-address branding
- npm package naming + deprecation/redirect plan
- GitHub repo naming + redirect behavior
- Cloudflare routes/custom domains
- Public dashboard/shared page branding
- API base URLs and API docs snippets
- Launch assets mentioning old name

---

## Why Option 2 Wins

- It removes the exact high-risk phrase ("Beam Analytics") that conflicts with a live competitor.
- It improves perceived trust by moving away from a dev-looking host as canonical public identity.
- It avoids the most expensive path (full rename) while still creating meaningful differentiation for launch and SEO.

