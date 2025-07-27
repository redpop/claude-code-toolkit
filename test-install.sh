#!/bin/bash

# Test script for the updated installation with agents support

set -e

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}Testing updated installation script...${NC}"
echo

# Test installation to a temporary directory
TEST_PREFIX="test-agents"
TEST_DIR="$HOME/.claude/commands/$TEST_PREFIX"

# Remove test directory if it exists
if [ -d "$TEST_DIR" ]; then
    echo -e "${YELLOW}Removing existing test installation...${NC}"
    rm -rf "$TEST_DIR"
fi

# Run installation from feature branch
echo -e "${GREEN}Installing from feature branch...${NC}"
export CLAUDE_COMMANDS_REPO_URL="https://github.com/redpop/claude-code-slash-commands.git"
bash install.sh "$TEST_PREFIX"

echo
echo -e "${GREEN}Installation complete. Checking results...${NC}"

# Check if agents were installed
if [ -d "$TEST_DIR" ]; then
    echo
    echo -e "${GREEN}✓ Installation directory created${NC}"
    
    # Check for agent files
    agent_count=$(find "$TEST_DIR" -name "*-specialist.md" -o -name "*-optimizer.md" -o -name "*-engineer.md" -o -name "*-architect.md" -o -name "*-expert.md" | wc -l)
    
    if [ "$agent_count" -gt 0 ]; then
        echo -e "${GREEN}✓ Found $agent_count agent files${NC}"
        echo
        echo "Agents installed:"
        find "$TEST_DIR" -name "*-specialist.md" -o -name "*-optimizer.md" -o -name "*-engineer.md" -o -name "*-architect.md" -o -name "*-expert.md" | while read -r file; do
            echo "  - $(basename "$file")"
        done
    else
        echo -e "${RED}✗ No agent files found${NC}"
    fi
    
    # Check for command files
    echo
    command_count=$(find "$TEST_DIR" -name "*.md" | grep -v -E "(-specialist|-optimizer|-engineer|-architect|-expert)\.md$" | wc -l)
    echo -e "${GREEN}✓ Found $command_count command files${NC}"
    
    # Check git configuration
    echo
    if [ -f "$TEST_DIR/.git/config" ]; then
        echo -e "${GREEN}✓ Git repository configured${NC}"
        
        # Check sparse-checkout configuration
        if [ -f "$TEST_DIR/.git/info/sparse-checkout" ]; then
            echo
            echo "Sparse-checkout configuration:"
            cat "$TEST_DIR/.git/info/sparse-checkout" | head -10
        fi
        
        # Check current branch
        echo
        cd "$TEST_DIR"
        current_branch=$(git branch --show-current)
        echo "Current branch: $current_branch"
        
        # Try to switch to feature branch
        if [ "$current_branch" != "feature/sub-agent-orchestration" ]; then
            echo
            echo -e "${YELLOW}Switching to feature/sub-agent-orchestration branch...${NC}"
            git fetch origin feature/sub-agent-orchestration
            git checkout feature/sub-agent-orchestration
            
            # Re-check for agents after branch switch
            echo
            echo -e "${YELLOW}Re-checking for agents after branch switch...${NC}"
            agent_count=$(find . -name "*-specialist.md" -o -name "*-optimizer.md" -o -name "*-engineer.md" -o -name "*-architect.md" -o -name "*-expert.md" | wc -l)
            if [ "$agent_count" -gt 0 ]; then
                echo -e "${GREEN}✓ Found $agent_count agent files after branch switch${NC}"
            else
                echo -e "${RED}✗ Still no agent files found${NC}"
            fi
        fi
    fi
else
    echo -e "${RED}✗ Installation directory not created${NC}"
fi

echo
echo -e "${GREEN}Test complete!${NC}"
echo
echo "To remove test installation:"
echo "  rm -rf $TEST_DIR"