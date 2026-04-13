# Google Search Console Setup for beam-privacy.com

**Time required: ~5 minutes**

beam-privacy.com currently has zero Google-indexed pages. This guide gets it indexed.

---

## Step 1 — Add the new property

1. Go to [search.google.com/search-console](https://search.google.com/search-console)
2. Click **Add property** (top-left dropdown)
3. Choose **Domain** type, enter: `beam-privacy.com`
4. Click **Continue**

---

## Step 2 — Verify ownership (DNS TXT method — recommended)

Google will show you a TXT record like:
```
google-site-verification=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

**Add it to Cloudflare:**

1. Go to [dash.cloudflare.com](https://dash.cloudflare.com) → select `beam-privacy.com` zone
2. Click **DNS** → **Records** → **Add record**
3. Type: `TXT`, Name: `@`, Content: paste the full `google-site-verification=...` value
4. TTL: Auto, click **Save**
5. Back in GSC, click **Verify**

> DNS propagation is usually instant in Cloudflare. If GSC reports failure, wait 2 minutes and retry.

---

## Alternative: HTML meta tag method

If you prefer the meta tag method (already in use for the old domain):

1. In GSC, switch to **URL prefix** method with `https://beam-privacy.com`
2. Choose **HTML tag** verification
3. GSC gives you a meta tag like:  
   `<meta name="google-site-verification" content="NEWCODE" />`
4. Deploy the new `CONTENT` value as the `GOOGLE_SITE_VERIFICATION` wrangler secret:
   ```bash
   echo "NEWCODE" | npx wrangler secret put GOOGLE_SITE_VERIFICATION
   ```
5. Verify in GSC after deploy completes (~1 minute)

> **Note:** The existing `GOOGLE_SITE_VERIFICATION` value was set for `beam.keylightdigital.dev`. For the new `beam-privacy.com` property, Google will issue a different verification code — you must update the secret.

---

## Step 3 — Submit the sitemap

1. In GSC, select the `beam-privacy.com` property
2. Go to **Indexing** → **Sitemaps** in the left nav
3. In the **Add a new sitemap** field, enter: `sitemap.xml`
4. Click **Submit**

The full sitemap URL is `https://beam-privacy.com/sitemap.xml` (56 pages).

---

## Step 4 — Request indexing of key pages

While Google crawls the sitemap, manually request priority pages:

1. In GSC, use the **URL inspection** tool (top search bar)
2. Paste each URL and click **Request indexing**:
   - `https://beam-privacy.com/`
   - `https://beam-privacy.com/pricing`
   - `https://beam-privacy.com/how-it-works`
   - `https://beam-privacy.com/blog`
   - `https://beam-privacy.com/alternatives`

This front-loads the pages most likely to drive signups.

---

## Done

Google typically starts crawling within 24–48 hours of sitemap submission. Check **Coverage** in GSC after 2–3 days to confirm pages are indexed.
