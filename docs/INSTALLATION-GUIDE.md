# Installation Guide: Claude Code Toolkit

Complete guide for installing and configuring the Claude Code Toolkit with all its commands and agents.

## Prerequisites

- Git installed on your system
- Access to your home directory (`~/.claude/`)
- Claude Code (claude.ai/code) installed and configured

## Quick Install

```bash
# Clone the repository
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit

# Install with your chosen prefix
./install.sh myprefix
```

That's it! All commands are now available as `/myprefix:category:command`

## Installation Options

### Basic Installation

```bash
./install.sh myprefix
```

This will:

- Install all commands to `~/.claude/commands/myprefix/`
- Install all agents to `~/.claude/agents/`
- Display all available commands after installation

### Force Installation (Skip Backup)

```bash
./install.sh myprefix --force
```

Overwrites existing installation without creating backups.

### Selective Installation

Install only specific components:

```bash
# Commands only
./install.sh myprefix --components=commands

# Agents only
./install.sh myprefix --components=agents
```

### Local Project Installation

Install commands for a specific project:

```bash
./install.sh myprefix --local=/path/to/project
```

This creates project-specific commands in `/path/to/project/.claude/`

## Directory Structure After Installation

```
~/.claude/
├── commands/
│   └── myprefix/
│       ├── auto/
│       │   ├── execute.md
│       │   ├── monitor.md
│       │   ├── report.md
│       │   └── sprint.md
│       ├── fix/
│       │   ├── documentation.md
│       │   ├── duplicates.md
│       │   ├── performance.md
│       │   ├── quick-wins.md
│       │   ├── security.md
│       │   └── shell.md
│       ├── flow/
│       │   ├── incident.md
│       │   ├── parallel.md
│       │   ├── refactor.md
│       │   ├── review.md
│       │   └── smart.md
│       ├── gen/
│       │   ├── docs.md
│       │   └── tests.md
│       ├── git/
│       │   └── commit.md
│       ├── meta/
│       │   ├── chain.md
│       │   ├── changelog.md
│       │   ├── create-cmd.md
│       │   ├── export.md
│       │   ├── handoff.md
│       │   ├── health.md
│       │   ├── pipelines.md
│       │   └── update-docs.md
│       ├── scan/
│       │   ├── deep.md
│       │   ├── deps.md
│       │   ├── docs.md
│       │   ├── explore.md
│       │   ├── map.md
│       │   ├── perf.md
│       │   ├── quality.md
│       │   ├── refactor.md
│       │   ├── report.md
│       │   ├── root-cause.md
│       │   └── tests.md
│       └── sec/
│           ├── audit.md
│           ├── baseline.md
│           └── comply.md
└── agents/
    ├── code-architect.md
    ├── documentation-health-specialist.md
    ├── performance-optimizer.md
    ├── refactoring-expert.md
    ├── report-analyzer.md
    ├── security-specialist.md
    └── test-engineer.md
```

## Multiple Installations

You can install multiple versions with different prefixes:

```bash
# Install main toolkit
git clone https://github.com/redpop/claude-code-toolkit.git toolkit-main
cd toolkit-main
./install.sh main

# Install your fork
cd ..
git clone https://github.com/YourName/your-fork.git toolkit-custom
cd toolkit-custom
./install.sh custom

# Install team version
cd ..
git clone https://github.com/YourTeam/team-toolkit.git toolkit-team
cd toolkit-team
./install.sh team
```

Now you have access to:

- `/main:scan:deep` - From main toolkit
- `/custom:scan:deep` - From your fork
- `/team:scan:deep` - From team toolkit

## Updating Your Installation

To update to the latest version:

```bash
cd /path/to/claude-code-toolkit
git pull
./install.sh myprefix
```

The installer will:

1. Detect existing installation
2. Offer to create a backup
3. Update all commands and agents
4. Show what's new

## Verifying Installation

After installation, verify everything works:

```bash
# Test a simple command
/myprefix:meta:health

# List all commands (in Claude Code)
ls ~/.claude/commands/myprefix/

# Check agents
ls ~/.claude/agents/
```

## Troubleshooting

### Command Not Found

If commands aren't recognized:

1. Ensure you're using the correct prefix
2. Check the installation directory exists
3. Restart Claude Code if needed

### Permission Errors

```bash
# Fix permissions
chmod +x install.sh
chmod -R u+rw ~/.claude/
```

### Installation Conflicts

If you have conflicts with existing commands:

1. Choose a unique prefix
2. Use `--force` to overwrite
3. Manually backup important customizations

## Customization

### Adding Custom Commands

1. Create new command in your fork:

   ```bash
   mkdir -p commands/custom
   echo "Your command content" > commands/custom/mycommand.md
   ```

2. Reinstall:
   ```bash
   ./install.sh myprefix
   ```

### Modifying Existing Commands

1. Edit command in your fork
2. Reinstall to apply changes
3. Changes persist through updates

## Best Practices

1. **Use Descriptive Prefixes**: Choose prefixes that indicate the source

   - `main` - Main toolkit
   - `team` - Team commands
   - `proj` - Project-specific

2. **Regular Updates**: Pull and reinstall weekly for latest features

3. **Backup Custom Work**: Before updating, backup any customizations

4. **Test After Updates**: Run a few commands to ensure everything works

## Uninstalling

To remove an installation:

```bash
# Remove commands
rm -rf ~/.claude/commands/myprefix/

# Remove agents (careful - may be shared)
rm -rf ~/.claude/agents/
```

## Getting Help

- Check [CLAUDE.md](../CLAUDE.md) for development guidelines
- See [README.md](../README.md) for command documentation
- Report issues on GitHub
- Join community discussions

## Next Steps

1. Try the quick start workflow:

   ```bash
   /myprefix:flow:smart "Help me improve my code quality"
   ```

2. Explore pre-built pipelines:

   ```bash
   /myprefix:meta:pipelines deep-quality
   ```

3. Create command chains:
   ```bash
   /myprefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"
   ```

Happy coding with Claude Code Toolkit! 🚀
