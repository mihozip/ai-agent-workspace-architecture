# Workspace AGENTS.md

## Workspace Role

This directory is a multi-project / multi-repository workspace.

Do not mix context, TODOs, deployment methods, schemas, or business rules across projects.

## Project Routing Protocol

Before implementation:

1. Identify the target project.
2. Enter the target project.
3. Read the project's `AGENTS.md`.
4. Read the project's `STATE.md`.
5. Read the project's `TODO.md`.
6. Inspect repository state.
7. Work only inside the target project's scope.

If the target project is ambiguous, stop implementation and resolve the project first.

## Workspace Safety

- Preserve unknown human changes.
- Avoid destructive Git operations.
- Do not deploy unless explicitly requested.
- Do not copy secrets or sensitive production data into Agent documentation.
- High-impact actions require explicit human review.

## Workspace Source of Truth

The workspace root describes topology, routing, shared safety and common Agent collaboration rules.

Project implementation state belongs inside each project.
