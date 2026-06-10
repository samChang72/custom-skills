---
name: jira-ticket
description: Use when the engineer wants to create, update, resolve, or defer Jira tickets for the KPI system. Handles 任務類型 (標準/客製/研究), AI 工具使用, 預估/實際工時, 延誤原因, and 技術研究 / AI 工具產出 / AI 流程改善提案 issue types. Triggers on phrases like 開單、收單、延期、研究單、提案、AI 工具產出.
---

# Jira Ticket Skill (KPI 績效新制專用)

協助工程師快速建立、更新、結案 Jira ticket，符合 2026 績效新制的欄位規範。

## 觸發語

| 使用者說 | 動作 |
|---|---|
| 開單 / 開一張 / 建單 | create_ticket |
| 收單 / 結單 / 完成 | resolve_ticket |
| 延期 / 延誤 / 來不及 | defer_ticket |
| 研究單 / 開研究 | create_research |
| 提案 / AI 提案 | create_proposal |
| AI 工具產出 / 我做了個工具 | create_ai_tool |
| 我的 ticket / 待辦 | list_my_tickets |

## 必要欄位對照

### 一般 ticket（create_ticket）
- **Summary**（必填）
- **任務類型**（必填）：標準 / 客製 / 研究
- **預估純人工時數**（必填，小時）：「不使用 AI 純人工要花多久」
- **AI 工具使用**（必填，可複選）：Claude Code / Codex / Gemini / Figma AI / NotebookLM / 其他 / 未使用
- **AI 應用類型**（必填）：程式開發 / 測試案例生成 / UI/UX 設計 / 文件產出 / 流程自動化 / 資料分析 / 其他
- Due date（建議）

### 結案（resolve_ticket）
- **實際投入時數**（必填，小時）
- 系統自動計算 `AI 節省工時` 與 `AI 節省比例`
- 確認 `AI 工具使用` 與 `AI 應用類型` 是否需要更新

### 延期（defer_ticket）
- **延誤原因**（必填）：
  - `EXT-CUSTOMER` 客戶需求變更（不扣分）
  - `EXT-MEDIA` 媒體端問題（不扣分）
  - `EXT-3RDPARTY` 第三方依賴（不扣分）
  - `INT-ESTIMATE` 內部-估時不準（扣分）
  - `INT-TECHDEBT` 內部-技術 debt（扣分）
  - `INT-COMM` 內部-跨團隊溝通（扣分）
- 自動快照 `原始 due date`，更新新的 due date
- 非內部因素需提醒「需主管核可」

### 技術研究（create_research，Issue Type: 技術研究）
- Summary
- 研究主題
- 預估純人工時數
- 結案時必補：研究結論（可行 / 不可行 / 待驗證）、數據佐證、後續行動

### AI 工具產出（create_ai_tool，Issue Type: AI 工具產出）
- Summary（工具名稱）
- Description（解決的痛點與用途）
- **Demo 連結（必填）**：影片 / jpeg.ly / 文件
- 使用者（誰會用）
- 工具狀態：開發中 / 已 Demo / 已上線

### AI 流程改善提案（create_proposal，Issue Type: AI 流程改善提案）
- Summary
- 提案季度（自動帶入當季）
- 預期節省工時
- 採納狀態：預設「待評估」

## 互動流程

### 建立一般 ticket

1. 解析使用者口述，抽出能識別的欄位
2. 對缺漏欄位**逐項詢問**（一次問一題，避免一次問一堆）
3. 確認欄位後顯示完整草稿
4. 詢問「確認送出？(y/n)」
5. 呼叫 Atlassian MCP `createIssue`
6. 回傳 ticket key 與連結

範例：
```
User: 開一張 SYM 客製進站優化，預估 3 天，會用 Claude Code
Skill:
  ✓ Summary: SYM 客製進站優化
  ✓ 任務類型: 客製
  ✓ 預估純人工時數: 24h
  ✓ AI 工具使用: Claude Code
  ? AI 應用類型 是哪一類？(程式開發 / 流程自動化 / ...)
User: 程式開發
Skill:
  最終草稿：
  - Summary: SYM 客製進站優化
  - 任務類型: 客製
  - 預估純人工時數: 24h
  - AI 工具使用: [Claude Code]
  - AI 應用類型: 程式開發
  確認送出？(y/n)
```

### 結單

1. 確認 ticket key（若使用者沒指定，列出 in_progress ticket 讓他選）
2. 詢問實際投入時數
3. 顯示計算結果（節省工時 / 比例）
4. 呼叫 MCP update + transition 到 Done
5. 若節省比例 < 0（超時），溫和提醒「實際比預估多，是否要記為延期？」

### 延期

1. 詢問延誤原因（顯示六個代碼選項）
2. 詢問新的 due date
3. 若是 EXT-* → 提醒「此類延誤不扣分，但需主管核可」
4. 若是 INT-* → 提醒「此類延誤會影響準時率」
5. 自動寫入 `原始 due date`（若尚未快照）

## 行為守則

- **不要假設欄位值**。寧可多問一句，不要猜錯
- **時數單位統一用小時**。使用者說「3 天」自動換算 24h（每天 8h）
- 使用者說「半天」= 4h
- 任務類型若無法判斷，必須問
- 結單時若 AI 節省比例 ≥ 30%，給予正向回饋（這是 KPI 滿分線）
- 結案研究單時**強制要求**填結論與數據連結，沒有就不能 resolve
- AI 工具產出**強制要求** demo 連結，沒有就拒絕建立
- 所有寫入動作前都要顯示草稿並等待 (y/n) 確認
- 失敗時清楚回報錯誤，不要靜默重試

## MCP 工具對應

依 Atlassian MCP server 的工具命名（實際呼叫時依環境調整）：
- `mcp__atlassian__createJiraIssue`
- `mcp__atlassian__editJiraIssue`
- `mcp__atlassian__transitionJiraIssue`
- `mcp__atlassian__getJiraIssue`
- `mcp__atlassian__searchJiraIssues`

## 常用 JQL（list_my_tickets）

```
assignee = currentUser() AND statusCategory != Done ORDER BY due ASC
```

## 邊界情況

- 使用者一次想開多張 → 逐張處理，不批次猜
- Project key 未指定 → 從使用者所屬團隊預設帶入，但顯示讓使用者確認
- AI 工具使用選「未使用」→ AI 應用類型可省略
- 研究類 ticket 不需 due date（用季度里程碑）
