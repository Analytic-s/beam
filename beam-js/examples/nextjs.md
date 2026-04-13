# Beam + Next.js

Canonical guide: https://beam-privacy.com/for/nextjs  
Live demo: https://beam-privacy.com/demo  
Create a free Beam site ID: https://beam-privacy.com/signup

## 1) Install with App Router (`app/layout.tsx`)

```tsx
import Script from 'next/script'

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body>
        {children}
        <Script
          src="https://beam-privacy.com/js/beam.js"
          data-site-id="YOUR_SITE_ID"
          strategy="afterInteractive"
        />
      </body>
    </html>
  )
}
```

Beam sends pageviews automatically when the script loads.

## 2) Track a custom event (optional)

```tsx
'use client'

export function UpgradeButton() {
  return (
    <button
      onClick={() =>
        window.beam?.track?.('upgrade_clicked', { plan: 'pro', source: 'pricing' })
      }
    >
      Upgrade
    </button>
  )
}
```

## 3) Verify in Beam

1. Visit two routes in your Next.js app.
2. Open Beam dashboard `Today` range.
3. Confirm both paths appear in Top Pages.
