# Claude Code Toolkit Help System

Comprehensive documentation for the help system that makes the Claude Code Toolkit discoverable and accessible.

## Overview

The Claude Code Toolkit help system provides multiple ways to discover, understand, and use commands. It combines automated metadata extraction, intelligent search, and structured documentation to create a comprehensive help experience.

### Purpose

- **Discoverability**: Help users find the right commands for their tasks
- **Guidance**: Provide clear usage instructions and examples
- **Learning**: Support users in understanding command capabilities
- **Efficiency**: Reduce time spent searching for information

### Benefits

- **Consistent Experience**: All commands follow the same help format
- **Self-Documenting**: Commands include their own help metadata
- **Intelligent Search**: Find commands by name, description, or functionality
- **Progressive Disclosure**: From quick overview to detailed documentation

## User Guide

### Basic Help Usage

All toolkit commands support the `--help` flag for immediate assistance:

```bash
# Get help for any command
/prefix:scan:deep --help
/prefix:fix:quick-wins --help
/prefix:meta:chain --help

# Help flag variants
/prefix:scan:deep -h
/prefix:scan:deep --help
```

### Meta Help Command

The `meta:help` command provides comprehensive help functionality:

```bash
# Show help for specific command
/prefix:meta:help scan:deep
/prefix:meta:help fix:security

# List all available commands
/prefix:meta:help --list

# Search commands by keyword
/prefix:meta:help --search security
/prefix:meta:help --search performance

# Show command categories
/prefix:meta:help --categories

# Get help on the help system itself
/prefix:meta:help help
```

### Help Output Format

Standard help output includes:

1. **Command Name**: Full command with prefix
2. **Description**: Brief purpose statement
3. **Usage**: Syntax with arguments and options
4. **Options**: Detailed flag descriptions
5. **Examples**: Practical usage scenarios
6. **See Also**: Related commands and workflows

Example output:

```
NAME
    /prefix:scan:deep

DESCRIPTION
    Deep code analysis with streamlined output and clear workflow guidance

USAGE
    /prefix:scan:deep <directory> [--focus=security|performance|architecture|all] [--export-md] [--export-json]

OPTIONS
    --focus              Focus analysis on specific aspect (default: all)
    --export-md          Export analysis results as timestamped Markdown report
    --export-json        Export analysis results as timestamped JSON report

EXAMPLES
    /prefix:scan:deep src/
    /prefix:scan:deep . --focus=security --export-json
    /prefix:scan:deep . --export-md

SEE ALSO
    /prefix:scan:report  - Generate action plan from analysis results
    /prefix:scan:quick   - Fast code quality check
    /prefix:fix:quick-wins - Apply easy fixes from analysis
```

## Developer Guide

### Adding Help Support to New Commands

To add comprehensive help support to a new command:

#### 1. Add YAML Frontmatter

Include detailed metadata at the top of your command file:

```yaml
---
description: Brief one-line description of what the command does
argument-hint: <required-arg> [optional-arg] [--flag] [--option=value]
options:
  - name: "--flag-name"
    description: "What this flag does"
    type: "flag"
  - name: "--option-name"
    description: "What this option controls"
    values: "value1|value2|value3"
    default: "value1"
examples:
  - command: "/prefix:category:command basic-usage"
    description: "Basic usage example"
  - command: "/prefix:category:command --advanced-flag"
    description: "Advanced usage example"
see-also:
  - "/prefix:related:command - What it does"
  - "/prefix:other:command - How it relates"
mcp-enhanced: "server1,server2"  # Optional: if command uses MCP servers
---
```

#### 2. Add Inline Help Check

Include a help check section in your command logic:

```markdown
## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display:

- Command name and description
- Usage syntax
- All arguments and options
- Examples
- Related commands

Then exit without executing main functionality.
```

#### 3. Implementation Example

```bash
# Help check implementation
if [[ "$ARGUMENTS" == *"--help"* ]] || [[ "$ARGUMENTS" == *"-h"* ]]; then
    echo "# command:name - Brief description"
    echo ""
    echo "Detailed description of what the command does."
    echo ""
    echo "## Usage:"
    echo "  /prefix:category:command [arguments] [options]"
    echo ""
    echo "## Options:"
    echo "  --flag         Description of flag"
    echo "  --option=VAL   Description of option"
    echo ""
    echo "## Examples:"
    echo "  /prefix:category:command basic-example"
    echo "  /prefix:category:command --advanced-option"
    echo ""
    echo "## See Also:"
    echo "  /prefix:related:command - Related functionality"
    exit 0
fi
```

### Frontmatter Field Reference

| Field | Required | Description | Example |
|-------|----------|-------------|---------|
| `description` | Yes | One-line command summary | "Deep code analysis with security focus" |
| `argument-hint` | Yes | Usage syntax pattern | `<path> [--focus=type] [--export]` |
| `options` | Recommended | Array of command options | See options structure below |
| `examples` | Recommended | Usage examples array | See examples structure below |
| `see-also` | Recommended | Related commands list | Array of related commands |
| `mcp-enhanced` | Optional | MCP server dependencies | "semgrep,github" |

#### Options Structure

```yaml
options:
  - name: "--flag-name"          # Required: option name
    description: "What it does"  # Required: clear description
    type: "flag"                 # Optional: flag|option
    values: "val1|val2"          # Optional: for choice options
    default: "default-value"     # Optional: default value
```

#### Examples Structure

```yaml
examples:
  - command: "/prefix:cmd basic-usage"     # Required: full command
    description: "What this example shows" # Required: explanation
  - command: "/prefix:cmd --advanced"
    description: "Advanced usage pattern"
```

## Architecture

### Component Overview

The help system consists of four main components:

1. **Command Metadata**: YAML frontmatter in command files
2. **Help Generator Script**: Parses metadata and formats output
3. **Help Template**: Standard format for consistent output
4. **Meta Help Command**: Interactive help interface

### Data Flow

```
Command File (.md)
    ↓
YAML Frontmatter Extraction
    ↓
Metadata Parsing
    ↓
Template Application
    ↓
Formatted Help Output
```

### File Structure

```
claude-code-toolkit/
├── commands/              # Command files with frontmatter
│   ├── scan/deep.md      # Contains help metadata
│   └── fix/quick-wins.md # Contains help metadata
├── scripts/
│   └── generate-help.sh  # Help generation script
├── templates/
│   └── help-output.md    # Help formatting template
└── docs/guides/
    └── HELP-SYSTEM.md    # This documentation
```

### Integration Points

- **Command Execution**: All commands check for `--help` flag
- **Meta Commands**: `meta:help` provides comprehensive help interface
- **Documentation**: Help output feeds into documentation generation
- **Discovery**: Help system supports command discovery workflows

## Command Metadata

### Required Fields

#### description

- **Purpose**: One-line summary of command functionality
- **Format**: Plain text, under 80 characters
- **Style**: Start with verb, active voice
- **Example**: `"Deep code analysis with security focus"`

#### argument-hint

- **Purpose**: Shows command syntax and parameter structure
- **Format**: `<required> [optional] [--flags] [--options=value]`
- **Conventions**:
  - `<arg>` for required arguments
  - `[arg]` for optional arguments
  - `--flag` for boolean flags
  - `--option=value` for value options
- **Example**: `"<directory> [--focus=security|performance] [--export-json]"`

### Optional Fields

#### options

Detailed option specifications:

```yaml
options:
  - name: "--export-json"
    description: "Export results to timestamped JSON file"
    type: "flag"
  - name: "--focus"
    description: "Analysis focus area"
    values: "security|performance|architecture|all"
    default: "all"
```

#### examples

Practical usage scenarios:

```yaml
examples:
  - command: "/prefix:scan:deep src/"
    description: "Basic analysis of source directory"
  - command: "/prefix:scan:deep . --focus=security --export-json"
    description: "Security-focused analysis with JSON export"
```

#### see-also

Related commands and workflows:

```yaml
see-also:
  - "/prefix:scan:report - Generate action plan from results"
  - "/prefix:fix:quick-wins - Apply automated fixes"
  - "/prefix:meta:pipelines deep-quality - Complete pipeline"
```

#### mcp-enhanced

MCP server dependencies:

```yaml
mcp-enhanced: "semgrep,github,gitlab"
```

### Validation Rules

- **description**: Must be present, under 80 characters
- **argument-hint**: Must be present, follow syntax conventions
- **options**: If present, each must have name and description
- **examples**: If present, each must have command and description
- **see-also**: If present, must reference valid commands

## Help Generator Script

### Overview

The `scripts/generate-help.sh` script processes command metadata and generates formatted help output.

### Usage

```bash
# Generate help for specific command
./scripts/generate-help.sh scan/deep.md

# Generate help with options
./scripts/generate-help.sh scan/deep.md --no-color
./scripts/generate-help.sh scan/deep.md --raw

# Generate help for all commands
find commands -name "*.md" -not -name "CLAUDE.md" | \
    xargs -I {} ./scripts/generate-help.sh {}
```

### Script Options

| Option | Description | Use Case |
|--------|-------------|----------|
| `--no-color` | Disable colored output | CI/CD, plain text files |
| `--raw` | Raw text without formatting | Machine processing |
| `--help` | Show script usage | Documentation reference |

### Features

#### YAML Frontmatter Parsing

- Extracts metadata from command files
- Handles complex nested structures
- Validates required fields
- Provides fallback for missing data

#### Intelligent Formatting

- Color-coded output for terminal display
- Consistent section organization
- Proper spacing and alignment
- Terminal width awareness

#### Error Handling

- Validates command file existence
- Handles malformed YAML gracefully
- Provides helpful error messages
- Suggests corrections for common issues

### Implementation Details

#### Frontmatter Extraction

```bash
function extract_frontmatter() {
    local file="$1"
    local in_frontmatter=false
    local frontmatter=""
    
    while IFS= read -r line; do
        if [[ "$line" == "---" ]]; then
            if [[ "$in_frontmatter" == "false" ]]; then
                in_frontmatter=true
                continue
            else
                break
            fi
        fi
        
        if [[ "$in_frontmatter" == "true" ]]; then
            frontmatter+="$line"$'\n'
        fi
    done < "$file"
    
    echo "$frontmatter"
}
```

#### Option Parsing

```bash
function extract_options() {
    local yaml_content="$1"
    local in_options=false
    
    echo "$yaml_content" | while IFS= read -r line; do
        if [[ "$line" =~ ^options: ]]; then
            in_options=true
            continue
        fi
        
        if [[ "$in_options" == "true" ]]; then
            # Parse option entries...
        fi
    done
}
```

## Help Template

### Template Structure

The `templates/help-output.md` file defines the standard format for all help output:

```markdown
# {{COMMAND_NAMESPACE}}:{{COMMAND_NAME}}

{{BRIEF_DESCRIPTION}}

## SYNOPSIS

```bash
/{{PREFIX}}:{{COMMAND_NAMESPACE}}:{{COMMAND_NAME}} {{USAGE_SYNTAX}}
```

## DESCRIPTION

{{DETAILED_DESCRIPTION}}

## OPTIONS

{{#each OPTIONS}}
**{{flag}}**
: {{description}}
{{#if default_value}}Default: `{{default_value}}`{{/if}}
{{/each}}

## EXAMPLES

{{#each EXAMPLES}}

```bash
{{command}}
```

{{description}}
{{/each}}

## SEE ALSO

{{#each SEE_ALSO}}

- `{{command}}` - {{description}}
{{/each}}

```

### Template Variables

#### Required Variables
- `{{COMMAND_NAMESPACE}}`: Command category (scan, fix, gen, etc.)
- `{{COMMAND_NAME}}`: Specific command name
- `{{PREFIX}}`: Installation prefix
- `{{BRIEF_DESCRIPTION}}`: One-line summary
- `{{USAGE_SYNTAX}}`: Argument pattern

#### Optional Variables
- `{{DETAILED_DESCRIPTION}}`: Extended explanation
- `{{OPTIONS}}`: Array of command options
- `{{EXAMPLES}}`: Array of usage examples
- `{{SEE_ALSO}}`: Array of related commands
- `{{NOTES}}`: Additional information

### Customization

#### Adding New Sections
```markdown
{{#if CUSTOM_SECTION}}
## CUSTOM SECTION

{{CUSTOM_SECTION}}
{{/if}}
```

#### Conditional Content

```markdown
{{#if MCP_ENHANCED}}
## MCP ENHANCEMENT

This command is enhanced with MCP servers: {{MCP_ENHANCED}}
{{/if}}
```

## Meta Help Command

### Overview

The `commands/meta/help.md` command provides the primary help interface for users.

### Features

#### Command-Specific Help

```bash
/prefix:meta:help scan:deep
```

Shows detailed help for the specific command including:

- Full description and usage
- All options and examples
- Related commands
- Next steps recommendations

#### Command Listing

```bash
/prefix:meta:help --list
```

Displays all available commands organized by category:

- Scan commands
- Fix commands
- Generation commands
- Flow commands
- Meta commands

#### Search Functionality

```bash
/prefix:meta:help --search security
```

Finds commands matching the search term in:

- Command names
- Descriptions
- Content
- Keywords

#### Category Overview

```bash
/prefix:meta:help --categories
```

Shows all command categories with:

- Purpose and scope
- Command count
- Key commands
- Usage patterns

### Implementation

#### Argument Parsing

```bash
# Extract search terms and flags
if [[ "$ARGUMENTS" =~ --search[[:space:]]+([^[:space:]]+) ]]; then
    SEARCH_TERM="${BASH_REMATCH[1]}"
elif [[ "$ARGUMENTS" =~ ^[a-z]+:[a-z-]+$ ]]; then
    COMMAND_NAME="$ARGUMENTS"
fi
```

#### Command Discovery

```bash
# Find all command files
find commands -name "*.md" -not -name "CLAUDE.md" | while read -r cmd_file; do
    # Extract metadata and build help
done
```

#### Fuzzy Matching

```bash
# Suggest similar commands for typos
function find_similar_commands() {
    local input="$1"
    local commands=("${@:2}")
    
    for cmd in "${commands[@]}"; do
        # Calculate string similarity
        similarity=$(calculate_similarity "$input" "$cmd")
        if [[ "$similarity" -gt 70 ]]; then
            echo "$cmd"
        fi
    done
}
```

## Best Practices

### Writing Good Help Content

#### Descriptions

- **Be Concise**: One line, under 80 characters
- **Start with Verb**: "Analyze", "Generate", "Fix"
- **Use Active Voice**: "Scans files" not "Files are scanned"
- **Be Specific**: "Security vulnerability scanning" not "Code checking"

#### Argument Hints

- **Use Conventions**: `<required>` and `[optional]`
- **Show Choices**: `[--format=json|md|txt]`
- **Indicate Defaults**: Common patterns first
- **Be Complete**: Include all significant options

#### Examples

- **Start Simple**: Basic usage first
- **Show Progression**: Simple to advanced
- **Be Realistic**: Use actual file/directory names
- **Include Output**: Show what to expect when helpful

#### Options

- **Clear Names**: Self-documenting flag names
- **Good Descriptions**: Explain purpose and effect
- **Show Defaults**: When applicable
- **Group Related**: Organize by functionality

### Consistency Guidelines

#### Naming Conventions

- Commands: `category:name` (lowercase, hyphens)
- Flags: `--kebab-case` format
- Options: `--option=value` format
- Files: `category/name.md` structure

#### Format Standards

- Line length: 80 characters for descriptions
- Code blocks: Use bash syntax highlighting
- Lists: Use consistent bullet styles
- Headings: Follow markdown hierarchy

#### Content Organization

1. Brief description
2. Usage syntax
3. Detailed description
4. Arguments (if any)
5. Options (if any)
6. Examples (always recommended)
7. Notes (if needed)
8. See also (always recommended)

### Common Patterns

#### Security Commands

```yaml
description: "Security-focused analysis with vulnerability detection"
argument-hint: "[path] [--severity=low|medium|high|critical] [--export]"
see-also:
  - "/prefix:fix:security - Apply security fixes"
  - "/prefix:scan:deep --focus=security - Deep security analysis"
```

#### Analysis Commands

```yaml
description: "Analyze codebase for [specific aspect]"
argument-hint: "[path] [--export-json] [--export-md] [--focus=area]"
examples:
  - command: "/prefix:scan:analysis ."
    description: "Basic analysis of current directory"
  - command: "/prefix:scan:analysis src/ --export-json"
    description: "Analyze source with JSON export"
```

#### Fix Commands

```yaml
description: "Automatically fix [specific issues]"
argument-hint: "[report.json] [--dry-run] [--category=type]"
options:
  - name: "--dry-run"
    description: "Preview changes without applying them"
    type: "flag"
```

## Examples

### Real Command Examples

#### scan:deep Command

**Frontmatter:**

```yaml
---
description: Deep code analysis with streamlined output and clear workflow guidance
argument-hint: <directory> [--focus=security|performance|architecture|all] [--export-md] [--export-json]
options:
  - name: "--focus"
    description: "Focus analysis on specific aspect"
    values: "security|performance|architecture|all"
    default: "all"
  - name: "--export-md"
    description: "Export analysis results as timestamped Markdown report"
    type: "flag"
  - name: "--export-json"
    description: "Export analysis results as timestamped JSON report"
    type: "flag"
examples:
  - command: "/prefix:scan:deep src/"
    description: "Basic deep scan of source directory"
  - command: "/prefix:scan:deep . --focus=security --export-json"
    description: "Security-focused analysis with JSON export"
see-also:
  - "/prefix:scan:report - Generate action plan from analysis results"
  - "/prefix:fix:quick-wins - Apply easy fixes from analysis"
---
```

**Generated Help Output:**

```
NAME
    /prefix:scan:deep

DESCRIPTION
    Deep code analysis with streamlined output and clear workflow guidance

USAGE
    /prefix:scan:deep <directory> [--focus=security|performance|architecture|all] [--export-md] [--export-json]

OPTIONS
    --focus              Focus analysis on specific aspect (default: all)
    --export-md          Export analysis results as timestamped Markdown report
    --export-json        Export analysis results as timestamped JSON report

EXAMPLES
    /prefix:scan:deep src/
    /prefix:scan:deep . --focus=security --export-json

SEE ALSO
    /prefix:scan:report  - Generate action plan from analysis results
    /prefix:fix:quick-wins - Apply easy fixes from analysis
```

#### fix:quick-wins Command

**Frontmatter:**

```yaml
---
description: Apply high-ROI fixes from analysis reports - quick wins with maximum impact and minimal effort
argument-hint: [report.json] [--dry-run] [--category=security|performance|quality] [--max-effort=4h] [--min-roi=5]
options:
  - name: "--dry-run"
    description: "Preview changes without applying them - shows what would be fixed"
    type: "flag"
  - name: "--category"
    description: "Filter fixes by category"
    values: "security|performance|quality"
  - name: "--max-effort"
    description: "Maximum effort threshold in hours"
    default: "4h"
examples:
  - command: "/prefix:fix:quick-wins report.json --dry-run"
    description: "Preview all quick wins"
  - command: "/prefix:fix:quick-wins --latest --category=security"
    description: "Apply only security fixes from latest report"
---
```

**Help Check Implementation:**

```bash
if [[ "$ARGUMENTS" == *"--help"* ]]; then
    echo "# Fix Quick Wins Help"
    echo ""
    echo "Apply high-ROI fixes from analysis reports - quick wins with maximum impact and minimal effort."
    echo ""
    echo "## Usage:"
    echo "  /prefix:fix:quick-wins [report.json] [options]"
    echo ""
    echo "## Options:"
    echo "  --dry-run             Preview changes without applying them"
    echo "  --category=TYPE       Filter by fix category (security|performance|quality)"
    echo "  --max-effort=HOURS    Maximum effort threshold (default: 4h)"
    echo "  --min-roi=SCORE       Minimum ROI score threshold (default: 5)"
    echo ""
    echo "## Examples:"
    echo "  /prefix:fix:quick-wins report.json --dry-run"
    echo "  /prefix:fix:quick-wins --latest --category=security"
    echo ""
    exit 0
fi
```

### Help System Usage Examples

#### Finding Commands

```bash
# Find security-related commands
/prefix:meta:help --search security

# Find all scanning commands
/prefix:meta:help --search scan

# Browse by category
/prefix:meta:help --categories
```

#### Getting Specific Help

```bash
# Help for deep analysis
/prefix:meta:help scan:deep
/prefix:scan:deep --help

# Help for quick fixes
/prefix:meta:help fix:quick-wins
/prefix:fix:quick-wins --help

# Help for command chaining
/prefix:meta:help meta:chain
```

#### Integration Workflows

```bash
# Learn then execute
/prefix:meta:help scan:deep
/prefix:scan:deep . --export-json

# Search and discover
/prefix:meta:help --search performance
/prefix:meta:help scan:perf
/prefix:scan:perf backend/

# Pipeline discovery
/prefix:meta:help --categories
/prefix:meta:help meta:pipelines
/prefix:meta:pipelines deep-quality
```

## Integration and Workflows

### Command Discovery Flow

1. **User Need**: User has a task but doesn't know which command
2. **Search**: Use `meta:help --search <keyword>`
3. **Explore**: Browse categories with `meta:help --categories`
4. **Learn**: Get specific help with `meta:help <command>`
5. **Execute**: Run command with proper options
6. **Chain**: Use suggested next steps from help output

### Documentation Integration

- **Auto-generated Docs**: Help output feeds into documentation
- **Consistency**: Same content in help and docs
- **Cross-references**: Help points to detailed docs
- **Examples**: Shared between help and tutorials

### Development Workflow

1. **Create Command**: Write command with frontmatter
2. **Test Help**: Verify help output with generator script
3. **Validate**: Check consistency and completeness
4. **Document**: Update any additional documentation
5. **Integration**: Ensure proper categorization

The help system creates a discoverable, learnable, and efficient command experience that grows with user expertise while maintaining accessibility for newcomers.
