# Archived Scripts

This directory contains scripts that became obsolete after the **Knowledge-Driven Revolution** transformation from 56 commands to 6 core commands.

## Archived Scripts

### Legacy Command Creation Tools

- **`create-sub-agent-command.sh`** - Created commands with old category system (scan:, fix:, gen:, etc.)
- **`create-sub-agent.sh`** - Created sub-agents with old orchestration patterns
- **`add-help-to-commands.sh`** - Bulk help addition for the old command structure
- **`simple-add-help.sh`** - Simplified help addition tool

## Why Archived?

These scripts were designed for the **56-command architecture** with categories like:

- `scan:deep`, `scan:quick`, `scan:perf`
- `fix:security`, `fix:performance`, `fix:types`
- `gen:component`, `gen:tests`, `gen:docs`
- `flow:refactor`, `flow:migrate`, `flow:optimize`

The new **6-Command Architecture** uses:

- `understand` - Comprehensive analysis with intelligent routing
- `improve` - Code improvements with learning persistence
- `create` - Content generation with pattern learning
- `secure` - Security operations with threat intelligence
- `ship` - Deployment readiness with quality gates
- `git` - Smart Git operations with project context

## Modern Alternatives

For current development, use:

- **Agent Creation**: `/prefix:create agent-name --template=specialist`
- **Command Development**: Edit core commands directly in `commands/`
- **Help System**: Built-in `--help` flag support in templates

## Historical Context

These tools were part of the **Phase 1-2** implementation (July-August 2025) and played a crucial role in:

- Rapid command scaffolding
- Consistent agent creation patterns
- Automated help system deployment
- Sub-agent orchestration workflows

*Archived: 2025-01-29 after Knowledge-Driven Revolution completion*
