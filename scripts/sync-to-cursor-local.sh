#!/usr/bin/env bash
# Copy this checkout into ~/.cursor/plugins/local/xiaoming-brainstorming for Cursor local testing.
#
# Cursor rejects symlinks that point outside ~/.cursor/plugins/local/ (security
# validation). Use this script after editing the repo, then Reload Window.
#
# Usage:
#   ./scripts/sync-to-cursor-local.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
DEST="${HOME}/.cursor/plugins/local/xiaoming"

mkdir -p "${HOME}/.cursor/plugins/local"

if [ -L "${DEST}" ] || [ -d "${DEST}" ]; then
  rm -rf "${DEST}"
fi

rsync -a --delete \
  --exclude='.git/' \
  --exclude='.idea/' \
  --exclude='node_modules/' \
  --exclude='tests/brainstorm-server/node_modules/' \
  "${PLUGIN_ROOT}/" "${DEST}/"

echo "Synced xiaoming to ${DEST}"
echo "Next: Cmd+Shift+P → Developer: Reload Window"
echo "Then: Cursor Settings → Plugins → enable Xiaoming (disable Superpowers if both show)"
