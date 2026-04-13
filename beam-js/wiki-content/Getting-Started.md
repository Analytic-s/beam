# Getting Started — Privacy Analytics Setup

> **Keywords:** privacy analytics setup, cookie-free analytics install, GDPR analytics guide

Set up Beam on your site in under 5 minutes with no server required. Beam collects pageviews and custom events without cookies, fingerprinting, or personal data.

## 1. Create a Free Account

[Sign up at beam-privacy.com/signup](https://beam-privacy.com/signup) — free tier includes 1 site and 50,000 pageviews/month. No credit card required.

## 2. Add Your Site

After signing up, go to your [Beam dashboard](https://beam-privacy.com/dashboard) and click **Add Site**. Enter your domain (e.g. `example.com`) and copy your unique `data-site-id`.

## 3. Install the Tracking Script

Paste this snippet before the closing `</head>` tag on every page you want to track:

```html
<script defer src="https://beam-privacy.com/js/beam.js" data-site-id="YOUR_SITE_ID"></script>
```

Replace `YOUR_SITE_ID` with the ID from your dashboard.

## 4. Verify Installation

Return to your [Beam dashboard](https://beam-privacy.com/dashboard) and open your site. Click **Verify Installation** — Beam checks for the first pageview signal and confirms the script is active.

## Framework-Specific Guides

Beam works on any HTML page. For framework-specific instructions see:

- [Next.js Analytics Guide](https://beam-privacy.com/for/nextjs)
- [WordPress Analytics Guide](https://beam-privacy.com/for/wordpress)
- [Astro Analytics Guide](https://beam-privacy.com/for/astro)
- [Webflow Analytics Guide](https://beam-privacy.com/for/webflow)
- [Shopify Analytics Guide](https://beam-privacy.com/for/shopify)

## Tracking Custom Events

Beyond pageviews, you can track button clicks, form submissions, and other interactions:

```html
<script>
// Track a custom event
window.beam && beam.track('signup_complete');

// Track with properties
window.beam && beam.track('purchase', { plan: 'pro', amount: 5 });
</script>
```

View event data in your dashboard under the **Events** tab. See the [API Reference](API-Reference) for the full events spec.

## What Data is Collected?

Beam collects:
- Page URL and referrer
- Country (from IP, IP is never stored)
- Browser type and screen width
- Session duration (approximate)

Beam never stores IP addresses, personal identifiers, or any data that requires GDPR consent. See [Privacy Design](Privacy-Design) for the full technical breakdown.

## Need Help?

- [Live Demo](https://beam-privacy.com/demo) — see what the dashboard looks like
- [API Documentation](https://beam-privacy.com/docs/api) — advanced configuration
- [Open a Q&A Discussion](https://github.com/scobb/beam.js/discussions) — get help from the community
