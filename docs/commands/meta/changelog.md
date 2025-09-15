# /prefix:meta:changelog

AI-powered CHANGELOG.md management that automatically determines version based on changes.

## Purpose

Intelligently manages your project's CHANGELOG.md file by analyzing changes and automatically determining appropriate version bumps following Keep a Changelog format and Semantic Versioning conventions.

## Syntax

```bash
/prefix:meta:changelog [--commit] [--push] [--fast] [--update-version]
```

## Options

| Option | Description |
|--------|-------------|
| `--commit` | Automatically commit the changelog update |
| `--push` | Also push the commit to the remote repository (requires --commit) |
| `--fast` | Shortcut for --commit --push (update, commit, and push in one command) |
| `--update-version` | Also update version in package files |

## Examples

### Basic Usage

```bash
# AI analyzes and updates changelog
/prefix:meta:changelog

# Update changelog and commit using git commit command
/prefix:meta:changelog --commit

# Update changelog, commit, and push in one command
/prefix:meta:changelog --fast

# Also update version in package files
/prefix:meta:changelog --update-version

# Full automated workflow
/prefix:meta:changelog --commit --update-version
```

## Workflows

### Standard Changelog Update

```bash
/prefix:meta:changelog
# Review the changes
/prefix:git commit --smart
```

### Automated Release Workflow

```bash
/prefix:meta:changelog --fast --update-version
# Changelog updated, version bumped, committed and pushed
```

## See Also

- [/prefix:git](../git.md) - Git operations and workflow management
- [Keep a Changelog](https://keepachangelog.com/) - Changelog format reference
- [Semantic Versioning](https://semver.org/) - Version numbering conventions
