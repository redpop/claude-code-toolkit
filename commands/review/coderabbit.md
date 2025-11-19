---
description: CodeRabbit CLI integration for automated code review and fixes
argument-hint: [--type uncommitted|committed|all] [--base branch-name] [--help]
allowed-tools: Bash(coderabbit:*), Task, Read, Edit, Write, TodoWrite, Grep
---

# CodeRabbit Review & Fix

Execute CodeRabbit CLI review and automatically fix identified issues using Claude Code.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: CodeRabbit CLI integration for automated code review and fixes
- **Usage**: [--type uncommitted|committed|all] [--base branch-name]
- **Options**:
  - `--type`: Review type - uncommitted (default), committed, or all
  - `--base`: Base branch for comparison (default: intelligently determined)
- **Examples**:
  - `/prefix:review:coderabbit` - Review uncommitted changes
  - `/prefix:review:coderabbit --type committed` - Review local commits (auto-detects correct base)
  - `/prefix:review:coderabbit --type all` - Review all changes
  - `/prefix:review:coderabbit --base develop` - Review against develop branch
  - `/prefix:review:coderabbit --type committed --base develop` - Review committed changes against develop
- **Smart Base Detection**:
  - If you have unpushed commits on `main`, base automatically becomes `origin/main`
  - Explicit `--base` always overrides automatic detection
  - Works for any branch with unpushed commits

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract options with defaults:

- `type`: uncommitted (default) | committed | all
- `base`: intelligently determined (see Phase 1) | any explicit branch name

## Workflow

### Phase 1: Intelligent Base Branch Detection

Before executing CodeRabbit, determine the correct base branch:

1. **Check current branch and remote status**:

   ```bash
   git rev-parse --abbrev-ref HEAD
   git rev-list --count @{u}..HEAD 2>/dev/null || echo "0"
   ```

2. **Apply intelligent defaults**:
   - If `--base` is explicitly provided → Use that value
   - If current branch has unpushed commits (ahead of origin):
     - Use `origin/<current-branch>` as base
   - Otherwise → Use "main" as default

3. **Example logic**:
   - On `main` with 2 commits ahead of `origin/main` → base: `origin/main`
   - On `feature` with 5 commits ahead of `origin/feature` → base: `origin/feature`
   - On `main` with no unpushed commits → base: `main`
   - On any branch with explicit `--base develop` → base: `develop`

This ensures `--type committed` works correctly with local commits.

### Phase 2: Execute CodeRabbit Review

**IMPORTANT**: CodeRabbit reviews take 7-30+ minutes. This command uses synchronous execution to ensure proper completion.

**Critical: Synchronous Execution Required**

Background execution does NOT work reliably with Claude Code hooks and completion detection. Use synchronous execution instead.

Use Bash tool to run CodeRabbit CLI **synchronously** (NOT in background):

```bash
coderabbit review --prompt-only --type [type] --base [intelligently-determined-base]
```

**Execution Requirements**:

1. **Synchronous Execution**: Use Bash tool WITHOUT `run_in_background` parameter
2. **Extended Timeout**: Set timeout to 3600000ms (60 minutes) to accommodate long reviews
3. **User Communication**: Inform user upfront that review will take 7-30+ minutes
4. **Active Waiting**: Claude Code stays active and waits for completion

**Example Bash Tool Usage**:

```
Bash tool with parameters:
- command: "coderabbit review --prompt-only --type uncommitted --base main"
- timeout: 3600000  # 60 minutes
- description: "Execute CodeRabbit review (this will take 7-30+ minutes)"
```

**Why Synchronous, Not Background?**

❌ **Background execution problems:**

- Claude Code thinks task is "complete" immediately
- Hooks fire prematurely (stop-notification, success-notification)
- Claude Code stops monitoring the background process
- Review never gets processed

✅ **Synchronous execution benefits:**

- Claude Code stays active during entire review
- Hooks fire only when review actually completes
- Automatic transition to parsing and fixing phases
- Proper integration with todo tracking

**User Communication**:

Before executing, inform user:

```
"Starting CodeRabbit review. This will take 7-30+ minutes depending on changeset size.
Claude Code will wait and automatically process results when ready.
Please do not interrupt."
```

The `--prompt-only` flag generates token-efficient output specifically designed for AI processing, including:

- Specific file locations and line numbers
- Concise problem descriptions
- Suggested fix approaches

### Phase 3: Parse Review Results

Analyze the CodeRabbit output to identify all issues:

1. Extract each issue section marked by "============================================================================"
2. For each issue, capture:
   - File path
   - Line number(s)
   - Issue type (potential_issue, suggestion, etc.)
   - Detailed prompt for fix

Create a comprehensive todo list with one item per issue using TodoWrite tool:

- Todo content: Brief description of issue (file:line)
- Status: All start as pending

### Phase 4: Systematic Fix Implementation

For each issue in the todo list:

1. **Mark as in_progress** - Update todo status before starting
2. **Read the file** - Use Read tool to examine the relevant file and surrounding context
3. **Understand the issue** - Analyze the CodeRabbit prompt and existing code
4. **Implement the fix** - Use Edit tool to apply the suggested changes
5. **Verify the fix** - Ensure the change addresses the issue without introducing new problems
6. **Mark as completed** - Update todo status after successful fix

### Phase 5: Summary

After all issues are processed:

1. Report total number of issues found and fixed
2. List any issues that could not be automatically fixed (if any)
3. Suggest running tests or additional validation
4. Optionally suggest creating a commit with the fixes

## Important Notes

- **Authentication Required**: Ensure CodeRabbit CLI is authenticated (`coderabbit auth status`)
- **Review Duration**: CodeRabbit reviews take 7-30+ minutes depending on scope
  - User can continue working while review runs in background
  - Check progress with: "Is CodeRabbit finished running?"
  - If review seems stuck, remind Claude Code: "Let CodeRabbit take as long as it takes"
- **Reducing Review Time**: For faster reviews, consider:
  - Use `--type uncommitted` to review only working directory changes
  - Work on smaller feature branches instead of large staging branches
  - Break large features into smaller, reviewable chunks
  - Configure base branch appropriately (`--base develop` vs `--base main`)
- **Incremental Fixes**: Each issue is fixed individually and marked complete before moving to the next
- **Context Preservation**: Read surrounding code to understand the full context before making changes
- **Safety First**: If an issue is unclear or potentially risky, ask for user confirmation before applying the fix
- **Best Practices**: Apply fixes following the project's existing code style and patterns

## Error Handling

If CodeRabbit CLI fails:

- Check authentication status: `coderabbit auth status`
- Verify CodeRabbit CLI is installed and accessible
- Ensure the specified base branch exists
- Report specific error message to user

If no issues are found:

- Confirm with user that codebase is clean
- Suggest running with different parameters if needed
