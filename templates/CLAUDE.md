# CLAUDE.md - Templates Directory

This file provides context for Claude Code when working with templates in this directory.

## Template Overview

Templates provide consistent starting points for creating new commands, agents, and reports. They ensure standardization and reduce boilerplate work.

## Available Templates

### Agent Templates

**agent-template.md**

- Base template for all new agents
- Includes required frontmatter structure
- Standard sections for agent definition

### Command Templates (`commands/`)

**analysis-sub-agent.md**

- Template for analysis-focused agents
- Structured analysis phases
- Report generation patterns

**analyzer-agent.md**

- Specialized analyzer agent template
- Metrics and measurement focus
- Comparative analysis structure

**basic-sub-agent.md**

- Minimal agent template
- Essential structure only
- Good for simple agents

**helper-agent.md**

- Support and utility agent template
- Tool-like functionality
- Clear input/output structure

**hybrid-sub-agent.md**

- Hybrid architecture command template
- Multi-phase execution pattern
- Combines Task Tool with specialized agents

**mcp-aware-command.md**

- MCP-enhanced command template
- Graceful degradation pattern
- MCP tool detection and usage

**research-sub-agent.md**

- Investigation and research template
- Discovery-oriented structure
- Information gathering patterns

**specialist-agent.md**

- Domain expert agent template
- Deep expertise structure
- Specialized knowledge areas

### Report Templates (`reports/`)

**action-plan-template.md**

- Structured action plan format
- Priority-based organization
- Clear next steps

**markdown-template.md**

- Standard markdown report structure
- Consistent formatting
- Section organization

**json-schema.json**

- JSON report schema definition
- Structured data format
- Validation rules

**next-steps-template.md**

- Post-analysis recommendations
- Actionable items format
- Progress tracking structure

## Using Templates

### For Creating Agents

1. Choose appropriate template based on agent type
2. Copy template to `/agents/` directory
3. Rename to match agent purpose
4. Fill in required frontmatter fields
5. Customize agent instructions
6. Test through orchestration command

Example:

```bash
cp templates/specialist-agent.md agents/database-optimizer.md
# Edit the file to customize
```

### For Creating Commands

1. Select template matching command pattern
2. Copy to appropriate `/commands/` subdirectory
3. Add frontmatter with description
4. Customize workflow steps
5. Include usage examples
6. Run `update-readme.sh` to document

Example:

```bash
cp templates/commands/hybrid-sub-agent.md commands/scan/comprehensive.md
# Customize for specific scanning needs
```

### For Report Generation

Templates guide consistent report formatting:

- Use markdown-template.md for human-readable reports
- Use json-schema.json for structured data
- Use action-plan-template.md for executable plans

## Template Structure

### Standard Sections

Most templates include:

1. **Frontmatter** - Metadata and configuration
2. **Identity** - Role and purpose definition
3. **Instructions** - Core workflow or behavior
4. **Output Format** - Expected results structure
5. **Examples** - Usage demonstrations
6. **Best Practices** - Guidelines and tips

### Frontmatter Requirements

Minimum required fields vary by type:

**Agents**:

```yaml
---
name: agent-name  # REQUIRED
description: Agent purpose
---
```

**Commands**:

```yaml
---
description: Command purpose
argument-hint: expected arguments
---
```

## Creating New Templates

When creating new templates:

1. **Identify Pattern**: Recognize repeated structures
2. **Abstract Common Elements**: Extract reusable parts
3. **Add Placeholders**: Use clear placeholder names
4. **Document Usage**: Include instructions in template
5. **Test Template**: Verify it works as intended

### Template Placeholders

Use consistent placeholder format:

- `[AGENT_NAME]` - Name replacement
- `[DESCRIPTION]` - Description text
- `[SPECIFIC_INSTRUCTIONS]` - Custom instructions
- `$ARGUMENTS` - User input placeholder

## Template Best Practices

### Design Principles

1. **Minimal Viable Structure**: Include only essentials
2. **Clear Placeholders**: Obvious what to replace
3. **Documentation**: Explain template usage
4. **Flexibility**: Allow customization
5. **Consistency**: Match existing patterns

### Maintenance

- Review templates when patterns change
- Update for new Claude Code features
- Remove obsolete templates
- Keep templates synchronized with examples

## Template Categories

### By Purpose

- **Analysis**: Templates for analysis agents/commands
- **Generation**: Content creation templates
- **Orchestration**: Multi-agent coordination
- **Utility**: Helper and tool templates
- **Reporting**: Output format templates

### By Complexity

- **Basic**: Minimal structure templates
- **Standard**: Common use case templates
- **Advanced**: Complex pattern templates
- **Hybrid**: Multi-pattern templates

## Quick Reference

### Most Used Templates

1. **specialist-agent.md** - For domain experts
2. **hybrid-sub-agent.md** - For complex commands
3. **markdown-template.md** - For reports
4. **basic-sub-agent.md** - For simple agents

### Template Selection Guide

- **Need an expert?** → specialist-agent.md
- **Multi-phase command?** → hybrid-sub-agent.md
- **Simple analysis?** → analyzer-agent.md
- **MCP integration?** → mcp-aware-command.md
- **Research task?** → research-sub-agent.md
