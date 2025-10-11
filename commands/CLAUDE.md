# CLAUDE.md - Commands Directory

This file provides context for Claude Code when working with commands in this directory.

## Command Structure

The Claude Code Toolkit implements a **5-Command Architecture** with additional specialized commands organized hierarchically by category. Each command is a markdown file containing instructions for Claude Code.

## Actual Command Structure

Based on the codebase, the following commands exist:

### Core Commands (5-Command Architecture)

The toolkit's primary workflow is built around 5 core commands:

- **understand** - Code analysis and comprehension with intelligent problem routing
- **improve** - Code improvement with intelligent routing and learning persistence
- **create** - Content and code generation with template-driven creation
- **secure** - Security analysis and vulnerability assessment
- **ship** - Production readiness assessment and deployment preparation

### Specialized Command Categories

#### meta/ - Project & Toolkit Management

Project and toolkit management commands:

- **changelog** - Changelog generation and updates
- **handoff** - AI handoff preparation and knowledge transfer

#### git/ - Git Operations

Version control and workflow management:

- **operations** - Git operations and workflow management

#### typo3/ - TYPO3 Development Commands

TYPO3-specific development tools:

- **content-blocks** - Content Blocks creation and management
- **extension-kickstarter** - Extension scaffolding and setup
- **fluid-components** - Fluid component generation
- **make-content-block** - Individual content block creation
- **sitepackage** - Sitepackage setup and configuration

## Command Naming Convention

- Core commands are in the root `commands/` directory: `commands/command.md` → `/prefix:command`
- Specialized commands are in subdirectories: `commands/category/command.md` → `/prefix:category:command`
- Use short, action-oriented names (e.g., `understand` not `analyze-codebase`)
- Maximum 2 words per command name
- Use verbs for clarity

## Command Format

Each command is a Markdown file containing:

1. **Frontmatter** (YAML format) with Claude Code-compatible fields:

  ```yaml
  ---
  description: Brief command description
  argument-hint: Expected arguments for auto-completion
  allowed-tools: List of allowed tools for this command
  mcp-enhanced: Optional MCP tools that enhance this command
  ---
  ```

2. **Command Content Structure**:

- Command description and purpose
- Usage instructions with examples
- Detailed workflow steps
- Best practices and guidelines
- Examples of expected output

## 5-Command Architecture

The core workflow provides transparency and developer control:

```bash
/prefix:understand . --comprehensive  # Analysis phase
/prefix:improve . --apply-insights   # Improvement phase
/prefix:create docs --update-all    # Creation phase
/prefix:secure . --audit        # Security phase
/prefix:ship . --readiness-check    # Deployment phase
```

Specialized commands support the core workflow:

```bash
/prefix:git:operations commit --smart  # Version control
/prefix:meta:changelog --fast     # Project management
/prefix:typo3:sitepackage mysite    # Domain-specific tools
```

### Benefits

- **Full Transparency**: See exactly what each command does
- **Developer Control**: Make decisions at each step
- **Clear Understanding**: No black-box automation
- **Easy Debugging**: Isolate issues to specific commands
- **Flexible Workflows**: Adapt based on results

### Usage Patterns

**Quick Development Cycle**:

```bash
/prefix:understand . --quick
/prefix:improve . --apply-insights
/prefix:ship . --readiness-check
/prefix:git:operations commit --smart
```

**Comprehensive Analysis**:

```bash
/prefix:understand . --comprehensive --export-json
/prefix:secure . --audit
/prefix:improve . --from-analysis
/prefix:ship . --readiness-check
```

## Key Patterns

### Explicit Task Tool Syntax

Commands use explicit Task tool invocation for multi-agent coordination:

```markdown
Use Task tool with subagent_type="security-specialist":
"Perform comprehensive security audit focusing on OWASP Top 10 vulnerabilities"
```

This pattern ensures:

- Clear agent invocation
- Proper context isolation
- Predictable behavior
- Better error handling

### Analysis Integration

Commands support analysis-driven workflows:

- `--from-analysis` → Use insights from previous analysis
- `--apply-insights` → Apply discovered improvements
- `--comprehensive` → Deep analysis with full context

### Export Capabilities

Commands support structured output:

- `--export-json` → Generate timestamped JSON reports
- `--export-md` → Generate timestamped Markdown reports
- `--latest` → Use most recent analysis results

## Command Design Principles

- **Focused functionality**: Each command does one thing well
- **Maximum 200-300 lines**: Keep commands focused and maintainable
- **Clear phase structure**: Organize complex workflows into phases
- **Explicit Task syntax**: Use clear agent invocation patterns
- **Reusable patterns**: Build on established patterns
- **Self-contained**: Include all necessary context

## Adding New Commands

1. **Determine category**: Core command or specialized category
2. **Create file**: `.md` file in appropriate directory
3. **Add frontmatter**: Include description and allowed-tools
4. **Write content**: Detailed instructions with examples
5. **Update documentation**: Run `./scripts/update-readme.sh`
6. **Test locally**: Verify command works as expected

### File Structure

```
commands/
├── understand.md      # Core: /prefix:understand
├── improve.md       # Core: /prefix:improve
├── create.md       # Core: /prefix:create
├── secure.md       # Core: /prefix:secure
├── ship.md        # Core: /prefix:ship
├── git.md         # Core: /prefix:git
├── meta/
│  ├── changelog.md    # Meta: /prefix:meta:changelog
│  └── handoff.md     # Meta: /prefix:meta:handoff
└── typo3/
  ├── content-blocks.md # TYPO3: /prefix:typo3:content-blocks
  ├── extension-kickstarter.md
  ├── fluid-components.md
  ├── make-content-block.md
  └── sitepackage.md
```

## MCP Enhancement

Commands can leverage MCP (Model Context Protocol) tools when available:

```yaml
---
allowed-tools: Task, mcp____search_notes, mcp__semgrep__security_check
---
```

Implementation should:

1. Check for MCP tool availability
2. Use enhanced approach if available
3. Fall back to traditional methods if not
4. Report which method was used

## Testing Commands

After adding a command:

1. Install locally: Copy to `~/.claude/commands/test/`
2. Verify command appears with correct namespace
3. Test command execution in a sample project
4. Validate frontmatter and argument hints
5. Document in user guide if significant

## Command Documentation

Each core command has detailed documentation in the `docs/commands/` directory:

- **[docs/commands/understand.md](../docs/commands/understand.md)** - Code analysis and comprehension
- **[docs/commands/improve.md](../docs/commands/improve.md)** - Code improvement with intelligent routing
- **[docs/commands/create.md](../docs/commands/create.md)** - Content and code generation
- **[docs/commands/secure.md](../docs/commands/secure.md)** - Security analysis and vulnerability detection
- **[docs/commands/ship.md](../docs/commands/ship.md)** - Deployment readiness and quality gates

### Specialized Command Documentation

Additional command categories have their own documentation directories:

#### Git Commands

- **[docs/commands/git/README.md](../docs/commands/git/README.md)** - Version control and workflow management
- **[docs/commands/git/operations.md](../docs/commands/git/operations.md)** - Smart Git operations with AI-powered commits

#### Meta Commands

- **[docs/commands/meta/README.md](../docs/commands/meta/README.md)** - Project and toolkit management commands
- **[docs/commands/meta/changelog.md](../docs/commands/meta/changelog.md)** - AI-powered CHANGELOG.md management
- **[docs/commands/meta/handoff.md](../docs/commands/meta/handoff.md)** - AI assistant handoff preparation

#### TYPO3 Commands

- **[docs/commands/typo3/README.md](../docs/commands/typo3/README.md)** - TYPO3-specific development tools
- **[docs/commands/typo3/content-blocks.md](../docs/commands/typo3/content-blocks.md)** - Content Blocks generation
- **[docs/commands/typo3/extension-kickstarter.md](../docs/commands/typo3/extension-kickstarter.md)** - Extension scaffolding
- **[docs/commands/typo3/fluid-components.md](../docs/commands/typo3/fluid-components.md)** - Fluid component generation
- **[docs/commands/typo3/make-content-block.md](../docs/commands/typo3/make-content-block.md)** - Content block creation wrapper
- **[docs/commands/typo3/sitepackage.md](../docs/commands/typo3/sitepackage.md)** - Sitepackage creation

The documentation includes:

- Complete syntax and arguments
- All available options with descriptions
- Practical examples and workflows
- Integration patterns with other commands

### Documentation Structure

Each command documentation follows a consistent structure:

1. **Purpose** - Brief description of what the command does
2. **Syntax** - Complete command syntax with brackets notation
3. **Arguments** - Table of positional arguments with defaults
4. **Options** - Table of all flags and options
5. **Examples** - Practical usage examples
6. **Workflows** - Integration with other commands
7. **See Also** - Cross-references to related commands

This ensures users can quickly understand and use any command effectively.

## Important Notes

- The `$ARGUMENTS` placeholder receives user input after command invocation
- Commands should be self-contained with all necessary context
- Avoid creating example or demo commands
- Focus on practical, reusable tools
- Commands work best when they follow established patterns
- Always include proper frontmatter with description
- Use allowed-tools to specify required Claude Code tools
- **Command documentation is automatically linked in README**: Core commands in the main README table are automatically linked to their documentation
