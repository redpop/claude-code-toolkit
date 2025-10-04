# ship

Deployment readiness and quality gates with release pattern learning.

## Syntax

```bash
/prefix:ship [type] [target] [options]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `type` | `readiness` | Ship type: readiness, deploy, release, validate, monitor |
| `target` | `.` | Directory or component to validate |

## Options

| Option | Description |
|--------|-------------|
| `--check=type` | Specific check: tests, build, security, performance |
| `--readiness-check` | Comprehensive deployment readiness assessment |
| `--quality-gates` | Apply quality gates before deployment |
| `--help` | Show detailed help information |

## Examples

```bash
# Basic readiness check
/prefix:ship

# Comprehensive deployment validation
/prefix:ship . --readiness-check

# Quality gates validation
/prefix:ship . --quality-gates

# Test-specific validation
/prefix:ship . --check=tests

# Security validation
/prefix:ship . --check=security
```

## Ship Types

| Type | Description |
|------|-------------|
| `readiness` | Full deployment readiness check |
| `deploy` | Deployment validation |
| `release` | Release readiness assessment |
| `validate` | Code validation |
| `monitor` | Post-deployment monitoring |

## Quality Gates

| Gate | Validation |
|------|------------|
| `tests` | Test coverage and quality |
| `build` | Build success and artifacts |
| `security` | Security compliance |
| `performance` | Performance benchmarks |

## Workflows

**Complete Deployment Workflow**:

```bash
/prefix:understand . --comprehensive    # Final analysis
/prefix:improve . --severity=high       # Fix critical issues
/prefix:secure . --audit               # Security validation
/prefix:ship . --readiness-check       # Deploy validation
```

**Quick Release Workflow**:

```bash
/prefix:ship . --check=tests           # Verify tests
/prefix:ship . --check=security        # Security check
/prefix:ship . --readiness-check       # Final validation
```

## See Also

- [`understand`](understand.md) - Pre-deployment analysis
- [`improve`](improve.md) - Fix issues before shipping
- [`secure`](secure.md) - Security validation
