---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
description: Deep code analysis combining parallel scanning with specialized sub-agent expertise for comprehensive insights
argument-hint: [directory] [--focus=security|performance|architecture|all] [--export-md] [--export-json] [--export-html] [--export-all] [--export-dir=path]
---

**IMPORTANT: This command analyzes code and optionally exports reports. File creation is ONLY allowed for report export when --export flags are used.**

# Deep Analysis Hybrid Command

This command combines the speed of parallel Task Tool agents with the expertise of specialized sub-agents to provide comprehensive code analysis with deep insights. When available, it leverages Semgrep MCP for enhanced security analysis.

## Tool Detection

**FIRST, CHECK AVAILABLE TOOLS:**

1. **Check for Semgrep MCP**: Test if `mcp__semgrep__*` tools are available
2. **Check for local Semgrep**: `Bash("which semgrep")`
3. **Adjust scanning strategy** based on available tools

## Phase 1: Parallel Quick Scan

**START PARALLEL SCANNING AGENTS (adjust security scanner based on tools):**

1. **Code Complexity Scanner**: Task(description="Quick complexity scan", prompt="READ-ONLY ANALYSIS - DO NOT CREATE ANY FILES. Rapidly scan $ARGUMENTS for high complexity code. Focus on: 1) Functions with cyclomatic complexity >10, 2) Deeply nested code >4 levels, 3) Long functions >50 lines. Return top 5 most complex areas as JSON with location and complexity score.", subagent_type="general-purpose")

2. **Security Pattern Scanner**: 
   - **IF Semgrep MCP available**: Use `mcp__semgrep__security_check` for comprehensive security scanning
   - **ELSE IF local Semgrep**: `Bash("semgrep --config=auto --json $ARGUMENTS")`
   - **ELSE**: Task(description="Security pattern detection", prompt="Quick scan $ARGUMENTS for obvious security patterns. Look for: 1) Hardcoded secrets/credentials, 2) SQL concatenation, 3) eval/exec usage, 4) Unvalidated inputs. Return top security concerns as JSON with severity.", subagent_type="general-purpose")

3. **Performance Hotspot Scanner**: Task(description="Performance issue detection", prompt="Scan $ARGUMENTS for performance anti-patterns. READ-ONLY ANALYSIS - DO NOT CREATE ANY FILES. Identify: 1) O(n²) or worse algorithms, 2) Synchronous I/O in loops, 3) Large memory allocations, 4) Blocking operations. Return hotspots as JSON analysis only.", subagent_type="general-purpose")

4. **Architecture Violation Scanner**: Task(description="Architecture check", prompt="READ-ONLY ANALYSIS - DO NOT CREATE ANY FILES. Quick scan $ARGUMENTS for architectural issues. Check: 1) Circular dependencies, 2) Layer violations, 3) God objects/modules, 4) Tight coupling. Return violations as JSON.", subagent_type="general-purpose")

5. **Test Coverage Scanner**: Task(description="Test coverage check", prompt="Analyze test coverage in $ARGUMENTS. Identify: 1) Untested critical functions, 2) Low coverage modules <50%, 3) Missing test files. Return coverage gaps as JSON. IMPORTANT: Do NOT create any coverage report files - only analyze existing coverage data or test-to-code ratios.", subagent_type="general-purpose")

6. **Code Smell Scanner**: Task(description="Code smell detection", prompt="READ-ONLY ANALYSIS - DO NOT CREATE ANY FILES. Detect code smells in $ARGUMENTS. Find: 1) Duplicate code blocks, 2) Long parameter lists >5, 3) Dead code, 4) Inappropriate naming. Return top smells as JSON.", subagent_type="general-purpose")

7. **Documentation Scanner**: Task(description="Documentation analysis", prompt="READ-ONLY ANALYSIS - DO NOT CREATE ANY FILES. Check documentation in $ARGUMENTS. Analyze: 1) Missing function docs, 2) Outdated comments, 3) Unclear variable names, 4) Missing README sections. Return doc issues as JSON.", subagent_type="general-purpose")

8. **Dependency Scanner**: Task(description="Dependency check", prompt="READ-ONLY ANALYSIS - DO NOT CREATE ANY FILES. Scan dependencies in $ARGUMENTS. Check: 1) Outdated packages, 2) Security vulnerabilities, 3) Unused dependencies, 4) Version conflicts. Return dependency issues as JSON.", subagent_type="general-purpose")

9. **Error Handling Scanner**: Task(description="Error handling analysis", prompt="READ-ONLY ANALYSIS - DO NOT CREATE ANY FILES. Analyze error handling in $ARGUMENTS. Check: 1) Unhandled exceptions, 2) Generic catch blocks, 3) Missing error logs, 4) Poor error messages. Return issues as JSON.", subagent_type="general-purpose")

10. **Integration Point Scanner**: Task(description="Integration analysis", prompt="READ-ONLY ANALYSIS - DO NOT CREATE ANY FILES. Scan integration points in $ARGUMENTS. Identify: 1) External API calls, 2) Database queries, 3) File I/O operations, 4) Network requests. Return integration risks as JSON.", subagent_type="general-purpose")

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

Combine quick scan results with deep expert analysis. **IMPORTANT: Include actionable "Next Steps" commands after each finding:**

```markdown
# Comprehensive Code Analysis Report

## Executive Summary

- **Quick Scan Duration**: [X seconds]
- **Security Analysis Method**: [Semgrep MCP | Local Semgrep | Pattern-Based]  
- **Issues Found**: [Total count by severity]
- **Expert Analysis Completed**: [List of delegated analyses]
- **Overall Health Score**: [X/100]

## 🚀 Quick Actions (Copy & Paste)
```bash
# Generate Action Plan
/global:analysis:analyze-report reports/analyze-deep-$(date +%Y%m%d).json --generate-action-plan

# Start Fixing Issues  
/global:workflow:execute-action-plan ACTION-PLAN-$(date +%Y%m%d).md

# Track Progress
/global:analysis:analyze-deep --export-json --compare-baseline
```

## Critical Findings (Expert-Verified)

### 🔒 Security Issues

[Results from security-specialist if delegated]

**→ FIX COMMANDS:**
```bash
# Fix XSS vulnerabilities
/global:fix:security --target=xss --auto-sanitize

# Add input validation  
/global:fix:security --target=validation --add-schemas

# Security audit
/global:orchestration:security-audit --auto-fix
```

### ⚡ Performance Bottlenecks

[Results from performance-optimizer if delegated]

**→ FIX COMMANDS:**
```bash
# Fix O(n²) algorithms
/global:fix:performance --target=algorithm --auto-optimize

# Optimize database queries
/global:fix:performance --target=database --batch-operations

# Memory leak fixes
/global:fix:performance --target=memory --add-cleanup
```

### 🏗️ Architecture Concerns

[Results from code-architect if delegated]

**→ FIX COMMANDS:**
```bash
# Break down god components
/global:refactoring-expert 'Extract components from large files'

# Fix layer violations
/global:code-architect 'Refactor architecture violations'

# Reduce coupling
/global:code-architect 'Implement dependency injection'
```

### 🧪 Test Coverage Gaps

[Results from test-engineer if delegated]

**→ FIX COMMANDS:**
```bash
# Generate missing tests
/global:generate:tests --focus=critical --coverage-target=90

# Add integration tests
/global:generate:tests --type=integration --auto-create

# Test coverage analysis
/global:orchestration:test-coverage --improve
```

### 🔧 Code Quality Issues

[Results from refactoring-expert if delegated]

**→ FIX COMMANDS:**
```bash
# Remove code duplication
/global:fix:duplicates --extract-shared --auto-refactor

# Fix code smells
/global:fix:quick-wins --target=all --auto-apply

# Add documentation
/global:fix:documentation --add-jsdoc --update-readme
```

## Quick Scan Findings

### Other Issues by Priority

[Findings not requiring deep analysis, organized by severity]

## Action Plan

### Immediate (0-24 hours)

1. **Generate Executable Action Plan**
   ```bash
   /global:analysis:analyze-report reports/analyze-deep-$(date +%Y%m%d).json --generate-action-plan
   ```

2. **Execute Critical Fixes**
   ```bash
   /global:workflow:execute-action-plan ACTION-PLAN-$(date +%Y%m%d).md --filter=critical
   ```

### Short-term (1 week)

1. **Continue with High-Priority Issues**
   ```bash
   /global:workflow:execute-action-plan ACTION-PLAN-$(date +%Y%m%d).md --filter=high
   ```

2. **Track Progress**
   ```bash
   /global:analysis:analyze-deep --export-json --compare-baseline
   ```

### Long-term (1 month)

1. **Complete All Remaining Tasks**
   ```bash
   /global:workflow:execute-action-plan ACTION-PLAN-$(date +%Y%m%d).md --auto-continue
   ```

2. **Final Quality Check**
   ```bash
   /global:analysis:analyze-deep --export-json --final-report
   ```

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
   - Generate filename with timestamp if not provided: `analyze-deep-YYYYMMDD-HHMMSS.json`
   - Create export directory if it doesn't exist: `mkdir -p reports`

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

   - Create reports directory if needed (`mkdir -p reports`)
   - Generate filename with timestamp if not provided
   - Write report file(s) to reports/ directory with proper formatting
   - Display export success message with file path(s)

4. **Update History**:
   - Append to .report-history.json for historical tracking

5. **Cleanup Temporary Files**:
   - Remove any temporary files created during analysis
   - Check for and delete coverage-report.json if it exists
   - Check for and delete performance_analysis.json if it exists
   - Clean up any other temporary analysis artifacts

## Performance Expectations

- **Phase 1**: 
  - With Semgrep MCP: 3-5 seconds (faster security scan)
  - Traditional: 5-8 seconds (parallel scanning)
- **Phase 2**: 10-20 seconds (expert analysis)
- **Phase 3**: 2-3 seconds (synthesis)
- **Phase 4**: 1-2 seconds (export, if enabled)
- **Total**: 15-35 seconds for comprehensive analysis with export

## Tool Enhancement Notes

When Semgrep MCP is available:
- **Security scanning accuracy**: Significantly improved with AST-based analysis
- **False positive rate**: Reduced by 80-90% compared to pattern matching
- **Coverage**: All OWASP Top 10 categories automatically checked

This hybrid approach provides both speed and depth, leveraging parallel scanning for broad coverage and expert sub-agents for detailed insights where needed. The integration of MCP tools when available enhances the quality of security analysis without affecting the overall workflow.
