#!/bin/bash

# Session-End Summary - Intelligent session summaries with 
# Provides comprehensive session analysis with project insights and suggestions
# Integrates with MCP services for context preservation

# Configuration
LOG_DIR="$HOME/.claude/claude-code-toolkit/logs"
STATS_DIR="$HOME/.claude/claude-code-toolkit/stats"
SESSION_LOG="$LOG_DIR/sessions.log"
STATS_FILE="$STATS_DIR/command-stats.json"

# Create directories if they don't exist
mkdir -p "$LOG_DIR" "$STATS_DIR"

# Read JSON input from stdin
INPUT=$(cat)
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
DATE_KEY=$(date '+%Y-%m-%d')

# Skip if stop_hook_active is true (prevents loops)
if echo "$INPUT" | jq -r '.stop_hook_active // false' | grep -q "true"; then
  exit 0
fi

# Functions
get_session_duration() {
  local current_session_file="$LOG_DIR/current_session.json"
  if [ -f "$current_session_file" ]; then
    local start_time=$(jq -r '.start_time // 0' "$current_session_file")
    local current_time=$(date +%s)
    local duration=$((current_time - start_time))

    if [ $duration -gt 3600 ]; then
      echo "$((duration / 3600))h $((duration % 3600 / 60))min"
    elif [ $duration -gt 60 ]; then
      echo "$((duration / 60))min"
    else
      echo "${duration}s"
    fi
  else
    echo "Unknown"
  fi
}

get_project_info() {
  local pwd_info=$(pwd 2>/dev/null || echo "Unknown directory")
  local project_name=$(basename "$pwd_info" 2>/dev/null || echo "Unknown")
  echo "$project_name|$pwd_info"
}

get_git_status() {
  if git rev-parse --git-dir >/dev/null 2>&1; then
    local branch=$(git branch --show-current 2>/dev/null || echo "unknown")
    local status=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
    local recent_commit=$(git log -1 --oneline 2>/dev/null || echo "No commits")
    echo "Branch: $branch | Changes: $status | Recent: $recent_commit"
  else
    echo "Not a git repository"
  fi
}

get_command_stats() {
  if [ -f "$STATS_FILE" ] && command -v jq &> /dev/null; then
    jq -r --arg date "$DATE_KEY" '
    if .daily[$date] then
      .daily[$date] | to_entries | sort_by(.value.count) | reverse |
      limit(3; .[]) | "  • \(.key): \(.value.count)x"
    else
      "  No commands logged today"
    end
    ' "$STATS_FILE" 2>/dev/null
  else
    echo "  Statistics not available"
  fi
}

check_basic_memory() {
  # Check if MCP services is available
  local project_info=$(get_project_info)
  local project_name=$(echo "$project_info" | cut -d'|' -f1)

  # This would be enhanced with actual integration
  # For now, provide suggestions based on project detection
  if [ -f "README.md" ] || [ -f "package.json" ] || [ -f "Cargo.toml" ] || [ -f "requirements.txt" ]; then
    echo "💡 PROJECT DETECTED: Consider using to save session insights"
    echo "  Use memory://projects/$project_name for context continuation"
  else
    echo "🔍 Use to document current session insights"
  fi
}

generate_suggestions() {
  local git_status=$(get_git_status)

  echo "🎯 NEXT SESSION SUGGESTIONS:"
  echo "────────────────────────────────────"

  # Git-based suggestions
  if echo "$git_status" | grep -q "Changes: [1-9]"; then
    echo "  • Commit pending changes: git commit -am 'session progress'"
    echo "  • Review changes: /global:git status --detailed"
  fi

  # File-based suggestions
  if [ -f "package.json" ]; then
    echo "  • Check dependencies: /global:secure . --dependencies"
  fi

  if [ -f "Dockerfile" ] || [ -f "docker-compose.yml" ]; then
    echo "  • Security scan: /global:secure . --infrastructure"
  fi

  if find . -name "*.md" -newer "$(date -d '1 hour ago' '+%Y%m%d%H%M' 2>/dev/null || date -j -v-1H '+%Y%m%d%H%M')" 2>/dev/null | grep -q .; then
    echo "  • Update documentation: /global:create docs --sync"
  fi

  # General suggestions
  echo "  • Deep analysis: /global:understand . --comprehensive"
  echo "  • Apply improvements: /global:improve . --apply-insights"
  echo "  • Security review: /global:secure . --audit"
  echo "  • Ready to ship: /global:ship . --readiness-check"
}

# Generate session summary
{
  echo ""
  echo "═══════════════════════════════════════════════════════════════"
  echo "📊 SESSION SUMMARY - Claude Code Toolkit"
  echo "═══════════════════════════════════════════════════════════════"
  echo ""

  # Session info
  echo "⏱️ Duration: $(get_session_duration)"

  local project_info=$(get_project_info)
  local project_name=$(echo "$project_info" | cut -d'|' -f1)
  local project_path=$(echo "$project_info" | cut -d'|' -f2)
  echo "📂 Project: $project_name"
  echo "📍 Location: $project_path"
  echo ""

  # section
  echo "🧠 CONTEXT PRESERVATION:"
  echo "────────────────────────────────────"
  check_basic_memory
  echo ""

  # Command statistics
  echo "📈 SESSION COMMANDS:"
  echo "────────────────────────────────────"
  echo "Most used commands today:"
  get_command_stats
  echo ""

  # Git status
  echo "📋 GIT STATUS:"
  echo "────────────────────────────────────"
  echo "  $(get_git_status)"
  echo ""

  # Suggestions
  generate_suggestions
  echo ""

  # Footer
  echo "═══════════════════════════════════════════════════════════════"
  echo "💡 Tip: Use /global:meta:handoff to document context for others"
  echo "🔧 Manage hooks: ./scripts/manage-hooks.sh"
  echo "═══════════════════════════════════════════════════════════════"
  echo ""

} | tee -a "$SESSION_LOG"

# Update session end time if session file exists
current_session_file="$LOG_DIR/current_session.json"
if [ -f "$current_session_file" ]; then
  if command -v jq &> /dev/null; then
    temp_file=$(mktemp)
    jq --arg end_time "$(date +%s)" \
      --arg timestamp "$TIMESTAMP" \
      '.end_time = ($end_time | tonumber) | .end_timestamp = $timestamp' \
      "$current_session_file" > "$temp_file" && mv "$temp_file" "$current_session_file"
  fi
fi

exit 0