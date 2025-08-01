# Claude Code Toolkit - Developer Guide

Welcome to the Claude Code Toolkit developer documentation. This guide provides technical details for maintaining, extending, and customizing the toolkit.

## 🏗️ Technical Overview

The Claude Code Toolkit is a sophisticated command and agent orchestration system built on top of Claude Code's capabilities. It uses a hybrid architecture combining parallel processing with specialized AI agents.

### Core Technologies
- **Claude Code**: The AI-powered development environment
- **Task Tool**: Enables parallel agent execution
- **Sub-Agents**: Specialized AI agents with domain expertise
- **Command System**: Markdown-based command definitions
- **Configuration**: JSON-based system configuration

## 📁 Repository Structure

```
claude-code-toolkit/
├── commands/                    # Command definitions
│   ├── auto/                   # Automation commands
│   ├── fix/                    # Fix commands
│   ├── flow/                   # Workflow commands
│   ├── gen/                    # Generation commands
│   ├── git/                    # Git operations
│   ├── meta/                   # Toolkit management
│   ├── scan/                   # Analysis commands
│   └── sec/                    # Security commands
├── agents/                     # Sub-agent definitions
├── scripts/                    # Utility scripts
├── templates/                  # Command/agent templates
├── docs/                       # Documentation
├── tests/                      # Test suite (future)
├── .claude-commands.json       # System configuration
├── install.sh                  # Installation script
├── CLAUDE.md                  # Claude Code instructions
└── README.md                  # User documentation
```

## 🔧 Key Components

### 1. Command System
Commands are Markdown files with:
- **Frontmatter**: Metadata and tool permissions
- **Instructions**: What the command should do
- **Agent Definitions**: For multi-agent commands
- **Output Format**: Expected results structure

### 2. Agent System
Specialized AI agents that:
- Focus on specific domains
- Work in parallel or sequence
- Provide expert analysis
- Generate actionable insights

### 3. Configuration System
Controls behavior through:
- Global settings in `.claude-commands.json`
- Command-specific overrides
- Performance modes
- Token budgets

### 4. Installation System
Simple file-based installation:
- Copies files to `~/.claude/`
- Supports multiple prefixes
- No dependencies required

## 📚 Documentation Sections

1. **[Architecture Guide](architecture.md)** - System design and patterns
2. **[Configuration Guide](configuration.md)** - Settings and customization
3. **[Extending Guide](extending.md)** - Creating commands and agents
4. **[Testing Guide](testing.md)** - Test infrastructure and writing tests
5. **[Internals Guide](internals.md)** - How everything works

## 🚀 Quick Links for Developers

### Common Tasks
- [Create a new command](extending.md#creating-commands)
- [Add a sub-agent](extending.md#creating-agents)
- [Configure performance](configuration.md#performance-modes)
- [Debug issues](internals.md#debugging)

### Development Workflow
```bash
# 1. Make changes
vim commands/my-command.md

# 2. Test locally
./install.sh global --force

# 3. Use in Claude Code
/global:my-command

# 4. Iterate
```

### Testing
```bash
# Run all tests
./tests/run-all.sh

# Test specific command
./tests/commands/test-flow-smart.sh

# Performance benchmark
./tests/integration/benchmark.sh
```

## 🔑 Key Concepts

### Hybrid Architecture
Combines two execution models:
- **Phase 1**: Parallel scanning with Task Tool
- **Phase 2**: Deep analysis with Sub-Agents
- **Phase 3**: Synthesis and reporting

### Performance Modes
- **Conservative**: Limited resources, 5 agents max
- **Balanced**: Standard usage, 10 agents max
- **Aggressive**: Maximum performance, 20 agents max

### Token Management
- Budget per agent: 2000-5000 tokens
- Automatic distribution
- Overflow handling

### Command Categories
- **scan**: Analysis and investigation
- **fix**: Direct corrections
- **gen**: Code generation
- **flow**: Multi-agent workflows
- **auto**: Automation
- **sec**: Security operations
- **meta**: Toolkit management

## 📖 Understanding the Codebase

### Command Structure
```markdown
---
allowed-tools: Task, Read, Grep, Bash, Write
description: Brief description
argument-hint: <expected-args>
---

# Command implementation
```

### Agent Structure
```markdown
---
name: agent-name
description: Agent expertise
---

You are an expert in...
```

### Configuration Schema
```json
{
  "subAgentOrchestration": {
    "enabled": true,
    "performanceMode": "balanced",
    "defaults": {
      "tokenBudget": 3000,
      "timeout": 30000
    }
  }
}
```

## 🛠️ Maintenance

### Adding Features
1. Design the feature
2. Update relevant commands/agents
3. Test thoroughly
4. Update documentation
5. Bump version

### Deprecating Features
1. Mark as deprecated in docs
2. Add warnings to commands
3. Provide migration path
4. Remove after 2 versions

### Release Process
1. Update CHANGELOG.md
2. Bump version in package.json
3. Tag release
4. Update installation docs

## 🤝 Contributing

### Code Style
- Clear, descriptive names
- Comprehensive comments
- Consistent patterns
- Test coverage

### Documentation
- Keep it current
- Include examples
- Explain the why
- Cross-reference

### Testing
- Unit tests for utilities
- Integration tests for commands
- Performance benchmarks
- User acceptance tests

## 📞 Support

### For Developers
- GitHub Issues
- Discord/Slack channel
- Code reviews
- Pair programming

### Resources
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Task Tool Reference](https://docs.anthropic.com/task-tool)
- [Community Forum](https://forum.example.com)

---

Ready to dive deeper? Start with the [Architecture Guide](architecture.md).