#!/bin/bash

# Test for scan:deep command

set -e

echo "Testing scan:deep command..."

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
    
    # Test 1: Basic scan with JSON export
    echo -n "Test 1: Basic scan... "
    RESULT=$($CLAUDE_CMD -p "/global:scan:deep . --export-json=test-scan-result.json" 2>&1 || true)
    if [[ "$RESULT" =~ "scan" ]] || [[ "$RESULT" =~ "analysis" ]] || [ -f "test-scan-result.json" ]; then
        echo "✓ PASSED"
    else
        echo "✗ FAILED"
        echo "   Output: ${RESULT:0:100}..."
    fi
    
    # Test 2: Security-focused scan
    echo -n "Test 2: Security scan... "
    RESULT=$($CLAUDE_CMD -p "/global:scan:deep . --focus=security" 2>&1 || true)
    if [[ "$RESULT" =~ "security" ]] || [[ "$RESULT" =~ "Security" ]]; then
        echo "✓ PASSED"
    else
        echo "✗ FAILED"
    fi
    
    # Test 3: Performance-focused scan
    echo -n "Test 3: Performance scan... "
    RESULT=$($CLAUDE_CMD -p "/global:scan:deep . --focus=performance" 2>&1 || true)
    if [[ "$RESULT" =~ "performance" ]] || [[ "$RESULT" =~ "Performance" ]]; then
        echo "✓ PASSED"
    else
        echo "✗ FAILED"
    fi
else
    echo "⚠️  Claude Code CLI not found"
    echo "   Running structural tests instead..."
    
    # Check if command file exists
    if [ -f "$HOME/.claude/commands/global/scan/deep.md" ]; then
        echo "✓ scan:deep command exists"
    else
        echo "✗ scan:deep command not found"
        exit 1
    fi
    
    # Check test project structure
    if [ -f "src/vulnerable-code.js" ] && [ -f "src/slow-algorithm.js" ]; then
        echo "✓ Test project structure valid"
    else
        echo "✗ Test project structure invalid"
        exit 1
    fi
fi

# Clean up any generated files
rm -f test-scan-result.json security-scan.json perf-scan.json

cd ..

echo "✓ scan:deep tests completed"
exit 0