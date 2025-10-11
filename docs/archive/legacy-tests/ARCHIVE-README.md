# Legacy Tests Archive

This directory contains the original test suite from before the **Knowledge-Driven Revolution**.

## Why Archived?

These tests were designed for the old 56-command architecture (scan:deep, fix:security, flow:smart, etc.) which was replaced by the modern **6-Command Architecture** (understand, improve, create, secure, ship, git).

## Original Test Structure

- **run-all.sh**: Main test runner
- **commands/**: Tests for old command categories
- **agents/**: Agent functionality tests
- **workflows/**: Multi-command workflow tests
- **integration/**: End-to-end integration tests

## Migration Status

The original tests referenced commands that no longer exist:

- `scan:deep` → now `understand . --deep`
- `fix:security` → now `secure . --fix`
- `flow:smart` → functionality distributed across new commands

## Future Testing

New testing approach will focus on:

- 6 core commands validation
- Agent orchestration tests
- MCP integration tests
- knowledge base integration

*Archived: 2025-01-29 after Knowledge-Driven Revolution completion*
