# Enhanced Hook System Guide

The Claude Code Toolkit includes an intelligent hook system that transforms your development workflow with automated insights, context preservation, and smart notifications.

## 🎯 Overview

The Enhanced Hook System provides four key capabilities:

1. **Session-End Summary** - Intelligent session summaries with Basic Memory integration
2. **Enhanced Command Statistics** - Detailed usage analytics and pattern recognition
3. **Hook Management CLI** - User-friendly hook administration
4. **Context Refresh** - Automatic context preservation and restoration

## 🔧 Installation

The enhanced hooks are automatically installed when you use the toolkit installer:

```bash
./install.sh myproject --with-settings
```

Or manually enable specific hooks:

```bash
./scripts/manage-hooks.sh enable session-end-summary
./scripts/manage-hooks.sh enable enhanced-command-logger
./scripts/manage-hooks.sh enable context-refresh
./scripts/manage-hooks.sh enable session-start-enhanced
```

## 📊 1. Session-End Summary Hook

**File**: `~/.claude/claude-code-toolkit/hooks/session-end-summary.sh`

### Features

- **Basic Memory Integration**: Automatically loads project insights and context
- **Session Metrics**: Duration, command count, productivity stats
- **Git Status**: Uncommitted changes, recent commits, branch info
- **Smart Suggestions**: Project-specific next session recommendations
- **Learning Capture**: Documents insights for future sessions

### Example Output

```
═══════════════════════════════════════════════════════════════
📊 SESSION SUMMARY - Claude Code Toolkit
═══════════════════════════════════════════════════════════════

⏱️  Duration: 2h 15min
📂 Project: claude-code-toolkit
📍 Location: /Users/user/Projects/claude-code-toolkit

🧠 BASIC MEMORY INSIGHTS:
────────────────────────────────────
💡 PROJECT MEMORY FOUND:
   Check: memory://claude-code-toolkit/ for context continuation

🎯 MEMORY SUGGESTIONS:
   • Save current progress: Use Basic Memory to document key insights
   • Next session: Review memory://claude-code-toolkit/ for context

📈 SESSION COMMANDS:
────────────────────────────────────
Most used commands today:
   • /prefix:understand: 12x
   • /prefix:improve: 8x
   • bash:git: 15x

📋 GIT STATUS:
────────────────────────────────────
   ✅ Working directory clean
   📚 Recent commits:
      954a14d feat: complete Knowledge-Driven Revolution v4.0.0
      5d63a77 docs: revolutionize documentation structure

🎯 NEXT SESSION SUGGESTIONS:
────────────────────────────────────
   • Use /prefix:understand . --comprehensive for deep analysis
   • Use /prefix:improve . --apply-insights for optimizations
   • Save insights to Basic Memory for next session
   • Review documentation: docs/USAGE.md

═══════════════════════════════════════════════════════════════
💡 Tip: Use /prefix:meta:handoff to document context for others
🔧 Manage hooks: ./scripts/manage-hooks.sh
═══════════════════════════════════════════════════════════════
```

### Configuration

Edit the hook file to customize:

- **Basic Memory Integration**: Modify memory queries and context depth
- **Project Detection**: Add custom project type recognition
- **Suggestions**: Customize recommendations based on project patterns
- **Output Format**: Adjust summary sections and styling

## 📈 2. Enhanced Command Statistics

**File**: `~/.claude/claude-code-toolkit/hooks/enhanced-command-logger.sh`

### Features

- **Multi-dimensional Tracking**: Daily, weekly, monthly statistics
- **Pattern Recognition**: Identifies successful command sequences
- **Project-specific Metrics**: Per-project usage analytics
- **Efficiency Insights**: Command success rates and optimization suggestions
- **Tool Classification**: Categorizes Claude commands, bash commands, and tool usage

### Statistics Files

```
~/.claude/claude-code-toolkit/stats/
├── command-stats.json          # Main statistics database
├── daily-stats-2025-01-13.json # Daily command breakdown
└── daily-stats-2025-01-12.json # Previous days...
```

### Example Statistics

```json
{
  "daily": {
    "2025-01-13": {
      "/prefix:understand": {
        "count": 12,
        "last_used": "2025-01-13T15:42:00Z",
        "projects": {
          "claude-code-toolkit": 8,
          "my-app": 4
        }
      },
      "bash:git": {
        "count": 15,
        "last_used": "2025-01-13T16:20:00Z"
      }
    }
  },
  "patterns": {
    "most_successful_sequences": [
      "understand-improve-secure",
      "understand-create-ship"
    ],
    "efficiency_metrics": {
      "2025-01-13": {
        "commands_per_session": 8.5,
        "most_used_tool": "/prefix:understand"
      }
    }
  }
}
```

### View Statistics

```bash
# Show hook usage statistics
./scripts/manage-hooks.sh stats

# View detailed statistics files
cat ~/.claude/claude-code-toolkit/stats/command-stats.json | jq '.daily'
```

## 🛠️ 3. Hook Management CLI

**File**: `./scripts/manage-hooks.sh`

### Commands

```bash
# List all available hooks with status
./scripts/manage-hooks.sh list

# Show detailed hook information
./scripts/manage-hooks.sh info session-end-summary

# Enable/disable hooks
./scripts/manage-hooks.sh enable enhanced-command-logger
./scripts/manage-hooks.sh disable stop-notification

# System diagnostics
./scripts/manage-hooks.sh doctor

# Usage statistics
./scripts/manage-hooks.sh stats

# Create new custom hook
./scripts/manage-hooks.sh create my-custom-hook
```

### Hook Information Display

```bash
$ ./scripts/manage-hooks.sh info session-end-summary

🎣 HOOK: session-end-summary
────────────────────────────────────────
📝 Description: Intelligent session summaries with Basic Memory
🔧 Type: Stop
📋 Dependencies: jq,Basic Memory MCP
⚡ Status: ✅ ENABLED
📁 File Path: ~/.claude/claude-code-toolkit/hooks/session-end-summary.sh

🔍 DEPENDENCY CHECK:
────────────────────────────────────────
   ✅ jq - Available
   ❌ Basic Memory MCP - Not found

💡 USAGE:
────────────────────────────────────────
   Enable:  ./scripts/manage-hooks.sh enable session-end-summary
   Disable: ./scripts/manage-hooks.sh disable session-end-summary
```

### Available Hooks

| Hook | Description | Type | Dependencies |
|------|-------------|------|--------------|
| `session-end-summary` | Intelligent session summaries with Basic Memory | Stop | jq, Basic Memory MCP |
| `enhanced-command-logger` | Enhanced command statistics tracking | PostToolUse | jq |
| `context-refresh` | Automatic context preservation | PostToolUse | Basic Memory MCP |
| `session-start-enhanced` | Enhanced session initialization | SessionStart | Basic Memory MCP |
| `markdown-format` | Auto-format MD files | PostToolUse | markdownlint-cli2 |
| `stop-notification` | Sound notifications | Stop | afplay |
| `error-detection` | Error pattern detection | PostToolUse | none |

## 🔄 4. Context Refresh System

**Files**:

- `context-refresh.sh` - Continuous context preservation
- `session-start-enhanced.sh` - Enhanced session initialization

### Context Refresh Hook

**Triggers**: Automatically every 30 minutes or on context-intensive operations

**Features**:

- **Basic Memory Integration**: Loads project-specific context
- **Session Focus Tracking**: Maintains current development focus
- **Smart Refresh**: Only shows full refresh when needed
- **Lightweight Updates**: Continuous background context preservation

### Session Start Hook

**Triggers**: At the beginning of each Claude Code session

**Features**:

- **Previous Context Loading**: Retrieves context from Basic Memory
- **Project Insights**: Analyzes project type and provides relevant information
- **Starting Suggestions**: Recommends appropriate commands based on project state
- **Session Tips**: Provides productivity tips and toolkit guidance

### Example Session Start Output

```
═══════════════════════════════════════════════════════════════
🚀 SESSION START - Claude Code Toolkit
═══════════════════════════════════════════════════════════════

📂 Project: claude-code-toolkit
📍 Directory: /Users/user/Projects/claude-code-toolkit
⏰ Started: 2025-01-13 16:45:23

🧠 LOADING PREVIOUS CONTEXT:
────────────────────────────────────────
Recent session context for claude-code-toolkit:
- Implemented enhanced hook system with 4 new concepts
- Added session summaries, command statistics, hook management CLI
- Working on documentation and integration testing

💡 TIP: Full context available in Basic Memory
   Use: mcp__basic-memory__search_notes query="claude-code-toolkit"

🔍 PROJECT INSIGHTS:
────────────────────────────────────────
   📁 General project
   📖 README.md found
   🤖 Claude Code instructions found
   🌿 Git branch: feature/knowledge-driven-revolution
   ⚠️  3 uncommitted files

🎯 SUGGESTED STARTING COMMANDS:
────────────────────────────────────────
   🔍 Analyze & Understand:
   • /prefix:understand . --comprehensive
   • /prefix:understand . --quick

   🛠️  Improve & Develop:
   • /prefix:improve . --apply-insights
   • /prefix:create docs --update

   🔒 Security & Quality:
   • /prefix:secure . --audit
   • /prefix:ship . --readiness-check

💡 SESSION TIPS:
────────────────────────────────────────
   • Use Basic Memory to document insights: mcp__basic-memory__write_note
   • Get session summary at end: Automatic with session-end-summary hook
   • Manage hooks: ./scripts/manage-hooks.sh
   • Create handoff document: /prefix:meta:handoff

═══════════════════════════════════════════════════════════════
✅ Session initialized! Ready for development.
🧠 Context loaded from Basic Memory where available.
═══════════════════════════════════════════════════════════════
```

## 💡 Best Practices

### 1. Basic Memory Integration

For optimal context preservation:

```bash
# Install Basic Memory MCP for enhanced functionality
# The hooks work without it but provide richer insights with it

# Document insights during sessions
mcp__basic-memory__write_note \
  title="session-insights-$(date +%Y%m%d)" \
  content="Key insights from today's development session" \
  folder="projects/my-project"

# Search previous context
mcp__basic-memory__search_notes query="project-name feature-name"
```

### 2. Hook Customization

Customize hooks for your workflow:

```bash
# Create project-specific reminders
echo "• Review API documentation before next session" > .claude-session-reminders
echo "• Update tests after implementing new features" >> .claude-session-reminders

# Edit hook behavior
vim ~/.claude/claude-code-toolkit/hooks/session-end-summary.sh
```

### 3. Statistics Analysis

Leverage command statistics:

```bash
# View daily patterns
jq '.daily["2025-01-13"]' ~/.claude/claude-code-toolkit/stats/command-stats.json

# Identify successful patterns
jq '.patterns.most_successful_sequences' ~/.claude/claude-code-toolkit/stats/command-stats.json

# Track project-specific usage
jq '.project_stats' ~/.claude/claude-code-toolkit/stats/command-stats.json
```

### 4. Hook Management

Regularly maintain your hook system:

```bash
# Run health checks
./scripts/manage-hooks.sh doctor

# Review enabled hooks
./scripts/manage-hooks.sh list

# Update hook dependencies
brew install jq markdownlint-cli2  # macOS
```

## 🔧 Troubleshooting

### Common Issues

**1. Hook Not Executing**

```bash
# Check hook permissions
ls -la ~/.claude/claude-code-toolkit/hooks/

# Make hook executable
chmod +x ~/.claude/claude-code-toolkit/hooks/session-end-summary.sh

# Test hook manually
echo '{"tool_name": "test"}' | ~/.claude/claude-code-toolkit/hooks/session-end-summary.sh
```

**2. Dependencies Missing**

```bash
# Check dependencies
./scripts/manage-hooks.sh doctor

# Install missing dependencies
brew install jq                    # Command statistics
npm install -g markdownlint-cli2   # Markdown formatting
```

**3. Basic Memory Integration Issues**

```bash
# Verify Basic Memory MCP is installed
# Hooks provide graceful fallback if Basic Memory unavailable

# Test Basic Memory commands
mcp__basic-memory__search_notes query="test"
```

**4. Statistics Not Recording**

```bash
# Check statistics directory
ls -la ~/.claude/claude-code-toolkit/stats/

# Verify enhanced-command-logger is enabled
./scripts/manage-hooks.sh info enhanced-command-logger

# Check log files
tail ~/.claude/claude-code-toolkit/logs/bash-command-log.txt
```

## 🚀 Advanced Usage

### Custom Hook Creation

```bash
# Create new hook with CLI
./scripts/manage-hooks.sh create project-specific-hook

# Edit the generated template
vim ~/.claude/claude-code-toolkit/hooks/project-specific-hook.sh
```

### Integration with CI/CD

```bash
# Use session summaries in automated workflows
# Add hook outputs to build logs or notifications

# Example: Save session summary to file
# Modify session-end-summary.sh to write summary to file for CI consumption
```

### Cross-Project Analytics

```bash
# Analyze patterns across multiple projects
jq '.project_stats' ~/.claude/claude-code-toolkit/stats/command-stats.json

# Compare efficiency metrics over time
find ~/.claude/claude-code-toolkit/stats/ -name "daily-stats-*.json" -exec jq '.claude_commands' {} \;
```

## 📚 Related Documentation

- [Hook System Architecture](../architecture/HOOKS-ARCHITECTURE.md)
- [Basic Memory Integration](MCP-INTEGRATION.md)
- [Command Reference](../USAGE.md)
- [Installation Guide](../INSTALLATION-GUIDE.md)

---

The Enhanced Hook System transforms the Claude Code Toolkit from a collection of commands into an intelligent development partner that learns from your patterns, preserves context across sessions, and provides actionable insights for continuous improvement.
