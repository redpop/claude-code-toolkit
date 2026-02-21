---
name: operations
description: This skill should be used when the user asks to "commit changes", "smart commit", "resolve conflicts", "review changes", or needs Git workflow assistance with intelligent commit messages.
---

# Git Operations

Smart Git operations with intelligent commit messages and change analysis.

**Default**: Always uses intelligent commit message generation. Defaults to `commit` operation.

## Arguments

Parse arguments: `$ARGUMENTS`

Extract operation and options:

- If first argument matches operations (commit, review, resolve, conflict-resolver), use as operation
- Default: operation="commit"
- Flags: `--push`

## Scope Detection

Before executing, analyze change scope:

```bash
git status --porcelain
git diff --stat
```

| Scope | Criteria | Workflow |
|-------|----------|----------|
| **Small** | < 3 files, single logical change | Direct commit, concise message |
| **Medium** | 3-10 files, related changes | Smart commit with detailed analysis |
| **Large** | 10+ files OR unrelated features | Suggest splitting into atomic commits |

## Execution

Use Task tool with subagent_type="git-workflow-specialist":
"Execute Git '$operation':

**IMPORTANT**: NEVER include Co-Authored-By lines in commit messages.

1. **Convention Analysis**: Apply standard commit conventions
2. **Change Analysis**: Analyze changes with full codebase context
3. **Message Generation**: Create professional commit messages with proper formatting
4. **Execution**: Create commits, handle conflicts, or perform code review

Focus:

- **commit**: Intelligent commit creation with scope-based messaging
- **review**: Pre-commit code review of staged changes
- **resolve/conflict-resolver**: Merge conflict resolution with context"

## Commit Summary

After completing operations, provide:

```markdown
## Commit Summary

**Scope**: [Small/Medium/Large] ([X] files changed)

**Commits created:**
- `abc1234` - feat: description

**Files affected:**
- path/to/file (modified/added/deleted)

**Next steps:**
- [ ] Push to remote: `git push`
- [ ] Create PR: `gh pr create`
```

If `--push` was used: confirm push success with remote branch info.
