---
description: Display help for commands or list available commands
argument-hint: [command-name] [--list] [--search <keyword>] [--categories]
---

# Claude Code Toolkit Help System

Comprehensive help system for discovering and learning about Claude Code Toolkit commands.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Display help for commands or list available commands
- **Usage**: [command-name] [--list] [--search <keyword>] [--categories]
- **Options**: See options section below
- **Examples**: See usage examples section below

Then exit without executing the main command.

---

## Usage

```bash
# Show help for specific command
/prefix:meta:help scan:deep
/prefix:meta:help fix:security

# List all available commands
/prefix:meta:help --list

# Search commands by keyword
/prefix:meta:help --search security
/prefix:meta:help --search refactor

# Show command categories
/prefix:meta:help --categories

# Get help on help command
/prefix:meta:help help
```

## How It Works

The help system automatically:

1. **Parses Arguments**: Determines what type of help to display
2. **Scans Commands**: Reads all available command files in the toolkit
3. **Extracts Metadata**: Gets descriptions, argument hints, and content
4. **Formats Output**: Presents information in a user-friendly format
5. **Handles Partial Matches**: Suggests similar commands if exact match not found

## Execution

Analyzing request: "$ARGUMENTS"

### Determine Help Type

**Arguments parsing**:

- No arguments or "help" → Show general help
- Contains "--list" → List all commands
- Contains "--search" → Search by keyword
- Contains "--categories" → Show categories
- Single word without flags → Show specific command help
- "--search keyword" → Search for keyword

**Extracting search term**:

- If "--search keyword", extract "keyword"
- If just text without flags, treat as command name

### Command Discovery

Use Glob tool to find all command files:

- Pattern: `commands/**/*.md`
- Exclude: `commands/CLAUDE.md`

### Command Information Extraction

For each command file found, use Read tool to extract:

1. **Frontmatter**: description, argument-hint, allowed-tools
2. **Title**: First # heading
3. **Purpose**: First paragraph or purpose section
4. **Category**: Directory name (scan, fix, gen, etc.)
5. **Usage Examples**: Code blocks with command syntax

### Help Display Logic

**For specific command** (`command-name`):

```markdown
# {command-name} - {description}

**Category**: {category}
**Usage**: /prefix:{command-name} {argument-hint}

## Description
{extracted description from file}

## Usage Examples
{code blocks from command file}

## Key Features
{extracted key points}

## Related Commands
{suggested related commands in same category}
```

**For listing all commands** (`--list`):

```markdown
# All Available Commands

## By Category

### 🔍 Scan Commands
- scan:deep - Deep code analysis with streamlined output
- scan:quick - Quick code quality assessment
- scan:security - Security vulnerability scanning
[... continue for all categories]

### 🔧 Fix Commands
- fix:security - Fix security vulnerabilities
- fix:performance - Performance optimization fixes
[... etc]

## Usage
Run `/prefix:meta:help <command-name>` for detailed help on any command.
```

**For search** (`--search keyword`):

```markdown
# Commands matching "{keyword}"

## Exact Matches
{commands with keyword in name}

## Description Matches
{commands with keyword in description}

## Content Matches
{commands with keyword in file content}

## Suggestions
{similar/related commands}
```

**For categories** (`--categories`):

```markdown
# Command Categories

## 🔍 Scan (Analysis & Discovery)
**Purpose**: Analyze code, find issues, generate reports
**Commands**: {count} commands
**Key Commands**: scan:deep, scan:quick, scan:security

## 🔧 Fix (Automated Fixes)
**Purpose**: Automatically fix detected issues
**Commands**: {count} commands  
**Key Commands**: fix:security, fix:performance, fix:quick-wins

[... continue for all categories]
```

### Implementation Details

**Command Parsing**:

```bash
# Extract command category and name
if [[ "$ARGUMENTS" =~ ^([a-z]+):([a-z-]+)$ ]]; then
    category="${BASH_REMATCH[1]}"
    command="${BASH_REMATCH[2]}"
    command_file="commands/$category/$command.md"
fi
```

**Fuzzy Matching**:

- If exact command not found, suggest similar commands
- Use string similarity for suggestions
- Consider both command names and descriptions

**Content Extraction**:

- Parse YAML frontmatter for metadata
- Extract first paragraph as summary
- Find usage examples in code blocks
- Identify key features from bullet points

### Error Handling

**Command Not Found**:

```markdown
❌ Command "{command-name}" not found.

## Did you mean?
- {closest-match-1}
- {closest-match-2}
- {closest-match-3}

## Available categories: {list-categories}

💡 Run `/prefix:meta:help --list` to see all commands.
```

**No Search Results**:

```markdown
🔍 No commands found matching "{keyword}".

## Suggestions:
- Try a broader search term
- Check spelling
- Use `/prefix:meta:help --categories` to browse by category

## Popular searches:
- security, performance, test, docs, refactor
```

### Output Examples

**Specific Command Help**:

```markdown
# scan:deep - Deep code analysis with streamlined output

**Category**: Scan
**Usage**: /prefix:scan:deep <directory> [--focus=security|performance|architecture|all] [--export-md] [--export-json]

## Description
Comprehensive code analysis using a hybrid approach with simplified, action-oriented output. Performs parallel scanning with specialized scanners and provides expert analysis for critical findings.

## Key Features
- ⚡ Parallel scanning (5-8 seconds)
- 🧠 Expert analysis for critical issues
- 📊 Health scoring and prioritization
- 📁 Multiple export formats

## Usage Examples
```bash
# Basic deep scan
/prefix:scan:deep src/

# Security-focused analysis  
/prefix:scan:deep . --focus=security --export-json

# Pre-release comprehensive check
/prefix:scan:deep . --export-md
```

## Next Steps

After running this command, use:

- `/prefix:scan:report --latest --generate-action-plan` - Create action plan
- `/prefix:fix:quick-wins --latest` - Apply quick fixes
- `/prefix:meta:chain deep-quality` - Run full pipeline

## Related Commands

- scan:quick - Faster alternative for quick checks
- scan:security - Focus on security issues only
- scan:report - Generate reports from scan results

```

**Search Results**:
```markdown
# Commands matching "security"

## Exact Matches
- **sec:audit** - Security audit with vulnerability scanning
- **sec:baseline** - Establish security baseline and compliance
- **fix:security** - Fix security vulnerabilities automatically

## Commands with "security" in description
- **scan:deep** - Deep code analysis (includes security scanning)
- **meta:chain** - Command chaining (includes security-hardening pipeline)

## Usage Examples
```bash
# Security-focused commands
/prefix:sec:audit . --export-json
/prefix:fix:security --latest --severity=critical
/prefix:scan:deep . --focus=security

# Security workflows
/prefix:meta:chain security-hardening
```

## Related Topics

- vulnerability, audit, compliance, hardening, CVE

```

### Special Cases

**Help for Help**:
```markdown
# meta:help - Claude Code Toolkit Help System

**Usage**: /prefix:meta:help [command-name] [--list] [--search <keyword>] [--categories]

## Available Options
- No arguments: Show this help
- `command-name`: Show help for specific command
- `--list`: List all available commands by category
- `--search keyword`: Search commands containing keyword
- `--categories`: Show all command categories with descriptions

## Examples
```bash
/prefix:meta:help scan:deep        # Help for scan:deep command
/prefix:meta:help --search test    # Find test-related commands
/prefix:meta:help --list           # List all commands
/prefix:meta:help --categories     # Show categories overview
```

```

**Empty Arguments**:
```markdown
# Claude Code Toolkit Help

Welcome to the Claude Code Toolkit help system!

## Quick Start
```bash
/prefix:meta:help --list          # See all commands
/prefix:meta:help --categories    # Browse by category  
/prefix:meta:help scan:deep       # Help for specific command
/prefix:meta:help --search test   # Find commands by keyword
```

## Most Popular Commands

- **scan:deep** - Comprehensive code analysis
- **fix:quick-wins** - Apply easy improvements
- **meta:chain** - Run command pipelines
- **flow:smart** - Intelligent problem routing

## Command Categories

- 🔍 **scan** - Analysis and discovery
- 🔧 **fix** - Automated fixes
- 🚀 **flow** - Intelligent workflows
- 🔄 **auto** - Automation and execution
- 🔒 **sec** - Security focused
- 📝 **gen** - Code generation
- 🎯 **meta** - Toolkit management
- 🌐 **typo3** - TYPO3 CMS specific
- 🎨 **css** - CSS/Styling tools
- 📚 **git** - Git operations

💡 **New to the toolkit?** Start with `/prefix:flow:smart "describe your task"`

```

## Integration with Other Commands

The help system works with other toolkit commands:

```bash
# Find command first, then get help
/prefix:meta:find-cmd "security audit" 
/prefix:meta:help sec:audit

# Create new command, then document it
/prefix:meta:create command scan:custom-check
/prefix:meta:help scan:custom-check

# Chain help with execution
/prefix:meta:help scan:deep && /prefix:scan:deep .
```

## Advanced Features

### Intelligent Suggestions

- Partial name matching (e.g., "sec" matches "sec:audit")
- Typo tolerance (e.g., "scam" suggests "scan")
- Context-aware recommendations

### Rich Output

- Category-based organization
- Usage examples with syntax highlighting
- Related command suggestions
- Next step recommendations

### Search Capabilities

- Name matching
- Description matching
- Content matching
- Tag/keyword matching

This help system makes the Claude Code Toolkit discoverable and accessible for users at all levels.
