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
| `--prp` | Activate PRP blueprint execution methodology |
| `--prp=fast` | Fast-track execution for tested patterns |
| `--prp=quality` | Enhanced quality validation during execution |
| `--prp=monitor` | Real-time execution monitoring with progress tracking |
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

# PRP execution with monitoring
/prefix:ship . --prp=monitor

# Fast deployment for tested patterns
/prefix:ship components/ --prp=fast

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

## PRP Integration

The `--prp` flag activates blueprint execution:

- **Full Execution**: `--prp` alone executes with comprehensive quality gates
- **Fast Track**: `--prp=fast` for well-tested patterns
- **Quality Focus**: `--prp=quality` with enhanced validation
- **Monitoring**: `--prp=monitor` with real-time progress tracking

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
/prefix:ship . --prp=fast             # Fast deployment
```

## See Also

- [`understand`](understand.md) - Pre-deployment analysis
- [`improve`](improve.md) - Fix issues before shipping
- [`secure`](secure.md) - Security validation
