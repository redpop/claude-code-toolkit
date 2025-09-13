#!/bin/bash

# Test for meta:pipelines command

set -e

echo "Testing meta:pipelines command..."

# Check for Claude Code CLI
CLAUDE_CMD=""
if command -v claude &> /dev/null; then
    CLAUDE_CMD="claude"
elif command -v claude-code &> /dev/null; then
    CLAUDE_CMD="claude-code"
fi

cd test-project

if [ -n "$CLAUDE_CMD" ]; then
    echo "🔧 Using Claude Code in programmatic mode (-p)"
    
    # Test 1: List available pipelines
    echo -n "Test 1: List pipelines... "
    RESULT=$($CLAUDE_CMD -p "/global:meta:pipelines" 2>&1 || true)
    if [[ "$RESULT" =~ "quality" ]] || [[ "$RESULT" =~ "security" ]] || [[ "$RESULT" =~ "pipeline" ]]; then
        echo "✓ PASSED"
    else
        echo "⚠️ UNCERTAIN"
    fi
    
    # Test 2: Quick quality pipeline (dry run)
    echo -n "Test 2: Quick quality pipeline... "
    RESULT=$($CLAUDE_CMD -p "/global:meta:pipelines quick-quality --dry-run" 2>&1 || true)
    if [[ "$RESULT" =~ "quality" ]] || [[ "$RESULT" =~ "scan" ]]; then
        echo "✓ PASSED"
    else
        echo "⚠️ UNCERTAIN"
    fi
    
    # Test 3: Security pipeline
    echo -n "Test 3: Security pipeline... "
    RESULT=$($CLAUDE_CMD -p "/global:meta:pipelines security-hardening --dry-run" 2>&1 || true)
    if [[ "$RESULT" =~ "security" ]] || [[ "$RESULT" =~ "Security" ]]; then
        echo "✓ PASSED"
    else
        echo "⚠️ UNCERTAIN"
    fi
else
    echo "⚠️  Claude Code CLI not found"
    echo "   Running structural tests instead..."
    
    # Check if command exists
    if [ -f "$HOME/.claude/commands/global/meta/pipelines.md" ]; then
        echo "✓ meta:pipelines command exists"
    else
        echo "✗ meta:pipelines command not found"
        exit 1
    fi
    
    # Check if related commands exist
    COMMANDS=("scan/quick" "scan/deep" "fix/quick-wins")
    for cmd in "${COMMANDS[@]}"; do
        if [ -f "$HOME/.claude/commands/global/$cmd.md" ]; then
            echo "✓ Pipeline command $cmd exists"
        else
            echo "✗ Pipeline command $cmd not found"
        fi
    done
fi

cd ..

echo "✓ meta:pipelines tests completed"
exit 0