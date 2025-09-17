---
description: Code and content generation with intelligent templating and pattern learning
argument-hint: [type] [target] [--format] [--prp] [--from-analysis] [--template] [--help]
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

**PRP Enhancement - Blueprint-Driven Creation:**

If arguments contain "--prp" flag, activate PRP blueprint creation methodology:

- `--prp` alone: Generate comprehensive implementation blueprint
- `--prp=template`: Create from existing template patterns
- `--prp=validation`: Validate blueprint against codebase patterns
- `--prp=fast`: Quick blueprint generation for simple features

**PRP Blueprint Workflow:**

1. **Requirements Integration**: Use requirements from PRP analysis phase
2. **Pattern Application**: Apply discovered patterns via codebase-research-specialist
3. **Architecture Planning**: Create detailed implementation blueprint via blueprint-architect
4. **Quality Gate Definition**: Define comprehensive validation and testing strategies

Route to enhanced generation:

Use Task tool with subagent_type="documentation-specialist" (for docs) or "test-engineer" (for tests) or "frontend-specialist" (for components):
"Generate '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when Basic Memory MCP available):**

1. **Pattern Retrieval**: Search Basic Memory for successful generation patterns and templates
2. **Template Application**: Apply knowledge-base templates for technology-specific generation
3. **Context-Aware Creation**: Use project context and existing patterns for consistent generation
4. **Pattern Learning**: Persist successful generation patterns and templates to Basic Memory

**Standard Workflow (always available - no MCP required):**

1. **Template Application**: Apply local knowledge-base/ templates for technology-specific generation
2. **Expert Creation**: Use specialist expertise for high-quality content generation
3. **Best Practice Standards**: Apply established quality standards and proven methodologies
4. **Consistent Generation**: Create content matching project patterns and conventions

**Universal Capabilities (always included):**

- Quality Standards from established best practices
- Technology-appropriate generation patterns
- Project-consistent styling and conventions
- Comprehensive implementation guidance

Generation areas: comprehensive documentation, thorough test coverage, component scaffolding, API specifications, configuration files, template creation, mock data, or schema definitions based on type.

Export results with enhanced templates when possible, professional generation guaranteed.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Persist successful generation patterns and template effectiveness for knowledge enhancement
- Provide intelligent recommendations for related content creation and documentation strategies
- Cross-reference generated content with similar successful implementations and best practices
- Learn from content creation outcomes to improve future generation quality and consistency"
