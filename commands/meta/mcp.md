---
description: Manage MCP (Model Context Protocol) servers for Claude Code
argument-hint: [install|remove|list|info] [server-name] [--scope local|project|user]
allowed-tools: Bash, Read
---

# meta:mcp

Manage MCP (Model Context Protocol) servers for Claude Code in any project.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

📚 **MCP Management Command Help**

**Command**: /prefix:meta:mcp
**Description**: Manage MCP (Model Context Protocol) servers for Claude Code
**Usage**: /prefix:meta:mcp [install|remove|list|info] [server-name] [--scope local|project|user]

**Commands**:

- `list` - List all available MCP servers
- `install [name]` - Install a specific MCP server (interactive if no name)
- `remove [name]` - Remove/uninstall a specific MCP server
- `info [name]` - Show detailed information about an MCP server

**Scope Options** (default: `--local`):

- `--scope local` or `--local` - Install in current directory only (**default**)
- `--scope project` - Install for current project workspace (creates .mcp.json)
- `--scope user` or `--user` - Install for all projects of current user

**Important**: If no scope option is specified, the MCP server will be installed with `--local` scope (current directory only).

**Examples**:

```bash
# List available servers
/prefix:meta:mcp list

# Interactive installation
/prefix:meta:mcp install

# Install with default scope (--local)
/prefix:meta:mcp install context7

# Install for project workspace
/prefix:meta:mcp install context7 --scope project

# Install globally for all projects
/prefix:meta:mcp install context7 --user

# Remove server
/prefix:meta:mcp remove context7

# Show server info
/prefix:meta:mcp info fetch
```

**Installation Scopes**:

- **local** (default): Current directory only
- **project**: Current project workspace (creates .mcp.json)
- **user**: All projects for current user

**Available MCP Servers**:

- playwright - Browser automation and testing
- perplexity-ask - AI-powered web search
- context7 - Documentation context management
- fetch - HTTP fetch and web scraping
- basic-memory - Memory and note-taking
- chrome-devtools - Chrome DevTools integration
- shadcn-ui-server - shadcn/ui components
- figma-dev-mode - Figma Dev Mode integration

**Related Commands**:

- /prefix:meta:changelog - Changelog management
- /prefix:meta:handoff - AI handoff preparation

Exit without executing the main command.

---

## Implementation

### Phase 1: Parse Arguments

Parse `$ARGUMENTS` to extract:

1. Command (list, install, remove, info)
2. Server name (if provided)
3. Scope options (--scope, --local, --user)

### Phase 2: Validate Script

Check if management script exists at `~/.claude/claude-code-toolkit/scripts/manage-mcp.sh`.

If not found, inform user that toolkit needs to be installed first.

### Phase 3: Execute Command

Based on the parsed command, execute the appropriate script action:

**List Command**:

```bash
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh list
```

**Install Command**:

- If server name provided:

  ```bash
  ~/.claude/claude-code-toolkit/scripts/manage-mcp.sh install <server-name> [--scope <scope>]
  ```

- If no server name (interactive):

  ```bash
  ~/.claude/claude-code-toolkit/scripts/manage-mcp.sh install [--scope <scope>]
  ```

**Remove Command**:

```bash
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh remove <server-name>
```

**Info Command**:

```bash
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh info <server-name>
```

### Phase 4: Handle Output

Display the script output to the user, including:

- Success/failure status
- Installation scope confirmation
- Next steps or usage instructions

## MCP Server Management

This command provides:

- **Easy Installation** - Interactive or direct server installation
- **Flexible Scoping** - Local, project, or user-wide installation
- **Server Discovery** - List all available MCP servers
- **Information** - Detailed server information and capabilities
- **Removal** - Clean uninstallation of servers

## Integration

Works seamlessly in any project:

1. Navigate to any project directory
2. Run the MCP management command
3. Install servers with appropriate scope
4. Servers immediately available in Claude Code

## Important Notes

- Script location: `~/.claude/claude-code-toolkit/scripts/manage-mcp.sh`
- Requires Claude CLI to be installed
- Project scope creates `.mcp.json` in project root
- Interactive mode triggers when server name is omitted
- Script provides clear error messages for invalid inputs
