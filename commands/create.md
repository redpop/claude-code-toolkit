---
description: Code and content generation with intelligent templating and pattern learning
argument-hint: [type] [target] [--format] [--help]
allowed-tools: Task, mcp__basic-memory__search_notes, mcp__basic-memory__write_note, mcp__basic-memory__build_context
---

# Create

Generate code and content: "Create tests for my API."

## Execution

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches generation types (docs, tests, component, api, config, template, mock, schema), use as type
- Default: type="docs", target="."
- Handle --format and other generation options

Route to knowledge-enhanced generation:

Use Task tool with subagent_type="documentation-specialist" (for docs) or "test-engineer" (for tests) or "frontend-specialist" (for components):
"Generate '$target' with '$type' focus using Knowledge-Enhanced approach with template learning:

1. **Pattern Retrieval**: Search Basic Memory for successful generation patterns and templates
2. **Template Application**: Apply knowledge-base templates for technology-specific generation
3. **Context-Aware Creation**: Use project context and existing patterns for consistent generation
4. **Quality Standards**: Apply best practices from knowledge-base and previous successful generations
5. **Pattern Learning**: Persist successful generation patterns and templates to Basic Memory

Generation areas: comprehensive documentation, thorough test coverage, component scaffolding, API specifications, configuration files, template creation, mock data, or schema definitions based on type.

Export results with generated files and implementation guidance."
