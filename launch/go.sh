#!/bin/bash
# launch/go.sh — Beam launch playbook for Steve
# Run this once when you're ready to launch. Total time: ~35 minutes.

set -e

# ── Helpers ───────────────────────────────────────────────────────────────────
BOLD="\033[1m"
GREEN="\033[32m"
CYAN="\033[36m"
YELLOW="\033[33m"
RESET="\033[0m"

open_url() {
  local url="$1"
  if command -v xdg-open &>/dev/null; then
    xdg-open "$url" 2>/dev/null &
  elif command -v open &>/dev/null; then
    open "$url" 2>/dev/null &
  else
    echo "  → Open manually: $url"
  fi
}

pause() {
  echo ""
  read -rp "  Press ENTER when done, or Ctrl-C to stop → " _
}

# ── Header ────────────────────────────────────────────────────────────────────
clear
echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════════════╗"
echo -e "║       Beam Launch Script — Total: ~35 minutes        ║"
echo -e "╚══════════════════════════════════════════════════════╝${RESET}"
echo ""
echo "  This script walks you through 6 launch actions."
echo "  Each step prints the exact text to paste — no writing required."
echo ""

# ── Step 0: Uneed.best ────────────────────────────────────────────────────────
echo -e "${BOLD}${GREEN}[0/5] Uneed.best — DO THIS FIRST  (~5 min)${RESET}"
echo ""
echo -e "  ${YELLOW}WHY FIRST:${RESET} uneed.best/alternatives/beam_analytics lists 10 Beam Analytics"
echo "  alternatives. beam-privacy.com is NOT on that list. beamanalytics.io"
echo "  users searching for a replacement will land there. Highest-leverage"
echo "  5-minute action — zero time pressure unlike HN."
echo ""
echo -e "${BOLD}  URL:${RESET}"
echo "  https://www.uneed.best/submit-a-tool"
echo ""
echo -e "${BOLD}  Tool name:${RESET}  Beam"
echo -e "${BOLD}  URL:${RESET}        https://beam-privacy.com?ref=uneed&utm_source=uneed&utm_medium=directory&utm_campaign=beam_analytics_migration"
echo -e "${BOLD}  Tagline:${RESET}    Privacy-first web analytics — no cookies, no consent banners"
echo -e "${BOLD}  Category:${RESET}   Analytics"
echo -e "${BOLD}  Pricing:${RESET}    Freemium (Free: 1 site / 50K pageviews/mo. Pro: \$5/mo)"
echo -e "${BOLD}  Alternatives to:${RESET}  Google Analytics, Plausible, Fathom, Beam Analytics (beamanalytics.io)"
echo ""
echo -e "${BOLD}  Description (copy the block between the dashes):${RESET}"
cat << 'UNEEDBODY'
---
Beam is a lightweight, privacy-first analytics platform built on Cloudflare Workers. It tracks
pageviews, referrers, countries, devices, and custom events without cookies or fingerprinting —
GDPR-compliant by design. If you're migrating from Beam Analytics (beamanalytics.io, shutting down
September 1, 2026), Beam has a migration guide and CSV import tool at
beam-privacy.com/migrate/beam-analytics. Free tier: 1 site, 50,000 pageviews/month. Pro: $5/month,
unlimited sites, 500,000 pageviews/month.
---
UNEEDBODY
echo ""
echo "  Full submission details: launch/uneed-submission.md"
echo ""
open_url "https://www.uneed.best/submit-a-tool"
pause

# ── Step 1: Show HN ───────────────────────────────────────────────────────────
echo -e "${BOLD}${GREEN}[1/5] Show HN  (~10 min)${RESET}"
echo "  URL: https://news.ycombinator.com/submit"
echo ""
echo -e "${BOLD}  Title (copy this exactly):${RESET}"
echo '  Show HN: Beam – Cookie-free analytics on Cloudflare Workers, sub-2KB script'
echo ""
echo -e "${BOLD}  Body (copy the block between the dashes):${RESET}"
cat << 'HNBODY'
---
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
No cookies, no fingerprint stored, no consent banner required.

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

Use this exact link in the post so signups keep source attribution:
https://beam-privacy.com/show-hn?ref=show-hn&utm_source=hackernews&utm_medium=community&utm_campaign=hn_launch_apr_2026&utm_content=post_body

Code (tracking script, open-source):
https://github.com/scobb/beam.js

Pricing:
- Free: 1 site, 50K pageviews/month
- Pro: $5/month, unlimited sites, 500K pageviews/month

Happy to answer questions about the edge architecture, the hashing approach,
or why I chose D1 over something like PlanetScale or Turso.
---
HNBODY

echo ""
echo "  IMPORTANT: Post Tue/Wed/Thu 8–10 AM EST for best front-page chances."
echo "  Do NOT upvote your own post. Reply to every comment in the first 2 hours."
echo ""
open_url "https://news.ycombinator.com/submit"
pause

# ── Step 2: Reddit r/webdev ────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}[2/5] Reddit r/webdev  (~5 min)${RESET}"
echo "  URL: https://www.reddit.com/r/webdev/submit"
echo ""
echo -e "${BOLD}  Title:${RESET}"
echo '  Beam: cookie-free web analytics on Cloudflare Workers (sub-2KB script)'
echo ""
echo -e "${BOLD}  Body:${RESET}"
cat << 'REDDITBODY'
---
I built Beam, a privacy-first analytics tool for people who want simple traffic
and conversion visibility without adding cookies or consent-banner complexity.

**Timely context:** beamanalytics.io announced it's shutting down September 1,
2026. If you or your team uses it, we built a migration guide with CSV import
support: https://beam-privacy.com/migrate/beam-analytics

What makes it different technically:
- Tracking script is tiny (~543B gzipped, under sub-2KB target)
- No cookies, no localStorage, no fingerprinting
- Runs on Cloudflare Workers + D1 + KV
- Custom events, goals, API access, and plain-English weekly insights

Live interactive demo (click around before signing up):
https://beam-privacy.com/show-hn?ref=reddit-webdev&utm_source=reddit&utm_medium=community&utm_campaign=launch_kit_apr_2026&utm_content=webdev_post

Open-source tracking script repo:
https://github.com/scobb/beam.js

I'd love feedback on two things:
1) Is the integration/docs clear enough for Next.js/WordPress/Astro/Remix users?
2) What's the biggest missing feature that blocks you from trying this on a real project?
---
REDDITBODY

open_url "https://www.reddit.com/r/webdev/submit"
pause

# ── Step 3: OpenAlternative.co ─────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}[3/5] Submit to openalternative.co  (~5 min)${RESET}"
echo "  URL: https://openalternative.co/submit"
echo ""
echo -e "${BOLD}  Form fields:${RESET}"
echo "  Name:         Beam"
echo "  URL:          https://beam-privacy.com"
echo "  Tagline:      Privacy-first web analytics on the Cloudflare edge"
echo "  Description:  Cookie-free, GDPR-compliant analytics built on Cloudflare Workers."
echo "                Sub-2KB tracking script, no consent banners needed."
echo "                Free tier included; \$5/mo Pro plan."
echo "  Alternatives: Google Analytics, Plausible, Umami, Matomo"
echo "  Categories:   Analytics, Privacy, Developer Tools"
echo ""
open_url "https://openalternative.co/submit"
pause

# ── Step 4: npm publish ────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}[4/5] npm publish beam-js  (~3 min)${RESET}"
echo ""
if [ -n "${NPM_TOKEN:-}" ]; then
  echo "  NPM_TOKEN is set — publishing now..."
  BEAM_JS_DIR="$(dirname "$(dirname "$0")")/beam-js"
  if [ -d "$BEAM_JS_DIR" ]; then
    cd "$BEAM_JS_DIR"
    echo "  Running: npm publish --access public"
    npm publish --access public
    cd - >/dev/null
    echo -e "  ${GREEN}✓ Published!${RESET}"
  else
    echo "  beam-js/ directory not found at expected path: $BEAM_JS_DIR"
    echo "  Run manually: cd beam-js && npm publish --access public"
  fi
else
  echo "  NPM_TOKEN is not set. To publish:"
  echo ""
  echo "  Step 1 — Set your npm token:"
  echo "    export NPM_TOKEN=your_token_here"
  echo "    (or add it to .env and source it)"
  echo ""
  echo "  Step 2 — Publish:"
  echo "    cd beam-js && npm publish --access public"
  echo ""
  echo "  Or re-run this script with NPM_TOKEN set to auto-publish."
fi
pause

# ── Step 5: Google Search Console ────────────────────────────────────────────
echo ""
echo -e "${BOLD}${GREEN}[5/5] Add beam-privacy.com to Google Search Console  (~5 min)${RESET}"
echo "  URL: https://search.google.com/search-console/welcome"
echo ""
echo "  Steps:"
echo "  1. Click 'Add property' → select 'URL prefix'"
echo "  2. Enter: https://beam-privacy.com"
echo "  3. Choose 'HTML tag' verification method"
echo "  4. Copy the meta tag content value"
echo "  5. Add it as GOOGLE_SITE_VERIFICATION secret in Cloudflare:"
echo "     cd beam && echo 'your_meta_content' | npx wrangler secret put GOOGLE_SITE_VERIFICATION"
echo "  6. Deploy: cd beam && npm run deploy"
echo "  7. Back in Search Console, click 'Verify'"
echo ""
echo -e "  ${YELLOW}Note: If beam-privacy.com is already verified, skip this step.${RESET}"
echo ""
open_url "https://search.google.com/search-console/welcome"
pause

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${BOLD}${CYAN}╔══════════════════════════════════════════════════════╗"
echo -e "║                  Launch complete!                    ║"
echo -e "╚══════════════════════════════════════════════════════╝${RESET}"
echo ""
echo "  Monitor over the next hour:"
echo "  → Public dashboard:  https://beam-privacy.com/public/dfa32f6b-0775-43df-a2c4-eb23787e5f03"
echo "  → Acquisition stats: https://beam-privacy.com/dashboard/acquisition"
echo "  → Cloudflare tail:   cd beam && npx wrangler tail"
echo ""
echo "  Good luck!"
echo ""
