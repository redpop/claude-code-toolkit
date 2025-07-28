---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Write
description: Deep code analysis combining parallel scanning with specialized sub-agent expertise for comprehensive insights
argument-hint: [directory] [--focus=security|performance|architecture|all] [--export-md] [--export-json] [--export-html] [--export-all] [--export-dir=path]
---

**IMPORTANT: This command analyzes code and optionally exports reports. File creation is ONLY allowed for report export when --export flags are used.**

# Deep Analysis Hybrid Command

This command combines the speed of parallel Task Tool agents with the expertise of specialized sub-agents to provide comprehensive code analysis with deep insights.

## Phase 1: Parallel Quick Scan

**IMMEDIATELY START 10 PARALLEL SCANNING AGENTS:**

1. **Code Complexity Scanner**: Task(description="Quick complexity scan", prompt="Rapidly scan $ARGUMENTS for high complexity code. Focus on: 1) Functions with cyclomatic complexity >10, 2) Deeply nested code >4 levels, 3) Long functions >50 lines. Return top 5 most complex areas as JSON with location and complexity score.", subagent_type="general-purpose")

2. **Security Pattern Scanner**: Task(description="Security pattern detection", prompt="Quick scan $ARGUMENTS for obvious security patterns. Look for: 1) Hardcoded secrets/credentials, 2) SQL concatenation, 3) eval/exec usage, 4) Unvalidated inputs. Return top security concerns as JSON with severity.", subagent_type="general-purpose")

3. **Performance Hotspot Scanner**: Task(description="Performance issue detection", prompt="Scan $ARGUMENTS for performance anti-patterns. Identify: 1) O(n²) or worse algorithms, 2) Synchronous I/O in loops, 3) Large memory allocations, 4) Blocking operations. Return hotspots as JSON.", subagent_type="general-purpose")

4. **Architecture Violation Scanner**: Task(description="Architecture check", prompt="Quick scan $ARGUMENTS for architectural issues. Check: 1) Circular dependencies, 2) Layer violations, 3) God objects/modules, 4) Tight coupling. Return violations as JSON.", subagent_type="general-purpose")

5. **Test Coverage Scanner**: Task(description="Test coverage check", prompt="Analyze test coverage in $ARGUMENTS. Identify: 1) Untested critical functions, 2) Low coverage modules <50%, 3) Missing test files. Return coverage gaps as JSON.", subagent_type="general-purpose")

6. **Code Smell Scanner**: Task(description="Code smell detection", prompt="Detect code smells in $ARGUMENTS. Find: 1) Duplicate code blocks, 2) Long parameter lists >5, 3) Dead code, 4) Inappropriate naming. Return top smells as JSON.", subagent_type="general-purpose")

7. **Documentation Scanner**: Task(description="Documentation analysis", prompt="Check documentation in $ARGUMENTS. Analyze: 1) Missing function docs, 2) Outdated comments, 3) Unclear variable names, 4) Missing README sections. Return doc issues as JSON.", subagent_type="general-purpose")

8. **Dependency Scanner**: Task(description="Dependency check", prompt="Scan dependencies in $ARGUMENTS. Check: 1) Outdated packages, 2) Security vulnerabilities, 3) Unused dependencies, 4) Version conflicts. Return dependency issues as JSON.", subagent_type="general-purpose")

9. **Error Handling Scanner**: Task(description="Error handling analysis", prompt="Analyze error handling in $ARGUMENTS. Check: 1) Unhandled exceptions, 2) Generic catch blocks, 3) Missing error logs, 4) Poor error messages. Return issues as JSON.", subagent_type="general-purpose")

10. **Integration Point Scanner**: Task(description="Integration analysis", prompt="Scan integration points in $ARGUMENTS. Identify: 1) External API calls, 2) Database queries, 3) File I/O operations, 4) Network requests. Return integration risks as JSON.", subagent_type="general-purpose")

## Phase 2: Intelligent Delegation

After collecting results from all scanning agents:

1. **Analyze and Prioritize Findings**

   - Aggregate all JSON results
   - Identify critical issues requiring deep analysis
   - Group related findings by expertise area

2. **Delegate to Specialized Sub-Agents**

Based on the scan results, delegate critical findings to appropriate sub-agents:

```markdown
### If security issues found (severity >= high):

Delegate to @security-specialist:
"READ-ONLY ANALYSIS. DO NOT MODIFY ANY FILES.
Perform deep security analysis on: [specific files/patterns]
Focus on: [identified vulnerabilities]
Provide remediation strategies and secure code examples."

### If performance bottlenecks found:

Delegate to @performance-optimizer:
"READ-ONLY ANALYSIS. DO NOT MODIFY ANY FILES.
Analyze performance issues in: [specific functions/modules]
Focus on: [identified bottlenecks]
Provide optimization strategies with benchmarks."

### If architectural violations found:

Delegate to @code-architect:
"READ-ONLY ANALYSIS. DO NOT MODIFY ANY FILES.
Review architecture in: [affected components]
Focus on: [identified violations]
Suggest refactoring approach and migration path."

### If test coverage gaps found:

Delegate to @test-engineer:
"READ-ONLY ANALYSIS. DO NOT MODIFY ANY FILES.
Analyze test gaps in: [uncovered modules]
Focus on: [critical untested paths]
Describe test strategy only - do not create test files."

### If significant code smells found:

Delegate to @refactoring-expert:
"READ-ONLY ANALYSIS. DO NOT MODIFY ANY FILES.
Review code quality in: [problematic areas]
Focus on: [identified smells]
Provide refactoring plan with examples."
```

## Phase 3: Synthesis and Reporting

Combine quick scan results with deep expert analysis:

```markdown
# Comprehensive Code Analysis Report

## Executive Summary

- **Quick Scan Duration**: [X seconds]
- **Issues Found**: [Total count by severity]
- **Expert Analysis Completed**: [List of delegated analyses]
- **Overall Health Score**: [X/100]

## Critical Findings (Expert-Verified)

### 🔒 Security Issues

[Results from security-specialist if delegated]

### ⚡ Performance Bottlenecks

[Results from performance-optimizer if delegated]

### 🏗️ Architecture Concerns

[Results from code-architect if delegated]

### 🧪 Test Coverage Gaps

[Results from test-engineer if delegated]

### 🔧 Code Quality Issues

[Results from refactoring-expert if delegated]

## Quick Scan Findings

### Other Issues by Priority

[Findings not requiring deep analysis, organized by severity]

## Action Plan

### Immediate (0-24 hours)

1. [Critical security fixes]
2. [Performance quick wins]

### Short-term (1 week)

1. [Architecture improvements]
2. [Test coverage increases]

### Long-term (1 month)

1. [Major refactoring]
2. [System redesign]

## Metrics Dashboard

| Metric         | Current | Target | Priority |
| -------------- | ------- | ------ | -------- |
| Security Score | X/100   | 95/100 | Critical |
| Performance    | X/100   | 90/100 | High     |
| Test Coverage  | X%      | 90%    | High     |
| Code Quality   | X/100   | 85/100 | Medium   |
```

## Configuration Options

### Focus Parameters

- `--focus=security`: Prioritize security analysis
- `--focus=performance`: Prioritize performance analysis
- `--focus=architecture`: Prioritize structural analysis
- `--focus=all`: Comprehensive analysis (default)

### Export Parameters

- `--export-md[=filename]`: Export markdown report (default: analyze-deep-YYYYMMDD-HHMMSS.md)
- `--export-json[=filename]`: Export JSON data (default: analyze-deep-YYYYMMDD-HHMMSS.json)
- `--export-html[=filename]`: Export HTML report (default: analyze-deep-YYYYMMDD-HHMMSS.html)
- `--export-all`: Export all formats
- `--export-dir=path`: Custom export directory (default: reports/)

### Export Examples

```bash
/analyze-deep --export-md                           # Basic markdown export
/analyze-deep --export-md=security-review.md       # Custom filename
/analyze-deep --export-all --export-dir=audits/    # All formats to custom dir
/analyze-deep --focus=security --export-json       # Focused analysis with JSON
```

## Phase 4: Report Export (if --export flags provided)

After synthesis, if export parameters are provided:

1. **Parse Export Parameters**:

   - Detect export format(s) requested
   - Generate filename with timestamp if not provided
   - Create export directory if it doesn't exist

2. **Generate Reports**:

   **Markdown Export** (--export-md):

   ```markdown
   # Code Analysis Report

   **Generated**: {timestamp}
   **Command**: /analyze-deep {args}
   **Project**: {project_name}
   **Duration**: {duration}

   ## Executive Summary

   {health_score_and_overview}

   ## Critical Findings

   {expert_verified_issues}

   ## Action Plan

   {prioritized_recommendations}

   ---

   _Generated by Claude Code Toolkit v{version}_
   ```

   **JSON Export** (--export-json):

   ```json
   {
     "metadata": {
       "timestamp": "{iso_timestamp}",
       "command": "analyze-deep",
       "args": "{command_args}",
       "project": "{project_name}",
       "duration_seconds": {duration},
       "toolkit_version": "{version}"
     },
     "summary": {
       "health_score": {score},
       "total_issues": {count},
       "severity_breakdown": {...}
     },
     "findings": [
       {
         "id": "ARCH-001",
         "category": "architecture",
         "severity": "critical",
         "title": "God Component Anti-pattern",
         "file": "src/Component.tsx",
         "solution": "Extract hooks and separate concerns"
       }
     ],
     "metrics": {
       "security_score": {score},
       "performance_score": {score},
       "test_coverage": {percentage}
     }
   }
   ```

3. **Write Files**:

   - Create reports directory if needed
   - Write report file(s) with proper formatting
   - Display export success message with file path(s)

4. **Update History**:
   - Append to .report-history.json for historical tracking

## Performance Expectations

- **Phase 1**: 5-8 seconds (parallel scanning)
- **Phase 2**: 10-20 seconds (expert analysis)
- **Phase 3**: 2-3 seconds (synthesis)
- **Phase 4**: 1-2 seconds (export, if enabled)
- **Total**: 15-35 seconds for comprehensive analysis with export

This hybrid approach provides both speed and depth, leveraging parallel scanning for broad coverage and expert sub-agents for detailed insights where needed.
