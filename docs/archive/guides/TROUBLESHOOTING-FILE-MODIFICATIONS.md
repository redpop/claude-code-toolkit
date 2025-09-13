# Troubleshooting: Unwanted File Modifications

## Problem

Analysis commands (`/analyze-deep`, `/security-audit`, etc.) are creating or modifying files in your project when they should only be performing read-only analysis.

## Root Cause

Claude Code may interpret code examples, templates, or test suggestions as instructions to create files, especially when:

- Commands show "test templates" or "code examples"
- Sub-agents provide implementation suggestions
- Analysis includes "TODO" or "FIXME" comments

## Immediate Solutions

### 1. Reset Modified Files

If files were modified during analysis:

```bash
# Check what was changed
git status

# Reset all changes (BE CAREFUL - this discards ALL changes)
git reset --hard HEAD

# Or reset specific files
git checkout -- package.json
git checkout -- path/to/modified/file
```

### 2. Prevention Measures

All analysis commands now include explicit READ-ONLY constraints:

- Commands start with `**IMPORTANT: This is a READ-ONLY analysis command**`
- All sub-agents have `**CRITICAL: This is a READ-ONLY analysis agent**` warnings
- Code examples are marked as `EXAMPLE ONLY - DO NOT CREATE FILES`

### 3. If Problems Persist

1. **Report the Issue**:

   - Note which command caused file modifications
   - List which files were created/modified
   - Create an issue at: <https://github.com/redpop/claude-code-toolkit/issues>

2. **Temporary Workaround**:
   - Run analysis in a separate branch
   - Use git stash before running analysis commands
   - Review changes with `git diff` after analysis

## Updated Commands

The following commands have been updated with stronger READ-ONLY constraints:

### Orchestration Commands

- `/orchestration/analyze-parallel`
- `/orchestration/security-audit`
- `/orchestration/performance-scan`
- `/orchestration/refactor-impact`
- `/orchestration/test-coverage`

### Research Commands

- `/research/codebase-map`
- `/research/deep-dive`
- `/research/dependency-trace`

### Hybrid Commands

- `/hybrid/analyze-deep`

### Analysis Commands

- `/analysis/five-whys`

### Sub-Agents

All sub-agents now have explicit READ-ONLY warnings:

- `test-engineer`
- `security-specialist`
- `performance-optimizer`
- `code-architect`
- `refactoring-expert`

## Best Practices

1. **Always work in a Git repository** - Makes it easy to undo unwanted changes
2. **Commit before analysis** - Create a checkpoint before running analysis commands
3. **Use branches** - Run analysis on a separate branch if concerned about modifications
4. **Review output carefully** - If you see "Creating file..." or similar messages, stop the command

## Technical Details

The issue occurs because:

1. Claude Code's Task Tool agents operate independently
2. Code examples in prompts can be misinterpreted as file creation instructions
3. "Template" language suggests creating new files

All commands and agents have been updated to:

- Explicitly state READ-ONLY operation
- Mark all code examples as "EXAMPLE ONLY"
- Avoid "template" terminology
- Use "suggest" instead of "create" language

## Version History

- **v2.1.1** (2025-01-28): Added READ-ONLY constraints to all analysis commands
- **v2.1.2** (pending): Enhanced sub-agent READ-ONLY enforcement

If you experience file modifications after v2.1.1, please report immediately.
