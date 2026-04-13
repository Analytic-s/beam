# Beam + WordPress

Canonical guide: https://beam-privacy.com/for/wordpress  
WordPress plugin page: https://beam-privacy.com/wordpress-plugin  
Live demo: https://beam-privacy.com/demo  
Create a free Beam site ID: https://beam-privacy.com/signup

Use the official Beam WordPress plugin for the cleanest install, or use a manual snippet if your theme/plugin workflow requires it.

## 1) Official plugin install (recommended)

1. Open the WordPress plugin guide: https://beam-privacy.com/for/wordpress
2. Install/activate the Beam plugin from your WordPress admin flow.
3. Paste your Beam `SITE_ID` in the plugin settings page.

The plugin outputs Beam's hosted script with your site ID:

```html
<script defer src="https://beam-privacy.com/js/beam.js" data-site-id="YOUR_SITE_ID"></script>
```

## 2) Manual fallback in `functions.php`

```php
// wp-content/themes/your-theme/functions.php
function beam_analytics_script() {
    echo '<script defer src="https://beam-privacy.com/js/beam.js" data-site-id="YOUR_SITE_ID"></script>';
}
add_action('wp_head', 'beam_analytics_script');
```

## 3) Verify in Beam

1. Visit your homepage and one post/page.
2. Open Beam dashboard `Today` range.
3. Confirm both URLs appear in Top Pages.
