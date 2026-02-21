# cct-core

Core development plugin for Claude Code Toolkit. Provides the primary development workflow with code analysis, improvement, generation, deployment readiness, and task completion.

## Skills

| Skill | Description |
|-------|-------------|
| `understand` | Code analysis and comprehension with intelligent problem routing |
| `improve` | Code improvement with analysis-driven recommendations |
| `create` | Code and content generation with template-driven creation |
| `ship` | Deployment readiness assessment and quality gates |
| `finalize` | Project-specific task completion workflow |

## Agents

12 specialized agents covering code analysis, architecture, performance, refactoring, planning, documentation, testing, and more.

## Hooks

- **Markdown Format** — Auto-formats .md files after edits using markdownlint-cli2
- **Smart Suggestions** — Context-aware skill recommendations after tool use
- **Quality Gate** — Pre-stop check for task completeness and code quality

## Usage

```bash
/cct-core:understand . --comprehensive
/cct-core:improve . --apply-insights
/cct-core:ship . --readiness-check
```

## Installation

```bash
claude plugin add ./plugins/cct-core
```

Or install the full marketplace:

```bash
claude plugin marketplace add .
```
