---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Write
description: Deep code analysis with streamlined output and clear workflow guidance
argument-hint: <directory> [--focus=security|performance|architecture|all] [--export-md] [--export-json]
options:
  - name: "--focus"
    description: "Focus analysis on specific aspect"
    values: "security|performance|architecture|all"
    default: "all"
  - name: "--export-md"
    description: "Export analysis results as timestamped Markdown report"
    type: "flag"
  - name: "--export-json"
    description: "Export analysis results as timestamped JSON report"
    type: "flag"
examples:
  - command: "/prefix:scan:deep src/"
    description: "Basic deep scan of source directory"
  - command: "/prefix:scan:deep . --focus=security --export-json"
    description: "Security-focused analysis with JSON export"
  - command: "/prefix:scan:deep . --export-md"
    description: "Comprehensive analysis with Markdown report"
  - command: "/prefix:scan:deep backend/ --focus=performance"
    description: "Performance-focused analysis of backend code"
see-also:
  - "/prefix:scan:report - Generate action plan from analysis results"
  - "/prefix:scan:quick - Fast code quality check"
  - "/prefix:fix:quick-wins - Apply easy fixes from analysis"
  - "/prefix:meta:pipelines deep-quality - Complete quality pipeline"
---

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display:

- Command name and description
- Usage syntax
- All arguments and options
- Examples
- Related commands
Then exit without executing analysis.

# Deep Code Analysis

Comprehensive code analysis using a hybrid approach with **simplified, action-oriented output**.

## Analysis Process

### Phase 1: Parallel Scanning (5-8 seconds)

10 specialized scanners analyze your codebase simultaneously.

### Phase 2: Expert Delegation (10-20 seconds)

Critical findings get expert analysis for detailed insights.

### Phase 3: Simplified Reporting

Clear next steps with optional detailed findings.

## Execution

**Target**: $ARGUMENTS

### Phase 1: Parallel Scanning

Use Task tool with subagent_type="general-purpose" for each scanner:

1. **Security Scanner**
   Prompt: "Scan $ARGUMENTS for critical security issues: hardcoded secrets, SQL injection risks, missing validation, unencrypted data. Focus on severity and auto-fixability. Return JSON with: {critical_count, issues: [{type, file, line, severity, auto_fixable, fix_time_minutes}]}"

2. **Performance Scanner**
   Prompt: "Scan $ARGUMENTS for performance bottlenecks: N+1 queries, blocking operations, memory leaks, inefficient algorithms. Prioritize by impact. Return JSON with: {bottlenecks_count, issues: [{type, file, impact, fix_effort_hours, expected_improvement}]}"

3. **Code Quality Scanner**
   Prompt: "Scan $ARGUMENTS for quick quality wins: code smells, duplication, complexity >15, dead code. Focus on high-ROI fixes. Return JSON with: {quick_wins_count, issues: [{type, file, roi_score, fix_minutes}]}"

4. **Architecture Scanner**
   Prompt: "Scan $ARGUMENTS for architectural issues: circular dependencies, god objects, layer violations. Prioritize by refactoring complexity. Return JSON with: {violations_count, issues: [{type, affected_files, complexity, refactor_effort}]}"

5. **Test Coverage Scanner**
   Prompt: "Scan $ARGUMENTS for critical test gaps: untested business logic, missing edge cases, <50% coverage modules. Return JSON with: {coverage_gaps, critical_untested: [{file, function, risk_level}]}"

### Phase 2: Expert Analysis (only for critical findings)

**If >5 critical security issues:**
Use Task tool with subagent_type="general-purpose":
"Security expert analysis: Review findings: [security results]. Provide: 1) Most critical vulnerability, 2) Auto-fix strategy, 3) Manual fix requirements, 4) Risk assessment. Format for immediate action."

**If >3 performance bottlenecks:**
Use Task tool with subagent_type="general-purpose":
"Performance expert analysis: Review bottlenecks: [performance results]. Provide: 1) Highest impact optimization, 2) Quick wins vs major refactors, 3) Expected improvement metrics. Prioritize by ROI."

### Phase 3: Report Generation

Generate a streamlined, action-focused report:

````markdown
# 🔍 Deep Analysis Complete

📊 **Health Score: {score}/100** | 🔴 Critical: {critical_count} | ⚡ Quick Wins: {quick_wins_count}

## 🎯 Your Next Step

```bash
/prefix:scan:report --latest --generate-action-plan
```
````

**Why?** This creates a prioritized action plan with specific fix commands for all issues found.

---

<details>
<summary>📋 Summary of Findings (click to expand)</summary>

### Top Issues Found

1. {most_critical_issue} - {impact_description}
2. {second_critical_issue} - {impact_description}
3. {third_critical_issue} - {impact_description}

### By Category

- 🔒 Security: {security_count} issues ({critical_security} critical)
- ⚡ Performance: {perf_count} bottlenecks ({major_perf} major impact)
- 🏗️ Architecture: {arch_count} concerns ({refactor_needed} need refactoring)
- 🧪 Testing: {coverage}% coverage ({untested_critical} critical paths untested)

### Expert Insights

{2-3 key insights from expert analysis}

</details>

💡 **Tip**: {contextual_tip_based_on_findings}

````

**Contextual Tips Logic**:
- If security critical ≥ 5: "Critical security issues detected - fix these immediately before proceeding!"
- If quick wins ≥ 10: "Great news! Many easy improvements available for quick impact."
- If health < 50: "Your codebase needs attention - start with the action plan for systematic improvement."
- If health > 80: "Your code is in good shape! Focus on the remaining optimizations."
- Default: "The action plan will guide you through improvements in priority order."

**Report Principles**:
1. Lead with the next action, not the problems
2. Show health metrics at a glance
3. Hide overwhelming details in collapsible sections
4. Provide context-aware guidance
5. Use the 3-step workflow as the primary recommendation

## Export Options

- `--export-md`: Export as Markdown report
- `--export-json`: Export as JSON for automation
- `--focus`: Emphasize specific aspect (security/performance/architecture)

## Integration Examples

```bash
# Basic deep scan
/prefix:scan:deep src/

# Security-focused analysis
/prefix:scan:deep . --focus=security --export-json

# Pre-release comprehensive check
/prefix:scan:deep . --export-md
````

## 🎯 Your Next Step

```bash
/prefix:scan:report --latest --generate-action-plan
```

This will create a prioritized action plan from your analysis. The plan will include specific commands to fix the issues found.

---

<details>
<summary>📊 See Full Analysis Details</summary>

The complete analysis has been saved to `{export-file}` and includes:

- Detailed findings for each category
- Severity ratings and impact scores
- Specific file locations and line numbers
- Technical recommendations

</details>

<details>
<summary>🚀 Alternative Workflows</summary>

If you prefer a different approach:

**Quick Wins Only** (15 min):

```bash
/prefix:fix:quick-wins --latest
```

**Security First** (if critical issues found):

```bash
/prefix:fix:security --latest --severity=critical
```

**Complete Pipeline**:

```bash
/prefix:meta:pipelines deep-quality
```

</details>

💡 **Why this workflow?** The 3-step process (scan → plan → execute) ensures systematic improvements with minimal manual effort.
