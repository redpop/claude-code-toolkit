# Claude Commands: Clone + Install Architecture

## Overview

This guide describes the new architecture for Claude Code Slash Commands, which enables a clean separation between source repository and installation.

## Core Concepts

### 1. **Separation of Concerns**
- **Source Repository**: Where code is developed and versioned (any location)
- **Installation**: Where Claude Code expects the commands/agents (`~/.claude/`)
- **Manifest System**: Tracking which files come from where

### 2. **Multi-Repository Support**
- Multiple command collections can be installed simultaneously
- Each with its own prefix
- Central agent management with conflict handling

### 3. **User-First Design**
- User's own agents are never overwritten
- Clear separation between repo agents and user agents
- Intelligent conflict handling

## Directory Structure

### Source Repository (any location)
```
~/projects/my-claude-commands/          # Or any other location
├── commands/                           # Command definitions
│   ├── git/
│   │   └── commit.md
│   ├── project/
│   │   └── changelog.md
│   └── ...
├── agents/                            # Agent definitions
│   ├── security-specialist.md
│   ├── performance-optimizer.md
│   └── ...
├── install.sh                         # Installation script
├── uninstall.sh                       # Uninstallation script
├── scripts/
│   ├── sync-agents.sh                # Agent sync tool
│   └── manage-commands.sh            # Command manager
├── .claude-commands.json              # Repo configuration
└── README.md
```

### Installation Target (`~/.claude/`)
```
~/.claude/
├── commands/                          # Installed commands
│   ├── global/                       # Prefix "global"
│   │   ├── git/
│   │   │   └── commit.md
│   │   └── .update.sh               # Auto-update script
│   ├── team/                        # Prefix "team"
│   │   └── ...
│   └── custom/                      # Prefix "custom"
│       └── ...
├── agents/                          # All agents (mixed)
│   ├── security-specialist.md       # Repo agent
│   ├── my-custom-agent.md          # User agent
│   └── .manifest.json              # Agent manifest
├── .manifests/                     # Installation tracking
│   ├── global.json                 # Manifest for "global"
│   ├── team.json                   # Manifest for "team"
│   └── custom.json                 # Manifest for "custom"
└── bin/                           # Utilities
    ├── claude-sync                 # Global sync tool
    └── claude-agent               # Agent manager
```

## Manifest System

### Command Manifest (`.claude/.manifests/PREFIX.json`)
```json
{
  "version": "1.0.0",
  "prefix": "global",
  "source": {
    "type": "git",
    "url": "https://github.com/redpop/claude-code-toolkit.git",
    "path": "/Users/user/projects/claude-commands",
    "commit": "abc123def456"
  },
  "installed": "2025-01-27T10:00:00Z",
  "lastUpdated": "2025-01-27T15:00:00Z",
  "files": [
    "git/commit.md",
    "project/changelog.md",
    "ai/handoff.md"
  ],
  "config": {
    "autoUpdate": false,
    "updateChannel": "stable"
  }
}
```

### Agent Manifest (`.claude/.manifests/agents.json`)
```json
{
  "version": "1.0.0",
  "agents": {
    "security-specialist.md": {
      "source": "repo",
      "prefix": "global",
      "sourcePath": "/Users/user/projects/claude-commands/agents/security-specialist.md",
      "installedAt": "2025-01-27T10:00:00Z",
      "checksum": "sha256:abc123...",
      "metadata": {
        "name": "Security Specialist",
        "description": "Security analysis expert"
      }
    },
    "my-custom-agent.md": {
      "source": "user",
      "createdAt": "2025-01-26T14:00:00Z",
      "metadata": {
        "name": "My Custom Agent",
        "description": "Personal custom agent"
      }
    },
    "team-analyzer.md": {
      "source": "repo",
      "prefix": "team",
      "sourcePath": "/Users/user/projects/team-commands/agents/team-analyzer.md",
      "installedAt": "2025-01-27T11:00:00Z"
    }
  }
}
```

## Installation Workflow

### 1. Initial Installation
```bash
# Clone repository
git clone https://github.com/redpop/claude-code-toolkit.git ~/projects/claude-commands
cd ~/projects/claude-commands

# Install with desired prefix
./install.sh global

# Or with options
./install.sh --prefix=team --skip-agents --verbose
```

### 2. Fork Installation
```bash
# Clone fork
git clone https://github.com/myteam/our-claude-commands.git ~/projects/team-commands
cd ~/projects/team-commands

# Install with different prefix
./install.sh team
```

### 3. Update Workflow
```bash
# Option 1: Manual update
cd ~/projects/claude-commands
git pull
./install.sh global --update

# Option 2: Auto-update script
~/.claude/commands/global/.update.sh

# Option 3: Global update tool
claude-sync update global
```

## Conflict Handling

### Agent Conflicts
When an agent already exists:

```
⚠️  Conflict: security-specialist.md already exists

Currently installed:
  Source: repo (prefix: team)
  Installed: 2025-01-26

New version:
  Source: repo (prefix: global)
  
Options:
  [s] Skip - Keep current version
  [r] Replace - Replace with new version
  [b] Backup - Backup current, install new
  [m] Merge - Keep both (with suffix)
  
Selection [s/r/b/m]: 
```

### Special Rules:
1. **User agents are NEVER automatically overwritten**
2. **Repo agents can replace other repo agents** (with warning)
3. **Backup option creates**: `agent-name.md.backup-20250127`
4. **Merge option creates**: `agent-name-global.md`

## Command-Line Interface

### install.sh
```bash
Usage: ./install.sh [PREFIX] [OPTIONS]

PREFIX:
  The namespace for this installation (default: directory name)

OPTIONS:
  --update              Update existing installation
  --skip-agents         Don't install agents
  --skip-commands       Don't install commands
  --force              Overwrite without confirmation
  --dry-run            Show what would happen
  --verbose            Detailed output
  --config FILE        Use alternative configuration

EXAMPLES:
  ./install.sh                    # Install with auto-detected prefix
  ./install.sh global            # Install with prefix "global"
  ./install.sh team --update     # Update installation "team"
  ./install.sh --dry-run         # Preview installation
```

### claude-sync (Global Tool)
```bash
Usage: claude-sync [COMMAND] [OPTIONS]

COMMANDS:
  list                  List all installations
  update [PREFIX]       Update specific installation
  update-all           Update all installations
  check                Check for updates
  clean                Remove orphaned files
  
OPTIONS:
  --verbose            Detailed output
  --force              No confirmations

EXAMPLES:
  claude-sync list
  claude-sync update global
  claude-sync check --verbose
```

## Migration Guide

### From old to new structure

```bash
# 1. Create backup
cp -r ~/.claude/commands ~/.claude/commands.backup

# 2. Identify old Git repo
cd ~/.claude/commands/global
git remote -v
# -> https://github.com/redpop/claude-code-toolkit.git

# 3. Clone anew
cd ~/projects
git clone https://github.com/redpop/claude-code-toolkit.git

# 4. Switch branch if necessary
cd claude-code-toolkit
git checkout feature/sub-agent-orchestration

# 5. Remove old installation
rm -rf ~/.claude/commands/global

# 6. Install anew
./install.sh global

# 7. Restore user customizations
# (manually check and copy from backup)
```

## Best Practices

### 1. For Repository Maintainers
- Use **Semantic Versioning** for releases
- Clearly document **Breaking Changes**
- **Agent names** should be unique
- **Minimize conflicts** through specific names

### 2. For End Users
- Always create **your own agents** in `~/.claude/agents/`
- **Choose a prefix** that avoids conflicts
- **Regular updates** via `claude-sync check`
- **Backup** before major updates

### 3. For Teams
- Create a **team fork** for shared commands
- **Own prefix** (e.g. "acme-team")
- **CI/CD** for automatic tests
- **Documentation** of team-specific commands

## Technical Details

### Checksum Verification
```bash
# Check agent integrity
sha256sum ~/.claude/agents/security-specialist.md
# Compare with manifest entry
```

### Symlink vs. Copy
```bash
# install.sh can use symlinks (development mode)
./install.sh global --use-symlinks

# Advantages: Changes are immediately active
# Disadvantages: Source must remain available
```

### Custom Hooks
```bash
# Post-Install Hook
~/.claude/hooks/post-install.sh

# Pre-Update Hook  
~/.claude/hooks/pre-update.sh
```

## Troubleshooting

### "Command not found"
```bash
# Check installation
ls ~/.claude/commands/PREFIX/

# Check manifest
cat ~/.claude/.manifests/PREFIX.json
```

### "Agent is not recognized"
```bash
# Check agent directory
ls ~/.claude/agents/

# Check agent manifest
cat ~/.claude/.manifests/agents.json | jq
```

### "Updates not working"
```bash
# Check source path
cat ~/.claude/.manifests/PREFIX.json | jq .source.path

# Update manually
cd [source-path]
git pull
./install.sh PREFIX --update
```

## Summary

The new architecture offers:

1. **Flexibility**: Clone and install from anywhere
2. **Security**: User content is protected
3. **Transparency**: Clear tracking via manifests
4. **Scalability**: Multi-repo support
5. **Maintainability**: Easy updates and management

The switch from "Git-in-place" to "Clone+Install" makes the system more robust, understandable, and future-proof.