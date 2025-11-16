# /prefix:review:coderabbit

CodeRabbit CLI integration for automated code review and fixes.

## Purpose

Executes CodeRabbit CLI reviews and automatically fixes identified issues using Claude Code. Provides seamless integration between CodeRabbit's AI-powered code review and Claude Code's fix implementation capabilities.

## Syntax

```bash
/prefix:review:coderabbit [--type uncommitted|committed|all] [--base branch-name] [--help]
```

## Arguments

This command uses only optional flags (no positional arguments).

## Options

| Option | Default | Description |
|--------|---------|-------------|
| `--type` | `uncommitted` | Review type: uncommitted, committed, or all changes |
| `--base` | `main` | Base branch for comparison |
| `--help` | - | Display command help and exit |

## Examples

### Basic Usage

```bash
# Review uncommitted changes against main (default)
/prefix:review:coderabbit

# Review all changes
/prefix:review:coderabbit --type all

# Review against develop branch
/prefix:review:coderabbit --base develop
```

### Advanced Usage

```bash
# Review committed changes against develop
/prefix:review:coderabbit --type committed --base develop

# Review all changes against feature branch
/prefix:review:coderabbit --type all --base feature/my-feature
```

## Workflows

### Standard Development Workflow

```bash
# Make changes, then review and fix
/prefix:review:coderabbit
# Fixes are applied automatically
/prefix:git:operations commit --smart --push
```

### Pre-Commit Review

```bash
# Review uncommitted changes before committing
/prefix:review:coderabbit --type uncommitted
# Review and fix issues
/prefix:git:operations commit --smart
```

### Pre-Merge Review

```bash
# Review all changes before merging to main
/prefix:review:coderabbit --type all --base main
# Fix issues and prepare for merge
/prefix:ship . --readiness-check
```

## How It Works

1. **Execute CodeRabbit**: Runs `coderabbit review --prompt-only --type [type] --base [base]` in background
   - Reviews take 7-30+ minutes depending on scope
   - Runs in background so you can continue working
   - Smart monitoring with filtered output checks
2. **Parse Results**: Extracts file paths, line numbers, issue types, and fix suggestions
3. **Create Todos**: Generates a comprehensive todo list for all identified issues
4. **Systematic Fixes**: Processes each issue individually:
   - Reads the affected file
   - Understands the context
   - Implements the suggested fix
   - Verifies the change
   - Marks as completed
5. **Summary**: Reports total issues found and fixed

### Review Duration Management

**Expected Duration**: 7-30+ minutes depending on changeset size

**Background Execution**:

- Review runs in background (CodeRabbit best practice)
- You can continue working while review runs
- Check progress: "Is CodeRabbit finished running?"
- If stuck: "Let CodeRabbit take as long as it takes"

**Reducing Review Time**:

- Use `--type uncommitted` for only working directory changes
- Work on smaller feature branches vs large staging branches
- Break large features into reviewable chunks
- Configure base branch wisely (`--base develop` vs `--base main`)

## Prerequisites

- **CodeRabbit CLI** installed and accessible
- **Authentication** completed: `coderabbit auth status`
- **Base branch** must exist locally or remotely

## Error Handling

If CodeRabbit CLI fails:

- Verify installation: `which coderabbit`
- Check authentication: `coderabbit auth status`
- Ensure base branch exists: `git branch -a | grep [base]`

If no issues found:

- Codebase is clean according to CodeRabbit
- Try different parameters (--type, --base) if needed

## Best Practices

- **Run before committing**: Catch issues early in development
- **Review against main**: Ensure changes align with main branch standards
- **Trust but verify**: Review applied fixes before committing
- **Combine with ship**: Use `/prefix:ship` for final quality checks

## See Also

- [Git Operations](../git/operations.md) - Smart commit management
- [Ship Command](../ship.md) - Deployment readiness checks
- [Improve Command](../improve.md) - Code quality improvements
- [CodeRabbit Documentation](https://docs.coderabbit.ai/cli/claude-code-integration) - Official integration guide
