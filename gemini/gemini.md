# **通用規範：** 始終使用 **繁體中文** 回答，程式碼必須加上註解。

## 語言規範

所有產出的文件（Artifacts），包含但不限於 `implementation_plan.md`, `task.md`, `walkthrough.md` 以及 Workflow 文件，皆須使用 **繁體中文** 撰寫。

## Skill 使用透明化規則

當你因應使用者的請求而啟用或對應特定 skill 時，必須在回應中明確說明：

- 使用了哪些 skill
- 為什麼選擇這些 skill
- 這些 skill 將如何協助完成任務

格式範例：

```
🎯 **啟用技能：** `skill-name-1`, `skill-name-2`
📝 **原因：** [簡述為何選擇這些技能]
```

## 工作流程與步驟 (Workflows)

當使用者請求執行特定任務時，可參考以下工作流程進行：

### 交付 SaaS MVP

1. **規劃範圍:** 使用 `@brainstorming`, `@concise-planning`, `@writing-plans` 定義 MVP 邊界和驗收標準。
2. **建構後端和 API:** 使用 `@backend-dev-guidelines`, `@api-patterns`, `@database-design` 實作核心實體、API 和基礎身份驗證。
3. **建構前端:** 使用 `@frontend-developer`, `@react-patterns`, `@frontend-design` 交付核心使用者流程。
4. **測試和驗證:** 使用 `@test-driven-development`, `@browser-automation` (或 `@go-playwright`) 覆蓋關鍵使用者旅程。
5. **安全交付:** 使用 `@deployment-procedures`, `@observability-engineer` 準備發布與回退計劃。

### Web 應用安全審計

1. **定義範圍和威脅模型:** 使用 `@ethical-hacking-methodology`, `@threat-modeling-expert`, `@attack-tree-construction` 識別資產與攻擊路徑。
2. **審查身份驗證和存取控制:** 使用 `@broken-authentication`, `@auth-implementation-patterns`, `@idor-testing` 偵測漏洞。
3. **評估 API 和輸入安全:** 使用 `@api-security-best-practices`, `@api-fuzzing-bug-bounty`, `@top-web-vulnerabilities` 發現 API 和注入漏洞。
4. **強化和驗證:** 使用 `@security-auditor`, `@sast-configuration`, `@verification-before-completion` 將發現轉化為修復並驗證。

### 建構 AI Agent 系統

1. **定義目標行為和 KPI:** 使用 `@ai-agents-architect`, `@agent-evaluation`, `@product-manager-toolkit` 設定成功標準與閾值。
2. **設計檢索和記憶:** 使用 `@llm-app-patterns`, `@rag-implementation`, `@vector-database-engineer` 建構檢索和上下文架構。
3. **實作編排:** 使用 `@langgraph`, `@mcp-builder`, `@workflow-automation` 實作編排和工具邊界。
4. **評估和迭代:** 使用 `@agent-evaluation`, `@langfuse`, `@kaizen` 用結構化迴圈改善系統。

### QA 和瀏覽器自動化

1. **準備測試策略:** 使用 `@e2e-testing-patterns`, `@test-driven-development` 確定範圍與環境。
2. **實作瀏覽器測試:** 使用 `@browser-automation` (或 `@go-playwright`) 建構強健的測試覆蓋。
3. **分類和強化:** 使用 `@systematic-debugging`, `@test-fixing`, `@verification-before-completion` 解決不穩定性並強制可重複性。

### 設計 DDD 核心領域

1. **評估 DDD 適用性和範圍:** 使用 `@domain-driven-design`, `@architecture-decision-records` 決定架構適用性。
2. **建立策略模型:** 使用 `@ddd-strategic-design` 定義子領域、限界上下文和通用語言。
3. **映射上下文關係:** 使用 `@ddd-context-mapping` 定義上下游合約和防腐層邊界。
4. **實作戰術模型:** 使用 `@ddd-tactical-patterns`, `@test-driven-development` 編碼不變式。
5. **選擇性採用事件模式:** 使用 `@cqrs-implementation`, `@event-store-design`, `@projection-patterns`, `@saga-orchestration` (僅在複雜度和規模需要時應用)。
