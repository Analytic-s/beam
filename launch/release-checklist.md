# Beam Release Checklist

> **Ship bar**: A release is considered ready only when every section below is checked off.
> Agent iterations must NOT call the product ship-ready without completing this checklist.

---

## 1. Code Quality

- [ ] `npm run typecheck` passes with zero errors (`tsc --noEmit` in `beam/`)
- [ ] No TypeScript `// @ts-ignore` or `// @ts-expect-error` introduced without explanation
- [ ] No `console.log` debug lines left in production paths
- [ ] All changed files follow existing naming and code conventions

---

## 2. Automated Smoke Suite

Run from `beam/`: `npm run test:smoke`

- [ ] **Desktop smoke** – all 4 tests pass
  - landing page loads, headline and CTA visible
  - signup page accessible (email + password fields present)
  - login page accessible
  - dashboard shell renders after signup (sidebar visible, Overview link present)
- [ ] **Mobile smoke** – all 3 tests pass (375 × 667 viewport, touch enabled)
  - landing page loads without horizontal overflow
  - dashboard hamburger menu opens sidebar on tap
  - analytics page renders without horizontal overflow
- [ ] No `test.only` left in test files
- [ ] Screenshots written to `screenshots/smoke/` (check desktop-landing, desktop-dashboard, mobile-landing, mobile-dashboard)

---

## 3. Production Deployment Verification

After `npx wrangler deploy` (from `beam/`):

- [ ] `GET https://beam-privacy.com/` returns 200 and correct HTML (or current `PUBLIC_BASE_URL` host if different)
- [ ] Tracking script endpoint responds: `GET /js/beam.js` returns 200
- [ ] Dashboard login/signup flow works end-to-end on production URL
- [ ] D1 migrations have been applied to remote: `npx wrangler d1 migrations apply beam-db --remote`
- [ ] All required Wrangler secrets are set (verify via `npx wrangler secret list`):
  - `BEAM_JWT_SECRET`
  - `RESEND_API_KEY`
  - `STRIPE_SECRET_KEY` (if billing flows touched)
  - `STRIPE_WEBHOOK_SECRET` (if Stripe webhooks touched)
  - `BEAM_SELF_SITE_ID` (for dogfooding self-analytics)

---

## 4. Revenue Flow (billing-related changes only)

Skip if the release does not touch Stripe or subscription logic.

- [ ] Pro upgrade flow completes without error (Stripe Checkout or Billing Portal)
- [ ] Webhook events are processed (check Stripe Dashboard → Events for recent `customer.subscription.*`)
- [ ] Plan limits are enforced: free-tier user blocked at 1 site / 50 K pageviews
- [ ] Pro-tier limits are enforced: unlimited sites, 500 K pageviews cap applied correctly
- [ ] Billing sanity: no duplicate charges, correct amount shown in Stripe Dashboard

---

## 5. Mobile Responsiveness

For any story that touches the dashboard UI:

- [ ] No horizontal overflow on landing page at 375 px wide
- [ ] No horizontal overflow on dashboard pages at 375 px wide
- [ ] Mobile sidebar hamburger opens and closes correctly
- [ ] Tables use `overflow-x-auto` wrapper so they scroll rather than overflow
- [ ] Auth pages have `px-4` body padding so cards don't touch screen edges
- [ ] Touch targets are at least 44 × 44 px (tap-friendly buttons/links)

---

## 6. Public Page Health

- [ ] Landing page (`/`) renders with correct headline, features, and pricing copy
- [ ] `/signup` and `/login` pages render and are functional
- [ ] `/pricing` (if separate) reflects current Free / Pro tiers accurately
- [ ] At least one blog post and one comparison page (`/vs/*`) are live and crawlable
- [ ] `sitemap.xml` includes all public pages added in this release
- [ ] `robots.txt` is served and not blocking critical paths
- [ ] No broken internal links on marketing pages (spot-check footer links)

---

## 7. Analytics Correctness

- [ ] Pageview tracking script fires on target domain (verify in Network tab or D1)
- [ ] Unique visitor counts are stable (hash-based deduplication not inflating)
- [ ] Date-window calculations are UTC-consistent across SQL, chart labels, and copy
- [ ] Custom events (if touched) appear in the Events dashboard tab
- [ ] Today view hourly breakdown renders correct hours for UTC day
- [ ] Badge SVG endpoint returns valid SVG with correct count format

---

## 8. Manual QA (human review — not automated)

These items require a human eye or touch-device verification:

- [ ] **Copy review**: headlines, CTAs, and error messages are clear and free of typos
- [ ] **Visual polish**: no obvious layout glitches, truncated text, or misaligned elements at common breakpoints (375 px, 768 px, 1280 px)
- [ ] **Touch feel**: on a real or simulated mobile device, tap interactions feel responsive (no 300 ms tap delay, correct hit areas)
- [ ] **Billing sanity**: if Stripe touched, manually confirm a test checkout succeeds and the dashboard reflects the correct plan
- [ ] **Empty states**: new-user dashboard, zero-pageview analytics, and zero-event views render gracefully (not blank or broken)
- [ ] **Error states**: 404 page is branded, 500-class errors don't expose stack traces

---

## Minimum Ship Bar Summary

| Gate | Requirement |
|------|------------|
| Typecheck | Zero errors |
| Desktop smoke | All desktop smoke tests green |
| Mobile smoke | All mobile smoke tests green |
| Production deploy | HTTP 200 on root, migrations applied |
| Revenue (if touched) | Checkout completes, webhook processed |
| Mobile layout | No overflow at 375 px |
| Copy review | Human spot-check |

A release is **blocked** if any of the following are broken:
- `tsc --noEmit` fails
- Any smoke test fails
- Production URL returns non-200
- Horizontal overflow exists at 375 px width
- Stripe checkout is broken (if billing code was changed)

---

## Deployment Note Template

Copy this block into `progress.txt` when shipping a release:

```
## [YYYY-MM-DD HH:MM UTC] - RELEASE [version or story range]

### Verified
- [ ] typecheck: PASS
- [ ] desktop smoke: PASS (N/N tests)
- [ ] mobile smoke: PASS (N/N tests)
- [ ] production deploy: beam-privacy.com HTTP 200
- [ ] D1 migrations applied to remote: YES / NO / N/A
- [ ] Stripe flow: PASS / SKIP (not touched)
- [ ] Mobile layout: PASS (no overflow at 375px)
- [ ] Manual copy review: PASS / PENDING

### Screenshots
- desktop-landing: [path or "attached"]
- desktop-dashboard: [path or "attached"]
- mobile-landing: [path or "attached"]
- mobile-dashboard: [path or "attached"]

### Notes
[Anything unusual, deferred items, known issues]
---
```
