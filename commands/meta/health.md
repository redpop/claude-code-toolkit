---
description: Comprehensive project health check with actionable insights and trend analysis
argument-hint: [--verbose] [--compare=last-check.json] [--export]
---

# Project Health Check

Holistic assessment of your project's health across development, operations, and maintenance dimensions.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Health Dimensions

### 🏗️ Development Health

- Code quality and maintainability
- Architecture soundness
- Technical debt levels

### 🧪 Testing Health

- Test coverage and quality
- CI/CD pipeline status
- Bug discovery rate

### 📚 Documentation Health

- README completeness
- API documentation
- Code comments coverage

### 🔒 Security Health

- Vulnerability status
- Dependency safety
- Security practices

### 👥 Collaboration Health

- PR review times
- Issue resolution rate
- Team velocity trends

## Execution

### Phase 1: Multi-Dimensional Analysis

Use Task tool with subagent_type="general-purpose" for each dimension:

1. **Development Analysis**
   "Analyze development health: code complexity trends, architecture violations, technical debt accumulation, refactoring needs. Check git history for code churn. Return health metrics."

2. **Testing Analysis**
   "Assess testing health: test coverage %, test execution time, flaky test count, bug escape rate. Check CI/CD success rate. Return testing metrics."

3. **Documentation Analysis**
   "Evaluate documentation: README sections, API docs coverage, changelog updates, inline comment ratio. Check staleness. Return doc metrics."

4. **Security Analysis**
   "Check security health: dependency vulnerabilities, security scan results, secret detection, OWASP compliance. Return security metrics."

5. **Collaboration Analysis**
   "Analyze team health: average PR review time, issue close rate, commit frequency, contributor diversity. Return collaboration metrics."

### Phase 2: Synthesis & Scoring

## Project Health Report

### Overall Health Score: [X/100] [Trend: ↑↓→]

```
🏗️ Development:    ████████░░ 82/100 (↑ +3)
🧪 Testing:        ██████░░░░ 64/100 (↓ -5)
📚 Documentation:  ███████░░░ 71/100 (→ 0)
🔒 Security:       █████████░ 89/100 (↑ +7)
👥 Collaboration:  ███████░░░ 75/100 (↑ +2)
```

### 🎯 Key Insights

#### What's Going Well ✅

- Security posture improved significantly
- Code complexity under control
- Team collaboration healthy

#### Needs Attention ⚠️

- Test coverage declining (64% from 69%)
- Documentation falling behind features
- Build times increasing

#### Critical Issues 🚨

- 3 high-severity vulnerabilities in dependencies
- Main branch build failing for 2 days
- No README update in 3 months

### 📊 Vital Signs

| Metric           | Current  | Last Month | Target   | Status |
| ---------------- | -------- | ---------- | -------- | ------ |
| Build Success    | 87%      | 94%        | >95%     | ⚠️     |
| Test Coverage    | 64%      | 69%        | >80%     | ❌     |
| PR Review Time   | 4.2h     | 6.1h       | <4h      | ✅     |
| Bug Rate         | 2.3/week | 3.1/week   | <2/week  | ⚠️     |
| Deploy Frequency | 8/week   | 5/week     | >10/week | ⚠️     |

### 🚀 Improvement Actions

#### Immediate (This Week)

```bash
# Fix failing builds
/prefix:flow:incident "Main branch build failures"

# Update critical dependencies
/prefix:fix:security --severity=high

# Boost test coverage
/prefix:gen:tests --focus=critical-paths
```

#### Short-term (This Month)

```bash
# Documentation sprint
/prefix:gen:docs --update-all
/prefix:meta:update-docs --comprehensive

# Testing improvement
/prefix:scan:tests --improve-quality
/prefix:flow:refactor --focus=testability
```

#### Long-term (This Quarter)

- Implement quality gates
- Automate documentation updates
- Achieve 90% test coverage
- Reduce build time by 50%

### 📈 Trends

```
Test Coverage:    [Month -3] 72% → [Month -2] 69% → [Month -1] 64% → [Now] 64%
Build Success:    [Month -3] 91% → [Month -2] 93% → [Month -1] 94% → [Now] 87%
Security Score:   [Month -3] 75  → [Month -2] 78  → [Month -1] 82  → [Now] 89
Team Velocity:    [Month -3] 45  → [Month -2] 52  → [Month -1] 48  → [Now] 51
```

### 🎲 Risk Assessment

- **High Risk**: Declining test coverage could lead to more bugs
- **Medium Risk**: Documentation debt affecting onboarding
- **Low Risk**: Minor build time increase

## Usage Examples

```bash
# Quick health check
/prefix:meta:health

# Detailed analysis with history
/prefix:meta:health --verbose --compare=last-month.json

# Export for tracking
/prefix:meta:health --export=health-2024-01.json

# Focus on specific concerns
/prefix:meta:health --focus=testing
```

## Integration Points

```bash
# Weekly health ritual
/prefix:meta:health --export
/prefix:flow:smart "Improve areas with declining health"

# Monthly review
/prefix:meta:health --compare=last-month.json
/prefix:auto:sprint --focus=health-improvements
```
