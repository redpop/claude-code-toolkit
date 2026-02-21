---
name: mcp
description: This skill should be used when the user asks to "install MCP server", "manage MCP", "list MCP servers", "remove MCP server", or needs MCP (Model Context Protocol) server management.
---

# MCP Management

Manage MCP (Model Context Protocol) servers for Claude Code.

## Arguments

Parse arguments: `$ARGUMENTS`

Extract:

- **Command**: list, install, remove, info
- **Server name**: if provided
- **Scope**: `--scope local|project|user` (default: local)
  - `--local`: Current directory only (default)
  - `--scope project`: Creates .mcp.json in project root
  - `--user`: All projects for current user

## Execution

### Phase 1: Validate Script

Check if management script exists:
`${CLAUDE_PLUGIN_ROOT}/scripts/manage-mcp.sh`

If not found, inform user.

### Phase 2: Execute Command

**list**: `${CLAUDE_PLUGIN_ROOT}/scripts/manage-mcp.sh list`
**install**: `${CLAUDE_PLUGIN_ROOT}/scripts/manage-mcp.sh install <name> [--scope <scope>]`
**remove**: `${CLAUDE_PLUGIN_ROOT}/scripts/manage-mcp.sh remove <name>`
**info**: `${CLAUDE_PLUGIN_ROOT}/scripts/manage-mcp.sh info <name>`

### Phase 3: Post-Action

For install/remove operations, inform user:
"Changes require a Claude Code restart to take effect."

## Available Servers

- playwright — Browser automation and testing
- perplexity-ask — AI-powered web search
- context7 — Documentation context
- fetch — HTTP fetch and web scraping
- chrome-devtools — Chrome DevTools integration
- shadcn-ui-server — shadcn/ui components
- figma-dev-mode — Figma Dev Mode integration
