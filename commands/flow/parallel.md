---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Write
description: Ultra-fast code analysis with 10 parallel agents for 10x performance
argument-hint: [directory] [--focus=area] [--export-md] [--export-json] [--export-html] [--export-all] [--export-dir=path]
---

**IMPORTANT: This is a READ-ONLY analysis command. Do NOT create, modify, or write any files. Only analyze and report findings.**

# Parallel Code Analysis Command

This command performs a comprehensive code analysis with 10 specialized agents running in parallel. The analysis is typically 10x faster than a sequential investigation.

## Execution

**IMMEDIATELY START 10 PARALLEL AGENTS:**

1. **Code Complexity Agent**: Task(description="Analyse Code Complexity", prompt="Analyze code complexity in $ARGUMENTS. Search for: 1) Functions with high cyclomatic complexity (>10), 2) Deeply nested structures (>4 levels), 3) Long functions (>50 lines), 4) Too many parameters (>5). Return structured JSON with the top 10 most problematic areas.", subagent_type="general-purpose")

2. **Duplicate Code Agent**: Task(description="Detect Code Duplication", prompt="Find duplicated code in $ARGUMENTS. Use tools like rg for pattern matching. Search for: 1) Identical code blocks (>10 lines), 2) Similar structures with minor variations, 3) Copy-paste patterns. Return JSON with duplicates and their locations.", subagent_type="general-purpose")

3. **Style Violations Agent**: Task(description="Check Code Style", prompt="Check code style violations in $ARGUMENTS. Analyze: 1) Inconsistent naming conventions, 2) Formatting issues, 3) Import organization, 4) Comment standards. Focus on the most frequent violations. Return structured JSON.", subagent_type="general-purpose")

4. **Documentation Coverage Agent**: Task(description="Analyze Documentation", prompt="Evaluate documentation quality in $ARGUMENTS. Check: 1) Missing function/class documentation, 2) Outdated comments, 3) README completeness, 4) API documentation. Return coverage metrics as JSON.", subagent_type="general-purpose")

5. **Dead Code Agent**: Task(description="Find Dead Code", prompt="Identify unused code in $ARGUMENTS. Search for: 1) Unused functions/variables, 2) Unreachable code, 3) Unused imports, 4) Orphaned files. Use rg and fd for analysis. Return JSON with dead code locations.", subagent_type="general-purpose")

6. **Type Safety Agent**: Task(description="Analyze Type Safety", prompt="Check type safety in $ARGUMENTS. Analyze: 1) Missing type annotations, 2) Any-types or unclear types, 3) Type mismatches, 4) Unsafe casts. Focus on the most critical areas. Return structured JSON.", subagent_type="general-purpose")

7. **Security Patterns Agent**: Task(description="Security Quick Scan", prompt="Perform a quick security scan in $ARGUMENTS. Search for: 1) Hardcoded secrets/credentials, 2) Unsafe functions (eval, exec), 3) SQL injection risks, 4) Path traversal possibilities. Return the top 5 findings as JSON.", subagent_type="general-purpose")

8. **Performance Profiling Agent**: Task(description="Performance Analysis", prompt="Analyze performance issues in $ARGUMENTS. Identify: 1) O(n²) or worse algorithms, 2) Unnecessary loops/recursions, 3) Memory leak potential, 4) Blocking I/O. Return the most critical performance issues as JSON.", subagent_type="general-purpose")

9. **Test Quality Agent**: Task(description="Assess Test Quality", prompt="Evaluate test quality in $ARGUMENTS. Analyze: 1) Test coverage gaps, 2) Missing edge case tests, 3) Test code quality, 4) Flaky test patterns. Return metrics and improvement suggestions as JSON.", subagent_type="general-purpose")

10. **Dependency Analysis Agent**: Task(description="Analyze Dependencies", prompt="Examine dependencies in $ARGUMENTS. Check: 1) Circular dependencies, 2) Outdated packages, 3) Unnecessary dependencies, 4) License compatibility. Return structured dependency analysis as JSON.", subagent_type="general-purpose")

## Synthesis

After all agents complete:

1. **Collect all JSON outputs** from the 10 agents
2. **Deduplicate findings** that were found by multiple agents
3. **Prioritize by severity**:
   - Critical: Security Issues, Memory Leaks
   - High: Performance Problems, Dead Code
   - Medium: Code Complexity, Duplicates
   - Low: Style Issues, Documentation

4. **Create Executive Summary** with:
   - Overall code health score (0-100)
   - Top 10 most critical issues
   - Quick wins (easily fixable problems)
   - Long-term improvements

5. **Generate Actionable Report**:
   ```markdown
   # Code Analysis Report
   
   ## Executive Summary
   - Health Score: X/100
   - Critical Issues: N
   - Total Issues: M
   - Estimated Fix Time: X hours
   
   ## Critical Findings
   [Sorted list of most important issues]
   
   ## Quick Wins
   [Easily fixable problems]
   
   ## Detailed Analysis
   [Categorized by agent type]
   ```

**Performance Expectation**: This analysis should complete in 5-8 seconds, compared to 50-60 seconds for sequential execution.