# ak-core

Core development plugin for AgentKit. Provides the primary development workflow with code analysis, improvement, generation, deployment readiness, and task completion.

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
/ak-core:understand . --comprehensive
/ak-core:improve . --apply-insights
/ak-core:ship . --readiness-check
```

## Installation

```bash
claude plugin add ./plugins/ak-core
```

Or install the full marketplace:

```bash
claude plugin marketplace add .
```
