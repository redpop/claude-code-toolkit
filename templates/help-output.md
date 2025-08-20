# Command Help Output Template

This template defines the standard format for command help output in the Claude Code Toolkit. It ensures consistency across all commands and follows Unix man page conventions.

## Template Structure

```markdown
# {{COMMAND_NAMESPACE}}:{{COMMAND_NAME}}

{{BRIEF_DESCRIPTION}}

## SYNOPSIS

```bash
/{{PREFIX}}:{{COMMAND_NAMESPACE}}:{{COMMAND_NAME}} {{USAGE_SYNTAX}}
```

## DESCRIPTION

{{DETAILED_DESCRIPTION}}

{{#if ARGUMENTS}}

## ARGUMENTS

{{#each ARGUMENTS}}
**{{name}}**
: {{description}}
{{#if required}}(Required){{/if}}
{{#if default_value}}Default: `{{default_value}}`{{/if}}

{{/each}}
{{/if}}

{{#if OPTIONS}}

## OPTIONS

{{#each OPTIONS}}
**{{flag}}** {{#if short_flag}}, **{{short_flag}}**{{/if}}
: {{description}}
{{#if default_value}}Default: `{{default_value}}`{{/if}}

{{/each}}
{{/if}}

{{#if EXAMPLES}}

## EXAMPLES

{{#each EXAMPLES}}

### {{title}}

```bash
{{command}}
```

{{description}}

{{/each}}
{{/if}}

{{#if NOTES}}

## NOTES

{{NOTES}}
{{/if}}

{{#if SEE_ALSO}}

## SEE ALSO

{{#each SEE_ALSO}}

- `/{{../PREFIX}}:{{command}}` - {{description}}
{{/each}}
{{/if}}

{{#if AGENT_INFO}}

## AGENT INFORMATION

**Agent Type**: {{AGENT_INFO.type}}
**Specialization**: {{AGENT_INFO.specialization}}
{{#if AGENT_INFO.capabilities}}
**Capabilities**: {{AGENT_INFO.capabilities}}
{{/if}}
{{/if}}

## EXIT STATUS

- **0**: Success
- **1**: General error
- **2**: Invalid arguments
- **3**: File not found
- **4**: Permission denied

```

## Placeholder Reference

### Required Placeholders

| Placeholder | Description | Example |
|------------|-------------|---------|
| `{{COMMAND_NAMESPACE}}` | Command category | `scan`, `fix`, `gen` |
| `{{COMMAND_NAME}}` | Specific command name | `deep`, `quick-wins`, `component` |
| `{{PREFIX}}` | Installation prefix | `myproject`, `toolkit` |
| `{{BRIEF_DESCRIPTION}}` | One-line command summary | "Perform deep code analysis with security focus" |
| `{{USAGE_SYNTAX}}` | Command syntax pattern | `[PATH] [OPTIONS]` |
| `{{DETAILED_DESCRIPTION}}` | Multi-line detailed explanation | Full command purpose and behavior |

### Optional Placeholders

| Placeholder | Description | Usage |
|------------|-------------|-------|
| `{{ARGUMENTS}}` | Positional arguments array | Include if command takes arguments |
| `{{OPTIONS}}` | Command-line flags array | Include if command has options |
| `{{EXAMPLES}}` | Usage examples array | Always recommended |
| `{{NOTES}}` | Additional information | Include for important caveats |
| `{{SEE_ALSO}}` | Related commands array | Include for command discoverability |
| `{{AGENT_INFO}}` | Agent-specific information | Include for agent-based commands |

## Formatting Guidelines

### Command References
- Use backticks for command names: `/prefix:scan:deep`
- Use code blocks for command examples
- Use bold for option flags: **--export-json**

### Descriptions
- Keep brief descriptions under 80 characters
- Use active voice: "Analyzes code" not "Code is analyzed"
- Start with a verb: "Perform", "Generate", "Fix"

### Arguments and Options
- Use definition list format with colons
- Mark required arguments clearly
- Include default values when applicable
- Group related options together

### Examples
- Provide realistic, practical examples
- Include expected output when helpful
- Show progressive complexity (simple to advanced)
- Use descriptive titles for each example

## Example Implementation

```markdown
# scan:deep

Perform comprehensive code analysis with security and quality focus

## SYNOPSIS

```bash
/myproject:scan:deep [PATH] [OPTIONS]
```

## DESCRIPTION

Conducts a thorough analysis of the codebase including security vulnerabilities,
code quality issues, performance bottlenecks, and architectural concerns.
Generates detailed reports with actionable recommendations.

## ARGUMENTS

**PATH**
: Directory or file path to analyze
Default: `.` (current directory)

## OPTIONS

**--export-json**
: Export results to timestamped JSON file

**--export-md**
: Export results to timestamped Markdown report

**--focus** *AREA*
: Limit analysis to specific area (security, performance, quality)

**--exclude** *PATTERN*
: Exclude files matching pattern

**--verbose**, **-v**
: Enable verbose output

## EXAMPLES

### Basic Analysis

```bash
/myproject:scan:deep
```

Analyze current directory with default settings.

### Focused Security Scan

```bash
/myproject:scan:deep src/ --focus security --export-json
```

Analyze only the src/ directory for security issues and export results.

### Comprehensive Project Analysis

```bash
/myproject:scan:deep . --export-md --verbose --exclude "node_modules/*"
```

Full project analysis excluding dependencies, with detailed output.

## NOTES

- Large codebases may take several minutes to analyze
- JSON exports are suitable for further processing
- Use --focus to reduce analysis time for specific concerns

## SEE ALSO

- `/myproject:scan:quick` - Fast basic code scan
- `/myproject:scan:report` - Generate report from previous scan
- `/myproject:fix:quick-wins` - Apply automated fixes
- `/myproject:auto:execute` - Execute action plan from scan

## AGENT INFORMATION

**Agent Type**: code-analysis-specialist
**Specialization**: Comprehensive codebase analysis and quality assessment
**Capabilities**: Security scanning, performance analysis, code quality metrics

## EXIT STATUS

- **0**: Success
- **1**: General error
- **2**: Invalid arguments
- **3**: File not found
- **4**: Permission denied

```

## Usage Instructions

1. **Copy Template**: Start with the template structure above
2. **Replace Placeholders**: Fill in all required placeholders
3. **Add Optional Sections**: Include relevant optional sections
4. **Review Format**: Ensure consistent formatting
5. **Test Output**: Verify readability and completeness

## Template Validation

When using this template, ensure:

- [ ] All required placeholders are replaced
- [ ] Examples are practical and tested
- [ ] Related commands are accurately listed
- [ ] Formatting follows guidelines
- [ ] Content is appropriate for target audience

## Integration with Help Generator

This template is designed to work with the help generator script:

```bash
# Generate help for a specific command
./scripts/generate-help.sh scan deep

# Validate all help outputs
./scripts/validate-help.sh
```

The help generator should parse command metadata and populate this template accordingly.
