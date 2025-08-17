#!/bin/bash

# Claude Code SubagentStop Hook - Agent-Specific Sound Notifications
# Plays different sounds based on which specialized agent completed
# This script is invoked by the SubagentStop hook in Claude Code

# Configuration
VOLUME="0.4"  # Slightly quieter than main notifications

# Sound mappings for different agents
declare -A AGENT_SOUNDS=(
    ["security-specialist"]="/System/Library/Sounds/Hero.aiff"         # Important security findings
    ["test-engineer"]="/System/Library/Sounds/Ping.aiff"              # Tests completed
    ["performance-optimizer"]="/System/Library/Sounds/Funk.aiff"      # Performance improved
    ["debugging-specialist"]="/System/Library/Sounds/Morse.aiff"      # Bug found/fixed
    ["code-architect"]="/System/Library/Sounds/Submarine.aiff"        # Architecture analysis
    ["frontend-specialist"]="/System/Library/Sounds/Pop.aiff"         # UI work done
    ["refactoring-expert"]="/System/Library/Sounds/Bottle.aiff"       # Code refactored
    ["deployment-specialist"]="/System/Library/Sounds/Blow.aiff"      # Deployment task
    ["ai-specialist"]="/System/Library/Sounds/Frog.aiff"              # AI/ML task
    ["workflow-optimizer"]="/System/Library/Sounds/Tink.aiff"         # Workflow improved
    ["report-analyzer"]="/System/Library/Sounds/Purr.aiff"            # Report analyzed
    ["documentation-health-specialist"]="/System/Library/Sounds/Glass.aiff"  # Docs updated
)

# TYPO3 specific agents
declare -A TYPO3_SOUNDS=(
    ["typo3-architect"]="/System/Library/Sounds/Submarine.aiff"
    ["typo3-extension-developer"]="/System/Library/Sounds/Pop.aiff"
    ["typo3-typoscript-expert"]="/System/Library/Sounds/Tink.aiff"
    ["typo3-content-blocks-specialist"]="/System/Library/Sounds/Bottle.aiff"
)

# Read JSON input from stdin (provided by Claude Code)
INPUT=$(cat)

# Check if stop_hook_active flag is set to prevent infinite loops
if echo "$INPUT" | grep -q '"stop_hook_active":true'; then
    exit 0
fi

# Extract subagent type from JSON input
# Look for subagent_type or agent_name in the JSON
AGENT_TYPE=$(echo "$INPUT" | grep -o '"subagent_type":"[^"]*"' | head -1 | cut -d'"' -f4)
if [ -z "$AGENT_TYPE" ]; then
    AGENT_TYPE=$(echo "$INPUT" | grep -o '"agent_name":"[^"]*"' | head -1 | cut -d'"' -f4)
fi

# Check if agent type was found
if [ -z "$AGENT_TYPE" ]; then
    # No agent type found, exit silently
    exit 0
fi

# Get sound file for this agent
SOUND_FILE="${AGENT_SOUNDS[$AGENT_TYPE]}"

# Check TYPO3 agents if not found
if [ -z "$SOUND_FILE" ]; then
    SOUND_FILE="${TYPO3_SOUNDS[$AGENT_TYPE]}"
fi

# If no specific sound mapped, use default based on agent category
if [ -z "$SOUND_FILE" ]; then
    case "$AGENT_TYPE" in
        *security*|*audit*)
            SOUND_FILE="/System/Library/Sounds/Hero.aiff"
            ;;
        *test*|*quality*)
            SOUND_FILE="/System/Library/Sounds/Ping.aiff"
            ;;
        *performance*|*optimize*)
            SOUND_FILE="/System/Library/Sounds/Funk.aiff"
            ;;
        *debug*|*fix*)
            SOUND_FILE="/System/Library/Sounds/Morse.aiff"
            ;;
        general-purpose)
            # Default for general-purpose agent
            SOUND_FILE="/System/Library/Sounds/Glass.aiff"
            ;;
        *)
            # No sound for unmapped agents
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

# Always exit successfully to avoid disrupting Claude Code
exit 0