---
name: openspec
description: OpenSpec - Fission AI 的輕量級 Spec-Driven Development 框架，支援 20+ AI 工具，適合快速迭代。
---

# OpenSpec

Fission AI 的輕量級 Spec-Driven Development 框架。

## 核心理念

```text
→ fluid not rigid       (流動而非僵化)
→ iterative not waterfall   (迭代而非瀑布)
→ easy not complex      (簡單而非複雜)
→ built for brownfield     (適用於既有專案)
→ scalable             (從個人到企業皆適用)
```

## 安裝與初始化

```bash
# 安裝
npm install -g @fission-ai/openspec@latest

# 確認版本
openspec --version

# 初始化專案
cd your-project
openspec init
```

## 核心 Slash Commands

| 指令 | 說明 |
|------|------|
| `/opsx:new <feature>` | 建立新的變更資料夾 |
| `/opsx:ff` | 快速產生所有規劃文件（proposal、specs、design、tasks） |
| `/opsx:apply` | 執行實作任務 |
| `/opsx:archive` | 歸檔已完成的變更 |
| `/opsx:onboard` | 新手引導流程 |

## 工作流程範例

```text
/opsx:new add-dark-mode    # 建立變更
/opsx:ff                   # 產生規劃文件
/opsx:apply                # 執行實作
/opsx:archive              # 歸檔完成
```

## 更新 OpenSpec

```bash
npm install -g @fission-ai/openspec@latest
openspec update  # 在專案內執行以更新 AI 指令
```

## 適用場景

- 快速迭代的專案
- 需要支援多種 AI 工具的開發流程
- 個人專案到中型團隊

## OpenSpec vs Spec Kit

| 面向 | OpenSpec | Spec Kit |
|------|----------|----------|
| 風格 | 輕量、流動 | 嚴謹、階段式 |
| 鎖定 | 支援 20+ AI 工具 | 主要配合 GitHub |
| 適用 | 快速迭代 | 大型企業專案 |

## 相關資源

- [OpenSpec GitHub](https://github.com/Fission-AI/OpenSpec)
- [OpenSpec 文件](https://github.com/Fission-AI/OpenSpec/tree/main/docs)
