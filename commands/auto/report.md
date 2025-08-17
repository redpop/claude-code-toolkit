---
allowed-tools: Task, Read, Grep, Bash(jq:*), Bash(git:log,diff,status), Write
description: Generate comprehensive completion report after action plan execution, showing results, metrics, and next steps
argument-hint: [--action-plan=<file>] [--execution-log=<file>] [--compare-baseline] [--baseline=<file>] [--current=<file>] [--export-formats=md,json,html] [--export-all] [--export-json=<file>] [--include-metrics] [--include-git-log] [--team-report] [--recommendations]
---

# Completion Report Command

This command generates a comprehensive report after executing an action plan, analyzing what was accomplished, what failed, and providing recommendations for next steps. It can compare against baselines and export in multiple formats.

## Usage Patterns

### 1. Basic Completion Report

```bash
/completion-report
/completion-report --action-plan=action-plan-20250129.md
```

### 2. With Baseline Comparison

```bash
/completion-report --compare-baseline
/completion-report --baseline=security-baseline-20250115.json --current=current-state.json
```

### 3. From Execution Log

```bash
/completion-report --execution-log=execution-log-20250129.md
/completion-report --action-plan=plan.md --execution-log=log.md
```

### 4. Multi-format Export

```bash
/completion-report --export-formats=md,json,html
/completion-report --export-all --include-metrics
```

## Report Generation Workflow

### Phase 1: Data Collection

1. **Gather Execution Data**:
   - Read action plan (original todos)
   - Parse execution logs
   - Collect git history
   - Analyze file changes

2. **Baseline Comparison** (if requested):
   - Load baseline metrics
   - Run current analysis
   - Calculate deltas
   - Identify improvements/regressions

### Phase 2: Results Analysis

Analyze execution results:

```markdown
## Execution Analysis

### Task Completion Status
- Planned Tasks: {total_planned}
- Completed Successfully: {completed} ({percentage}%)
- Partially Completed: {partial}
- Failed: {failed}
- Skipped: {skipped}

### Time Analysis
- Estimated Time: {estimated_hours}h
- Actual Time: {actual_hours}h
- Efficiency: {efficiency_percentage}%
```

### Phase 3: Impact Assessment

Measure actual improvements:

```markdown
## Impact Metrics

### Security Improvements
- Vulnerabilities Fixed: {count}
- Security Score: {before} → {after} ({delta})
- Critical Issues Resolved: {list}

### Performance Gains
- Load Time: {before}ms → {after}ms ({improvement}%)
- Memory Usage: {before}MB → {after}MB
- API Response Time: {improvements}

### Code Quality
- Test Coverage: {before}% → {after}%
- Code Duplication: {before} → {after} lines
- Complexity Reduction: {metrics}
```

### Phase 4: Detailed Task Report

For each executed task:

```markdown
### ✅ Task: Input Sanitization
- **Status**: Completed
- **Duration**: 2h 45m (estimated: 3h)
- **Files Modified**: 12
- **Changes**:
  - Added DOMPurify to 8 components
  - Created sanitization utility
  - Updated input handlers
- **Verification**: All XSS tests passing
- **Impact**: Eliminated XSS vulnerability class

### ❌ Task: Legacy Migration
- **Status**: Failed
- **Duration**: 1h 15m (incomplete)
- **Error**: Dependency conflict with legacy-lib@2.x
- **Attempted Solutions**:
  - Tried upgrading to legacy-lib@3.x
  - Attempted polyfill approach
- **Recommendation**: Manual refactoring required
- **Estimated Additional Effort**: 8h
```

### Phase 5: Comprehensive Report Generation

Generate final report with multiple sections:

```markdown
# Workflow Completion Report

**Generated**: {timestamp}
**Action Plan**: {action_plan_file}
**Execution Duration**: {total_time}
**Overall Success Rate**: {percentage}%

## Executive Summary

{high_level_summary_of_achievements}

## 📊 Key Metrics

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| Security Score | 45/100 | 72/100 | +60% |
| Test Coverage | 30% | 55% | +83% |
| Performance | 65/100 | 78/100 | +20% |
| Tech Debt | 21 days | 14 days | -33% |

## 🎯 Completed Objectives

### Security Hardening
- ✅ Input sanitization implemented across all forms
- ✅ JSON validation with Zod preventing injection
- ✅ CSP headers blocking XSS attempts
- ✅ Removed 47 console.log statements with sensitive data

### Performance Optimization
- ✅ Database operations now batched (70% faster)
- ✅ Implemented lazy loading (initial load -2.3s)
- ⚠️ Memory optimization partially complete

### Code Quality
- ✅ Removed 140 lines of duplicate code
- ✅ Added 125 new tests
- ❌ Complex refactoring blocked by legacy code

## 📈 Improvement Trends

{visual_representation_of_improvements}

## 🚧 Incomplete Items

### High Priority
1. **Legacy System Migration**
   - Blocker: Dependency conflicts
   - Required Effort: 8h
   - Recommendation: Schedule dedicated sprint

2. **Full Test Coverage**
   - Current: 55%
   - Target: 80%
   - Gap: Critical paths still untested

## 💡 Recommendations

### Immediate Actions
1. Address failed legacy migration manually
2. Run security penetration testing
3. Performance test under load

### Next Sprint
1. Complete test coverage to 80%
2. Implement remaining performance optimizations
3. Address new issues discovered during fixes

### Long-term Strategy
1. Establish continuous quality monitoring
2. Automate security scanning in CI/CD
3. Regular architecture reviews

## 📁 Artifacts Generated

- Security baseline: `security-baseline-{timestamp}.json`
- Execution log: `execution-log-{timestamp}.md`
- Git commits: {list_of_commits}
- Test reports: `test-coverage-{timestamp}.html`

## 🔄 Next Steps

1. Run `/analyze-deep --compare-baseline` to verify improvements
2. Create new action plan for remaining items
3. Schedule team retrospective
4. Update documentation with new patterns

## Team Performance

- Tasks Completed: {by_assignee}
- Average Completion Time vs Estimate: {percentage}%
- Blockers Encountered: {count}
- Knowledge Gaps Identified: {list}
```

## Export Formats

### Markdown (Default)

- Human-readable format
- Includes tables and formatting
- Suitable for documentation
- Git-friendly

### JSON

```json
{
  "metadata": {
    "timestamp": "2025-01-29T15:00:00Z",
    "action_plan": "action-plan-20250129.md",
    "duration_hours": 24.5
  },
  "summary": {
    "total_tasks": 15,
    "completed": 12,
    "success_rate": 80
  },
  "metrics": {
    "before": { ... },
    "after": { ... },
    "improvements": { ... }
  },
  "tasks": [ ... ],
  "recommendations": [ ... ]
}
```

### HTML

- Interactive dashboard
- Charts and graphs
- Expandable sections
- Print-friendly

## Integration Examples

### CI/CD Pipeline

```yaml
- name: Execute Fixes
  run: |
    /execute-action-plan action-plan.md --mode=auto
    /completion-report --export-formats=json,html
    
- name: Upload Reports
  uses: actions/upload-artifact@v2
  with:
    name: quality-reports
    path: reports/
```

### Slack Notification

```bash
# Generate report and send summary
/completion-report --export-json=report.json
SUCCESS_RATE=$(jq '.summary.success_rate' report.json)
curl -X POST $SLACK_WEBHOOK -d "Success Rate: ${SUCCESS_RATE}%"
```

### JIRA Integration

```bash
# Create follow-up tickets for failed items
/completion-report --export-json=report.json
jq '.tasks[] | select(.status == "failed")' report.json | \
  while read -r task; do
    create-jira-ticket "$task"
  done
```

## Command Options

- `--action-plan=<file>`: Specify action plan file
- `--execution-log=<file>`: Use execution log
- `--compare-baseline`: Compare against baseline
- `--baseline=<file>`: Specific baseline file
- `--export-formats=<list>`: Output formats (md,json,html)
- `--export-all`: Export in all formats
- `--include-metrics`: Include detailed metrics
- `--include-git-log`: Include git history
- `--team-report`: Include team performance
- `--recommendations`: Generate AI recommendations

This command provides complete visibility into the execution results, helping teams understand what was accomplished, what remains, and how to proceed for continuous improvement.
