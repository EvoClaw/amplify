#!/usr/bin/env bash
# SessionStart hook for amplify plugin

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" && pwd)"
PLUGIN_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

amplify_content=$(cat "${PLUGIN_ROOT}/skills/using-amplify/SKILL.md" 2>&1 || echo "Error reading using-amplify skill")

escape_for_json() {
    local s="$1"
    s="${s//\\/\\\\}"
    s="${s//\"/\\\"}"
    s="${s//$'\n'/\\n}"
    s="${s//$'\r'/\\r}"
    s="${s//$'\t'/\\t}"
    printf '%s' "$s"
}

amplify_escaped=$(escape_for_json "$amplify_content")
session_context="<EXTREMELY_IMPORTANT>\nYou have Amplify — an agentic research automation framework.\n\n**Below is the full content of your 'amplify:using-amplify' skill - your introduction to using research skills. For all other skills, use the 'Skill' tool:**\n\n${amplify_escaped}\n</EXTREMELY_IMPORTANT>"

cat <<EOF
{
  "additional_context": "${session_context}",
  "hookSpecificOutput": {
    "hookEventName": "SessionStart",
    "additionalContext": "${session_context}"
  }
}
EOF

exit 0
