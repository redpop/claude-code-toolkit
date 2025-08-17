# Advanced Hooks Guide

This guide covers the advanced hook scripts available in the Claude Code Toolkit for enhanced notifications and monitoring.

## Overview

The toolkit now includes 7 specialized hook scripts that provide:

- **Context-aware sound notifications** based on tool usage and outcomes
- **macOS system notifications** for critical events
- **Session logging and metrics** tracking
- **Command chain progress** monitoring
- **Error detection and alerts**

## Available Hook Scripts

### 1. stop-notification.sh (Basic)

**Purpose**: Plays a sound when Claude finishes responding  
**Default Sound**: Glass.aiff  
**Hook Type**: Stop

### 2. tool-specific-notification.sh

**Purpose**: Different sounds for different tools  
**Hook Type**: PostToolUse

| Tool | Sound | Description |
|------|-------|-------------|
| Write/Edit | Pop.aiff | File modified |
| Bash | Tink.aiff | Command executed |
| Task | Submarine.aiff | Agent started |
| Read | Purr.aiff | File read (quiet) |
| Grep/Search | Ping.aiff | Search completed |
| WebFetch | Blow.aiff | Web content fetched |

### 3. subagent-notification.sh

**Purpose**: Agent-specific completion sounds  
**Hook Type**: SubagentStop

| Agent | Sound | Meaning |
|-------|-------|---------|
| security-specialist | Hero.aiff | Security findings |
| test-engineer | Ping.aiff | Tests completed |
| performance-optimizer | Funk.aiff | Performance improved |
| debugging-specialist | Morse.aiff | Bug found/fixed |
| code-architect | Submarine.aiff | Architecture analyzed |

### 4. error-detection.sh

**Purpose**: Monitors for critical errors and security issues  
**Hook Type**: PostToolUse  
**Features**:

- Loud alerts for critical security vulnerabilities
- Different sounds for error severity levels
- macOS notifications for critical issues
- Success sounds for clean security scans

### 5. success-notification.sh

**Purpose**: Celebrates successful operations  
**Hook Type**: Stop  
**Triggers**:

- Security vulnerabilities fixed
- Clean security scans
- Successful test runs
- Git commits (special sound for milestones)
- Sprint completions
- Performance improvements

### 6. system-notification.sh

**Purpose**: macOS system notifications for important events  
**Hook Type**: PostToolUse  
**Notifications for**:

- Critical security alerts
- Build failures
- Test results
- Deployment status
- Git conflicts
- Performance issues
- Database migrations
- Quota warnings

### 7. command-chain-notification.sh

**Purpose**: Tracks progress through command chains  
**Hook Type**: PostToolUse  
**Features**:

- Ascending tones for progression through phases
- Progress notifications at 25%, 50%, 75%
- Different sound for parallel execution
- Error sound if chain fails

### 8. session-logger.sh

**Purpose**: Logs session activity and provides summaries  
**Hook Types**: SessionStart, Stop  
**Features**:

- Tracks session duration
- Counts tools used, files modified, errors
- Creates JSON summaries for sessions > 5 minutes
- Sends notification for important sessions (> 30 min or many errors)
- Automatic log rotation

## Installation Options

### Option 1: Minimal (Default)

Just the basic Stop notification:

```bash
./install.sh myprefix --with-settings
```

Uses: `settings/global-settings.json`

### Option 2: Advanced (All Features)

All notification hooks enabled:

```bash
# Install hooks
./install.sh myprefix

# Manually copy advanced settings
cp settings/advanced-hooks-settings.json ~/.claude/settings.json
```

### Option 3: Custom Mix

Choose specific hooks:

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {"type": "command", "command": "~/.claude/claude-code-toolkit/hooks/stop-notification.sh"},
          {"type": "command", "command": "~/.claude/claude-code-toolkit/hooks/success-notification.sh"}
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "security|audit",
        "hooks": [
          {"type": "command", "command": "~/.claude/claude-code-toolkit/hooks/error-detection.sh"}
        ]
      }
    ]
  }
}
```

## Configuration Profiles

### 🔇 Silent Mode

No sounds, only critical notifications:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "critical|vulnerability|CVE",
        "hooks": [
          {"type": "command", "command": "~/.claude/claude-code-toolkit/hooks/system-notification.sh"}
        ]
      }
    ]
  }
}
```

### 🎵 Developer Mode

All sounds, optimized for active development:

```json
# Use settings/advanced-hooks-settings.json
```

### 🔔 Security Focus

Enhanced security monitoring:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "hooks": [
          {"type": "command", "command": "~/.claude/claude-code-toolkit/hooks/error-detection.sh"},
          {"type": "command", "command": "~/.claude/claude-code-toolkit/hooks/system-notification.sh"}
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {"type": "command", "command": "~/.claude/claude-code-toolkit/hooks/success-notification.sh"}
        ]
      }
    ]
  }
}
```

## Customization

### Changing Sounds

Edit any hook script to modify sounds:

```bash
# In any hook script:
SOUND_FILE="/System/Library/Sounds/YourChoice.aiff"
VOLUME="0.5"  # 0.0 to 1.0
```

### Disabling Specific Notifications

Comment out unwanted conditions in hook scripts:

```bash
# In error-detection.sh, disable test failure sounds:
# if echo "$TOOL_OUTPUT" | grep -qi "test.*failed"; then
#     play_sound "$ERROR_SOUND" "$WARNING_VOLUME"
# fi
```

### Adding Custom Patterns

Add your own detection patterns:

```bash
# In success-notification.sh:
if echo "$CONTEXT" | grep -qi "your.*pattern"; then
    play_sound "$CUSTOM_SOUND" "$VOLUME"
    celebrate "Your Title" "Your message"
fi
```

## Session Logs Location

Session logs are stored in:

```
~/.claude/claude-code-toolkit/logs/
├── sessions.log              # Main activity log
├── current_session.json      # Active session tracking
└── session_*_summary.json    # Completed session summaries
```

## Troubleshooting

### Too Many Notifications

- Use `minimal-hooks-settings.json` instead
- Reduce volume in individual scripts
- Remove hooks from PostToolUse

### No Notifications

- Check `~/.claude/settings.json` is configured
- Verify hooks are executable: `ls -la ~/.claude/claude-code-toolkit/hooks/`
- Test individually: `echo '{}' | ~/.claude/claude-code-toolkit/hooks/stop-notification.sh`

### System Notifications Not Appearing

- Check System Preferences > Notifications
- Ensure Terminal has notification permissions
- Test: `osascript -e 'display notification "Test" with title "Test"'`

### Session Logs Growing Large

- Logs auto-rotate at 10MB
- Old summaries deleted after 30 days
- Manually clean: `rm ~/.claude/claude-code-toolkit/logs/session_*_summary.json`

## Performance Impact

All hooks are designed to be lightweight:

- Sounds play in background (`&`)
- Scripts exit immediately (0-5ms)
- No blocking operations
- Silent failures don't disrupt Claude Code

## Platform Support

Currently optimized for **macOS**. For other platforms:

### Linux

Replace `afplay` with `paplay` or `aplay`:

```bash
# In hook scripts:
paplay "$SOUND_FILE" &  # PulseAudio
# or
aplay "$SOUND_FILE" &   # ALSA
```

### Windows (WSL)

Use PowerShell for sounds:

```bash
powershell.exe -c "(New-Object Media.SoundPlayer '$SOUND_FILE').PlaySync()" &
```

## Best Practices

1. **Start with minimal hooks** and add more as needed
2. **Keep volumes moderate** (0.3-0.5 for regular work)
3. **Use system notifications** sparingly (only critical events)
4. **Review session logs** weekly for insights
5. **Customize patterns** to match your workflow
6. **Test hooks** after modifications

## Hook Combinations

### Recommended Combinations

**For Regular Development**:

- stop-notification.sh
- success-notification.sh
- error-detection.sh (critical only)

**For Security Work**:

- All error-detection features
- system-notification.sh
- subagent-notification.sh (security-specialist)

**For Long Sessions**:

- session-logger.sh
- command-chain-notification.sh
- stop-notification.sh

**For Team Environments**:

- Minimal sounds (respect coworkers)
- System notifications for critical issues
- Session logging for metrics

## Future Enhancements

Potential additions:

- Slack/Discord notifications
- Time-based volume adjustment
- Custom sound packs
- Web dashboard for session metrics
- Integration with project management tools
