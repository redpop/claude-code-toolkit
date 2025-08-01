#!/bin/bash

# Test for scan:deep command

set -e

echo "Testing scan:deep command..."

cd test-project

# Test 1: Basic scan with JSON export
if /global:scan:deep . --export-json=test-scan-result.json; then
    echo "✓ Basic scan completed"
else
    echo "✗ Basic scan failed"
    exit 1
fi

# Test 2: Check if JSON file was created
if [ -f "test-scan-result.json" ]; then
    echo "✓ JSON export works"
    
    # Test 3: Verify JSON structure
    if command -v jq >/dev/null 2>&1; then
        if jq '.' test-scan-result.json >/dev/null 2>&1; then
            echo "✓ JSON is valid"
        else
            echo "✗ JSON is invalid"
            exit 1
        fi
    fi
else
    echo "✗ JSON export failed"
    exit 1
fi

# Test 4: Security-focused scan
if /global:scan:deep . --focus=security --export-json=security-scan.json; then
    echo "✓ Security-focused scan works"
else
    echo "✗ Security-focused scan failed"
    exit 1
fi

# Test 5: Performance-focused scan
if /global:scan:deep . --focus=performance --export-json=perf-scan.json; then
    echo "✓ Performance-focused scan works"
else
    echo "✗ Performance-focused scan failed"
    exit 1
fi

# Clean up
rm -f test-scan-result.json security-scan.json perf-scan.json

cd ..

echo "✓ All scan:deep tests passed"
exit 0