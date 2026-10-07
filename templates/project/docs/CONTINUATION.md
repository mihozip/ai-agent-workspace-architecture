# Session Continuation Protocol

## Fast Recovery

1. Read `AGENTS.md`.
2. Read `STATE.md`.
3. Read `TODO.md`.
4. Inspect repository state.
5. Inspect uncommitted changes.
6. Read relevant files only.
7. Verify previous work.
8. Continue the first unfinished task.

## Source of Truth

Priority:

1. Current repository files
2. Git state / history
3. Tests / build results
4. `STATE.md`
5. `TODO.md`
6. Previous conversation

Conversation memory is not authoritative.

## Interrupted Session

After quota limits, terminal closure, context reset, Codex interruption, AGY interruption, or Agent handoff:

- verify repository state first;
- do not redo verified completed work;
- preserve unknown human changes.

## Milestone Update

After a meaningful milestone:

1. Verify.
2. Update `TODO.md`.
3. Update `STATE.md`.
4. Remove stale state.
5. Keep documentation concise.
