---
description: Smart Git operations with intelligent commit creation and change review
argument-hint: [type] [options] [--help]
allowed-tools: Read, Write, Bash(git:*)
---

# Git - Smart Git Operations

Intelligent Git command that automatically handles commits and reviews with smart defaults. Zero configuration, maximum workflow efficiency.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Git Operations

**Automatically analyzes changes and applies best Git practices with conventional commit format.**

### Available Git Operations

- `commit` - Smart commit creation with conventional format (default)
- `review` - Comprehensive change review before commit
- `simple` - Simple commit with branch prefix extraction
- `fast` - Quick commit with auto-selection
- `push` - Commit and push in one operation

## Usage

```bash
# Smart defaults - intelligent commit creation
/prefix:git

# Specific Git operations
/prefix:git commit              # Smart commit with analysis
/prefix:git review             # Review changes before commit
/prefix:git simple             # Simple commit with branch prefix
/prefix:git fast               # Quick commit, auto-select first option

# With options
/prefix:git commit --push      # Commit and push
/prefix:git simple --brief     # Simple commit, single-line messages
/prefix:git review --detailed  # Detailed code analysis
/prefix:git fast --no-verify   # Skip pre-commit hooks
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine Git operation type and options**

```bash
# Parse arguments
args=($ARGUMENTS)
git_operation="commit"    # default to smart commit

# Check for operation type
git_operations=("commit" "review" "simple" "fast" "push")
if [[ " ${git_operations[@]} " =~ " ${args[0]} " ]]; then
    git_operation=${args[0]}
    remaining_args="${args[@]:1}"
else
    remaining_args="${args[*]}"
fi

# Handle composite operations
if [[ "$remaining_args" == *"--push"* ]]; then
    git_operation="push"
elif [[ "$remaining_args" == *"--fast"* ]]; then
    git_operation="fast"
fi
```

**Step 2: Execute appropriate Git workflow**

Based on git_operation, execute the optimal strategy:

### Smart Commit Creation (Default)

**Process**: Intelligent commit analysis and creation
**Output**: Structured commits with conventional format and emojis

**Workflow:**

1. **Pre-commit Validation**: Run pre-commit hooks unless `--no-verify` specified
2. **Change Analysis**: Check staged files, auto-add if none staged
3. **Diff Analysis**: Analyze `git diff` to understand changes
4. **Commit Strategy**:
   - Single logical change → Single commit
   - Multiple changes → Suggest split into atomic commits
5. **Message Generation**: Create conventional commit format with emoji
6. **Push Option**: Auto-push if `--push` specified

**Implementation:**

```bash
# Check for staged files
git status --porcelain

# If no staged files, stage all changes
if [[ -z "$(git diff --cached --name-only)" ]]; then
    git add -A
fi

# Analyze changes
git diff --cached --stat
git diff --cached

# Generate structured commit message with:
# - Type prefix (feat, fix, docs, style, refactor, test, chore)
# - Emoji indicator
# - Conventional commit format
# - Multi-line description for complex changes
```

### Comprehensive Change Review

**Process**: Multi-perspective analysis of all changes
**Output**: Detailed review report with recommendations

**Workflow:**

1. **Status Overview**: Complete Git status analysis
2. **Change Categorization**: Group changes by type and impact
3. **Quality Assessment**: Code quality and best practices review
4. **Risk Analysis**: Identify potential issues and breaking changes
5. **Recommendations**: Actionable feedback for improvement

**Implementation:**

```bash
# Comprehensive status check
git status --verbose
git diff --name-status
git diff --stat

# Analyze each changed file
# - Code quality patterns
# - Potential issues
# - Breaking change indicators
# - Testing recommendations
```

### Simple Commit with Branch Prefix

**Process**: Streamlined commit with branch-based prefixes
**Output**: Clean commits with ticket/branch prefix extraction

**Workflow:**

1. **Branch Analysis**: Extract ticket number or prefix from branch name
2. **Change Grouping**: Group related changes intelligently
3. **Message Creation**: Simple, clean commit messages
4. **Atomic Commits**: Create focused, single-purpose commits

**Implementation:**

```bash
# Extract branch prefix (e.g., JIRA-123, feature/auth, bugfix/login)
current_branch=$(git branch --show-current)
prefix=""
if [[ $current_branch =~ ^([A-Z]+-[0-9]+|[a-z]+/[a-z-]+) ]]; then
    prefix="${BASH_REMATCH[1]}: "
fi

# Create clean, prefixed commit messages
```

### Fast Commit Mode

**Process**: Quick commit with smart auto-selection
**Output**: Rapid commits with first suggested message

**Workflow:**

1. **Quick Analysis**: Fast change assessment
2. **Auto-Selection**: Use first/best commit message suggestion
3. **Minimal Interaction**: Skip interactive choices
4. **Speed Optimized**: Fastest path to commit

### Push Operation

**Process**: Commit and push in single workflow
**Output**: Committed and pushed changes

**Workflow:**

1. **Smart Commit**: Execute appropriate commit strategy
2. **Push Validation**: Check remote status and conflicts
3. **Auto-Push**: Push to current upstream branch
4. **Feedback**: Confirm successful push with URL if available

### Git Review Analysis

When `review` operation is selected, perform comprehensive analysis:

**Phase 1: Change Overview**

- Staged vs unstaged changes
- File modification summary
- Change impact assessment

**Phase 2: Code Quality Review**

- Syntax and formatting issues
- Code complexity analysis  
- Best practices compliance
- Security concern identification

**Phase 3: Git Best Practices**

- Commit atomicity assessment
- Message quality evaluation
- Branch strategy compliance
- Merge conflict potential

**Phase 4: Recommendations**

- Suggested improvements
- Risk mitigation strategies
- Testing recommendations
- Documentation updates needed

## Conventional Commit Format

All commits follow conventional commit standards:

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Commit Types with Emojis

- `✨ feat:` - New features
- `🐛 fix:` - Bug fixes
- `📚 docs:` - Documentation changes
- `💎 style:` - Code style/formatting
- `♻️ refactor:` - Code refactoring
- `⚡ perf:` - Performance improvements
- `🧪 test:` - Testing changes
- `🔧 chore:` - Build/maintenance tasks
- `🚀 ci:` - CI/CD changes
- `⚠️ BREAKING CHANGE:` - Breaking changes

## Options Support

### Global Options

- `--no-verify` - Skip pre-commit hooks
- `--push` - Push after commit
- `--help` - Show detailed help

### Operation-Specific Options

- `--fast` - Auto-select first suggestion (commit)
- `--single` - Single commit for all changes (simple)
- `--brief` - Single-line messages only (simple)
- `--staged-only` - Review only staged changes (review)
- `--detailed` - Include detailed analysis (review)

## Next Steps Recommendations

After Git operation completion, display context-aware recommendations:

```markdown
✅ [Git Operation] completed successfully

📝 **Commits Created**: [Number and summary of commits]
🔄 **Status**: [Current Git status]
🌐 **Remote**: [Push status and remote URL]

💡 **Recommended next steps:**
   /prefix:work review          # Get code review before push
   /prefix:analyze quality      # Verify code quality
   /prefix:git push            # Push commits to remote

   **Or describe your next goal:** "I need to create a pull request"
```

### Smart Next-Step Logic

Based on Git operation results:

- **Commits created** → Suggest `/prefix:git push` or `/prefix:work review`
- **Review completed** → Suggest `/prefix:git commit` with improvements
- **Changes pushed** → Suggest creating PR/MR or running CI checks
- **Multiple commits** → Suggest squashing or rebase if needed

## Benefits

- **Smart Defaults**: Automatically handles common Git workflows with minimal input
- **Conventional Commits**: Enforces consistent, professional commit messages
- **Change Intelligence**: Analyzes diffs to suggest optimal commit strategies
- **Quality Assurance**: Built-in review and validation capabilities
- **Workflow Integration**: Seamlessly handles commit-review-push cycles
- **One Interface**: Replaces multiple specialized Git commands

*Consolidates: git:commit, git:commit-simple (smart routing replaces both)*
