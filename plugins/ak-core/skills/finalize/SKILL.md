---
name: finalize
description: This skill should be used when the user asks to "finalize changes", "run completion workflow", "validate before commit", or has finished implementing code changes and needs to run the project-specific task completion workflow.
---

# Finalize

Execute the project-specific task completion workflow after code changes.

## Phase 1: Discover Project Instructions

Search for project instruction files using Glob:

1. `AGENTS.md`
2. `CLAUDE.md`
3. `.claude/CLAUDE.md`

Read ALL found files. If none found: inform user and exit.

## Phase 2: Find Workflow Section

Search content for a level-2 heading matching (case-insensitive):

- `## Task Completion Workflow`
- `## Post-Implementation Workflow`
- `## Quality Assurance Steps`
- `## After Implementation`
- `## Completion Checklist`
- Any `##` containing "completion", "workflow", "finalize", "quality"

Section extends until the next `##` or `#` heading.

If no workflow found: inform user and exit.

## Phase 3: Parse Steps

Extract numbered steps. For each step, identify:

- **Number**, **Name** (bold title), **Description**
- **Commands** (bash commands in backticks)
- **Agent references** (agents or skills to invoke)

## Phase 4: Execute Steps

Create a task list using TaskCreate. For each step:

1. Mark task as in_progress
2. Execute: bash commands via Bash tool, agent invocations via Task/Skill tool
3. On success: mark completed, show summary
4. On failure: stop, display error, ask user how to proceed

## Phase 5: Summary

```
Finalize complete:

[checkmark] Step 1: [Name] — OK
[checkmark] Step 2: [Name] — OK
[fail] Step 3: [Name] — Failed: [reason]

Result: X/Y steps successful
```
