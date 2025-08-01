#!/bin/bash

# Test for meta:pipelines command

set -e

echo "Testing meta:pipelines command..."

cd test-project

# Test 1: Quick quality pipeline
OUTPUT=$(/global:meta:pipelines quick-quality 2>&1)

if [[ "$OUTPUT" == *"quality"* ]] || [[ "$OUTPUT" == *"check"* ]]; then
    echo "✓ Quick quality pipeline works"
else
    echo "✗ Quick quality pipeline failed"
    exit 1
fi

# Test 2: Dry run mode
OUTPUT=$(/global:meta:pipelines deep-quality --dry-run 2>&1)

if [[ "$OUTPUT" == *"would execute"* ]] || [[ "$OUTPUT" == *"dry"* ]]; then
    echo "✓ Dry run mode works"
else
    echo "✗ Dry run mode failed"
    exit 1
fi

# Test 3: Security hardening pipeline
OUTPUT=$(/global:meta:pipelines security-hardening --dry-run 2>&1)

if [[ "$OUTPUT" == *"security"* ]]; then
    echo "✓ Security pipeline accessible"
else
    echo "✗ Security pipeline failed"
    exit 1
fi

cd ..

echo "✓ All meta:pipelines tests passed"
exit 0