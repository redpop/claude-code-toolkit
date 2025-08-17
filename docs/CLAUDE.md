# CLAUDE.md - Documentation Context

Provides Claude Code AI with documentation structure and navigation context.

## Documentation Organization

- **guides/** - Practical workflows and how-to documentation
- **user-guide/** - End-user command reference and workflows  
- **developer-guide/** - Development and contribution guides
- **architecture/** - Technical design and system documentation
- **api/** - API specifications and integration guides
- **tutorials/** - Learning-oriented materials
- **archive/** - Historical and deprecated content

## AI Context Guidelines

When working with documentation:

1. **Consistency**: Use "global" prefix in all examples
2. **Cross-references**: Link to related sections appropriately  
3. **Single source**: Avoid duplicating content between files
4. **Installation**: Reference [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md) for setup
5. **Current**: Keep examples and commands up to date

## Quick Navigation

| User Type | Start Here | Then See |
|-----------|------------|----------|
| **New Users** | [Quick Start](guides/QUICK-START.md) | [Workflow Guide](user-guide/workflow-guide.md) |
| **Developers** | [Developer Guide](developer-guide/README.md) | [Agent Creation](guides/AGENT-CREATION-WORKFLOW.md) |
| **Contributors** | [Contributing](../CONTRIBUTING.md) | [Extending](developer-guide/extending.md) |

## Cross-References

- **Commands**: [/commands/CLAUDE.md](../commands/CLAUDE.md)
- **Agents**: [/agents/CLAUDE.md](../agents/CLAUDE.md)
- **Scripts**: [/scripts/CLAUDE.md](../scripts/CLAUDE.md)
- **Templates**: [/templates/CLAUDE.md](../templates/CLAUDE.md)
- **Installation**: [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md)

## Maintenance

- Update command tables: `./scripts/update-readme.sh`
- Test all code examples before documenting
- Use consistent "global" prefix in examples
- Link to appropriate guides instead of duplicating content
