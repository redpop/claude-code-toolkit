# AgentKit

Modular plugin marketplace for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) with 16 skills, 23 specialized agents, and domain knowledge bases.

## Plugins

| Plugin | Skills | Agents | Description |
|--------|--------|--------|-------------|
| **ak-core** | 5 | 12 | Code analysis, improvement, generation, deployment readiness |
| **ak-security** | 1 | 2 | Security analysis, vulnerability detection, debugging |
| **ak-git** | 1 | 2 | Git operations, smart commits, conflict resolution |
| **ak-meta** | 3 | - | Changelog, handoff, MCP server management |
| **ak-review** | 1 | - | CodeRabbit CLI integration |
| **ak-frontend** | - | 2 | Frontend development, Tailwind CSS |
| **ak-typo3** | 5 | 5 | TYPO3 v13.4 development (Content Blocks, SitePackage, extensions) |

## Installation

### Full Marketplace

```bash
git clone https://github.com/redpop/agentkit.git
cd agentkit
claude plugin marketplace add .
```

### Individual Plugins

```bash
claude plugin add ./plugins/ak-core
claude plugin add ./plugins/ak-security
# ... add only what you need
```

## Quick Start

```bash
# Analyze codebase
/ak-core:understand . --comprehensive

# Improve code
/ak-core:improve . --apply-insights

# Security audit
/ak-security:secure . --audit

# Ship readiness check
/ak-core:ship . --readiness-check

# Smart git commit
/ak-git:operations commit --smart
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI with plugin support

## Previous Version

The pre-plugin architecture (v6.x, `install.sh`-based) is archived at [redpop/claude-code-toolkit-legacy](https://github.com/redpop/claude-code-toolkit-legacy).

## License

MIT
