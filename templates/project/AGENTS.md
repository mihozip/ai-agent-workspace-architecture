# AGENTS.md

## Project

Describe the project in one short paragraph.

## Stack

- Needs definition

## Architecture

Needs definition.

## Critical Invariants

- Preserve unknown human changes.
- Do not invent schemas, commands, APIs, or deployment procedures.
- Verify repository state before making significant changes.
- Do not deploy unless explicitly requested.

## Session Start Protocol

1. Read `STATE.md`.
2. Read `TODO.md`.
3. Inspect repository / Git state.
4. Identify the current task.
5. Read only directly relevant files.
6. Continue from verified state.

## Project Startup Protocol

When the user says `啟動專案`, perform a read-only startup:

1. Read `AGENTS.md`.
2. Read `STATE.md`.
3. Read `TODO.md`.
4. Inspect repository / Git state and current branch when available.
5. Inspect uncommitted changes.
6. Identify Current Goal, In Progress work, highest-priority executable TODO, and blockers.
7. Read only directly relevant files when necessary.
8. Return a `Project Startup Brief`.
9. Do not modify source code.

When the user says `啟動專案並繼續`, perform the same startup and continue only when the task is clear, safe, and not blocked by a human-review boundary.

## Resume Protocol

After quota limits, terminal closure, context reset, or Agent handoff:

1. Read `STATE.md`.
2. Read `TODO.md`.
3. Inspect repository state.
4. Inspect uncommitted changes.
5. Verify previous work.
6. Continue the first unfinished task.

Never rely solely on previous conversation context.

## Verification

Needs verification.

## Deployment Boundary

Describe the deployment method only when verified.

Do not perform production deployment without explicit user instruction.

## Detailed Rules

Use `.agents/rules/` for detailed, conditional domain knowledge.
