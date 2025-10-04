# understand

Analyze and comprehend code structure, patterns, and issues with intelligent problem routing.

## Syntax

```bash
/prefix:understand [type] [target] [options]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `type` | `code` | Analysis type: code, performance, security, architecture, debug, flow, dependencies, tests, docs, legacy |
| `target` | `.` | File or directory to analyze |

## Options

| Option | Description |
|--------|-------------|
| `--comprehensive` | Deep analysis with full context |
| `--quick` | Fast analysis for immediate insights |
| `--export-json` | Generate timestamped JSON report |
| `--export-md` | Generate timestamped Markdown report |
| `--help` | Show detailed help information |

## Examples

```bash
# Quick analysis of current directory
/prefix:understand

# Comprehensive analysis with JSON export
/prefix:understand . --comprehensive --export-json

# Security-focused analysis of auth module
/prefix:understand security src/auth

# Performance analysis
/prefix:understand performance --comprehensive

# Quick documentation analysis
/prefix:understand docs --quick
```

## Workflows

**Development Workflow**:

```bash
/prefix:understand . --quick           # Initial assessment
/prefix:improve . --apply-insights     # Apply findings
/prefix:ship . --readiness-check       # Validate changes
```

**Deep Analysis Workflow**:

```bash
/prefix:understand . --comprehensive --export-json
/prefix:improve . --from-analysis
/prefix:ship . --readiness-check
```

## See Also

- [`improve`](improve.md) - Apply improvements based on analysis
- [`secure`](secure.md) - Security-focused analysis
- [`create`](create.md) - Generate code from analysis insights
- [`ship`](ship.md) - Validate analysis with deployment readiness
