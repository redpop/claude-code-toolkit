---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*)
description: Deep code analysis combining parallel scanning with specialized sub-agent expertise for comprehensive insights
argument-hint: [directory] [--focus=security|performance|architecture|all]
---

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
"Perform deep security analysis on: [specific files/patterns]
Focus on: [identified vulnerabilities]
Provide remediation strategies and secure code examples."

### If performance bottlenecks found:
Delegate to @performance-optimizer:
"Analyze performance issues in: [specific functions/modules]
Focus on: [identified bottlenecks]
Provide optimization strategies with benchmarks."

### If architectural violations found:
Delegate to @code-architect:
"Review architecture in: [affected components]
Focus on: [identified violations]
Suggest refactoring approach and migration path."

### If test coverage gaps found:
Delegate to @test-engineer:
"Analyze test gaps in: [uncovered modules]
Focus on: [critical untested paths]
Generate test templates and coverage strategy."

### If significant code smells found:
Delegate to @refactoring-expert:
"Review code quality in: [problematic areas]
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

| Metric | Current | Target | Priority |
|--------|---------|--------|----------|
| Security Score | X/100 | 95/100 | Critical |
| Performance | X/100 | 90/100 | High |
| Test Coverage | X% | 90% | High |
| Code Quality | X/100 | 85/100 | Medium |
```

## Configuration Options

The command respects focus parameters:
- `--focus=security`: Prioritize security analysis
- `--focus=performance`: Prioritize performance analysis
- `--focus=architecture`: Prioritize structural analysis
- `--focus=all`: Comprehensive analysis (default)

## Performance Expectations

- **Phase 1**: 5-8 seconds (parallel scanning)
- **Phase 2**: 10-20 seconds (expert analysis)
- **Total**: 15-30 seconds for comprehensive deep analysis

This hybrid approach provides both speed and depth, leveraging parallel scanning for broad coverage and expert sub-agents for detailed insights where needed.