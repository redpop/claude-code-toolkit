# Migration Guide: v6.x to v7.0

## Overview

v7.0 migrates from the custom `install.sh`-based system to the official Claude Code Plugin Architecture. Instead of one monolithic installation, the toolkit is now split into 7 independent plugins.

## Key Changes

| Aspect | v6.x | v7.0 |
|--------|------|------|
| Installation | `./install.sh myprefix` | `claude plugin marketplace add .` |
| Commands | `/myprefix:understand` | `/cct-core:understand` |
| Location | `~/.claude/commands/myprefix/` | Plugin system (managed by Claude Code) |
| Agents | `~/.claude/agents/` | Per-plugin `agents/` directories |
| Hooks | `~/.claude/settings.json` | Per-plugin `hooks/hooks.json` |
| Knowledge | `~/.claude/claude-code-toolkit/knowledge-base/` | Per-plugin `knowledge/` directories |

## Command Mapping

### Core Commands

| v6.x | v7.0 |
|------|------|
| `/prefix:understand` | `/cct-core:understand` |
| `/prefix:improve` | `/cct-core:improve` |
| `/prefix:create` | `/cct-core:create` |
| `/prefix:ship` | `/cct-core:ship` |
| `/prefix:finalize` | `/cct-core:finalize` |

### Security

| v6.x | v7.0 |
|------|------|
| `/prefix:secure` | `/cct-security:secure` |

### Git

| v6.x | v7.0 |
|------|------|
| `/prefix:git:operations` | `/cct-git:operations` |

### Meta

| v6.x | v7.0 |
|------|------|
| `/prefix:meta:changelog` | `/cct-meta:changelog` |
| `/prefix:meta:handoff` | `/cct-meta:handoff` |
| `/prefix:meta:mcp` | `/cct-meta:mcp` |

### Review

| v6.x | v7.0 |
|------|------|
| `/prefix:review:coderabbit` | `/cct-review:coderabbit` |

### TYPO3

| v6.x | v7.0 |
|------|------|
| `/prefix:typo3:content-blocks` | `/cct-typo3:content-blocks` |
| `/prefix:typo3:sitepackage` | `/cct-typo3:sitepackage` |
| `/prefix:typo3:extension-kickstarter` | `/cct-typo3:extension-kickstarter` |
| `/prefix:typo3:fluid-components` | `/cct-typo3:fluid-components` |
| `/prefix:typo3:make-content-block` | `/cct-typo3:make-content-block` |

## Agent Changes

### Removed Agents

- `deployment-specialist` — Consolidated into `ship` skill
- `documentation-health-specialist` — Merged into `documentation-specialist`
- `external-research-specialist` — Removed (web search is a Claude Code built-in)

### Remaining Agents (23 total)

All agents have been rewritten with streamlined format (60-120 lines instead of 100-250+).

## Hook Changes

v6.x had 10+ hook scripts for sounds, logging, and notifications. v7.0 reduces to 3 smart hooks:

1. **Markdown Format** — Auto-formats .md files (ported from v6.x)
2. **Smart Suggestions** — Context-aware skill recommendations (replaces smart-suggestions.sh + suggestion-engine.sh)
3. **Quality Gate** — Pre-stop quality check (new)

**Not migrated**: Sound notifications, session logging, system notifications, command chain tracking.

## Installation

### Fresh Install

```bash
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit

# Install all plugins
claude plugin marketplace add .

# Or install individual plugins
claude plugin add ./plugins/cct-core
claude plugin add ./plugins/cct-security
```

### Cleanup v6.x

After installing v7.0, you can remove the old installation:

```bash
# Remove old commands (replace 'myprefix' with your prefix)
rm -rf ~/.claude/commands/myprefix/

# Remove old agents
rm -rf ~/.claude/agents/

# Remove old hooks and knowledge base
rm -rf ~/.claude/claude-code-toolkit/

# Remove old hook entries from settings.json (manual)
```

## Selective Installation

You don't need all 7 plugins. Install only what you need:

- **Every project**: `cct-core` (the essential workflow)
- **Security-focused**: + `cct-security`
- **Git workflow**: + `cct-git`
- **TYPO3 projects**: + `cct-typo3` + `cct-frontend`
- **Code review**: + `cct-review`
- **Project management**: + `cct-meta`
