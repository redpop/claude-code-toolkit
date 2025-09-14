#!/bin/bash

# Enhanced Command Logger - Advanced command statistics tracking
# Tracks tool usage patterns, performance metrics, and generates insights
# Provides detailed analytics for development workflow optimization

# Configuration
LOG_DIR="$HOME/.claude/claude-code-toolkit/logs"
STATS_DIR="$HOME/.claude/claude-code-toolkit/stats"
STATS_FILE="$STATS_DIR/command-stats.json"
DETAILED_LOG="$LOG_DIR/enhanced-commands.log"

# Create directories if they don't exist
mkdir -p "$LOG_DIR" "$STATS_DIR"

# Read JSON input from stdin
INPUT=$(cat)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
UNIX_TIME=$(date +%s)
DATE_KEY=$(date '+%Y-%m-%d')

# Extract tool information
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // "unknown"')
FILE_PATH=$(echo "$INPUT" | jq -r '.file_path // ""')
EXECUTION_TIME=$(echo "$INPUT" | jq -r '.execution_time // 0')

# Skip if no jq available
if ! command -v jq &> /dev/null; then
    exit 0
fi

# Initialize stats file if it doesn't exist
if [ ! -f "$STATS_FILE" ]; then
    cat > "$STATS_FILE" << 'EOF'
{
  "total": {},
  "daily": {},
  "weekly": {},
  "patterns": {},
  "performance": {},
  "last_updated": ""
}
EOF
fi

# Update statistics
TEMP_FILE=$(mktemp)
jq --arg tool "$TOOL_NAME" \
   --arg date "$DATE_KEY" \
   --arg timestamp "$TIMESTAMP" \
   --arg unix_time "$UNIX_TIME" \
   --arg file_path "$FILE_PATH" \
   --arg exec_time "$EXECUTION_TIME" \
   '
   # Update total counts
   .total[$tool] = (.total[$tool] // {count: 0, total_time: 0}) |
   .total[$tool].count += 1 |
   .total[$tool].total_time += ($exec_time | tonumber) |

   # Update daily counts
   .daily[$date] = (.daily[$date] // {}) |
   .daily[$date][$tool] = (.daily[$date][$tool] // {count: 0, total_time: 0}) |
   .daily[$date][$tool].count += 1 |
   .daily[$date][$tool].total_time += ($exec_time | tonumber) |

   # Track file patterns
   if $file_path != "" then
     .patterns.file_extensions = (.patterns.file_extensions // {}) |
     (.patterns.file_extensions[($file_path | split(".") | last)] //= 0) |
     .patterns.file_extensions[($file_path | split(".") | last)] += 1
   end |

   # Update performance metrics
   .performance[$tool] = (.performance[$tool] // {min: 999999, max: 0, avg: 0, samples: 0}) |
   if ($exec_time | tonumber) > 0 then
     .performance[$tool].min = [.performance[$tool].min, ($exec_time | tonumber)] | min |
     .performance[$tool].max = [.performance[$tool].max, ($exec_time | tonumber)] | max |
     .performance[$tool].samples += 1 |
     .performance[$tool].avg = (.performance[$tool].total_time / .performance[$tool].samples)
   end |

   # Update timestamp
   .last_updated = $timestamp
   ' "$STATS_FILE" > "$TEMP_FILE" && mv "$TEMP_FILE" "$STATS_FILE"

# Detailed logging
{
    echo "[$TIMESTAMP] Tool: $TOOL_NAME"
    if [ -n "$FILE_PATH" ]; then
        echo "  File: $FILE_PATH"
    fi
    if [ "$EXECUTION_TIME" != "0" ]; then
        echo "  Time: ${EXECUTION_TIME}ms"
    fi
    echo "  Input: $INPUT"
    echo ""
} >> "$DETAILED_LOG"

# Cleanup old logs (keep last 30 days)
find "$LOG_DIR" -name "enhanced-commands.log" -mtime +30 -delete 2>/dev/null || true

# Clean up old daily stats (keep last 90 days)
if [ -f "$STATS_FILE" ]; then
    TEMP_FILE=$(mktemp)
    jq --arg cutoff_date "$(date -d '90 days ago' '+%Y-%m-%d' 2>/dev/null || date -j -v-90d '+%Y-%m-%d')" '
    .daily = (.daily | with_entries(select(.key >= $cutoff_date)))
    ' "$STATS_FILE" > "$TEMP_FILE" && mv "$TEMP_FILE" "$STATS_FILE" 2>/dev/null || true
fi

exit 0