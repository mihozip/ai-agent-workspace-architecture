# Existing Project Migration Guide

這份文件說明如何把既有專案導入 AI Agent Workspace Architecture，而不破壞原有規則、程式碼與工作流程。

## Migration goal

把原本可能混在同一份 `AGENTS.md`、README 或聊天紀錄裡的資訊，重新分工為：

```text
AGENTS.md
STATE.md
TODO.md
docs/CONTINUATION.md
.agents/rules/
```

核心原則：

> 不要用模板覆蓋既有專案；先理解，再重構。

---

## Before migration

先確認目前 Project Root。

常見判斷依據包括：

- `.git/`
- `package.json`
- `composer.json`
- `pyproject.toml`
- `requirements.txt`
- `.clasp.json`
- `appsscript.json`
- README
- 既有 `AGENTS.md`

如果目前目錄只是 `src/`、`frontend/`、`backend/`、`functions/` 等子目錄，不應建立一套獨立的 `STATE.md / TODO.md`，除非它本身真的是獨立 Project Root。

### 先備份

如果已有 Git：

```bash
git status
git add -A
git commit -m "chore: backup before agent architecture migration"
```

如果目前不適合 commit，至少先建立壓縮備份。

---

# Migration steps

## Step 1 — Understand the existing project

優先閱讀：

```text
AGENTS.md
README*
package.json
composer.json
pyproject.toml
requirements.txt
.clasp.json
appsscript.json
```

再視需要閱讀少量真正重要的核心檔案。

不要一開始就全庫盲掃。

先回答：

- 這個專案的用途是什麼？
- 技術棧是什麼？
- 哪些資料契約不可破壞？
- 如何 build / test / deploy？
- 現有 `AGENTS.md` 有哪些真正重要的 project-specific rules？

---

## Step 2 — Refactor AGENTS.md

`AGENTS.md` 只保留 every-session 都需要的資訊。

建議內容：

```text
Project
Stack
Architecture
Critical Invariants
Session Start Protocol
Project Startup Protocol
Resume Protocol
Verification
Deployment Boundary
Detailed Rules index
```

### 應保留

- 重要 coding conventions
- schema / API 不可破壞原則
- 權限與安全邊界
- multi-tenant isolation
- Google Sheet first-row header contracts
- backwards compatibility requirements
- verified build / test commands
- deployment restrictions

### 應移出

- 大型資料字典全文
- API 全文
- 短期 TODO
- 完整開發歷史
- 逐日工作紀錄
- 大型 deployment SOP

---

## Step 3 — Create STATE.md

`STATE.md` 是 snapshot，不是 diary。

建議格式：

```markdown
# Project State

## Current Goal

## Current Architecture

## Completed

## In Progress

## Next

## Known Issues

## Important Decisions

## Last Verified
```

如果沒有 evidence，不要猜。

使用：

```text
Needs verification
```

比寫出一個看似合理但未驗證的狀態更安全。

---

## Step 4 — Create TODO.md

建議只維護：

```markdown
# TODO

## Current

## Next

## Later

## Blocked
```

真正完成的歷史交給 Git。

`TODO.md` 不應變成 changelog。

---

## Step 5 — Create docs/CONTINUATION.md

最小恢復流程：

```text
Read AGENTS.md
↓
Read STATE.md
↓
Read TODO.md
↓
Inspect Git / repository state
↓
Inspect uncommitted work
↓
Verify previous implementation
↓
Continue first unfinished task
```

建議 Source of Truth priority：

```text
1. Current repository files
2. Git state / history
3. Tests / build results
4. STATE.md
5. TODO.md
6. Previous conversation
```

---

## Step 6 — Extract detailed rules

如果 `AGENTS.md` 太大，將只在特定任務才需要的內容拆到：

```text
.agents/rules/
```

例如：

```text
.agents/rules/
├── data-contracts.md
├── api-contracts.md
├── permissions.md
└── deployment.md
```

Critical invariants 仍應保留摘要於 root `AGENTS.md`。

詳細內容才放進 rules。

### Example: data contract rule

```markdown
---
trigger: model_decision
description: "Use when changing database schemas, spreadsheet columns, data mappings, imports, exports, or migrations."
---

# Data Contracts

...
```

### Example: deployment rule

```markdown
---
trigger: manual
description: "Production deployment procedures and release constraints."
---

# Deployment

...
```

---

# Migration safety checklist

Migration 本身應只修改 Agent architecture documents。

建議禁止：

```text
application source code changes
database migrations
package installation
lock-file changes
production deployment
git reset
git clean
git push
```

完成後檢查：

- [ ] 原有 project-specific rules 沒有遺失
- [ ] `AGENTS.md` 已變成短而穩定的 always-on context
- [ ] `STATE.md` 是目前狀態快照
- [ ] `TODO.md` 是可執行工作
- [ ] `CONTINUATION.md` 可以讓新的 Agent 獨立恢復
- [ ] 大型 domain knowledge 已適當拆到 `.agents/rules/`
- [ ] 沒有修改 application source
- [ ] 沒有執行 deployment

---

# Suggested Agent migration prompt

可以把下面的核心要求交給 Coding Agent：

```text
將目前專案遷移到 Project Agent Architecture。

先理解既有 AGENTS.md、README、主要設定檔與 repository 狀態。
不要用 template 直接覆蓋既有規則。

目標建立或整理：

AGENTS.md
STATE.md
TODO.md
docs/CONTINUATION.md

必要時：
.agents/rules/

規則：
- 保留所有 project-specific critical invariants
- AGENTS.md 只保留長期 always-on context
- STATE.md 是 current snapshot，不是 diary
- TODO.md 只放 executable work
- 大型 data/API/deployment rules 改成按需載入
- 不修改 application source code
- 不部署
- 不刪除既有檔案
- 不執行 destructive Git commands

完成後列出：
- modified Agent files
- preserved critical rules
- extracted detailed rules
- needs verification
- manual cleanup candidates
```

---

# After migration

進入專案後：

```bash
codex
```

或啟動其他 Coding Agent。

輸入：

```text
啟動專案
```

確認 Agent 能在沒有舊聊天紀錄的情況下正確回答：

- 這是什麼專案？
- 現在做到哪裡？
- Working Tree 是否乾淨？
- 下一個優先任務是什麼？
- 哪些規則不能破壞？

如果這些問題都能從 Repository 回答，Migration 才算真正完成。
