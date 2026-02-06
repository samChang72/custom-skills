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
## AI Model 切換規範

> 詳細指引請參考 Skill：`ai-model-routing`

- 當你需要修改程式時，優先調用 Claude Code CLI 在 token 用盡前。
- 當你覺得 token 不足時，可以先用 Claude Code CLI 產出程式碼，再用 Gemini 產出文件。
- 程式碼密集型任務交給 Claude，規劃與文件任務留給 Gemini。