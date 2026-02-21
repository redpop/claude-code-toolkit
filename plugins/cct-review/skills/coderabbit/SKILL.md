---
name: coderabbit
description: This skill should be used when the user asks for "code review", "run CodeRabbit", "review my changes", or needs automated code review with fix application and critical evaluation.
---

# CodeRabbit Review

Execute CodeRabbit CLI review with critical evaluation, systematic fixes, and project consistency validation.

## Arguments

Parse arguments: `$ARGUMENTS`

- `--type`: uncommitted (default) | committed | all
- `--base`: Base branch (intelligently determined if not specified)

## Workflow

### Phase 1: Base Branch Detection

1. Check current branch: `git rev-parse --abbrev-ref HEAD`
2. Check unpushed commits: `git rev-list --count @{u}..HEAD 2>/dev/null`
3. If `--base` explicit: use that. If ahead of origin: use `origin/<branch>`. Otherwise: "main"

### Phase 2: Execute Review

Run synchronously (takes 7-30+ minutes):

```bash
coderabbit review --prompt-only --type [type] --base [base]
```

Set timeout to 3600000ms (60 minutes). Inform user about expected duration.

### Phase 3: Parse Results

Extract issues from CodeRabbit output:

- File path, line numbers
- Issue type (potential_issue, suggestion)
- Fix description

Create todo list with one item per issue.

### Phase 4: Critical Evaluation & Fix

For each issue, critically evaluate before implementing:

1. **Is the issue valid?** (not a false positive?)
2. **Is the fix appropriate?** (fits project conventions?)
3. **Is the fix necessary?** (provides genuine value?)
4. **Could the fix cause harm?** (breaks functionality?)

Decision framework:

- **Apply**: Valid and appropriate — implement
- **Adapt**: Core idea valid, adjust for project — implement modified version
- **Skip**: False positive or unnecessary — mark completed with justification

Guidelines:

- Skip purely stylistic changes with no functional benefit
- Adapt rather than blindly copy when project conventions differ
- When in doubt, skip and flag for manual review

### Phase 5: Validation

After all fixes, validate project consistency:

- Architectural patterns maintained
- Naming conventions consistent
- Dependencies and imports correct
- Cross-reference similar patterns in codebase using Grep

### Phase 6: Summary

Report: issues found, fixes applied, items skipped (with reasons), validation results, testing recommendations.
