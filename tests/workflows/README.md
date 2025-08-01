# Workflow Tests

This directory contains tests for pre-defined workflows and pipelines.

## Purpose

Workflow tests verify complete user scenarios:
- Pre-built pipelines work correctly
- Workflows produce expected results
- User journeys are smooth

## Planned Tests

- `test-quick-quality.sh` - Test quick quality pipeline
- `test-deep-quality.sh` - Test comprehensive analysis workflow
- `test-security-hardening.sh` - Test security workflow
- `test-refactoring-sprint.sh` - Test refactoring workflow
- `test-release-prep.sh` - Test release preparation workflow

## Running Workflow Tests

```bash
# Run all workflow tests
for test in tests/workflows/test-*.sh; do
    bash "$test"
done

# Run specific workflow test
./tests/workflows/test-quick-quality.sh
```

## Test Strategy

Each workflow test should:
1. Set up a test scenario
2. Execute the workflow
3. Verify expected outputs
4. Check for side effects
5. Clean up