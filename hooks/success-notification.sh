#!/bin/bash

# Claude Code Stop Hook - Success Detection for Commands
# Monitors for successful completion of specific commands and celebrates
# Particularly for security fixes, successful scans, and completed workflows

# Configuration
VOLUME="0.6"  # Celebratory volume

# Success sounds
HERO_SOUND="/System/Library/Sounds/Hero.aiff"        # Major success
GLASS_SOUND="/System/Library/Sounds/Glass.aiff"      # Standard success
FUNK_SOUND="/System/Library/Sounds/Funk.aiff"        # Fun success

# Read JSON input from stdin
INPUT=$(cat)

# Check if stop_hook_active flag is set
if echo "$INPUT" | grep -q '"stop_hook_active":true'; then
    exit 0
fi

# Function to play sound
play_sound() {
    local sound_file="$1"
    local volume="${2:-$VOLUME}"
    
    if [ -f "$sound_file" ] && command -v afplay &> /dev/null; then
        afplay -v "$volume" "$sound_file" 2>/dev/null &
    fi
}

# Function to send celebration notification
celebrate() {
    local title="$1"
    local message="$2"
    
    if command -v osascript &> /dev/null; then
        osascript -e "display notification \"$message\" with title \"$title\"" 2>/dev/null &
    fi
}

# Extract context from the conversation/output
CONTEXT=$(echo "$INPUT" | tr '\n' ' ')

# Check for successful security operations
if echo "$CONTEXT" | grep -qi "/fix:security.*complete\|security.*fixed\|vulnerability.*resolved"; then
    play_sound "$HERO_SOUND" "$VOLUME"
    celebrate "🛡️ Security Fixed!" "All security vulnerabilities have been resolved"
    exit 0
fi

# Check for successful deep scan without critical issues
if echo "$CONTEXT" | grep -qi "/scan:deep.*complete.*0.*critical\|scan.*complete.*no.*critical"; then
    play_sound "$GLASS_SOUND" "$VOLUME"
    celebrate "✅ Clean Scan" "Deep scan completed with no critical issues"
    exit 0
fi

# Check for successful test generation
if echo "$CONTEXT" | grep -qi "/gen:tests.*complete\|generated.*test.*files\|test.*coverage.*increased"; then
    play_sound "$FUNK_SOUND" "0.5"
    exit 0
fi

# Check for successful git commit
if echo "$CONTEXT" | grep -qi "/git:commit.*success\|commit.*created\|committed.*successfully"; then
    play_sound "$GLASS_SOUND" "0.4"
    
    # Special celebration for milestone commits
    if echo "$CONTEXT" | grep -qi "milestone\|release\|v[0-9]\|major.*feature"; then
        sleep 0.5
        play_sound "$HERO_SOUND" "0.5"
        celebrate "🎉 Milestone Commit!" "Important commit successfully created"
    fi
    exit 0
fi

# Check for successful refactoring
if echo "$CONTEXT" | grep -qi "/flow:refactor.*complete\|refactoring.*successful\|code.*improved"; then
    play_sound "$FUNK_SOUND" "0.5"
    exit 0
fi

# Check for successful auto execution
if echo "$CONTEXT" | grep -qi "/auto:execute.*complete\|action.*plan.*executed\|all.*tasks.*completed"; then
    play_sound "$HERO_SOUND" "0.5"
    celebrate "🚀 Automation Complete" "All automated tasks executed successfully"
    exit 0
fi

# Check for successful sprint completion
if echo "$CONTEXT" | grep -qi "/auto:sprint.*complete\|sprint.*finished\|quality.*improved"; then
    play_sound "$HERO_SOUND" "$VOLUME"
    celebrate "🏆 Sprint Complete!" "Quality improvement sprint finished successfully"
    exit 0
fi

# Check for successful performance improvements
if echo "$CONTEXT" | grep -qi "/fix:performance.*complete\|performance.*optimized\|speed.*improved"; then
    play_sound "$FUNK_SOUND" "$VOLUME"
    celebrate "⚡ Performance Boost!" "Performance optimizations applied successfully"
    exit 0
fi

# Check for successful documentation updates
if echo "$CONTEXT" | grep -qi "/gen:docs.*complete\|documentation.*updated\|docs.*generated"; then
    play_sound "$GLASS_SOUND" "0.4"
    exit 0
fi

# Check for successful dependency updates
if echo "$CONTEXT" | grep -qi "dependencies.*updated\|packages.*upgraded\|vulnerabilities.*patched"; then
    play_sound "$GLASS_SOUND" "0.5"
    exit 0
fi

# Check for workflow completion markers
if echo "$CONTEXT" | grep -qi "workflow.*complete\|pipeline.*success\|all.*steps.*passed"; then
    play_sound "$GLASS_SOUND" "$VOLUME"
    exit 0
fi

# Smart suggestions integration
if [ -f "$HOME/.claude/claude-code-toolkit/hooks/smart-suggestions.sh" ]; then
    echo "$INPUT" | "$HOME/.claude/claude-code-toolkit/hooks/smart-suggestions.sh" 2>&1 &
fi

# Always exit successfully
exit 0