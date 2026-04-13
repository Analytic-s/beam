# Beam + Shopify

Canonical guide: https://beam-privacy.com/for/shopify  
Live demo: https://beam-privacy.com/demo  
Create a free Beam site ID: https://beam-privacy.com/signup

Shopify is one of the newly added `/for/*` platform guides in this phase.

## 1) Install in `layout/theme.liquid`

```liquid
{% comment %} Shopify Admin -> Online Store -> Themes -> Edit code -> layout/theme.liquid {% endcomment %}
<head>
  <!-- Existing head tags -->
  <script
    defer
    src="https://beam-privacy.com/js/beam.js"
    data-site-id="YOUR_SITE_ID">
  </script>
</head>
```

This loads Beam across homepage, collection, product, and content templates.

## 2) Track a custom storefront event (optional)

```liquid
<button onclick="window.beam?.track?.('add_to_cart_clicked', { template: '{{ template }}' })">
  Add to cart
</button>
```

## 3) Verify in Beam

1. Open homepage, one collection page, and one product page.
2. Check Beam dashboard `Today`.
3. Confirm each path appears in Top Pages.
