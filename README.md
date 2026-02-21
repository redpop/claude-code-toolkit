# AgentKit

Modular plugin marketplace for [Claude Code](https://docs.anthropic.com/en/docs/claude-code) with 10 skills, 9 specialized agents, and domain knowledge bases.

## Plugins

| Plugin | Skills | Agents | Description |
|--------|--------|--------|-------------|
| **ak-core** | 1 | 2 | Task completion workflow, refactoring and performance agents, markdown formatting hooks |
| **ak-git** | 1 | 2 | Git operations, smart commits, conflict resolution |
| **ak-meta** | 2 | - | Changelog generation, AI context handoff |
| **ak-review** | 1 | - | CodeRabbit CLI integration |
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
claude plugin add ./plugins/ak-git
# ... add only what you need
```

## Quick Start

```bash
# Smart git commit
/ak-git:operations commit --smart

# Run task completion workflow
/ak-core:finalize

# Code review
/ak-review:coderabbit

# Generate changelog
/ak-meta:changelog

# TYPO3 sitepackage
/ak-typo3:sitepackage my-site
```

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) CLI with plugin support

## Previous Version

The pre-plugin architecture (v6.x, `install.sh`-based) is archived at [redpop/claude-code-toolkit-legacy](https://github.com/redpop/claude-code-toolkit-legacy).

## License

MIT
