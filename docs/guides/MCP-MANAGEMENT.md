# MCP Server Management Guide

This guide explains how to use the MCP management system to install and manage MCP (Model Context Protocol) servers for Claude Code.

## Overview

The MCP Server Manager provides two ways to manage MCP servers:

1. **Slash Command** (`/prefix:meta:mcp`) - Use from within Claude Code in any project
2. **Direct Script** (`manage-mcp.sh`) - Use from the repository or installed location

Both support project-scoped and global installations, making it easy to add powerful capabilities to your Claude Code environment.

## Quick Start

### Using the Slash Command (Recommended)

After toolkit installation, use the MCP command from any project:

```bash
# List all available MCP servers
/prefix:meta:mcp list

# Interactive installation (select server and scope)
/prefix:meta:mcp install

# Install a server for current directory (default - local scope)
/prefix:meta:mcp install playwright

# Install a server for the project (creates .mcp.json)
/prefix:meta:mcp install playwright --scope project

# Install a server globally for all projects
/prefix:meta:mcp install playwright --user

# Remove a server
/prefix:meta:mcp remove playwright

# Show server information
/prefix:meta:mcp info playwright
```

### Using the Script Directly

From the toolkit repository or installed location:

```bash
# List all available MCP servers
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh list

# Install a server for the current directory (default - local scope)
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh install playwright

# Install a server for the project workspace (creates .mcp.json)
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh install playwright --scope project

# Install a server for all projects (user scope)
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh install playwright --user

# Interactive installation (select server and scope)
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh install

# Remove a server
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh remove playwright

# Show server information
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh info playwright
```

## Available MCP Servers

The script currently supports the following MCP servers:

### 1. Playwright

- **Command**: `npx @playwright/mcp@latest`
- **Description**: Browser automation and testing with Playwright
- **Use Cases**: Web scraping, automated testing, browser interactions

### 2. Perplexity Ask

- **Command**: `npx server-perplexity-ask`
- **Description**: AI-powered web search and research
- **Use Cases**: Real-time information retrieval, research assistance

### 3. Context7

- **Command**: `npx @upstash/context7-mcp@latest`
- **Description**: Context management and retrieval
- **Use Cases**: Documentation lookup, API reference retrieval

### 4. Fetch

- **Command**: `npx @kazuph/mcp-fetch`
- **Description**: HTTP fetch and web scraping
- **Use Cases**: API calls, web content retrieval

### 5. knowledge base

- **Command**: `uvx mcp`
- **Description**: Simple memory and note-taking
- **Use Cases**: Persistent memory across sessions, note management

### 6. Chrome DevTools

- **Command**: `npx chrome-devtools-mcp@latest`
- **Description**: Chrome DevTools integration
- **Use Cases**: Browser debugging, performance analysis

### 7. shadcn/ui Server

- **Command**: `npx @heilgar/shadcn-ui-mcp-server`
- **Description**: shadcn/ui component library
- **Use Cases**: UI component generation, design system integration

### 8. Figma Dev Mode

- **Command**: `--transport sse http://127.0.0.1:3845/sse`
- **Description**: Figma Dev Mode integration
- **Transport**: SSE (Server-Sent Events)
- **Use Cases**: Design-to-code workflows, Figma integration

## Installation Scopes

Claude Code supports three installation scopes for MCP servers:

### Local Scope (Default)

Installs the MCP server in the current directory only. This is the default scope and is useful when:

- You want directory-specific MCP configurations
- You're testing a new MCP server in isolation
- You need different MCP setups in subdirectories

**Note**: Local scope does NOT create a `.mcp.json` file.

```bash
./scripts/manage-mcp.sh install playwright
# or explicitly
./scripts/manage-mcp.sh install playwright --local
# or
./scripts/manage-mcp.sh install playwright --scope local
```

### Project Scope

Installs the MCP server for the current project workspace and creates a `.mcp.json` file. This is useful when:

- You want to keep project dependencies isolated
- Different projects need different MCP servers
- You want team members to share the same MCP configuration via version control

**Note**: Project scope DOES create a `.mcp.json` file that can be committed to version control.

```bash
./scripts/manage-mcp.sh install playwright --scope project
```

### User Scope

Installs the MCP server for all projects for the current user. This is useful when:

- You use the same MCP servers across all projects
- You want a consistent development environment
- The MCP server provides general-purpose functionality

```bash
./scripts/manage-mcp.sh install playwright --user
# or explicitly
./scripts/manage-mcp.sh install playwright --scope user
```

## Commands

### list

Lists all available MCP servers with descriptions and transport types.

```bash
./scripts/manage-mcp.sh list
```

**Output:**

```
═══════════════════════════════════════════════════════════════
  Available MCP Servers
═══════════════════════════════════════════════════════════════

[1] playwright
  Description: Browser automation and testing with Playwright
  Transport: stdio

[2] perplexity-ask
  Description: AI-powered web search and research
  Transport: stdio
...
```

### install

Installs a specific MCP server or provides interactive selection.

```bash
# Install specific server (local scope - default)
./scripts/manage-mcp.sh install playwright

# Install specific server (project scope)
./scripts/manage-mcp.sh install playwright --scope project

# Install specific server (user scope)
./scripts/manage-mcp.sh install playwright --user

# Interactive installation (select server and scope)
./scripts/manage-mcp.sh install
```

**Interactive Mode:**
When you run `./scripts/manage-mcp.sh install` without a server name, the script will:

1. Display a numbered list of all available MCP servers
2. Ask you to select a server by number
3. Ask you to select an installation scope (local/project/user)
4. Install the selected server with the chosen scope

The interactive mode makes it easy to explore available servers and choose the right scope for your needs.

**Interactive Mode:**

```
═══════════════════════════════════════════════════════════════
  Select MCP Server to Install
═══════════════════════════════════════════════════════════════

[1] playwright - Browser automation and testing with Playwright
[2] perplexity-ask - AI-powered web search and research
[3] context7 - Context management and retrieval
...

Enter number (1-8) or 'q' to quit: 
```

### remove

Removes/uninstalls a specific MCP server.

```bash
./scripts/manage-mcp.sh remove playwright
```

The script will:

1. Verify the server exists in the available list
2. Prompt for confirmation if not found
3. Execute the removal command
4. Display success or error message

### info

Shows detailed information about a specific MCP server.

```bash
./scripts/manage-mcp.sh info playwright
```

**Output:**

```
═══════════════════════════════════════════════════════════════
  MCP Server: playwright
═══════════════════════════════════════════════════════════════

Name:    playwright
Description: Browser automation and testing with Playwright
Command:   npx @playwright/mcp@latest
Transport:  stdio
```

### help

Displays usage information and examples.

```bash
./scripts/manage-mcp.sh help
# or
./scripts/manage-mcp.sh --help
```

## Adding New MCP Servers

To add a new MCP server to the script, edit the `MCP_SERVERS` array in `scripts/manage-mcp.sh`:

```bash
declare -a MCP_SERVERS=(
  # Existing servers...
  
  # Add new server
  "server-name|npx package-name|Description of the server|stdio"
)
```

**Format:**

```
"name|command|description|transport"
```

- **name**: Unique identifier for the server (lowercase, hyphens allowed)
- **command**: Full command to execute the server
- **description**: Brief description of what the server does
- **transport**: Communication protocol (stdio, sse, etc.) - optional, defaults to stdio

**Example:**

```bash
"my-server|npx @myorg/my-mcp-server|Custom MCP server for special tasks|stdio"
```

## Troubleshooting

### Server Installation Fails

**Problem:** Installation command fails with error

**Solutions:**

1. Check if you have the required runtime (Node.js for npx, Python for uvx)
2. Verify network connectivity
3. Try installing the package manually first
4. Check Claude Code logs for detailed error messages

### Server Not Available After Installation

**Problem:** Server installed but not showing up in Claude Code

**Solutions:**

1. Restart Claude Code
2. Check the installation scope (project vs global)
3. Verify the server is listed in Claude Code settings
4. Check MCP server logs

### Permission Errors

**Problem:** Permission denied when installing

**Solutions:**

1. Ensure you have write permissions to the project directory (for project scope)
2. Check your npm/npx permissions
3. Try running with appropriate permissions

## Best Practices

1. **Start with Project Scope**: Test new MCP servers in project scope before installing globally
2. **Review Server Documentation**: Check the official documentation for each MCP server
3. **Keep Servers Updated**: Regularly update MCP servers to get latest features and fixes
4. **Remove Unused Servers**: Uninstall MCP servers you're not using to reduce overhead
5. **Use Interactive Mode**: When unsure which server to install, use interactive mode to browse options

## References

- [Claude Code MCP Documentation](https://docs.claude.com/en/docs/claude-code/mcp)
- [MCP Installation Scopes](https://docs.claude.com/en/docs/claude-code/mcp#mcp-installation-scopes)
- [Model Context Protocol Specification](https://modelcontextprotocol.io/)

## Related Documentation

- [MCP Integration Guide](MCP-INTEGRATION.md) - Detailed MCP integration patterns
- [Enhanced Hooks Guide](ENHANCED-HOOKS.md) - Hook system integration with MCP
