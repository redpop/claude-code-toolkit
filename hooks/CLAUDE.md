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

#### system-notification.sh
**Purpose**: macOS system notifications for important events  
**Hook Type**: PostToolUse  
**Covers**: Security, builds, tests, deployments, errors

### Workflow Hooks

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

## Hook Types Supported

Claude Code supports these hook types:
- **Stop**: Runs when main agent finishes responding (implemented)
- **SubagentStop**: Runs when subagent finishes
- **PreToolUse**: Before tool calls
- **PostToolUse**: After tool completion
- **Notification**: For permission requests
- **UserPromptSubmit**: When user submits prompt
- **PreCompact**: Before context compaction
- **SessionStart**: At session start

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
# Test with sample input
echo '{"stop_hook_active": false}' | ./hooks/stop-notification.sh

# Verify sound plays
afplay -v 0.5 /System/Library/Sounds/Glass.aiff
```

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