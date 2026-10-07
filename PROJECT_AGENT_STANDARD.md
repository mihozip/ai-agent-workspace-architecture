# Project Agent Architecture Standard

## 1. Required structure

```text
Project/
├── AGENTS.md
├── STATE.md
├── TODO.md
├── docs/
│   └── CONTINUATION.md
└── .agents/
    └── rules/
```

## 2. File responsibilities

### AGENTS.md
Keep short, stable and always-on.

Contains:
- project purpose
- main stack
- architecture summary
- critical invariants
- session start protocol
- resume protocol
- verification commands
- deployment boundary
- references to detailed rules

Does not contain:
- full project history
- large data dictionaries
- full API documentation
- long deployment manuals
- short-lived TODOs

### STATE.md
Current state snapshot.

Contains:
- Current Goal
- Current Architecture
- Completed milestones
- In Progress
- Next
- Known Issues
- Important Decisions
- Last Verified

### TODO.md
Executable work only.

Sections:
- Current
- Next
- Later
- Blocked

### docs/CONTINUATION.md
Session recovery SOP.

### .agents/rules/
Optional detailed or conditional knowledge:
- data contracts
- API contracts
- migrations
- deployment SOPs
- domain-specific rules

## 3. Project Startup Protocol

When the user says:

```text
啟動專案
```

perform a read-only startup:

1. Read `AGENTS.md`.
2. Read `STATE.md`.
3. Read `TODO.md`.
4. Inspect repository / Git state.
5. Inspect current branch if available.
6. Inspect uncommitted changes.
7. Identify Current Goal.
8. Identify In Progress work.
9. Identify the highest-priority executable TODO.
10. Identify blockers.
11. Read only directly relevant files when necessary.

Do not modify source code during startup.

Return:

```text
# Project Startup Brief

Project:
Repository:
Branch:
Working Tree:
Current Goal:
In Progress:
Highest Priority Task:
Blockers:
Relevant Files:
Recommended Next Action:

Ready.
```

When the user says:

```text
啟動專案並繼續
```

perform the same startup. If the current task is unambiguous and no safety/human-review boundary blocks it, continue the Current task.

## 4. Milestone protocol

After a meaningful milestone:

1. Verify the implementation.
2. Update `TODO.md`.
3. Update `STATE.md`.
4. Remove stale state.
5. Keep documentation concise.

Do not update `STATE.md` after every trivial edit.

## 5. Source of truth

Priority:

1. Current repository files
2. Git state / history
3. Tests / build results
4. `STATE.md`
5. `TODO.md`
6. Previous conversation

Conversation memory is not authoritative.
