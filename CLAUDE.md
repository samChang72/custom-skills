# 語言設定

請用繁體中文回答所有問題。

## General Rules

When asked to create a plan or document, generate the document ONLY — do not start implementing code unless explicitly asked to implement.

## Code Editing

Preserve existing code structure by default. Do not refactor or restructure unless explicitly asked. When editing, make minimal targeted changes.

## Integrations

For Jira transitions, always check available transitions and required fields (especially 'resolution') before attempting status changes.

## Output Preferences

When running /insights, the generated report.html must be fully translated to Traditional Chinese (繁體中文). All headings, labels, descriptions, and paragraphs should be in Chinese. Technical terms, product names, and code snippets remain in English.

## Build Scripts & Tooling

撰寫 build script 或內容比較邏輯時，務必測試邊界情況：比較 stripped 與 unstripped 內容時確保邏輯一致，並在提交方案前驗證「內容已變更」和「內容未變更」兩條路徑皆正確。

## Workflow Conventions

多檔案重構（檔案搬移、路徑變更、圖片重組）後，務必執行完整 build 並驗證無損壞引用才 commit。

## Project Stack & Preferences

專案大量使用 Node.js build scripts、TypeScript、JavaScript 與 HTML。變更偵測偏好使用 SHA-256 content hashing，而非 timestamp-based 方式。

## 1. 動手寫程式前先思考

**不要假設。不要隱藏疑惑。攤開取捨。**

在實作之前：
- 明確陳述你的假設。若不確定，就發問。
- 若存在多種解讀，全部呈現出來——不要默默選一個。
- 若有更簡單的做法，就說出來。必要時據理力爭。
- 若有不清楚之處，停下來。指出令人困惑的地方。發問。

## 2. 簡單優先

**用解決問題的最少程式碼。不做任何臆測性的東西。**

- 不做超出要求範圍的功能。
- 不為一次性程式碼建立抽象層。
- 不加入未被要求的「彈性」或「可配置性」。
- 不為不可能發生的情境寫錯誤處理。
- 若你寫了 200 行而其實 50 行就夠，重寫它。

問自己：「資深工程師會說這過度複雜嗎？」若是，就簡化。

## 3. 外科手術式的變更

**只動你非動不可的部分。只清理你自己製造的爛攤子。**

編輯既有程式碼時：
- 不要「順手改善」相鄰的程式碼、註解或格式。
- 不要重構沒有壞掉的東西。
- 配合既有風格，即使你會用不同寫法。
- 若注意到無關的死碼，提出來——不要刪掉它。

當你的變更產生孤兒（orphans）時：
- 移除「因你的變更」而變得未使用的 import／變數／函式。
- 除非被要求，否則不要移除既有的死碼。

檢驗標準：每一行變更都應能直接追溯到使用者的需求。

## 4. 以目標驅動的執行

**定義成功標準。反覆迭代直到驗證通過。**

把任務轉化為可驗證的目標：
- 「加入驗證」→「為無效輸入寫測試，然後讓它們通過」
- 「修這個 bug」→「寫一個能重現它的測試，然後讓它通過」
- 「重構 X」→「確保重構前後測試都通過」

對於多步驟任務，陳述一份簡短計畫：
```
1. [步驟] → 驗證：[檢查]
2. [步驟] → 驗證：[檢查]
3. [步驟] → 驗證：[檢查]
```

強而明確的成功標準讓你能獨立迭代。薄弱的標準（「讓它能動就好」）會導致不斷需要釐清。

---

**這些準則若有發揮作用，會看到：** diff 中不必要的變更變少、因過度複雜而重寫的情況變少，且釐清問題發生在實作之前，而非犯錯之後。
