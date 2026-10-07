#!/usr/bin/env bash
set -euo pipefail

TARGET="${1:-}"

if [[ -z "$TARGET" ]]; then
  echo "Usage: $0 <project-directory>"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATE="$REPO_ROOT/templates/project"

if [[ -e "$TARGET" && -n "$(ls -A "$TARGET" 2>/dev/null || true)" ]]; then
  echo "Error: target already exists and is not empty: $TARGET"
  exit 1
fi

mkdir -p "$TARGET"
cp -R "$TEMPLATE"/. "$TARGET"/

echo "Created AI Agent project architecture in: $TARGET"
echo
echo "Next:"
echo "  cd \"$TARGET\""
echo "  git init   # optional"
echo "  codex      # or another coding agent"
echo
echo "Then type:"
echo "  啟動專案"
