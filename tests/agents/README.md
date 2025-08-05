# Agent Tests

This directory contains tests for individual sub-agents.

## Structure

Each agent should have its own test file:
- `test-security-specialist.sh`
- `test-performance-optimizer.sh`
- `test-code-architect.sh`
- etc.

## Running Agent Tests

```bash
# Run all agent tests
for test in tests/agents/test-*.sh; do
    bash "$test"
done

# Run specific agent test
./tests/agents/test-security-specialist.sh
```

## Test Template

See `docs/developer-guide/testing.md` for agent test templates.