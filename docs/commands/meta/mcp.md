# MCP Management Command

**Command**: `/prefix:meta:mcp`

**Purpose**: Manage MCP (Model Context Protocol) servers for Claude Code from any project.

## Overview

The MCP management command provides an intuitive interface for installing, removing, and managing MCP servers directly from Claude Code. This eliminates the need to manually run shell scripts and makes MCP server management accessible from any project.

## Syntax

```bash
/prefix:meta:mcp [command] [server-name] [options]
```

## Commands

| Command | Description | Arguments |
|---------|-------------|-----------|
| `list` | List all available MCP servers | None |
| `install` | Install an MCP server | `[server-name]` (optional for interactive) |
| `remove` | Remove/uninstall an MCP server | `<server-name>` (required) |
| `info` | Show detailed server information | `<server-name>` (required) |

## Scope Options

| Option | Scope | Description |
|--------|-------|-------------|
| `--scope local` | Local | Current directory only (default) |
| `--scope project` | Project | Current project workspace (creates `.mcp.json`) |
| `--scope user` or `--user` | User | All projects for current user (global) |

## Available MCP Servers

1. **playwright** - Browser automation and testing with Playwright
2. **perplexity-ask** - AI-powered web search and research
3. **context7** - Documentation context management and retrieval
4. **fetch** - HTTP fetch and web scraping with image support
5. **** - Simple memory and note-taking capabilities
6. **chrome-devtools** - Chrome DevTools integration
7. **shadcn-ui-server** - shadcn/ui component library
8. **figma-dev-mode** - Figma Dev Mode integration (SSE transport)

## Examples

### Interactive Installation

```bash
# Start interactive installation (select server and scope)
/prefix:meta:mcp install
```

The command will:

1. Display a list of available MCP servers
2. Let you select a server by number
3. Let you choose the installation scope
4. Execute the installation

### Direct Installation

```bash
# Install for current directory only (local scope)
/prefix:meta:mcp install context7

# Install for current project (creates .mcp.json)
/prefix:meta:mcp install context7 --scope project

# Install globally for all projects
/prefix:meta:mcp install perplexity-ask --user
```

### List and Info

```bash
# List all available servers
/prefix:meta:mcp list

# Show detailed information about a server
/prefix:meta:mcp info fetch
```

### Removal

```bash
# Remove an installed server
/prefix:meta:mcp remove context7
```

## Workflows

### Project Setup Workflow

When starting a new project with specific MCP requirements:

```bash
# Navigate to project
cd /path/to/project

# Install project-specific MCP servers
/prefix:meta:mcp install context7 --scope project
/prefix:meta:mcp install fetch --scope project

# Verify installation
/prefix:meta:mcp list
```

### Global MCP Setup

Set up commonly used MCP servers globally:

```bash
# Install frequently used servers globally
/prefix:meta:mcp install perplexity-ask --user
/prefix:meta:mcp install --user
```

### Experimentation Workflow

Try out different MCP servers in local scope:

```bash
# Install locally for testing
/prefix:meta:mcp install playwright

# Test the server
# ... use the MCP server ...

# Remove if not needed
/prefix:meta:mcp remove playwright
```

## Installation Scopes Explained

### Local Scope (Default)

- **When to use**: Testing, temporary needs, directory-specific requirements
- **Scope**: Current directory only
- **Configuration**: Uses Claude CLI's local scope
- **Persistence**: Only available when working in that specific directory

```bash
/prefix:meta:mcp install playwright --scope local
```

### Project Scope

- **When to use**: Project-wide requirements, team collaboration
- **Scope**: Current project workspace
- **Configuration**: Creates `.mcp.json` in project root
- **Persistence**: Available throughout the project, can be committed to version control

```bash
/prefix:meta:mcp install context7 --scope project
```

### User Scope

- **When to use**: Personal preferences, frequently used servers
- **Scope**: All projects for current user
- **Configuration**: User-wide Claude CLI configuration
- **Persistence**: Available in all projects

```bash
/prefix:meta:mcp install --user
```

## Behind the Scenes

The command uses the `manage-mcp.sh` script installed at:

```
~/.claude/claude-code-toolkit/scripts/manage-mcp.sh
```

This script is automatically installed during toolkit installation and is always available after running `./install.sh`.

## Troubleshooting

### Script Not Found

If the command reports that the management script is not found:

1. Ensure the toolkit is installed: `./install.sh <prefix>`
2. Check if the script exists: `ls ~/.claude/claude-code-toolkit/scripts/manage-mcp.sh`
3. Reinstall the toolkit if needed

### Claude CLI Not Found

The management script requires Claude CLI:

1. Install Claude Code CLI from <https://docs.claude.com/en/docs/claude-code>
2. Verify installation: `claude --version`
3. Retry the MCP installation

### Server Installation Fails

1. Check your internet connection (servers are installed via npx/uvx)
2. Verify the server name is correct: `/prefix:meta:mcp list`
3. Check Claude CLI logs for detailed error messages

## See Also

- [MCP Management Guide](../../docs/guides/MCP-MANAGEMENT.md) - Comprehensive MCP management documentation
- [MCP Integration](../../docs/guides/MCP-INTEGRATION.md) - MCP integration patterns and best practices
- `/prefix:meta:changelog` - Changelog management command
- `/prefix:meta:handoff` - AI handoff preparation command
