#!/bin/bash

# Claude Code Universal Hook - System Notifications for Important Events
# Sends macOS native notifications for important events across all hooks
# Can be used with Stop, SubagentStop, PostToolUse, or any other hook

# Configuration
ENABLE_NOTIFICATIONS=true  # Master switch for notifications
MIN_TASK_DURATION=30      # Minimum seconds before showing completion notification

# Read JSON input from stdin
INPUT=$(cat)
TIMESTAMP=$(date '+%H:%M:%S')

# Function to send macOS notification with proper escaping
send_notification() {
    local title="$1"
    local message="$2"
    local subtitle="$3"
    local sound="${4:-default}"  # Use 'default' for system sound
    
    if [ "$ENABLE_NOTIFICATIONS" != "true" ]; then
        return
    fi
    
    if command -v osascript &> /dev/null; then
        # Escape quotes in messages
        title=$(echo "$title" | sed 's/"/\\"/g')
        message=$(echo "$message" | sed 's/"/\\"/g')
        subtitle=$(echo "$subtitle" | sed 's/"/\\"/g')
        
        if [ -n "$subtitle" ]; then
            osascript -e "display notification \"$message\" with title \"$title\" subtitle \"$subtitle\"" 2>/dev/null &
        else
            osascript -e "display notification \"$message\" with title \"$title\"" 2>/dev/null &
        fi
    fi
}

# Extract context information
HOOK_TYPE=$(echo "$INPUT" | grep -o '"hook_type":"[^"]*"' | cut -d'"' -f4)
TOOL_NAME=$(echo "$INPUT" | grep -o '"tool_name":"[^"]*"' | cut -d'"' -f4)
AGENT_TYPE=$(echo "$INPUT" | grep -o '"subagent_type":"[^"]*"' | cut -d'"' -f4)
COMMAND=$(echo "$INPUT" | grep -o '"command":"[^"]*"' | cut -d'"' -f4)

# Detect if this is a Stop hook
if echo "$INPUT" | grep -q '"stop_hook_active":true'; then
    exit 0  # Prevent loops
fi

# === CRITICAL SECURITY NOTIFICATIONS ===
if echo "$INPUT" | grep -qi "critical.*vulnerability\|CVE-.*critical\|security.*breach\|exposed.*credentials"; then
    send_notification \
        "🚨 Critical Security Alert" \
        "Immediate attention required" \
        "Found critical security vulnerabilities"
    exit 0
fi

# === LONG TASK COMPLETIONS ===
# Track task start time (would need persistent storage in real implementation)
# For now, detect completion of known long-running commands
if echo "$INPUT" | grep -qi "/scan:deep.*complete\|/auto:sprint.*finish\|/sec:audit.*done"; then
    send_notification \
        "✅ Task Complete" \
        "Long-running analysis finished" \
        "$TIMESTAMP"
    exit 0
fi

# === BUILD/TEST NOTIFICATIONS ===
if echo "$INPUT" | grep -qi "build.*failed\|compilation.*error"; then
    send_notification \
        "❌ Build Failed" \
        "Build process encountered errors" \
        "Check output for details"
    exit 0
fi

if echo "$INPUT" | grep -qi "all.*tests.*passed\|test.*suite.*success"; then
    TEST_COUNT=$(echo "$INPUT" | grep -o '[0-9]* tests' | head -1 | cut -d' ' -f1)
    send_notification \
        "✅ Tests Passed" \
        "${TEST_COUNT:-All} tests completed successfully" \
        "$TIMESTAMP"
    exit 0
fi

# === DEPLOYMENT NOTIFICATIONS ===
if echo "$INPUT" | grep -qi "deploy.*success\|deployment.*complete\|pushed.*to.*production"; then
    send_notification \
        "🚀 Deployment Successful" \
        "Code deployed to production" \
        "$TIMESTAMP"
    exit 0
fi

if echo "$INPUT" | grep -qi "deploy.*failed\|deployment.*error\|rollback.*initiated"; then
    send_notification \
        "⚠️ Deployment Failed" \
        "Deployment encountered issues" \
        "Manual intervention may be required"
    exit 0
fi

# === GIT OPERATIONS ===
if echo "$INPUT" | grep -qi "merge.*conflict\|rebase.*conflict"; then
    send_notification \
        "⚠️ Git Conflict" \
        "Merge conflicts need resolution" \
        "Manual intervention required"
    exit 0
fi

if echo "$INPUT" | grep -qi "pushed.*to.*remote\|pull.*request.*created\|PR.*opened"; then
    send_notification \
        "📤 Git Push Complete" \
        "Changes pushed successfully" \
        "$TIMESTAMP"
    exit 0
fi

# === PERFORMANCE ALERTS ===
if echo "$INPUT" | grep -qi "performance.*degraded\|slow.*query\|memory.*leak\|high.*cpu"; then
    send_notification \
        "⚠️ Performance Alert" \
        "Performance issues detected" \
        "Review performance metrics"
    exit 0
fi

# === AGENT COMPLETION SUMMARIES ===
if [ -n "$AGENT_TYPE" ] && [ "$AGENT_TYPE" != "general-purpose" ]; then
    case "$AGENT_TYPE" in
        security-specialist)
            if echo "$INPUT" | grep -qi "vulnerabilities.*found\|security.*issues"; then
                COUNT=$(echo "$INPUT" | grep -o '[0-9]* vulnerabilities' | head -1 | cut -d' ' -f1)
                send_notification \
                    "🔒 Security Analysis Complete" \
                    "${COUNT:-Security} issues found" \
                    "Review report for details"
            fi
            ;;
        performance-optimizer)
            if echo "$INPUT" | grep -qi "optimization.*complete\|performance.*improved"; then
                send_notification \
                    "⚡ Performance Optimized" \
                    "Code performance improvements applied" \
                    "$AGENT_TYPE completed"
            fi
            ;;
        debugging-specialist)
            if echo "$INPUT" | grep -qi "bug.*fixed\|issue.*resolved\|root.*cause.*found"; then
                send_notification \
                    "🐛 Bug Fixed" \
                    "Issue has been resolved" \
                    "$AGENT_TYPE analysis"
            fi
            ;;
    esac
fi

# === WORKFLOW MILESTONES ===
if echo "$INPUT" | grep -qi "milestone.*reached\|phase.*complete\|stage.*finished"; then
    PHASE=$(echo "$INPUT" | grep -o 'Phase [0-9]' | head -1)
    send_notification \
        "📍 Milestone Reached" \
        "${PHASE:-Workflow phase} completed" \
        "$TIMESTAMP"
    exit 0
fi

# === ERROR RECOVERY ===
if echo "$INPUT" | grep -qi "recovered.*from.*error\|retry.*successful\|fallback.*activated"; then
    send_notification \
        "♻️ Recovery Successful" \
        "System recovered from error" \
        "Operation continuing"
    exit 0
fi

# === DATABASE OPERATIONS ===
if echo "$INPUT" | grep -qi "migration.*complete\|database.*updated\|schema.*changed"; then
    send_notification \
        "🗄️ Database Updated" \
        "Database operations completed" \
        "$TIMESTAMP"
    exit 0
fi

# === QUOTA/LIMIT WARNINGS ===
if echo "$INPUT" | grep -qi "quota.*exceeded\|rate.*limit\|api.*limit\|usage.*warning"; then
    send_notification \
        "⚠️ Quota Warning" \
        "Resource limits approaching" \
        "Check usage metrics"
    exit 0
fi

# Always exit successfully
exit 0