# Installing Sub-Agents in Existing Installations

This guide explains how to get the new Sub-Agent Orchestration System into your existing Claude Code slash commands installation.

## Quick Update for Existing Installations

If you already have claude-code-toolkit installed at `~/.claude/commands/global` (or another prefix), here's how to get the new agents:

### Option 1: Manual Update (Fastest)

```bash
# Navigate to your installation
cd ~/.claude/commands/global

# Fetch the feature branch
git fetch origin feature/sub-agent-orchestration

# Switch to the feature branch
git checkout feature/sub-agent-orchestration

# Update sparse-checkout to include agents
echo "agents/*" >> .git/info/sparse-checkout

# Re-read the tree to get agents directory
git read-tree -m -u HEAD

# Move agents to root (matching command structure)
if [ -d "agents" ]; then
    mv agents/* . 2>/dev/null || true
    rmdir agents 2>/dev/null || true
fi

# Verify agents are installed
ls -la *-specialist.md *-optimizer.md *-engineer.md *-architect.md *-expert.md
```

### Option 2: Re-run Updated Install Script

```bash
# From the feature branch
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/feature/sub-agent-orchestration/install.sh | bash -s -- global
```

This will:
- Update your existing installation
- Add agents support
- Preserve your current setup
- Update hooks to version 6

### Option 3: Fresh Installation

For a completely fresh installation with agents:

```bash
# Remove old installation
rm -rf ~/.claude/commands/global

# Install from feature branch
export CLAUDE_COMMANDS_REPO_URL="https://github.com/redpop/claude-code-toolkit.git"
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/feature/sub-agent-orchestration/install.sh | bash -s -- global
```

## Verifying Agent Installation

After installation, you should see:

1. **Agent files in your installation directory:**
   ```bash
   ls ~/.claude/commands/global/*-specialist.md
   ls ~/.claude/commands/global/*-optimizer.md
   ls ~/.claude/commands/global/*-engineer.md
   ls ~/.claude/commands/global/*-architect.md
   ls ~/.claude/commands/global/*-expert.md
   ```

2. **Updated commands that use agents:**
   ```bash
   # Hybrid commands
   ls ~/.claude/commands/global/hybrid/
   
   # Orchestration commands
   ls ~/.claude/commands/global/orchestration/
   ```

3. **Test a hybrid command:**
   ```bash
   /global:hybrid:analyze-deep . --focus=all
   ```

## Understanding the Installation Structure

The updated installation now includes:

```
~/.claude/commands/global/
├── ai/                    # AI-related commands
├── analysis/              # Analysis commands
├── code/                  # Code manipulation commands
├── git/                   # Git commands
├── hybrid/                # NEW: Hybrid architecture commands
│   └── analyze-deep.md
├── orchestration/         # NEW: Sub-agent orchestration commands
│   ├── analyze-parallel.md
│   ├── performance-scan.md
│   ├── refactor-impact.md
│   ├── security-audit.md
│   └── test-coverage.md
├── project/               # Project management commands
├── research/              # NEW: Research commands
│   ├── codebase-map.md
│   ├── deep-dive.md
│   └── dependency-trace.md
├── templates/             # NEW: Command/agent templates
├── code-architect.md      # NEW: Architecture analysis agent
├── performance-optimizer.md # NEW: Performance optimization agent
├── refactoring-expert.md  # NEW: Refactoring specialist agent
├── security-specialist.md # NEW: Security analysis agent
└── test-engineer.md       # NEW: Testing expert agent
```

## Troubleshooting

### Agents not appearing after update

1. **Check your branch:**
   ```bash
   cd ~/.claude/commands/global
   git branch --show-current
   ```
   Should show: `feature/sub-agent-orchestration`

2. **Check sparse-checkout configuration:**
   ```bash
   cat .git/info/sparse-checkout
   ```
   Should include both:
   - `commands/*`
   - `agents/*`

3. **Force re-read of the repository:**
   ```bash
   git sparse-checkout reapply
   git read-tree -m -u HEAD
   ```

4. **Check for agents in the repository:**
   ```bash
   git ls-tree -r HEAD --name-only | grep "^agents/"
   ```

### Commands not finding agents

If hybrid/orchestration commands can't find agents:

1. **Verify agent files are in root:**
   ```bash
   ls ~/.claude/commands/global/*-specialist.md
   ```

2. **Check .claude-commands.json:**
   ```bash
   cat ~/.claude/commands/global/.claude-commands.json | grep -A5 "agentRegistry"
   ```

3. **Ensure agents are executable:**
   The `.md` files should be readable by Claude Code.

## Testing the Installation

Run this test sequence:

```bash
# 1. List all available commands
ls ~/.claude/commands/global/**/*.md

# 2. Count agents
find ~/.claude/commands/global -name "*-specialist.md" -o -name "*-optimizer.md" -o -name "*-engineer.md" -o -name "*-architect.md" -o -name "*-expert.md" | wc -l
# Should show: 5

# 3. Test a hybrid command
/global:hybrid:analyze-deep /path/to/test/project

# 4. Test an orchestration command
/global:orchestration:security-audit /path/to/test/project
```

## Updating in the Future

Once agents are installed, future updates are simple:

```bash
cd ~/.claude/commands/global
git pull
```

The updated post-merge hook (version 6) will automatically:
- Move new agents from `agents/` to root
- Update existing agents
- Remove obsolete files
- Maintain proper structure

## Switching Back to Main Branch

If you need to switch back to the main branch (without agents):

```bash
cd ~/.claude/commands/global
git checkout main
git pull

# Clean up agent files
rm -f *-specialist.md *-optimizer.md *-engineer.md *-architect.md *-expert.md
rm -rf hybrid orchestration research templates
```

## Questions or Issues?

If you encounter any issues:

1. Check the [Troubleshooting](#troubleshooting) section above
2. Review the test script: `test-install.sh`
3. Open an issue on the repository

The Sub-Agent Orchestration System represents a major enhancement to Claude Code's capabilities, enabling powerful parallel analysis and specialized expertise through the hybrid architecture.