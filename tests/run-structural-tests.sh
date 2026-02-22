#!/usr/bin/env bash
# Structural integrity tests for Amplify
# Verifies plugin structure, frontmatter, cross-references, and templates.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGIN_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

PASS=0
FAIL=0

pass() { echo "  [PASS] $1"; PASS=$((PASS + 1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL + 1)); }

echo "========================================"
echo " Structural Integrity Tests"
echo " Plugin: $PLUGIN_ROOT"
echo "========================================"
echo

# --- Test 1: plugin.json valid ---
echo "Test 1: plugin.json is valid JSON"
if python3 -c "import json; json.load(open('$PLUGIN_ROOT/.cursor-plugin/plugin.json'))" 2>/dev/null; then
    pass "plugin.json parses as valid JSON"
else
    fail "plugin.json is not valid JSON"
fi

# --- Test 2: hooks.json valid ---
echo "Test 2: hooks.json is valid JSON"
if python3 -c "import json; json.load(open('$PLUGIN_ROOT/hooks/hooks.json'))" 2>/dev/null; then
    pass "hooks.json parses as valid JSON"
else
    fail "hooks.json is not valid JSON"
fi

# --- Test 3: session-start.sh executable and valid ---
echo "Test 3: session-start.sh is executable and has valid syntax"
if [ -x "$PLUGIN_ROOT/hooks/session-start.sh" ]; then
    pass "session-start.sh is executable"
else
    fail "session-start.sh is not executable"
fi
if bash -n "$PLUGIN_ROOT/hooks/session-start.sh" 2>/dev/null; then
    pass "session-start.sh has valid bash syntax"
else
    fail "session-start.sh has syntax errors"
fi

# --- Test 4: session-start.sh produces valid JSON ---
echo "Test 4: session-start.sh produces valid JSON output"
if CLAUDE_PLUGIN_ROOT="$PLUGIN_ROOT" bash "$PLUGIN_ROOT/hooks/session-start.sh" 2>/dev/null | python3 -c "import sys,json; json.load(sys.stdin)" 2>/dev/null; then
    pass "session-start.sh output is valid JSON"
else
    fail "session-start.sh output is not valid JSON"
fi

# --- Test 5: All skills have SKILL.md with YAML frontmatter ---
echo "Test 5: All skill directories contain SKILL.md with YAML frontmatter"
for dir in "$PLUGIN_ROOT"/skills/*/; do
    skill=$(basename "$dir")
    if [ ! -f "$dir/SKILL.md" ]; then
        fail "$skill: missing SKILL.md"
        continue
    fi
    if head -1 "$dir/SKILL.md" | grep -q "^---"; then
        pass "$skill: has YAML frontmatter"
    else
        fail "$skill: missing YAML frontmatter"
    fi
done

# --- Test 6: SKILL.md name matches directory name ---
echo "Test 6: SKILL.md 'name' field matches directory name"
for dir in "$PLUGIN_ROOT"/skills/*/; do
    skill=$(basename "$dir")
    name=$(grep '^name:' "$dir/SKILL.md" 2>/dev/null | head -1 | sed 's/name: *//')
    if [ "$name" = "$skill" ]; then
        pass "$skill: name field matches"
    else
        fail "$skill: name='$name' does not match directory '$skill'"
    fi
done

# --- Test 7: Commands have YAML frontmatter ---
echo "Test 7: Commands have YAML frontmatter"
for cmd_file in "$PLUGIN_ROOT"/commands/*.md; do
    cmd=$(basename "$cmd_file")
    if head -1 "$cmd_file" | grep -q "^---"; then
        pass "$cmd: has YAML frontmatter"
    else
        fail "$cmd: missing YAML frontmatter"
    fi
done

# --- Test 8: Agents have YAML frontmatter ---
echo "Test 8: Agents have YAML frontmatter"
for agent_file in "$PLUGIN_ROOT"/agents/*.md; do
    agent=$(basename "$agent_file")
    if head -1 "$agent_file" | grep -q "^---"; then
        pass "$agent: has YAML frontmatter"
    else
        fail "$agent: missing YAML frontmatter"
    fi
done

# --- Test 9: YAML templates parse correctly ---
echo "Test 9: YAML templates parse correctly"
for tmpl in "$PLUGIN_ROOT"/templates/*.yaml; do
    name=$(basename "$tmpl")
    if python3 -c "import yaml; yaml.safe_load(open('$tmpl'))" 2>/dev/null; then
        pass "$name: valid YAML"
    else
        fail "$name: invalid YAML"
    fi
done

# --- Test 10: Cross-references resolve ---
echo "Test 10: All amplify: cross-references resolve to existing skills"
refs=$(grep -roh 'amplify:[a-z_-]*' "$PLUGIN_ROOT/skills/" 2>/dev/null | sort -u)
for ref in $refs; do
    skill_name="${ref#amplify:}"
    if [ -d "$PLUGIN_ROOT/skills/$skill_name" ]; then
        pass "reference $ref resolves"
    else
        fail "reference $ref does NOT resolve (skills/$skill_name/ not found)"
    fi
done

# --- Test 11: Expected skill count ---
echo "Test 11: Skill count matches design (23 skills)"
skill_count=$(find "$PLUGIN_ROOT/skills" -maxdepth 1 -mindepth 1 -type d | wc -l | tr -d ' ')
if [ "$skill_count" -eq 23 ]; then
    pass "23 skill directories found"
else
    fail "Expected 23 skill directories, found $skill_count"
fi

# --- Test 12: Expected command count ---
echo "Test 12: Command count matches design (4 commands)"
cmd_count=$(find "$PLUGIN_ROOT/commands" -name "*.md" | wc -l | tr -d ' ')
if [ "$cmd_count" -eq 4 ]; then
    pass "4 command files found"
else
    fail "Expected 4 commands, found $cmd_count"
fi

# --- Test 13: Expected agent count ---
echo "Test 13: Agent count matches design (3 agents)"
agent_count=$(find "$PLUGIN_ROOT/agents" -name "*.md" | wc -l | tr -d ' ')
if [ "$agent_count" -eq 3 ]; then
    pass "3 agent files found"
else
    fail "Expected 3 agents, found $agent_count"
fi

# --- Summary ---
echo
echo "========================================"
echo " Test Summary"
echo "========================================"
echo
echo "  Passed: $PASS"
echo "  Failed: $FAIL"
echo "  Total:  $((PASS + FAIL))"
echo
if [ "$FAIL" -eq 0 ]; then
    echo "  STATUS: ALL PASSED"
    exit 0
else
    echo "  STATUS: $FAIL FAILURE(S)"
    exit 1
fi
