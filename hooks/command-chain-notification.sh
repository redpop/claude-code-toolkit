#!/bin/bash

# Command Chain Notification - Progress tracking for command chains
# Provides audio feedback and progress notifications for command sequences
# Tracks command chains and plays ascending tones for progress indication

# Configuration
LOG_DIR="$HOME/.claude/claude-code-toolkit/logs"
CHAIN_STATE_FILE="$LOG_DIR/command-chain-state.json"
VOLUME="0.4"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Sound progression for command chains (ascending tones)
declare -A CHAIN_SOUNDS=(
    [1]="/System/Library/Sounds/Tink.aiff"      # First command in chain
    [2]="/System/Library/Sounds/Pop.aiff"       # Second command
    [3]="/System/Library/Sounds/Ping.aiff"      # Third command
    [4]="/System/Library/Sounds/Purr.aiff"      # Fourth command
    [5]="/System/Library/Sounds/Hero.aiff"      # Fifth command (achievement)
)

# Command chain patterns to recognize
declare -A CHAIN_PATTERNS=(
    ["understand-improve"]="Analysis→Improvement"
    ["understand-create"]="Analysis→Creation"
    ["understand-secure"]="Analysis→Security"
    ["improve-ship"]="Improvement→Deployment"
    ["secure-ship"]="Security→Deployment"
    ["understand-improve-ship"]="Full Development Cycle"
    ["understand-secure-ship"]="Security-First Deployment"
)

# Read JSON input from stdin
INPUT=$(cat)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
UNIX_TIME=$(date +%s)

# Extract tool information
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // "unknown"' 2>/dev/null)
COMMAND_NAME=""

# Try to extract command name from various sources
if echo "$INPUT" | jq -r '.command_name // empty' 2>/dev/null | grep -q .; then
    COMMAND_NAME=$(echo "$INPUT" | jq -r '.command_name')
elif echo "$INPUT" | jq -r '.command // empty' 2>/dev/null | grep -q .; then
    COMMAND_NAME=$(echo "$INPUT" | jq -r '.command')
elif echo "$INPUT" | jq -r '.content // empty' 2>/dev/null | grep -q "/"; then
    # Extract command from content if it looks like a slash command
    COMMAND_NAME=$(echo "$INPUT" | jq -r '.content' | grep -o '/[a-zA-Z0-9:_-]*' | head -1 | sed 's|^/[^:]*:||')
fi

# Skip if no command name found or not a toolkit command
if [ -z "$COMMAND_NAME" ] || ! echo "$COMMAND_NAME" | grep -qE "(understand|improve|create|secure|ship|git)"; then
    exit 0
fi

# Skip if jq not available
if ! command -v jq &> /dev/null; then
    exit 0
fi

# Function to play sound
play_sound() {
    local sound_file="$1"
    if [ -f "$sound_file" ] && command -v afplay &> /dev/null; then
        afplay -v "$VOLUME" "$sound_file" 2>/dev/null &
    fi
}

# Initialize chain state if it doesn't exist
if [ ! -f "$CHAIN_STATE_FILE" ]; then
    echo '{"current_chain": [], "last_command_time": 0, "chain_count": 0}' > "$CHAIN_STATE_FILE"
fi

# Read current chain state
CURRENT_CHAIN=$(jq -r '.current_chain[]?' "$CHAIN_STATE_FILE" 2>/dev/null | tr '\n' '-' | sed 's/-$//')
LAST_COMMAND_TIME=$(jq -r '.last_command_time // 0' "$CHAIN_STATE_FILE" 2>/dev/null)
CHAIN_COUNT=$(jq -r '.chain_count // 0' "$CHAIN_STATE_FILE" 2>/dev/null)

# Check if this is part of a command chain (within 10 minutes of last command)
TIME_DIFF=$((UNIX_TIME - LAST_COMMAND_TIME))
if [ $TIME_DIFF -gt 600 ]; then
    # Reset chain if too much time has passed
    CURRENT_CHAIN=""
    CHAIN_COUNT=0
fi

# Update chain state
TEMP_FILE=$(mktemp)
if [ -n "$CURRENT_CHAIN" ]; then
    NEW_CHAIN="${CURRENT_CHAIN}-${COMMAND_NAME}"
    NEW_COUNT=$((CHAIN_COUNT + 1))
else
    NEW_CHAIN="$COMMAND_NAME"
    NEW_COUNT=1
fi

# Update state file
jq --arg chain "$NEW_CHAIN" \
   --arg command "$COMMAND_NAME" \
   --arg timestamp "$UNIX_TIME" \
   --arg count "$NEW_COUNT" \
   '
   .current_chain = ($chain | split("-")) |
   .last_command_time = ($timestamp | tonumber) |
   .chain_count = ($count | tonumber)
   ' "$CHAIN_STATE_FILE" > "$TEMP_FILE" && mv "$TEMP_FILE" "$CHAIN_STATE_FILE"

# Play appropriate sound based on position in chain
SOUND_FILE="${CHAIN_SOUNDS[$NEW_COUNT]}"
if [ -z "$SOUND_FILE" ]; then
    # For longer chains, cycle through the sounds
    SOUND_INDEX=$(((NEW_COUNT - 1) % 5 + 1))
    SOUND_FILE="${CHAIN_SOUNDS[$SOUND_INDEX]}"
fi

# Play the sound
play_sound "$SOUND_FILE"

# Check for recognized patterns
for pattern in "${!CHAIN_PATTERNS[@]}"; do
    if [ "$NEW_CHAIN" = "$pattern" ]; then
        echo "[$TIMESTAMP] 🎯 Completed chain: ${CHAIN_PATTERNS[$pattern]} ($NEW_CHAIN)" >> "$LOG_DIR/command-chains.log"

        # Play special completion sound for recognized patterns
        sleep 0.5  # Brief pause
        play_sound "/System/Library/Sounds/Glass.aiff" &
        break
    fi
done

# Log the command chain progress
{
    echo "[$TIMESTAMP] Command Chain Progress:"
    echo "  Command: $COMMAND_NAME"
    echo "  Chain: $NEW_CHAIN"
    echo "  Count: $NEW_COUNT"
    echo "  Tool: $TOOL_NAME"
    echo ""
} >> "$LOG_DIR/command-chains.log"

# Cleanup old logs (keep last 30 days)
find "$LOG_DIR" -name "command-chains.log" -mtime +30 -delete 2>/dev/null || true

# Clean up state if chain gets too long (prevent memory issues)
if [ "$NEW_COUNT" -gt 10 ]; then
    echo '{"current_chain": [], "last_command_time": 0, "chain_count": 0}' > "$CHAIN_STATE_FILE"
fi

exit 0