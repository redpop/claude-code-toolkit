# Installation Guide

Complete setup instructions for the Claude Code Toolkit.

## Prerequisites

See the [main README](../README.md) for system requirements. Ensure you have Claude Code installed and configured.

## Quick Install

```bash
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit
./install.sh global
```

All commands are now available as `/global:category:command`

## Installation Options

### Standard Installation

```bash
./install.sh <prefix>
```

- Installs commands to `~/.claude/commands/<prefix>/`
- Installs agents to `~/.claude/agents/`
- No hooks or notifications

### Enhanced Installation (Recommended)

```bash
./install.sh <prefix> --with-settings
```

- Includes sound notifications and enhanced hooks
- Better user experience with progress feedback
- Configurable notification profiles

### Hooks Profiles

| Profile | Features | Command |
|---------|----------|---------|
| **Basic** | Stop notifications | `--hooks-profile basic` |
| **Minimal** | + Error detection | `--hooks-profile minimal` |
| **Advanced** | + Sounds, logging | `--hooks-profile advanced` |

## Multiple Installations

Install with different prefixes for different workflows:

```bash
./install.sh global     # Main installation
./install.sh team       # Team-specific commands  
./install.sh testing    # Testing environment
```

Each installation is completely independent.

## Hooks System

The toolkit includes an optional hooks system for enhanced functionality:

### Hook Types

- **Session Management**: Logs command usage and sessions
- **Notifications**: Sound alerts for command completion/errors
- **Error Detection**: Automatic error pattern recognition
- **Command Chaining**: Enhanced workflow notifications

### Enabling Hooks

```bash
# Install with advanced hooks
./install.sh global --with-settings --hooks-profile advanced
```

### Hook Profiles

**Basic Profile** (`basic-hooks-settings.json`):

- Stop notifications only
- Minimal system integration

**Minimal Profile** (`minimal-hooks-settings.json`):

- Stop notifications
- Error detection and alerts
- Session logging

**Advanced Profile** (`advanced-hooks-settings.json`):

- All features enabled
- Sound notifications (requires `afplay` on macOS)
- Comprehensive logging
- Command chain notifications
- Sub-agent progress tracking

### Hook Configuration

Hooks are configured in `~/.claude/claude-code-toolkit/settings/` with these files:

- `basic-hooks-settings.json`
- `minimal-hooks-settings.json`
- `advanced-hooks-settings.json`

You can customize any profile by editing the corresponding JSON file.

## Installation Structure

After installation, you'll have:

```
~/.claude/
├── commands/<prefix>/     # Your toolkit commands
├── agents/               # Shared analysis agents
└── claude-code-toolkit/  # Toolkit data and hooks
    ├── settings/         # Hook configuration files
    ├── hooks/           # Hook scripts
    └── .installed-version # Version tracking
```

## Verification

Test your installation:

```bash
# Check installation
ls ~/.claude/commands/global/

# Test a command
/global:meta:health

# Test smart routing
/global:flow:smart "help me get started"
```

## Updating

### Update to Latest Version

```bash
cd claude-code-toolkit
git pull origin main
./install.sh global  # Reinstall with same prefix
```

### Update with Settings Preservation

Your hook settings are automatically preserved during updates.

### Version Checking

```bash
# Check current version
/global:meta:version

# Check for updates
/global:meta:version --check-updates
```

## Troubleshooting

### Commands Not Found

- Verify installation: `ls ~/.claude/commands/global/`
- Check Claude Code configuration
- Ensure correct prefix: `/global:category:command`

### Installation Fails

- Check write permissions to `~/.claude/`
- Ensure Git repository is accessible
- Verify disk space availability

### Hooks Not Working

- Check hook files exist: `ls ~/.claude/claude-code-toolkit/hooks/`
- Verify settings file: `ls ~/.claude/claude-code-toolkit/settings/`
- Test sound system (macOS): `afplay /System/Library/Sounds/Glass.aiff`

### Permission Issues

```bash
# Fix permissions
chmod -R 755 ~/.claude/claude-code-toolkit/
chmod +x ~/.claude/claude-code-toolkit/hooks/*.sh
```

## Customization

### Custom Installation Directory

```bash
# Install to custom location (advanced)
CLAUDE_DIR="/custom/path" ./install.sh global
```

### Custom Hook Scripts

Copy and modify existing hooks:

```bash
cp ~/.claude/claude-code-toolkit/hooks/success-notification.sh ~/.claude/claude-code-toolkit/hooks/my-custom-hook.sh
# Edit the copied file
```

Then reference your custom hook in the settings JSON.

## Best Practices

### Prefix Selection

- **global**: General development work
- **team**: Team-specific workflows  
- **project**: Project-specific commands
- **test**: Testing and experimentation

### Hook Profiles

- **Basic**: Minimal distraction, essential feedback only
- **Minimal**: Good balance of features and simplicity
- **Advanced**: Full experience with all features

### Maintenance

- Update regularly: `git pull && ./install.sh global`
- Clean old reports: `/global:meta:export reports/ --archive`
- Check system health: `/global:meta:analyze-toolkit`

## Next Steps

After installation:

1. **Get Started**: Read the [Quick Start Guide](guides/QUICK-START.md)
2. **Learn Workflows**: Check the [Workflow Guide](user-guide/workflow-guide.md)
3. **Try Smart Commands**: Run `/global:flow:smart "analyze my project"`
4. **Explore**: See [Command Reference](user-guide/command-reference.md)

## Support

- **Quick Help**: `/global:flow:smart "help with [your question]"`
- **Documentation**: [docs/README.md](README.md)
- **Issues**: GitHub repository
- **FAQ**: [FAQ.md](FAQ.md)
