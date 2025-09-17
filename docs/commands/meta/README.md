# Meta Commands

Project and toolkit management commands for Claude Code.

## Available Commands

| Command | Purpose |
|---------|---------|
| [changelog](changelog.md) | AI-powered CHANGELOG.md management with automatic version detection |
| [handoff](handoff.md) | Documents current problem context for AI assistant handoff |

## Usage Pattern

Meta commands manage the development process itself rather than the code:

```bash
# Project documentation and handoffs
/prefix:meta:handoff
/prefix:meta:handoff --compact

# Version and changelog management
/prefix:meta:changelog
/prefix:meta:changelog --fast --update-version
```

## Integration with Core Commands

Meta commands complement the 6-command architecture:

```bash
# Analysis and documentation workflow
/prefix:understand . --comprehensive
/prefix:meta:handoff debug-analysis.md --focus "performance issues"

# Release preparation workflow
/prefix:ship . --readiness-check
/prefix:meta:changelog --fast --update-version
```

## See Also

- [Core Commands](../README.md) - Main 6-command architecture
- [TYPO3 Commands](../typo3/README.md) - TYPO3-specific development tools
