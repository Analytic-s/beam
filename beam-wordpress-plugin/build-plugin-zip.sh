#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_DIR="$ROOT_DIR/beam-analytics"
OUTPUT_ZIP="$ROOT_DIR/beam-analytics.zip"

if ! command -v zip >/dev/null 2>&1; then
  echo "zip command is required but not installed."
  exit 1
fi

if [ ! -d "$PLUGIN_DIR" ]; then
  echo "Plugin directory not found: $PLUGIN_DIR"
  exit 1
fi

rm -f "$OUTPUT_ZIP"

(
  cd "$ROOT_DIR"
  zip -r "$OUTPUT_ZIP" beam-analytics -x "*/.DS_Store" "*/__MACOSX/*"
)

echo "Created $OUTPUT_ZIP"
