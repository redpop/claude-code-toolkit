---
description: CodeRabbit CLI integration for automated code review, fixes, and project consistency validation
argument-hint: [--type uncommitted|committed|all] [--base branch-name] [--help]
allowed-tools: Bash(coderabbit:*), Task, Read, Edit, Write, TodoWrite, Grep
---

# CodeRabbit Review & Fix

Execute CodeRabbit CLI review, automatically fix identified issues, and perform critical validation to ensure project-wide consistency.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: CodeRabbit CLI integration for automated code review, fixes, and project consistency validation
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
- **Workflow**:
  - Phase 1: Intelligent base branch detection
  - Phase 2: Execute CodeRabbit review (7-30+ minutes)
  - Phase 3: Parse review results
  - Phase 4: Apply fixes systematically
  - Phase 5: Critical validation & project consistency check
  - Phase 6: Summary & recommendations

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

### Phase 4: Critical Evaluation & Systematic Fix Implementation

**IMPORTANT**: CodeRabbit suggestions must NOT be applied blindly. Each suggestion must be critically evaluated before implementation. CodeRabbit lacks full project context and may produce suggestions that are incorrect, unnecessary, overly complex, or inconsistent with the project's established patterns.

For each issue in the todo list:

1. **Mark as in_progress** - Update todo status before starting
2. **Read the file** - Use Read tool to examine the relevant file and surrounding context
3. **Critically evaluate the suggestion** - Before implementing anything, assess:
   - **Is the issue valid?** Does the problem actually exist, or is it a false positive?
   - **Is the suggested fix appropriate?** Does it fit the project's architecture, conventions, and coding style?
   - **Is the fix necessary?** Does it provide genuine value, or is it purely cosmetic / opinionated?
   - **Could the fix cause harm?** Could it break existing functionality, reduce readability, or introduce unnecessary complexity?
   - **Is there a better alternative?** Would a different approach be more appropriate for this specific codebase?
4. **Decide action** - Based on the evaluation, choose one of:
   - **Apply**: The suggestion is valid and appropriate — implement it
   - **Adapt**: The core idea is valid, but the suggested implementation needs adjustment to fit the project — implement a modified version
   - **Skip**: The suggestion is a false positive, unnecessary, or would cause more harm than good — mark as completed with a brief justification in the todo note
5. **Implement the fix** (if Apply or Adapt) - Use Edit tool to apply the changes
6. **Verify the fix** - Ensure the change addresses the issue without introducing new problems
7. **Mark as completed** - Update todo status after successful fix or justified skip

**Evaluation Guidelines**:

- Prefer **skipping** over applying changes that are purely stylistic preferences with no functional benefit
- Prefer **adapting** over blindly copying CodeRabbit's exact suggestion when project conventions differ
- Always consider the broader context: how does the surrounding code work, and does the suggestion align with it?
- When in doubt about a suggestion's validity or impact, **skip it** and flag it for manual review in Phase 6
- Document the reasoning for skipped or adapted suggestions — this transparency helps the user understand what was done and why

### Phase 5: Critical Validation & Project Consistency Check

**IMPORTANT**: After all fixes are applied, perform a comprehensive validation to ensure changes are consistent with the entire project.

**Why This Phase Is Critical**:

- CodeRabbit may not have full project context when making suggestions
- Local fixes might introduce global inconsistencies
- Architectural patterns and conventions must be maintained
- Dependencies and interactions between components need verification

**Validation Steps**:

1. **Analyze All Applied Changes**:
   - Review every file that was modified during the fixing phase
   - Understand the scope and nature of each change
   - Identify patterns in the modifications

2. **Project-Wide Consistency Check**:
   - **Architectural Patterns**: Verify changes follow existing architecture (MVC, layered, microservices, etc.)
   - **Naming Conventions**: Ensure consistency with project naming standards
   - **Code Style**: Confirm changes match project code style (formatting, conventions)
   - **Dependencies**: Check if changes affect or break existing dependencies
   - **API Contracts**: Verify public interfaces remain compatible
   - **Error Handling**: Ensure error handling patterns are consistent
   - **Import/Export Patterns**: Validate module imports follow project conventions

3. **Cross-Reference Analysis**:
   - Search for similar patterns elsewhere in the codebase using Grep tool
   - Compare applied fixes with existing implementations
   - Identify potential conflicts with other components
   - Check if changes align with established project patterns

4. **Deep Context Validation**:
   - Read related files that interact with modified code
   - Verify data flow and component interactions remain intact
   - Check if changes might break existing functionality
   - Validate business logic consistency

5. **Issue Detection & Correction**:
   - If inconsistencies are found, document them clearly
   - Prioritize issues by severity (breaking vs. style inconsistency)
   - Apply corrective fixes for critical inconsistencies
   - Update todo list with any remaining concerns

6. **Validation Report**:
   - Create detailed report of validation findings
   - List any corrective actions taken
   - Highlight areas requiring manual review (if any)
   - Provide confidence level for applied changes (High/Medium/Low)

**Example Validation Scenarios**:

- **Scenario 1**: CodeRabbit suggests using `async/await`, but project uses Promises consistently
  - **Action**: Revert to Promise-based pattern for consistency
- **Scenario 2**: Fix introduces new dependency that conflicts with existing architecture
  - **Action**: Refactor to use existing project utilities instead
- **Scenario 3**: Naming change breaks established project convention
  - **Action**: Adjust to match project naming standards

**Tools to Use**:

- **Grep**: Search for similar patterns across codebase
- **Read**: Examine related files for context
- **Edit**: Apply corrective fixes if needed
- **TodoWrite**: Track validation findings and remaining concerns

### Phase 6: Summary & Recommendations

After validation is complete:

1. Report total number of issues found and fixed
2. Report validation results and any corrective actions taken
3. List any issues that could not be automatically fixed (if any)
4. Provide confidence assessment for applied changes
5. Suggest running tests or additional validation
6. Recommend manual review areas (if applicable)
7. Optionally suggest creating a commit with the fixes

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
- **Critical Validation Phase**: After all fixes, a comprehensive validation ensures:
  - Changes are consistent with project architecture and patterns
  - No global inconsistencies are introduced
  - Existing functionality remains intact
  - CodeRabbit suggestions are adapted to fit project context
  - Final changes have high confidence level for production use

## Error Handling

If CodeRabbit CLI fails:

- Check authentication status: `coderabbit auth status`
- Verify CodeRabbit CLI is installed and accessible
- Ensure the specified base branch exists
- Report specific error message to user

If no issues are found:

- Confirm with user that codebase is clean
- Suggest running with different parameters if needed
