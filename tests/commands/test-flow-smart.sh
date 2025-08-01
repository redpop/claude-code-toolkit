#!/bin/bash

# Test for flow:smart command

set -e

echo "Testing flow:smart command..."

# Test 1: Basic problem solving
OUTPUT=$(/global:flow:smart "my code has security vulnerabilities" 2>&1)

# Check if output contains expected keywords
if [[ "$OUTPUT" == *"security"* ]] && [[ "$OUTPUT" == *"vulnerability"* ]]; then
    echo "✓ Basic problem solving works"
else
    echo "✗ Basic problem solving failed"
    exit 1
fi

# Test 2: Performance problem
OUTPUT=$(/global:flow:smart "application is running slow" 2>&1)

if [[ "$OUTPUT" == *"performance"* ]] || [[ "$OUTPUT" == *"optimization"* ]]; then
    echo "✓ Performance routing works"
else
    echo "✗ Performance routing failed"
    exit 1
fi

# Test 3: Complex multi-domain problem
OUTPUT=$(/global:flow:smart "code is slow and has security issues" 2>&1)

if [[ "$OUTPUT" == *"security"* ]] && [[ "$OUTPUT" == *"performance"* ]]; then
    echo "✓ Multi-domain routing works"
else
    echo "✗ Multi-domain routing failed"
    exit 1
fi

echo "✓ All flow:smart tests passed"
exit 0