#!/bin/bash

# Claude Code PostToolUse Hook - Critical Error Detection
# Monitors tool outputs for critical errors and plays alert sounds
# Also sends macOS notifications for critical security issues

# Configuration
ALERT_VOLUME="0.8"  # Louder for critical alerts
WARNING_VOLUME="0.6"  # Medium for warnings
INFO_VOLUME="0.4"    # Quieter for info

# Sound files for different severity levels
CRITICAL_SOUND="/System/Library/Sounds/Sosumi.aiff"    # Loud alert
ERROR_SOUND="/System/Library/Sounds/Basso.aiff"        # Error tone
WARNING_SOUND="/System/Library/Sounds/Morse.aiff"      # Warning beep
SUCCESS_SOUND="/System/Library/Sounds/Glass.aiff"      # Success chime

# Read JSON input from stdin
INPUT=$(cat)

# Extract tool output or error messages
TOOL_OUTPUT=$(echo "$INPUT" | grep -o '"output":"[^"]*"' | cut -d'"' -f4)
TOOL_ERROR=$(echo "$INPUT" | grep -o '"error":"[^"]*"' | cut -d'"' -f4)
TOOL_NAME=$(echo "$INPUT" | grep -o '"tool_name":"[^"]*"' | cut -d'"' -f4)

# Function to send macOS notification
send_notification() {
    local title="$1"
    local message="$2"
    local sound="$3"
    
    if command -v osascript &> /dev/null; then
        osascript -e "display notification \"$message\" with title \"$title\" sound name \"$sound\"" 2>/dev/null &
    fi
}

# Function to play sound
play_sound() {
    local sound_file="$1"
    local volume="$2"
    
    if [ -f "$sound_file" ] && command -v afplay &> /dev/null; then
        afplay -v "$volume" "$sound_file" 2>/dev/null &
    fi
}

# Check for critical security issues
if echo "$TOOL_OUTPUT" | grep -qi "critical\|vulnerability\|CVE-\|security.*high\|exposed.*secret\|hardcoded.*password"; then
    # Critical security issue detected
    play_sound "$CRITICAL_SOUND" "$ALERT_VOLUME"
    
    # Count critical issues
    CRITICAL_COUNT=$(echo "$TOOL_OUTPUT" | grep -oic "critical")
    
    # Send system notification
    send_notification "⚠️ Critical Security Alert" \
        "Found $CRITICAL_COUNT critical security issue(s) in $TOOL_NAME output" \
        "Sosumi"
    
    exit 0
fi

# Check for test failures
if echo "$TOOL_OUTPUT" | grep -qi "test.*failed\|FAIL\|✗.*failed\|error.*test\|assertion.*failed"; then
    # Test failures detected
    play_sound "$ERROR_SOUND" "$WARNING_VOLUME"
    
    # Count failures
    FAIL_COUNT=$(echo "$TOOL_OUTPUT" | grep -oic "fail")
    
    if [ "$FAIL_COUNT" -gt 5 ]; then
        # Many failures - send notification
        send_notification "❌ Test Failures" \
            "$FAIL_COUNT test failures detected" \
            "Basso"
    fi
    
    exit 0
fi

# Check for general errors
if [ -n "$TOOL_ERROR" ] || echo "$TOOL_OUTPUT" | grep -qi "error\|exception\|fatal\|panic"; then
    # General error detected
    play_sound "$WARNING_SOUND" "$INFO_VOLUME"
    exit 0
fi

# Check for successful security scans
if [[ "$TOOL_NAME" == *"security"* ]] || [[ "$TOOL_NAME" == *"audit"* ]]; then
    if echo "$TOOL_OUTPUT" | grep -qi "no.*vulnerabilities\|clean\|passed.*security\|0.*critical"; then
        # Security scan passed
        play_sound "$SUCCESS_SOUND" "$INFO_VOLUME"
        
        # Optional: Send success notification for important scans
        if echo "$TOOL_OUTPUT" | grep -qi "security.*audit.*complete"; then
            send_notification "✅ Security Scan Clean" \
                "No critical vulnerabilities found" \
                "Glass"
        fi
    fi
fi

# Check for successful test runs
if echo "$TOOL_OUTPUT" | grep -qi "all.*tests.*pass\|✓.*passed\|test.*success\|100%.*pass"; then
    # All tests passed
    play_sound "$SUCCESS_SOUND" "$INFO_VOLUME"
    exit 0
fi

# Check for performance improvements
if echo "$TOOL_OUTPUT" | grep -qi "performance.*improved\|speed.*increase\|optimized\|faster by"; then
    # Performance improved
    play_sound "/System/Library/Sounds/Funk.aiff" "$INFO_VOLUME"
    exit 0
fi

# Smart suggestions integration
if [ -f "$HOME/.claude/claude-code-toolkit/hooks/smart-suggestions.sh" ]; then
    echo "$INPUT" | "$HOME/.claude/claude-code-toolkit/hooks/smart-suggestions.sh" 2>&1 &
fi

# Always exit successfully
exit 0