#!/bin/bash
# session-chain.sh - Session 串接範例
# 用法: ./session-chain.sh "初始任務"
# 展示如何在多步驟任務中保持對話上下文

set -e

INITIAL_TASK="${1:-分析專案架構}"

echo "📋 Session 串接範例"
echo "   初始任務: $INITIAL_TASK"
echo ""

# 步驟 1: 執行初始任務，取得 session_id
echo "🔹 步驟 1: 執行分析..."
RESULT=$(claude -p "$INITIAL_TASK" \
  --allowedTools "Read,Grep,Glob" \
  --output-format json)

SESSION_ID=$(echo "$RESULT" | jq -r '.session_id')
echo "   Session ID: $SESSION_ID"
echo ""

# 顯示第一步結果
echo "🔹 步驟 1 結果:"
echo "$RESULT" | jq -r '.result' | head -20
echo "..."
echo ""

# 步驟 2: 延續對話，深入分析
echo "🔹 步驟 2: 延續對話，請求詳細建議..."
claude -p "基於剛才的分析，提供具體的改進建議" \
  --resume "$SESSION_ID" \
  --allowedTools "Read,Grep,Glob" \
  --output-format json | jq -r '.result'
