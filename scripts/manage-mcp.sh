#!/usr/bin/env bash

# Script: manage-mcp.sh
# Purpose: Manage MCP (Model Context Protocol) servers for Claude Code
# Usage: ./scripts/manage-mcp.sh [command] [options]

set -euo pipefail

# Colors for output
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly BLUE='\033[0;34m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m' # No Color

# MCP Server Definitions
# Format: "name|command|description|transport"
# transport is optional, defaults to "stdio"
declare -a MCP_SERVERS=(
    "playwright|npx @playwright/mcp@latest|Browser automation and testing with Playwright|stdio"
    "perplexity-ask|npx server-perplexity-ask|AI-powered web search and research|stdio"
    "context7|npx @upstash/context7-mcp@latest|Context management and retrieval|stdio"
    "fetch|npx @kazuph/mcp-fetch|HTTP fetch and web scraping|stdio"
    "basic-memory|uvx basic-memory mcp|Simple memory and note-taking|stdio"
    "chrome-devtools|npx chrome-devtools-mcp@latest|Chrome DevTools integration|stdio"
    "shadcn-ui-server|npx @heilgar/shadcn-ui-mcp-server|shadcn/ui component library|stdio"
    "figma-dev-mode|--transport sse http://127.0.0.1:3845/sse|Figma Dev Mode integration|sse"
)

# Default scope
DEFAULT_SCOPE="local"

# Valid scopes
declare -a VALID_SCOPES=("local" "project" "user")

# Find Claude CLI
find_claude_cli() {
    # Try common locations
    local claude_paths=(
        "$HOME/.claude/local/claude"
        "/usr/local/bin/claude"
        "/opt/homebrew/bin/claude"
    )

    # First try 'which' command (works if claude is in PATH)
    if command -v claude &> /dev/null; then
        command -v claude
        return 0
    fi

    # Try common installation paths
    for path in "${claude_paths[@]}"; do
        if [[ -x "$path" ]]; then
            echo "$path"
            return 0
        fi
    done

    return 1
}

# Get Claude CLI path
CLAUDE_CLI=$(find_claude_cli)
if [[ -z "$CLAUDE_CLI" ]]; then
    echo -e "${RED}Error: Claude CLI not found${NC}" >&2
    echo "Please install Claude Code CLI first." >&2
    echo "Visit: https://docs.claude.com/en/docs/claude-code" >&2
    exit 1
fi

# Functions
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}→ $1${NC}"
}

print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}   $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
    echo
}

usage() {
    echo -e "${CYAN}MCP Server Manager for Claude Code${NC}"
    echo
    echo -e "${YELLOW}Usage:${NC}"
    echo "    $0 <command> [options]"
    echo
    echo -e "${YELLOW}Commands:${NC}"
    echo "    list                    List all available MCP servers"
    echo "    install <name>          Install a specific MCP server"
    echo "    install                 Interactive installation (select from list)"
    echo "    remove <name>           Remove/uninstall a specific MCP server"
    echo "    info <name>             Show detailed information about an MCP server"
    echo "    help                    Show this help message"
    echo
    echo -e "${YELLOW}Options:${NC}"
    echo "    --local                 Install in local scope (current directory)"
    echo "    --user                  Install in user scope (all projects)"
    echo "    --scope <scope>         Specify installation scope (local|project|user)"
    echo "    -h, --help              Show this help message"
    echo
    echo -e "${YELLOW}Installation Scopes:${NC}"
    echo "    local (default)         Current directory only"
    echo "    project                 Current project workspace (creates .mcp.json)"
    echo "    user                    All projects for current user"
    echo
    echo -e "${YELLOW}Examples:${NC}"
    echo "    # List all available MCP servers"
    echo "    $0 list"
    echo
    echo "    # Install playwright for current directory (default)"
    echo "    $0 install playwright"
    echo
    echo "    # Install playwright for project workspace (creates .mcp.json)"
    echo "    $0 install playwright --scope project"
    echo
    echo "    # Install playwright for all projects"
    echo "    $0 install playwright --user"
    echo
    echo "    # Interactive installation"
    echo "    $0 install"
    echo
    echo "    # Remove a server"
    echo "    $0 remove playwright"
    echo
    echo "    # Show server information"
    echo "    $0 info playwright"
    echo
    echo -e "${YELLOW}Reference:${NC}"
    echo "    https://docs.claude.com/en/docs/claude-code/mcp"
    echo
    exit 0
}

# Validate scope
validate_scope() {
    local scope="$1"
    for valid_scope in "${VALID_SCOPES[@]}"; do
        if [[ "$scope" == "$valid_scope" ]]; then
            return 0
        fi
    done
    return 1
}

# Parse MCP server entry
parse_mcp_entry() {
    local entry="$1"
    local field="$2"

    IFS='|' read -r name command description transport <<< "$entry"

    case "$field" in
        name) echo "$name" ;;
        command) echo "$command" ;;
        description) echo "$description" ;;
        transport) echo "${transport:-stdio}" ;;
        *) echo "" ;;
    esac
}

# List all available MCP servers
list_servers() {
    print_header "Available MCP Servers"

    # Create a temporary array with name|entry pairs for sorting
    local -a sorted_entries=()
    for entry in "${MCP_SERVERS[@]}"; do
        local name
        name=$(parse_mcp_entry "$entry" "name")
        sorted_entries+=("$name|$entry")
    done

    # Sort alphabetically by name
    mapfile -t sorted_entries < <(printf '%s\n' "${sorted_entries[@]}" | sort)

    local index=1
    for sorted_entry in "${sorted_entries[@]}"; do
        # Extract the original entry after the pipe
        local entry="${sorted_entry#*|}"
        local name description
        name=$(parse_mcp_entry "$entry" "name")
        description=$(parse_mcp_entry "$entry" "description")

        echo -e "${CYAN}[$index]${NC} ${GREEN}$name${NC}"
        echo -e "    ${YELLOW}Description:${NC} $description"
        echo
        ((index++))
    done
}

# Show detailed information about a server
show_server_info() {
    local server_name="$1"

    for entry in "${MCP_SERVERS[@]}"; do
        local name command description transport
        name=$(parse_mcp_entry "$entry" "name")

        if [[ "$name" == "$server_name" ]]; then
            command=$(parse_mcp_entry "$entry" "command")
            description=$(parse_mcp_entry "$entry" "description")
            transport=$(parse_mcp_entry "$entry" "transport")

            print_header "MCP Server: $name"
            echo -e "${YELLOW}Name:${NC}        $name"
            echo -e "${YELLOW}Description:${NC} $description"
            echo -e "${YELLOW}Command:${NC}     $command"
            echo -e "${YELLOW}Transport:${NC}   $transport"
            echo
            return 0
        fi
    done

    print_error "MCP server '$server_name' not found"
    echo "Run '$0 list' to see available servers"
    exit 1
}

# Find MCP server by name
find_mcp_server() {
    local server_name="$1"

    for entry in "${MCP_SERVERS[@]}"; do
        local name
        name=$(parse_mcp_entry "$entry" "name")
        if [[ "$name" == "$server_name" ]]; then
            echo "$entry"
            return 0
        fi
    done

    return 1
}

# Interactive server selection
select_server_interactive() {
    print_header "Select MCP Server to Install" >&2

    # Create a temporary array with name|entry pairs for sorting
    local -a sorted_entries=()
    for entry in "${MCP_SERVERS[@]}"; do
        local name
        name=$(parse_mcp_entry "$entry" "name")
        sorted_entries+=("$name|$entry")
    done

    # Sort alphabetically by name
    mapfile -t sorted_entries < <(printf '%s\n' "${sorted_entries[@]}" | sort)

    local index=1
    for sorted_entry in "${sorted_entries[@]}"; do
        # Extract the original entry after the pipe
        local entry="${sorted_entry#*|}"
        local name description
        name=$(parse_mcp_entry "$entry" "name")
        description=$(parse_mcp_entry "$entry" "description")
        echo -e "${CYAN}[$index]${NC} ${GREEN}$name${NC} - $description" >&2
        ((index++))
    done

    echo >&2
    read -rp "Enter number (1-${#sorted_entries[@]}) or 'q' to quit: " selection

    if [[ "$selection" == "q" ]] || [[ "$selection" == "Q" ]]; then
        echo "Installation cancelled" >&2
        echo "" # Return empty string
        return 0
    fi

    if ! [[ "$selection" =~ ^[0-9]+$ ]] || [ "$selection" -lt 1 ] || [ "$selection" -gt "${#sorted_entries[@]}" ]; then
        print_error "Invalid selection"
        echo "" # Return empty string
        return 1
    fi

    # Get the selected entry from sorted array
    local selected_sorted_entry="${sorted_entries[$((selection - 1))]}"
    local selected_entry="${selected_sorted_entry#*|}"
    parse_mcp_entry "$selected_entry" "name"
}

# Interactive scope selection
select_scope_interactive() {
    echo >&2
    print_header "Select Installation Scope" >&2
    echo >&2
    echo -e "${CYAN}[1]${NC} ${GREEN}local${NC} (default)    - Current directory only" >&2
    echo -e "${CYAN}[2]${NC} ${GREEN}project${NC}            - Current project workspace (creates .mcp.json)" >&2
    echo -e "${CYAN}[3]${NC} ${GREEN}user${NC}               - All projects for current user" >&2
    echo >&2
    read -rp "Enter number (1-3) or press Enter for default [1]: " scope_selection

    # Default to local if empty
    if [[ -z "$scope_selection" ]]; then
        scope_selection="1"
    fi

    if [[ "$scope_selection" == "q" ]] || [[ "$scope_selection" == "Q" ]]; then
        echo "Installation cancelled" >&2
        echo "" # Return empty string
        return 0
    fi

    case "$scope_selection" in
        1)
            echo "local"
            ;;
        2)
            echo "project"
            ;;
        3)
            echo "user"
            ;;
        *)
            print_error "Invalid selection"
            echo "" # Return empty string
            return 1
            ;;
    esac
}

# Install MCP server
install_server() {
    local server_name="$1"
    local scope="${2:-$DEFAULT_SCOPE}"

    # Validate scope
    if ! validate_scope "$scope"; then
        print_error "Invalid scope: $scope"
        echo "Valid scopes: local, project, user"
        exit 1
    fi

    local entry
    if ! entry=$(find_mcp_server "$server_name"); then
        print_error "MCP server '$server_name' not found"
        echo "Run '$0 list' to see available servers"
        exit 1
    fi

    local command
    command=$(parse_mcp_entry "$entry" "command")

    print_header "Installing MCP Server: $server_name"
    print_info "Scope: $scope"
    print_info "Command: $command"
    echo

    # Build claude mcp add command
    local claude_cmd="$CLAUDE_CLI mcp add $server_name $command --scope $scope"

    print_info "Executing: $claude_cmd"
    echo

    if eval "$claude_cmd"; then
        echo
        print_success "Successfully installed '$server_name' MCP server"
        echo
        print_info "The server is now available in Claude Code"
        case "$scope" in
            local)
                print_info "Scope: Current directory only"
                ;;
            project)
                print_info "Scope: Current project workspace (creates .mcp.json)"
                ;;
            user)
                print_info "Scope: All projects for current user"
                ;;
        esac
    else
        echo
        print_error "Failed to install '$server_name' MCP server"
        exit 1
    fi
}

# Remove MCP server
remove_server() {
    local server_name="$1"

    print_header "Removing MCP Server: $server_name"

    # Verify server exists in our list
    if ! find_mcp_server "$server_name" > /dev/null; then
        print_error "MCP server '$server_name' not found in available servers"
        echo "Note: You can still try to remove it if it was installed manually"
        read -rp "Continue with removal? (y/N): " confirm
        if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
            echo "Removal cancelled"
            exit 0
        fi
    fi

    print_info "Executing: $CLAUDE_CLI mcp remove $server_name"
    echo

    if "$CLAUDE_CLI" mcp remove "$server_name"; then
        echo
        print_success "Successfully removed '$server_name' MCP server"
    else
        echo
        print_error "Failed to remove '$server_name' MCP server"
        print_info "The server might not be installed or the name is incorrect"
        exit 1
    fi
}

# Main function
main() {
    local command="${1:-}"
    local server_name=""
    local scope="$DEFAULT_SCOPE"
    local scope_explicitly_set=false

    # Parse all arguments
    shift || true
    while [[ $# -gt 0 ]]; do
        case "${1:-}" in
            --local)
                scope="local"
                scope_explicitly_set=true
                shift
                ;;
            --user)
                scope="user"
                scope_explicitly_set=true
                shift
                ;;
            --scope)
                scope="${2:-}"
                scope_explicitly_set=true
                shift 2
                ;;
            *)
                if [[ -z "$server_name" ]]; then
                    server_name="$1"
                fi
                shift
                ;;
        esac
    done

    case "$command" in
        list)
            list_servers
            ;;
        install)
            if [[ -z "$server_name" ]]; then
                server_name=$(select_server_interactive)
                if [[ -z "$server_name" ]]; then
                    exit 0
                fi
                # If no scope was specified via command line, ask interactively
                if [[ "$scope_explicitly_set" == false ]]; then
                    scope=$(select_scope_interactive)
                    if [[ -z "$scope" ]]; then
                        exit 0
                    fi
                fi
            fi
            install_server "$server_name" "$scope"
            ;;
        remove | uninstall)
            if [[ -z "$server_name" ]]; then
                print_error "Server name required for removal"
                echo "Usage: $0 remove <server-name>"
                exit 1
            fi
            remove_server "$server_name"
            ;;
        info)
            if [[ -z "$server_name" ]]; then
                print_error "Server name required"
                echo "Usage: $0 info <server-name>"
                exit 1
            fi
            show_server_info "$server_name"
            ;;
        help | -h | --help)
            usage
            ;;
        "")
            print_error "No command specified"
            echo
            usage
            ;;
        *)
            print_error "Unknown command: $command"
            echo
            usage
            ;;
    esac
}

# Run main function
main "$@"
