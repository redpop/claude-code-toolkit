# CLAUDE.md - Documentation Context

Provides Claude Code AI with documentation structure and navigation context for the 6-command architecture.

## Documentation Organization

- **USAGE.md** - Complete command reference and workflows
- **DEVELOPMENT.md** - Development and contribution guide
- **INSTALLATION-GUIDE.md** - Setup instructions
- **FAQ.md** - Common questions and troubleshooting
- **guides/** - Essential guides (MCP, security, project planning)
- **archive/** - Historical and deprecated content

## AI Context Guidelines

When working with documentation:

1. **Consistency**: Use user's chosen prefix in all examples
2. **Simplicity**: Focus on essential information only
3. **6-Command Focus**: Emphasize core commands (understand, improve, create, secure, ship, git)
4. **Extensions**: Document meta/*and typo3/* as extensions
5. **Current**: Keep aligned with new architecture

## Quick Navigation

| User Type | Start Here | Then See |
|-----------|------------|----------|
| **New Users** | [USAGE.md](USAGE.md) | [FAQ.md](FAQ.md) |
| **Developers** | [DEVELOPMENT.md](DEVELOPMENT.md) | [MCP Integration](guides/MCP-INTEGRATION.md) |
| **Contributors** | [DEVELOPMENT.md](DEVELOPMENT.md) | [../CONTRIBUTING.md](../CONTRIBUTING.md) |

## Cross-References

- **Commands**: [/commands/CLAUDE.md](../commands/CLAUDE.md)
- **Agents**: [/agents/CLAUDE.md](../agents/CLAUDE.md)
- **Scripts**: [/scripts/CLAUDE.md](../scripts/CLAUDE.md)
- **Installation**: [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md)

## Core Architecture

The documentation reflects the Knowledge-Driven Architecture:

- **6 Core Commands**: understand, improve, create, secure, ship, git
- **Extensions**: meta/*, typo3/*
- **25+ AI Agents**: Specialized domain expertise including research and planning agents
- **Learning Integration**: Basic Memory with graceful fallback

## Maintenance

- Update README: `./scripts/update-readme.sh`
- Keep documentation minimal and essential
- Use consistent prefix in examples
- Focus on practical utility over complexity
