# Dual Code Review (Claude + Codex)

Run code review with both Claude and Codex (GPT-5.5), then consolidate into a unified report.

**Arguments:** $ARGUMENTS (optional: specific files or git ref to review, defaults to uncommitted changes)

## Workflow

### Step 1: Identify files to review

Determine the review scope:
- If $ARGUMENTS specifies files: review those files
- If $ARGUMENTS specifies a git ref (e.g., HEAD~3..HEAD): use `git diff` for that range
- Default: review uncommitted changes via `git diff --name-only HEAD`

### Step 2: Claude Code Review

For each changed file, review for:

**Security (CRITICAL):**
- Hardcoded credentials, API keys, tokens
- SQL/NoSQL injection, XSS, CSRF
- Missing input validation
- Path traversal, SSRF risks

**Code Quality (HIGH):**
- Functions > 50 lines, files > 800 lines
- Nesting > 4 levels
- Missing error handling
- Mutation patterns (should be immutable)
- console.log statements left in

**Best Practices (MEDIUM):**
- Missing tests for new code
- Accessibility issues
- Performance concerns
- Naming and readability

Save Claude's findings internally before proceeding.

### Step 3: Codex Code Review

Pipe the diff or file contents to `codex exec` and run a review with GPT-5.5. Codex reads stdin when no prompt is supplied as an argument, or appends stdin as a `<stdin>` block when a prompt is also given (we use the latter so the prompt is explicit).

For diff-based review:

```bash
git diff HEAD -- $FILES | codex exec --skip-git-repo-check --sandbox read-only -m gpt-5.5 "你是資深程式碼審查員。請用繁體中文對 stdin 中的 git diff 進行全面的 code review。檢查項目：

1. **安全性問題** (CRITICAL): 硬編碼密鑰、注入攻擊、XSS、CSRF、輸入驗證
2. **程式碼品質** (HIGH): 函式過長(>50行)、檔案過大(>800行)、巢狀過深(>4層)、錯誤處理、mutation
3. **最佳實踐** (MEDIUM): 測試覆蓋、無障礙、效能、命名規範
4. **低優先級** (LOW): 風格、文件、註解

每個問題請列出：嚴重度、檔案位置、問題描述、建議修正。控制在 800 字內。"
```

For file-content review (when reviewing without a diff):

```bash
for f in $FILES; do echo "=== $f ==="; cat "$f"; done | codex exec --skip-git-repo-check --sandbox read-only -m gpt-5.5 "你是資深程式碼審查員。請用繁體中文對 stdin 中的程式碼進行全面的 code review。[同上檢查項目]"
```

Notes:
- `--skip-git-repo-check` lets Codex run even when invoked from outside a git repo
- `--sandbox read-only` blocks accidental writes; safe for review
- `-m gpt-5.5` pins the model (the user's default in `~/.codex/config.toml` is also `gpt-5.5`, but pin explicitly so the skill is reproducible)
- The output is a streamed transcript; Codex's final answer appears after the last `codex` marker line and before the `tokens used` line — Claude should extract that block when consolidating

### Step 4: Consolidated Report

Merge both reviews into a single report with this format:

---

## Code Review Report (Claude + Codex)

**Review scope:** [files or git range]
**Date:** [current date]
**Codex model:** gpt-5.5

### CRITICAL Issues
| # | Issue | File:Line | Found By | Description | Fix |
|---|-------|-----------|----------|-------------|-----|
(Issues found by either or both reviewers)

### HIGH Issues
(Same table format)

### MEDIUM Issues
(Same table format)

### LOW Issues
(Same table format)

### Summary
- **Claude found:** X issues (Y critical, Z high)
- **Codex found:** X issues (Y critical, Z high)
- **Overlapping:** N issues found by both (higher confidence)
- **Unique to Claude:** N issues
- **Unique to Codex:** N issues

### Verdict
- BLOCK: If any CRITICAL or HIGH issues remain
- APPROVE: If only MEDIUM/LOW issues

---

Important notes:
- Issues found by BOTH reviewers should be flagged as **high confidence**
- Issues found by only ONE reviewer should still be listed but noted as single-source
- Always prioritize security issues regardless of source
- Do NOT auto-approve if any CRITICAL issue exists
- If `codex` command is missing, install it (e.g. `brew install codex`) or fall back to a single-reviewer report and note the degradation in the Summary section
