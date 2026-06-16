---
name: deep-research
description: "Deep research skill for investigating technologies, protocols, products, or concepts. Multi-source web research with cross-validation, structured analysis, and multi-AI verification using Codex CLI and agy CLI. Use when: research, 研究, deep dive, investigate, 調查, analyze technology, protocol analysis, competitive analysis, market research, or any request to thoroughly understand a topic."
---

# Deep Research

## Overview

結構化深度研究流程，結合 Claude + Codex + agy 三方 AI 交叉驗證，產出高品質、事實查核的研究文件。

**各 AI 分工**：
- **Claude**：主研究者，負責規劃、搜尋、整合、產出
- **Codex (OpenAI)**：事實查核員，強在精確性與邏輯審閱
- **agy**：時效與盲點補充，負責最新資訊與遺漏面向

## When to Use

- 用戶要求「研究」「調查」「深入了解」某個技術/產品/協議/概念
- 需要多來源交叉驗證的資訊蒐集
- 技術評估、競品分析、協議比較
- 產出留存用的知識管理文件

## Research Phases

### Phase 1：定義研究範圍（Scoping）

在開始搜尋前，先釐清並確認：

1. **研究主題**：精確定義要研究什麼
2. **研究深度**：概覽（overview）/ 標準（standard）/ 深度（deep）
3. **關注面向**：技術架構、商業模式、競品比較、實作細節、安全性、生態系
4. **輸出格式**：研究筆記 / 比較表 / 技術評估報告
5. **既有知識**：用戶或專案中已有的相關資訊

> 如果用戶的指令已足夠明確，不需要逐項確認，直接進入 Phase 2。

### Phase 2：多來源平行搜尋（Parallel Search）

同時發起 **至少 5 個不同角度** 的搜尋查詢：

| 搜尋角度 | 查詢策略 | 目的 |
|----------|----------|------|
| **官方來源** | 產品名 + official documentation / specification | 取得權威第一手資料 |
| **技術深度** | 產品名 + technical architecture / deep dive / under the hood | 理解內部運作機制 |
| **安全與限制** | 產品名 + security model / limitations / challenges | 發現潛在風險與邊界 |
| **競品比較** | 產品名 + vs / comparison / alternative | 理解市場定位與差異 |
| **實作經驗** | 產品名 + implementation / tutorial / lessons learned | 取得實務觀點 |
| **產業觀點** | 產品名 + adoption / ecosystem / industry analysis | 理解生態與趨勢 |

**關鍵原則**：
- 每個事實至少需要 **2 個獨立來源** 交叉驗證
- 優先信任：官方文件 > 工程部落格 > 權威媒體 > 第三方分析 > 個人部落格
- 時間敏感資訊務必加上日期標註
- 搜尋時使用當前年份，確保取得最新資訊

### Phase 3：多 AI 協作驗證（Multi-AI Verification）

同時使用 Codex CLI 與 agy CLI，由兩個獨立模型從不同視角驗證與補充：

```bash
# Codex CLI（OpenAI，事實查核與邏輯審閱）
codex -m gpt-5.5 -p "<prompt>" --output-format text

# agy CLI（時效性與盲點補充）
agy -p "<prompt>"
```

**分工原則**：
- **Codex（gpt-5.5）**：處理 3a 事實查核、3d 邏輯審閱
- **agy**：處理 3b 盲點補充、3c 最新動態驗證
- **Claude**：整合雙方結果，處理衝突、做最終判斷

若 Codex 與 agy 結論衝突 → 標註「⚠️ 模型分歧」，Claude 回到原始來源再次查證。

#### 3a. 事實查核（Codex / Fact Check）

將 Claude 蒐集的關鍵事實交給 Codex 驗證：

```bash
codex -m gpt-5.5 -p "你是一位嚴謹的事實查核員。請驗證以下關於 [主題] 的陳述是否正確，標註每項為 ✅ 已確認 / ⚠️ 部分正確 / ❌ 錯誤 / ❓ 無法驗證，並說明理由：

1. [事實陳述 1]
2. [事實陳述 2]
...

請用繁體中文回答。" --output-format text
```

#### 3b. 盲點補充（agy / Blind Spot Discovery）

讓 agy 獨立研究同一主題，找出 Claude 與 Codex 可能遺漏的面向：

```bash
agy -p "請針對 [主題] 進行深度分析，特別關注以下面向：
1. 最新發展（截至今日，請使用即時搜尋）
2. 常被忽略的技術細節或限制
3. 潛在風險與未解決的問題
4. 與競品的關鍵差異點
5. 中文／日文／其他非英語市場的觀點（如適用）

請用繁體中文回答，每項結論附上可追溯的資料來源 URL。"
```

#### 3c. 時效性驗證（agy / Recency Check）

針對「版本號、發布日期、市佔率、價格」等易過時資訊，請 agy 做即時查證：

```bash
agy -p "請用即時搜尋驗證以下關於 [主題] 的時效性資訊，並以表格呈現「陳述 / 最新實際值 / 差異 / 資料來源 URL / 資料日期」：

1. [資訊 1，含日期／版本／數字]
2. [資訊 2]
...

請用繁體中文回答。"
```

#### 3d. 結構審閱（Codex / Structure Review）

研究文件初稿完成後，請 Codex 審閱邏輯與結構：

```bash
codex -m gpt-5.5 -p "請審閱以下研究文件，檢查：
1. 資訊完整性：是否有重要面向遺漏？
2. 事實準確性：是否有可疑或過時的陳述？
3. 邏輯一致性：各段落之間是否有矛盾？
4. 深度平衡：哪些段落需要更多細節？

文件內容：
$(cat [file_path])

請用繁體中文回答。" --output-format text
```

### Phase 4：結構化輸出（Structured Output）

研究文件遵循以下模板結構：

```markdown
# [主題] 研究筆記

> 研究日期：YYYY-MM-DD
> 資料來源：[來源類型摘要]
> 驗證方式：Claude + Codex + agy 多 AI 交叉驗證

---

## 1. 概述
[一段式摘要：是什麼、誰做的、何時發布、為何重要]

## 2. 核心架構 / 技術細節
[根據主題性質調整，使用表格和圖表輔助]

## 3. 運作流程 / 資料流
[端到端流程，使用步驟式說明]

## 4. 安全模型 / 信任機制
[如適用]

## 5. 競品分析 / 市場定位
[比較表格，客觀呈現優劣]

## 6. 實作要點 / 整合指南
[開發者視角的重點]

## 7. 已知限制與風險
[技術限制、功能限制、商業風險]

## 8. 產業生態 / 採用狀況
[合作夥伴、市場滲透度、未來路線圖]

## 9. 版本時間線
[關鍵里程碑表格]

## 10. 開發資源
[官方文件、SDK、參考實作連結表格]

## 參考來源
[所有引用來源，格式：[標題 - 來源](URL)]
```

**模板使用原則**：
- 這是最大集合，根據主題刪減不適用的章節
- 每個章節使用最適合的呈現方式（表格、清單、流程圖、程式碼區塊）
- 所有數據標註來源與日期
- 中文為主，技術名詞保留英文原文

### Phase 5：品質檢查清單（Quality Checklist）

輸出前逐項確認：

- [ ] 每個關鍵事實有 ≥2 個獨立來源
- [ ] 日期、版本號、數字已交叉驗證
- [ ] Codex 事實查核已完成，❌ 項目已修正
- [ ] agy 盲點補充已整合
- [ ] agy 時效性驗證已完成（版本／日期／數字）
- [ ] Codex 與 agy 結論衝突處已標註並複查
- [ ] 無過時資訊（標註資訊時效性）
- [ ] 來源清單完整，URL 可追溯
- [ ] 已區分「已確認事實」與「推測/分析」
- [ ] 術語首次出現時有中英對照

## AI CLI 使用規範

### 指令規範

| 工具 | Model | 指令範例 |
|------|-------|----------|
| **Codex CLI** | `gpt-5.5`（固定指定） | `codex -m gpt-5.5 -p "..." --output-format text` |
| **agy CLI** | 不指定（CLI 自動選擇） | `agy -p "..."` |

> ⚠️ Codex 模型版本為固定指定，若 `gpt-5.5` 不存在請**先詢問使用者**再降級，切勿自行替換。
> agy 不需指定 model，直接使用 `-p` 傳入 prompt。

### Prompt 設計原則（Codex 與 agy 通用）

1. **明確角色**：告訴模型它扮演什麼角色（事實查核員、技術分析師、審閱者）
2. **結構化輸出**：要求表格、編號清單等結構化格式
3. **語言指定**：提示詞結尾加上「請用繁體中文回答」
4. **範圍限定**：明確告知要驗證/分析的具體內容，避免開放式問題
5. **來源要求**：要求模型附上可追溯的資料來源 URL（尤其是 agy）

### 使用時機

| 時機 | 工具 | 用途 | 必要性 |
|------|------|------|--------|
| Phase 3a | **Codex** | 事實查核 | **必要** — 所有研究都需要 |
| Phase 3b | **agy** | 盲點補充 | **建議** — 標準／深度研究使用 |
| Phase 3c | **agy** | 時效性驗證 | **建議** — 含版本／日期／數字的研究必備 |
| Phase 3d | **Codex** | 結構審閱 | **選用** — 重要文件使用 |

### 平行呼叫建議

Phase 3 中的 Codex 與 agy 呼叫彼此獨立，**應平行執行**以節省時間：
- 同時送出 3a（Codex）與 3b/3c（agy）
- 等兩邊結果都回來後再由 Claude 整合

### 錯誤處理

如果任一 CLI 呼叫失敗：
1. 檢查網路連線與認證狀態（`codex --version` / `agy --version`）
2. 重試一次
3. 如仍失敗，標註該段落為「**未經 [Codex/agy] 驗證**」，繼續完成研究
4. 不要因為單一工具不可用而阻塞整個研究流程
5. 若 Codex 與 agy 同時不可用，降級為「僅 Claude 單方研究」並在文件頂部加註警告

## Research Depth Levels

| 等級 | 搜尋數 | 多 AI 驗證 | 預期章節數 | 適用場景 |
|------|--------|------------|-----------|----------|
| **概覽** (overview) | 3-5 | 3a (Codex 事實查核) | 3-5 | 快速了解、會議準備 |
| **標準** (standard) | 5-8 | 3a + 3b (agy 盲點補充) | 6-8 | 一般技術研究、決策參考 |
| **深度** (deep) | 8-15 | 3a + 3b + 3c + 3d (四階段全開) | 8-12 | 技術評估、架構決策、策略規劃 |

> 未指定時預設為「標準」等級。

## Anti-Patterns（避免事項）

- ❌ 僅依賴單一來源就下結論
- ❌ 將推測當作事實陳述
- ❌ 忽略負面資訊或限制
- ❌ 複製貼上搜尋結果而不消化整理
- ❌ 跳過 Codex 或 agy 驗證步驟（單方 AI 驗證不足）
- ❌ Codex 與 agy 結論衝突時未回查原始來源就強行選邊
- ❌ 將 Codex 或 agy 輸出直接貼進文件而未經 Claude 整合消化
- ❌ 使用過時資訊而未標註時效
- ❌ 為了篇幅而加入不相關的內容
- ❌ 為 agy 加上 `-m` 或其他 model flag（agy 由 CLI 自動選擇模型）
