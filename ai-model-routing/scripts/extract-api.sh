#!/bin/bash
# extract-api.sh - API 端點提取腳本（結構化輸出）
# 用法: ./extract-api.sh [directory]

set -e

DIR="${1:-.}"

echo "🔍 掃描 $DIR 中的 API 端點..."

# 使用 JSON Schema 強制結構化輸出
claude -p "掃描 $DIR 目錄，提取所有 API endpoint 及其 HTTP method" \
  --allowedTools "Read,Grep,Glob" \
  --output-format json \
  --json-schema '{
    "type": "object",
    "properties": {
      "endpoints": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "method": {"type": "string"},
            "path": {"type": "string"},
            "file": {"type": "string"},
            "line": {"type": "integer"},
            "description": {"type": "string"}
          },
          "required": ["method", "path"]
        }
      },
      "total_count": {"type": "integer"}
    },
    "required": ["endpoints"]
  }' \
  --max-turns 5 | jq '.structured_output'
