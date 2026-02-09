#!/bin/bash
# auto-fix.sh - 自動修復腳本（含成本控制）
# 用法: ./auto-fix.sh "修復描述"

set -e

TASK="${1:-修復所有 lint 錯誤}"
MAX_BUDGET="${MAX_BUDGET:-2.00}"
MAX_TURNS="${MAX_TURNS:-10}"

echo "🔧 執行自動修復任務..."
echo "   任務: $TASK"
echo "   預算上限: \$$MAX_BUDGET"
echo "   回合上限: $MAX_TURNS"
echo ""

# 執行修復 (Level 3: 讀寫修改)
claude -p "$TASK" \
  --allowedTools "Read,Edit,Write" \
  --max-turns "$MAX_TURNS" \
  --max-budget-usd "$MAX_BUDGET" \
  --fallback-model haiku \
  --output-format json | jq '.'
