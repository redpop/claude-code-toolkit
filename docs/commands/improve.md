# improve

Apply code improvements with intelligent routing and learning persistence.

## Syntax

```bash
/prefix:improve [type] [target] [options]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `type` | `quality` | Improvement type: quality, performance, security, architecture, style, dependencies, tests, docs, modernize |
| `target` | `.` | File or directory to improve |

## Options

| Option | Description |
|--------|-------------|
| `--dry-run` | Show proposed changes without applying them |
| `--severity=level` | Filter by severity: low, medium, high, critical |
| `--apply-insights` | Apply recommendations from previous analysis |
| `--from-analysis` | Use existing analysis results for targeted improvements |
| `--export-json` | Generate timestamped JSON report |
| `--export-md` | Generate timestamped Markdown report |
| `--help` | Show detailed help information |

## Examples

```bash
# Show what would be improved (dry run)
/prefix:improve . --dry-run

# Fix only high-priority issues
/prefix:improve . --severity=high

# Apply insights from previous understand analysis
/prefix:improve . --apply-insights

# Performance improvements with export
/prefix:improve performance src/ --export-json

# Security improvements from analysis
/prefix:improve security --from-analysis

# Code quality improvements
/prefix:improve quality components/
```

## Improvement Types

| Type | Focus Area |
|------|------------|
| `quality` | Code quality, clean code principles |
| `performance` | Speed, memory, algorithm optimization |
| `security` | Security vulnerabilities, best practices |
| `architecture` | Design patterns, structure improvements |
| `style` | Code style, formatting, conventions |
| `dependencies` | Package updates, dependency management |
| `tests` | Test coverage, test quality |
| `docs` | Documentation improvements |
| `modernize` | Language/framework modernization |

## Workflows

**Quality Improvement Workflow**:

```bash
/prefix:understand . --comprehensive    # Analyze first
/prefix:improve . --apply-insights      # Apply findings
/prefix:secure . --audit               # Security check
/prefix:ship . --readiness-check       # Validate
```

**Performance Optimization**:

```bash
/prefix:improve performance --dry-run   # Preview changes
/prefix:improve performance --severity=high
/prefix:understand performance --quick  # Verify improvements
```

## See Also

- [`understand`](understand.md) - Analyze code before improvements
- [`secure`](secure.md) - Security-focused improvements
- [`ship`](ship.md) - Validate improvements before deployment
