# secure

Security analysis and vulnerability detection with threat intelligence learning.

## Syntax

```bash
/prefix:secure [type] [target] [options]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `type` | `audit` | Security type: audit, baseline, comply, review, monitor, fix |
| `target` | `.` | File or directory to analyze |

## Options

| Option | Description |
|--------|-------------|
| `--standard=name` | Apply security standard (OWASP, CIS, SOX, GDPR) |
| `--help` | Show detailed help information |

## Examples

```bash
# Basic security audit
/prefix:secure

# OWASP compliance check
/prefix:secure audit . --standard=OWASP

# Security baseline establishment
/prefix:secure baseline

# Compliance review
/prefix:secure comply --standard=GDPR

# Monitor security posture
/prefix:secure monitor src/

# Fix security issues
/prefix:secure fix --standard=CIS
```

## Security Types

| Type | Description |
|------|-------------|
| `audit` | Comprehensive security analysis |
| `baseline` | Establish security baseline |
| `comply` | Compliance verification |
| `review` | Security code review |
| `monitor` | Ongoing security monitoring |
| `fix` | Automated security fixes |

## Standards

| Standard | Focus Area |
|----------|------------|
| `OWASP` | Web application security |
| `CIS` | Configuration security |
| `SOX` | Financial compliance |
| `GDPR` | Data privacy |

## Workflows

**Security Workflow**:

```bash
/prefix:secure baseline              # Establish baseline
/prefix:understand security .        # Deep security analysis
/prefix:secure audit --standard=OWASP
/prefix:improve security --severity=high
```

**Compliance Workflow**:

```bash
/prefix:secure comply --standard=GDPR
/prefix:secure fix --standard=GDPR
/prefix:ship . --security-gates
```

## See Also

- [`understand`](understand.md) - Security-focused code analysis
- [`improve`](improve.md) - Apply security improvements
- [`ship`](ship.md) - Security validation before deployment
