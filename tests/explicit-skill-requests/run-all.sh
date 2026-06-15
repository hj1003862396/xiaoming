#!/usr/bin/env bash
# Run all explicit skill request tests
# Usage: ./run-all.sh

set -eo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"

echo "=== Running All Explicit Skill Request Tests ==="
echo ""

PASSED=0
FAILED=0
RESULTS=""

# Test: xiaoming-subagent-driven-development, please
echo ">>> Test 1: subagent-driven-development-please"
if "$SCRIPT_DIR/run-test.sh" "xiaoming-subagent-driven-development" "$PROMPTS_DIR/xiaoming-subagent-driven-development-please.txt"; then
    PASSED=$((PASSED + 1))
    RESULTS="$RESULTS\nPASS: subagent-driven-development-please"
else
    FAILED=$((FAILED + 1))
    RESULTS="$RESULTS\nFAIL: subagent-driven-development-please"
fi
echo ""

# Test: use xiaoming-systematic-debugging
echo ">>> Test 2: use-systematic-debugging"
if "$SCRIPT_DIR/run-test.sh" "xiaoming-systematic-debugging" "$PROMPTS_DIR/use-xiaoming-systematic-debugging.txt"; then
    PASSED=$((PASSED + 1))
    RESULTS="$RESULTS\nPASS: use-systematic-debugging"
else
    FAILED=$((FAILED + 1))
    RESULTS="$RESULTS\nFAIL: use-systematic-debugging"
fi
echo ""

# Test: please use xiaoming-brainstorming
echo ">>> Test 3: please-use-xiaoming"
if "$SCRIPT_DIR/run-test.sh" "xiaoming-brainstorming" "$PROMPTS_DIR/please-use-xiaoming-brainstorming.txt"; then
    PASSED=$((PASSED + 1))
    RESULTS="$RESULTS\nPASS: please-use-xiaoming"
else
    FAILED=$((FAILED + 1))
    RESULTS="$RESULTS\nFAIL: please-use-xiaoming"
fi
echo ""

# Test: mid-conversation execute plan
echo ">>> Test 4: mid-conversation-execute-plan"
if "$SCRIPT_DIR/run-test.sh" "xiaoming-subagent-driven-development" "$PROMPTS_DIR/mid-conversation-execute-plan.txt"; then
    PASSED=$((PASSED + 1))
    RESULTS="$RESULTS\nPASS: mid-conversation-execute-plan"
else
    FAILED=$((FAILED + 1))
    RESULTS="$RESULTS\nFAIL: mid-conversation-execute-plan"
fi
echo ""

echo "=== Summary ==="
echo -e "$RESULTS"
echo ""
echo "Passed: $PASSED"
echo "Failed: $FAILED"
echo "Total: $((PASSED + FAILED))"

if [ "$FAILED" -gt 0 ]; then
    exit 1
fi
