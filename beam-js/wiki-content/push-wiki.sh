#!/bin/bash
# Push wiki pages to GitHub after Steve initializes the wiki via web UI
# Steve: visit https://github.com/scobb/beam.js/wiki/new, create "Home" page with any content, then run this script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WIKI_DIR="/tmp/beam-wiki-push"

# Source env for GITHUB_TOKEN
if [ -f "$(dirname "$SCRIPT_DIR")/../.env" ]; then
  source "$(dirname "$SCRIPT_DIR")/../.env" 2>/dev/null || true
fi
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN not set. Source .env first."
  exit 1
fi

echo "Cloning wiki repo..."
rm -rf "$WIKI_DIR"
git clone "https://x-access-token:${GITHUB_TOKEN}@github.com/scobb/beam.js.wiki.git" "$WIKI_DIR"

echo "Copying wiki pages..."
cp "$SCRIPT_DIR/Home.md" "$WIKI_DIR/Home.md"
cp "$SCRIPT_DIR/Getting-Started.md" "$WIKI_DIR/Getting-Started.md"
cp "$SCRIPT_DIR/Privacy-Design.md" "$WIKI_DIR/Privacy-Design.md"
cp "$SCRIPT_DIR/API-Reference.md" "$WIKI_DIR/API-Reference.md"
cp "$SCRIPT_DIR/Comparison-with-Alternatives.md" "$WIKI_DIR/Comparison-with-Alternatives.md"

cd "$WIKI_DIR"
git config user.email "ralph@keylightdigital.com"
git config user.name "Ralph"
git add -A
git commit -m "Add Getting Started, Privacy Design, API Reference, Comparison with Alternatives wiki pages"
git push origin master

echo ""
echo "Wiki pages pushed successfully!"
echo "View at: https://github.com/scobb/beam.js/wiki"
