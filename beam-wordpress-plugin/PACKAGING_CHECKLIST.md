# Beam WordPress Plugin Packaging Checklist

Use this checklist before publishing a new plugin build to WordPress.org or sharing a zip directly.

## Version and metadata

- [ ] `beam-analytics/beam-analytics.php` header version matches intended release version.
- [ ] `beam-analytics/readme.txt` `Stable tag` matches release version.
- [ ] `beam-analytics/readme.txt` includes current `Tested up to` WordPress version.
- [ ] Changelog entry for the release is present in `beam-analytics/readme.txt`.

## Packaging

- [ ] Run `./build-plugin-zip.sh` from `beam-wordpress-plugin/`.
- [ ] Confirm `beam-analytics.zip` exists in `beam-wordpress-plugin/`.
- [ ] Confirm zip root is `beam-analytics/` (not nested directories).
- [ ] Confirm zip includes only expected files (no `.DS_Store`, no local temp files).

## QA sanity checks

- [ ] Upload zip via `Plugins -> Add New -> Upload Plugin` on a test WordPress site.
- [ ] Activate plugin successfully.
- [ ] Open `Settings -> Beam Analytics`, set Site ID, and save.
- [ ] Verify script appears on public pages and does not load in wp-admin.
- [ ] If enabled, confirm "skip logged-in administrators" prevents admin tracking.

## Messaging and positioning

- [ ] Plugin docs clarify this plugin injects tracking only.
- [ ] Plugin docs clarify analytics dashboard/account management stays in hosted Beam.
