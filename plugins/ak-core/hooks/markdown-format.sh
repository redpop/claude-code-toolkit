#!/bin/bash

# Markdown Auto-Format Hook for AgentKit
# Formats MD files after modifications using markdownlint-cli2
# This script is invoked by the PostToolUse hook in Claude Code

# Read JSON input from stdin (provided by Claude Code)
INPUT=$(cat)

# Extract tool name from JSON - Claude Code uses "tool_name" not "tool"
TOOL_NAME=$(echo "$INPUT" | grep -oE '"tool_name":"[^"]*"' | cut -d'"' -f4)

# Only run for file modification tools
if [[ ! "$TOOL_NAME" =~ ^(Write|Edit|MultiEdit)$ ]]; then
    exit 0
fi

# Extract file path from tool_input object
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; data = json.load(sys.stdin); print(data.get('tool_input', {}).get('file_path', ''))" 2>/dev/null)

# If that doesn't work, try the old way
if [ -z "$FILE_PATH" ]; then
    FILE_PATH=$(echo "$INPUT" | grep -oE '"file_path":"[^"]*"' | cut -d'"' -f4)
fi

# Only process Markdown files
if [[ ! "$FILE_PATH" =~ \.md$ ]]; then
    exit 0
fi

# Check if file exists (might have been deleted)
if [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

# Determine config file to use
# Priority: 1. Project-specific config, 2. Plugin config, 3. Default
CONFIG_ARGS=""
FILE_DIR=$(dirname "$FILE_PATH")

# Check for project-specific config files (search up the directory tree)
CURRENT_DIR="$FILE_DIR"
while [ "$CURRENT_DIR" != "/" ]; do
    if [ -f "$CURRENT_DIR/.markdownlint-cli2.jsonc" ] || \
       [ -f "$CURRENT_DIR/.markdownlint-cli2.json" ] || \
       [ -f "$CURRENT_DIR/.markdownlint-cli2.yaml" ] || \
       [ -f "$CURRENT_DIR/.markdownlint-cli2.yml" ] || \
       [ -f "$CURRENT_DIR/.markdownlint-cli2.cjs" ] || \
       [ -f "$CURRENT_DIR/.markdownlint-cli2.mjs" ] || \
       [ -f "$CURRENT_DIR/.markdownlint.jsonc" ] || \
       [ -f "$CURRENT_DIR/.markdownlint.json" ] || \
       [ -f "$CURRENT_DIR/.markdownlint.yaml" ] || \
       [ -f "$CURRENT_DIR/.markdownlint.yml" ]; then
        # Project has its own config, use it
        break
    fi
    CURRENT_DIR=$(dirname "$CURRENT_DIR")
done

# If no project config found, use plugin config
if [ "$CURRENT_DIR" = "/" ]; then
    # Resolve CLAUDE_PLUGIN_ROOT - the script's directory is inside the plugin
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    PLUGIN_CONFIG="$SCRIPT_DIR/config/.markdownlint-cli2.jsonc"
    if [ -f "$PLUGIN_CONFIG" ]; then
        CONFIG_ARGS="--config \"$PLUGIN_CONFIG\""
    fi
fi

# Try to format the file using markdownlint-cli2
# First check for Homebrew installation (faster)
if command -v markdownlint-cli2 &> /dev/null; then
    eval "markdownlint-cli2 --fix $CONFIG_ARGS \"$FILE_PATH\" 2>/dev/null"
elif command -v npx &> /dev/null; then
    # Fallback to npx (slower but doesn't require installation)
    eval "npx -y markdownlint-cli2 --fix $CONFIG_ARGS \"$FILE_PATH\" 2>/dev/null"
fi

# Always exit successfully to avoid disrupting Claude Code
exit 0
