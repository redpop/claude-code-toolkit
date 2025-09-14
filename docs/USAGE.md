# Usage Guide

Simple guide for using the Claude Code Toolkit's 6 core commands plus extensions.

## Core Commands

### understand

Analyze and comprehend code structure, patterns, and issues.

```bash
/prefix:understand <target> [--comprehensive|--quick]
```

**Examples:**

- `/myprefix:understand . --comprehensive` - Deep analysis of entire project
- `/myprefix:understand src/auth --quick` - Quick analysis of auth module

### improve

Apply improvements with intelligent routing and learning persistence.

```bash
/prefix:improve <target> [--dry-run] [--severity=high|medium|low]
```

**Examples:**

- `/myprefix:improve . --dry-run` - Show what would be improved
- `/myprefix:improve src/ --severity=high` - Fix high-priority issues only

### create

Generate code and content with intelligent templating.

```bash
/prefix:create <type> <target> [--format=...]
```

**Examples:**

- `/myprefix:create component UserProfile` - Create new component
- `/myprefix:create docs --format=api` - Generate API documentation

### secure

Security analysis and vulnerability detection.

```bash
/prefix:secure <target> [--standard=owasp] [--audit]
```

**Examples:**

- `/myprefix:secure . --standard=owasp` - OWASP security scan
- `/myprefix:secure api/ --audit` - Security audit of API

### ship

Deployment readiness and quality gates.

```bash
/prefix:ship <target> [--check=all] [--readiness]
```

**Examples:**

- `/myprefix:ship . --check=all` - Complete readiness check
- `/myprefix:ship dist/ --readiness` - Check deployment readiness

### git

Smart Git operations with project context.

```bash
/prefix:git <operation> [--push] [--no-verify]
```

**Examples:**

- `/myprefix:git commit --push` - Smart commit with push
- `/myprefix:git status` - Enhanced git status

## Extensions

### Meta Commands

**changelog** - AI-powered CHANGELOG.md management

```bash
/prefix:meta:changelog [--commit] [--push] [--fast]
```

**handoff** - Document problem context for AI handoff

```bash
/prefix:meta:handoff [filename] [--compact] [--technical]
```

### TYPO3 Commands

**content-blocks** - Generate TYPO3 Content Blocks v1.3

```bash
/prefix:typo3:content-blocks <name> [--type=element|page]
```

**fluid-components** - Generate Fluid v4 Components

```bash
/prefix:typo3:fluid-components <name> [--type=atom|molecule|organism]
```

**sitepackage** - Create TYPO3 sitepackages

```bash
/prefix:typo3:sitepackage <name> [--composer-name=...]
```

Plus: extension-kickstarter, make-content-block

## Quick Workflows

**Deep Analysis Pipeline:**

```bash
/prefix:understand . --comprehensive
/prefix:improve . --apply-insights
/prefix:secure . --audit
```

**Quick Quality Check:**

```bash
/prefix:understand . --quick
/prefix:improve . --dry-run
/prefix:ship . --check=basic
```

**Release Workflow:**

```bash
/prefix:meta:changelog --fast
/prefix:ship . --readiness
/prefix:git commit --push
```

## Installation

See [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md) for setup instructions.

## Hook Management

The toolkit includes an intelligent hook system for enhanced development experience:

### Managing Hooks

```bash
# List all available hooks with status
./scripts/manage-hooks.sh list

# Show detailed hook information
./scripts/manage-hooks.sh info session-end-summary

# Enable/disable specific hooks
./scripts/manage-hooks.sh enable enhanced-command-logger
./scripts/manage-hooks.sh disable stop-notification

# System health check
./scripts/manage-hooks.sh doctor

# View usage statistics
./scripts/manage-hooks.sh stats
```

### Key Hooks

- **session-end-summary** - Intelligent session summaries with Basic Memory
- **enhanced-command-logger** - Command statistics and pattern tracking
- **command-chain-notification** - Progress tracking for command chains
- **context-refresh** - Automatic context preservation
- **markdown-format** - Auto-format markdown files
- **stop-notification** - Sound notifications

### Hook Features

- **Basic Memory Integration** - Context preservation across sessions
- **Command Statistics** - Usage analytics and efficiency insights
- **Smart Notifications** - Context-aware alerts and summaries
- **Smart Suggestions** - Intelligent workflow recommendations based on file modifications
- **Project Intelligence** - Automatic project type detection and suggestions

See [Enhanced Hooks Guide](guides/ENHANCED-HOOKS.md) for detailed documentation.

## Troubleshooting

**Command not found**: Verify installation and prefix configuration
**Permission errors**: Check file permissions and git repository status
**MCP issues**: Commands work without MCP, but enhanced with it
**Hook issues**: Run `./scripts/manage-hooks.sh doctor` for diagnostics

For additional help, use `--help` with any command or check the hook management CLI.
