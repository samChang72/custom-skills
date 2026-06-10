# Read Document with Gemini

Read and analyze a document using Gemini CLI for a second perspective, then synthesize findings.

**Arguments:** $ARGUMENTS (file path or URL to read)

## Workflow

### Step 1: Claude reads the document

Read the target document and extract key information:
- Document structure and sections
- Main concepts and conclusions
- Important data points, tables, or code

### Step 2: Gemini reads the document

Run Gemini CLI in non-interactive mode to analyze the same document:

```bash
gemini -m gemini-3.1-pro-preview -p "請用繁體中文閱讀並分析以下文件，摘要重點、結構、關鍵資訊，以及任何需要注意的細節。文件路徑: $ARGUMENTS" --sandbox -y
```

If the document is a local file, pipe it to Gemini:

```bash
cat "$ARGUMENTS" | gemini -m gemini-3.1-pro-preview -p "請用繁體中文閱讀並分析以下文件內容，摘要重點、結構、關鍵資訊，以及任何需要注意的細節。" --sandbox -y
```

### Step 3: Synthesize

Compare and merge both analyses into a consolidated report:

1. **共同發現** - Points both Claude and Gemini agree on
2. **Claude 獨有觀點** - Insights only Claude identified
3. **Gemini 獨有觀點** - Insights only Gemini identified
4. **差異與補充** - Any disagreements or complementary perspectives
5. **建議行動** - Recommended next steps based on combined analysis

Format the final report clearly with sections and bullet points.
