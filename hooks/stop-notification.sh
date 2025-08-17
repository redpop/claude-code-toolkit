#!/bin/bash

# Claude Code Stop Hook - Sound Notification
# Plays a sound when Claude finishes responding
# This script is invoked by the Stop hook in Claude Code

# Configuration
SOUND_FILE="/System/Library/Sounds/Glass.aiff"
VOLUME="0.5"  # Volume level (0.0 to 1.0)

# Alternative sound files (macOS system sounds)
# Uncomment one to use a different sound:
# SOUND_FILE="/System/Library/Sounds/Ping.aiff"
# SOUND_FILE="/System/Library/Sounds/Pop.aiff"
# SOUND_FILE="/System/Library/Sounds/Purr.aiff"
# SOUND_FILE="/System/Library/Sounds/Blow.aiff"
# SOUND_FILE="/System/Library/Sounds/Bottle.aiff"
# SOUND_FILE="/System/Library/Sounds/Frog.aiff"
# SOUND_FILE="/System/Library/Sounds/Funk.aiff"
# SOUND_FILE="/System/Library/Sounds/Hero.aiff"
# SOUND_FILE="/System/Library/Sounds/Morse.aiff"
# SOUND_FILE="/System/Library/Sounds/Submarine.aiff"
# SOUND_FILE="/System/Library/Sounds/Tink.aiff"

# Read JSON input from stdin (provided by Claude Code)
INPUT=$(cat)

# Check if stop_hook_active flag is set to prevent infinite loops
if echo "$INPUT" | grep -q '"stop_hook_active":true'; then
    exit 0
fi

# Check if the sound file exists
if [ ! -f "$SOUND_FILE" ]; then
    # Silent failure - don't disrupt Claude Code workflow
    exit 0
fi

# Check if afplay is available
if ! command -v afplay &> /dev/null; then
    # Silent failure - afplay not available
    exit 0
fi

# Play the sound with specified volume
# Run in background to avoid blocking Claude Code
afplay -v "$VOLUME" "$SOUND_FILE" 2>/dev/null &

# Always exit successfully to avoid disrupting Claude Code
exit 0