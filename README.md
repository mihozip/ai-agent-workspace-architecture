# AI Agent Workspace Architecture

A lightweight, vendor-neutral repository-state architecture for long-running AI coding workflows.

這是一套給 Codex、AGY 與其他 Coding Agent 使用的持久化專案架構。核心目標不是讓 Agent「記住更多對話」，而是讓 Repository 自己保存足以恢復工作的狀態。

## Core idea

```text
Conversation State  →  Repository State
```

專案以四個核心文件管理 Agent 工作：

```text
AGENTS.md
STATE.md
TODO.md
docs/CONTINUATION.md
```

大型規則則採 progressive disclosure：

```text
.agents/rules/
```

## Two-layer architecture

```text
Workspace/
├── AGENTS.md
├── STATE.md
├── TODO.md
├── CONTINUATION.md
└── PROJECT_AGENT_STANDARD.md

Project/
├── AGENTS.md
├── STATE.md
├── TODO.md
├── docs/
│   └── CONTINUATION.md
└── .agents/
    └── rules/
```

### AGENTS.md
Always-on invariants: stack, safety boundaries, critical contracts, verification, deployment boundary, startup/resume protocol.

### STATE.md
Current project snapshot. Not a diary.

### TODO.md
Executable work only: Current / Next / Later / Blocked.

### docs/CONTINUATION.md
How a fresh Agent session reconstructs context after quota reset, terminal closure, context reset, or handoff.

### .agents/rules/
Detailed domain knowledge loaded only when relevant, such as data contracts, API contracts, or deployment procedures.

## Startup commands

Suggested human-facing shortcuts:

```text
啟動專案
```

Read-only startup. The Agent restores context and returns a Project Startup Brief, but does not modify source code.

```text
啟動專案並繼續
```

Same startup procedure, then continues the current executable task when it is clear and safe.

## Quick start

Copy the project template:

```bash
cp -R templates/project my-project
cd my-project
```

Or use the bootstrap script:

```bash
./scripts/bootstrap-project.sh my-project
cd my-project
```

Then start your coding agent and type:

```text
啟動專案
```

## Repository contents

- `ARTICLE.md` — full Chinese introduction
- `PROJECT_AGENT_STANDARD.md` — architecture standard
- `templates/workspace/` — multi-project workspace governance templates
- `templates/project/` — standalone project templates
- `templates/project/.agents/rules/` — progressive-disclosure examples
- `scripts/bootstrap-project.sh` — create a new project skeleton

## Design principles

1. Repository state is more authoritative than conversation memory.
2. `AGENTS.md` stays short and stable.
3. `STATE.md` is a snapshot, not a changelog.
4. `TODO.md` contains executable work, not project history.
5. Detailed rules are loaded only when relevant.
6. A fresh Agent must be able to recover without the previous conversation.
7. Deployment, destructive changes, sensitive data, and other high-impact actions remain behind explicit human review.

## License

MIT
