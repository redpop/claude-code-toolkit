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
"Improve '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when Basic Memory MCP available):**

1. **Pattern Retrieval**: Search Basic Memory for successful improvement patterns and strategies
2. **Best Practice Application**: Apply knowledge-base patterns for technology-specific optimizations
3. **Context-Aware Enhancement**: Use project context and previous improvement decisions for targeted optimizations
4. **Learning Capture**: Persist successful patterns and insights to Basic Memory for future use

**Standard Workflow (always available - no MCP required):**

1. **Best Practice Application**: Apply local knowledge-base/ patterns for technology-specific optimizations
2. **Expert Analysis**: Use built-in specialist expertise for comprehensive improvement recommendations
3. **Risk Assessment**: Apply established improvement strategies with safety considerations
4. **Standard Implementation**: Provide detailed improvement guidance with proven methodologies

**Universal Capabilities (always included):**

- Safe Implementation with risk assessment and testing guidance
- Before/after metrics and impact analysis
- Prioritized improvement recommendations
- Technology-specific optimization strategies

Improvement areas: code quality, performance optimization, security hardening, architectural refactoring, style consistency, dependency management, test coverage, documentation completeness, or modernization based on type.

Export results with enhanced insights when possible, comprehensive improvements guaranteed.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Capture successful improvement patterns and their effectiveness metrics for knowledge persistence
- Generate intelligent next-step recommendations based on improvement results and project context
- Cross-reference improvements with related code quality patterns and successful refactoring strategies
- Track improvement outcomes and refine optimization strategies based on accumulated learning"
