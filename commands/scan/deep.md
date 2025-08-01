---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Write
description: Deep code analysis with parallel scanning and expert delegation for comprehensive insights
argument-hint: <directory> [--focus=security|performance|architecture|all] [--export-md] [--export-json]
---

# Deep Code Analysis

Comprehensive code analysis using a hybrid approach: parallel scanning for speed, followed by expert analysis for depth.

## Analysis Process

### Phase 1: Parallel Scanning (5-8 seconds)
10 specialized scanners analyze your codebase simultaneously, each focusing on specific aspects.

### Phase 2: Expert Delegation (10-20 seconds)
Based on Phase 1 findings, appropriate expert agents provide deep analysis of critical issues.

### Phase 3: Synthesis & Reporting
All findings are consolidated into actionable insights with clear next steps.

## Execution

**Target**: $ARGUMENTS

### Phase 1: Parallel Scanning

Deploying 10 parallel scanners...

Use Task tool with subagent_type="general-purpose" for each scanner:

1. **Code Complexity Scanner**
   Prompt: "Scan $ARGUMENTS for complexity issues. Find functions with cyclomatic complexity >10, nested code >4 levels, functions >50 lines. Return JSON with top 5 complex areas."

2. **Security Scanner**
   Prompt: "Scan $ARGUMENTS for security patterns: hardcoded secrets, SQL injection risks, eval/exec usage, unvalidated inputs. Return JSON with severity ratings."

3. **Performance Scanner**
   Prompt: "Find performance issues in $ARGUMENTS: O(n²) algorithms, sync I/O in loops, memory leaks, blocking operations. Return JSON with performance hotspots."

4. **Architecture Scanner**
   Prompt: "Check architecture in $ARGUMENTS: circular dependencies, layer violations, god objects, tight coupling. Return JSON with architectural issues."

5. **Test Coverage Scanner**
   Prompt: "Analyze test coverage in $ARGUMENTS: untested critical functions, modules <50% coverage, missing tests. Return JSON with coverage gaps."

6. **Code Smell Scanner**
   Prompt: "Detect code smells in $ARGUMENTS: duplicate code, long parameter lists, dead code, poor naming. Return JSON with top code smells."

7. **Documentation Scanner**
   Prompt: "Check documentation in $ARGUMENTS: missing function docs, outdated comments, unclear names. Return JSON with doc issues."

8. **Dependency Scanner**
   Prompt: "Scan dependencies in $ARGUMENTS: outdated packages, vulnerabilities, unused deps, conflicts. Return JSON with dependency issues."

9. **Error Handling Scanner**
   Prompt: "Analyze error handling in $ARGUMENTS: unhandled exceptions, generic catches, missing logs. Return JSON with error handling issues."

10. **Integration Scanner**
    Prompt: "Find integration points in $ARGUMENTS: API calls, database queries, file I/O, network requests. Return JSON with integration risks."

### Phase 2: Expert Delegation

Based on scanner findings, delegate to specialized experts:

**If critical security issues found:**
Use Task tool with subagent_type="general-purpose":
"As security expert, analyze these findings: [security scanner results]. Provide detailed vulnerability assessment and remediation strategies."

**If performance bottlenecks found:**
Use Task tool with subagent_type="general-purpose":
"As performance expert, analyze these bottlenecks: [performance scanner results]. Provide optimization strategies with expected improvements."

**If architectural violations found:**
Use Task tool with subagent_type="general-purpose":
"As architecture expert, review these issues: [architecture scanner results]. Suggest refactoring approach and migration path."

**If test coverage gaps found:**
Use Task tool with subagent_type="general-purpose":
"As test expert, analyze coverage gaps: [test scanner results]. Provide test strategy for critical uncovered code."

### Phase 3: Report Generation

## Deep Analysis Report

### Executive Summary
- **Health Score**: [0-100 based on findings]
- **Critical Issues**: [Count by category]
- **Quick Wins**: [Easy fixes with high impact]

### Critical Findings

#### 🔒 Security Issues
[Expert-verified security vulnerabilities with remediation]

#### ⚡ Performance Bottlenecks  
[Expert-analyzed performance issues with optimization strategies]

#### 🏗️ Architecture Concerns
[Expert-reviewed architectural issues with refactoring plans]

### Quick Actions

```bash
# Fix critical security issues
/prefix:fix:security --severity=critical

# Optimize performance hotspots
/prefix:fix:performance --target=algorithm

# Generate missing tests
/prefix:gen:tests --coverage-target=80
```

### Detailed Findings
[Comprehensive list organized by priority]

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
/prefix:scan:deep . --export-md=release-report.md
```

## 🎯 Next Steps

Based on the analysis, I recommend:

### 1. **Immediate Actions** (5-15 min)
**Quick fixes with high impact:**
```bash
# Fix critical issues from this scan
/prefix:fix:quick-wins {export-file}

# Or fix specific critical security issues
/prefix:fix:security {export-file} --severity=critical
```

### 2. **Comprehensive Improvement** (30-60 min)
**For thorough code quality enhancement:**
```bash
# Generate and execute action plan
/prefix:scan:report {export-file} --generate-action-plan
/prefix:auto:execute action-plan-*.md

# Or run quality improvement workflow
/prefix:meta:workflow quality-sprint
```

### 3. **Focused Approach**
**Choose based on your priorities:**

- [ ] 🔒 **Security Focus**: `/prefix:sec:audit . --comprehensive`
- [ ] ⚡ **Performance**: `/prefix:fix:performance {export-file} --target=critical`
- [ ] 🧪 **Testing**: `/prefix:gen:tests --focus={uncovered-modules}`
- [ ] 🏗️ **Architecture**: `/prefix:flow:refactor . --based-on={export-file}`
- [ ] 📚 **Documentation**: `/prefix:fix:documentation {export-file}`

### 4. **Track Progress**
```bash
# Compare with this baseline
/prefix:scan:quality . --compare={export-file}

# Review detailed findings
/prefix:flow:review {export-file}
```

## 📤 Export Information
- **Results saved to**: `{export-file}`
- **Format**: JSON/Markdown
- **Use in next commands**: Pass the export file as input to fix commands

💡 **Pro tip**: Start with quick wins for immediate value, then proceed to comprehensive improvements.