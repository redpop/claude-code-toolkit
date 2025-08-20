#!/usr/bin/env bash
set -euo pipefail

# Script: generate-help.sh
# Purpose: Generate help output for Claude Code Toolkit commands
# Usage: ./generate-help.sh <command-path>
#
# Examples:
#   ./generate-help.sh scan/deep.md
#   ./generate-help.sh git/conflict-resolver.md
#   ./generate-help.sh meta/pipelines.md

# Constants
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPT_DIR
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
readonly ROOT_DIR
COMMANDS_DIR="$ROOT_DIR/commands"
readonly COMMANDS_DIR

# Colors for output formatting (will be set conditionally)
COLOR_BOLD='\033[1m'
COLOR_GREEN='\033[0;32m'
COLOR_YELLOW='\033[0;33m'
COLOR_CYAN='\033[0;36m'
COLOR_RESET='\033[0m'

# Functions
function usage() {
    cat << EOF
Usage: $0 <command-path>

Generate formatted help output for Claude Code Toolkit commands.

Arguments:
  command-path    Path to command markdown file (relative to commands/)
                  Examples: scan/deep.md, git/conflict-resolver.md

Options:
  -h, --help      Show this help message
  --no-color      Disable colored output
  --raw           Output raw text without formatting

Examples:
  $0 scan/deep.md
  $0 git/conflict-resolver.md
  $0 meta/pipelines.md --no-color

The script parses YAML frontmatter and markdown content to generate
CLI-style help output with description, usage, options, and examples.
EOF
    exit 0
}

function error() {
    echo "Error: $1" >&2
    exit 1
}

function warn() {
    echo "Warning: $1" >&2
}

function info() {
    echo "Info: $1" >&2
}

# Parse command line arguments
USE_COLOR=true
RAW_OUTPUT=false
COMMAND_PATH=""

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        --no-color)
            USE_COLOR=false
            shift
            ;;
        --raw)
            RAW_OUTPUT=true
            USE_COLOR=false
            shift
            ;;
        -*)
            error "Unknown option: $1"
            ;;
        *)
            if [[ -z "$COMMAND_PATH" ]]; then
                COMMAND_PATH="$1"
            else
                error "Too many arguments. Expected one command path."
            fi
            shift
            ;;
    esac
done

# Validate arguments
if [[ -z "$COMMAND_PATH" ]]; then
    error "Command path is required. Use --help for usage information."
fi

# Construct full path to command file
if [[ "$COMMAND_PATH" == /* ]]; then
    # Absolute path provided
    FULL_COMMAND_PATH="$COMMAND_PATH"
else
    # Relative path - relative to commands directory
    FULL_COMMAND_PATH="$COMMANDS_DIR/$COMMAND_PATH"
fi

# Validate command file exists
if [[ ! -f "$FULL_COMMAND_PATH" ]]; then
    error "Command file not found: $FULL_COMMAND_PATH"
fi

# Set colors based on options and terminal capability
if [[ "$USE_COLOR" == "false" ]] || [[ ! -t 1 ]]; then
    # Disable colors
    COLOR_BOLD=""
    COLOR_GREEN=""
    COLOR_YELLOW=""
    COLOR_CYAN=""
    COLOR_RESET=""
fi

# Set working color variables
C_BOLD="$COLOR_BOLD"
C_GREEN="$COLOR_GREEN"
C_YELLOW="$COLOR_YELLOW"
C_CYAN="$COLOR_CYAN"
C_RESET="$COLOR_RESET"

# Function to extract YAML frontmatter
function extract_frontmatter() {
    local file="$1"
    local in_frontmatter=false
    local frontmatter=""
    
    while IFS= read -r line; do
        if [[ "$line" == "---" ]]; then
            if [[ "$in_frontmatter" == "false" ]]; then
                in_frontmatter=true
                continue
            else
                break
            fi
        fi
        
        if [[ "$in_frontmatter" == "true" ]]; then
            frontmatter+="$line"$'\n'
        fi
    done < "$file"
    
    echo "$frontmatter"
}

# Function to extract YAML field value
function get_yaml_field() {
    local yaml_content="$1"
    local field="$2"
    
    # Handle simple string fields
    echo "$yaml_content" | grep "^$field:" | sed "s/^$field: *//" | sed 's/^"//' | sed 's/"$//' || true
}

# Function to extract YAML array field
function get_yaml_array() {
    local yaml_content="$1"
    local field="$2"
    
    # Extract array items (simplified parser)
    echo "$yaml_content" | awk "
        BEGIN { in_array = 0 }
        /^$field:/ { in_array = 1; next }
        /^[a-zA-Z]/ && in_array { in_array = 0 }
        in_array && /^  - / { 
            sub(/^  - /, \"\")
            print
        }
    " || true
}

# Function to extract options from YAML (more complex structure)
function extract_options() {
    local yaml_content="$1"
    local in_options=false
    local current_option=""
    
    echo "$yaml_content" | while IFS= read -r line; do
        if [[ "$line" =~ ^options: ]]; then
            in_options=true
            continue
        fi
        
        if [[ "$in_options" == "true" ]]; then
            # Check if we've hit another top-level field
            if [[ "$line" =~ ^[a-zA-Z-]+: ]] && [[ ! "$line" =~ ^[[:space:]] ]]; then
                break
            fi
            
            # Parse option entries
            if [[ "$line" =~ ^[[:space:]]*-[[:space:]]*name: ]]; then
                if [[ -n "$current_option" ]]; then
                    echo "$current_option"
                fi
                current_option="${line#*name: }"
                current_option="${current_option# }"
            elif [[ "$line" =~ ^[[:space:]]*description: ]] && [[ -n "$current_option" ]]; then
                local desc="${line#*description: }"
                desc="${desc# }"
                echo "${current_option}:${desc}"
                current_option=""
            elif [[ "$line" =~ ^[[:space:]]*values: ]]; then
                # Handle values array - simplified for now
                continue
            fi
        fi
    done
    
    # Handle last option if exists
    if [[ -n "$current_option" ]]; then
        echo "$current_option"
    fi
}

# Function to get command name from path
function get_command_name() {
    local path="$1"
    
    # For absolute paths, try to extract relative to commands directory
    if [[ "$path" == /* ]]; then
        # Check if path is within commands directory
        if [[ "$path" == "$COMMANDS_DIR"/* ]]; then
            path="${path#"$COMMANDS_DIR"/}"
        else
            # For external files, just use filename
            path=$(basename "$path" .md)
        fi
    fi
    
    local category
    category=$(dirname "$path")
    local name
    name=$(basename "$path" .md)
    
    if [[ "$category" == "." ]]; then
        echo "$name"
    else
        echo "$category:$name"
    fi
}

# Function to format help output
function format_help() {
    local frontmatter="$1"
    local command_name="$2"
    
    # Extract fields from frontmatter
    local description
    description=$(get_yaml_field "$frontmatter" "description")
    local argument_hint
    argument_hint=$(get_yaml_field "$frontmatter" "argument-hint")
    local mcp_enhanced
    mcp_enhanced=$(get_yaml_field "$frontmatter" "mcp-enhanced")
    
    # Generate help output
    if [[ "$RAW_OUTPUT" == "true" ]]; then
        # Raw output format
        echo "COMMAND: /prefix:$command_name"
        [[ -n "$description" ]] && echo "DESCRIPTION: $description"
        [[ -n "$argument_hint" ]] && echo "USAGE: /prefix:$command_name $argument_hint"
        [[ -n "$mcp_enhanced" ]] && echo "MCP-ENHANCED: $mcp_enhanced"
    else
        # Formatted output
        echo -e "${C_BOLD}NAME${C_RESET}"
        echo -e "    ${C_GREEN}/prefix:$command_name${C_RESET}"
        echo ""
        
        if [[ -n "$description" ]]; then
            echo -e "${C_BOLD}DESCRIPTION${C_RESET}"
            echo "    $description"
            echo ""
        fi
        
        if [[ -n "$argument_hint" ]]; then
            echo -e "${C_BOLD}USAGE${C_RESET}"
            echo -e "    ${C_CYAN}/prefix:$command_name${C_RESET} $argument_hint"
            echo ""
        fi
        
        # Extract and format options
        local options_output=""
        options_output=$(extract_options "$frontmatter")
        
        if [[ -n "$options_output" ]]; then
            echo -e "${C_BOLD}OPTIONS${C_RESET}"
            while IFS=':' read -r opt_name opt_desc; do
                if [[ -n "$opt_name" ]] && [[ -n "$opt_desc" ]]; then
                    printf "    ${C_YELLOW}%-20s${C_RESET} %s\n" "$opt_name" "$opt_desc"
                fi
            done <<< "$options_output"
            echo ""
        fi
        
        # Extract examples from frontmatter
        local examples=""
        examples=$(get_yaml_array "$frontmatter" "examples")
        
        if [[ -n "$examples" ]]; then
            echo -e "${C_BOLD}EXAMPLES${C_RESET}"
            while IFS= read -r example; do
                if [[ -n "$example" ]]; then
                    echo -e "    ${C_CYAN}$example${C_RESET}"
                fi
            done <<< "$examples"
            echo ""
        fi
        
        # MCP enhancement notice
        if [[ -n "$mcp_enhanced" ]]; then
            echo -e "${C_BOLD}MCP ENHANCEMENT${C_RESET}"
            echo "    This command is enhanced with MCP servers: $mcp_enhanced"
            echo "    Enhanced functionality available when MCP servers are configured."
            echo ""
        fi
        
        # Footer
        echo -e "${C_BOLD}SEE ALSO${C_RESET}"
        echo "    Claude Code Toolkit documentation: docs/README.md"
        echo "    All commands: /prefix:meta:find-cmd"
    fi
}

# Main execution
function main() {
    # Validate dependencies
    if ! command -v grep >/dev/null 2>&1; then
        error "Required command 'grep' not found"
    fi
    
    if ! command -v awk >/dev/null 2>&1; then
        error "Required command 'awk' not found"
    fi
    
    if ! command -v sed >/dev/null 2>&1; then
        error "Required command 'sed' not found"
    fi
    
    # Extract frontmatter
    local frontmatter=""
    frontmatter=$(extract_frontmatter "$FULL_COMMAND_PATH")
    
    if [[ -z "$frontmatter" ]]; then
        warn "No YAML frontmatter found in $COMMAND_PATH"
        # Try to extract from first few lines anyway
        frontmatter=$(head -20 "$FULL_COMMAND_PATH")
    fi
    
    # Get command name
    local command_name=""
    command_name=$(get_command_name "$COMMAND_PATH")
    
    # Generate and output help
    format_help "$frontmatter" "$command_name"
}

# Trap for cleanup
trap 'echo -e "\nHelp generation interrupted" >&2; exit 130' INT

# Run main function
main "$@"