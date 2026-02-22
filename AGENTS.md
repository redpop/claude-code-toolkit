# AGENTS.md

This file provides guidance to AI agents (Claude Code, Warp AI, etc.) when working with the AgentKit repository.

## Project overview

Claude Code plugin marketplace (`ak-marketplace`) with 5 independently installable plugins, 11 skills, 9 agents, and domain knowledge bases. Built on the official Claude Code Plugin Architecture.

## Dev environment

No build step required — the codebase is pure Markdown, JSON, and shell scripts.

**Test a plugin locally:**

```bash
claude --plugin-dir ./plugins/ak-core
```

**Test full marketplace:**

```bash
claude plugin marketplace add .
```

**Validate markdown formatting:**

```bash
markdownlint-cli2 "plugins/**/*.md"
```

**Validate JSON files:**

```bash
python3 -m json.tool .claude-plugin/marketplace.json > /dev/null
python3 -m json.tool plugins/ak-core/.claude-plugin/plugin.json > /dev/null
```

**Validate shell scripts:**

```bash
shellcheck plugins/ak-core/hooks/markdown-format.sh
```

## Monorepo structure

This is a monorepo — each plugin directory can contain its own AGENTS.md for plugin-specific context. The closest AGENTS.md to the edited file takes precedence.

```
.claude-plugin/marketplace.json    ← Root marketplace config
plugins/{plugin-name}/
├── .claude-plugin/plugin.json     ← Plugin metadata
├── skills/{skill}/SKILL.md        ← Slash commands (/plugin:skill args)
├── agents/{name}.md               ← Sub-agents (via Task tool)
├── knowledge/                     ← Domain reference files (optional)
├── hooks/hooks.json               ← Hook definitions (optional)
└── README.md
```

| Plugin | Skills | Agents | Extras |
|--------|--------|--------|--------|
| `ak-core` | finalize, validate-all | 2 | hooks, markdownlint config |
| `ak-git` | operations | 2 | |
| `ak-meta` | changelog, handoff | - | |
| `ak-review` | coderabbit | - | |
| `ak-typo3` | 5 TYPO3 skills | 5 | knowledge/ (14 files) |

## Code style guidelines

### SKILL.md format

```yaml
---
name: skill-name
description: When this skill should be used
---
```

Body: Arguments parsing (`$ARGUMENTS`), Execution workflow, Output format template. Skills route to agents via `Task tool with subagent_type="{agent-name}"`.

### Agent .md format

```yaml
---
name: agent-name-kebab-case
description: |
  When to invoke this agent.
  <example>Use when...</example>
---
```

Body: Identity statement, Core expertise, Knowledge references (`${CLAUDE_PLUGIN_ROOT}/knowledge/`), Methodology (numbered phases), Output format. Target 60-120 lines.

### plugin.json

Required: `name`, `description`, `version`. Optional: `hooks` (path to hooks.json), `mcpServers` (path to .mcp.json).

### marketplace.json

Each plugin entry needs `name`, `source` (relative path), `version`, `category`.

### Hooks (hooks.json)

Wrapper format: `{"description": "...", "hooks": {...}}`. The `${CLAUDE_PLUGIN_ROOT}` variable resolves to the plugin's absolute directory at runtime. Hook scripts must always `exit 0`.

## Commit and PR guidelines

- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`
- Scope by plugin when applicable: `feat(ak-typo3): add content block field type`
- Keep versions synchronized across `marketplace.json` and all `plugin.json` files (currently `1.1.3`)

## Task completion workflow

After implementing changes:

1. **Format** — Verify markdown formatting (auto-handled by markdown-format hook)
2. **Simplify** — Simplify changed code for clarity and maintainability
   - Claude Code: invoke the `refactoring-expert` agent on modified files
3. **Review** — Run CodeRabbit review on uncommitted changes, then fix reported issues
   - Claude Code: invoke `/ak-review:coderabbit`
   - Other tools: run `coderabbit review --prompt-only --type uncommitted`

Skip steps 2-3 for trivial changes (typo fixes, config updates, single-line changes).

## Important conventions

- Agents can analyze code and implement changes directly (Edit/Write tools enabled)
- Knowledge files are referenced explicitly in agents via `${CLAUDE_PLUGIN_ROOT}/knowledge/path`
- The `$ARGUMENTS` placeholder receives user input in skills
- Documentation is written in English
- The `markdown-format.sh` hook requires `markdownlint-cli2` (Homebrew preferred, npx fallback)
