/**
 * @keylightdigital/beam — TypeScript type declarations
 *
 * Beam is a privacy-first web analytics service.
 * https://beam-privacy.com
 */

export {}

declare global {
  interface Window {
    beam: BeamAnalytics
  }
}

/**
 * The Beam analytics object exposed on `window.beam` after the script loads.
 */
interface BeamAnalytics {
  /**
   * Track a custom event with an optional properties object.
   *
   * @param eventName  Event name (max 64 characters, e.g. "signup_started")
   * @param properties Optional key/value pairs to attach to the event
   *
   * @example
   * window.beam.track('signup_started', { plan: 'pro' })
   * window.beam.track('purchase', { product_id: 'prod_abc', value: 29 })
   */
  track(eventName: string, properties?: Record<string, string | number | boolean>): void
}

/**
 * Attributes accepted by the Beam script tag.
 *
 * @example
 * <script defer
 *   src="https://beam-privacy.com/js/beam.js"
 *   data-site-id="YOUR_SITE_ID">
 * </script>
 */
interface BeamScriptAttributes {
  /**
   * Your Beam site ID, copied from the Beam dashboard.
   * The script will not send any data if this attribute is missing.
   */
  'data-site-id': string
}
