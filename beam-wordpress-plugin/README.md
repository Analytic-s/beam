# Beam WordPress Plugin Package

This directory contains the official Beam WordPress plugin source in a zip-ready structure.

- Plugin folder: `beam-analytics/`
- Main plugin entry file: `beam-analytics/beam-analytics.php`
- WordPress.org readme: `beam-analytics/readme.txt`
- Packaging checklist: `PACKAGING_CHECKLIST.md`
- Build script: `build-plugin-zip.sh`

To build an installable zip:

```bash
cd beam-wordpress-plugin
./build-plugin-zip.sh
```

Important: this plugin only installs Beam tracking on WordPress. Account creation, site setup, and analytics reporting happen in the hosted Beam app.
