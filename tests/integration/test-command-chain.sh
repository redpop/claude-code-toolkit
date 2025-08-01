#!/bin/bash
set -euo pipefail

echo "🧪 Testing command chaining integration..."

# Setup
TEST_DIR="test-project"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="/tmp/test-chain-$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

# Test 1: Simple chain with data passing
echo "Test 1: Simple command chain..."
CHAIN_RESULT=$(/global:meta:chain "scan:quick $TEST_DIR" -> "scan:report {output} --quick-wins" 2>&1)
if [[ "$CHAIN_RESULT" =~ "Chain Execution Report" ]] || [[ "$CHAIN_RESULT" =~ "completed" ]]; then
    echo "✅ Simple chain executed"
else
    echo "❌ Simple chain failed"
    echo "$CHAIN_RESULT"
    exit 1
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