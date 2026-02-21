---
name: create
description: This skill should be used when the user asks to "create tests", "generate documentation", "scaffold a component", "create API specs", "generate mock data", or needs code and content generation.
---

# Create

Generate code and content with intelligent routing to specialized agents.

## Arguments

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches types (docs, tests, component, api, config, template, mock, schema), use as type
- Default: type="docs", target="."
- Flags: `--format`, `--from-analysis`, `--template`

## Execution

Route to agent based on type:

- **docs**: subagent_type="documentation-specialist"
- **tests**: subagent_type="test-engineer"
- **component**: subagent_type="frontend-specialist"
- **default**: subagent_type="documentation-specialist"

Prompt for agent:
"Generate '$target' with '$type' focus:

1. **Pattern Analysis**: Examine existing code patterns and conventions
2. **Best Practice Standards**: Apply established quality standards
3. **Consistent Generation**: Match project patterns and conventions
4. **Comprehensive Output**: Generate complete, production-ready content

Generation areas:

- **docs**: Comprehensive documentation with examples
- **tests**: Thorough test coverage with edge cases
- **component**: Component scaffolding with types and styles
- **api**: API specifications with request/response schemas
- **config**: Configuration files with documentation
- **template**: Reusable templates following project patterns
- **mock**: Realistic mock data for testing
- **schema**: Type-safe schema definitions"

## Output Format

Generated content is written directly to the appropriate files. Summary:

```markdown
## Generation Summary

**Type**: {type} | **Target**: {target}

### Files Created
- `path/to/file` — Description

### Next Steps
- [ ] Review generated content
- [ ] Run tests if applicable
```
