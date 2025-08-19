# Hooks & Notifications

Configure hooks for automation and sound notifications in Claude Code.

## Quick Setup

### Install with Hooks

```bash
# Install with sound notifications
./install.sh myprefix --with-settings

# Choose profile during installation:
# 1. Basic - Essential hooks only
# 2. Minimal - Basic + sound notifications  
# 3. Advanced - Full automation suite
```

### Manual Setup

```bash
# Copy hook settings to Claude config
cp settings/hooks/*.json ~/.claude/settings/

# Or symlink for auto-updates
ln -sf "$(pwd)/settings/hooks/settings-minimal.json" ~/.claude/settings/settings.json
```

## Hook Profiles

### Basic Profile

Minimal hooks for essential feedback:

- User prompt submission validation
- Basic error handling

### Minimal Profile (Recommended)

Adds sound notifications:

- Success sounds for completed tasks
- Error alerts for failures
- Completion chimes

### Advanced Profile

Full automation suite:

- Git integration
- File modification tracking
- Performance monitoring
- Custom workflow triggers

## Sound Notifications

### Configuration

Edit `~/.claude/settings/settings.json`:

```json
{
  "hooks": {
    "postResponse": [
      {
        "command": "afplay /System/Library/Sounds/Glass.aiff",
        "platforms": ["darwin"],
        "description": "Success sound on macOS"
      },
      {
        "command": "paplay /usr/share/sounds/freedesktop/stereo/complete.oga",
        "platforms": ["linux"],
        "description": "Success sound on Linux"
      }
    ],
    "onError": [
      {
        "command": "afplay /System/Library/Sounds/Basso.aiff",
        "platforms": ["darwin"],
        "description": "Error sound"
      }
    ]
  }
}
```

### Available Sounds

#### macOS System Sounds

```bash
ls /System/Library/Sounds/*.aiff
# Glass.aiff - Success/completion
# Basso.aiff - Error/warning
# Hero.aiff - Major achievement
# Ping.aiff - Notification
```

#### Linux Sounds

```bash
ls /usr/share/sounds/freedesktop/stereo/*.oga
# complete.oga - Task completion
# bell.oga - Alert
# message.oga - Notification
```

## Advanced Hooks

### File Modification Tracking

```json
{
  "hooks": {
    "preFileEdit": [
      {
        "command": "git add -N '${FILE_PATH}' 2>/dev/null || true",
        "description": "Track new files in git"
      }
    ],
    "postFileEdit": [
      {
        "command": "echo '✓ Modified: ${FILE_PATH}'",
        "description": "Log modifications"
      }
    ]
  }
}
```

### Command Execution Hooks

```json
{
  "hooks": {
    "postToolUse": [
      {
        "when": {
          "tool": "Bash",
          "output_contains": "error"
        },
        "command": "afplay /System/Library/Sounds/Basso.aiff",
        "description": "Alert on bash errors"
      }
    ]
  }
}
```

### Workflow Automation

```json
{
  "hooks": {
    "postResponse": [
      {
        "when": {
          "response_contains": "test.*pass"
        },
        "command": "git commit -am 'Tests passing' && git push",
        "description": "Auto-commit on test success"
      }
    ]
  }
}
```

## Hook Variables

Available variables in hook commands:

| Variable | Description | Example |
|----------|-------------|---------|
| `${FILE_PATH}` | Modified file path | `/src/app.js` |
| `${TOOL_NAME}` | Tool that was used | `Bash`, `Edit` |
| `${EXIT_CODE}` | Command exit code | `0`, `1` |
| `${OUTPUT}` | Command output | Command stdout |
| `${ERROR}` | Error message | Error text |

## Conditional Execution

### Platform-Specific

```json
{
  "command": "say 'Task complete'",
  "platforms": ["darwin"],
  "description": "macOS text-to-speech"
}
```

### Output-Based

```json
{
  "when": {
    "output_contains": "success",
    "exit_code": 0
  },
  "command": "afplay success.aiff"
}
```

### Tool-Specific

```json
{
  "when": {
    "tool": "Write",
    "file_extension": ".test.js"
  },
  "command": "npm test ${FILE_PATH}"
}
```

## Troubleshooting

### Testing Hooks

```bash
# Test sound playback
afplay /System/Library/Sounds/Glass.aiff  # macOS
paplay /usr/share/sounds/freedesktop/stereo/complete.oga  # Linux

# Check hook configuration
cat ~/.claude/settings/settings.json | jq '.hooks'

# Debug hook execution
export CLAUDE_DEBUG_HOOKS=true
```

### Common Issues

| Issue | Solution |
|-------|----------|
| No sound | Check volume, test sound command directly |
| Hook not firing | Verify condition syntax, check debug logs |
| Command fails | Test command in terminal first |
| Wrong platform | Check `platforms` array matches your OS |

## Best Practices

1. **Start simple** - Use minimal profile initially
2. **Test commands** - Verify hooks work in terminal
3. **Use conditions** - Prevent excessive notifications
4. **Platform aware** - Include fallbacks for different OS
5. **Non-blocking** - Use `&` for long-running commands

## Examples

### Development Workflow

```json
{
  "hooks": {
    "postResponse": [
      {
        "when": {"response_contains": "fix.*applied"},
        "command": "npm test && afplay /System/Library/Sounds/Glass.aiff"
      }
    ]
  }
}
```

### CI Integration

```json
{
  "hooks": {
    "postToolUse": [
      {
        "when": {"tool": "Bash", "command_contains": "git push"},
        "command": "curl -X POST $CI_WEBHOOK_URL -d 'pushed=true'"
      }
    ]
  }
}
```

## Related Documentation

- [QUICK-START.md](QUICK-START.md) - Basic usage
- [AUTOMATED-WORKFLOW.md](AUTOMATED-WORKFLOW.md) - CI/CD hooks
- [TROUBLESHOOTING-FILE-MODIFICATIONS.md](TROUBLESHOOTING-FILE-MODIFICATIONS.md) - File tracking
