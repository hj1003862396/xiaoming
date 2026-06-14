#!/usr/bin/env bash
# Verification script for Xiaoming rebranding.
set -euo pipefail

echo "=== Verification Script for Xiaoming Rebranding ==="

errors=0

# 1. Check directories
check_dir() {
    if [ ! -d "$1" ]; then
        echo "❌ Directory missing: $1"
        errors=$((errors+1))
    else
        echo "✅ Directory exists: $1"
    fi
}
check_dir "skills/xiaoming"
check_dir "skills/using-xiaoming-bootstrap"
check_dir "docs/xiaoming"

# 2. Check manifests JSON validity and keys
check_manifest() {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "❌ Manifest missing: $file"
        errors=$((errors+1))
        return
    fi
    local name
    name=$(jq -r '.name' "$file")
    if [ "$name" != "xiaoming" ]; then
        echo "❌ Manifest $file 'name' key is '$name', expected 'xiaoming'"
        errors=$((errors+1))
    else
        echo "✅ Manifest $file 'name' key matches 'xiaoming'"
    fi
}
check_manifest ".cursor-plugin/plugin.json"
check_manifest ".claude-plugin/plugin.json"
check_manifest ".codex-plugin/plugin.json"
check_manifest "gemini-extension.json"

# 3. Check for dangling superpowers namespaces in skills and docs
dangling_ns=$(grep -rn "superpowers:" skills/ docs/ || true)
if [ -n "$dangling_ns" ]; then
    echo "❌ Dangling 'superpowers:' namespace references found:"
    echo "$dangling_ns"
    errors=$((errors+1))
else
    echo "✅ No dangling 'superpowers:' namespace references found."
fi

# 4. Check for old brainstorming namespace references
dangling_brainstorming=$(grep -rn "xiaoming:brainstorming" skills/ docs/ || true)
if [ -n "$dangling_brainstorming" ]; then
    echo "❌ Dangling 'xiaoming:brainstorming' references found (should be 'xiaoming:xiaoming'):"
    echo "$dangling_brainstorming"
    errors=$((errors+1))
else
    echo "✅ No dangling 'xiaoming:brainstorming' references found."
fi

# Summary
if [ "$errors" -eq 0 ]; then
    echo "🎉 Verification passed! Rebranding to Xiaoming is successful."
    exit 0
else
    echo "❌ Verification failed with $errors errors."
    exit 1
fi
