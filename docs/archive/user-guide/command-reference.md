# Command Reference

Quick syntax reference for all toolkit commands. For detailed usage examples, see [Workflow Guide](workflow-guide.md).

## Format

```bash
/prefix:category:command [args] [--options]
```

## Scan Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `scan:deep` | `<dir> [--focus] [--export-json]` | Comprehensive analysis |
| `scan:quality` | `<dir> [--compare] [--export]` | Quality metrics |
| `scan:perf` | `<dir> [--profile] [--memory]` | Performance analysis |
| `scan:deps` | `[--outdated] [--vulnerabilities]` | Dependency check |
| `scan:docs` | `<dir> [--coverage] [--sync]` | Documentation health |
| `scan:tests` | `<dir> [--coverage] [--quality]` | Test analysis |
| `scan:report` | `<report.json> [--trends] [--generate-action-plan]` | Report analysis |
| `scan:quick` | `<dir> [--export-json]` | Fast parallel scan |
| `scan:refactor` | `<dir> [--complexity] [--duplicates]` | Refactoring opportunities |
| `scan:root-cause` | `<issue> [--deep]` | Problem investigation |
| `scan:explore` | `<dir> [--keywords] [--patterns]` | Codebase exploration |
| `scan:map` | `<dir> [--dependencies] [--structure]` | Project mapping |

## Fix Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `fix:quick-wins` | `<report.json> [--threshold=8] [--preview]` | High-ROI fixes |
| `fix:security` | `<report.json> [--severity] [--auto-fix]` | Security patches |
| `fix:performance` | `<report.json> [--target] [--safe-only]` | Performance optimization |
| `fix:duplicates` | `<dir> [--threshold] [--preview]` | Remove duplicates |
| `fix:documentation` | `<dir> [--auto-generate] [--sync]` | Doc improvements |
| `fix:shell` | `<file> [--strict] [--shellcheck]` | Shell script fixes |

## Flow Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `flow:smart` | `"<problem description>"` | Intelligent problem routing |
| `flow:review` | `<dir> [--depth] [--focus]` | Multi-perspective review |
| `flow:incident` | `"<description>" [--priority]` | Incident response |
| `flow:refactor` | `<target> [--safety]` | Refactoring workflow |
| `flow:debug-mode` | `[--interactive]` | Debug assistance |

## Auto Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `auto:execute` | `<plan.md> [--mode] [--checkpoint]` | Execute action plans |
| `auto:monitor` | `<dir> [--schedule] [--alerts]` | Continuous monitoring |
| `auto:report` | `<log> [--format] [--metrics]` | Completion reports |
| `auto:sprint` | `<dir> [--duration] [--focus]` | Quality sprints |

## Gen Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `gen:docs` | `<dir> [--format] [--api-docs]` | Generate documentation |
| `gen:tests` | `<file> [--framework] [--coverage]` | Generate tests |
| `gen:format` | `<dir> [--style] [--fix]` | Format code |

## Sec Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `sec:audit` | `<dir> [--depth] [--compliance]` | Security audit |
| `sec:baseline` | `<dir> [--save-to]` | Security baseline |
| `sec:comply` | `<dir> [--standard] [--report]` | Compliance check |

## Meta Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `meta:health` | `[--compare] [--trends]` | Project health |
| `meta:chain` | `"cmd1" -> "cmd2 {output}"` | Command chaining |
| `meta:export` | `<pattern> [--to] [--format]` | Export results |
| `meta:create` | `"<desc>" [--type] [--category]` | Create components |
| `meta:summary` | `[--last] [--format]` | Session summary |
| `meta:find-cmd` | `"<capability>"` | Find commands |

## Git Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `git:commit` | `[--conventional] [--include-changes]` | Smart commits |

## TYPO3 Commands

| Command | Syntax | Purpose |
|---------|--------|---------|
| `typo3:content-blocks` | `<name> [--fields] [--preview]` | Content Blocks |
| `typo3:extension-kickstarter` | `<key> [--version] [--template]` | Extension scaffold |
| `typo3:fluid-components` | `<name> [--atomic]` | Fluid components |
| `typo3:sitepackage` | `<name> [--bootstrap]` | Sitepackage setup |

## Common Options

| Option | Description |
|--------|-------------|
| `--export-json` | Export as JSON |
| `--export-md` | Export as Markdown |
| `--preview` | Preview without applying |
| `--dry-run` | Simulate changes |
| `--interactive` | Interactive mode |
| `--latest` | Use most recent report |
| `--compare=<file>` | Compare with baseline |

For detailed usage, see [Workflow Guide](workflow-guide.md)
