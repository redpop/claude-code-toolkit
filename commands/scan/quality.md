---
description: Comprehensive code quality metrics with trend analysis and improvement roadmap
argument-hint: <directory> [--baseline=previous.json] [--threshold=80] [--export]
---

# Code Quality Scanner

Measure and track code quality metrics with actionable improvement recommendations.

## Quality Dimensions

1. **Maintainability**: How easy to modify and extend
2. **Reliability**: How likely to work correctly
3. **Security**: How well protected against vulnerabilities
4. **Performance**: How efficiently resources are used
5. **Testability**: How easy to test thoroughly

## Execution

**Target**: $ARGUMENTS

### Phase 1: Metrics Collection

Use Task tool with subagent_type="general-purpose" for parallel metrics gathering:

1. **Complexity Metrics**
   "Calculate complexity metrics for $ARGUMENTS: cyclomatic complexity per function, cognitive complexity, nesting depth. Return average and outliers as JSON."

2. **Maintainability Index**
   "Calculate maintainability index for $ARGUMENTS using: lines of code, cyclomatic complexity, comment ratio. Score 0-100 per file. Return as JSON."

3. **Code Coverage**
   "Analyze test coverage for $ARGUMENTS: line coverage, branch coverage, function coverage. Identify untested critical paths. Return coverage data as JSON."

4. **Technical Debt**
   "Estimate technical debt in $ARGUMENTS: code smells count, duplicate code %, outdated patterns. Calculate fix time estimates. Return as JSON."

5. **Documentation Score**
   "Assess documentation quality in $ARGUMENTS: function docs %, README completeness, inline comments quality. Score 0-100. Return as JSON."

### Phase 2: Trend Analysis

If baseline provided, compare metrics:

Use Task tool with subagent_type="general-purpose":
"Compare current metrics with baseline: [current metrics] vs [baseline metrics]. Calculate: 1) Improvement/degradation %, 2) Trend direction, 3) Problem areas, 4) Success stories. Return trend analysis."

### Phase 3: Quality Report

## Code Quality Report

### Overall Health Score: [X/100]

```
Maintainability: ████████░░ 78/100 (↑ +5)
Reliability:     ██████░░░░ 65/100 (↓ -3)
Security:        █████████░ 92/100 (→ 0)
Performance:     ███████░░░ 71/100 (↑ +8)
Testability:     ██████░░░░ 68/100 (↑ +2)
```

### Key Metrics

| Metric           | Current | Target | Status |
| ---------------- | ------- | ------ | ------ |
| Code Coverage    | 72%     | 80%    | ⚠️     |
| Complexity (avg) | 8.3     | <10    | ✅     |
| Duplication      | 12%     | <5%    | ❌     |
| Tech Debt        | 45h     | <20h   | ⚠️     |
| Doc Coverage     | 68%     | >80%   | ⚠️     |

### Top Issues by Impact

1. **High Complexity Functions** (Impact: High)

   - `processOrder()` - Complexity: 24
   - `validateUser()` - Complexity: 19
   - Action: `/prefix:flow:refactor --type=extract`

2. **Low Test Coverage** (Impact: High)

   - `PaymentService` - Coverage: 45%
   - `AuthModule` - Coverage: 52%
   - Action: `/prefix:gen:tests --focus=critical`

3. **Code Duplication** (Impact: Medium)
   - 3 instances of data validation logic
   - 2 instances of error handling pattern
   - Action: `/prefix:fix:duplicates`

### Improvement Roadmap

#### Week 1: Quick Wins (8h effort, +10 quality points)

```bash
# Fix critical complexity
/prefix:flow:refactor src/OrderProcessor.js --type=extract

# Add missing critical tests
/prefix:gen:tests src/PaymentService.js --coverage-target=80

# Remove obvious duplication
/prefix:fix:duplicates --threshold=90
```

#### Week 2-3: Major Improvements (24h effort, +15 quality points)

```bash
# Comprehensive test coverage
/prefix:gen:tests --coverage-target=80

# Architecture improvements
/prefix:flow:refactor --type=restructure

# Documentation update
/prefix:gen:docs --comprehensive
```

#### Month 2: Excellence (40h effort, +20 quality points)

- Achieve 90% test coverage
- Reduce complexity below 8
- Eliminate code duplication
- Complete documentation

### Quality Gates

Configure CI/CD to enforce:

- No new code with complexity >15
- Maintain test coverage >80%
- No critical security issues
- Documentation for public APIs

## Usage Examples

```bash
# First quality assessment
/prefix:scan:quality src/

# Track improvement over time
/prefix:scan:quality src/ --baseline=quality-last-month.json

# Set quality threshold for CI
/prefix:scan:quality . --threshold=85 --export

# Focus on specific area
/prefix:scan:quality src/api/ --export=api-quality.json
```

## Export Format

```json
{
  "timestamp": "2024-01-30T10:00:00Z",
  "overall_score": 74,
  "metrics": {
    "maintainability": 78,
    "reliability": 65,
    "security": 92,
    "performance": 71,
    "testability": 68
  },
  "details": {...},
  "recommendations": [...]
}
```
