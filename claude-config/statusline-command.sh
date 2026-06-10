#!/bin/sh
input=$(cat)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
worktree_name=$(echo "$input" | jq -r '.worktree.name // empty')
worktree_branch=$(echo "$input" | jq -r '.worktree.branch // empty')

# Shorten path to last 2-3 segments
short_path=$(echo "$cwd" | awk -F'/' '{
  n = NF
  if (n >= 3) {
    print $(n-2) "/" $(n-1) "/" $n
  } else if (n == 2) {
    print $(n-1) "/" $n
  } else {
    print $n
  }
}')

# Get git branch (skip locks for safety)
branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)

# Build output
out=""

# Directory segment
if [ -n "$short_path" ]; then
  out="$short_path"
fi

# Git branch segment
if [ -n "$branch" ]; then
  out="$out  $branch"
fi

# Worktree indicator (prefer branch from worktree data, fallback to name)
if [ -n "$worktree_branch" ]; then
  out="$out  [worktree: $worktree_branch]"
elif [ -n "$worktree_name" ]; then
  out="$out  [worktree: $worktree_name]"
fi

echo "$out"
