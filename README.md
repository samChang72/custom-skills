<p align="center">
  <img src="gemini/project_header_banner.png" width="100%" alt="Antigravity Custom Skills Banner">
</p>

# Antigravity Custom Skills

> **賦予你的 AI 代理人超越極限的能力。**

為 AI 代理人（Gemini / Claude Code）量身打造的自定義技能（Skills）與工作流（Hooks）儲存庫。整合了 **56 個專業技能**，涵蓋 3D 體驗開發、後端架構設計、量化交易分析、商業戰略分析到自動化測試等方方面面。

---

## 快速上手

**Gemini Skills** — 將所需技能複製到專案的 `.gemini/skills` 目錄：

```bash
cp -r gemini/skills/frontend-design path/to/your/project/.gemini/skills/
```

**獨立技能** — 直接複製頂層技能資料夾到目標位置：

```bash
cp -r stock path/to/your/project/
```

---

## 專案結構

```
custom-skills/
├── gemini/
│   ├── hooks/               # Git 自動化鉤子腳本
│   └── skills/              # 52 個 Gemini 技能
├── stock/                   # 量化交易分析技能
├── strategic-analysis/      # 商業戰略分析技能
├── ai-model-routing/        # AI 模型智慧路由技能
├── dual-code-review/        # 雙重代碼審查技能
└── docs/                    # Claude Code CLI 參考文件
```

---

## 獨立技能

| 技能 | 描述 |
| :--- | :--- |
| [stock](stock) | 華爾街頂級量化基金等級的股票分析師，涵蓋 8 大專業分析模組。 |
| [strategic-analysis](strategic-analysis) | 麥肯錫等級的商業戰略分析師，提供 12 項專業分析框架。 |
| [ai-model-routing](ai-model-routing) | 根據任務類型自動選擇最佳 AI 模型，支援 Gemini 與 Claude Code CLI 協作。 |
| [dual-code-review](dual-code-review) | 協調 Gemini 與 Claude CLI 進行雙重代碼審查，產出共識報告。 |

---

## Gemini 技能庫（52 個）

### 視覺與設計

| 技能 | 描述 |
| :--- | :--- |
| [frontend-design](gemini/skills/frontend-design) | 建立生產級高品質的前端介面與元件。 |
| [3d-web-experience](gemini/skills/3d-web-experience) | Three.js、React Three Fiber、WebGL 3D 沉浸式體驗。 |
| [ui-ux-pro-max](gemini/skills/ui-ux-pro-max) | 具備 50+ 風格與 21 組調色盤的 UI/UX 設計智能。 |
| [scroll-experience](gemini/skills/scroll-experience) | 滾動驅動體驗——視差故事、滾動動畫。 |
| [web-design-guidelines](gemini/skills/web-design-guidelines) | Web 介面設計指南合規性審查與可訪問性審計。 |
| [tailwind-patterns](gemini/skills/tailwind-patterns) | Tailwind CSS v4 模式——CSS-first 配置、容器查詢。 |

### 架構與開發

| 技能 | 描述 |
| :--- | :--- |
| [backend-architect](gemini/skills/backend-architect) | 建立強型別、高效能的分層後端系統。 |
| [backend-dev-guidelines](gemini/skills/backend-dev-guidelines) | Node.js/Express/TypeScript 微服務後端開發指南。 |
| [typescript-expert](gemini/skills/typescript-expert) | TypeScript 型別級程式設計與效能優化專家。 |
| [clean-code](gemini/skills/clean-code) | 簡潔、直接、無過度工程的編碼標準。 |
| [software-architecture](gemini/skills/software-architecture) | 品質聚焦的軟體架構設計指南。 |
| [nextjs-best-practices](gemini/skills/nextjs-best-practices) | Next.js App Router、Server Components、資料獲取。 |
| [nodejs-best-practices](gemini/skills/nodejs-best-practices) | Node.js 開發原則——框架選擇、非同步模式、安全性。 |
| [nestjs-expert](gemini/skills/nestjs-expert) | Nest.js 框架——模組架構、依賴注入、Jest 測試。 |
| [react-patterns](gemini/skills/react-patterns) | 現代 React 模式——Hooks、組合、效能優化。 |
| [graphql](gemini/skills/graphql) | GraphQL schema 設計、解析器、DataLoader、Federation。 |

### 資料庫

| 技能 | 描述 |
| :--- | :--- |
| [database-design](gemini/skills/database-design) | 資料庫設計原則、Schema 設計、索引策略。 |
| [database-specialist](gemini/skills/database-specialist) | 優化查詢、消除慢查詢、設計高效索引與 Schema。 |
| [prisma-expert](gemini/skills/prisma-expert) | Prisma ORM——schema 設計、遷移、查詢優化。 |

### 測試與品質

| 技能 | 描述 |
| :--- | :--- |
| [playwright-skill](gemini/skills/playwright-skill) | Playwright 完整瀏覽器自動化測試解決方案。 |
| [qa-test-engineer](gemini/skills/qa-test-engineer) | 確保邏輯正確性與高測試覆蓋率。 |
| [test-fixing](gemini/skills/test-fixing) | 系統化修復失敗測試。 |
| [test-driven-development](gemini/skills/test-driven-development) | 實現功能前先撰寫測試。 |
| [testing-patterns](gemini/skills/testing-patterns) | Jest 測試模式、工廠函式、模擬策略。 |
| [lint-and-validate](gemini/skills/lint-and-validate) | 自動品質控制、linting 與靜態分析。 |
| [ab-test-setup](gemini/skills/ab-test-setup) | A/B 測試實驗規劃、設計與實現。 |

### 代碼審查

| 技能 | 描述 |
| :--- | :--- |
| [code-review](gemini/skills/code-review) | 代碼審查——檢查 bugs、風格問題與最佳實踐。 |
| [dual-code-review](gemini/skills/dual-code-review) | 協調 Gemini 與 Claude CLI 的雙重審查流程。 |
| [requesting-code-review](gemini/skills/requesting-code-review) | 完成工作前驗證代碼品質。 |
| [receiving-code-review](gemini/skills/receiving-code-review) | 接收審查反饋——技術驗證和實現。 |
| [address-github-comments](gemini/skills/address-github-comments) | 用 gh CLI 處理 GitHub PR 審查評論。 |

### 運維與部署

| 技能 | 描述 |
| :--- | :--- |
| [docker-expert](gemini/skills/docker-expert) | 多階段構建、鏡像優化與容器安全硬化。 |
| [github-workflow-automation](gemini/skills/github-workflow-automation) | 自動化 PR 審閱與 CI/CD 流程。 |
| [gcp-cloud-run](gemini/skills/gcp-cloud-run) | 部署生產級 Serverless 應用的最佳實踐。 |
| [server-management](gemini/skills/server-management) | 伺服器管理、流程管理與監控策略。 |
| [deployment-procedures](gemini/skills/deployment-procedures) | 安全部署工作流與回滾策略。 |
| [git-pushing](gemini/skills/git-pushing) | Git 分段、提交與推送——規範化提交訊息。 |
| [finishing-a-development-branch](gemini/skills/finishing-a-development-branch) | 完成開發工作——合併/PR/清理決策指南。 |

### 文件與寫作

| 技能 | 描述 |
| :--- | :--- |
| [documentation-expert](gemini/skills/documentation-expert) | 透過結構化對話產出高品質技術文件。 |
| [documentation-templates](gemini/skills/documentation-templates) | 文件模板與結構指南（README、API docs 等）。 |
| [doc-coauthoring](gemini/skills/doc-coauthoring) | 結構化協作文件編寫工作流。 |
| [doc-generator-strategy](gemini/skills/doc-generator-strategy) | 使用者手冊與文件策略生成。 |
| [docx-official](gemini/skills/docx-official) | .docx 文件建立、編輯與分析。 |
| [pptx-official](gemini/skills/pptx-official) | .pptx 簡報建立、編輯與分析。 |
| [internal-comms-community](gemini/skills/internal-comms-community) | 內部通訊寫作——狀態報告、領導力更新。 |

### 規劃與流程

| 技能 | 描述 |
| :--- | :--- |
| [brainstorming](gemini/skills/brainstorming) | 創意工作前探索使用者意圖、需求與設計。 |
| [writing-plans](gemini/skills/writing-plans) | 多步驟任務規劃——接觸代碼前先制定計畫。 |
| [kaizen](gemini/skills/kaizen) | 持續改進、防錯與標準化指南。 |
| [openspec](gemini/skills/openspec) | 輕量級 Spec-Driven Development 框架。 |
| [spec-kit](gemini/skills/spec-kit) | GitHub Spec Kit——嚴謹的 Spec-Driven Development 工具包。 |

### SEO 與行銷

| 技能 | 描述 |
| :--- | :--- |
| [programmatic-seo](gemini/skills/programmatic-seo) | SEO 驅動頁面大規模生成——模板頁面、位置頁面。 |
| [frontend-dev-guidelines](gemini/skills/frontend-dev-guidelines) | React/TypeScript 前端開發指南。 |

---

## 自動化 Hooks

專案內建了一系列 git 鉤子腳本，幫助維持程式碼品質：

- **[block-secrets.sh](gemini/hooks/block-secrets.sh)** — 防止機敏資訊（如 API Keys）被提交。
- **[audit-log.sh](gemini/hooks/audit-log.sh)** — 自動記錄變更日誌。
- **[auto-format.sh](gemini/hooks/auto-format.sh)** — 提交前自動格式化程式碼。
- **[inject-git-context.sh](gemini/hooks/inject-git-context.sh)** — 在 AI 對話中注入 Git 狀態上下文。

---

## 參考文件

- [Gemini Skills 總覽](gemini/skills/README.md)
- [Claude Code CLI 參考](docs/claude-cli-reference.md)

---

## 如何貢獻

1. 參考 [gemini/skills/README.md](gemini/skills/README.md) 中的技能規範。
2. 在 `gemini/skills` 建立新目錄，撰寫 `SKILL.md` 並提供範例。
3. 提交 Pull Request。

---

<p align="center">
  Made with ❤️ by the Antigravity Team
</p>
