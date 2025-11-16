# Review Commands

Code review integration and automated fix implementation.

## Available Commands

| Command | Purpose |
|---------|---------|
| [coderabbit](coderabbit.md) | CodeRabbit CLI integration for automated code review and fixes |

## Usage Pattern

Review commands integrate external code review tools with Claude Code's fix capabilities:

```bash
# Review uncommitted changes and auto-fix issues
/prefix:review:coderabbit

# Review all changes against develop branch
/prefix:review:coderabbit --type all --base develop

# Review committed changes only
/prefix:review:coderabbit --type committed
```

## Integration with Core Commands

Review commands complement the 5-command architecture:

```bash
# Pre-commit review workflow
/prefix:review:coderabbit
/prefix:secure . --audit
/prefix:ship . --readiness-check
/prefix:git:operations commit --smart --push

# Comprehensive quality workflow
/prefix:understand . --comprehensive
/prefix:improve . --apply-insights
/prefix:review:coderabbit --type all
/prefix:ship . --quality-gates
```

## Features

- **Automated Review**: Execute code reviews via CLI tools
- **Intelligent Parsing**: Extract and process review findings
- **Systematic Fixes**: Apply fixes one by one with verification
- **Todo Tracking**: Track progress through review issues
- **Integration Ready**: Works with external review platforms

## Supported Review Tools

### CodeRabbit

CodeRabbit provides AI-powered code review with Claude Code integration:

- **Prerequisites**: CodeRabbit CLI installed and authenticated
- **Output Format**: Token-efficient `--prompt-only` format
- **Fix Automation**: Claude Code automatically implements suggested fixes
- **Documentation**: [CodeRabbit CLI Integration](https://docs.coderabbit.ai/cli/claude-code-integration)

## Best Practices

- **Early Review**: Run reviews before committing changes
- **Base Branch**: Always specify appropriate base branch (main, develop, etc.)
- **Combined Validation**: Use with `/prefix:ship` for comprehensive quality checks
- **Verify Fixes**: Review applied changes before pushing

## See Also

- [Core Commands](../README.md) - Main 5-command architecture
- [Git Commands](../git/README.md) - Smart Git operations
- [Ship Command](../ship.md) - Deployment readiness validation
- [Improve Command](../improve.md) - Code quality improvements
