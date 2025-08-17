#!/bin/bash

# Claude Code Toolkit Installation Script
# Usage: ./install.sh <prefix>
# Example: ./install.sh mytools
# 
# This script MUST be run from the cloned repository directory

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_error() {
    echo -e "${RED}Error: $1${NC}" >&2
}

print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_info() {
    echo -e "${YELLOW}→ $1${NC}"
}

# Check if we're running from inside the repository
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
if [ ! -f "$SCRIPT_DIR/install.sh" ] || [ ! -d "$SCRIPT_DIR/commands" ] || [ ! -d "$SCRIPT_DIR/agents" ]; then
    print_error "This script must be run from inside the claude-code-toolkit repository."
    echo "Please clone the repository first:"
    echo "  git clone https://github.com/redpop/claude-code-toolkit.git"
    echo "  cd claude-code-toolkit"
    echo "  ./install.sh myprefix"
    exit 1
fi

# Default values
CLAUDE_COMMANDS_DIR="$HOME/.claude/commands"
CLAUDE_AGENTS_DIR="$HOME/.claude/agents"
CLAUDE_TOOLKIT_DIR="$HOME/.claude/claude-code-toolkit"
CLAUDE_SETTINGS_FILE="$HOME/.claude/settings.json"
FORCE_INSTALL=false
INSTALL_COMPONENTS="all"
LOCAL_INSTALL=false
LOCAL_PROJECT_DIR=""
INSTALL_HOOKS=false
INSTALL_SETTINGS=false
HOOKS_PROFILE="basic"  # basic, minimal, advanced

# Function to show help
show_help() {
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${GREEN}                       Claude Code Toolkit Installation                          ${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo
    echo -e "${YELLOW}USAGE${NC}"
    echo -e "  ${GREEN}./install.sh${NC} <prefix> [options]"
    echo
    echo -e "${YELLOW}ARGUMENTS${NC}"
    printf "  ${GREEN}%-20s${NC} %s\n" "<prefix>" "Your command prefix (e.g., 'mytools', 'global', 'team')"
    echo
    echo -e "${YELLOW}OPTIONS${NC}"
    printf "  ${GREEN}%-20s${NC} %s\n" "--help, -h" "Show this help message"
    printf "  ${GREEN}%-20s${NC} %s\n" "--force" "Force installation without creating backups"
    printf "  ${GREEN}%-20s${NC} %s\n" "--local <path>" "Install in specific project directory (.claude/)"
    printf "  ${GREEN}%-20s${NC} %s\n" "--install <items>" "Install specific components (comma-separated)"
    printf "  %-20s %s\n" "" "Available: ${YELLOW}commands${NC}, ${YELLOW}agents${NC}, ${YELLOW}hooks${NC}, ${YELLOW}all${NC} (default)"
    printf "  ${GREEN}%-20s${NC} %s\n" "--with-settings" "Install global settings.json for hooks"
    printf "  ${GREEN}%-20s${NC} %s\n" "--hooks-profile <p>" "Choose hooks configuration profile:"
    printf "  %-20s %s\n" "" "${YELLOW}basic${NC}    → Stop notification only (default)"
    printf "  %-20s %s\n" "" "${YELLOW}minimal${NC}  → Stop + critical error detection + markdown"
    printf "  %-20s %s\n" "" "${YELLOW}advanced${NC} → All hooks (sounds, notifications, logging)"
    echo
    echo -e "${YELLOW}EXAMPLES${NC}"
    echo
    echo -e "  ${GREEN}Quick Start:${NC}"
    printf "  %-60s %s\n" "./install.sh mytools" "# Standard installation"
    printf "  %-60s %s\n" "./install.sh mytools --with-settings" "# With hooks enabled"
    printf "  %-60s %s\n" "./install.sh global --with-settings --hooks-profile advanced" "# Full featured"
    echo
    echo -e "  ${GREEN}Component Selection:${NC}"
    printf "  %-60s %s\n" "./install.sh mytools --install commands" "# Commands only"
    printf "  %-60s %s\n" "./install.sh mytools --install agents" "# Agents only"
    printf "  %-60s %s\n" "./install.sh mytools --install commands,agents" "# Multiple components"
    printf "  %-60s %s\n" "./install.sh mytools --install hooks" "# Hooks only"
    echo
    echo -e "  ${GREEN}Advanced Usage:${NC}"
    printf "  %-60s %s\n" "./install.sh mytools --local /path/to/project" "# Project-specific"
    printf "  %-60s %s\n" "./install.sh global --force" "# Force reinstall"
    printf "  %-60s %s\n" "./install.sh mytools --with-settings --hooks-profile minimal" "# Minimal hooks"
    echo
    echo -e "${YELLOW}COMMAND FORMAT${NC}"
    echo -e "  After installation, use commands as:"
    echo -e "  ${GREEN}/<prefix>:<category>:<command>${NC}"
    echo
    echo -e "  Examples with prefix '${YELLOW}mytools${NC}':"
    echo -e "  • /mytools:scan:deep     ${GREEN}→${NC} Deep code analysis"
    echo -e "  • /mytools:fix:security  ${GREEN}→${NC} Security fixes"
    echo -e "  • /mytools:git:commit    ${GREEN}→${NC} Smart git commits"
    echo
    echo -e "${YELLOW}COMPONENTS${NC}"
    echo -e "  ${GREEN}Commands${NC}  → 50+ development commands"
    echo -e "  ${GREEN}Agents${NC}    → 15+ specialized AI agents"
    echo -e "  ${GREEN}Hooks${NC}     → 9 automation scripts"
    echo
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "  📚 Docs: ${GREEN}github.com/redpop/claude-code-toolkit${NC}"
    echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Parse command line arguments
PREFIX=""
while [[ $# -gt 0 ]]; do
    case $1 in
        --help|-h)
            show_help
            exit 0
            ;;
        --force)
            FORCE_INSTALL=true
            shift
            ;;
        --local)
            LOCAL_INSTALL=true
            # Check if next argument is provided and is a path (not starting with --)
            if [ -z "$2" ] || [[ "$2" == --* ]]; then
                print_error "Option --local requires a project path"
                echo "Example: ./install.sh mytools --local /path/to/project"
                exit 1
            fi
            LOCAL_PROJECT_DIR="$2"
            shift 2
            ;;
        --install)
            if [ -z "$2" ] || [[ "$2" == --* ]]; then
                print_error "Option --install requires a value"
                exit 1
            fi
            INSTALL_COMPONENTS="$2"
            shift 2
            ;;
        --with-settings)
            INSTALL_SETTINGS=true
            shift
            ;;
        --hooks-profile)
            if [ -z "$2" ] || [[ "$2" == --* ]]; then
                print_error "Option --hooks-profile requires a value"
                exit 1
            fi
            case "$2" in
                basic|minimal|advanced)
                    HOOKS_PROFILE="$2"
                    ;;
                *)
                    print_error "Invalid hooks profile: $2"
                    echo "Available profiles: basic, minimal, advanced"
                    exit 1
                    ;;
            esac
            shift 2
            ;;
        -*)
            print_error "Unknown option: $1"
            echo "Run './install.sh --help' for more information."
            exit 1
            ;;
        *)
            if [ -z "$PREFIX" ]; then
                PREFIX="$1"
            else
                print_error "Too many arguments. Only one prefix is allowed."
                exit 1
            fi
            shift
            ;;
    esac
done

# Check if prefix is provided
if [ -z "$PREFIX" ]; then
    print_error "No prefix provided. Usage: ./install.sh <prefix> [options]"
    echo "Example: ./install.sh mytools"
    echo ""
    echo "Run './install.sh --help' for more information."
    exit 1
fi

# Parse install components
INSTALL_COMMANDS=false
INSTALL_AGENTS=false

IFS=',' read -ra COMPONENTS <<< "$INSTALL_COMPONENTS"
for component in "${COMPONENTS[@]}"; do
    case "$component" in
        all)
            INSTALL_COMMANDS=true
            INSTALL_AGENTS=true
            INSTALL_HOOKS=true
            ;;
        commands)
            INSTALL_COMMANDS=true
            ;;
        agents)
            INSTALL_AGENTS=true
            ;;
        hooks)
            INSTALL_HOOKS=true
            ;;
        *)
            print_error "Unknown component: $component"
            echo "Available components: commands, agents, hooks, all"
            exit 1
            ;;
    esac
done

# Check if at least one component is selected
if [ "$INSTALL_COMMANDS" = false ] && [ "$INSTALL_AGENTS" = false ] && [ "$INSTALL_HOOKS" = false ]; then
    print_error "No components selected for installation."
    echo "Use --install with one or more of: commands, agents, hooks, all"
    exit 1
fi

# Update paths if local installation is requested
if [ "$LOCAL_INSTALL" = true ]; then
    # Use specified project directory (now required)
    if [ ! -d "$LOCAL_PROJECT_DIR" ]; then
        print_error "Project directory does not exist: $LOCAL_PROJECT_DIR"
        exit 1
    fi
    LOCAL_DIR="$(cd "$LOCAL_PROJECT_DIR" && pwd)/.claude"
    
    # Check if it's a git project
    if [ ! -d "$LOCAL_PROJECT_DIR/.git" ]; then
        print_info "Warning: $LOCAL_PROJECT_DIR is not a git repository. Installing anyway."
    fi
    
    CLAUDE_COMMANDS_DIR="$LOCAL_DIR/commands"
    CLAUDE_AGENTS_DIR="$LOCAL_DIR/agents"
    CLAUDE_TOOLKIT_DIR="$LOCAL_DIR/claude-code-toolkit"
    
    print_info "Installing locally in: $LOCAL_DIR"
fi

# Check for updates if already installed
if [ -f "$CLAUDE_TOOLKIT_DIR/.installed-version" ]; then
    print_info "Checking for updates..."
    
    # Read the old commit hash
    OLD_HASH=$(grep "^COMMIT_HASH=" "$CLAUDE_TOOLKIT_DIR/.installed-version" 2>/dev/null | cut -d= -f2)
    OLD_DATE=$(grep "^INSTALLED_AT=" "$CLAUDE_TOOLKIT_DIR/.installed-version" 2>/dev/null | cut -d= -f2-)
    
    if [ -n "$OLD_HASH" ] && [ "$OLD_HASH" != "unknown" ]; then
        # Get current hash
        CURRENT_HASH=$(cd "$SCRIPT_DIR" && git rev-parse HEAD 2>/dev/null || echo "unknown")
        
        if [ "$CURRENT_HASH" != "unknown" ] && [ "$OLD_HASH" != "$CURRENT_HASH" ]; then
            # Count new commits
            NEW_COMMITS=$(cd "$SCRIPT_DIR" && git rev-list "$OLD_HASH"..HEAD --count 2>/dev/null || echo "0")
            
            if [ "$NEW_COMMITS" -gt 0 ]; then
                echo
                echo -e "${GREEN}📦 Found $NEW_COMMITS new commits since last installation (installed: $OLD_DATE)${NC}"
                echo -e "${YELLOW}Recent changes:${NC}"
                echo
                # Show up to 15 recent commits
                cd "$SCRIPT_DIR" && git log "$OLD_HASH"..HEAD --oneline --no-decorate | head -15 | while IFS= read -r line; do
                    echo "  $line"
                done
                echo
            else
                print_success "Already up to date (commit: ${OLD_HASH:0:7})"
            fi
        elif [ "$OLD_HASH" = "$CURRENT_HASH" ]; then
            print_success "Already up to date (commit: ${OLD_HASH:0:7})"
        fi
    fi
fi

COMMANDS_INSTALL_PATH="$CLAUDE_COMMANDS_DIR/$PREFIX"

# Create Claude directories if they don't exist
if [ "$INSTALL_COMMANDS" = true ] && [ ! -d "$CLAUDE_COMMANDS_DIR" ]; then
    print_info "Creating Claude commands directory: $CLAUDE_COMMANDS_DIR"
    mkdir -p "$CLAUDE_COMMANDS_DIR"
fi

if [ "$INSTALL_AGENTS" = true ] && [ ! -d "$CLAUDE_AGENTS_DIR" ]; then
    print_info "Creating Claude agents directory: $CLAUDE_AGENTS_DIR"
    mkdir -p "$CLAUDE_AGENTS_DIR"
fi

# Handle commands installation
if [ "$INSTALL_COMMANDS" = true ]; then
    # Check if prefix directory already exists
    if [ -d "$COMMANDS_INSTALL_PATH" ]; then
        if [ "$FORCE_INSTALL" = true ]; then
            print_info "Force mode: Removing existing installation without backup..."
            rm -rf "$COMMANDS_INSTALL_PATH"
        else
            echo -e "${YELLOW}Warning: Directory $COMMANDS_INSTALL_PATH already exists.${NC}"
            read -p "Replace existing installation? (y/N) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                print_info "Backing up existing installation..."
                mv "$COMMANDS_INSTALL_PATH" "${COMMANDS_INSTALL_PATH}.backup.$(date +%Y%m%d_%H%M%S)"
                print_info "Old installation backed up"
            else
                print_info "Skipping commands installation."
                INSTALL_COMMANDS=false
            fi
        fi
    fi

    # Copy commands
    if [ "$INSTALL_COMMANDS" = true ]; then
        print_info "Installing commands to $COMMANDS_INSTALL_PATH..."
        mkdir -p "$COMMANDS_INSTALL_PATH"
        # Copy all files except CLAUDE.md
        find "$SCRIPT_DIR/commands" -type f -name "*.md" ! -name "CLAUDE.md" -exec cp {} "$COMMANDS_INSTALL_PATH/" \; 2>/dev/null || true
        # Copy subdirectories
        find "$SCRIPT_DIR/commands" -mindepth 1 -type d -exec cp -r {} "$COMMANDS_INSTALL_PATH/" \; 2>/dev/null || true
    fi
fi

# Handle agents installation
if [ "$INSTALL_AGENTS" = true ]; then
    # Check if any agents already exist
    EXISTING_AGENTS=()
    if [ -d "$CLAUDE_AGENTS_DIR" ]; then
        while IFS= read -r -d '' agent_file; do
            agent_name=$(basename "$agent_file")
            if [ -f "$SCRIPT_DIR/agents/$agent_name" ]; then
                EXISTING_AGENTS+=("$agent_name")
            fi
        done < <(find "$CLAUDE_AGENTS_DIR" -name "*.md" -type f -print0 2>/dev/null)
    fi

    # Warn about existing agents
    if [ ${#EXISTING_AGENTS[@]} -gt 0 ]; then
        if [ "$FORCE_INSTALL" = true ]; then
            print_info "Force mode: Overwriting existing agents without backup..."
            # No backup, just let the copy command overwrite
        else
            echo -e "${YELLOW}Warning: The following agents already exist in $CLAUDE_AGENTS_DIR:${NC}"
            for agent in "${EXISTING_AGENTS[@]}"; do
                echo "  - $agent"
            done
            read -p "Replace existing agents? (y/N) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                print_info "Backing up existing agents..."
                AGENTS_BACKUP_DIR="${CLAUDE_AGENTS_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
                mkdir -p "$AGENTS_BACKUP_DIR"
                for agent in "${EXISTING_AGENTS[@]}"; do
                    cp "$CLAUDE_AGENTS_DIR/$agent" "$AGENTS_BACKUP_DIR/" 2>/dev/null || true
                done
                print_info "Existing agents backed up to: $AGENTS_BACKUP_DIR"
            else
                print_info "Skipping agent installation to preserve existing agents."
                INSTALL_AGENTS=false
            fi
        fi
    fi

    # Copy agents
    if [ "$INSTALL_AGENTS" = true ]; then
        print_info "Installing agents to $CLAUDE_AGENTS_DIR..."
        # Copy all MD files except CLAUDE.md
        find "$SCRIPT_DIR/agents" -maxdepth 1 -type f -name "*.md" ! -name "CLAUDE.md" -exec cp {} "$CLAUDE_AGENTS_DIR/" \; 2>/dev/null || true
    fi
fi

# Install knowledge-base to claude-code-toolkit directory
if [ -d "$SCRIPT_DIR/knowledge-base" ]; then
    print_info "Installing knowledge-base to $CLAUDE_TOOLKIT_DIR..."
    mkdir -p "$CLAUDE_TOOLKIT_DIR"
    
    # Check if knowledge-base already exists
    if [ -d "$CLAUDE_TOOLKIT_DIR/knowledge-base" ]; then
        if [ "$FORCE_INSTALL" = true ]; then
            print_info "Force mode: Overwriting existing knowledge-base..."
            rm -rf "$CLAUDE_TOOLKIT_DIR/knowledge-base"
        else
            print_info "Backing up existing knowledge-base..."
            mv "$CLAUDE_TOOLKIT_DIR/knowledge-base" "$CLAUDE_TOOLKIT_DIR/knowledge-base.backup.$(date +%Y%m%d_%H%M%S)"
        fi
    fi
    
    # Create knowledge-base directory structure
    mkdir -p "$CLAUDE_TOOLKIT_DIR/knowledge-base"
    # Copy all files except CLAUDE.md while preserving directory structure
    (cd "$SCRIPT_DIR" && find knowledge-base -type f ! -name "CLAUDE.md" -exec bash -c 'dest="$1/${2#./}"; mkdir -p "$(dirname "$dest")"; cp "$2" "$dest"' _ "$CLAUDE_TOOLKIT_DIR" {} \;)
    print_success "Knowledge-base installed to $CLAUDE_TOOLKIT_DIR/knowledge-base"
fi

# Install hooks to claude-code-toolkit directory
if [ "$INSTALL_HOOKS" = true ] && [ -d "$SCRIPT_DIR/hooks" ]; then
    print_info "Installing hooks to $CLAUDE_TOOLKIT_DIR/hooks..."
    mkdir -p "$CLAUDE_TOOLKIT_DIR"
    
    # Check if hooks already exist
    if [ -d "$CLAUDE_TOOLKIT_DIR/hooks" ]; then
        if [ "$FORCE_INSTALL" = true ]; then
            print_info "Force mode: Overwriting existing hooks..."
            rm -rf "$CLAUDE_TOOLKIT_DIR/hooks"
        else
            print_info "Backing up existing hooks..."
            mv "$CLAUDE_TOOLKIT_DIR/hooks" "$CLAUDE_TOOLKIT_DIR/hooks.backup.$(date +%Y%m%d_%H%M%S)"
        fi
    fi
    
    # Create hooks directory
    mkdir -p "$CLAUDE_TOOLKIT_DIR/hooks"
    # Copy only shell scripts (not CLAUDE.md)
    find "$SCRIPT_DIR/hooks" -maxdepth 1 -type f -name "*.sh" -exec cp {} "$CLAUDE_TOOLKIT_DIR/hooks/" \; 2>/dev/null || true
    # Copy markdownlint config to markdown subdirectory
    if [ -f "$SCRIPT_DIR/.markdownlint-cli2.jsonc" ]; then
        mkdir -p "$CLAUDE_TOOLKIT_DIR/markdown"
        cp "$SCRIPT_DIR/.markdownlint-cli2.jsonc" "$CLAUDE_TOOLKIT_DIR/markdown/"
        print_info "Markdownlint config installed to $CLAUDE_TOOLKIT_DIR/markdown/.markdownlint-cli2.jsonc"
    fi
    # Ensure scripts are executable
    chmod +x "$CLAUDE_TOOLKIT_DIR/hooks"/*.sh 2>/dev/null || true
    print_success "Hooks installed to $CLAUDE_TOOLKIT_DIR/hooks"
fi

# Install global settings if requested
if [ "$INSTALL_SETTINGS" = true ]; then
    # Determine which settings file to use based on profile
    case "$HOOKS_PROFILE" in
        minimal)
            SETTINGS_SOURCE="$SCRIPT_DIR/settings/minimal-hooks-settings.json"
            PROFILE_DESC="minimal (stop + critical errors)"
            ;;
        advanced)
            SETTINGS_SOURCE="$SCRIPT_DIR/settings/advanced-hooks-settings.json"
            PROFILE_DESC="advanced (all hooks active)"
            ;;
        basic|*)
            SETTINGS_SOURCE="$SCRIPT_DIR/settings/basic-hooks-settings.json"
            PROFILE_DESC="basic (stop notification only)"
            ;;
    esac
    
    if [ ! -f "$SETTINGS_SOURCE" ]; then
        print_error "Settings file not found: $SETTINGS_SOURCE"
        exit 1
    fi
    
    print_info "Installing $PROFILE_DESC hooks settings..."
    
    # Check if settings.json already exists
    if [ -f "$CLAUDE_SETTINGS_FILE" ]; then
        if [ "$FORCE_INSTALL" = true ]; then
            print_info "Force mode: Installing $PROFILE_DESC settings..."
            # Backup existing settings
            cp "$CLAUDE_SETTINGS_FILE" "${CLAUDE_SETTINGS_FILE}.backup.$(date +%Y%m%d_%H%M%S)"
            
            # Use Python to merge if available, preserving non-hook settings
            if command -v python3 &> /dev/null; then
                python3 -c "
import json
import sys

# Read existing settings
try:
    with open('$CLAUDE_SETTINGS_FILE', 'r') as f:
        existing = json.load(f)
except:
    existing = {}

# Read new hook settings
with open('$SETTINGS_SOURCE', 'r') as f:
    new_settings = json.load(f)

# Merge settings (hooks get replaced, other settings preserved)
existing.update(new_settings)

# Ensure schema is present
if '\$schema' not in existing:
    existing['\$schema'] = 'https://json.schemastore.org/claude-code-settings.json'

# Write merged settings
with open('$CLAUDE_SETTINGS_FILE', 'w') as f:
    json.dump(existing, f, indent=2)

print('\033[0;32m✓ Settings merged successfully\033[0m')
" && print_success "Hooks profile '$HOOKS_PROFILE' installed" || {
                    print_info "Python merge failed, using direct copy..."
                    cp "$SETTINGS_SOURCE" "$CLAUDE_SETTINGS_FILE"
                }
            else
                cp "$SETTINGS_SOURCE" "$CLAUDE_SETTINGS_FILE"
            fi
        else
            echo -e "${YELLOW}Warning: $CLAUDE_SETTINGS_FILE already exists.${NC}"
            echo "Manual merge required. Hook configuration to add ($PROFILE_DESC):"
            echo
            cat "$SETTINGS_SOURCE"
            echo
            echo "You can add this configuration manually to your existing settings.json"
            echo "Or re-run with --force to overwrite (backup will be created)"
        fi
    else
        cp "$SETTINGS_SOURCE" "$CLAUDE_SETTINGS_FILE"
        print_success "Hooks profile '$HOOKS_PROFILE' installed to $CLAUDE_SETTINGS_FILE"
    fi
fi

# Save version information from source repository
print_info "Saving version information..."
mkdir -p "$CLAUDE_TOOLKIT_DIR"

# Get Git information from the source repository
CURRENT_HASH=$(cd "$SCRIPT_DIR" && git rev-parse HEAD 2>/dev/null || echo "unknown")
CURRENT_DATE=$(cd "$SCRIPT_DIR" && git log -1 --format=%ci 2>/dev/null || date '+%Y-%m-%d %H:%M:%S')
CURRENT_BRANCH=$(cd "$SCRIPT_DIR" && git branch --show-current 2>/dev/null || echo "unknown")
CURRENT_MESSAGE=$(cd "$SCRIPT_DIR" && git log -1 --pretty=%s 2>/dev/null || echo "unknown")

# Create version file
cat > "$CLAUDE_TOOLKIT_DIR/.installed-version" << EOF
COMMIT_HASH=$CURRENT_HASH
COMMIT_DATE=$CURRENT_DATE
COMMIT_MESSAGE=$CURRENT_MESSAGE
BRANCH=$CURRENT_BRANCH
INSTALLED_AT=$(date '+%Y-%m-%d %H:%M:%S')
SOURCE_DIR=$SCRIPT_DIR
PREFIX=$PREFIX
EOF

print_success "Version information saved"

print_success "Installation complete!"

# Display available commands
if [ "$INSTALL_COMMANDS" = true ]; then
    echo
    echo "Available commands:"
    echo

    # List all command files
    if [ -d "$COMMANDS_INSTALL_PATH" ]; then
        while IFS= read -r -d '' file; do
            # Get relative path from installation directory
            relative_path="${file#"$COMMANDS_INSTALL_PATH/"}"
            # Remove .md extension
            command_path="${relative_path%.md}"
            # Replace / with :
            command_name="${command_path//\//:}"
            echo "  /${PREFIX}:${command_name}"
        done < <(find "$COMMANDS_INSTALL_PATH" -name "*.md" -type f -print0 | sort -z)
    fi
fi

# List available agents
if [ "$INSTALL_AGENTS" = true ]; then
    echo
    echo -e "${GREEN}Available sub-agents:${NC}"
    echo
    if [ -d "$CLAUDE_AGENTS_DIR" ]; then
        for agent_file in "$CLAUDE_AGENTS_DIR"/*.md; do
            if [ -f "$agent_file" ]; then
                agent_name=$(basename "$agent_file" .md)
                # Skip CLAUDE.md files
                if [ "$agent_name" != "CLAUDE" ]; then
                    echo -e "  ${YELLOW}→${NC} $agent_name"
                fi
            fi
        done
    fi
fi

# Display hooks information
if [ "$INSTALL_HOOKS" = true ]; then
    echo
    echo "Hooks installed:"
    echo "  - stop-notification.sh (basic completion sound)"
    echo "  - markdown-format.sh (auto-format Markdown files)"
    echo "  - tool-specific-notification.sh (different sounds per tool)"
    echo "  - subagent-notification.sh (agent-specific sounds)"
    echo "  - error-detection.sh (critical error alerts)"
    echo "  - success-notification.sh (success celebrations)"
    echo "  - system-notification.sh (macOS notifications)"
    echo "  - command-chain-notification.sh (chain progress tracking)"
    echo "  - session-logger.sh (session metrics and logging)"
    echo
    
    # Check for markdownlint-cli2 installation
    if ! command -v markdownlint-cli2 &> /dev/null; then
        echo -e "${YELLOW}Note: markdownlint-cli2 is not installed${NC}"
        echo "  The markdown-format.sh hook requires markdownlint-cli2"
        echo "  Install with: brew install markdownlint-cli2"
        echo "  Or it will use npx as fallback (slower)"
        echo
    fi
    if [ "$INSTALL_SETTINGS" = true ]; then
        echo -e "${GREEN}✓ Hooks configured with '$HOOKS_PROFILE' profile:${NC}"
        case "$HOOKS_PROFILE" in
            basic)
                echo -e "${YELLOW}Active hooks:${NC}"
                echo "  • Stop: stop-notification.sh (completion sound)"
                echo "  • PostToolUse: markdown-format.sh (auto-format .md files)"
                ;;
            minimal)
                echo -e "${YELLOW}Active hooks:${NC}"
                echo "  • Stop: stop-notification.sh (completion sound)"
                echo "  • PostToolUse: error-detection.sh (security/audit/vulnerability)"
                echo "  • PostToolUse: markdown-format.sh (auto-format .md files)"
                ;;
            advanced)
                echo -e "${YELLOW}Active hooks:${NC}"
                echo "  • Stop: stop-notification.sh, success-notification.sh, session-logger.sh"
                echo "  • SubagentStop: subagent-notification.sh"
                echo "  • PostToolUse: tool-specific-notification.sh, error-detection.sh,"
                echo "                 command-chain-notification.sh, system-notification.sh,"
                echo "                 markdown-format.sh"
                echo "  • SessionStart: session-logger.sh (startup/resume)"
                ;;
        esac
        echo
        echo "To change hook profile, re-run with:"
        echo "  ./install.sh $PREFIX --with-settings --hooks-profile [basic|minimal|advanced]"
    else
        echo "To activate hooks, either:"
        echo "  1. Re-run with --with-settings flag to install hooks configuration"
        echo "  2. Re-run with --with-settings --hooks-profile advanced for all features"
        echo "  3. Manually copy a profile from settings/ to ~/.claude/settings.json"
    fi
fi

echo
echo "To use these commands in Claude Code, type '/' followed by the command name."
echo

if [ "$LOCAL_INSTALL" = true ]; then
    echo "Installation location: $LOCAL_DIR"
    echo
    echo "Note: These commands and agents are only available when Claude Code is"
    echo "      running in this project directory."
else
    echo "Installation location: $HOME/.claude/"
    echo
    echo "Note: These commands and agents are available globally in all projects."
fi

echo
echo "To update in the future:"
echo "  1. Pull the latest changes in your cloned repository:"
echo "     cd $SCRIPT_DIR && git pull"
echo "  2. Re-run the installation:"
if [ "$LOCAL_INSTALL" = true ]; then
    echo "     $SCRIPT_DIR/install.sh $PREFIX --local $LOCAL_PROJECT_DIR"
else
    echo "     ./install.sh $PREFIX"
fi
echo
print_success "Happy coding with Claude Code! 🚀"