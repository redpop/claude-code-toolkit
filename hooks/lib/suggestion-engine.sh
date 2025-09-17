#!/bin/bash

# suggestion-engine.sh - Core library functions for smart suggestions system
# Part of Claude Code Toolkit - Smart Suggestions System

# Configuration paths (use environment variable if set, otherwise default)
SUGGESTIONS_CONFIG="${SUGGESTIONS_CONFIG:-${HOME}/.claude/claude-code-toolkit/hooks/config/suggestions-config.json}"
COOLDOWN_FILE="${COOLDOWN_FILE:-/tmp/claude-suggestions-cooldown}"

# Check if suggestions system is enabled
suggestions_enabled() {
    if [[ ! -f "$SUGGESTIONS_CONFIG" ]]; then
        return 1
    fi

    local enabled
    enabled=$(grep -o '"enabled"[[:space:]]*:[[:space:]]*[^,}]*' "$SUGGESTIONS_CONFIG" 2>/dev/null | sed 's/.*://; s/[[:space:]]*//g; s/[",]//g')
    [[ "$enabled" == "true" ]]
}

# Check cooldown period to prevent suggestion spam
check_cooldown() {
    if [[ ! -f "$COOLDOWN_FILE" ]]; then
        return 0  # No cooldown file, proceed
    fi

    local cooldown_seconds
    cooldown_seconds=$(grep -o '"cooldown_seconds"[[:space:]]*:[[:space:]]*[0-9]*' "$SUGGESTIONS_CONFIG" 2>/dev/null | sed 's/.*://; s/[[:space:]]//g')
    cooldown_seconds=${cooldown_seconds:-30}  # Default 30 seconds

    local last_suggestion
    if [[ -f "$COOLDOWN_FILE" ]]; then
        # Get file modification time as epoch seconds
        if date -r "$COOLDOWN_FILE" +%s >/dev/null 2>&1; then
            # macOS/BSD date command
            last_suggestion=$(date -r "$COOLDOWN_FILE" +%s)
        elif stat -c %Y "$COOLDOWN_FILE" >/dev/null 2>&1; then
            # Linux stat command
            last_suggestion=$(stat -c %Y "$COOLDOWN_FILE")
        else
            last_suggestion="0"
        fi
    else
        last_suggestion="0"
    fi
    local current_time
    current_time=$(date +%s)

    # Default to 0 if stat failed
    last_suggestion=${last_suggestion:-0}

    if [[ $((current_time - last_suggestion)) -ge cooldown_seconds ]]; then
        return 0  # Cooldown expired, proceed
    else
        return 1  # Still in cooldown period
    fi
}

# Update cooldown timestamp
update_cooldown() {
    touch "$COOLDOWN_FILE" 2>/dev/null || true
}

# Extract context from JSON input
extract_context() {
    local input="$1"

    # Extract tool_name
    TOOL_NAME=$(echo "$input" | grep -o '"tool_name"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*: *"//; s/".*//')

    # Extract file_path
    FILE_PATH=$(echo "$input" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*: *"//; s/".*//')

    # Basic validation
    if [[ -z "$TOOL_NAME" || -z "$FILE_PATH" ]]; then
        return 1
    fi

    return 0
}

# Match file pattern against configured patterns
match_file_pattern() {
    local file_path="$1"
    local pattern_category="$2"

    if [[ ! -f "$SUGGESTIONS_CONFIG" ]]; then
        return 1
    fi

    # Extract patterns for the category
    local patterns
    patterns=$(grep -A 20 "\"$pattern_category\"" "$SUGGESTIONS_CONFIG" | grep -A 10 '"patterns"' | grep -o '\["[^]]*"\]' | sed 's/\[//; s/\]//; s/"//g')

    if [[ -z "$patterns" ]]; then
        return 1
    fi

    # Check each pattern
    local IFS=','
    for pattern in $patterns; do
        pattern=$(echo "$pattern" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')
        if [[ "$file_path" == $pattern ]]; then
            return 0
        fi
    done

    return 1
}

# Get suggestions for a specific pattern category
get_suggestions_for_category() {
    local category="$1"

    if [[ ! -f "$SUGGESTIONS_CONFIG" ]]; then
        return 1
    fi

    # Extract suggestions array for the category
    local suggestions_section
    suggestions_section=$(grep -A 50 "\"$category\"" "$SUGGESTIONS_CONFIG" | grep -A 20 '"suggestions"' | sed -n '/\[/,/\]/p')

    if [[ -z "$suggestions_section" ]]; then
        return 1
    fi

    # Extract individual suggestions
    echo "$suggestions_section" | grep -o '"[^"]*💡[^"]*"' | sed 's/"//g'
}

# Generate suggestions for a file based on patterns
suggest_for_file() {
    local file_path="$1"
    local suggestions_found=0
    local max_suggestions
    max_suggestions=$(grep -o '"max_suggestions"[[:space:]]*:[[:space:]]*[0-9]*' "$SUGGESTIONS_CONFIG" 2>/dev/null | sed 's/.*://; s/[[:space:]]//g')
    max_suggestions=${max_suggestions:-2}

    # Categories to check in order
    local categories=("security" "tests" "dependencies" "infrastructure" "documentation")

    for category in "${categories[@]}"; do
        if [[ $suggestions_found -ge $max_suggestions ]]; then
            break
        fi

        if match_file_pattern "$file_path" "$category"; then
            local suggestions
            suggestions=$(get_suggestions_for_category "$category")
            if [[ -n "$suggestions" ]]; then
                echo "$suggestions" | head -n $((max_suggestions - suggestions_found))
                suggestions_found=$((suggestions_found + $(echo "$suggestions" | wc -l)))
            fi
        fi
    done
}

# Get contextual suggestions based on tool and context
get_contextual_suggestions() {
    local tool_name="$1"
    local file_path="$2"

    # Check for error patterns in file path or tool context
    if [[ "$file_path" == *"error"* ]] || [[ "$file_path" == *"bug"* ]] || [[ "$file_path" == *"fix"* ]]; then
        echo "💡 Error-related changes detected. Consider: /prefix:improve . --fix-issues"
        return 0
    fi

    # Check for large change indicators (multiple files, batch operations)
    if [[ "$tool_name" == "MultiEdit" ]]; then
        echo "💡 Multiple changes detected. Consider: /prefix:understand . --impact-analysis"
        return 0
    fi

    return 1
}

# Main suggestion logic
generate_suggestions() {
    local input="$1"

    # Check if system is enabled
    if ! suggestions_enabled; then
        return 0
    fi

    # Check cooldown
    if ! check_cooldown; then
        return 0
    fi

    # Extract context from input
    if ! extract_context "$input"; then
        return 1
    fi

    # Generate file-based suggestions
    local file_suggestions
    file_suggestions=$(suggest_for_file "$FILE_PATH")

    # Generate contextual suggestions
    local contextual_suggestions
    contextual_suggestions=$(get_contextual_suggestions "$TOOL_NAME" "$FILE_PATH")

    # Output suggestions if any were found
    if [[ -n "$file_suggestions" || -n "$contextual_suggestions" ]]; then
        # Update cooldown to prevent spam
        update_cooldown

        # Output suggestions to stderr (so they appear to user but don't interfere with tool output)
        {
            if [[ -n "$file_suggestions" ]]; then
                echo "$file_suggestions"
            fi
            if [[ -n "$contextual_suggestions" ]]; then
                echo "$contextual_suggestions"
            fi
        } >&2

        return 0
    fi

    return 1
}

# Utility function to validate JSON structure
validate_json_input() {
    local input="$1"

    # Basic JSON structure validation
    if [[ "$input" == *"tool_name"* && "$input" == *"file_path"* ]]; then
        return 0
    fi

    return 1
}

# Debug function to log suggestions (if debug mode is enabled)
debug_log() {
    local message="$1"
    local verbosity
    verbosity=$(grep -o '"verbosity"[[:space:]]*:[[:space:]]*"[^"]*"' "$SUGGESTIONS_CONFIG" 2>/dev/null | sed 's/.*"//; s/"//')

    if [[ "$verbosity" == "debug" ]]; then
        echo "[SUGGESTIONS DEBUG] $message" >&2
    fi
}

# Function to check if a specific suggestion type is enabled
suggestion_type_enabled() {
    local suggestion_type="$1"

    # For now, all suggestion types are enabled if the system is enabled
    # This can be extended later for more granular control
    suggestions_enabled
}