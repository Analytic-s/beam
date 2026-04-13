=== Beam Analytics ===
Contributors: scobb
Tags: analytics, privacy, cookieless, gdpr
Requires at least: 6.0
Tested up to: 6.8
Requires PHP: 7.4
Stable tag: 0.1.0
License: GPLv2 or later
License URI: https://www.gnu.org/licenses/gpl-2.0.html

Privacy-first analytics for WordPress with no cookies and no consent-banner overhead.

== Description ==

Beam Analytics connects your WordPress site to Beam with a lightweight script and no external plugin dependencies.

Features:

* Settings page in wp-admin (`Settings -> Beam Analytics`)
* Site ID saved with the WordPress Settings API
* Public-site script injection only when configured
* Optional skip-tracking mode for logged-in administrators
* Compatible with Beam custom events because it loads the same `window.beam` browser API script

== Installation ==

1. Zip the `beam-analytics` plugin folder.
2. In WordPress admin, go to `Plugins -> Add New -> Upload Plugin`.
3. Upload the zip and activate **Beam Analytics**.
4. Open `Settings -> Beam Analytics`.
5. Enter your Beam Site ID and save.

== Frequently Asked Questions ==

= Where do I find my Beam Site ID? =

In Beam dashboard: Sites -> select your site -> copy Site ID.

= Does this plugin include hosted analytics dashboards? =

No. This plugin only injects Beam's tracking script into your WordPress frontend. You still need a hosted Beam account for site setup and reporting.

= Does this plugin track wp-admin traffic? =

No. It only injects the script on public pages. You can also enable the setting to skip logged-in administrators on the public site.

= Can I still fire custom events? =

Yes. The plugin only loads Beam's standard script. If your theme or frontend code calls `window.beam.track(...)`, those events continue to work.

== Changelog ==

= 0.1.0 =
* Initial release with settings page, site ID storage, optional admin skip tracking, and Beam script injection.
