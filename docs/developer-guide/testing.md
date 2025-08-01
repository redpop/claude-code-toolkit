# Testing Guide

This guide explains the testing infrastructure of the Claude Code Toolkit, including the test project, test scripts, and how to maintain tests when commands or agents change.

## Overview

The toolkit uses two main directories for testing:

- **`test-project/`** - A sample project with intentionally problematic code
- **`tests/`** - Test scripts and automation tools

## Test Project (`test-project/`)

### Purpose

The test project serves as a controlled environment with known issues that commands can analyze and fix. It contains deliberately problematic code to validate that our analysis and fix commands work correctly.

### Structure

```
test-project/
├── package.json           # Basic Node.js project setup
├── src/
│   ├── vulnerable-code.js # Security vulnerabilities (SQL injection, XSS, etc.)
│   ├── slow-algorithm.js  # Performance issues (O(n²) algorithms, inefficient loops)
│   ├── untested-module.js # Code without tests (for test generation commands)
│   └── legacy-code.js     # Code needing refactoring (long functions, duplication)
└── tests/                 # Empty directory for generated tests
```

### Known Issues in Test Project

#### vulnerable-code.js
- SQL injection vulnerability
- XSS vulnerability
- Hardcoded credentials
- Insecure random number generation
- Command injection risk

#### slow-algorithm.js
- Nested loops creating O(n²) complexity
- Inefficient array operations
- Missing memoization
- Unnecessary repeated calculations

#### untested-module.js
- Complex logic without tests
- Edge cases not covered
- Missing input validation

#### legacy-code.js
- Functions over 100 lines
- Repeated code blocks
- Poor naming conventions
- Mixed responsibilities

### Using the Test Project

```bash
# Test security scanning
/global:sec:audit test-project/

# Test performance analysis
/global:scan:perf test-project/

# Test fix commands
/global:fix:smart test-project/

# Test code generation
/global:gen:tests test-project/src/untested-module.js
```

## Test Scripts (`tests/`)

### Structure

```
tests/
├── run-all.sh              # Master test runner
├── commands/               # Individual command tests
│   ├── test-scan-deep.sh
│   ├── test-flow-smart.sh
│   └── test-meta-pipelines.sh
├── agents/                 # Sub-agent tests (to be implemented)
├── workflows/              # Workflow tests (to be implemented)
└── integration/            # End-to-end tests (to be implemented)
```

### Running Tests

#### Run All Tests
```bash
cd claude-code-toolkit
./tests/run-all.sh
```

#### Run Specific Command Test
```bash
./tests/commands/test-scan-deep.sh
```

#### Test After Installation
```bash
# Install toolkit
./install.sh global --force

# Run tests
./tests/run-all.sh
```

## Writing Tests

### Command Test Template

Create a new test file: `tests/commands/test-[command-name].sh`

```bash
#!/bin/bash
set -euo pipefail

echo "Testing /global:[category]:[command]..."

# Setup
TEST_DIR="test-project"
OUTPUT_FILE="/tmp/test-output-$$.json"

# Run command
/global:[category]:[command] "$TEST_DIR" --export-json="$OUTPUT_FILE"

# Validate output exists
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "❌ Command failed to create output file"
    exit 1
fi

# Validate output structure
if ! jq -e '.results' "$OUTPUT_FILE" > /dev/null 2>&1; then
    echo "❌ Invalid output structure"
    exit 1
fi

# Check for expected findings
ISSUE_COUNT=$(jq '.results | length' "$OUTPUT_FILE")
if [ "$ISSUE_COUNT" -eq 0 ]; then
    echo "❌ No issues found (expected > 0)"
    exit 1
fi

# Cleanup
rm -f "$OUTPUT_FILE"

echo "✅ Test passed!"
```

### Agent Test Template

Create a new test file: `tests/agents/test-[agent-name].sh`

```bash
#!/bin/bash
set -euo pipefail

echo "Testing [agent-name] sub-agent..."

# Test agent can be invoked
RESULT=$(/global:flow:smart "test [agent-name] functionality" --dry-run)

# Validate agent was selected
if [[ ! "$RESULT" =~ "[agent-name]" ]]; then
    echo "❌ Agent was not properly invoked"
    exit 1
fi

echo "✅ Agent test passed!"
```

## Maintaining Tests

### When Adding a New Command

1. Create a test script in `tests/commands/`
2. Add known test cases to `test-project/` if needed
3. Update `tests/run-all.sh` to include the new test
4. Document expected behavior in the test script

### When Modifying a Command

1. Run existing tests to establish baseline
2. Update test expectations if behavior changes
3. Add new test cases for new functionality
4. Ensure backward compatibility or document breaking changes

### When Adding a New Agent

1. Create test script in `tests/agents/`
2. Add test scenarios that trigger the agent
3. Validate agent selection and output
4. Update integration tests if needed

## Test Best Practices

### 1. Isolated Tests
- Each test should be independent
- Clean up temporary files after tests
- Don't rely on global state

### 2. Clear Expectations
- Document what each test validates
- Use descriptive error messages
- Include both positive and negative test cases

### 3. Performance Considerations
- Keep individual tests under 30 seconds
- Use `--quick` or `--limit` flags when appropriate
- Cache test data when possible

### 4. Maintenance
- Run tests before committing changes
- Update tests when commands change
- Remove tests for deprecated features

## Continuous Integration

### GitHub Actions Example

```yaml
name: Test Commands

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Install toolkit
        run: ./install.sh ci
      
      - name: Run tests
        run: ./tests/run-all.sh
      
      - name: Upload test results
        if: failure()
        uses: actions/upload-artifact@v3
        with:
          name: test-results
          path: /tmp/test-output-*.json
```

## Debugging Failed Tests

### Common Issues

1. **Command not found**
   - Ensure toolkit is installed: `./install.sh global --force`
   - Check command name and prefix

2. **No output generated**
   - Verify test project has expected issues
   - Check command supports `--export-json`

3. **Unexpected results**
   - Compare with manual command execution
   - Check for recent command changes
   - Validate test expectations are current

### Debug Mode

Run tests with debug output:

```bash
DEBUG=1 ./tests/commands/test-scan-deep.sh
```

## Future Improvements

### Planned Enhancements

1. **Coverage Metrics**
   - Track which commands have tests
   - Measure code paths tested
   - Generate coverage reports

2. **Performance Benchmarks**
   - Track command execution times
   - Identify performance regressions
   - Optimize slow commands

3. **Integration Tests**
   - Test command chains
   - Validate workflow scenarios
   - Test error handling

4. **Mock Infrastructure**
   - Mock external dependencies
   - Test error conditions
   - Validate edge cases

## Contributing Tests

When contributing new features:

1. Write tests for new commands/agents
2. Update existing tests if behavior changes
3. Document test purpose and expectations
4. Ensure all tests pass before submitting PR

Tests are crucial for maintaining toolkit quality and preventing regressions. Every command should have at least one test validating its core functionality.