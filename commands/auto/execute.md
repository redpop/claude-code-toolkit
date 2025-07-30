---
allowed-tools: Task, Read, Grep, Bash(jq:*), Write, TodoWrite
description: Execute action plans systematically with progress tracking and smart error handling
argument-hint: <action-plan.md> [--mode=supervised|auto] [--dry-run] [--parallel=N]
---

# Execute Action Plan

Systematically execute fix commands from an action plan, with progress tracking and intelligent error handling.

## Execution Modes

- **Supervised** (default): Confirms each action before execution
- **Auto**: Runs all commands automatically
- **Dry-run**: Preview without making changes

## Workflow

### Phase 1: Plan Loading & Validation

1. Read action plan file: $ARGUMENTS
2. Parse todo items and commands
3. Validate command syntax
4. Check prerequisites

### Phase 2: Execution

**Using TodoWrite for Progress Tracking:**

Initialize todo list with all tasks from the action plan:
```
TodoWrite([
  {id: "task-1", content: "Fix security vulnerabilities", status: "pending", priority: "high"},
  {id: "task-2", content: "Optimize performance", status: "pending", priority: "medium"},
  ...
])
```

**For each task in priority order:**

1. Update status to "in_progress"
   ```
   TodoWrite(update task-N status: "in_progress")
   ```

2. Execute the command
   - If supervised mode: Show preview and ask confirmation
   - If auto mode: Execute directly
   - If dry-run: Show what would be done

3. Handle results
   - Success: Update status to "completed"
   - Failure: Log error, decide if critical
   - Skip: Mark as "skipped" with reason

4. Progress report after each task:
   ```
   Completed: X/Y (Z%)
   Current: [task name]
   Remaining: Y-X tasks
   ```

### Phase 3: Completion Report

Generate summary using Task tool:
```
Use Task tool with subagent_type="general-purpose":
"Generate execution summary from these results: [execution log]. Include success rate, key achievements, failures, and next steps."
```

## Error Handling

**Critical Failures** (stop execution):
- Git conflicts
- Build breakage
- Test failures
- Security vulnerabilities introduced

**Non-Critical Failures** (continue):
- Linting warnings
- Documentation gaps
- Style violations

**Recovery Actions**:
- Create checkpoint before risky operations
- Offer rollback on critical failures
- Log all errors for review

## Usage Examples

```bash
# Supervised execution (default)
/prefix:auto:execute action-plan.md

# Automatic execution
/prefix:auto:execute action-plan.md --mode=auto

# Dry run to preview
/prefix:auto:execute action-plan.md --dry-run

# Parallel execution (auto mode only)
/prefix:auto:execute action-plan.md --mode=auto --parallel=3
```

## Integration with Other Commands

**Typical Workflow:**
```bash
# 1. Analyze codebase
/prefix:scan:deep . --export-json

# 2. Generate action plan
/prefix:scan:report analysis.json --generate-action-plan

# 3. Execute fixes
/prefix:auto:execute action-plan.md --mode=supervised

# 4. Verify results
/prefix:auto:report
```

## Options

- `--mode`: Execution mode (supervised/auto)
- `--dry-run`: Preview without changes
- `--parallel`: Number of parallel tasks (auto mode only)
- `--focus`: Execute only specific category

## Real-time Progress

The command provides real-time updates:
- ✅ Completed tasks
- 🔄 Current task in progress
- ⏳ Pending tasks
- ❌ Failed tasks
- ⏭️ Skipped tasks

Final report includes:
- Total execution time
- Success rate
- Key improvements made
- Any failures requiring attention
- Recommended next steps