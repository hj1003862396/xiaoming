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

if [ ! -f "commands/xiaoming.md" ]; then
    echo "❌ Slash command missing: commands/xiaoming.md"
    errors=$((errors+1))
else
    echo "✅ Slash command exists: commands/xiaoming.md"
fi

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

if [ -f "scripts/sync-to-cursor-local.sh" ] && [ -x "scripts/sync-to-cursor-local.sh" ]; then
    echo "✅ Cursor local sync script exists and is executable"
else
    echo "❌ Missing or non-executable scripts/sync-to-cursor-local.sh"
    errors=$((errors+1))
fi

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

# 5. Check for stale skills/brainstorming paths in active code
stale_paths=$(grep -rn "skills/brainstorming" skills/ tests/ .github/ .opencode/ hooks/ scripts/ 2>/dev/null | grep -v 'scripts/verify-xiaoming.sh' || true)
if [ -n "$stale_paths" ]; then
    echo "❌ Stale 'skills/brainstorming' path references found:"
    echo "$stale_paths"
    errors=$((errors+1))
else
    echo "✅ No stale 'skills/brainstorming' path references found."
fi

# 6. Check for stale using-superpowers references in active code
stale_bootstrap=$(grep -rn "using-superpowers" skills/ tests/ .github/ .opencode/ hooks/ scripts/ 2>/dev/null | grep -v 'scripts/verify-xiaoming.sh' || true)
if [ -n "$stale_bootstrap" ]; then
    echo "❌ Stale 'using-superpowers' references found:"
    echo "$stale_bootstrap"
    errors=$((errors+1))
else
    echo "✅ No stale 'using-superpowers' references found."
fi

# 7. Check OpenCode plugin loads the correct bootstrap skill path
if grep -q "using-xiaoming/SKILL.md" .opencode/plugins/xiaoming.js 2>/dev/null; then
    echo "❌ OpenCode plugin still references missing using-xiaoming/SKILL.md"
    errors=$((errors+1))
else
    echo "✅ OpenCode plugin references using-xiaoming-bootstrap."
fi

# Summary
if [ "$errors" -eq 0 ]; then
    echo "🎉 Verification passed! Rebranding to Xiaoming is successful."
    exit 0
else
    echo "❌ Verification failed with $errors errors."
    exit 1
fi
