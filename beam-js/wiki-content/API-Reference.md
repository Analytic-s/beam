# API Reference — Analytics API Documentation

> **Keywords:** analytics API documentation, beam analytics REST API, pageviews API query, custom events API

Beam provides a public Stats API for querying your analytics data programmatically. Use it to build dashboards, automate reports, or integrate Beam data into your own tools.

## Authentication

All API requests require an API key. Generate one from your [Beam dashboard](https://beam-privacy.com/dashboard) under Settings → API Keys.

```bash
Authorization: Bearer YOUR_API_KEY
```

## Base URL

```
https://beam-privacy.com/api
```

## Endpoints

### GET /api/stats

Returns aggregated analytics for a site.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `site_id` | string | Yes | Your site ID (from dashboard) |
| `period` | string | No | `day`, `week`, `month`, `custom` (default: `month`) |
| `start` | string | No | Start date `YYYY-MM-DD` (required for `custom`) |
| `end` | string | No | End date `YYYY-MM-DD` (required for `custom`) |

**Example request:**

```bash
curl -H "Authorization: Bearer YOUR_API_KEY" \
  "https://beam-privacy.com/api/stats?site_id=YOUR_SITE_ID&period=week"
```

**Example response:**

```json
{
  "pageviews": 1240,
  "visitors": 890,
  "bounce_rate": 0.42,
  "avg_duration": 87,
  "top_pages": [
    { "path": "/", "pageviews": 450, "visitors": 380 },
    { "path": "/blog", "pageviews": 200, "visitors": 165 }
  ],
  "top_sources": [
    { "source": "direct", "visitors": 400 },
    { "source": "google", "visitors": 290 }
  ]
}
```

### POST /api/collect

Collects a pageview or custom event. This is the endpoint called by the `beam.js` tracking script.

**Request body:**

```json
{
  "site_id": "YOUR_SITE_ID",
  "url": "https://example.com/page",
  "referrer": "https://google.com",
  "event": "pageview"
}
```

For custom events:

```json
{
  "site_id": "YOUR_SITE_ID",
  "url": "https://example.com/checkout",
  "event": "purchase_complete",
  "props": { "plan": "pro", "amount": 5 }
}
```

## JavaScript Client

The [beam.js tracking script](https://beam-privacy.com/js/beam.js) wraps the collection API:

```html
<!-- Install the script -->
<script defer src="https://beam-privacy.com/js/beam.js" data-site-id="YOUR_SITE_ID"></script>

<!-- Track a custom event -->
<script>
window.beam && beam.track('button_click', { label: 'signup_cta' });
</script>
```

## Goals API

Goals let you define conversion targets and track their completion rate. Configure goals in your [Beam dashboard](https://beam-privacy.com/dashboard).

**Goal patterns:**
- Path-based: `/checkout/success` matches any URL ending with that path
- Event-based: `event:purchase_complete` matches a named custom event

## Rate Limits

| Endpoint | Rate Limit |
|----------|-----------|
| `/api/collect` | 10,000 requests/minute per site |
| `/api/stats` | 100 requests/minute per API key |

## Full API Docs

See [beam-privacy.com/docs/api](https://beam-privacy.com/docs/api) for the complete API reference including filtering, sorting, goal queries, and event breakdown endpoints.

## Questions?

- [Live Demo](https://beam-privacy.com/demo) — explore the dashboard with sample data
- [Sign Up Free](https://beam-privacy.com/signup) — get your API key
- [Open a Q&A Discussion](https://github.com/scobb/beam.js/discussions) — ask the community
