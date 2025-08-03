# Security Guide

This guide covers security best practices when using the Claude Code Toolkit.

## Security Commands

The toolkit provides several security-focused commands:

### Security Scanning

- `/prefix:sec:audit` - Comprehensive security audit
- `/prefix:sec:baseline` - Establish security baseline
- `/prefix:sec:comply` - Compliance checking

### Security Fixes

- `/prefix:fix:security` - Automated security fixes
- `/prefix:fix:quick-wins` - Quick security improvements

## Best Practices

### 1. Regular Security Audits

Run security audits before each release:

```bash
/prefix:sec:audit . --severity=all --export-all
```

### 2. Baseline Tracking

Establish and monitor security baselines:

```bash
/prefix:sec:baseline . --export-baseline
# Later...
/prefix:sec:baseline . --compare=baseline.json
```

### 3. Compliance Checking

Ensure compliance with security standards:

```bash
/prefix:sec:comply . --standard=owasp
```

## Common Security Issues

### Authentication & Authorization

- Ensure proper authentication on all endpoints
- Implement role-based access control
- Use secure session management

### Input Validation

- Validate all user inputs
- Prevent SQL injection
- Sanitize HTML content to prevent XSS

### Sensitive Data

- Never commit secrets to version control
- Use environment variables for configuration
- Encrypt sensitive data at rest

## Integration with CI/CD

Add security checks to your pipeline:

```yaml
# Example GitHub Actions
- name: Security Audit
  run: |
    /prefix:sec:audit . --severity=critical,high
    /prefix:sec:comply . --standard=owasp
```

## Resources

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [Security Commands Documentation](../../commands/sec/)
- [Fix Security Command](../../commands/fix/security.md)
