#!/usr/bin/env bash
# Run all skill triggering tests.
# These are reference prompts for manual verification.
# Each prompt file documents expected skill activation and behavior.
#
# Usage:
#   ./run-all.sh          — list all test prompts with expectations
#   ./run-all.sh --detail — show full prompt content

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"

DETAIL=false
if [ "${1:-}" = "--detail" ]; then
    DETAIL=true
fi

echo "========================================"
echo " Skill Triggering Test Prompts"
echo "========================================"
echo
echo "These prompts are for manual testing in Cursor."
echo "Start a new chat with the plugin active, paste the prompt,"
echo "and verify the agent behaves as documented."
echo

count=0
for prompt_file in "$PROMPTS_DIR"/*.txt; do
    name=$(basename "$prompt_file" .txt)
    expected_skill=$(grep '^# Expected skill:' "$prompt_file" | sed 's/^# Expected skill: *//')
    expected_behavior=$(grep '^# Expected behavior:' "$prompt_file" | sed 's/^# Expected behavior: *//')

    count=$((count + 1))
    echo "--- Test $count: $name ---"
    echo "  Skill:    $expected_skill"
    echo "  Behavior: $expected_behavior"

    if $DETAIL; then
        echo "  Prompt:"
        grep -v '^#' "$prompt_file" | sed '/^$/d' | sed 's/^/    /'
    fi
    echo
done

echo "========================================"
echo " Total: $count test prompts"
echo "========================================"
echo
echo "To run manually:"
echo "  1. Open Cursor with amplify plugin active"
echo "  2. Start a new chat"
echo "  3. Paste a prompt from tests/skill-triggering/prompts/"
echo "  4. Verify the agent activates the expected skill"
echo "  5. Verify the expected behavior matches"
