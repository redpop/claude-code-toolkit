# CLAUDE.md - Commands Directory

This file provides context for Claude Code when working with commands in this directory.

## Command Structure

The Claude Code Toolkit implements a **6-Command Architecture** with additional specialized commands organized hierarchically by category. Each command is a markdown file containing instructions for Claude Code.

## Actual Command Structure

Based on the codebase, the following commands exist:

### Core Commands (6-Command Architecture)

The toolkit's primary workflow is built around 6 core commands:

- **understand** - Code analysis and comprehension with intelligent problem routing
- **improve** - Code improvement with intelligent routing and learning persistence
- **create** - Content and code generation with template-driven creation
- **secure** - Security analysis and vulnerability assessment
- **ship** - Production readiness assessment and deployment preparation
- **git** - Git operations and workflow management

### Specialized Command Categories

#### meta/ - Project & Toolkit Management

Project and toolkit management commands:

- **changelog** - Changelog generation and updates
- **handoff** - AI handoff preparation and knowledge transfer

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

## 6-Command Architecture

The core workflow provides transparency and developer control:

```bash
/prefix:understand . --comprehensive    # Analysis phase
/prefix:improve . --apply-insights     # Improvement phase
/prefix:create docs --update-all       # Creation phase
/prefix:secure . --audit               # Security phase
/prefix:ship . --readiness-check       # Deployment phase
/prefix:git commit --smart             # Version control
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
```

**Comprehensive Analysis**:

```bash
/prefix:understand . --comprehensive --export-json
/prefix:secure . --audit
/prefix:improve . --from-analysis
```

**PRP (Project Requirements Proposal) Workflow**:

```bash
/prefix:understand . --prp --requirements="OAuth2 authentication"
/prefix:create . --prp --from-analysis
/prefix:ship . --prp --quality-gates
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

### PRP Integration

Commands support Project Requirements Proposal methodology:

- `--prp` → Activate PRP methodology
- `--prp=research` → Focus on external research
- `--prp=patterns` → Focus on internal patterns
- `--from-analysis` → Use existing analysis results

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
├── understand.md           # Core: /prefix:understand
├── improve.md             # Core: /prefix:improve
├── create.md              # Core: /prefix:create
├── secure.md              # Core: /prefix:secure
├── ship.md                # Core: /prefix:ship
├── git.md                 # Core: /prefix:git
├── meta/
│   ├── changelog.md       # Meta: /prefix:meta:changelog
│   └── handoff.md         # Meta: /prefix:meta:handoff
└── typo3/
    ├── content-blocks.md  # TYPO3: /prefix:typo3:content-blocks
    ├── extension-kickstarter.md
    ├── fluid-components.md
    ├── make-content-block.md
    └── sitepackage.md
```

## MCP Enhancement

Commands can leverage MCP (Model Context Protocol) tools when available:

```yaml
---
allowed-tools: Task, mcp__basic-memory__search_notes, mcp__semgrep__security_check
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

## Important Notes

- The `$ARGUMENTS` placeholder receives user input after command invocation
- Commands should be self-contained with all necessary context
- Avoid creating example or demo commands
- Focus on practical, reusable tools
- Commands work best when they follow established patterns
- Always include proper frontmatter with description
- Use allowed-tools to specify required Claude Code tools
