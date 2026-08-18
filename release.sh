#!/usr/bin/env bash
#
# Release a new Crustdata version to this Homebrew tap.
# Builds nothing — assumes the DMG is already built locally by ../mac-app/build.sh.
#
# Usage:  ./release.sh 0.4.0
#
set -euo pipefail

VERSION="${1:?usage: ./release.sh <version>, e.g. ./release.sh 0.4.0}"
REPO="crustdata/homebrew-tap"
DMG="$HOME/Desktop/Dev/mac-app/src-tauri/target/release/bundle/dmg/Crustdata_${VERSION}_aarch64.dmg"
CASK="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/Casks/crustdata.rb"

[ -f "$DMG" ] || { echo "✖ DMG not found: $DMG (run mac-app/build.sh first)"; exit 1; }

echo "▶ Computing sha256…"
SHA="$(shasum -a 256 "$DMG" | awk '{print $1}')"
echo "  $SHA"

echo "▶ Creating GitHub release v${VERSION} with DMG asset…"
gh release create "v${VERSION}" "$DMG" \
  --repo "$REPO" \
  --title "Crustdata ${VERSION}" \
  --notes "Crustdata macOS app (Apple Silicon, unsigned). Install: brew install --cask ${REPO%/*}/tap/crustdata"

echo "▶ Updating cask version + sha256…"
/usr/bin/sed -i '' -E "s/^  version \".*\"/  version \"${VERSION}\"/" "$CASK"
/usr/bin/sed -i '' -E "s/^  sha256 \".*\"/  sha256 \"${SHA}\"/" "$CASK"

echo "▶ Committing + pushing cask…"
cd "$(dirname "$CASK")/.."
git commit -aqm "Release Crustdata ${VERSION}"
git push -q origin HEAD

echo "✓ Released v${VERSION}. Testers: brew update && brew upgrade --cask crustdata"
