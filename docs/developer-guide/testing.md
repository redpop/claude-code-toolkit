# Testing Guide

Test infrastructure and practices for the Claude Code Toolkit.

## Test Structure

```
test-project/           # Sample project with known issues
├── src/
│   ├── vulnerable-code.js  # Security vulnerabilities
│   ├── slow-algorithm.js   # Performance issues
│   ├── untested-module.js  # Missing tests
│   └── legacy-code.js      # Needs refactoring
tests/                  # Test scripts
├── run-all.sh         # Master test runner
├── commands/          # Command tests
├── agents/            # Agent tests
├── workflows/         # Workflow tests
└── integration/       # End-to-end tests
```

## Running Tests

### With Claude CLI

```bash
# Auto-detects claude command and uses programmatic mode
./tests/run-all.sh

# Or specify explicitly
export CLAUDE_CMD=claude
./tests/run-all.sh
```

### Without Claude CLI

Falls back to structural validation:

- Verifies file existence
- Checks installation structure
- Creates mock outputs

### Test Specific Components

```bash
# Test single command
./tests/commands/test-scan-deep.sh

# Test after installation
./install.sh global --force
./tests/run-all.sh
```

## Known Issues in Test Project

| File | Issues | Purpose |
|------|--------|---------|
| `vulnerable-code.js` | SQL injection, XSS, hardcoded secrets | Security testing |
| `slow-algorithm.js` | O(n²) loops, missing memoization | Performance testing |
| `untested-module.js` | Complex logic without tests | Test generation |
| `legacy-code.js` | 100+ line functions, duplication | Refactoring testing |

## Writing Tests

### Command Test Template

Create `tests/commands/test-{command}.sh`:

```bash
#!/bin/bash
set -euo pipefail

echo "Testing /prefix:category:command..."

# Setup
TEST_DIR="test-project"
OUTPUT_FILE="/tmp/test-output-$$.json"

# Run command
/prefix:category:command "$TEST_DIR" --export-json="$OUTPUT_FILE"

# Validate output
if [ ! -f "$OUTPUT_FILE" ]; then
    echo "❌ No output file created"
    exit 1
fi

if ! jq -e '.results' "$OUTPUT_FILE" > /dev/null 2>&1; then
    echo "❌ Invalid JSON structure"
    exit 1
fi

# Check expectations
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

Create `tests/agents/test-{agent}.sh`:

```bash
#!/bin/bash
set -euo pipefail

echo "Testing {agent} sub-agent..."

# Test agent invocation
RESULT=$(/prefix:flow:smart "test {agent} functionality" --dry-run)

if [[ ! "$RESULT" =~ "{agent}" ]]; then
    echo "❌ Agent not invoked"
    exit 1
fi

echo "✅ Agent test passed!"
```

## Test Maintenance

### When Adding Commands

1. Create test script in `tests/commands/`
2. Add test cases to `test-project/` if needed
3. Update `tests/run-all.sh`
4. Document expected behavior

### When Modifying Commands

1. Run existing tests for baseline
2. Update test expectations
3. Add tests for new functionality
4. Ensure backward compatibility

### When Adding Agents

1. Create test in `tests/agents/`
2. Add triggering scenarios
3. Validate agent selection
4. Update integration tests

## Best Practices

| Practice | Description |
|----------|-------------|
| **Isolated** | Each test independent, clean up after |
| **Clear** | Document what test validates |
| **Fast** | Keep tests under 30 seconds |
| **Maintained** | Update tests with code changes |

## CI/CD Integration

### GitHub Actions (Future)

```yaml
name: Test Commands
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - run: ./install.sh ci
      - run: ./tests/run-all.sh
      - uses: actions/upload-artifact@v3
        if: failure()
        with:
          name: test-results
          path: /tmp/test-output-*.json
```

## Debugging Failed Tests

| Issue | Solution |
|-------|----------|
| Command not found | Run `./install.sh global --force` |
| No output | Verify test project has expected issues |
| Wrong results | Compare with manual execution |
| Timeout | Increase timeout or use `--quick` |

### Debug Mode

```bash
DEBUG=1 ./tests/commands/test-scan-deep.sh
```

## Test Coverage Goals

- [ ] All commands have basic tests
- [ ] Critical paths have integration tests
- [ ] Performance benchmarks established
- [ ] Error conditions tested

## Contributing Tests

When contributing:

1. Write tests for new features
2. Update tests for changes
3. Document test purpose
4. Ensure all tests pass

## Future Enhancements

- **Coverage metrics** - Track tested code paths
- **Performance benchmarks** - Monitor execution times
- **Integration tests** - Test command chains
- **Mock infrastructure** - Test edge cases

## Related Documentation

- [Extending](extending.md) - Creating testable components
- [Architecture](architecture.md) - Understanding test points
- [Configuration](configuration.md) - Test configurations
