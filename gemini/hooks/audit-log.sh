#!/usr/bin/env bash

# Trigger: BeforeTool
# Purpose: Log tool usage to audit file

input=$(cat)
AUDIT_FILE="$HOME/.gemini/audit.log"

# Get current timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Extract tool name and potential arguments
TOOL_NAME=$(echo "$input" | jq -r '.tool_name // "unknown"')
COMMAND_LINE=$(echo "$input" | jq -r '.tool_input.CommandLine // "n/a"')
TARGET_FILE=$(echo "$input" | jq -r '.tool_input.TargetFile // .tool_input.AbsolutePath // "n/a"')

# Format log entry
LOG_ENTRY="[$TIMESTAMP] Tool: $TOOL_NAME | Command: $COMMAND_LINE | File: $TARGET_FILE"

# Append to log file
echo "$LOG_ENTRY" >> "$AUDIT_FILE"

# Always allow
echo '{"decision": "allow"}'
exit 0
