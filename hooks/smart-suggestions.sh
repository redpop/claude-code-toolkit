#!/bin/bash

# smart-suggestions.sh - Main entry point for Claude Code Toolkit Smart Suggestions System
#
# This script processes input from Claude Code hooks and provides intelligent
# suggestions based on file modifications and context.
#
# Usage: echo '{"tool_name":"Edit","file_path":"auth.py"}' | ./smart-suggestions.sh
#
# Input: JSON from hook with tool_name, file_path, and optional context
# Output: Suggestions printed to stderr for user visibility

set -euo pipefail

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source the suggestion engine library
# shellcheck source=lib/suggestion-engine.sh
if [[ -f "$SCRIPT_DIR/lib/suggestion-engine.sh" ]]; then
    source "$SCRIPT_DIR/lib/suggestion-engine.sh"
else
    echo "Error: Cannot find suggestion engine library at $SCRIPT_DIR/lib/suggestion-engine.sh" >&2
    exit 1
fi

# Main function
main() {
    local input=""

    # Read input from stdin
    if [[ -p /dev/stdin ]]; then
        input=$(cat)
    else
        # If no piped input, check command line arguments
        if [[ $# -gt 0 ]]; then
            input="$1"
        else
            # No input provided
            debug_log "No input provided to smart-suggestions.sh"
            exit 0
        fi
    fi

    # Validate input is not empty
    if [[ -z "$input" ]]; then
        debug_log "Empty input received"
        exit 0
    fi

    # Validate JSON structure
    if ! validate_json_input "$input"; then
        debug_log "Invalid JSON input: $input"
        exit 0
    fi

    # Generate and output suggestions
    if generate_suggestions "$input"; then
        debug_log "Suggestions generated successfully"
    else
        debug_log "No suggestions generated for input: $input"
    fi
}

# Handle script execution
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Script is being executed directly
    main "$@"
else
    # Script is being sourced
    debug_log "smart-suggestions.sh sourced as library"
fi