---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*)
description: Ultra-fast parallel code analysis with 10 specialized agents
argument-hint: <directory> [--focus=area] [--export-json]
---

# Parallel Code Analysis

Lightning-fast code analysis using 10 parallel agents, delivering comprehensive results in seconds instead of minutes.

## How It Works

All 10 agents run simultaneously, each scanning for specific issues. Results are then consolidated and prioritized.

**Expected Performance**: 5-8 seconds total (vs 50-60 seconds sequential)

## Execution

**Target**: $ARGUMENTS

### Deploying 10 Parallel Agents

Use Task tool with subagent_type="general-purpose" for ALL agents simultaneously:

1. **Complexity Agent**
   "Find functions with cyclomatic complexity >10, nesting >4 levels, length >50 lines in $ARGUMENTS. Return top 10 as JSON."

2. **Duplication Agent**  
   "Find duplicate code blocks >10 lines in $ARGUMENTS. Use pattern matching to identify copy-paste code. Return JSON with locations."

3. **Style Agent**
   "Check style violations in $ARGUMENTS: naming conventions, formatting, import order. Return most frequent issues as JSON."

4. **Documentation Agent**
   "Find missing docs in $ARGUMENTS: undocumented functions/classes, outdated comments, incomplete READMEs. Return as JSON."

5. **Dead Code Agent**
   "Identify unused code in $ARGUMENTS: unused functions, variables, imports, unreachable code. Return locations as JSON."

6. **Type Safety Agent**
   "Check type issues in $ARGUMENTS: missing annotations, any-types, type mismatches. Return critical type issues as JSON."

7. **Security Agent**
   "Quick security scan of $ARGUMENTS: hardcoded secrets, unsafe functions, injection risks. Return top 5 security issues as JSON."

8. **Performance Agent**
   "Find performance issues in $ARGUMENTS: O(n²) algorithms, unnecessary loops, memory leaks. Return bottlenecks as JSON."

9. **Test Quality Agent**
   "Assess test quality in $ARGUMENTS: coverage gaps, missing edge cases, flaky patterns. Return test issues as JSON."

10. **Dependency Agent**
    "Analyze dependencies in $ARGUMENTS: circular deps, outdated packages, license issues. Return dependency problems as JSON."

### Result Synthesis

After all agents complete, consolidate findings:

## Parallel Analysis Report

### Executive Summary
- **Scan Duration**: [X seconds]
- **Total Issues**: [Count by severity]  
- **Health Score**: [0-100]

### Critical Issues (Immediate Action)
[Security vulnerabilities, memory leaks, broken functionality]

### High Priority (This Sprint)
[Performance problems, major code smells, missing tests]

### Medium Priority (Next Sprint)
[Code complexity, documentation gaps, style issues]

### Quick Wins (< 1 hour each)
[Easy fixes with high impact]

## Next Steps

```bash
# Execute high-ROI fixes
/prefix:fix:quick-wins

# Deep dive into critical issues
/prefix:scan:deep --focus=security

# Generate action plan
/prefix:scan:report parallel-results.json --generate-action-plan
```

## Usage Examples

```bash
# Quick health check
/prefix:flow:parallel src/

# Focused analysis
/prefix:flow:parallel src/api --focus=security

# Export for automation
/prefix:flow:parallel . --export-json=health-check.json
```

## Integration Points

This command is ideal for:
- Pre-commit hooks (fast enough for real-time)
- CI/CD pipeline quality gates
- Daily health checks
- Quick project assessments

## Key Benefits

- **10x Faster**: Parallel execution vs sequential
- **Comprehensive**: Covers all major quality aspects
- **Actionable**: Prioritized findings with next steps
- **Lightweight**: No external dependencies