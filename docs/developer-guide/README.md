# Developer Guide

Technical documentation for extending and maintaining the Claude Code Toolkit.

## Quick Navigation

| Guide | Purpose | Start Here |
|-------|---------|------------|
| [Architecture](architecture.md) | System design & patterns | Understanding the hybrid architecture |
| [Configuration](configuration.md) | Settings & customization | Performance modes & configuration |
| [Extending](extending.md) | Creating commands & agents | Command/agent creation workflow |
| [Internals](internals.md) | How everything works | Command resolution & orchestration |
| [Testing](testing.md) | Test infrastructure | Running and writing tests |

## Repository Structure

```
claude-code-toolkit/
├── commands/{category}/*.md    # Command definitions
├── agents/*.md                 # Sub-agent definitions  
├── scripts/*.sh                # Utility scripts
├── templates/                  # Creation templates
├── tests/                      # Test infrastructure
└── install.sh                  # Installation script
```

## Development Workflow

```bash
# Create command/agent
./scripts/create-sub-agent-command.sh --name "analyzer" --agents 6

# Test locally
./install.sh prefix --force
/prefix:category:command test-project/

# Run tests
./tests/run-all.sh
```

## Key Components

| Component | Description | Documentation |
|-----------|-------------|---------------|
| **Commands** | Markdown files with YAML frontmatter | [extending.md](extending.md#creating-commands) |
| **Agents** | Specialized AI personas | [extending.md](extending.md#creating-agents) |
| **Task Tool** | Parallel execution engine | [architecture.md](architecture.md#task-tool) |
| **Configuration** | JSON-based settings | [configuration.md](configuration.md) |

## Performance Modes

| Mode | Agents | Tokens | Timeout | Use Case |
|------|--------|--------|---------|----------|
| Conservative | 5 | 2000 | 20s | Limited resources |
| Balanced | 10 | 3000 | 30s | Standard development |
| Aggressive | 20 | 4000 | 45s | Large codebases |

## Quick Start

1. **Understand**: Read [Architecture](architecture.md) for system design
2. **Configure**: Set performance mode in [Configuration](configuration.md)
3. **Create**: Build commands/agents with [Extending](extending.md)
4. **Test**: Validate with [Testing](testing.md)
5. **Debug**: Troubleshoot using [Internals](internals.md)

## Contributing

See [extending.md](extending.md) for creation workflows and [testing.md](testing.md) for test requirements.
