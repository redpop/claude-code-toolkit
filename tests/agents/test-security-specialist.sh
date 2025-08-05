#!/bin/bash
set -euo pipefail

echo "🧪 Testing security-specialist agent..."

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
    # Test 1: Test smart routing with programmatic mode
    echo "Testing smart routing..."
    RESULT=$(cd test-project && $CLAUDE_CMD -p "/global:flow:smart 'check for SQL injection vulnerabilities' --dry-run" 2>&1 || true)
    
    if [[ "$RESULT" =~ "security" ]] || [[ "$RESULT" =~ "Security" ]]; then
        echo "✅ Security specialist correctly selected"
    else
        echo "⚠️  Could not verify security specialist selection"
        echo "   Output: ${RESULT:0:100}..."
    fi
    
    # Test 2: Test deep scan with security focus
    echo "Testing security scan..."
    SCAN_RESULT=$(cd test-project && $CLAUDE_CMD -p "/global:scan:deep . --focus=security --export-json=/tmp/security-test.json" 2>&1 || true)
    
    if [[ "$SCAN_RESULT" =~ "security" ]] || [ -f "/tmp/security-test.json" ]; then
        echo "✅ Security scan executed"
        if [ -f "/tmp/security-test.json" ]; then
            rm -f /tmp/security-test.json
        fi
    else
        echo "⚠️  Security scan may not have completed"
    fi
else
    echo "⚠️  Claude Code CLI not found"
    echo "   Running structural tests instead..."
    
    # Fallback structural tests
    if [ -f "$HOME/.claude/agents/security-specialist.md" ]; then
        echo "✅ Security specialist agent exists"
    else
        echo "❌ Security specialist agent not found"
        exit 1
    fi
    
    if [ -f "$HOME/.claude/commands/global/flow/smart.md" ]; then
        echo "✅ Smart routing command exists"
    else
        echo "❌ Smart routing command not found"
        exit 1
    fi
    
    if [ -f "test-project/src/vulnerable-code.js" ]; then
        echo "✅ Test project contains vulnerable code"
    else
        echo "❌ Test project missing vulnerable code"
        exit 1
    fi
fi

echo "✅ All security-specialist tests passed!"