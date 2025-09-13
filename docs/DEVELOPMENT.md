# Development Guide

Technical documentation for extending and maintaining the Claude Code Toolkit.

## Architecture

The toolkit uses a **6-Command Core Architecture** with specialized extensions:

- **Core Commands**: understand, improve, create, secure, ship, git
- **Extensions**: meta/*(changelog, handoff), typo3/* (content-blocks, etc.)
- **Agents**: 22+ specialized AI agents for domain expertise
- **Knowledge Base**: Basic Memory integration with graceful fallback

## Adding Commands

Use the command creation script:

```bash
# Core command (goes in commands/)
./scripts/create-command.sh --name "analyze" --type core --description "Deep analysis"

# Meta command (goes in commands/meta/)
./scripts/create-command.sh --name "deploy" --type meta --description "Deployment helper"

# TYPO3 command (goes in commands/typo3/)
./scripts/create-command.sh --name "debugger" --type typo3 --description "TYPO3 debugging"
```

### Command Structure

Commands must follow Claude Code standards (15-30 lines):

```markdown
---
description: Brief command description
argument-hint: [expected-arguments]
---

# command-name

Description with intelligent routing and learning persistence.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
[Show help and exit]

## Implementation

Use Task tool with appropriate specialists:

```markdown
Use Task tool with subagent_type="specialist-name":
"Perform task for: $ARGUMENTS"
```

## Learning Integration

This command integrates with the Knowledge-Driven Revolution:

1. **Intelligent Routing** - Automatically selects best agents
2. **Learning Persistence** - Builds knowledge over time

```

## Adding Agents

Create agents in `/agents/` directory with frontmatter:

```markdown
---
name: agent-name
type: specialist
focus: Domain expertise area
tools: Read, Write, Bash, etc.
---

# Agent Name

Agent description and capabilities.

## Expertise

- Specific skill 1
- Specific skill 2

## Usage Pattern

Invoked through Task tool:
```markdown
Use Task tool with subagent_type="agent-name":
"Specific task description"
```

```

## Repository Structure

```

claude-code-toolkit/
├── commands/           # Core commands (understand, improve, etc.)
├── commands/meta/      # Meta commands (changelog, handoff)
├── commands/typo3/     # TYPO3 commands (content-blocks, etc.)
├── agents/            # Specialized AI agents
├── scripts/           # Utility scripts
├── templates/         # Command/agent templates
└── docs/             # Essential documentation only

```

## Development Workflow

1. **Create Command/Agent**: Use creation scripts
2. **Test Locally**: Verify functionality
3. **Update Documentation**: Run `./scripts/update-readme.sh`
4. **Validate**: Ensure 15-30 line limit for commands

## Configuration

### Installation
Commands install to `~/.claude/commands/PREFIX/`
Agents install to `~/.claude/agents/`

### MCP Integration
Optional enhancement - toolkit works without MCP but better with it.
Supported: Semgrep, GitHub, GitLab, Perplexity, Basic Memory

### Hooks
Place hooks in `~/.claude/claude-code-toolkit/hooks/`
Configuration in user settings

## Testing

Commands are tested through actual usage patterns.
No complex test infrastructure - focus on practical functionality.

## Best Practices

- **Commands**: 15-30 lines, Claude Code compliant
- **Agents**: Domain-specific, clear expertise areas
- **Documentation**: Minimal, essential only
- **Learning**: Use Basic Memory integration where applicable
- **Fallbacks**: Always provide graceful degradation

## Contributing

1. Follow 6-command architecture principles
2. Use creation scripts for consistency
3. Update README after changes
4. Focus on practical utility over complexity
