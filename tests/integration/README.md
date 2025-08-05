# Integration Tests

This directory contains end-to-end integration tests.

## Purpose

Integration tests verify that:
- Multiple commands work together correctly
- Data flows properly between commands
- The toolkit integrates well with external tools
- Performance meets expectations

## Planned Tests

- `test-workflow-chain.sh` - Test command chaining
- `test-export-import.sh` - Test data export/import between commands
- `test-performance-benchmark.sh` - Performance regression tests
- `test-mcp-integration.sh` - MCP server integration tests

## Running Integration Tests

```bash
# Run all integration tests
for test in tests/integration/test-*.sh; do
    bash "$test"
done
```

## Note

Integration tests are more complex and may require setup/teardown procedures.