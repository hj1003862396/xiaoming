#!/usr/bin/env bash
# Copy this checkout into ~/.gemini/config/plugins/xiaoming for Antigravity local testing.
#
# Usage:
#   ./scripts/sync-to-antigravity-local.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
DEST="${HOME}/.gemini/config/plugins/xiaoming"

mkdir -p "${HOME}/.gemini/config/plugins"

if [ -L "${DEST}" ] || [ -d "${DEST}" ]; then
  rm -rf "${DEST}"
fi

# 1. Sync the core plugin content
rsync -a --delete \
  --exclude='.git/' \
  --exclude='.idea/' \
  --exclude='node_modules/' \
  --exclude='tests/brainstorm-server/node_modules/' \
  "${PLUGIN_ROOT}/" "${DEST}/"

# 2. Copy the plugin metadata files to the destination root folder
cp "${PLUGIN_ROOT}/.antigravity-plugin/plugin.json" "${DEST}/plugin.json"
cp "${PLUGIN_ROOT}/.antigravity-plugin/installed_version.json" "${DEST}/installed_version.json"

echo "Synced xiaoming to ${DEST}"
