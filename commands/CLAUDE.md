# CLAUDE.md - Commands Directory

This file provides context for Claude Code when working with commands in this directory.

## Command Structure

Commands are organized hierarchically by category, with each command being a markdown file containing instructions for Claude Code.

## Command Naming Convention

- Commands are organized in subdirectories under `commands/`
- Directory structure determines command namespace: `commands/category/command.md` → `/prefix:category:command`
- Categories follow clear purposes: `scan`, `fix`, `gen`, `flow`, `auto`, `sec`, `git`, `meta`
- Use short, action-oriented names (e.g., `deep` not `analyze-deep`)
- Maximum 2 words per command name
- Use verbs for clarity

## Command Format

Each command is a Markdown file containing:

1. **Frontmatter** (YAML format) with Claude Code-compatible fields:

   ```yaml
   ---
   description: Brief command description
   argument-hint: Expected arguments for auto-completion
   mcp-enhanced: Optional MCP tools that enhance this command
   ---
   ```

2. **Command Content Structure**:
   - Command description and purpose
   - Usage instructions with examples
   - Detailed workflow steps
   - Best practices and guidelines
   - Examples of expected output

## Command Categories

### scan/ - Analysis & Investigation

Analysis and investigation commands for understanding codebases:

- **deep** - Comprehensive analysis with parallel scanning
- **quality** - Code quality metrics and trends
- **perf** - Performance profiling
- **deps** - Dependency analysis
- **docs** - Documentation health
- **tests** - Test coverage analysis
- **quick** - Fast parallel analysis
- **refactor** - Refactoring opportunities
- **report** - Report analysis and generation
- **root-cause** - Root cause analysis
- **explore** - Deep codebase exploration
- **map** - Codebase structure mapping

### fix/ - Direct Corrections

Commands that make direct fixes to code:

- **quick-wins** - High-ROI fixes from reports
- **security** - Security vulnerability fixes
- **performance** - Performance optimizations
- **duplicates** - Code duplication removal
- **documentation** - Documentation fixes
- **shell** - Shell script improvements

### flow/ - Multi-Agent Workflows

Intelligent multi-agent coordination:

- **smart** - Intelligent problem routing
- **review** - Multi-perspective code review
- **incident** - Rapid incident response
- **refactor** - Refactoring workflow
- **debug-mode** - Interactive debugging

### auto/ - Automation & Orchestration

Automated workflow execution:

- **execute** - Execute action plans
- **monitor** - Continuous monitoring
- **report** - Completion reports
- **sprint** - Quality improvement sprints

### gen/ - Generation Commands

Code and content generation:

- **docs** - Generate documentation
- **tests** - Generate test files
- **format** - Format code consistently

### sec/ - Security Operations

Security-focused commands:

- **audit** - Security audit
- **baseline** - Security baseline establishment
- **comply** - Compliance checking

### git/ - Git Operations

Git workflow commands:

- **commit** - Smart commit generation

### meta/ - Project & Toolkit Management

Meta-commands for project and toolkit:

- **health** - Project health assessment
- **chain** - Command chaining
- **changelog** - Changelog updates
- **create** - Create new commands
- **export** - Export management
- **handoff** - AI handoff preparation
- **summary** - Chat summary generation
- **test-guide** - Interactive test guidance
- **update-docs** - Documentation updates
- **version** - Version information
- **find-cmd** - Find commands by capability
- **analyze-toolkit** - Analyze toolkit usage

### typo3/ - TYPO3 Specific Commands

TYPO3 development commands:

- **content-blocks** - Content Blocks creation
- **extension-kickstarter** - Extension scaffolding
- **fluid-components** - Fluid component generation
- **make-content-block** - Individual block creation
- **sitepackage** - Sitepackage setup

## Key Patterns

### Explicit Task Tool Syntax

All multi-agent commands use explicit Task tool invocation:

```markdown
Use Task tool with subagent_type="general-purpose":
"Your detailed prompt here with specific instructions and expected output format."
```

This pattern ensures:

- Clear agent invocation
- Proper context isolation
- Predictable behavior
- Better error handling

### Command Chaining Architecture

Commands can be chained with automatic data flow:

```bash
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}" -> "scan:quality . --compare"
```

Features:

- `{output}` - Previous command's output
- `{outputs}` - All previous outputs array
- `->` - Sequential execution
- `[cmd1, cmd2]` - Parallel execution
- `?>` - Conditional execution
- `!>` - Error fallback

### Hybrid Architecture

The hybrid architecture combines parallel processing with specialized expertise:

**Phase 1: Parallel Scanning**

- Uses Task Tool for rapid parallel execution
- Multiple scanner agents work simultaneously
- Optimized for speed and broad coverage
- Produces structured JSON output

**Phase 2: Expert Analysis**

- Results from Phase 1 are intelligently delegated
- Specialized Sub-Agents provide deep analysis
- Each agent has domain-specific expertise
- Agents work in isolated contexts

**Phase 3: Synthesis**

- Results from all agents are combined
- Final report integrates all perspectives
- Provides actionable recommendations

### Smart Problem Routing

The `/flow:smart` command analyzes problems and routes to appropriate specialists:

1. Problem analysis and categorization
2. Multi-agent task distribution
3. Parallel execution where possible
4. Consolidated results with action plan

## Command Design Principles

- **Maximum 200-300 lines**: Keep commands focused and maintainable
- **Clear phase structure**: Organize complex workflows into phases
- **Explicit Task syntax**: Use clear agent invocation patterns
- **Focused functionality**: Each command does one thing well
- **Reusable patterns**: Build on established patterns

## Adding New Commands

1. Create appropriate category directory under `commands/` if needed
2. Create `.md` file with descriptive command name
3. Add frontmatter with at minimum a `description` field
4. Write command as detailed Markdown prompt with clear instructions
5. Include usage examples and expected behaviors
6. Run `./scripts/update-readme.sh` to update README documentation

## MCP Enhancement

Commands can leverage MCP (Model Context Protocol) tools when available:

```yaml
---
mcp-enhanced: mcp__semgrep__security_check, mcp__github__create_pr
---
```

Implementation should:

1. Check for MCP tool availability
2. Use enhanced approach if available
3. Fall back to traditional methods if not
4. Report which method was used

## Testing Commands

After adding a command:

1. Install locally: `~/.claude/commands/test/`
2. Verify command appears with correct namespace
3. Test command execution in a sample project
4. Document in user guide if significant

## Important Notes

- The `$ARGUMENTS` placeholder receives user input after command invocation
- Commands should be self-contained with all necessary context
- Avoid creating example or demo commands
- Focus on practical, reusable tools
- Commands work best when they follow established patterns
