# ak-core

Core development plugin for AgentKit. Provides task completion workflow, code refactoring and performance optimization agents, and markdown formatting hooks.

## Skills

| Skill | Description |
|-------|-------------|
| `finalize` | Project-specific task completion workflow |

## Agents

| Agent | Description |
|-------|-------------|
| `refactoring-expert` | Code refactoring with clean code principles and design patterns |
| `performance-optimizer` | Performance analysis, bottleneck identification, and optimization |

## Hooks

- **Markdown Format** — Auto-formats .md files after edits using markdownlint-cli2
- **Smart Suggestions** — Context-aware skill recommendations after tool use
- **Quality Gate** — Pre-stop check for task completeness and code quality

## Usage

```bash
/ak-core:finalize
```

## Installation

```bash
claude plugin add ./plugins/ak-core
```

Or install the full marketplace:

```bash
claude plugin marketplace add .
```
