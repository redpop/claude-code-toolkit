#!/bin/bash

# Claude Code SessionStart/Stop Hook - Session Logger and Summary
# Logs session activity and provides summaries for important sessions
# Maintains a history of Claude Code sessions with metrics

# Configuration
LOG_DIR="$HOME/.claude/claude-code-toolkit/logs"
LOG_FILE="$LOG_DIR/sessions.log"
CURRENT_SESSION_FILE="$LOG_DIR/current_session.json"
ENABLE_SOUND=true
SESSION_START_SOUND="/System/Library/Sounds/Purr.aiff"
SESSION_END_SOUND="/System/Library/Sounds/Glass.aiff"
VOLUME="0.3"

# Create log directory if it doesn't exist
mkdir -p "$LOG_DIR"

# Read JSON input from stdin
INPUT=$(cat)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
UNIX_TIME=$(date +%s)

# Function to play sound
play_sound() {
    local sound_file="$1"
    if [ "$ENABLE_SOUND" = "true" ] && [ -f "$sound_file" ] && command -v afplay &> /dev/null; then
        afplay -v "$VOLUME" "$sound_file" 2>/dev/null &
    fi
}

# Function to log event
log_event() {
    local event_type="$1"
    local details="$2"
    echo "[$TIMESTAMP] $event_type: $details" >> "$LOG_FILE"
}

# Detect hook type
HOOK_TYPE="unknown"
if echo "$INPUT" | grep -q '"hook_type":"SessionStart"'; then
    HOOK_TYPE="SessionStart"
elif echo "$INPUT" | grep -q '"hook_type":"Stop"'; then
    HOOK_TYPE="Stop"
elif echo "$INPUT" | grep -q '"session_start":true'; then
    HOOK_TYPE="SessionStart"
fi

# Extract session information
PROJECT_DIR=$(echo "$INPUT" | grep -o '"project_dir":"[^"]*"' | cut -d'"' -f4)
if [ -z "$PROJECT_DIR" ]; then
    PROJECT_DIR=$(pwd)
fi
PROJECT_NAME=$(basename "$PROJECT_DIR")

# Handle SessionStart
if [ "$HOOK_TYPE" = "SessionStart" ]; then
    # Log session start
    log_event "SESSION_START" "Project: $PROJECT_NAME, Path: $PROJECT_DIR"
    
    # Create current session tracking file
    cat > "$CURRENT_SESSION_FILE" << EOF
{
  "start_time": $UNIX_TIME,
  "start_timestamp": "$TIMESTAMP",
  "project": "$PROJECT_NAME",
  "project_dir": "$PROJECT_DIR",
  "tools_used": [],
  "commands_executed": [],
  "files_modified": [],
  "errors_encountered": 0,
  "agents_invoked": []
}
EOF
    
    # Play session start sound
    play_sound "$SESSION_START_SOUND"
    
    # Optional: Send notification for new session
    if command -v osascript &> /dev/null && [ "$PROJECT_NAME" != "" ]; then
        osascript -e "display notification \"Working on: $PROJECT_NAME\" with title \"🚀 Claude Code Session Started\"" 2>/dev/null &
    fi
    
    exit 0
fi

# Handle Stop (session activity tracking)
if [ "$HOOK_TYPE" = "Stop" ] && [ -f "$CURRENT_SESSION_FILE" ]; then
    # Update session metrics
    
    # Extract activity information from input
    TOOL_USED=$(echo "$INPUT" | grep -o '"tool_name":"[^"]*"' | cut -d'"' -f4)
    COMMAND=$(echo "$INPUT" | grep -o '"command":"[^"]*"' | cut -d'"' -f4)
    FILE_PATH=$(echo "$INPUT" | grep -o '"file_path":"[^"]*"' | cut -d'"' -f4)
    ERROR=$(echo "$INPUT" | grep -o '"error":"[^"]*"' | cut -d'"' -f4)
    AGENT=$(echo "$INPUT" | grep -o '"subagent_type":"[^"]*"' | cut -d'"' -f4)
    
    # Update session file using temporary Python script for JSON manipulation
    if command -v python3 &> /dev/null; then
        python3 << EOF
import json
import sys

try:
    with open('$CURRENT_SESSION_FILE', 'r') as f:
        session = json.load(f)
    
    # Update metrics
    if '$TOOL_USED':
        if '$TOOL_USED' not in session['tools_used']:
            session['tools_used'].append('$TOOL_USED')
    
    if '$COMMAND' and '$COMMAND' not in session['commands_executed']:
        session['commands_executed'].append('$COMMAND')
    
    if '$FILE_PATH' and '$FILE_PATH' not in session['files_modified']:
        session['files_modified'].append('$FILE_PATH')
    
    if '$ERROR':
        session['errors_encountered'] += 1
    
    if '$AGENT' and '$AGENT' not in session['agents_invoked']:
        session['agents_invoked'].append('$AGENT')
    
    # Save updated session
    with open('$CURRENT_SESSION_FILE', 'w') as f:
        json.dump(session, f, indent=2)
        
except Exception as e:
    pass  # Silent failure
EOF
    fi
fi

# Detect session end patterns
if echo "$INPUT" | grep -qi "session.*end\|goodbye\|signing.*off\|task.*complete.*exiting"; then
    
    if [ -f "$CURRENT_SESSION_FILE" ]; then
        # Calculate session duration
        START_TIME=$(grep '"start_time":' "$CURRENT_SESSION_FILE" | grep -o '[0-9]*' | head -1)
        if [ -n "$START_TIME" ]; then
            DURATION=$((UNIX_TIME - START_TIME))
            DURATION_MIN=$((DURATION / 60))
            
            # Read session metrics
            TOOLS_COUNT=$(grep -o '"tools_used":' "$CURRENT_SESSION_FILE" | wc -l)
            FILES_COUNT=$(grep -o '"files_modified":' "$CURRENT_SESSION_FILE" | wc -l)
            ERRORS=$(grep '"errors_encountered":' "$CURRENT_SESSION_FILE" | grep -o '[0-9]*' | head -1)
            
            # Log session end with summary
            log_event "SESSION_END" "Duration: ${DURATION_MIN}min, Tools: $TOOLS_COUNT, Files: $FILES_COUNT, Errors: ${ERRORS:-0}"
            
            # For significant sessions (> 5 minutes), create detailed summary
            if [ "$DURATION_MIN" -gt 5 ]; then
                SUMMARY_FILE="$LOG_DIR/session_${UNIX_TIME}_summary.json"
                
                # Add end time to session data
                if command -v python3 &> /dev/null; then
                    python3 << EOF
import json
with open('$CURRENT_SESSION_FILE', 'r') as f:
    session = json.load(f)
session['end_time'] = $UNIX_TIME
session['end_timestamp'] = '$TIMESTAMP'
session['duration_seconds'] = $DURATION
session['duration_minutes'] = $DURATION_MIN

# Save as summary
with open('$SUMMARY_FILE', 'w') as f:
    json.dump(session, f, indent=2)
    
# Log important sessions
if $DURATION_MIN > 30 or session['errors_encountered'] > 5:
    print("IMPORTANT_SESSION")
EOF
                    
                    # Check if this was an important session
                    if [ "$?" = "0" ]; then
                        # Send notification for important sessions
                        if command -v osascript &> /dev/null; then
                            osascript -e "display notification \"Duration: ${DURATION_MIN}min, Files: $FILES_COUNT, Errors: ${ERRORS:-0}\" with title \"📊 Session Summary: $PROJECT_NAME\"" 2>/dev/null &
                        fi
                    fi
                fi
                
                log_event "SESSION_SUMMARY" "Saved to: $SUMMARY_FILE"
            fi
            
            # Play session end sound for long sessions
            if [ "$DURATION_MIN" -gt 2 ]; then
                play_sound "$SESSION_END_SOUND"
            fi
        fi
        
        # Archive current session file
        if [ -f "$CURRENT_SESSION_FILE" ]; then
            ARCHIVE_FILE="$LOG_DIR/archived_session_${UNIX_TIME}.json"
            mv "$CURRENT_SESSION_FILE" "$ARCHIVE_FILE"
        fi
    fi
fi

# Cleanup old session files (older than 30 days)
find "$LOG_DIR" -name "session_*_summary.json" -mtime +30 -delete 2>/dev/null
find "$LOG_DIR" -name "archived_session_*.json" -mtime +7 -delete 2>/dev/null

# Rotate main log file if it's too large (> 10MB)
if [ -f "$LOG_FILE" ]; then
    LOG_SIZE=$(stat -f%z "$LOG_FILE" 2>/dev/null || stat -c%s "$LOG_FILE" 2>/dev/null || echo "0")
    if [ "$LOG_SIZE" -gt 10485760 ]; then
        mv "$LOG_FILE" "${LOG_FILE}.${UNIX_TIME}"
        gzip "${LOG_FILE}.${UNIX_TIME}" 2>/dev/null &
        log_event "LOG_ROTATED" "Previous log archived"
    fi
fi

# Always exit successfully
exit 0