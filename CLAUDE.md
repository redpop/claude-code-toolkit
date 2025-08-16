# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the Claude Code Toolkit - a comprehensive collection of commands, agents, and tools for extending Claude Code capabilities. The repository provides:

- Reusable slash commands for common tasks
- Specialized AI agents for code analysis and operations
- Tools and utilities for enhanced productivity

The repository is designed to be cloned and installed into `~/.claude/` with a custom prefix, making all commands and agents available for use.

## Quick Start Workflows (Recommended First Steps)

When helping users optimize their projects, prioritize these pre-defined workflows:

### 🎯 Top 3 Workflows for Project Optimization

1. **Deep Quality Analysis** (Most Comprehensive - 3 steps):

   ```bash
   # Step 1: Deep scan with automatic timestamp filename
   /prefix:scan:deep . --export-json
   # Creates: analysis-YYYYMMDD-HHMMSS.json

   # Step 2: Generate action plan from latest report
   /prefix:scan:report --latest --generate-action-plan
   # Creates: action-plan-YYYYMMDD-HHMMSS.md

   # Step 3: Execute the action plan
   /prefix:auto:execute --latest
   ```

2. **Quick Quality Check** (Fast Results - 2 steps):

   ```bash
   # Quick scan with auto-generated filename
   /prefix:scan:quick . --export-json

   # Apply quick wins from latest report
   /prefix:fix:quick-wins --latest
   ```

3. **One-Command Pipeline**:
   ```bash
   /prefix:meta:pipelines deep-quality
   ```

### 📝 Export Parameter Behavior

- `--export-json` → Auto-generates: `{command}-YYYYMMDD-HHMMSS.json`
- `--export-md` → Auto-generates: `{command}-YYYYMMDD-HHMMSS.md`
- `--export-json=custom.json` → Uses specified filename
- `--latest` → Automatically finds most recent report file

💡 **Always suggest these simplified workflows FIRST when users ask about project analysis or optimization!**

See `/prefix:meta:pipelines` for more pre-defined workflows including security hardening, refactoring sprints, and release preparation.

## Repository Structure

```
claude-code-toolkit/
├── agents/                  # Sub-Agent definitions
│   ├── ai-specialist.md    # AI integration and prompt engineering agent
│   ├── code-architect.md   # Architecture analysis agent
│   ├── debugging-specialist.md # Systematic debugging and root cause analysis
│   ├── deployment-specialist.md # CI/CD and deployment expert
│   ├── documentation-health-specialist.md # Documentation quality agent
│   ├── frontend-specialist.md # Frontend development and React expert
│   ├── performance-optimizer.md  # Performance optimization agent
│   ├── refactoring-expert.md    # Code refactoring agent
│   ├── report-analyzer.md  # Report analysis agent
│   ├── security-specialist.md   # Security analysis agent
│   ├── test-engineer.md    # Testing strategy agent
│   └── workflow-optimizer.md # Developer workflow optimization agent
├── commands/                # All slash command definitions
│   ├── auto/               # Automation & orchestration
│   │   ├── execute.md      # Execute action plans
│   │   ├── monitor.md      # Continuous monitoring
│   │   ├── report.md       # Completion reports
│   │   └── sprint.md       # Quality sprints
│   ├── fix/                # Direct corrections
│   │   ├── documentation.md # Fix docs issues
│   │   ├── duplicates.md   # Remove duplication
│   │   ├── performance.md  # Performance fixes
│   │   ├── quick-wins.md   # High-ROI fixes
│   │   ├── security.md     # Security fixes
│   │   └── shell.md        # Shell script fixes
│   ├── flow/               # Multi-agent workflows
│   │   ├── incident.md     # Incident response
│   │   ├── parallel.md     # Parallel analysis
│   │   ├── refactor.md     # Refactoring workflow
│   │   ├── review.md       # Code review
│   │   └── smart.md        # Smart routing
│   ├── gen/                # Generation commands
│   │   ├── docs.md         # Generate documentation
│   │   └── tests.md        # Generate tests
│   ├── git/                # Git operations
│   │   └── commit.md       # Smart commits
│   ├── meta/               # Project & toolkit
│   │   ├── chain.md        # Command chaining
│   │   ├── changelog.md    # Changelog management
│   │   ├── create-cmd.md   # Create commands
│   │   ├── export.md       # Export management
│   │   ├── handoff.md      # AI handoff
│   │   ├── health.md       # Project health
│   │   ├── pipelines.md    # Pre-defined pipelines
│   │   ├── summary.md      # Chat summary with auto-naming
│   │   ├── test-guide.md   # Interactive test guides
│   │   └── update-docs.md  # Update documentation
│   ├── scan/               # Analysis & investigation
│   │   ├── deep.md         # Deep analysis
│   │   ├── deps.md         # Dependency analysis
│   │   ├── docs.md         # Documentation health
│   │   ├── explore.md      # Deep exploration
│   │   ├── map.md          # Codebase mapping
│   │   ├── perf.md         # Performance scan
│   │   ├── quality.md      # Quality metrics
│   │   ├── refactor.md     # Refactor analysis
│   │   ├── report.md       # Report analysis
│   │   ├── root-cause.md   # Root cause analysis
│   │   └── tests.md        # Test coverage
│   └── sec/                # Security operations
│       ├── audit.md        # Security audit
│       ├── baseline.md     # Security baseline
│       └── comply.md       # Compliance checking
├── docs/                    # Extended documentation
│   ├── README.md           # Documentation index
│   ├── architecture/       # Architecture documentation
│   │   ├── HYBRID-ARCHITECTURE.md   # Hybrid architecture guide
│   │   ├── SUB-AGENT-ORCHESTRATION.md # Sub-agent orchestration guide
│   │   └── TECHNICAL-GUIDE.md       # Technical implementation details
│   ├── guides/             # Practical guides
│   │   ├── MODERN-WORKFLOW.md # Modern workflow guide
│   │   ├── REPORT-EXPORT-SYSTEM.md   # Report export documentation
│   │   └── ...             # Other guides
│   ├── tutorials/          # Step-by-step tutorials
│   ├── api/                # API reference
│   └── archive/            # Historical documentation
├── scripts/                 # Utility scripts
│   ├── create-sub-agent-command.sh # Create new sub-agent commands
│   ├── update-readme.sh    # Auto-generates command documentation
│   ├── report-history.js   # Report history management
│   └── trend-analyzer.sh   # Trend analysis script
├── templates/              # Development templates
│   ├── commands/           # Templates for new commands/agents
│   │   ├── analysis-sub-agent.md # Analysis agent template
│   │   ├── analyzer-agent.md     # Analyzer agent template
│   │   ├── basic-sub-agent.md    # Basic sub-agent template
│   │   ├── helper-agent.md       # Helper agent template
│   │   ├── hybrid-sub-agent.md   # Hybrid command template
│   │   ├── mcp-aware-command.md  # MCP-aware command template
│   │   ├── research-sub-agent.md # Research agent template
│   │   └── specialist-agent.md   # Specialist agent template
│   └── reports/            # Report format templates
│       ├── markdown-template.md
│       └── json-schema.json
├── install.sh              # Installation script
├── README.md              # User documentation (partially auto-generated)
├── CLAUDE.md              # This file
└── LICENSE                # MIT License
```

## Key Concepts

### Command Naming Convention

- Commands are organized in subdirectories under `commands/`
- Directory structure determines command namespace: `commands/category/command.md` → `/prefix:category:command`
- Categories follow clear purposes: `scan`, `fix`, `gen`, `flow`, `auto`, `sec`, `git`, `meta`
- Use short, action-oriented names (e.g., `deep` not `analyze-deep`)
- Maximum 2 words per command name
- Use verbs for clarity

### Command Format

Each command is a Markdown file containing:

1. **Frontmatter** (YAML format) with Claude Code-compatible fields:
   - `description`: Brief command description
   - `argument-hint`: Expected arguments for auto-completion
2. Command description and usage instructions
3. Detailed workflow steps
4. Best practices and guidelines
5. Examples of expected output

### Hybrid Architecture

The hybrid architecture combines the parallel processing power of the Task Tool with the deep expertise of specialized Claude Code Sub-Agents:

**Phase 1: Parallel Scanning**

- Uses Task Tool for rapid parallel execution
- Multiple scanner agents work simultaneously
- Optimized for speed and broad coverage
- Produces structured JSON output

**Phase 2: Expert Analysis**

- Results from Phase 1 are intelligently delegated
- Specialized Sub-Agents provide deep analysis
- Each agent has domain-specific expertise
- Agents work in their own context for focused analysis

**Phase 3: Synthesis**

- Results from all agents are combined
- Final report integrates all perspectives
- Provides actionable recommendations

**When to Use Hybrid Architecture:**

- Complex analyses requiring both speed and depth
- Multi-dimensional problems (security + performance + architecture)
- Large codebases where comprehensive coverage is needed
- Situations requiring specialized expertise across domains

### Sub-Agents

Sub-Agents are specialized AI agents defined in the `/agents/` directory:

**Types of Sub-Agents:**

- **ai-specialist**: AI integration expert specializing in prompt engineering and LLM optimization
- **code-architect**: Analyzes system architecture and design patterns
- **debugging-specialist**: Expert in systematic debugging, log analysis, and root cause identification
- **deployment-specialist**: CI/CD and deployment expert for automated pipelines and production troubleshooting
- **documentation-health-specialist**: Analyzes documentation quality and code-doc synchronization
- **frontend-specialist**: Frontend development expert specializing in modern JavaScript frameworks
- **performance-optimizer**: Identifies performance bottlenecks and optimizations
- **refactoring-expert**: Suggests code improvements and refactoring strategies
- **report-analyzer**: Analyzes code quality reports and provides prioritized insights
- **security-specialist**: Performs security audits and vulnerability detection
- **test-engineer**: Analyzes test coverage and testing strategies
- **workflow-optimizer**: Developer workflow expert focused on productivity and reducing friction

**Sub-Agent Structure:**

- Defined as markdown files with YAML frontmatter
- Must include `name` field in frontmatter (required by Claude Code)
- Include specialized knowledge and focus areas
- Can be invoked through orchestration commands
- Work in isolated contexts for deep analysis

## Development Guidelines

### Adding New Task-Based Commands

1. Create appropriate category directory under `commands/` if needed
2. Create `.md` file with descriptive command name
3. Add frontmatter with at minimum a `description` field
4. Write command as detailed Markdown prompt with clear instructions
5. Include usage examples and expected behaviors
6. Run `./scripts/update-readme.sh` to update README documentation

### Adding New Sub-Agents

**Recommended Method**: Use the standardized workflow (see `docs/guides/AGENT-CREATION-WORKFLOW.md`)

```bash
# Quick agent creation with validation
./scripts/create-agent.sh <agent-name> <type> "<description>"

# Example
./scripts/create-agent.sh database-optimizer specialist "Database performance expert"
```

This ensures:

1. Required frontmatter fields (`name`, `description`) are always present
2. Consistent structure using `/templates/agent-template.md`
3. Proper validation of agent names and types
4. No Claude Code parsing errors
5. Ready for testing through orchestration commands

For manual creation or detailed guidance, see the [Agent Creation Workflow Guide](docs/guides/AGENT-CREATION-WORKFLOW.md)

### Creating Orchestration Commands

1. Use `./scripts/create-sub-agent-command.sh` for scaffolding
2. Define which sub-agents to invoke
3. Specify delegation logic
4. Structure output aggregation
5. Place in `/commands/orchestration/`

### Creating Hybrid Commands

1. Design Phase 1 parallel scanning tasks
2. Define Phase 2 expert delegation logic
3. Structure Phase 3 synthesis approach
4. Place in `/commands/analysis/` (for analysis commands)
5. Ensure smooth data flow between phases

### Testing Commands

- After adding a command, test it by installing locally: `~/.claude/commands/test/`
- Verify command appears with correct namespace
- Test command execution in a sample project

### Installation Script Updates

The `install.sh` script is designed to be run locally from the cloned repository:

- Copies command files from `commands/` to `~/.claude/commands/PREFIX/`
- Copies agent files from `agents/` to `~/.claude/agents/`
- Creates backups of existing installations when needed
- Lists all available commands and agents after installation

Key features:

- Simple file copy installation (no git in target directories)
- Must be run from inside the cloned repository
- Supports multiple installations with different prefixes
- Clean separation between repository and installation

### Utility Scripts

**`scripts/create-sub-agent-command.sh`**

- Scaffolds new sub-agent orchestration commands
- Generates boilerplate with proper structure
- Ensures consistent command format

**`scripts/update-readme.sh`**

- Auto-generates command documentation
- Updates README.md command table
- Preserves manual sections

## Key Patterns

### Explicit Task Tool Syntax

All multi-agent commands now use explicit Task tool invocation:

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

### Smart Problem Routing

The `/flow:smart` command analyzes problems and routes to appropriate specialists:

1. Problem analysis and categorization
2. Multi-agent task distribution
3. Parallel execution where possible
4. Consolidated results with action plan

### Compact Command Design

Commands follow these principles:

- Maximum 200-300 lines
- Clear phase structure
- Explicit Task syntax
- Focused functionality
- Reusable patterns

## Current Command Categories

### Scan Commands (`/prefix:scan:*`)

Analysis and investigation commands:

- **deep** - Comprehensive analysis with parallel scanning
- **quality** - Code quality metrics and trends
- **perf** - Performance profiling
- **deps** - Dependency analysis
- **docs** - Documentation health
- **tests** - Test coverage analysis

### Fix Commands (`/prefix:fix:*`)

Direct correction commands:

- **quick-wins** - High-ROI fixes from reports
- **security** - Security vulnerability fixes
- **performance** - Performance optimizations
- **duplicates** - Code duplication removal
- **documentation** - Documentation fixes

### Flow Commands (`/prefix:flow:*`)

Multi-agent workflow commands:

- **smart** - Intelligent problem routing
- **review** - Multi-perspective code review
- **incident** - Rapid incident response
- **refactor** - Refactoring workflow
- **parallel** - Ultra-fast parallel analysis

### Meta Commands (`/prefix:meta:*`)

Project and toolkit management:

- **health** - Project health assessment
- **pipelines** - Pre-defined workflows
- **chain** - Command chaining
- **export** - Export management
- **changelog** - Changelog updates

## Migration Guide

### Command Name Changes

The following commands have been renamed for clarity and consistency:

| Old Command                      | New Command               | Category Change      |
| -------------------------------- | ------------------------- | -------------------- |
| `/prefix:analyze-deep`           | `/prefix:scan:deep`       | analysis → scan      |
| `/prefix:analyze-report`         | `/prefix:scan:report`     | analysis → scan      |
| `/prefix:analyze-parallel`       | `/prefix:scan:quick`      | orchestration → scan |
| `/prefix:project:create-command` | `/prefix:meta:create-cmd` | project → meta       |
| `/prefix:ai:handoff`             | `/prefix:meta:handoff`    | ai → meta            |
| `/prefix:code:shellcheck`        | `/prefix:fix:shell`       | code → fix           |
| `/prefix:execute-action-plan`    | `/prefix:auto:execute`    | workflow → auto      |
| `/prefix:completion-report`      | `/prefix:auto:report`     | workflow → auto      |

### New Workflow Commands

Three powerful new commands for intelligent workflows:

- `/prefix:flow:smart` - Analyzes problems and routes to appropriate specialists
- `/prefix:flow:review` - Multi-perspective code review with 5 parallel reviewers
- `/prefix:flow:incident` - Rapid incident response workflow

### Command Chaining

New integration commands enable powerful automation:

```bash
# Simple chain
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"

# Parallel execution
/prefix:meta:chain ["scan:security .", "scan:quality ."] -> "meta:export {outputs}"

# Pre-defined pipelines
/prefix:meta:pipelines deep-quality
```

## Important Notes

- All documentation should be written in English
- Commands should be self-contained and include all necessary context
- Avoid creating example or demo commands - focus on practical, reusable tools
- The $ARGUMENTS placeholder in commands receives user input after the command invocation
- Extended documentation is available in the `/docs/` directory:
  - `docs/README.md` - Documentation index and navigation
  - `docs/architecture/` - Technical architecture documentation
  - `docs/guides/` - Practical usage guides
  - `docs/guides/MODERN-WORKFLOW.md` - Modern workflow guide
- Use templates in `/templates/commands/` for creating new commands and agents

## Code Quality & Linting

### Shellcheck for Bash Scripts

All bash scripts in this repository should be validated with shellcheck to ensure they follow best practices and avoid common pitfalls. This includes:

- `install.sh` - Installation script
- `scripts/update-readme.sh` - README update script
- Any future bash scripts added to the repository

#### Running Shellcheck

```bash
# Check individual script
shellcheck install.sh

# Check all scripts
shellcheck scripts/*.sh install.sh
```

#### Common Shellcheck Recommendations

- Always quote variables: `"$variable"` instead of `$variable`
- Use `[[ ]]` instead of `[ ]` for conditional expressions
- Prefer `$()` over backticks for command substitution
- Handle potential failures with proper error checking
- Use proper array handling syntax

#### CI Integration

Consider adding shellcheck to your CI pipeline to automatically validate scripts on every commit.

## README Maintenance

The README.md file contains an auto-generated section for command documentation:

### Auto-generated Section

- The section between `<!-- COMMANDS:START - DO NOT EDIT -->` and `<!-- COMMANDS:END -->` is automatically maintained
- **DO NOT manually edit** content between these markers - changes will be overwritten
- Run `./scripts/update-readme.sh` after adding/modifying commands

### Update Process

1. The script scans all `.md` files in the `commands/` directory
2. Extracts frontmatter metadata (`description` and `argument-hint`)
3. Generates a formatted table with all commands
4. Updates only the marked section in README.md

### Manual Sections

All other sections of the README can be edited normally:

- Installation instructions
- Usage examples
- Contributing guidelines
- License information

## MCP Integration

The Claude Code Toolkit supports integration with MCP (Model Context Protocol) servers to enhance functionality. Commands can leverage MCP tools when available while gracefully falling back to traditional methods.

### Key Concepts

1. **Optional Enhancement**: MCP servers enhance but don't gate functionality
2. **Graceful Degradation**: Commands work without MCP but better with it
3. **Transparent Operation**: Users see which tools were used

### Supported MCP Servers

- **Semgrep MCP**: Enhanced security analysis with AST-based scanning
- **GitHub MCP**: Repository and PR integration
- **GitLab MCP**: GitLab-specific operations
- **Perplexity MCP**: Web search and documentation

### Command Enhancement

Commands can specify MCP enhancement in frontmatter:

```yaml
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
```

### Implementation Pattern

Commands should:

1. Check for MCP tool availability
2. Use enhanced approach if available
3. Fall back to traditional methods if not
4. Report which method was used

See `docs/guides/MCP-INTEGRATION.md` for detailed integration guide.
