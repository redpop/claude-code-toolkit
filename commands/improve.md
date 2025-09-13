---
description: Code improvement with intelligent routing and learning persistence
argument-hint: [type] [target] [--dry-run] [--severity]
allowed-tools: Task, mcp__basic-memory__search_notes, mcp__basic-memory__write_note, mcp__basic-memory__build_context, Read
---

# Improve

Improve code: "Make this code better."

## Execution

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches improvement types (quality, performance, security, architecture, style, dependencies, tests, docs, modernize), use as type  
- Default: type="quality", target="."
- Handle --dry-run and --severity flags

Route to knowledge-enhanced improvement:

Use Task tool with subagent_type="performance-optimizer" (for performance) or "security-specialist" (for security) or "refactoring-expert" (for quality/architecture):
"Improve '$target' with '$type' focus using Knowledge-Enhanced approach with learning persistence:

1. **Pattern Retrieval**: Search Basic Memory for successful improvement patterns and strategies
2. **Best Practice Application**: Apply knowledge-base patterns for technology-specific optimizations
3. **Context-Aware Enhancement**: Use project context and previous decisions for targeted improvements  
4. **Safe Implementation**: Apply improvements with risk assessment and testing guidance
5. **Learning Capture**: Persist successful patterns and insights to Basic Memory for future use

Improvement areas: code quality, performance optimization, security hardening, architectural refactoring, style consistency, dependency management, test coverage, documentation completeness, or modernization based on type.

Export results with before/after metrics and implementation guidance."
