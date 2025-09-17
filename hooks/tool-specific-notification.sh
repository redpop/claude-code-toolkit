#!/bin/bash

# Claude Code PostToolUse Hook - Tool-Specific Sound Notifications
# Plays different sounds based on which tool was used
# This script is invoked by the PostToolUse hook in Claude Code

# Configuration
VOLUME="0.5"  # Volume level (0.0 to 1.0)

# Sound mappings for different tools
declare -A TOOL_SOUNDS=(
    ["Write"]="/System/Library/Sounds/Pop.aiff"       # File created/written
    ["Edit"]="/System/Library/Sounds/Pop.aiff"        # File edited
    ["MultiEdit"]="/System/Library/Sounds/Pop.aiff"   # Multiple edits
    ["Bash"]="/System/Library/Sounds/Tink.aiff"       # Command executed
    ["Task"]="/System/Library/Sounds/Submarine.aiff"  # Agent started
    ["Read"]="/System/Library/Sounds/Purr.aiff"       # File read (quiet)
    ["Grep"]="/System/Library/Sounds/Ping.aiff"       # Search completed
    ["WebFetch"]="/System/Library/Sounds/Blow.aiff"   # Web content fetched
    ["WebSearch"]="/System/Library/Sounds/Blow.aiff"  # Web search completed
)

# Read JSON input from stdin (provided by Claude Code)
INPUT=$(cat)

# Extract tool name from JSON input
TOOL_NAME=$(echo "$INPUT" | grep -o '"tool_name":"[^"]*"' | head -1 | cut -d'"' -f4)

# Check if tool name was found
if [ -z "$TOOL_NAME" ]; then
    # No tool name found, exit silently
    exit 0
fi

# Get sound file for this tool
SOUND_FILE="${TOOL_SOUNDS[$TOOL_NAME]}"

# If no specific sound mapped, use default based on tool category
if [ -z "$SOUND_FILE" ]; then
    case "$TOOL_NAME" in
        *Edit*|*Write*|*Create*)
            SOUND_FILE="/System/Library/Sounds/Pop.aiff"
            ;;
        *Delete*|*Remove*)
            SOUND_FILE="/System/Library/Sounds/Bottle.aiff"
            ;;
        *Search*|*Find*|*Grep*)
            SOUND_FILE="/System/Library/Sounds/Ping.aiff"
            ;;
        *)
            # No sound for unmapped tools
            exit 0
            ;;
    esac
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

# Smart suggestions integration
if [ -f "$HOME/.claude/claude-code-toolkit/hooks/smart-suggestions.sh" ]; then
    echo "$INPUT" | "$HOME/.claude/claude-code-toolkit/hooks/smart-suggestions.sh" 2>&1 &
fi

# Always exit successfully to avoid disrupting Claude Code
exit 0