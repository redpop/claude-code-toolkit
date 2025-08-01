#!/bin/bash
set -euo pipefail

echo "🧪 Testing quick-quality workflow..."

# Setup
TEST_DIR="test-project"
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
OUTPUT_DIR="/tmp/test-quick-quality-$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

# Test the quick quality pipeline
echo "Running quick quality pipeline..."
if /global:meta:pipelines quick-quality 2>&1 | tee "$OUTPUT_DIR/pipeline.log"; then
    echo "✅ Pipeline executed successfully"
else
    echo "❌ Pipeline failed"
    cat "$OUTPUT_DIR/pipeline.log"
    exit 1
fi

# Verify expected outputs were created
echo "Checking for expected outputs..."

# Look for analysis files
ANALYSIS_FILES=$(find . -name "quick-check*.json" -mmin -5 2>/dev/null | wc -l)
if [ "$ANALYSIS_FILES" -gt 0 ]; then
    echo "✅ Analysis files created"
else
    echo "❌ No analysis files found"
    exit 1
fi

# Verify workflow completed in reasonable time (should be ~30s)
ELAPSED=$(grep -E "Duration:|Elapsed:|Completed in" "$OUTPUT_DIR/pipeline.log" || echo "")
if [ -n "$ELAPSED" ]; then
    echo "✅ Performance metrics recorded: $ELAPSED"
else
    echo "⚠️  No performance metrics found"
fi

# Cleanup
rm -rf "$OUTPUT_DIR"
find . -name "quick-check*.json" -mmin -5 -delete 2>/dev/null || true

echo "✅ Quick quality workflow test passed!"