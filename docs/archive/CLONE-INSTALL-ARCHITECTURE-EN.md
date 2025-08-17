# Claude Commands: Clone + Install Architecture

## Overview

This guide describes the new architecture for Claude Code Slash Commands, which enables a clean separation between source repository and installation. It's designed for both developers who want to extend the toolkit and end users who simply want to use the commands.

### For End Users

If you just want to use the commands, you only need to:

1. Clone the repository
2. Run `./install.sh [prefix]`
3. Start using commands like `/prefix:command:name`

### For Developers

If you want to modify or create new commands/agents, this guide explains:

- How the architecture works
- How to configure your modifications
- How the agent orchestration system functions
- How to use the hybrid approach for maximum performance

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

### Special Rules

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

## Configuration File: .claude-commands.json

The `.claude-commands.json` file is the central configuration for the entire toolkit. It controls how commands and agents work together.

### Key Sections Explained

#### 1. **Repository Information**

```json
{
  "repo_owner": "redpop",
  "repo_name": "claude-code-toolkit",
  "default_branch": "main",
  "description": "The complete toolkit...",
  "version": "2.0.0"
}
```

- Identifies the repository and version
- Used for updates and fork management

#### 2. **Fork Configuration**

```json
"fork_config": {
  "auto_update_urls": true,
  "preserve_original_references": false,
  "custom_prefix_support": true
}
```

- `auto_update_urls`: Automatically updates URLs when forked
- `preserve_original_references`: Whether to keep original repo references
- `custom_prefix_support`: Allows custom prefixes during installation

#### 3. **Sub-Agent Orchestration**

```json
"subAgentOrchestration": {
  "enabled": true,
  "defaults": {
    "tokenBudget": 3000,
    "timeout": 30000,
    "parallelExecution": true
  }
}
```

- Controls how multiple agents work together
- `tokenBudget`: Max tokens per agent (affects response length)
- `timeout`: Max execution time in milliseconds
- `parallelExecution`: Whether agents run in parallel

#### 4. **Performance Modes**

```json
"performanceModes": {
  "conservative": { "maxConcurrentAgents": 5 },
  "balanced": { "maxConcurrentAgents": 10 },
  "aggressive": { "maxConcurrentAgents": 20 }
}
```

- Choose based on your system capabilities
- `conservative`: Safer for limited resources
- `balanced`: Default, good for most systems
- `aggressive`: Maximum parallelization

#### 5. **Agent Registry**

```json
"agentRegistry": {
  "security-specialist": {
    "type": "sub-agent",
    "location": "agents/security-specialist.md",
    "autoInvoke": ["security", "vulnerability"],
    "priority": "high"
  }
}
```

- Defines available agents and their triggers
- `autoInvoke`: Keywords that trigger this agent
- `priority`: Execution priority when multiple agents match

## How the Agent/Command System Works

### Three Types of Execution

#### 1. **Simple Commands**

Basic commands that execute a single task:

```
/prefix:git:commit
```

- Runs standalone
- No agent orchestration
- Fast and simple

#### 2. **Orchestration Commands**

Commands that coordinate multiple specialized agents:

```
/prefix:orchestration:security-audit
```

- Invokes specific sub-agents
- Agents work in their own contexts
- Results are aggregated

#### 3. **Hybrid Commands**

The most powerful approach, combining parallel scanning with expert analysis:

```
/prefix:hybrid:analyze-deep
```

### The Hybrid Architecture in Detail

The hybrid approach uses a three-phase system:

#### Phase 1: Parallel Scanning (5-8 seconds)

- 10+ scanner agents run simultaneously using the Task Tool
- Each scanner has a specific focus (security, performance, etc.)
- Produces structured JSON output
- Optimized for speed and coverage

#### Phase 2: Expert Analysis (10-20 seconds)

- Results from Phase 1 are analyzed
- Critical issues are delegated to specialized sub-agents
- Each sub-agent works in isolation for deep analysis
- Sub-agents have full Claude Code capabilities

#### Phase 3: Synthesis (2-5 seconds)

- All results are combined
- Duplicate findings are merged
- Prioritized action plan is generated
- Final report with metrics

### Example Workflow

When you run `/global:hybrid:analyze-deep ./my-project`:

1. **Phase 1 starts**: 10 scanners launch in parallel
   - Security scanner finds hardcoded credentials
   - Performance scanner finds O(n²) algorithm
   - Architecture scanner finds circular dependencies
   - Test scanner finds 30% coverage
   - And 6 more scanners...

2. **Phase 2 delegation**:
   - Security findings → `security-specialist` agent
   - Performance issues → `performance-optimizer` agent
   - Architecture problems → `code-architect` agent

3. **Phase 3 synthesis**:
   - Combined report with all findings
   - Severity-based prioritization
   - Actionable recommendations
   - Overall health score

## For End Users: Configuration Options

### 1. **Performance Tuning**

Edit `.claude-commands.json` to adjust:

```json
"performanceMode": "conservative"  // Change from "balanced"
```

### 2. **Disable Specific Features**

```json
"subAgentOrchestration": {
  "enabled": false  // Disable agent orchestration
}
```

### 3. **Custom Command Behavior**

```json
"commandOverrides": {
  "orchestration:security-audit": {
    "performanceMode": "conservative",
    "defaults": {
      "tokenBudget": 5000  // More detailed analysis
    }
  }
}
```

## For Developers: Extending the System

### 1. **Creating New Agents**

1. Create a markdown file in `agents/`
2. Define the agent's expertise and persona
3. Register in `.claude-commands.json`:

```json
"agentRegistry": {
  "my-new-agent": {
    "type": "sub-agent",
    "location": "agents/my-new-agent.md",
    "autoInvoke": ["keyword1", "keyword2"],
    "priority": "medium"
  }
}
```

### 2. **Creating Hybrid Commands**

1. Design your three phases
2. Create command in `commands/hybrid/`
3. Configure in `.claude-commands.json`:

```json
"hybridCommands": {
  "my-hybrid-command": {
    "phases": ["scan", "analyze", "report"],
    "scannerCount": 12,
    "expertDelegation": true
  }
}
```

### 3. **Performance Optimization**

- Adjust `tokenBudget` for quality vs speed
- Modify `maxConcurrentAgents` based on system
- Use `caching` for repeated analyses
- Enable `experimental` features for cutting-edge performance

## Summary

The new architecture offers:

1. **Flexibility**: Clone and install from anywhere
2. **Security**: User content is protected
3. **Transparency**: Clear tracking via manifests
4. **Scalability**: Multi-repo support
5. **Maintainability**: Easy updates and management
6. **Performance**: Hybrid approach for maximum efficiency
7. **Extensibility**: Easy to add new commands and agents

The combination of simple installation, powerful orchestration, and the hybrid architecture makes this the most advanced command system for Claude Code.
