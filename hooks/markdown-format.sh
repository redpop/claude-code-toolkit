#!/bin/bash

# Markdown Auto-Format Hook for Claude Code
# Formats MD files after modifications using markdownlint-cli2
# This script is invoked by the PostToolUse hook in Claude Code

# Read JSON input from stdin (provided by Claude Code)
INPUT=$(cat)

# Extract tool name from JSON
TOOL_NAME=$(echo "$INPUT" | grep -oE '"tool":"[^"]*"' | cut -d'"' -f4)

# Only run for file modification tools
if [[ ! "$TOOL_NAME" =~ ^(Write|Edit|MultiEdit)$ ]]; then
    exit 0
fi

# Extract file path from JSON
FILE_PATH=$(echo "$INPUT" | grep -oE '"file_path":"[^"]*"' | cut -d'"' -f4)

# Only process Markdown files
if [[ ! "$FILE_PATH" =~ \.md$ ]]; then
    exit 0
fi

# Check if file exists (might have been deleted)
if [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

# Determine config file to use
# Priority: 1. Project-specific config, 2. Toolkit config, 3. Default
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

# If no project config found, use toolkit config
if [ "$CURRENT_DIR" = "/" ]; then
    TOOLKIT_CONFIG="$HOME/.claude/claude-code-toolkit/markdown/.markdownlint-cli2.jsonc"
    if [ -f "$TOOLKIT_CONFIG" ]; then
        CONFIG_ARGS="--config \"$TOOLKIT_CONFIG\""
    fi
fi

# Try to format the file using markdownlint-cli2
# First check for Homebrew installation (faster)
if command -v markdownlint-cli2 &> /dev/null; then
    # Run markdownlint-cli2 with fix option in background
    eval "markdownlint-cli2 --fix $CONFIG_ARGS \"$FILE_PATH\" 2>/dev/null &"
elif command -v npx &> /dev/null; then
    # Fallback to npx (slower but doesn't require installation)
    # -y flag automatically installs if needed
    eval "npx -y markdownlint-cli2 --fix $CONFIG_ARGS \"$FILE_PATH\" 2>/dev/null &"
fi

# Always exit successfully to avoid disrupting Claude Code
exit 0