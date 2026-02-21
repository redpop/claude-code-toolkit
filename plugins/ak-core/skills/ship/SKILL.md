---
name: ship
description: This skill should be used when the user asks "is my app ready to ship?", "check deployment readiness", "run quality gates", "validate for production", or needs deployment assessment, release preparation, or health checks.
---

# Ship

Assess deployment readiness with comprehensive quality gates.

## Arguments

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches types (readiness, deploy, release, validate, monitor, quality, health, checklist), use as type
- Default: type="readiness", target="."
- Flags: `--check=type`, `--readiness-check`, `--quality-gates`

## Execution

Use Task tool with subagent_type="code-architect":
"Assess deployment readiness of '$target' with '$type' focus:

1. **Application Health**: Verify build succeeds, no critical errors
2. **Code Quality Gates**: Linting, type-checking, code style compliance
3. **Test Validation**: Test suite passes, adequate coverage
4. **Security Clearance**: No known vulnerabilities, dependency audit
5. **Performance Baseline**: No obvious performance regressions
6. **Documentation**: Critical docs up to date

Specific check (when --check is used):

- **tests**: Run test suite, report coverage
- **build**: Verify build succeeds
- **security**: Dependency audit, vulnerability scan
- **performance**: Performance benchmarks

Quality gates (when --quality-gates is used):

- All tests pass
- No critical/high vulnerabilities
- Build succeeds without warnings
- Linting passes
- Type checking passes"

## Output Format

```markdown
# Deployment Readiness: {target}

**Date:** {YYYY-MM-DD} | **Status:** READY / NOT READY

## Quality Gates

| Gate | Status | Details |
|------|--------|---------|
| Build | PASS/FAIL | ... |
| Tests | PASS/FAIL | Coverage: X% |
| Security | PASS/FAIL | Vulnerabilities: X |
| Linting | PASS/FAIL | ... |

## Issues Found
[List of blockers]

## Recommendations
[Pre-deployment actions]
```
