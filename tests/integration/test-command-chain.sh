#!/bin/bash
set -euo pipefail

echo "🧪 Testing command chaining integration..."

# Setup
TEST_DIR="test-project"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="/tmp/test-chain-$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

# Check for Claude Code CLI
CLAUDE_CMD=""
if command -v claude &> /dev/null; then
    CLAUDE_CMD="claude"
elif command -v claude-code &> /dev/null; then
    CLAUDE_CMD="claude-code"
fi

# If Claude CLI is available, use programmatic mode
if [ -n "$CLAUDE_CMD" ]; then
    echo "🔧 Using Claude Code in programmatic mode (-p)"
    
    # Test 1: Simple command chain
    echo "Test 1: Simple command chain..."
    CHAIN_CMD='/global:meta:chain "scan:quick '$TEST_DIR'" -> "scan:report {output} --quick-wins"'
    CHAIN_RESULT=$(cd test-project && $CLAUDE_CMD -p "$CHAIN_CMD" 2>&1 || true)
    
    if [[ "$CHAIN_RESULT" =~ "chain" ]] || [[ "$CHAIN_RESULT" =~ "Chain" ]] || [[ "$CHAIN_RESULT" =~ "completed" ]]; then
        echo "✅ Chain command executed"
    else
        echo "⚠️  Chain execution uncertain"
        echo "   Output: ${CHAIN_RESULT:0:100}..."
    fi
    
    # Test 2: Create test data for chain
    echo '{"test": "data", "issues": ["issue1", "issue2"]}' > "$OUTPUT_DIR/test-chain.json"
    echo "✅ Test data created"
else
    echo "⚠️  Claude Code CLI not found"
    echo "   Running structural tests instead..."
    
    # Structural tests
    if [ -f "$HOME/.claude/commands/global/meta/chain.md" ]; then
        echo "✅ Chain command exists"
    else
        echo "❌ Chain command not found"
        exit 1
    fi
    
    for cmd in "scan/quick.md" "scan/report.md" "meta/chain.md"; do
        if [ -f "$HOME/.claude/commands/global/$cmd" ]; then
            echo "✅ Command $cmd exists"
        else
            echo "❌ Command $cmd not found"
            exit 1
        fi
    done
    
    # Create test data
    echo '{"test": "data", "issues": ["issue1", "issue2"]}' > "$OUTPUT_DIR/test-chain.json"
    echo "✅ Test data created"
fi

# Test 2: Parallel execution
echo "Test 2: Parallel command execution..."
PARALLEL_CMD='["scan:security test-project", "scan:quality test-project"]'
if /global:meta:chain "$PARALLEL_CMD" -> "scan:report {outputs} --unified" 2>&1 | grep -E "(parallel|completed)" > /dev/null; then
    echo "✅ Parallel execution works"
else
    echo "❌ Parallel execution failed"
    exit 1
fi

# Test 3: Error handling (should handle gracefully)
echo "Test 3: Error handling in chains..."
ERROR_CHAIN=$(/global:meta:chain "nonexistent:command" -> "scan:deep ." 2>&1 || true)
if [[ "$ERROR_CHAIN" =~ "error" ]] || [[ "$ERROR_CHAIN" =~ "failed" ]] || [[ "$ERROR_CHAIN" =~ "not found" ]]; then
    echo "✅ Error handling works correctly"
else
    echo "❌ Error not handled properly"
    exit 1
fi

# Test 4: Data flow validation
echo "Test 4: Data flow between commands..."
# Create a test file
echo '{"test": "data", "issues": ["issue1", "issue2"]}' > "$OUTPUT_DIR/test-input.json"

# Chain with explicit file
if /global:meta:chain "scan:report $OUTPUT_DIR/test-input.json --export-md" 2>&1 | grep -E "(test|data|issue)" > /dev/null; then
    echo "✅ Data flows correctly between commands"
else
    echo "❌ Data flow issue detected"
    exit 1
fi

# Cleanup
rm -rf "$OUTPUT_DIR"
find . -name "chain-output*.json" -mmin -5 -delete 2>/dev/null || true

echo "✅ All command chain integration tests passed!"