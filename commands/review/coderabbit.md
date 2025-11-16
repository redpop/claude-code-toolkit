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
  - `--base`: Base branch for comparison (default: main)
- **Examples**:
  - `/prefix:review:coderabbit` - Review uncommitted changes against main
  - `/prefix:review:coderabbit --type all` - Review all changes
  - `/prefix:review:coderabbit --base develop` - Review against develop branch
  - `/prefix:review:coderabbit --type committed --base develop` - Review committed changes against develop

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract options with defaults:

- `type`: uncommitted (default) | committed | all
- `base`: main (default) | any branch name

## Workflow

### Phase 1: Execute CodeRabbit Review

**IMPORTANT**: CodeRabbit reviews can take 7-30+ minutes. Follow CodeRabbit's best practices for background execution.

Use Bash tool to run CodeRabbit CLI in background:

```bash
coderabbit review --prompt-only --type [type] --base [base]
```

**Execution Requirements** (following CodeRabbit best practices):

1. **Start in Background**: Use Bash tool WITH `run_in_background: true`
2. **No Timeout**: CodeRabbit needs as long as it takes (7-30+ minutes for large reviews)
3. **User Communication**: Inform user that review is running in background
4. **Smart Monitoring**: Use BashOutput with filter to wait for completion signal

**Example Bash Tool Usage**:

```
Bash tool with parameters:
- command: "coderabbit review --prompt-only --type uncommitted --base main"
- run_in_background: true
- description: "Execute CodeRabbit review in background"
```

**Monitoring Strategy**:

After starting the background process, use BashOutput with a filter to efficiently wait for completion:

```
BashOutput with parameters:
- bash_id: [id from background Bash execution]
- filter: "Review completed|============================================================================"
```

This filter approach:

- ✅ Follows CodeRabbit's "run in background" recommendation
- ✅ Allows reviews to take as long as needed (7-30+ minutes)
- ✅ Reduces BashOutput calls to only meaningful updates
- ✅ User can continue working while review runs

The `--prompt-only` flag generates token-efficient output specifically designed for AI processing, including:

- Specific file locations and line numbers
- Concise problem descriptions
- Suggested fix approaches

### Phase 2: Parse Review Results

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

### Phase 3: Systematic Fix Implementation

For each issue in the todo list:

1. **Mark as in_progress** - Update todo status before starting
2. **Read the file** - Use Read tool to examine the relevant file and surrounding context
3. **Understand the issue** - Analyze the CodeRabbit prompt and existing code
4. **Implement the fix** - Use Edit tool to apply the suggested changes
5. **Verify the fix** - Ensure the change addresses the issue without introducing new problems
6. **Mark as completed** - Update todo status after successful fix

### Phase 4: Summary

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
