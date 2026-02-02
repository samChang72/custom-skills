#!/usr/bin/env bash

# Trigger: BeforeAgent
# Purpose: Inject Git context if available

input=$(cat)

# Check if we are in a git repository
if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    # Get last 5 commits
    RECENT_LOG=$(git log -n 5 --oneline 2>/dev/null)
    
    # Get status (staged/unstaged)
    STATUS=$(git status --short 2>/dev/null)
    
    # Format the message to inject
    CONTEXT_MSG="Git Context:\nRecent Commits:\n$RECENT_LOG\n\nCurrent Status:\n$STATUS"
    
    # Escape newlines for JSON safety in a simple way or use jq to construct the object
    # Using jq to construct the JSON output safely
    jq -n --arg msg "$CONTEXT_MSG" '{
        "decision": "allow",
        "context": $msg
    }'
else
    # Not a git repo, just allow without context
    echo '{"decision": "allow"}'
fi

exit 0
