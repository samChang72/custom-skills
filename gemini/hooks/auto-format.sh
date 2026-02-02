#!/usr/bin/env bash

# Read hook input from stdin
input=$(cat)

# Extract the file path being modified.
# This depends on the tool input schema.
# Typically: .tool_input.TargetFile or .tool_input.AbsolutePath
# We use jq to handle this safely. 
# "null" is handled by the check below.
TARGET_FILE=$(echo "$input" | jq -r '.tool_input.TargetFile // .tool_input.AbsolutePath // empty')

if [ -z "$TARGET_FILE" ] || [ "$TARGET_FILE" == "null" ]; then
    # No file target found, likely an error or unrelated tool use. Allow and exit.
    exit 0
fi

# Wait a moment to ensure file write is fully flushed (rarely needed but good practice in async hooks)
sleep 0.1

if [ -f "$TARGET_FILE" ]; then
    # Try to use local project prettier if available, else global, else skip.
    # We navigate to the directory of the file to respect local .prettierrc
    FILE_DIR=$(dirname "$TARGET_FILE")
    FILE_NAME=$(basename "$TARGET_FILE")
    
    cd "$FILE_DIR" || exit 0
    
    if npx --no-install prettier --check "$FILE_NAME" &> /dev/null; then
         # Prettier supports this file and it might need formatting
         # We run write to fix it.
         npx --no-install prettier --write "$FILE_NAME" &> /dev/null
    elif command -v prettier &> /dev/null; then
         # Fallback to global prettier if npx fails (e.g. not a node project)
         prettier --write "$TARGET_FILE" &> /dev/null
    fi
fi

# Always exit 0, we don't want to fail the agent just because formatting failed.
exit 0
