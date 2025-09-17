# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with the Claude Code Toolkit repository.

## Repository Purpose

The Claude Code Toolkit is a comprehensive collection of commands, agents, and tools for extending Claude Code capabilities:

- **Commands**: Reusable slash commands for common development tasks
- **Agents**: Specialized AI agents for code analysis and operations
- **Tools**: Utilities and scripts for enhanced productivity
- **Knowledge Base**: Domain-specific patterns and references
- **PRP System**: Project Requirements Proposal methodology for blueprint-driven development

Designed to be installed into `~/.claude/` with a custom prefix, making all toolkit capabilities available for use in any project.

## Quick Start

### 🎯 Essential Workflows

**6-Command Architecture** (Recommended):

```bash
/prefix:understand . --comprehensive
/prefix:improve . --apply-insights
/prefix:ship . --readiness-check
```

**PRP Methodology - Blueprint-Driven Development**:

```bash
/prefix:understand . --prp --requirements="OAuth2 authentication"
/prefix:create . --prp --from-analysis
/prefix:ship . --prp --quality-gates
```

**Quick Development Workflow**:

```bash
/prefix:understand . --quick
/prefix:secure . --audit
```

**Individual Command Usage**:

```bash
/prefix:understand . --deep-analysis
/prefix:improve . --apply-insights
/prefix:ship . --readiness-check
```

💡 Use individual commands for maximum transparency and control over your development workflow.

## Context Distribution

This repository uses distributed CLAUDE.md files for better context management. Each major directory contains its own CLAUDE.md with specific guidelines:

### 📁 Directory-Specific Context Files

- **[agents/CLAUDE.md](agents/CLAUDE.md)** - Sub-agent definitions and creation guidelines
- **[commands/CLAUDE.md](commands/CLAUDE.md)** - Command structure, naming conventions, and patterns
- **[scripts/CLAUDE.md](scripts/CLAUDE.md)** - Utility scripts documentation and shellcheck guidelines
- **[docs/CLAUDE.md](docs/CLAUDE.md)** - Documentation structure and writing guidelines
- **[templates/CLAUDE.md](templates/CLAUDE.md)** - Template usage and creation patterns
- **[knowledge-base/CLAUDE.md](knowledge-base/CLAUDE.md)** - Domain-specific knowledge and references
- **[hooks/CLAUDE.md](hooks/CLAUDE.md)** - Hook scripts for Claude Code integration

Each CLAUDE.md file provides focused context for its specific area, reducing cognitive load and improving relevance.

## Core Concepts

### Command System

Commands follow a hierarchical namespace pattern:

- Structure: `/prefix:command` (6-command architecture) or `/prefix:category:command` (specialized)
- Core Commands: `understand`, `improve`, `create`, `secure`, `ship`, `git`
- Specialized Categories: `typo3`, `meta` (for specific domains)
- Example: `/prefix:understand .` for codebase analysis

See **[commands/CLAUDE.md](commands/CLAUDE.md)** for detailed command documentation.

### Agent System

Specialized AI agents provide domain expertise:

- Located in `/agents/` directory
- Each agent has specific focus area
- Invoked through commands or Task Tool
- **PRP Agents**: codebase-research-specialist, external-research-specialist, requirements-analyst, blueprint-architect

See **[agents/CLAUDE.md](agents/CLAUDE.md)** for agent details.

### Key Patterns

**Task Tool Invocation**:

```markdown
Use Task tool with subagent_type="security-specialist":
"Perform security audit focusing on OWASP Top 10"
```

**6-Command Architecture**:

```bash
/prefix:understand . --comprehensive
/prefix:improve . --apply-recommendations
/prefix:create docs --update-all
```

**PRP Parameters**:

- `--prp` → Activate Project Requirements Proposal methodology
- `--prp=research` → Focus on external research and best practices
- `--prp=patterns` → Focus on internal codebase pattern discovery
- `--prp=template` → Create from existing template patterns

**Export Parameters**:

- `--export-json` → Auto-generates timestamped JSON
- `--export-md` → Auto-generates timestamped Markdown
- `--latest` → Uses most recent report

## Installation & Usage

### Installation

```bash
# Clone the repository
git clone https://github.com/yourusername/claude-code-toolkit.git
cd claude-code-toolkit

# Install with custom prefix
./install.sh myproject
```

This installs:

- Commands to `~/.claude/commands/myproject/`
- Agents to `~/.claude/agents/`
- Hooks to `~/.claude/claude-code-toolkit/hooks/`
- PRP System to `~/.claude/claude-code-toolkit/prp/`
- Creates backup if updating existing installation

For sound notifications:

```bash
./install.sh myproject --with-settings
```

### Development Guidelines

- **Adding Commands**: See [commands/CLAUDE.md](commands/CLAUDE.md)
- **Creating Agents**: See [agents/CLAUDE.md](agents/CLAUDE.md)  
- **Writing Scripts**: See [scripts/CLAUDE.md](scripts/CLAUDE.md)
- **Documentation**: See [docs/CLAUDE.md](docs/CLAUDE.md)
- **Using Templates**: See [templates/CLAUDE.md](templates/CLAUDE.md)

### Important Notes

- Commands should be self-contained and practical
- The `$ARGUMENTS` placeholder receives user input
- Run `./scripts/update-readme.sh` after adding commands
- All scripts should pass shellcheck validation
- Documentation should be written in English

## MCP Integration

The toolkit supports MCP (Model Context Protocol) servers for enhanced functionality:

- **Optional Enhancement**: Works without MCP, better with it
- **Graceful Degradation**: Falls back to traditional methods
- **Supported Servers**: Semgrep, GitHub, GitLab, Perplexity

See [docs/guides/MCP-INTEGRATION.md](docs/guides/MCP-INTEGRATION.md) for details.

## Resources

- **Documentation**: [docs/README.md](docs/README.md)
- **PRP Methodology**: [docs/guides/PRP-METHODOLOGY.md](docs/guides/PRP-METHODOLOGY.md)
- **Project Planning**: [docs/guides/PROJECT-PLANNING-GUIDE.md](docs/guides/PROJECT-PLANNING-GUIDE.md)
- **Security Guide**: [docs/guides/SECURITY-GUIDE.md](docs/guides/SECURITY-GUIDE.md)
- **Enhanced Hooks**: [docs/guides/ENHANCED-HOOKS.md](docs/guides/ENHANCED-HOOKS.md)
- **Contributing**: [CONTRIBUTING.md](CONTRIBUTING.md)
