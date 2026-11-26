---
name: dual-code-review
description: Orchestrate a comprehensive code review process involving both Gemini (Antigravity) and Claude CLI, synthesizing a consensus report.
---

# Dual Code Review Protocol

透過 Gemini 與 Claude CLI 的雙重審查，產出高可信度的程式碼審查報告。

## 決策流程圖

```mermaid
flowchart TD
    START([開始審查]) --> SCOPE[確定審查範圍]
    SCOPE --> PARALLEL{平行分析}
    
    PARALLEL --> GEMINI[Antigravity 分析<br/>agy-yolo -p]
    PARALLEL --> CLAUDE[Claude CLI 分析]
    
    GEMINI --> COLLECT[收集兩方結果]
    CLAUDE --> COLLECT
    
    COLLECT --> COMPARE{比對發現}
    
    COMPARE -->|雙方都發現| CONFIRMED[✅ Double Verified]
    COMPARE -->|僅 Claude 發現| VERIFY_C{驗證 Claude 發現}
    COMPARE -->|僅 Gemini 發現| VERIFY_G{驗證 Gemini 發現}
    
    VERIFY_C -->|有效| ACCEPT_C[接受並標記]
    VERIFY_C -->|幻覺| DISCARD_C[捨棄]
    VERIFY_G -->|有效| ACCEPT_G[接受並標記]
    
    CONFIRMED --> REPORT[產出報告]
    ACCEPT_C --> REPORT
    ACCEPT_G --> REPORT
    DISCARD_C --> REPORT
    
    REPORT --> DONE([完成])
```

## Workflow

### 1. 確定審查範圍

```bash
# 選項 A: 暫存區變更
git diff --staged > /tmp/review_content.txt

# 選項 B: 與 main 分支比較
git diff main > /tmp/review_content.txt

# 選項 C: 特定檔案
cat src/auth/*.ts > /tmp/review_content.txt
```

### 2. 雙重分析

#### A. Claude CLI 分析（使用管道模式）

```bash
# 唯讀審查，強制 JSON 輸出
cat /tmp/review_content.txt | claude -p \
  "你是資深程式碼審查員。請審查以下程式碼變更。
   重點關注：Bug、安全性、效能、可讀性。
   以 JSON 格式回傳發現。" \
  --output-format json \
  --json-schema '{
    "type": "object",
    "properties": {
      "findings": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "severity": {"type": "string", "enum": ["High", "Medium", "Low"]},
            "category": {"type": "string"},
            "file": {"type": "string"},
            "line": {"type": "integer"},
            "message": {"type": "string"},
            "suggestion": {"type": "string"}
          },
          "required": ["severity", "category", "message"]
        }
      },
      "summary": {"type": "string"}
    }
  }' \
  --allowedTools "Read,Grep,Glob" \
  --max-turns 5 | jq '.structured_output' > /tmp/claude_review.json
```

#### B. Antigravity（Gemini）分析

用 `agy-yolo` 叫 Gemini 獨立審查，和 A 同時跑（兩個指令都丟背景），兩邊都跑完才互相比對，以維持獨立性。

- `agy-yolo` 是 `~/.zshrc` 裡的 alias，等於 `agy --dangerously-skip-permissions`。腳本／非互動 shell 不會展開 alias，所以指令裡**寫完整的 `agy --dangerously-skip-permissions`**。
- `agy -p` **不讀 stdin**：用管線（`|`）傳 diff 會被忽略，Gemini 會回「沒收到程式碼」。diff 要用 `$(cat ...)` 直接放進 prompt。
- diff 很大（超過約 100KB）時，改成在 prompt 裡寫檔案路徑，請 Gemini 自己讀 `/tmp/review_content.txt`。
- yolo 模式下 Gemini 可以改檔、跑指令，所以 prompt 一定要寫「只讀不改任何檔案」。

```bash
agy --dangerously-skip-permissions -p "你是資深程式碼審查員。只讀不改任何檔案。
請審查以下程式碼變更，重點關注：Bug、安全性、效能、可讀性。以 JSON 回傳發現。
--- CODE START ---
$(cat /tmp/review_content.txt)
--- CODE END ---" \
  --output-format json \
  --json-schema '{
    "type": "object",
    "properties": {
      "findings": {
        "type": "array",
        "items": {
          "type": "object",
          "properties": {
            "severity": {"type": "string", "enum": ["High", "Medium", "Low"]},
            "category": {"type": "string"},
            "file": {"type": "string"},
            "line": {"type": "integer"},
            "message": {"type": "string"},
            "suggestion": {"type": "string"}
          },
          "required": ["severity", "category", "message"]
        }
      },
      "summary": {"type": "string"}
    },
    "required": ["findings", "summary"]
  }' \
  --print-timeout 300s | jq '.structured_output' > /tmp/gemini_review.json
```

> 從 Antigravity 本身跑這個 skill 時，Gemini 就是執行者自己，不必再呼叫 `agy`，直接自己審查即可。

### 3. 共識與綜合

**評估邏輯：**

| 情況 | 處理方式 | 標籤 |
|------|---------|------|
| 雙方都發現相同問題 | 確認為高可信度問題 | `[Double Verified]` |
| 僅 Claude 發現 | 驗證是否為幻覺，有效則接受 | `[Claude CLI Detected]` |
| 僅 Gemini 發現 | 再次確認，有效則保留 | `[Antigravity Detected]` |

### 4. 產出報告

**報告結構：**

```markdown
# Code Review Report

## Summary
- **Status**: Pass / Request Changes
- **Files Reviewed**: X
- **Issues Found**: High: X, Medium: X, Low: X

## Consensus Highlights
> 雙方一致認為的關鍵問題

## Detailed Findings

### 🔴 High Severity
| Issue | File | Line | Source |
|-------|------|------|--------|
| ... | ... | ... | [Double Verified] |

### 🟡 Medium Severity
...

### 🟢 Low Severity
...

## Actionable Advice
1. 修復步驟...
```

## 兩階段執行（先審查後修復）

```bash
# 階段一：唯讀審查
review=$(git diff --staged | claude -p \
  "審查這些變更，列出所有問題" \
  --allowedTools "Read,Grep,Glob" \
  --output-format json)

# 階段二：自動修復（需人工確認）
echo "$review" | jq -r '.result' | claude -p \
  "依照以下審查結果修復問題：$(cat)" \
  --allowedTools "Read,Edit,Write" \
  --max-turns 10
```

## 觸發條件

當使用者提及以下關鍵字時啟用此技能：
- "Dual Review" / "雙重審查"
- "Double Check" / "雙重檢查"
- "Mutual Review" / "交叉審查"
- "Review Process" / "審查流程"
