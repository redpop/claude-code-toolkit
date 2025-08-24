---
description: Reviews all Git changes before commit to ensure code quality and identify issues
argument-hint: [--staged-only] [--detailed]
---

# Claude Command: Review Changes Before Commit

This command performs a comprehensive review of all Git changes before committing, checking for code quality issues, redundancies, and potential problems.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Reviews all Git changes before commit to ensure code quality and identify issues
- **Usage**: [--staged-only] [--detailed]
- **Options**:
  - `--staged-only`: Review only staged changes
  - `--detailed`: Include detailed code analysis

Then exit without executing the main command.

---

## Usage

```
/review                    # Review all changes (staged and unstaged)
/review --staged-only      # Review only staged changes
/review --detailed         # Include detailed code analysis
```

## What This Command Does

### Phase 1: Status Overview

1. Runs `git status` to get a complete overview of:
   - Staged files ready for commit
   - Modified files not yet staged
   - Untracked files
   - Current branch and upstream status

2. Analyzes the scope of changes:
   - Number of files affected
   - Types of files changed (code, docs, config, etc.)
   - Size of changes (lines added/removed)

### Phase 2: Change Analysis

1. **Staged Changes Review** (`git diff --cached`):
   - Examines all staged changes in detail
   - Identifies the purpose of each change
   - Groups related changes together

2. **Unstaged Changes Review** (`git diff`):
   - Reviews modifications not yet staged
   - Identifies if these should be included in the commit
   - Highlights any incomplete work

3. **Untracked Files Check**:
   - Lists new files that might need to be added
   - Identifies potential missing files (tests, docs, configs)

### Phase 3: Code Quality Check

The command analyzes your changes for:

1. **Code Redundancy**:
   - Duplicate code blocks
   - Similar functions that could be consolidated
   - Repeated patterns that could be abstracted

2. **Consistency Issues**:
   - Naming convention violations
   - Inconsistent formatting or style
   - Mixed paradigms or approaches

3. **Potential Problems**:
   - TODO/FIXME comments that should be resolved
   - Commented-out code that should be removed
   - Debug statements (console.log, print, etc.)
   - Hardcoded values that should be configurable
   - Missing error handling
   - Incomplete implementations

4. **Best Practices**:
   - Missing tests for new functionality
   - Missing or outdated documentation
   - Security concerns (exposed secrets, unsafe operations)
   - Performance issues (inefficient algorithms, memory leaks)

### Phase 4: Commit Organization Analysis

Reviews whether changes should be:

1. **Combined**: All changes belong to a single logical unit
2. **Split**: Multiple distinct changes that should be separate commits
3. **Reordered**: Dependencies between changes that affect commit order

Provides specific recommendations for:

- Which files to stage together
- Suggested commit messages for each logical group
- Order of commits if splitting is recommended

### Phase 5: Comprehensive Report

Generates a structured report with:

#### ✅ **Good to Go**

- Changes that are clean and ready to commit
- Well-structured code additions
- Proper documentation updates

#### ⚠️ **Warnings** (can commit but should consider)

- Minor style inconsistencies
- Opportunities for improvement
- Non-critical suggestions

#### 🔴 **Issues** (should fix before committing)

- Broken code or syntax errors
- Missing required files
- Security vulnerabilities
- Critical bugs or logic errors

#### 💡 **Recommendations**

- Specific commands to run before committing
- Suggested file organization
- Recommended commit structure
- Next steps for a clean commit

## Options

- `--staged-only`: Only review staged changes, ignore unstaged modifications
- `--detailed`: Include more detailed code analysis and suggestions

## Example Output

```
📋 Git Review Report
═══════════════════════════════════════════════════════

📊 Overview:
- Branch: feature/user-auth
- Staged: 5 files (120 additions, 45 deletions)
- Unstaged: 2 files (15 additions, 3 deletions)
- Untracked: 1 file

✅ Good to Go:
- ✓ Authentication logic properly implemented
- ✓ Tests added for new functionality
- ✓ Documentation updated

⚠️ Warnings:
- Mixed use of arrow functions and regular functions in auth.js
- Consider extracting validation logic to separate module
- Package-lock.json has unstaged changes

🔴 Issues to Fix:
- console.log statements found in production code (auth.js:45, auth.js:67)
- TODO comment needs resolution (user.js:23)
- Potential SQL injection vulnerability in query builder (db.js:89)

💡 Recommendations:
1. Remove debug statements:
   - auth.js lines 45, 67
   
2. Stage package-lock.json:
   git add package-lock.json
   
3. Consider splitting into 2 commits:
   - Commit 1: Core authentication implementation
   - Commit 2: Tests and documentation

4. Run before committing:
   npm run lint
   npm run test
```

## Best Practices

This command helps ensure:

1. **Clean Commits**: Each commit is focused and complete
2. **No Debug Code**: Remove console.logs and debug statements
3. **Consistent Code**: Maintain coding standards across changes
4. **Complete Changes**: No partial implementations or TODOs
5. **Proper Testing**: New features have corresponding tests
6. **Documentation**: Code changes are documented
7. **Security**: No exposed secrets or vulnerabilities

## When to Use

Run this command:

- Before any commit to ensure code quality
- After resolving merge conflicts
- Before pushing to shared branches
- When preparing PRs
- After refactoring sessions
- When working on critical features

## Integration with Other Commands

Works well with:

- `/git:commit` - After review, create the commit
- `/scan:quick` - For deeper code analysis
- `/fix:quick-wins` - To automatically fix identified issues

## Important Notes

- This command only reviews and reports, it doesn't make changes
- All file paths in the report are relative to the repository root
- The review considers the project's existing patterns and conventions
- Severity levels help prioritize what must be fixed vs. what's optional
- For large changesets, consider using `--staged-only` to focus the review
