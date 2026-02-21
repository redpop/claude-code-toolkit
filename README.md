# Claude Code Toolkit

Modular plugin marketplace for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) with 16 skills, 23 specialized agents, and domain knowledge bases.

## Plugins

| Plugin | Skills | Agents | Description |
|--------|--------|--------|-------------|
| **cct-core** | 5 | 12 | Code analysis, improvement, generation, deployment readiness |
| **cct-security** | 1 | 2 | Security analysis, vulnerability detection, debugging |
| **cct-git** | 1 | 2 | Git operations, smart commits, conflict resolution |
| **cct-meta** | 3 | - | Changelog, handoff, MCP server management |
| **cct-review** | 1 | - | CodeRabbit CLI integration |
| **cct-frontend** | - | 2 | Frontend development, Tailwind CSS |
| **cct-typo3** | 5 | 5 | TYPO3 v13.4 development (Content Blocks, SitePackage, extensions) |

## Installation

### Full Marketplace

```bash
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit
claude plugin marketplace add .
```

### Individual Plugins

```bash
claude plugin add ./plugins/cct-core
claude plugin add ./plugins/cct-security
# ... add only what you need
```

## Quick Start

```bash
# Analyze codebase
/cct-core:understand . --comprehensive

# Improve code
/cct-core:improve . --apply-insights

# Security audit
/cct-security:secure . --audit

# Ship readiness check
/cct-core:ship . --readiness-check

# Smart git commit
/cct-git:operations commit --smart
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI with plugin support

## Migrating from v6.x

See [MIGRATION-GUIDE.md](MIGRATION-GUIDE.md) for the complete command mapping and upgrade instructions.

## License

MIT
