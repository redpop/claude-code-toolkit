---
allowed-tools: Task, Read, Grep, Bash(jq:*), Bash(find:*), Bash(ls:*), Write, Edit, TodoWrite
description: Execute action plans systematically with progress tracking and smart error handling
argument-hint: <action-plan.md>|--latest [--mode=supervised|auto] [--dry-run] [--parallel=N]
---

# Execute Action Plan

Systematically execute fix commands from an action plan, with progress tracking and intelligent error handling.

## Execution Modes

- **Supervised** (default): Confirms each action before execution
- **Auto**: Runs all commands automatically
- **Dry-run**: Preview without making changes

## Workflow

### Phase 1: Plan Loading & Validation

1. **Handle --latest Flag**:
   - If `--latest` is specified:
     - Search for most recent action plan: `ls -t ACTION-PLAN-*.md 2>/dev/null | head -1`
     - Alternative: `find . -maxdepth 1 -name "ACTION-PLAN-*.md" -o -name "action-plan-*.md" | head -1`
     - Use timestamps in filenames to identify newest
   - Otherwise use provided filename: $ARGUMENTS

2. Read action plan file
3. **Parse task checkboxes and commands**:
   - Look for patterns: `- [ ] /prefix:command` (pending tasks)
   - Look for patterns: `- [x] /prefix:command` (completed tasks)
   - Extract command, reason, and ROI for each task
4. **Count completed vs pending tasks** for progress reporting
5. Validate command syntax for pending tasks only
6. Check prerequisites

### Phase 2: Execution

**Progress Overview:**
```
📊 Action Plan Status:
- Total Tasks: {total_count}
- Already Completed: {completed_count} ✓
- Matching Criteria: {matching_count}
- Will Execute: {execution_count}
```

**Task Filtering (if filters applied):**
- Apply `--min-roi`, `--max-roi`, `--focus` filters to pending tasks
- Show filtered task list upfront

**Using TodoWrite for Progress Tracking:**

Initialize todo list with ALL tasks that will be executed:
```
TodoWrite([
  {id: "task-1", content: "Fix security vulnerabilities", status: "completed"},  // - [x] in plan
  {id: "task-2", content: "Generate tests for dataExportImport (ROI: 8.0)", status: "pending", priority: "high"},
  {id: "task-3", content: "Generate tests for storage layer (ROI: 7.0)", status: "pending", priority: "high"},
  {id: "task-4", content: "Extract magic numbers to constants (ROI: 7.0)", status: "pending", priority: "high"},
  // Only tasks that match execution criteria
])
```

**Execution Overview Display:**
```
🎯 Execution Plan (ROI ≥ 7.9):

1. Generate tests for dataExportImport (ROI: 8.0)
2. Generate tests for storage layer (ROI: 7.0) 
3. Extract magic numbers to constants (ROI: 7.0)

Total: 3 tasks to execute
```

**For each task in the filtered execution list:**

1. **Pre-execution checks**:
   - If `- [x]`: Skip with message "✓ Already completed"
   - If `- [ ]` and matches criteria: Proceed
   - Update TodoWrite status to "in_progress"

2. Execute the command
   - If supervised mode: Show preview and ask confirmation
   - If auto mode: Execute directly
   - If dry-run: Show what would be done

3. Handle results
   - Success: 
     - Update TodoWrite status to "completed"
     - **Update action plan**: Change `- [ ]` to `- [x]` using Edit tool
     ```
     Edit(action-plan.md, 
       old_string="- [ ] /prefix:command...",
       new_string="- [x] /prefix:command...")
     ```
   - Failure: 
     - Log error, decide if critical
     - Leave checkbox as `- [ ]` with error note
   - Skip: 
     - Mark as "skipped" with reason

4. Progress report after each task:
   ```
   ✅ Completed: X/Y ({Z}%)
   🔄 Current: [task name]
   ⏳ Remaining: Y-X tasks
   ```

**Final Summary:**
```
🎉 Execution Complete!

Completed Tasks:
✅ Task 1: [description] (ROI: X.X)
✅ Task 2: [description] (ROI: X.X)
✅ Task 3: [description] (ROI: X.X)

Total: X/X tasks completed successfully
Time: XX minutes
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

# Continue where left off (reads checkboxes)
/prefix:auto:execute action-plan.md --mode=auto

# Parallel execution (auto mode only)
/prefix:auto:execute action-plan.md --mode=auto --parallel=3
```

## Integration with Other Commands

**Simplified 3-Step Workflow:**
```bash
# 1. Analyze codebase
/prefix:scan:deep . --export-json

# 2. Generate action plan
/prefix:scan:report --latest --generate-action-plan

# 3. Execute fixes
/prefix:auto:execute --latest

# 4. Verify results (optional)
/prefix:auto:report
```

**Using --latest throughout:**
```bash
# Execute most recent action plan
/prefix:auto:execute --latest

# Auto mode (no confirmations)
/prefix:auto:execute --latest --mode=auto

# Preview mode
/prefix:auto:execute --latest --dry-run
```

**Resuming Execution:**
The command automatically detects completed tasks by reading the checkboxes in the action plan:
- `- [x]` = Already completed (will be skipped)
- `- [ ]` = Pending (will be executed)

## Options

- `--mode`: Execution mode (supervised/auto)
- `--dry-run`: Preview without changes
- `--parallel`: Number of parallel tasks (auto mode only)
- `--focus`: Execute only specific category
- `--force-all`: Execute all tasks, even those marked as completed
- `--min-roi`: Only execute tasks with ROI >= threshold
- `--max-roi`: Only execute tasks with ROI <= threshold

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

## Progress Tracking

**Checkbox-based State:**
- The action plan itself is the source of truth
- `- [ ]` = Task pending
- `- [x]` = Task completed
- Tasks are updated in real-time during execution
- No separate state files needed

**Benefits:**
- Simple and visible progress tracking
- Resume capability built into the action plan
- Easy manual intervention if needed
- Git-friendly (tracks changes to plan)

**Example Action Plan with Progress:**
```markdown
## TASKS

- [x] /prefix:fix:security --target=validation --file=src/utils/dataExportImport.ts
  REASON: JSON Injection vulnerability
  ROI: 10.0

- [x] /prefix:fix:security --target=validation --file=src/services/neutralinoStorage.ts
  REASON: JSON.parse() without error handling
  ROI: 9.0

- [ ] /prefix:generate:tests --focus=dataExportImport --coverage-target=90
  REASON: Critical functions untested
  ROI: 8.0
```