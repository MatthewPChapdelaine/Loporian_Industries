#!/usr/bin/env bash
set -euo pipefail

# Fetch Combinatorial Visual Design Engine HTML and copy into every folder
# Usage: run from repository root or pass repository path as first arg

REPO_ROOT=${1:-$(pwd)}
OUTFILE=Combinatorial_Visual_Design_Engine.html
URL="https://matthewpchapdelaine.substack.com/p/combinatorial-visual-design-engine"

cd "$REPO_ROOT"
echo "Downloading article to $OUTFILE..."
curl -L -A "Mozilla/5.0 (X11; Linux x86_64)" -fsS "$URL" -o "$OUTFILE"

if [ ! -s "$OUTFILE" ]; then
  echo "Error: downloaded file is empty" >&2
  exit 2
fi

echo "Copying $OUTFILE into every directory under $REPO_ROOT..."
find . -type d -print0 | xargs -0 -I{} cp -f "$OUTFILE" "{}/$OUTFILE"

COUNT=$(find . -type f -name "$OUTFILE" | wc -l)
echo "Done — $COUNT copies created."

echo "You can now git add/commit/push as needed."
