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
| `--prp` | Activate Project Requirements Proposal methodology |
| `--prp=research` | Focus on external research and best practices |
| `--prp=patterns` | Focus on internal codebase pattern discovery |
| `--prp=requirements` | Focus on requirements analysis and gap identification |
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

# PRP analysis for OAuth2 implementation
/prefix:understand --prp --requirements="OAuth2 authentication"

# Performance analysis with external research
/prefix:understand performance --prp=research

# Quick documentation analysis
/prefix:understand docs --quick
```

## PRP Integration

The `--prp` flag activates Project Requirements Proposal methodology:

- **Full PRP**: `--prp` alone performs comprehensive analysis
- **Research Focus**: `--prp=research` includes external best practices
- **Pattern Discovery**: `--prp=patterns` focuses on internal codebase patterns
- **Requirements**: `--prp=requirements` validates and identifies gaps

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
/prefix:understand performance --prp=research
/prefix:create . --prp --from-analysis
```

## See Also

- [`improve`](improve.md) - Apply improvements based on analysis
- [`secure`](secure.md) - Security-focused analysis
- [`create`](create.md) - Generate code from analysis insights
- [`ship`](ship.md) - Validate analysis with deployment readiness
