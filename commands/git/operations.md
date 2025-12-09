---
description: Smart Git operations with project context and commit pattern learning
argument-hint: [operation] [--push] [--help]
allowed-tools: Task, Bash(git:*), mcp____search_notes, mcp____write_note
---

# Git

Save changes intelligently: "Git workflow with project context."

**Default Behavior**: Always uses intelligent commit message generation. When executed without arguments, defaults to `commit` operation.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Smart Git operations with project context and commit pattern learning
- **Usage**: [operation] [--push]
- **Operations**: commit, review, resolve, conflict-resolver
- **Default Behavior**: Always uses intelligent commit message generation. Defaults to `commit` operation.
- **Options**:
  - `--push`: Push changes to remote repository after committing

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract operation and options:

- If first argument matches git operations (commit, review, resolve, conflict-resolver), use as operation
- Default: operation="commit"
- **Smart commit message generation is always enabled**
- Handle --push flag

---

## Scope Detection

Before executing, analyze the scope of changes to determine the appropriate workflow:

**Run scope analysis:**

```bash
git status --porcelain
git diff --stat
```

**Determine scope category:**

| Scope | Criteria | Workflow |
|-------|----------|----------|
| **Small** | < 3 files changed, single logical change | Direct commit, simple message |
| **Medium** | 3-10 files, related changes | Smart commit with detailed analysis |
| **Large** | 10+ files OR multiple unrelated features | Consider splitting into atomic commits |

**Scope-based behavior:**

- **Small changes**: Quick commit with concise message
- **Medium changes**: Full analysis, semantic commit message with body
- **Large changes**: Suggest atomic commits, warn if mixing unrelated changes

---

## Workflow Execution

Route to knowledge-enhanced Git workflow:

Use Task tool with subagent_type="git-workflow-specialist":
"Execute Git '$operation' with Knowledge-Enhanced approach with graceful fallback.

**IMPORTANT**: NEVER include Claude Code signature or Co-Authored-By lines in commit messages. This command creates commits without automation signatures.

**Enhanced Workflow (when MCP services available):**

1. **Context Retrieval**: Search for project-specific commit patterns and conventions
2. **Pattern Application**: Apply successful commit strategies and messaging patterns from project history
3. **Smart Analysis**: Analyze changes with understanding of project architecture and recent decisions
4. **Pattern Learning**: Capture successful Git workflows and commit patterns

**Standard Workflow (always available - no MCP required):**

1. **Convention Analysis**: Apply standard commit conventions and established messaging patterns
2. **Expert Workflow**: Use Git specialist expertise for professional commit creation and analysis
3. **Change Analysis**: Analyze changes with comprehensive understanding of codebase context
4. **Standard Execution**: Create conventional commits with proper formatting and best practices

**Universal Capabilities (always included):**

- Professional commit message generation with proper formatting
- Comprehensive change analysis and impact assessment
- Conflict resolution strategies and merge guidance
- Code review workflows and quality validation

Focus: intelligent commit creation, change analysis, conflict resolution, or code review based on operation.

Export results with enhanced project context when possible, professional Git workflows guaranteed.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Capture successful Git workflow patterns and commit strategies for version control knowledge enhancement
- Generate intelligent recommendations for workflow optimizations and team collaboration improvements
- Cross-reference Git operations with similar successful projects and workflow outcomes
- Track commit quality and workflow effectiveness to evolve Git practices based on team learning"

---

## Commit Summary

After completing all Git operations, provide a clear summary:

**Summary Format:**

```
## Commit Summary

**Scope**: [Small/Medium/Large] ([X] files changed)

**Commits created:**
- `abc1234` - feat: add user authentication
- `def5678` - fix: resolve login redirect issue

**Files affected:**
- src/auth/login.ts (modified)
- src/components/LoginForm.tsx (added)
- tests/auth.test.ts (modified)

**Next steps** (if applicable):
- [ ] Push to remote: `git push`
- [ ] Create PR: `gh pr create`
```

**Always include:**

1. Scope classification with file count
2. List of all commits with short hash and message
3. Summary of affected files with change type
4. Suggested next steps based on context (push, PR, etc.)

**If --push flag was used:**

- Confirm push success with remote branch info
- Include PR creation suggestion if on feature branch
