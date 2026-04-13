# Beam + Webflow

Canonical guide: https://beam-privacy.com/for/webflow  
Live demo: https://beam-privacy.com/demo  
Create a free Beam site ID: https://beam-privacy.com/signup

Webflow works with the same hosted Beam script used across all platforms.

## 1) Add Beam in Project Settings

1. In Webflow, open `Project settings -> Custom code`.
2. Paste this snippet into `Head code`.
3. Publish your site.

```html
<script defer src="https://beam-privacy.com/js/beam.js" data-site-id="YOUR_SITE_ID"></script>
```

## 2) Optional page-level embed

If you only want Beam on selected pages, place the same script in a page-level `Embed` component near the end of `<body>`.

## 3) Verify in Beam

1. Open two published pages on your Webflow site.
2. Check Beam dashboard `Today`.
3. Confirm both paths appear in Top Pages.
