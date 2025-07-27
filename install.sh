#!/bin/bash

# Claude Code Toolkit Installation Script
# Usage: ./install.sh <prefix>
# Example: ./install.sh mytools
# 
# This script MUST be run from the cloned repository directory

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}→ $1${NC}"
}

# Check if we're running from inside the repository
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ ! -f "$SCRIPT_DIR/install.sh" ] || [ ! -d "$SCRIPT_DIR/commands" ] || [ ! -d "$SCRIPT_DIR/agents" ]; then
    print_error "This script must be run from inside the claude-code-toolkit repository."
    echo "Please clone the repository first:"
    echo "  git clone https://github.com/redpop/claude-code-toolkit.git"
    echo "  cd claude-code-toolkit"
    echo "  ./install.sh myprefix"
    exit 1
fi

# Default values
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"
CLAUDE_AGENTS_DIR="$HOME/.claude/agents"

# Check if prefix is provided
if [ -z "$1" ]; then
    print_error "No prefix provided. Usage: ./install.sh <prefix>"
    echo "Example: ./install.sh mytools"
    exit 1
fi

PREFIX="$1"
COMMANDS_INSTALL_PATH="$CLAUDE_COMMANDS_DIR/$PREFIX"

# Create Claude directories if they don't exist
if [ ! -d "$CLAUDE_COMMANDS_DIR" ]; then
    print_info "Creating Claude commands directory: $CLAUDE_COMMANDS_DIR"
    mkdir -p "$CLAUDE_COMMANDS_DIR"
fi

if [ ! -d "$CLAUDE_AGENTS_DIR" ]; then
    print_info "Creating Claude agents directory: $CLAUDE_AGENTS_DIR"
    mkdir -p "$CLAUDE_AGENTS_DIR"
fi

# Check if prefix directory already exists
if [ -d "$COMMANDS_INSTALL_PATH" ]; then
    echo -e "${YELLOW}Warning: Directory $COMMANDS_INSTALL_PATH already exists.${NC}"
    read -p "Replace existing installation? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        print_info "Backing up existing installation..."
        mv "$COMMANDS_INSTALL_PATH" "${COMMANDS_INSTALL_PATH}.backup.$(date +%Y%m%d_%H%M%S)"
        print_info "Old installation backed up"
    else
        print_info "Installation cancelled."
        exit 0
    fi
fi

# Copy commands
print_info "Installing commands to $COMMANDS_INSTALL_PATH..."
mkdir -p "$COMMANDS_INSTALL_PATH"
cp -r "$SCRIPT_DIR/commands/"* "$COMMANDS_INSTALL_PATH/" 2>/dev/null || true

# Copy agents
print_info "Installing agents to $CLAUDE_AGENTS_DIR..."
cp "$SCRIPT_DIR/agents/"*.md "$CLAUDE_AGENTS_DIR/" 2>/dev/null || true

print_success "Installation complete!"

# Display available commands
echo
echo "Available commands:"
echo

# List all command files
if [ -d "$COMMANDS_INSTALL_PATH" ]; then
    while IFS= read -r -d '' file; do
        # Get relative path from installation directory
        relative_path="${file#"$COMMANDS_INSTALL_PATH/"}"
        # Remove .md extension
        command_path="${relative_path%.md}"
        # Replace / with :
        command_name="${command_path//\//:}"
        echo "  /${PREFIX}:${command_name}"
    done < <(find "$COMMANDS_INSTALL_PATH" -name "*.md" -type f -print0 | sort -z)
fi

# List available agents
echo
echo "Available sub-agents:"
echo
if [ -d "$CLAUDE_AGENTS_DIR" ]; then
    for agent_file in "$CLAUDE_AGENTS_DIR"/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file" .md)
            echo "  - $agent_name"
        fi
    done
fi

echo
echo "To use these commands in Claude Code, type '/' followed by the command name."
echo
echo "To update in the future:"
echo "  1. Pull the latest changes in your cloned repository:"
echo "     cd $SCRIPT_DIR && git pull"
echo "  2. Re-run the installation:"
echo "     ./install.sh $PREFIX"
echo
print_success "Happy coding with Claude Code! 🚀"