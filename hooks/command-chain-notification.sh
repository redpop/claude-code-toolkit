#!/bin/bash

# Claude Code PostToolUse Hook - Command Chain Progress Notifications
# Tracks progress through command chains (meta:chain) and provides audio feedback
# Plays different sounds for each phase and final completion

# Configuration
VOLUME="0.4"  # Moderate volume for progress sounds

# Progress sounds (ascending tones for progression)
PHASE_SOUNDS=(
    "/System/Library/Sounds/Tink.aiff"      # Phase 1
    "/System/Library/Sounds/Pop.aiff"       # Phase 2  
    "/System/Library/Sounds/Ping.aiff"      # Phase 3
    "/System/Library/Sounds/Purr.aiff"      # Phase 4
    "/System/Library/Sounds/Blow.aiff"      # Phase 5
)
COMPLETE_SOUND="/System/Library/Sounds/Glass.aiff"  # Chain complete
ERROR_SOUND="/System/Library/Sounds/Basso.aiff"     # Chain error

# State file to track chain progress (in temp directory)
STATE_FILE="/tmp/claude_chain_state_$$"

# Read JSON input from stdin
INPUT=$(cat)

# Function to play sound
play_sound() {
    local sound_file="$1"
    local volume="${2:-$VOLUME}"
    
    if [ -f "$sound_file" ] && command -v afplay &> /dev/null; then
        afplay -v "$volume" "$sound_file" 2>/dev/null &
    fi
}

# Function to update chain state
update_state() {
    local phase="$1"
    local total="$2"
    echo "PHASE=$phase" > "$STATE_FILE"
    echo "TOTAL=$total" >> "$STATE_FILE"
    echo "TIME=$(date +%s)" >> "$STATE_FILE"
}

# Function to read chain state
read_state() {
    if [ -f "$STATE_FILE" ]; then
        source "$STATE_FILE"
        
        # Clean up old state files (older than 1 hour)
        local current_time=$(date +%s)
        local state_age=$((current_time - TIME))
        if [ "$state_age" -gt 3600 ]; then
            rm -f "$STATE_FILE"
            PHASE=0
            TOTAL=0
        fi
    else
        PHASE=0
        TOTAL=0
    fi
}

# Detect command chain execution
if echo "$INPUT" | grep -qi "/meta:chain\|command.*chain\|chain.*execution"; then
    
    # Check if this is chain initialization
    if echo "$INPUT" | grep -qi "starting.*chain\|initializing.*chain\|chain.*started"; then
        # Count total commands in chain
        TOTAL_COMMANDS=$(echo "$INPUT" | grep -o '->' | wc -l | tr -d ' ')
        TOTAL_COMMANDS=$((TOTAL_COMMANDS + 1))
        
        # Initialize state
        update_state 1 "$TOTAL_COMMANDS"
        
        # Play start sound
        play_sound "${PHASE_SOUNDS[0]}" "$VOLUME"
        
        # Send notification
        if command -v osascript &> /dev/null; then
            osascript -e "display notification \"Starting chain with $TOTAL_COMMANDS commands\" with title \"🔗 Command Chain Started\"" 2>/dev/null &
        fi
        exit 0
    fi
    
    # Check for phase completion
    if echo "$INPUT" | grep -qi "phase.*complete\|step.*complete\|command.*executed"; then
        # Read current state
        read_state
        
        # Increment phase
        PHASE=$((PHASE + 1))
        update_state "$PHASE" "$TOTAL"
        
        # Select appropriate sound
        if [ "$PHASE" -le "${#PHASE_SOUNDS[@]}" ]; then
            SOUND_INDEX=$((PHASE - 1))
            play_sound "${PHASE_SOUNDS[$SOUND_INDEX]}" "$VOLUME"
        else
            # Use cycling sounds for long chains
            SOUND_INDEX=$(( (PHASE - 1) % ${#PHASE_SOUNDS[@]} ))
            play_sound "${PHASE_SOUNDS[$SOUND_INDEX]}" "$VOLUME"
        fi
        
        # Show progress notification for milestones
        if [ "$TOTAL" -gt 0 ]; then
            PERCENT=$((PHASE * 100 / TOTAL))
            
            if [ "$PERCENT" -eq 25 ] || [ "$PERCENT" -eq 50 ] || [ "$PERCENT" -eq 75 ]; then
                if command -v osascript &> /dev/null; then
                    osascript -e "display notification \"$PHASE of $TOTAL commands complete ($PERCENT%)\" with title \"🔗 Chain Progress\"" 2>/dev/null &
                fi
            fi
        fi
        exit 0
    fi
    
    # Check for chain completion
    if echo "$INPUT" | grep -qi "chain.*complete\|all.*commands.*executed\|chain.*finished.*successfully"; then
        # Play completion sound
        play_sound "$COMPLETE_SOUND" "0.6"
        
        # Read final state
        read_state
        
        # Send completion notification
        if command -v osascript &> /dev/null; then
            osascript -e "display notification \"All $TOTAL commands executed successfully\" with title \"✅ Chain Complete\"" 2>/dev/null &
        fi
        
        # Clean up state file
        rm -f "$STATE_FILE"
        exit 0
    fi
    
    # Check for chain errors
    if echo "$INPUT" | grep -qi "chain.*failed\|chain.*error\|execution.*stopped"; then
        # Play error sound
        play_sound "$ERROR_SOUND" "0.6"
        
        # Read state to get failure point
        read_state
        
        # Send error notification
        if command -v osascript &> /dev/null; then
            osascript -e "display notification \"Chain failed at command $PHASE of $TOTAL\" with title \"❌ Chain Error\"" 2>/dev/null &
        fi
        
        # Clean up state file
        rm -f "$STATE_FILE"
        exit 0
    fi
fi

# Detect parallel execution markers
if echo "$INPUT" | grep -qi "parallel.*execution\|concurrent.*tasks\|\[.*,.*\].*executing"; then
    # Play a chord-like sound for parallel execution
    play_sound "/System/Library/Sounds/Submarine.aiff" "0.3"
    exit 0
fi

# Detect conditional execution
if echo "$INPUT" | grep -qi "condition.*met\|conditional.*execution\|?>.*executing"; then
    play_sound "/System/Library/Sounds/Bottle.aiff" "0.3"
    exit 0
fi

# Clean up old state files on any execution
find /tmp -name "claude_chain_state_*" -mmin +60 -delete 2>/dev/null

# Always exit successfully
exit 0