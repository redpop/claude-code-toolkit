---
description: Code analysis and comprehension with intelligent problem routing
argument-hint: [type] [target] [--comprehensive] [--quick] [--export-json] [--export-md] [--help]
allowed-tools: Task, mcp____search_notes, mcp____write_note, mcp____build_context
---

# Understand

Analyze code: "What does this code do?"

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Code analysis and comprehension with intelligent problem routing
- **Usage**: [type] [target] [--comprehensive] [--quick] [--export-json] [--export-md]
- **Types**: code, performance, security, architecture, debug, flow, dependencies, tests, docs, legacy
- **Options**:
- `--comprehensive`: Deep analysis with full context
- `--quick`: Fast analysis for immediate insights
- `--export-json`: Generate timestamped JSON report
- `--export-md`: Generate timestamped Markdown report

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract type and target:

- If first argument matches analysis types (code, performance, security, architecture, debug, flow, dependencies, tests, docs, legacy), use as type
- Default: type="code", target="."

Route to enhanced analysis:

Use Task tool with subagent_type="code-understanding-specialist":
"Perform comprehensive analysis of '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when MCP services available):**

1. **Knowledge Retrieval**: Search for similar analysis patterns and previous insights
2. **Domain Expertise**: Reference knowledge-base for technology-specific patterns and best practices
3. **Cross-Project Learning**: Apply accumulated learning from successful analyses across projects
4. **Learning Persistence**: Automatically capture key insights and patterns for future use

**Standard Workflow (always available - no MCP required):**

1. **Domain Expertise**: Reference local knowledge-base/ for technology-specific patterns and best practices
2. **Built-in Analysis**: Apply comprehensive code understanding using established expertise
3. **Real-Time Context**: Analyze current codebase with full contextual understanding
4. **Standard Export**: Generate detailed analysis reports with actionable recommendations

Focus areas: code structure, logic explanation, performance patterns, security implications, architectural decisions, dependencies, testing strategies, documentation gaps, or modernization opportunities based on type.

Export results with timestamped filenames and provide enhanced insights when possible, comprehensive analysis guaranteed.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Automatically extract key insights and architectural patterns for knowledge persistence
- Generate intelligent next-step recommendations based on analysis results
- Cross-reference findings with related knowledge entries and similar analyses
- Create structured knowledge entries linking analysis patterns to successful outcomes"
