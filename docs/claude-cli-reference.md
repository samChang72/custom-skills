# Claude Code CLI 外部調用技術文件

## 1. 概述

Claude Code CLI (`claude`) 提供三種主要執行模式，適用於不同場景：

| 模式 | 啟動方式 | 用途 |
|------|---------|------|
| **互動模式** | `claude` / `claude "prompt"` | 日常開發、多輪對話 |
| **列印模式** | `claude -p "prompt"` | 自動化、CI/CD、腳本整合 |
| **管道模式** | `echo "data" \| claude -p "prompt"` | 串接 Unix 工具鏈 |

---

## 2. 三種模式詳細比較

### 2.1 互動模式

```bash
claude                      # 啟動空白 REPL
claude "解釋這個專案"        # 帶初始提示詞進入 REPL
claude -c                   # 繼續最近一次對話
claude -r "session-name"    # 恢復指定 session
```

**特性：**

- 支援多輪對話、工具權限提示、Plan Mode
- 會話自動持久化，可用 `-c` / `-r` 恢復
- 支援斜線命令（`/commit`、`/mcp` 等）

### 2.2 列印模式 (`-p`)

```bash
claude -p "分析這個專案架構"
claude -p "修復 lint 錯誤" --max-turns 10
claude -p "審查程式碼" --output-format json
```

**特性：**

- 執行完畢即退出，不進入 REPL
- **無權限提示** — 需用 `--allowedTools` 預先授權
- **不支援 Plan Mode**（Plan Mode 需要使用者互動確認）
- 跳過工作區信任對話框

### 2.3 管道模式

```bash
cat error.log | claude -p "解釋這個錯誤"
git diff | claude -p "審查這些變更" --output-format json
npm run build 2>&1 | claude -p "摘要失敗原因"
```

**特性：**

- stdin 內容自動併入對話上下文
- 本質上是列印模式的變體，所有 `-p` 旗標皆適用

### 2.4 差異對照表

| 特性 | 互動模式 | 列印模式 (`-p`) | 管道模式 |
|------|---------|----------------|---------|
| 多輪對話 | ✅ | ❌ | ❌ |
| 權限提示 | ✅ | ❌ | ❌ |
| Plan Mode | ✅ | ❌ | ❌ |
| stdin 輸入 | ❌ | ✅ | ✅ |
| 輸出格式控制 | ❌ | ✅ | ✅ |
| 會話持久化 | ✅ 預設開啟 | 可選 | 可選 |
| 斜線命令 | ✅ | ❌ | ❌ |
| 適用 CI/CD | ❌ | ✅ | ✅ |
| `--max-turns` | ❌ | ✅ | ✅ |
| `--max-budget-usd` | ❌ | ✅ | ✅ |
| `--fallback-model` | ❌ | ✅ | ✅ |

---

## 3. 輸出格式 (`--output-format`)

僅適用於列印模式 (`-p`)。

### 3.1 `text`（預設）

```bash
claude -p "解釋 recursion"
# 輸出：純文字回應
```

### 3.2 `json`

```bash
claude -p "摘要專案" --output-format json
```

回傳結構：

```json
{
  "result": "回應文字...",
  "session_id": "abc123",
  "usage": {
    "input_tokens": 150,
    "output_tokens": 200
  }
}
```

### 3.3 `stream-json`

```bash
claude -p "解釋 recursion" \
  --output-format stream-json \
  --verbose \
  --include-partial-messages
```

每行一個 JSON 事件，適合即時串流處理：

```json
{"type":"message_start","message":{"id":"msg_123"}}
{"type":"stream_event","event":{"delta":{"type":"text_delta","text":"Recursion 是"}}}
```

### 3.4 結構化輸出 (`--json-schema`)

```bash
claude -p "提取所有函式名稱" \
  --output-format json \
  --json-schema '{
    "type": "object",
    "properties": {
      "functions": {"type": "array", "items": {"type": "string"}}
    },
    "required": ["functions"]
  }'
```

回傳 `structured_output` 欄位，保證符合指定 Schema。

---

## 4. 工具權限控制

### 4.1 `--allowedTools`（允許清單）

```bash
# 僅允許讀取操作（安全審查）
claude -p "審查程式碼安全性" --allowedTools "Read,Grep,Glob"

# 允許讀寫（自動修復）
claude -p "修復所有 lint 錯誤" --allowedTools "Read,Edit,Bash"

# 精細控制 Bash 命令（glob 匹配語法）
claude -p "建立 commit" \
  --allowedTools "Bash(git diff *),Bash(git log *),Bash(git status *),Bash(git commit *)"
```

### 4.2 `--disallowedTools`（禁止清單）

```bash
# 從模型上下文中完全移除指定工具
claude -p "分析程式碼" --disallowedTools "Bash(rm *),Bash(git push *)"
```

### 4.3 `--tools`（限制可用工具集）

```bash
# 僅提供特定工具
claude -p "分析" --tools "Read,Grep,Glob"

# 停用所有工具
claude -p "回答問題" --tools ""
```

**差異：**

- `--allowedTools`：自動核准（不需權限提示）
- `--disallowedTools`：完全移除（模型看不到該工具）
- `--tools`：限制可用工具的完整集合

---

## 5. 模型與成本控制

```bash
# 指定模型（別名）
claude -p "query" --model sonnet
claude -p "query" --model opus
claude -p "query" --model haiku

# 指定模型（完整名稱）
claude -p "query" --model claude-sonnet-4-5-20250929

# 過載時自動回退
claude -p "query" --fallback-model haiku

# 設定花費上限（美元）
claude -p "query" --max-budget-usd 5.00

# 限制最大回合數
claude -p "query" --max-turns 10
```

---

## 6. 系統提示自訂

| 旗標 | 行為 | 適用模式 |
|------|------|---------|
| `--system-prompt "..."` | **取代**整個預設系統提示 | 互動 + 列印 |
| `--system-prompt-file <path>` | 從檔案**取代** | 僅列印 |
| `--append-system-prompt "..."` | **附加**至預設提示 | 互動 + 列印 |
| `--append-system-prompt-file <path>` | 從檔案**附加** | 僅列印 |

```bash
# 取代（完全控制行為）
claude -p "query" --system-prompt "你是 Python 安全專家"

# 附加（推薦，保留預設能力）
claude -p "query" --append-system-prompt "務必使用 TypeScript 並加上 JSDoc"

# 從檔案載入（可重複使用）
claude -p "query" --system-prompt-file ./custom-prompt.txt
```

---

## 7. 會話管理

```bash
# 繼續最近對話
claude -c

# 恢復指定 session
claude -r "session-name"
claude --resume "session-id"

# 恢復但建立新 session（fork）
claude --resume abc123 --fork-session

# 恢復與 PR 連結的 session
claude --from-pr 123

# 指定 session ID
claude --session-id "550e8400-e29b-41d4-a716-446655440000"

# 列印模式下串接 session
session_id=$(claude -p "分析 auth.py" --output-format json | jq -r '.session_id')
claude -p "現在關注安全問題" --resume "$session_id"

# 停用會話持久化
claude -p "query" --no-session-persistence
```

---

## 8. CI/CD 整合範例

### 8.1 GitHub Actions

```yaml
name: Claude Code Review
on:
  pull_request:
    types: [opened, synchronize]

jobs:
  review:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: anthropics/claude-code-action@v1
        with:
          anthropic_api_key: ${{ secrets.ANTHROPIC_API_KEY }}
```

### 8.2 自訂腳本

```bash
#!/bin/bash
# code-review.sh - 自動程式碼審查

git diff main | claude -p \
  --append-system-prompt "你是資深工程師，審查安全性與程式碼品質" \
  --output-format json \
  --allowedTools "Read,Grep,Glob" \
  --max-turns 5 | jq -r '.result'
```

### 8.3 兩階段執行（先計畫再實作）

```bash
# 階段一：產出計畫（只讀）
claude -p "分析並規劃如何實作快取機制，只輸出計畫" \
  --allowedTools "Read,Grep,Glob" \
  --output-format json | jq -r '.result' > plan.txt

# 人工審核 plan.txt ...

# 階段二：依照計畫執行
claude -p "依照以下計畫實作：$(cat plan.txt)" \
  --allowedTools "Read,Edit,Write,Bash" \
  --max-turns 20
```

### 8.4 結構化資料提取

```bash
claude -p "提取所有 API endpoint 及其 HTTP method" \
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
            "description": {"type": "string"}
          }
        }
      }
    }
  }' | jq '.structured_output'
```

---

## 9. MCP 伺服器配置

```bash
# 新增 HTTP 伺服器
claude mcp add --transport http notion https://mcp.notion.com/mcp

# 新增 stdio 伺服器（本機）
claude mcp add --transport stdio my-db -- python /path/to/db-server.py

# 帶環境變數
claude mcp add --transport stdio airtable \
  -e AIRTABLE_API_KEY=xxx -- npx -y airtable-mcp-server

# 作用域控制
claude mcp add --scope project ...   # 存入 .mcp.json（團隊共享）
claude mcp add --scope user ...      # 所有專案可用
claude mcp add --scope local ...     # 僅當前專案（預設）

# 執行時載入 MCP 配置
claude --mcp-config ./mcp.json -p "query"
claude --strict-mcp-config --mcp-config ./mcp.json  # 僅用指定配置

# 管理
claude mcp list
claude mcp get <name>
claude mcp remove <name>
```

---

## 10. 權限模式 (`--permission-mode`)

| 模式 | 說明 |
|------|------|
| `default` | 預設，工具執行前提示確認 |
| `plan` | 規劃模式，偏好讀取操作 |
| `acceptEdits` | 自動核准檔案編輯 |
| `dontAsk` | 不詢問，拒絕未授權的操作 |
| `delegate` | 委託模式 |
| `bypassPermissions` | 略過所有權限（需搭配 `--allow-dangerously-skip-permissions`） |

```bash
# 規劃模式
claude --permission-mode plan

# 完全跳過權限（僅限 sandbox 環境）
claude --dangerously-skip-permissions
```

---

## 11. 自訂 Agent

```bash
claude --agents '{
  "reviewer": {
    "description": "資深程式碼審查員",
    "prompt": "你是資深工程師，專注於安全與效能審查",
    "tools": ["Read", "Grep", "Glob"],
    "model": "sonnet"
  },
  "fixer": {
    "description": "自動修復工具",
    "prompt": "修復所有發現的問題",
    "tools": ["Read", "Edit", "Bash"],
    "model": "haiku"
  }
}'
```

---

## 12. 完整旗標速查表

### 僅列印模式可用

| 旗標 | 說明 |
|------|------|
| `--output-format <format>` | 輸出格式：`text` / `json` / `stream-json` |
| `--input-format <format>` | 輸入格式：`text` / `stream-json` |
| `--json-schema <schema>` | 結構化 JSON 輸出 |
| `--max-budget-usd <amount>` | API 花費上限 |
| `--fallback-model <model>` | 過載時回退模型 |
| `--no-session-persistence` | 停用會話持久化 |
| `--include-partial-messages` | 含部分串流訊息 |

### 所有模式可用

| 旗標 | 說明 |
|------|------|
| `--model <model>` | 指定模型 |
| `--system-prompt <prompt>` | 取代系統提示 |
| `--append-system-prompt <prompt>` | 附加系統提示 |
| `--allowedTools <tools...>` | 自動核准工具 |
| `--disallowedTools <tools...>` | 移除工具 |
| `--tools <tools...>` | 限制工具集 |
| `--permission-mode <mode>` | 權限模式 |
| `--mcp-config <configs...>` | MCP 配置 |
| `--max-turns <n>` | 最大回合數 |
| `--add-dir <dirs...>` | 額外工作目錄 |
| `--debug [filter]` | 除錯模式 |
| `-c / --continue` | 繼續最近對話 |
| `-r / --resume [value]` | 恢復指定 session |