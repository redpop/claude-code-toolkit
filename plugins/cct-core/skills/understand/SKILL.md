---
name: understand
description: This skill should be used when the user asks to "analyze code", "understand this codebase", "explain what this does", "review architecture", or needs code comprehension, dependency analysis, performance profiling, security review, or debugging assistance.
---

# Understand

Analyze and comprehend code with intelligent routing to specialized agents.

## Arguments

Parse arguments: `$ARGUMENTS`

Extract type and target:

- If first argument matches analysis types (code, performance, security, architecture, debug, flow, dependencies, tests, docs, legacy), use as type
- Default: type="code", target="."
- Flags: `--comprehensive`, `--quick`, `--export-json`, `--export-md`

## Execution

Route to specialized analysis agent based on type:

Use Task tool with subagent_type="code-understanding-specialist":
"Perform comprehensive analysis of '$target' with '$type' focus:

1. **Domain Expertise**: Reference technology-specific patterns and best practices
2. **Contextual Analysis**: Analyze current codebase with full contextual understanding
3. **Actionable Output**: Generate detailed analysis with prioritized recommendations

Focus areas based on type:

- **code**: Structure, logic, patterns, readability
- **performance**: Bottlenecks, memory, algorithmic complexity
- **security**: Vulnerabilities, OWASP patterns, input validation
- **architecture**: Design patterns, coupling, modularity
- **debug**: Error traces, state flow, failure points
- **flow**: Control flow, data flow, execution paths
- **dependencies**: Dependency graph, version conflicts, unused packages
- **tests**: Coverage gaps, test quality, missing scenarios
- **docs**: Documentation gaps, API docs, inline comments
- **legacy**: Modernization opportunities, deprecated patterns"

## Export

If `--export-md` or `--export-json` is specified:

1. Create export directory: `.docs/analysis/` (or `docs/analysis/`)
2. Filename: `analysis-{basename}-{YYYY-MM-DD}.{ext}`
3. Write complete analysis using Write tool
4. Report: `Analysis exported to: {path}`

## Output Format

```markdown
# Code Analysis: {target}

**Date:** {YYYY-MM-DD} | **Focus:** {type} | **Lines:** {count}

## Executive Summary
[High-level findings]

## Detailed Analysis
[Comprehensive analysis with sections]

## Actionable Next Steps

### Priority 1: Critical
- [ ] Item

### Priority 2: Important
- [ ] Item

### Priority 3: Recommended
- [ ] Item
```
