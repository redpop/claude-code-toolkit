---
description: Code analysis and comprehension with intelligent problem routing
argument-hint: [type] [target]
allowed-tools: Task, mcp__basic-memory__search_notes, mcp__basic-memory__write_note, mcp__basic-memory__build_context
---

# Understand

Analyze code: "What does this code do?"

## Execution

Parse arguments: `$ARGUMENTS`

Extract type and target:

- If first argument matches analysis types (code, performance, security, architecture, debug, flow, dependencies, tests, docs, legacy), use as type
- Default: type="code", target="."

Route to knowledge-enhanced analysis:

Use Task tool with subagent_type="code-understanding-specialist":
"Perform comprehensive analysis of '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when Basic Memory MCP available):**

1. **Knowledge Retrieval**: Search Basic Memory for similar analysis patterns and previous insights
2. **Domain Expertise**: Reference knowledge-base for technology-specific patterns and best practices  
3. **Cross-Project Learning**: Apply accumulated learning from successful analyses across projects
4. **Learning Persistence**: Automatically capture key insights and patterns to Basic Memory for future use

**Standard Workflow (always available - no MCP required):**

1. **Domain Expertise**: Reference local knowledge-base/ for technology-specific patterns and best practices
2. **Built-in Analysis**: Apply comprehensive code understanding using established expertise
3. **Real-Time Context**: Analyze current codebase with full contextual understanding
4. **Standard Export**: Generate detailed analysis reports with actionable recommendations

Focus areas: code structure, logic explanation, performance patterns, security implications, architectural decisions, dependencies, testing strategies, documentation gaps, or modernization opportunities based on type.

Export results with timestamped filenames and provide enhanced insights when possible, comprehensive analysis guaranteed."
