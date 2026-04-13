```text
██████  ███████  █████  ███    ███
██   ██ ██      ██   ██ ████  ████
██████  █████   ███████ ██ ████ ██
██   ██ ██      ██   ██ ██  ██  ██
██████  ███████ ██   ██ ██      ██
```

# @keylightdigital/beam

[![npm version](https://img.shields.io/npm/v/@keylightdigital/beam.svg)](https://www.npmjs.com/package/@keylightdigital/beam)
[![npm downloads](https://img.shields.io/npm/dm/@keylightdigital/beam.svg)](https://www.npmjs.com/package/@keylightdigital/beam)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Powered by Beam](https://img.shields.io/badge/Powered%20by-Beam-4f46e5)](https://beam-privacy.com)

Privacy-first, cookie-free web analytics tracking script for [Beam](https://beam-privacy.com) by Keylight Digital LLC.

## Live Demo

- Try the product: https://beam-privacy.com/demo
- See API docs: https://beam-privacy.com/docs/api

![Beam live demo dashboard preview](./assets/demo-dashboard.png)

## Why This Script

- Tiny payload: `beam.js` is currently `1592` bytes raw in this repo
- No cookies, no localStorage, no fingerprinting
- GDPR-friendly event and pageview tracking
- Works with static sites, SPAs, and server frameworks

## Script Size Comparison

Measured as uncompressed response size (bytes) on 2026-04-03.

| Tool | Script Size |
| --- | ---: |
| Beam (`beam.js`) | 1,592 B |
| Plausible (`/js/script.js`) | 3,005 B |
| Fathom (`/script.js`) | 6,905 B |
| Umami Cloud (`/script.js`) | 4,584 B |

## Installation

### Option 1: Script Tag (recommended)

```html
<script defer src="https://beam-privacy.com/js/beam.js" data-site-id="YOUR_SITE_ID"></script>
```

### Option 2: npm

```bash
npm install @keylightdigital/beam
```

```html
<!-- Serve beam.js from node_modules or your copied public asset path -->
<script defer src="/vendor/beam.js" data-site-id="YOUR_SITE_ID"></script>
```

The npm package provides the script file (`beam.js`) and type declarations (`index.d.ts`).

## Technical Article

**[Building privacy-first web analytics on Cloudflare Workers and D1](./articles/edge-analytics-architecture.md)**

An in-depth look at how Beam works under the hood: the Cloudflare Workers + D1 architecture, the cookie-free daily hashing approach for unique visitor counting, and the sub-2KB tracking script design. Also available on [Beam's blog](https://beam-privacy.com/blog/edge-analytics-architecture) and [Dev.to](https://dev.to/new) (paste from [devto-article.md](../launch/community-posts/devto-article.md)).

## Install Examples

GitHub-indexable install examples:

- [Next.js example](./examples/nextjs.md)
- [Astro example](./examples/astro.md)
- [Shopify example](./examples/shopify.md)
- [WordPress example](./examples/wordpress.md)
- [Webflow example](./examples/webflow.md)
- [All examples](./examples/README.md)

Canonical Beam guides:

- https://beam-privacy.com/for/nextjs
- https://beam-privacy.com/for/astro
- https://beam-privacy.com/for/shopify
- https://beam-privacy.com/for/wordpress
- https://beam-privacy.com/wordpress-plugin
- https://beam-privacy.com/for/webflow

## Quick Start

1. Create a site in the Beam dashboard and copy your `site_id`.
2. Add the script tag to your site.
3. Open your site once to generate a pageview.
4. Check analytics in your dashboard.

## Custom Event Tracking

```js
window.beam.track('purchase', { product: 'Pro Plan', value: 5 })
window.beam.track('newsletter_signup')
```

## TypeScript Support

This package ships with `index.d.ts`.

```ts
window.beam.track('upgrade', { from: 'free', to: 'pro' })
```

## Documentation

- Product and signup: https://beam-privacy.com
- Live demo: https://beam-privacy.com/demo
- API docs: https://beam-privacy.com/docs/api
- Source repo: https://github.com/scobb/beam.js

## Contributing

Contributions are welcome. Before opening a PR:

- Read [CONTRIBUTING.md](./CONTRIBUTING.md)
- Use the bug template: [New bug report](https://github.com/scobb/beam.js/issues/new?template=bug_report.md)
- Keep changes focused on the public script package and docs

## License

MIT
