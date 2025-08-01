#!/bin/bash
set -euo pipefail

echo "🧪 Testing security-specialist agent..."

# Check if we're in Claude Code environment
if ! command -v claude-code &> /dev/null && [ -z "${CLAUDE_CODE:-}" ]; then
    echo "⚠️  This test requires Claude Code environment"
    echo "   Running structural tests instead..."
    
    # Test 1: Check if security agent exists
    if [ -f "$HOME/.claude/agents/security-specialist.md" ]; then
        echo "✅ Security specialist agent exists"
    else
        echo "❌ Security specialist agent not found"
        exit 1
    fi
    
    # Test 2: Check if flow:smart command exists
    if [ -f "$HOME/.claude/commands/global/flow/smart.md" ]; then
        echo "✅ Smart routing command exists"
    else
        echo "❌ Smart routing command not found"
        exit 1
    fi
    
    # Test 3: Check if scan:deep command exists
    if [ -f "$HOME/.claude/commands/global/scan/deep.md" ]; then
        echo "✅ Deep scan command exists"
    else
        echo "❌ Deep scan command not found"
        exit 1
    fi
    
    # Test 4: Verify test project has security issues to find
    if [ -f "test-project/src/vulnerable-code.js" ]; then
        echo "✅ Test project contains vulnerable code"
    else
        echo "❌ Test project missing vulnerable code"
        exit 1
    fi
else
    # Real test in Claude Code
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
fi

echo "✅ All security-specialist tests passed!"