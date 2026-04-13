# Beam Analytics WordPress Plugin

Official Beam plugin for WordPress.

- Product: Beam
- Company: Keylight Digital LLC
- Minimum WordPress version: 6.0
- Minimum PHP version: 7.4

## What It Does

- This plugin only installs Beam tracking on WordPress pages.
- Adds a `Settings -> Beam Analytics` page in wp-admin.
- Stores your Beam Site ID using WordPress Settings API.
- Injects Beam's tracking script on public pages when configured.
- Can skip tracking for logged-in administrators to avoid polluting analytics during setup.
- Leaves Beam's browser API untouched, so custom events (for example `window.beam.track(...)`) still work as expected.

Account creation, site setup, and analytics reporting stay in the hosted Beam app.

## Installation

1. In your Beam dashboard, create a site and copy its Site ID.
2. Zip the `beam-analytics` folder so the folder itself is the zip root.
3. In WordPress admin, go to `Plugins -> Add New -> Upload Plugin` and upload the zip.
4. Activate `Beam Analytics`.
5. Open `Settings -> Beam Analytics`, paste your Site ID, and save.

## Packaging Command

Run from the repository root:

```bash
cd beam-wordpress-plugin
./build-plugin-zip.sh
```

## Development Notes

- Script URL defaults to `https://beam-privacy.com/js/beam.js`.
- You can override the base URL if needed:

```php
add_filter('beam_analytics_base_url', function () {
    return 'https://beam-privacy.com';
});
```

## License

GPL-2.0-or-later
