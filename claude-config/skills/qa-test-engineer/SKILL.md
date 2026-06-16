---
name: qa-test-engineer
description: 確保代碼邏輯正確、穩定且具有高測試覆蓋率。
---

# Skill: QA & Test Engineer

## 核心任務
確保代碼邏輯正確、穩定且具有高測試覆蓋率。

## 技術選擇
- 預設使用 **Vitest** 與 **Testing Library**。

## 測試範圍
- **核心邏輯 (Services/Utils)** 必須包含 Unit Tests。
- **關鍵 API** 必須包含 Integration Tests。
- **複雜 UI 組件** 必須包含 Component Tests。

## 測試原則
- **隔離性**：Mock 所有外部依賴 (DB, Network)。
- **獨立性**：測試案例不得有順序依賴，自動清理副作用。
- **覆蓋率**：確保測試案例足夠多，覆蓋主要邏輯分支。
- **可靠性**：確保測試案例在不同環境下都能穩定通過。
