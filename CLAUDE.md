# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is the Claude Code Toolkit - a comprehensive collection of commands, agents, and tools for extending Claude Code capabilities. The repository provides:
- Reusable slash commands for common tasks
- Specialized AI agents for code analysis and operations
- Tools and utilities for enhanced productivity

The repository is designed to be cloned and installed into `~/.claude/` with a custom prefix, making all commands and agents available for use.

## Repository Structure

```
claude-code-toolkit/
├── agents/                  # Sub-Agent definitions
│   ├── code-architect.md   # Architecture analysis agent
│   ├── performance-optimizer.md  # Performance optimization agent
│   ├── refactoring-expert.md    # Code refactoring agent
│   ├── security-specialist.md   # Security analysis agent
│   └── test-engineer.md    # Testing strategy agent
├── commands/                # All slash command definitions
│   ├── git/                # Git-related commands
│   ├── hybrid/             # Hybrid architecture commands
│   │   └── analyze-deep.md # Deep analysis using hybrid approach
│   ├── orchestration/      # Sub-Agent orchestration commands
│   │   ├── analyze-parallel.md   # Parallel multi-agent analysis
│   │   ├── performance-scan.md   # Performance analysis
│   │   ├── refactor-impact.md    # Refactoring impact analysis
│   │   ├── security-audit.md     # Security audit
│   │   └── test-coverage.md      # Test coverage analysis
│   ├── research/           # Research and exploration commands
│   │   ├── codebase-map.md      # Generate codebase overview
│   │   ├── deep-dive.md         # Deep investigation
│   │   └── dependency-trace.md  # Trace dependencies
│   └── templates/          # Templates for new commands/agents
│       ├── basic-sub-agent.md    # Basic sub-agent template
│       ├── analysis-sub-agent.md # Analysis agent template
│       └── research-sub-agent.md # Research agent template
├── docs/                    # Extended documentation
│   ├── HYBRID-ARCHITECTURE.md   # Hybrid architecture guide
│   ├── SUB-AGENT-ORCHESTRATION.md # Sub-agent orchestration guide
│   └── TECHNICAL-GUIDE.md       # Technical implementation details
├── scripts/                 # Utility scripts
│   ├── create-sub-agent-command.sh # Create new sub-agent commands
│   └── update-readme.sh    # Auto-generates command documentation
├── install.sh              # Installation script
├── README.md              # User documentation (partially auto-generated)
├── CLAUDE.md              # This file
└── LICENSE                # MIT License
```

## Key Concepts

### Command Naming Convention

- Commands are organized in subdirectories under `commands/`
- Directory structure determines command namespace: `commands/category/command.md` → `/prefix:category:command`
- Use lowercase with hyphens for multi-word names

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

- **code-architect**: Analyzes system architecture and design patterns
- **performance-optimizer**: Identifies performance bottlenecks and optimizations
- **refactoring-expert**: Suggests code improvements and refactoring strategies
- **security-specialist**: Performs security audits and vulnerability detection
- **test-engineer**: Analyzes test coverage and testing strategies

**Sub-Agent Structure:**

- Defined as markdown files with specific personas
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

1. Define the agent's expertise and purpose
2. Create `.md` file in `/agents/` directory
3. Structure the agent with:
   - Clear persona definition
   - Specific expertise areas
   - Analysis methodology
   - Output format specifications
4. Test the agent through orchestration commands

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
4. Place in `/commands/hybrid/`
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

## Current Commands

### Git Commands (`/prefix:git:*`)

**`/prefix:git:commit`** - Advanced git commit command that:

- Runs pre-commit checks (lint, build, docs) unless `--no-verify` is specified
- Analyzes changes and suggests splitting into multiple commits when appropriate
- Uses conventional commit format with emojis
- Handles both staged and unstaged files intelligently

### Project Commands (`/prefix:project:*`)

**`/prefix:project:changelog`** - Changelog management command that:

- Adds entries to CHANGELOG.md following Keep a Changelog format
- Supports semantic versioning validation
- Can automatically update version in package files
- Includes emoji prefixes for change types
- Optionally commits changes with conventional commit message

### AI Commands (`/prefix:ai:*`)

**`/prefix:ai:handoff`** - AI context handoff command that:

- Analyzes current problem state and generates comprehensive documentation
- Creates markdown file suitable for sharing with other AI assistants
- Includes code snippets, directory structure, and recent changes
- Captures context of ongoing tasks and next steps
- Useful for switching between AI assistants or documenting work state

### Research Commands (`/prefix:research:*`)

**`/prefix:research:codebase-map`** - Generate comprehensive codebase overview  
**`/prefix:research:deep-dive`** - Deep investigation into specific topics  
**`/prefix:research:dependency-trace`** - Trace and analyze dependencies

### Orchestration Commands (`/prefix:orchestration:*`)

**`/prefix:orchestration:analyze-parallel`** - Multi-agent parallel analysis  
**`/prefix:orchestration:security-audit`** - Comprehensive security audit using security-specialist  
**`/prefix:orchestration:performance-scan`** - Performance analysis using performance-optimizer  
**`/prefix:orchestration:refactor-impact`** - Refactoring impact analysis  
**`/prefix:orchestration:test-coverage`** - Test coverage analysis using test-engineer

### Hybrid Commands (`/prefix:hybrid:*`)

**`/prefix:hybrid:analyze-deep`** - Deep analysis using hybrid architecture:

- Phase 1: Parallel scanning with Task Tool
- Phase 2: Expert analysis with specialized Sub-Agents
- Phase 3: Comprehensive synthesis and recommendations

## Important Notes

- All documentation should be written in English
- Commands should be self-contained and include all necessary context
- Avoid creating example or demo commands - focus on practical, reusable tools
- The $ARGUMENTS placeholder in commands receives user input after the command invocation
- Extended documentation is available in the `/docs/` directory:
  - `HYBRID-ARCHITECTURE.md` - Detailed hybrid architecture patterns
  - `SUB-AGENT-ORCHESTRATION.md` - Sub-agent orchestration guide
  - `TECHNICAL-GUIDE.md` - Technical implementation details
- Use templates in `/commands/templates/` for creating new commands and agents

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
