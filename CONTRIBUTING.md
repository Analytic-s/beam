# Contributing to Beam

Thanks for your interest in contributing to Beam!

## Prerequisites

- Node.js 20+
- A Cloudflare account (free tier works for local dev)
- [Wrangler CLI](https://developers.cloudflare.com/workers/wrangler/) (`npm i -g wrangler`)

## Local setup

```bash
git clone https://github.com/scobb/beam.git
cd beam
npm install
cp .env.example .env   # fill in your credentials
npm run migrations:local
npm run dev
```

The dev server starts at `http://localhost:8787`.

## Code style

- TypeScript, strict mode
- Hono framework for routing
- No external runtime dependencies beyond `hono` and `@sentry/cloudflare`
- Keep the tracking snippet under 2 KB gzipped

## Running checks

```bash
npm run typecheck   # must pass
npm run test        # 97+ unit tests must pass
```

## Submitting a PR

1. Fork the repo and create a branch from `main`
2. Make your changes
3. Run `npm run typecheck` and `npm run test` — both must pass
4. Open a PR using the pull request template
5. CI will run automatically; all checks must be green before merge

## Reporting bugs

Use the [bug report template](.github/ISSUE_TEMPLATE/bug_report.md).

## Requesting features

Use the [feature request template](.github/ISSUE_TEMPLATE/feature_request.md).

## License

By contributing you agree that your contributions will be licensed under the [MIT License](LICENSE).
