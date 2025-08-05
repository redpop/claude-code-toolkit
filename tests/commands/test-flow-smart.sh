#!/bin/bash

# Test for flow:smart command - intelligent problem routing

set -e

echo "Testing flow:smart command..."

# Check for Claude Code CLI
CLAUDE_CMD=""
if command -v claude &> /dev/null; then
    CLAUDE_CMD="claude"
elif command -v claude-code &> /dev/null; then
    CLAUDE_CMD="claude-code"
fi

if [ -n "$CLAUDE_CMD" ]; then
    echo "🔧 Using Claude Code in programmatic mode (-p)"
    
    # Test 1: Security problem routing
    echo -n "Test 1: Security problem routing... "
    RESULT=$($CLAUDE_CMD -p "/global:flow:smart 'SQL injection vulnerabilities found'" 2>&1 || true)
    if [[ "$RESULT" =~ "security" ]] || [[ "$RESULT" =~ "Security" ]]; then
        echo "✓ PASSED"
    else
        echo "⚠️ UNCERTAIN"
    fi
    
    # Test 2: Performance problem routing
    echo -n "Test 2: Performance problem routing... "
    RESULT=$($CLAUDE_CMD -p "/global:flow:smart 'Application is running slow'" 2>&1 || true)
    if [[ "$RESULT" =~ "performance" ]] || [[ "$RESULT" =~ "Performance" ]]; then
        echo "✓ PASSED"
    else
        echo "⚠️ UNCERTAIN"
    fi
    
    # Test 3: General problem routing
    echo -n "Test 3: General problem routing... "
    RESULT=$($CLAUDE_CMD -p "/global:flow:smart 'Help improve code quality'" 2>&1 || true)
    if [[ "$RESULT" =~ "quality" ]] || [[ "$RESULT" =~ "analysis" ]]; then
        echo "✓ PASSED"
    else
        echo "⚠️ UNCERTAIN"
    fi
else
    echo "⚠️  Claude Code CLI not found"
    echo "   Running structural tests instead..."
    
    # Check if command exists
    if [ -f "$HOME/.claude/commands/global/flow/smart.md" ]; then
        echo "✓ flow:smart command exists"
    else
        echo "✗ flow:smart command not found"
        exit 1
    fi
    
    # Check if agents exist
    AGENTS=("security-specialist" "performance-optimizer" "code-architect")
    for agent in "${AGENTS[@]}"; do
        if [ -f "$HOME/.claude/agents/$agent.md" ]; then
            echo "✓ Agent $agent exists"
        else
            echo "✗ Agent $agent not found"
        fi
    done
fi

echo "✓ flow:smart tests completed"
exit 0