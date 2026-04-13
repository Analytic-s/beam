<?php
/**
 * Plugin Name:       Beam Analytics
 * Plugin URI:        https://beam.keylightdigital.dev/for/wordpress
 * Description:       Privacy-first analytics for WordPress sites with no cookies and no consent banner overhead.
 * Version:           0.1.0
 * Author:            Keylight Digital LLC
 * Author URI:        https://keylightdigital.com
 * Requires at least: 6.0
 * Requires PHP:      7.4
 * License:           GPL-2.0-or-later
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:       beam-analytics
 */

if (!defined('ABSPATH')) {
    exit;
}

final class Beam_Analytics_Plugin {
    private const OPTION_SITE_ID = 'beam_analytics_site_id';
    private const OPTION_SKIP_ADMINS = 'beam_analytics_skip_admins';
    private const DEFAULT_BASE_URL = 'https://beam.keylightdigital.dev';

    public static function bootstrap(): void {
        add_action('admin_init', [self::class, 'register_settings']);
        add_action('admin_menu', [self::class, 'register_settings_page']);
        add_action('wp_head', [self::class, 'render_tracking_script'], 99);
    }

    public static function register_settings(): void {
        register_setting('beam_analytics_options', self::OPTION_SITE_ID, [
            'type' => 'string',
            'sanitize_callback' => [self::class, 'sanitize_site_id'],
            'default' => '',
        ]);

        register_setting('beam_analytics_options', self::OPTION_SKIP_ADMINS, [
            'type' => 'boolean',
            'sanitize_callback' => [self::class, 'sanitize_skip_admins'],
            'default' => 1,
        ]);

        add_settings_section(
            'beam_analytics_main',
            'Beam Tracking Configuration',
            static function (): void {
                echo '<p>Connect this WordPress site to your Beam dashboard with a Site ID.</p>';
            },
            'beam-analytics'
        );

        add_settings_field(
            self::OPTION_SITE_ID,
            'Beam Site ID',
            [self::class, 'render_site_id_field'],
            'beam-analytics',
            'beam_analytics_main'
        );

        add_settings_field(
            self::OPTION_SKIP_ADMINS,
            'Skip tracking for administrators',
            [self::class, 'render_skip_admins_field'],
            'beam-analytics',
            'beam_analytics_main'
        );
    }

    public static function register_settings_page(): void {
        add_options_page(
            'Beam Analytics',
            'Beam Analytics',
            'manage_options',
            'beam-analytics',
            [self::class, 'render_settings_page']
        );
    }

    public static function sanitize_site_id($value): string {
        $site_id = trim((string) $value);

        if ($site_id === '') {
            return '';
        }

        if (!preg_match('/^[A-Za-z0-9_-]{6,128}$/', $site_id)) {
            add_settings_error(
                self::OPTION_SITE_ID,
                'beam_analytics_invalid_site_id',
                'Site ID can contain letters, numbers, dashes, and underscores only.',
                'error'
            );

            return (string) get_option(self::OPTION_SITE_ID, '');
        }

        return $site_id;
    }

    public static function sanitize_skip_admins($value): int {
        return !empty($value) ? 1 : 0;
    }

    public static function render_site_id_field(): void {
        $site_id = (string) get_option(self::OPTION_SITE_ID, '');
        echo '<input type="text" class="regular-text" name="' . esc_attr(self::OPTION_SITE_ID) . '" value="' . esc_attr($site_id) . '" placeholder="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" />';
        echo '<p class="description">Find this in Beam under Dashboard -> Sites -> your site.</p>';
    }

    public static function render_skip_admins_field(): void {
        $checked = ((int) get_option(self::OPTION_SKIP_ADMINS, 1) === 1);
        echo '<label><input type="checkbox" name="' . esc_attr(self::OPTION_SKIP_ADMINS) . '" value="1" ' . checked($checked, true, false) . ' /> Do not track logged-in admins (recommended).</label>';
    }

    public static function render_settings_page(): void {
        if (!current_user_can('manage_options')) {
            return;
        }
        ?>
        <div class="wrap">
            <h1>Beam Analytics</h1>
            <p>Beam is a privacy-first analytics platform focused on actionable metrics without cookies.</p>
            <form action="options.php" method="post">
                <?php
                settings_fields('beam_analytics_options');
                do_settings_sections('beam-analytics');
                submit_button('Save Beam Settings');
                ?>
            </form>
            <p style="margin-top: 1rem;">
                Need a Beam account? <a href="https://beam.keylightdigital.dev/signup" target="_blank" rel="noopener noreferrer">Create one here</a>.
            </p>
        </div>
        <?php
    }

    public static function render_tracking_script(): void {
        if (is_admin()) {
            return;
        }

        $site_id = trim((string) get_option(self::OPTION_SITE_ID, ''));
        if ($site_id === '') {
            return;
        }

        $skip_admins = ((int) get_option(self::OPTION_SKIP_ADMINS, 1) === 1);
        if ($skip_admins && is_user_logged_in() && current_user_can('manage_options')) {
            return;
        }

        $base_url = apply_filters('beam_analytics_base_url', self::DEFAULT_BASE_URL);
        $normalized_base_url = rtrim((string) $base_url, '/');
        if ($normalized_base_url === '') {
            $normalized_base_url = self::DEFAULT_BASE_URL;
        }

        $script_src = esc_url($normalized_base_url . '/js/beam.js');
        $site_attr = esc_attr($site_id);

        echo "\n<!-- Beam Analytics -->\n";
        echo '<script defer src="' . $script_src . '" data-site-id="' . $site_attr . '"></script>' . "\n";
    }
}

Beam_Analytics_Plugin::bootstrap();
