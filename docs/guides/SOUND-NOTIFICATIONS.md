# Sound Notifications Guide

This guide explains how to set up and customize sound notifications for Claude Code using the Claude Code Toolkit's hook system.

## Overview

The Claude Code Toolkit includes a sound notification system that plays a pleasant chime when Claude finishes responding. This helps you stay productive by:

- Alerting you when long-running tasks complete
- Allowing you to multitask while waiting for responses
- Providing audio feedback for completed operations

## Quick Setup

### 1. Install with Hooks and Settings

```bash
# Clone the repository
git clone https://github.com/yourusername/claude-code-toolkit.git
cd claude-code-toolkit

# Install with hooks and auto-configure settings
./install.sh mytools --with-settings
```

This will:
- Install hooks to `~/.claude/claude-code-toolkit/hooks/`
- Configure `~/.claude/settings.json` with the Stop hook
- Activate sound notifications immediately

### 2. Install Hooks Only (Manual Configuration)

```bash
# Install without settings
./install.sh mytools

# Manually add to ~/.claude/settings.json:
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "~/.claude/claude-code-toolkit/hooks/stop-notification.sh"
          }
        ]
      }
    ]
  }
}
```

## Customization

### Changing the Sound

Edit `~/.claude/claude-code-toolkit/hooks/stop-notification.sh`:

```bash
# Default sound
SOUND_FILE="/System/Library/Sounds/Glass.aiff"

# Alternative options (uncomment one):
# SOUND_FILE="/System/Library/Sounds/Ping.aiff"     # Gentle ping
# SOUND_FILE="/System/Library/Sounds/Pop.aiff"      # Soft pop
# SOUND_FILE="/System/Library/Sounds/Purr.aiff"     # Cat purr
# SOUND_FILE="/System/Library/Sounds/Hero.aiff"     # Triumphant
# SOUND_FILE="/System/Library/Sounds/Submarine.aiff" # Deep tone
```

### Adjusting Volume

Change the `VOLUME` setting (0.0 to 1.0):

```bash
VOLUME="0.5"  # 50% volume (default)
# VOLUME="0.3"  # Quieter
# VOLUME="0.8"  # Louder
# VOLUME="1.0"  # Maximum
```

### Using Custom Sounds

You can use any audio file on your system:

```bash
# Custom sound file
SOUND_FILE="$HOME/Music/my-notification.mp3"
```

Supported formats: `.aiff`, `.mp3`, `.wav`, `.m4a`

## Available System Sounds (macOS)

All sounds are located in `/System/Library/Sounds/`:

| Sound | Description | Best For |
|-------|-------------|----------|
| Glass.aiff | Crystal chime (default) | General notifications |
| Ping.aiff | Gentle ping | Subtle alerts |
| Pop.aiff | Soft pop | Quick tasks |
| Purr.aiff | Cat purr | Relaxed feedback |
| Blow.aiff | Bottle blow | Medium alerts |
| Bottle.aiff | Bottle tap | Completion signals |
| Frog.aiff | Frog croak | Fun notifications |
| Funk.aiff | Funky beat | Upbeat alerts |
| Hero.aiff | Triumphant fanfare | Major completions |
| Morse.aiff | Morse code beep | Technical tasks |
| Submarine.aiff | Deep submarine ping | Serious alerts |
| Tink.aiff | Light tink | Minimal feedback |

## Advanced Configuration

### Conditional Notifications

Modify the script to play different sounds based on conditions:

```bash
# Example: Different sounds for different times of day
HOUR=$(date +%H)
if [ $HOUR -ge 22 ] || [ $HOUR -lt 6 ]; then
    # Quiet hours
    SOUND_FILE="/System/Library/Sounds/Tink.aiff"
    VOLUME="0.2"
else
    # Regular hours
    SOUND_FILE="/System/Library/Sounds/Glass.aiff"
    VOLUME="0.5"
fi
```

### Multiple Hooks

Add additional hooks for different events:

```json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "command",
        "command": "~/.claude/claude-code-toolkit/hooks/stop-notification.sh"
      }]
    }],
    "SubagentStop": [{
      "hooks": [{
        "type": "command",
        "command": "~/.claude/claude-code-toolkit/hooks/subagent-notification.sh"
      }]
    }]
  }
}
```

### Platform-Specific Setup

#### macOS
- `afplay` is pre-installed
- System sounds in `/System/Library/Sounds/`
- No additional setup required

#### Linux
- Install `sox`: `sudo apt-get install sox`
- Modify script to use `play` command:
  ```bash
  play -v "$VOLUME" "$SOUND_FILE" 2>/dev/null &
  ```

#### Windows (WSL)
- Use `powershell.exe` to play sounds:
  ```bash
  powershell.exe -c "(New-Object Media.SoundPlayer '$SOUND_FILE').PlaySync()" &
  ```

## Troubleshooting

### No Sound Playing

1. **Check volume settings:**
   ```bash
   # Test sound directly
   afplay -v 0.5 /System/Library/Sounds/Glass.aiff
   ```

2. **Verify hook is configured:**
   ```bash
   cat ~/.claude/settings.json | grep -A 5 "Stop"
   ```

3. **Check script permissions:**
   ```bash
   ls -la ~/.claude/claude-code-toolkit/hooks/stop-notification.sh
   # Should show executable permissions (x)
   ```

4. **Test script manually:**
   ```bash
   echo '{"stop_hook_active": false}' | ~/.claude/claude-code-toolkit/hooks/stop-notification.sh
   ```

### Hook Not Triggering

1. **Restart Claude Code** after modifying settings.json

2. **Check for syntax errors** in settings.json:
   ```bash
   python -m json.tool ~/.claude/settings.json > /dev/null
   ```

3. **Verify installation path** matches settings:
   ```bash
   ls ~/.claude/claude-code-toolkit/hooks/
   ```

### Sound Plays Multiple Times

This can happen if the Stop hook is configured multiple times. Check for duplicates in:
- `~/.claude/settings.json` (global)
- `.claude/settings.json` (project-specific)

## Best Practices

1. **Keep Volume Moderate**: Use 0.3-0.5 for regular work environments
2. **Choose Appropriate Sounds**: Match sound intensity to task importance
3. **Test Before Committing**: Always test changes to the script
4. **Silent Failures**: Script exits with code 0 to avoid disrupting Claude Code
5. **Background Execution**: Use `&` to prevent blocking

## Disabling Notifications

To temporarily disable notifications:

1. **Remove from settings:**
   ```bash
   # Comment out or remove the Stop hook section in settings.json
   ```

2. **Or rename the script:**
   ```bash
   mv ~/.claude/claude-code-toolkit/hooks/stop-notification.sh{,.disabled}
   ```

## Creating Custom Hooks

See [hooks/CLAUDE.md](../../hooks/CLAUDE.md) for detailed information on creating custom hooks for other Claude Code events.

## Support

For issues or suggestions:
- Check [hooks/CLAUDE.md](../../hooks/CLAUDE.md) for technical details
- Review the [troubleshooting section](#troubleshooting) above
- Open an issue in the GitHub repository