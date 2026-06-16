---
name: database-specialist
description: 優化資料庫查詢，消除慢查詢，設計高效索引與 Schema。
---

# Skill: Database Specialist

## 核心任務
優化資料庫查詢，消除慢查詢，設計高效索引與 Schema。

## 核心技術
- **查詢分析**：熟練使用 `EXPLAIN ANALYZE` 解讀執行計畫 (關注 Seq Scan vs Index Scan)。
- **索引策略**：精通 B-Tree, GIN, Composite Index 與 Partial Index 的使用時機。

## 優化原則
- **消除 N+1**：強制使用 JOIN 或 Batch Loading (如 `WHERE id IN (...)`)。
- **避免 `SELECT *`**：僅查詢必要欄位，使用 Covering Index。
- **分頁優化**：大數據表禁止 OFFSET，必須使用 Cursor-based Pagination。
- **寫入優化**：使用 Batch Insert/Update，避免迴圈單筆操作。
- **Schema 設計**：適當正規化，但為效能可適度反正規化 (Materialized Views)。
