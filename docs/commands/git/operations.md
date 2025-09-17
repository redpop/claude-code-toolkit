# /prefix:git:operations

Smart Git operations with project context and commit pattern learning.

## Purpose

Provides intelligent Git operations with project context awareness, smart commit message generation, and workflow management for modern development practices.

## Syntax

```bash
/prefix:git:operations [operation] [--push] [--no-verify] [--smart] [--pattern-learn] [--interactive] [--dry-run] [--help]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `operation` | `commit` | Git operation (commit, push, pull, merge, etc.) |

## Options

| Option | Description |
|--------|-------------|
| `--push` | Also push after commit |
| `--no-verify` | Skip pre-commit hooks |
| `--smart` | Use AI-generated commit messages |
| `--pattern-learn` | Learn from project commit patterns |
| `--interactive` | Interactive mode for complex operations |
| `--dry-run` | Show what would be done without executing |

## Examples

### Basic Usage

```bash
# Smart commit with AI-generated message
/prefix:git:operations commit --smart

# Commit and push
/prefix:git:operations commit --smart --push

# Interactive merge conflict resolution
/prefix:git:operations merge --interactive
```

### Advanced Operations

```bash
# Learn from project patterns
/prefix:git:operations commit --pattern-learn

# Dry run to preview operations
/prefix:git:operations push --dry-run

# Skip hooks for emergency commits
/prefix:git:operations commit --no-verify
```

## Workflows

### Standard Development Workflow

```bash
/prefix:understand . --quick
/prefix:improve . --apply-insights
/prefix:git:operations commit --smart --push
```

### Release Workflow

```bash
/prefix:ship . --readiness-check
/prefix:git:operations commit --smart
/prefix:meta:changelog --fast
```

## See Also

- [Meta Commands](../meta/README.md) - Project and toolkit management
- [Core Commands](../README.md) - Main 5-command architecture
- Git best practices and workflow patterns
