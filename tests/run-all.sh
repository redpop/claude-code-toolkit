#!/bin/bash

# Claude Code Toolkit - Complete Test Suite
# This script runs all tests for commands, agents, and workflows

set -e  # Exit on error

echo "🧪 Claude Code Toolkit - Test Suite"
echo "==================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counters
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Test result tracking
declare -a FAILED_COMMANDS

# Function to run a test
run_test() {
    local test_name=$1
    local test_file=$2
    
    echo -n "Testing $test_name... "
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if bash "$test_file" > /dev/null 2>&1; then
        echo -e "${GREEN}✓ PASSED${NC}"
        PASSED_TESTS=$((PASSED_TESTS + 1))
    else
        echo -e "${RED}✗ FAILED${NC}"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        FAILED_COMMANDS+=("$test_name")
    fi
}

# Ensure we're in the right directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/.."

# Step 1: Install/Update toolkit
echo "📦 Installing/Updating toolkit..."
./install.sh global --force > /dev/null 2>&1
echo -e "${GREEN}✓ Installation complete${NC}"
echo ""

# Step 2: Run Command Tests
echo "📋 Running Command Tests"
echo "-----------------------"

# Test flow commands
if [ -d "tests/commands" ]; then
    for test in tests/commands/test-*.sh; do
        if [ -f "$test" ]; then
            test_name=$(basename "$test" .sh | sed 's/test-//')
            run_test "$test_name" "$test"
        fi
    done
fi

echo ""

# Step 3: Run Agent Tests
echo "🤖 Running Agent Tests"
echo "---------------------"

if [ -d "tests/agents" ]; then
    for test in tests/agents/test-*.sh; do
        if [ -f "$test" ]; then
            test_name=$(basename "$test" .sh | sed 's/test-//')
            run_test "$test_name" "$test"
        fi
    done
fi

echo ""

# Step 4: Run Workflow Tests
echo "🔄 Running Workflow Tests"
echo "------------------------"

if [ -d "tests/workflows" ]; then
    for test in tests/workflows/test-*.sh; do
        if [ -f "$test" ]; then
            test_name=$(basename "$test" .sh | sed 's/test-//')
            run_test "$test_name" "$test"
        fi
    done
fi

echo ""

# Step 5: Run Integration Tests
echo "🔗 Running Integration Tests"
echo "---------------------------"

if [ -d "tests/integration" ]; then
    for test in tests/integration/test-*.sh; do
        if [ -f "$test" ]; then
            test_name=$(basename "$test" .sh | sed 's/test-//')
            run_test "$test_name" "$test"
        fi
    done
fi

echo ""

# Step 6: Performance Benchmark
echo "⚡ Running Performance Benchmark"
echo "-------------------------------"

if [ -f "tests/integration/benchmark.sh" ]; then
    echo "Benchmarking scan:deep command..."
    START_TIME=$(date +%s)
    
    # Run the benchmark
    cd test-project
    /global:scan:deep . --export-json=benchmark-result.json > /dev/null 2>&1
    
    END_TIME=$(date +%s)
    DURATION=$((END_TIME - START_TIME))
    
    if [ $DURATION -lt 60 ]; then
        echo -e "${GREEN}✓ Performance: ${DURATION}s (Good)${NC}"
    elif [ $DURATION -lt 120 ]; then
        echo -e "${YELLOW}⚠ Performance: ${DURATION}s (Acceptable)${NC}"
    else
        echo -e "${RED}✗ Performance: ${DURATION}s (Too Slow)${NC}"
    fi
    
    cd ..
fi

echo ""
echo "==================================="
echo "📊 Test Summary"
echo "==================================="
echo -e "Total Tests: $TOTAL_TESTS"
echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
echo -e "Failed: ${RED}$FAILED_TESTS${NC}"

if [ $FAILED_TESTS -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ All tests passed!${NC}"
    exit 0
else
    echo ""
    echo -e "${RED}❌ Some tests failed:${NC}"
    for cmd in "${FAILED_COMMANDS[@]}"; do
        echo "  - $cmd"
    done
    exit 1
fi