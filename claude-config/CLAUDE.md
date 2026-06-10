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

@RTK.md
@karpathy-guidelines.md

