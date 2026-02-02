---
name: spec-kit
description: GitHub Spec Kit (Specify) - 嚴謹的 Spec-Driven Development 工具包，適用於大型企業專案。
---

# GitHub Spec Kit (Specify)

GitHub 的 Spec-Driven Development 工具包，提供嚴謹的階段式開發流程。

## 使用方式

```bash
uvx --from specify-cli specify <命令>
```

## 可用命令

| 命令 | 說明 |
|------|------|
| `init` | 初始化新的 Specify 專案 |
| `check` | 檢查所有必要工具是否已安裝 |
| `version` | 顯示版本和系統資訊 |

## 與 Antigravity 整合

Spec Kit 可作為「治理層」定義規格，Antigravity 作為「執行層」自主實作：

1. 用 Spec Kit 建立 Constitution 和規格
2. 將 `.claude/commands` 轉換為 `.agent/workflows`
3. Antigravity agents 根據規格執行並自主驗證

## 適用場景

- 大型企業專案
- 需要嚴格階段門檻的開發流程
- 與 GitHub 生態系統深度整合

## 相關資源

- [GitHub Blog](https://github.blog) - 官方介紹
- [dev.to](https://dev.to) - 整合教學
- [antigravity.google](https://antigravity.google) - Antigravity 官網
