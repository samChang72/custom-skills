#!/usr/bin/env bash

# Read hook input from stdin
input=$(cat)

# Extract content being written using jq.
# The payload differs slightly by tool, but usually follows this structure.
# We look for "content" (write_to_file) or "replacementContent" (replace_file_content).
# We'll dump the whole input to specific fields if possible, or just grep the raw input (safest for generic catch-all).
# Note: Grepping raw input JSON might match false positives in metadata, but for secrets it's usually safer to be over-aggressive.

# Pattern for generic secrets
SECRET_PATTERN="sk-[a-zA-Z0-9]{32,}|AKIA[0-9A-Z]{16}|ghp_[a-zA-Z0-9]{36}|AIza[0-9A-Za-z-_]{35}|[0-9]+:[0-9A-Za-z_-]{35}"

if echo "$input" | grep -qE "$SECRET_PATTERN"; then
    cat <<EOF
{
  "decision": "deny",
  "reason": "Security Policy Enforcement: Potential secret detected in content (sk-*, AKIA*, ghp_*, etc.). Please remove secrets before writing.",
  "systemMessage": "Security Scanner blocked this operation."
}
EOF
    exit 0
fi

# Allow by default
echo '{"decision": "allow"}'
exit 0
