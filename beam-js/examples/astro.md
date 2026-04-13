# Beam + Astro

Canonical guide: https://beam-privacy.com/for/astro  
Live demo: https://beam-privacy.com/demo  
Create a free Beam site ID: https://beam-privacy.com/signup

## 1) Add script in your base layout

```astro
---
// src/layouts/BaseLayout.astro
---
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
  </head>
  <body>
    <slot />
    <script
      is:inline
      defer
      src="https://beam-privacy.com/js/beam.js"
      data-site-id="YOUR_SITE_ID">
    </script>
  </body>
</html>
```

`is:inline` keeps the emitted tag predictable and works well for Astro static/SSR output.

## 2) Track a custom event (optional)

```html
<button onclick="window.beam?.track?.('newsletter_signup', { source: 'hero' })">
  Join newsletter
</button>
```

## 3) Verify in Beam

1. Open your homepage and another page.
2. Check Beam dashboard `Today`.
3. Confirm both URLs appear in Top Pages.
