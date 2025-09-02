---
allowed-tools: Read, Write, Bash(tailwind:*)
description: Analyze and optimize Tailwind CSS implementation with v4 best practices
argument-hint: "[path] [--check-migration] [--export-json|--export-md]"
---

# Tailwind CSS Optimization Command

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

📚 **Command Help**

Display this command's documentation:

- **Description**: Extract from frontmatter `description` field
- **Usage**: Extract from frontmatter `argument-hint` field
- **Options**: Extract from frontmatter `options` field if present
- **Examples**: Extract from frontmatter `examples` field if present
- **Related**: Extract from frontmatter `see-also` field if present

Format the help output clearly and exit without executing the main command.

---

This command analyzes your Tailwind CSS implementation and provides optimization recommendations based on v4 best practices.

## Workflow

### Step 1: Analyze Tailwind Setup

Use the Task tool with `subagent_type="tailwind-css-specialist"`:

```
Analyze the Tailwind CSS implementation in $ARGUMENTS. Focus on:
1. Current Tailwind version and configuration
2. Build tool setup (PostCSS, Vite, etc.)
3. Content paths configuration
4. Plugin usage and custom utilities
5. Performance metrics (bundle size, unused utilities)
6. Tool integration (Prettier, ESLint, IntelliSense)
7. Accessibility and best practices compliance
8. Migration opportunities if using older version

Provide a comprehensive analysis report with:
- Configuration assessment
- Performance metrics
- Best practices review
- Tool integration recommendations
- Specific optimization actions
```

### Step 2: Export Results (if requested)

If the user includes `--export-json` or `--export-md`:

1. Format the analysis results appropriately
2. Save to timestamped file in project root
3. Provide file location to user

## Usage Examples

```bash
# Basic analysis
/tailwind:optimize .

# Check migration possibilities
/tailwind:optimize . --check-migration

# Export results
/tailwind:optimize src/ --export-json
/tailwind:optimize . --export-md
```

## Key Features

- **Version Detection**: Identifies current Tailwind version and setup
- **Performance Analysis**: Bundle size and optimization opportunities
- **Best Practices**: Checks against Tailwind CSS v4 recommendations
- **Tool Integration**: Setup guides for Prettier, ESLint, VS Code
- **Migration Guidance**: Upgrade path from v3 to v4
- **MCP Enhanced**: Uses Context7 for latest documentation

## Output Format

The analysis provides:

1. **Executive Summary**: Version, scores, and key metrics
2. **Configuration Analysis**: Current setup and recommendations
3. **Performance Metrics**: Bundle size and optimization opportunities
4. **Best Practices Review**: What's working and what needs improvement
5. **Tool Integration**: Setup instructions for development tools
6. **Migration Path**: If applicable, upgrade guidance
7. **Actionable Recommendations**: Prioritized optimization tasks

## Notes

- The agent accesses latest Tailwind documentation via Context7 when available
- Falls back to web resources or built-in knowledge if MCP unavailable
- Focuses on practical, implementable recommendations
- Provides code examples for all suggested changes
