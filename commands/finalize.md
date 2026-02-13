---
description: Execute project-specific task completion workflow from AGENTS.md/CLAUDE.md
argument-hint: [--dry-run] [--skip-review] [--help]
allowed-tools: Bash, Task, Read, Glob, Grep, Edit, Write, Skill, TaskCreate, TaskUpdate, TaskList
---

# Finalize

Execute the project-specific task completion workflow after code changes.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Reads the task completion workflow from the project's AGENTS.md or CLAUDE.md and executes each step sequentially.
- **Usage**: `/prefix:finalize [--dry-run] [--skip-review]`
- **Options**:
  - `--dry-run`: Show recognized steps without executing them
  - `--skip-review`: Skip non-essential quality steps (Simplify, Review, Re-validate) — for trivial changes

**Examples:**

```
/prefix:finalize
/prefix:finalize --dry-run
/prefix:finalize --skip-review
```

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract flags:

- `--dry-run`: If present, only display the recognized workflow steps without executing them
- `--skip-review`: If present, skip steps that are explicitly marked as skippable for trivial changes in the workflow documentation

---

## Phase 1: Discover Project Instructions

Search for project instruction files that may contain a task completion workflow. Use Glob to find these files in the project root:

1. `AGENTS.md`
2. `CLAUDE.md`
3. `.claude/CLAUDE.md`

Read ALL found files using the Read tool.

If NO instruction files are found: inform the user that no project instructions were found and exit.

---

## Phase 2: Find Workflow Section

Search the content of each file for a section that describes post-implementation steps. Look for level-2 headings matching these patterns (case-insensitive):

- `## Task Completion Workflow`
- `## Post-Implementation Workflow`
- `## Quality Assurance Steps`
- `## After Implementation`
- `## Completion Checklist`
- `## Pre-Commit Workflow`
- Any `##` heading containing keywords like "completion", "workflow", "finalize", "quality", "post-implementation"

The workflow section extends from the matched heading until the next heading of equal or higher level (the next `##` or `#`).

If NO workflow section is found in any file: inform the user that no task completion workflow was found and exit.

---

## Phase 3: Parse Steps

Extract numbered steps from the workflow section. Each step typically follows this pattern:

```
N. **Step Name** — Description
   - Specific commands or actions
   - Additional details
```

For each step, extract:

- **Number**: The step number
- **Name**: The bold title (e.g., "Validate", "Format", "Review")
- **Description**: The text after the title
- **Commands**: Any bash commands mentioned (in backticks or code blocks)
- **Agent references**: Any mentions of Claude Code agents or skills to invoke (e.g., "invoke the `code-simplifier:code-simplifier` agent")
- **Conditions**: Any conditional notes (e.g., "if README blocks changed")
- **Skip hint**: Whether the workflow marks this step as skippable for trivial changes

---

## Phase 4: Display Recognized Steps

Display ALL recognized steps to the user in a clear format:

```
Erkannte Workflow-Schritte aus [filename]:

1. [Name] — [Description summary]
   Aktionen: [list of commands/agents]

2. [Name] — [Description summary]
   Aktionen: [list of commands/agents]

...
```

If `--skip-review` is active, mark skipped steps clearly:

```
3. [Name] — [Description summary]  ⏭ SKIP (--skip-review)
```

If `--dry-run` is active: display the steps and exit here. Do NOT execute anything.

---

## Phase 5: Execute Steps

Create a task list using TaskCreate with one task per workflow step. Then execute each step sequentially:

For each step (in order):

1. **Mark task as in_progress** using TaskUpdate
2. **Announce the step**: Display the step name and what will be done
3. **Execute the step**:
   - **Bash commands**: Run them directly using the Bash tool. Adapt commands to the actual project context (e.g., resolve relative paths, check if referenced tools/files exist before running)
   - **Agent/Skill invocations**: Use the Task tool or Skill tool as appropriate
   - **Conditional steps**: Evaluate conditions before executing (e.g., check if relevant files were actually changed using git status)
4. **Handle results**:
   - **Success**: Mark task as completed, show brief result summary
   - **Failure**: Stop execution, display the error clearly, and ask the user how to proceed (fix and retry, skip, or abort)
5. **If `--skip-review`**: Skip steps whose name contains Simplify, Review, Re-validate, or that the workflow documentation explicitly marks as skippable for trivial changes

---

## Phase 6: Summary

After all steps complete (or after stopping on error), display a summary:

```
Finalize complete:

✅ Step 1: [Name] — OK
✅ Step 2: [Name] — OK
⏭ Step 3: [Name] — Skipped (--skip-review)
⏭ Step 4: [Name] — Skipped (--skip-review)
❌ Step 5: [Name] — Failed: [reason]

Result: X/Y steps successful
```

If all steps succeeded: confirm that the changes are ready for commit.
If any step failed: state which step failed and suggest next actions.
