#!/bin/bash
# code-review.sh - 唯讀程式碼審查腳本
# 用法: ./code-review.sh [file|--staged|--diff-main]

set -e

# 解析參數
case "${1:-}" in
  --staged)
    CONTENT=$(git diff --staged)
    ;;
  --diff-main)
    CONTENT=$(git diff main)
    ;;
  *)
    if [ -n "$1" ] && [ -f "$1" ]; then
      CONTENT=$(cat "$1")
    else
      echo "用法: $0 [file|--staged|--diff-main]"
      exit 1
    fi
    ;;
esac

# 執行唯讀審查 (Level 1: 純分析)
echo "$CONTENT" | claude -p \
  "你是資深程式碼審查員。請審查以下內容。
   重點：Bug、安全性、效能、可讀性。
   以結構化格式回報發現。" \
  --allowedTools "Read,Grep,Glob" \
  --output-format json \
  --max-turns 5 | jq '.'
