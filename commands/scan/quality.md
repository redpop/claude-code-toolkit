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

### Phase 3: Report Generation

Generate streamlined, action-focused report with these principles:

1. Lead with the next action, not analysis
2. Hide detailed metrics in expandable sections
3. Focus on what changed and what to do next
4. No time-based groupings (weeks/months)

**Report Format:**

# 📊 Code Quality Report

**Health Score: {score}/100** {trend_emoji} {change_text}

## 🎯 Your Next Step

```bash
{primary_action_command}
```

**Why:** {action_reason}

---

<details>
<summary>📊 Metrics Overview (click to expand)</summary>

```
Maintainability: {maint_bar} {maint_score}/100 {maint_trend}
Reliability:     {rel_bar} {rel_score}/100 {rel_trend}
Security:        {sec_bar} {sec_score}/100 {sec_trend}
Performance:     {perf_bar} {perf_score}/100 {perf_trend}
Testability:     {test_bar} {test_score}/100 {test_trend}
```

| Metric           | Current | Previous | Target | Status |
| ---------------- | ------- | -------- | ------ | ------ |
| Code Coverage    | {cov}%  | {p_cov}% | 80%    | {cov_status} |
| Complexity (avg) | {comp}  | {p_comp} | <10    | {comp_status} |
| Duplication      | {dup}%  | {p_dup}% | <5%    | {dup_status} |
| Tech Debt        | {debt}h | {p_debt}h| <20h   | {debt_status} |
| Doc Coverage     | {doc}%  | {p_doc}% | >80%   | {doc_status} |

</details>

<details>
<summary>🚨 Critical Issues Found ({critical_count})</summary>

{critical_issues_list}

</details>

<details>
<summary>🎉 Success Stories ({success_count})</summary>

{success_stories_list}

</details>

<details>
<summary>📋 All Recommended Actions</summary>

**Priority Actions** (sorted by ROI)

```bash
# 1. {action_1_desc}
{action_1_cmd}
# ROI: {action_1_roi}

# 2. {action_2_desc}
{action_2_cmd}
# ROI: {action_2_roi}

# 3. {action_3_desc}
{action_3_cmd}
# ROI: {action_3_roi}
```

**Additional Actions**

{additional_actions_list}

</details>

💡 **Tip:** {contextual_tip}

### Quality Gates

```yaml
# Recommended thresholds
quality_gates:
  complexity_max: 15
  coverage_min: 80
  security_critical: 0
  doc_coverage_min: 80
```

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

Results are exported as JSON with filename: `code-quality-report-{YYYYMMDD}.json`

<details>
<summary>JSON Schema</summary>

```json
{
  "timestamp": "ISO-8601",
  "overall_score": {current},
  "comparison": {
    "baseline_file": "filename",
    "score_change": {delta}
  },
  "metrics": {
    "maintainability": {score},
    "reliability": {score},
    "security": {score},
    "performance": {score},
    "testability": {score}
  },
  "top_actions": [
    {
      "command": "/prefix:...",
      "reason": "...",
      "roi": {score}
    }
  ]
}
```

</details>
