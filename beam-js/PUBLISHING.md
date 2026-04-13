# Publishing @keylightdigital/beam to npm

## Automated (recommended)

Publishing is automated via GitHub Actions. Two steps:

1. **Add NPM_TOKEN as a repository secret**
   - Go to https://github.com/scobb/beam.js/settings/secrets/actions
   - Click "New repository secret"
   - Name: `NPM_TOKEN`
   - Value: your npm access token (from https://www.npmjs.com/settings/~/tokens — create a "Publish" type token)

2. **Push a version tag**
   ```bash
   git tag v1.0.1
   git push --tags
   ```

The GitHub Action (`.github/workflows/publish.yml`) will trigger automatically and publish to npm using the token.

---

## Manual publish (fallback)

If you need to publish without the GitHub Action:

```bash
npm login
npm publish
```

`npm login` will open a browser window to authenticate. Once logged in, `npm publish` pushes the package.

### Before publishing

Run a dry-run to confirm package contents:

```bash
npm pack --dry-run
```

Expected files:
- `beam.js` — tracking script
- `index.d.ts` — TypeScript type declarations
- `README.md`
- `LICENSE`
- `package.json`

### Version bumps

Update the `version` field in `package.json` before tagging or publishing.
