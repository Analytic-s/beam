# Beam Product Hunt Asset Pack

This folder is the launch-ready media + copy kit for Product Hunt.

## What is inside

- `assets/` — Product Hunt gallery images, all exported at `1270x760` PNG
- `submission-kit.md` — copy-paste launch copy (tagline, short description, maker comment, replies)

## Canonical tracked URL

Use this exact URL in the Product Hunt listing and maker comment:

`https://beam-privacy.com/product-hunt?ref=product-hunt&utm_source=producthunt&utm_medium=launch&utm_campaign=ph_launch_apr_2026`

This must stay aligned with [launch-day-checklist.md](/home/scobb/repos/ralph-bootstrap/launch/launch-day-checklist.md).

## Asset Placement Guide

1. `assets/01-product-hunt-landing.png`
   Use for: Gallery image #1 (hero)
   Shows: Product Hunt-specific launch page and value proposition
2. `assets/02-live-demo.png`
   Use for: Gallery image #2
   Shows: Live demo surface with realistic analytics data
3. `assets/03-dashboard-overview.png`
   Use for: Gallery image #3
   Shows: Authenticated dashboard overview (site list + navigation)
4. `assets/04-analytics-breakdowns.png`
   Use for: Gallery image #4
   Shows: Analytics page with channel and breakdown context
5. `assets/05-guided-setup.png`
   Use for: Gallery image #5
   Shows: Guided first-session setup flow
6. `assets/06-migration-assistant.png`
   Use for: Gallery image #6
   Shows: Migration assistant and scanner workflow

## Source-of-truth surfaces

All assets are derived from real Beam product pages (captured in `beam/screenshots/smoke/*.png`) and then normalized to Product Hunt gallery dimensions.
No synthetic mockups are used.

## Regeneration command

Run from repo root if smoke screenshots are refreshed:

```bash
mkdir -p launch/product-hunt/assets
magick beam/screenshots/smoke/desktop-product-hunt-launch.png -resize 1270x -gravity north -crop 1270x760+0+0 +repage -strip launch/product-hunt/assets/01-product-hunt-landing.png
magick beam/screenshots/smoke/desktop-demo.png -resize 1270x -gravity north -crop 1270x760+0+0 +repage -strip launch/product-hunt/assets/02-live-demo.png
magick beam/screenshots/smoke/desktop-dashboard.png -resize 1270x -gravity north -crop 1270x760+0+0 +repage -strip launch/product-hunt/assets/03-dashboard-overview.png
magick beam/screenshots/smoke/desktop-analytics.png -resize 1270x -gravity north -crop 1270x760+0+0 +repage -strip launch/product-hunt/assets/04-analytics-breakdowns.png
magick beam/screenshots/smoke/desktop-first-session-setup.png -resize 1270x -gravity north -crop 1270x760+0+0 +repage -strip launch/product-hunt/assets/05-guided-setup.png
magick beam/screenshots/smoke/desktop-migration-assistant.png -resize 1270x -gravity north -crop 1270x760+0+0 +repage -strip launch/product-hunt/assets/06-migration-assistant.png
```
