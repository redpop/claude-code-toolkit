#!/bin/bash
set -euo pipefail

echo "🧪 Testing security-specialist agent..."

# Test that security agent can be invoked through smart routing
echo "Testing agent invocation..."
RESULT=$(/global:flow:smart "check for SQL injection vulnerabilities" --dry-run 2>&1 || true)

# Verify security specialist was selected
if [[ "$RESULT" =~ "security" ]]; then
    echo "✅ Security specialist correctly selected"
else
    echo "❌ Security specialist not selected for security query"
    echo "Output: $RESULT"
    exit 1
fi

# Test with scan:deep security focus
echo "Testing through scan:deep..."
if /global:scan:deep test-project --focus=security --export-json=/tmp/security-test.json; then
    echo "✅ Security scan completed"
    
    # Verify output contains security findings
    if [ -f /tmp/security-test.json ]; then
        if jq -e '.security_issues' /tmp/security-test.json > /dev/null 2>&1; then
            echo "✅ Security findings present in output"
        else
            echo "❌ No security findings in output"
            exit 1
        fi
        rm -f /tmp/security-test.json
    fi
else
    echo "❌ Security scan failed"
    exit 1
fi

echo "✅ All security-specialist tests passed!"