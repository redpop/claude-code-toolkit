---
description: Pre-defined command pipelines for common development workflows
argument-hint: <workflow-name> [--customize] [--dry-run]
---

# Command Pipelines

Execute pre-defined command chains for common development workflows with a single command.

## Available Pipelines

### 🚀 Quick Quality Check
**Purpose**: Fast quality assessment before commits
**Duration**: ~30 seconds

```bash
/prefix:scan:quick . --export-json=quick-check.json
/prefix:scan:report quick-check.json --quick-wins
```

### 🔍 Deep Quality Analysis
**Purpose**: Comprehensive analysis with actionable fixes
**Duration**: ~5 minutes

```bash
# 1. Deep scan
/prefix:scan:deep . --export-json=analysis.json

# 2. Generate action plan  
/prefix:scan:report analysis.json --generate-action-plan

# 3. Preview fixes
/prefix:auto:execute action-plan.md --dry-run
```

### 🛡️ Security Hardening
**Purpose**: Find and fix security vulnerabilities
**Duration**: ~10 minutes

```bash
# 1. Security audit
/prefix:sec:audit . --export-json=security.json

# 2. Fix critical issues
/prefix:fix:security security.json --severity=critical,high

# 3. Verify compliance
/prefix:sec:comply . --standard=owasp
```

### 🏗️ Refactoring Sprint
**Purpose**: Improve code structure systematically
**Duration**: ~30 minutes

```bash
# 1. Find refactoring opportunities
/prefix:flow:refactor . --export=refactor-plan.md

# 2. Execute safe refactorings
/prefix:flow:refactor . --safety=conservative --execute

# 3. Verify no regressions
/prefix:test:run --all
/prefix:scan:quality . --compare=baseline.json
```

### 📈 Release Preparation
**Purpose**: Ensure code is release-ready
**Duration**: ~20 minutes

```bash
# 1. Full quality check
/prefix:scan:deep . --export-all

# 2. Fix all quick wins
/prefix:fix:quick-wins analysis.json

# 3. Update documentation
/prefix:gen:docs --update-all
/prefix:meta:changelog --update-version

# 4. Final verification
/prefix:meta:health --export=release-health.json
```

### 🔄 Continuous Improvement
**Purpose**: Weekly code quality improvement
**Duration**: ~2 hours

```bash
# 1. Baseline measurement
/prefix:scan:quality . --export=week-start.json

# 2. Execute improvement sprint
/prefix:auto:sprint . --duration=1w --focus=quality

# 3. Measure improvement
/prefix:scan:quality . --baseline=week-start.json

# 4. Generate report
/prefix:auto:report --compare-baseline
```

## Custom Pipeline Creation

### Define Your Pipeline

Create custom pipeline with Task tool:

Use Task tool with subagent_type="general-purpose":
"Create a command pipeline for: $ARGUMENTS. Include: 1) Analysis phase, 2) Action phase, 3) Verification phase. Consider dependencies between commands. Output as executable command sequence."

### Example Custom Pipeline

**Goal**: Improve test coverage to 90%

```bash
# 1. Analyze current coverage
/prefix:scan:tests . --export=coverage-baseline.json

# 2. Generate tests for uncovered code
/prefix:gen:tests --coverage-target=90 --focus=critical

# 3. Refactor for testability
/prefix:flow:refactor --focus=testability

# 4. Generate remaining tests
/prefix:gen:tests --coverage-target=90

# 5. Verify goal achieved
/prefix:scan:tests . --compare=coverage-baseline.json
```

## Pipeline Execution

### Dry Run Mode
Preview what commands would be executed:
```bash
/prefix:meta:pipelines release-prep --dry-run
```

### Customization
Modify pipeline before execution:
```bash
/prefix:meta:pipelines security-hardening --customize
```

### Automated Execution
Run pipeline automatically:
```bash
/prefix:meta:pipelines quick-quality --auto
```

## Integration Examples

### Git Hooks
```bash
# Pre-commit hook
/prefix:meta:pipelines quick-quality || exit 1
```

### CI/CD Pipeline
```yaml
# GitHub Actions
- name: Quality Check
  run: |
    /prefix:meta:pipelines deep-quality
    /prefix:meta:pipelines security-hardening
```

### Scheduled Tasks
```bash
# Weekly improvement (cron)
0 9 * * MON /prefix:meta:pipelines continuous-improvement
```

## Best Practices

1. **Start Small**: Use quick pipelines frequently
2. **Baseline First**: Always measure before improving
3. **Verify Changes**: Include verification steps
4. **Export Results**: Track progress over time
5. **Customize**: Adapt pipelines to your needs

## Common Patterns

### Before PR Review
```bash
/prefix:meta:pipelines quick-quality
/prefix:flow:review . --focus=changes
```

### After Major Feature
```bash
/prefix:meta:pipelines deep-quality
/prefix:meta:pipelines refactoring-sprint
```

### Before Release
```bash
/prefix:meta:pipelines release-prep
/prefix:meta:health --verbose
```