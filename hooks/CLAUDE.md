# CLAUDE.md - Hooks Directory

This file provides guidance to Claude Code when working with hooks in the Claude Code Toolkit.

## Purpose

The hooks directory contains scripts that integrate with Claude Code's hook system to enhance the user experience with notifications and automation.

## Available Hooks

### Core Notification Hooks

#### stop-notification.sh

**Purpose**: Basic completion sound when Claude finishes responding  
**Hook Type**: Stop  
**Default**: Glass.aiff at 50% volume

#### tool-specific-notification.sh

**Purpose**: Different sounds based on which tool was used  
**Hook Type**: PostToolUse  
**Sounds**: Pop (files), Tink (commands), Submarine (agents), etc.

#### subagent-notification.sh

**Purpose**: Agent-specific sounds when subagents complete  
**Hook Type**: SubagentStop  
**Examples**: Hero (security), Ping (tests), Funk (performance)

### Advanced Monitoring Hooks

#### error-detection.sh

**Purpose**: Monitors for errors and security issues with alerts  
**Hook Type**: PostToolUse  
**Features**: Critical alerts, macOS notifications, success sounds

#### success-notification.sh

**Purpose**: Celebrates successful operations and milestones
**Hook Type**: Stop
**Triggers**: Security fixes, clean scans, test passes, commits

#### smart-suggestions.sh

**Purpose**: Provides intelligent workflow suggestions based on file modifications
**Hook Type**: Integrated with PostToolUse hooks
**Features**: Context-aware suggestions, pattern matching, rate limiting
**Examples**: Security files → `/prefix:secure . --quick`, Tests → `/prefix:understand . --test-coverage`

#### system-notification.sh

**Purpose**: macOS system notifications for important events  
**Hook Type**: PostToolUse  
**Covers**: Security, builds, tests, deployments, errors

### Workflow Hooks

#### markdown-format.sh

**Purpose**: Auto-formats Markdown files after edits  
**Hook Type**: PostToolUse  
**Features**: Uses markdownlint-cli2 with configurable rules, silent operation

#### command-chain-notification.sh

**Purpose**: Tracks progress through command chains  
**Hook Type**: PostToolUse  
**Features**: Phase sounds, progress notifications, error alerts

#### session-logger.sh

**Purpose**: Logs sessions with metrics and summaries  
**Hook Types**: SessionStart, Stop  
**Output**: JSON logs, session summaries, duration tracking

## Installation

Hooks are installed by the main `install.sh` script:

1. Scripts are copied to `~/.claude/claude-code-toolkit/hooks/`
2. Settings template is optionally installed to `~/.claude/settings.json`
3. Existing settings are preserved during installation

## Smart Suggestions System

### Overview

The Smart Suggestions system provides intelligent workflow recommendations based on file modifications. It analyzes file patterns and suggests relevant toolkit commands to help users learn the 6-command architecture.

### Features

- **Context-Aware**: Suggestions based on file types and modification patterns
- **Rate Limited**: 30-second cooldown prevents suggestion spam
- **Customizable**: JSON configuration allows pattern and suggestion customization
- **Non-Invasive**: Integrates seamlessly with existing hooks

### File Pattern Categories

- **Security**: `*auth*`, `*login*`, `*password*`, `*crypto*`, etc. → `/prefix:secure . --quick`
- **Tests**: `*test*`, `*.test.*`, `*spec*` → `/prefix:understand . --test-coverage`
- **Dependencies**: `package.json`, `requirements.txt` → `/prefix:secure . --dependencies`
- **Infrastructure**: `*.yml`, `Dockerfile`, `.env*` → `/prefix:secure . --infrastructure`
- **Documentation**: `*.md`, `README*` → `/prefix:create docs --sync`
- **Database**: `*migration*`, `*schema*`, `*.sql` → `/prefix:secure . --data-security`
- **API**: `*api*`, `*endpoint*`, `*route*` → `/prefix:secure . --api-security`
- **Frontend**: `*.js`, `*.ts`, `*.html`, `*.css` → `/prefix:secure . --frontend`

### Configuration

Customize suggestions in `~/.claude/claude-code-toolkit/hooks/config/suggestions-config.json`:

```json
{
  "enabled": true,
  "verbosity": "normal",
  "cooldown_seconds": 30,
  "max_suggestions": 2,
  "file_patterns": {
    "security": {
      "patterns": ["*auth*", "*login*"],
      "suggestions": ["💡 Security code modified. Consider: /prefix:secure . --quick"]
    }
  }
}
```

## Hook Types Supported

Claude Code supports these hook types:

- **Stop**: Runs when main agent finishes responding (implemented)
- **SubagentStop**: Runs when subagent finishes
- **PreToolUse**: Before tool calls
- **PostToolUse**: After tool completion (Smart Suggestions integrated here)
- **Notification**: For permission requests
- **UserPromptSubmit**: When user submits prompt
- **PreCompact**: Before context compaction
- **SessionStart**: At session start (requires matcher: startup/resume/clear)

## SessionStart Hook Configuration

The SessionStart hook requires a `matcher` property to specify when it should run:

```json
"SessionStart": [
  {
    "matcher": "startup",  // When Claude Code initially starts
    "hooks": [...]
  },
  {
    "matcher": "resume",   // When using --resume, --continue, or /resume
    "hooks": [...]
  },
  {
    "matcher": "clear",    // When using /clear command
    "hooks": [...]
  }
]
```

This is useful for:

- Loading development context at startup
- Restoring state when resuming sessions
- Cleaning up when clearing sessions

## Adding New Hooks

To add a new hook script:

1. Create script in `hooks/` directory
2. Make it executable: `chmod +x hooks/script-name.sh`
3. Follow these patterns:
   - Read JSON input from stdin
   - Check for relevant flags (e.g., `stop_hook_active`)
   - Fail silently on errors
   - Always exit with code 0
   - Run long operations in background

## Testing Hooks

Test hooks locally before installation:

```bash
# Test stop notification
echo '{"stop_hook_active": false}' | ./hooks/stop-notification.sh

# Test markdown formatting
echo '{"tool": "Write", "file_path": "test.md"}' | ./hooks/markdown-format.sh

# Verify sound plays
afplay -v 0.5 /System/Library/Sounds/Glass.aiff
```

## Markdown Formatting Hook

The `markdown-format.sh` hook automatically formats Markdown files after edits.

### Requirements

- **Recommended**: Install via Homebrew for best performance

  ```bash
  brew install markdownlint-cli2
  ```

- **Alternative**: Uses npx as fallback (slower but no installation needed)

### Configuration Priority

The hook intelligently selects the configuration file:

1. **Project-specific config** (highest priority)
   - Searches up from the file's directory for any of:
     - `.markdownlint-cli2.{jsonc,json,yaml,yml,cjs,mjs}`
     - `.markdownlint.{jsonc,json,yaml,yml}`
   - Uses the first config found in the directory tree

2. **Toolkit default config** (fallback)
   - Uses `~/.claude/claude-code-toolkit/markdown/.markdownlint-cli2.jsonc`
   - Applied when no project config exists
   - Contains sensible defaults for technical documentation

3. **markdownlint-cli2 defaults** (if no config found)

### Customizing for Your Project

To override the default configuration for a specific project:

1. Create a `.markdownlint-cli2.jsonc` file in your project root
2. Define your preferred rules
3. The hook will automatically use your project's config

### Features

- Runs automatically after Write/Edit/MultiEdit tools
- Silent operation (doesn't interrupt workflow)
- Smart config selection (project → toolkit → default)
- Supports both global and local installation

## Available System Sounds (macOS)

The following sounds are available in `/System/Library/Sounds/`:

- Glass.aiff (default)
- Ping.aiff
- Pop.aiff
- Purr.aiff
- Blow.aiff
- Bottle.aiff
- Frog.aiff
- Funk.aiff
- Hero.aiff
- Morse.aiff
- Submarine.aiff
- Tink.aiff

## Troubleshooting

**No sound playing:**

- Check if `afplay` is available: `which afplay`
- Verify sound file exists: `ls /System/Library/Sounds/`
- Check system volume settings
- Review Claude Code logs for hook errors

**Hook not triggering:**

- Verify settings.json configuration
- Check hook script is executable
- Ensure correct installation path
- Look for `stop_hook_active` flag in input

## Best Practices

1. **Silent Failures**: Always exit 0 to avoid disrupting Claude Code
2. **Background Operations**: Use `&` for long-running commands
3. **Input Validation**: Check JSON flags to prevent loops
4. **Resource Usage**: Keep hooks lightweight and fast
5. **Cross-Platform**: Consider platform compatibility when adding hooks
