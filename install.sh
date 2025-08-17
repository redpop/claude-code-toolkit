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

# Function to show help
show_help() {
    echo "Claude Code Toolkit Installation Script"
    echo ""
    echo "Usage: ./install.sh <prefix> [options]"
    echo ""
    echo "Arguments:"
    echo "  <prefix>    The prefix for your commands (e.g., 'mytools', 'global', 'team')"
    echo ""
    echo "Options:"
    echo "  --help, -h              Show this help message"
    echo "  --force                 Force installation without creating backups"
    echo "  --local <path>          Install in specific project directory (.claude/)"
    echo "                          Required: path to target project directory"
    echo "  --install <components>  Install specific components (comma-separated)"
    echo "                          Available: commands, agents, hooks, all (default: all)"
    echo "  --with-settings         Also install global settings.json for hooks"
    echo ""
    echo "Examples:"
    echo "  ./install.sh mytools                     Install everything globally (default)"
    echo "  ./install.sh mytools --local /path/to/project  Install in specific project"
    echo "  ./install.sh mytools --install commands  Install only commands"
    echo "  ./install.sh mytools --install agents    Install only agents"
    echo "  ./install.sh mytools --install commands,agents  Install both (explicit)"
    echo "  ./install.sh mytools --with-settings     Install with global hook settings"
    echo "  ./install.sh global --force              Force install without backups"
    echo ""
    echo "After installation, commands will be available as:"
    echo "  /<prefix>:<category>:<command>"
    echo ""
    echo "For example, with prefix 'mytools':"
    echo "  /mytools:git:commit"
    echo "  /mytools:project:changelog"
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
        cp -r "$SCRIPT_DIR/commands/"* "$COMMANDS_INSTALL_PATH/" 2>/dev/null || true
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
        cp "$SCRIPT_DIR/agents/"*.md "$CLAUDE_AGENTS_DIR/" 2>/dev/null || true
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
    
    cp -r "$SCRIPT_DIR/knowledge-base" "$CLAUDE_TOOLKIT_DIR/"
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
    
    cp -r "$SCRIPT_DIR/hooks" "$CLAUDE_TOOLKIT_DIR/"
    # Ensure scripts are executable
    chmod +x "$CLAUDE_TOOLKIT_DIR/hooks"/*.sh 2>/dev/null || true
    print_success "Hooks installed to $CLAUDE_TOOLKIT_DIR/hooks"
fi

# Install global settings if requested
if [ "$INSTALL_SETTINGS" = true ] && [ -f "$SCRIPT_DIR/settings/global-settings.json" ]; then
    print_info "Installing global settings for hooks..."
    
    # Check if settings.json already exists
    if [ -f "$CLAUDE_SETTINGS_FILE" ]; then
        if [ "$FORCE_INSTALL" = true ]; then
            print_info "Force mode: Overwriting existing settings.json..."
            cp "$SCRIPT_DIR/settings/global-settings.json" "$CLAUDE_SETTINGS_FILE"
        else
            echo -e "${YELLOW}Warning: $CLAUDE_SETTINGS_FILE already exists.${NC}"
            echo "Manual merge required. Hook configuration to add:"
            echo
            cat "$SCRIPT_DIR/settings/global-settings.json"
            echo
            echo "You can add this configuration manually to your existing settings.json"
        fi
    else
        cp "$SCRIPT_DIR/settings/global-settings.json" "$CLAUDE_SETTINGS_FILE"
        print_success "Global settings installed to $CLAUDE_SETTINGS_FILE"
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
    echo "Available sub-agents:"
    echo
    if [ -d "$CLAUDE_AGENTS_DIR" ]; then
        for agent_file in "$CLAUDE_AGENTS_DIR"/*.md; do
            if [ -f "$agent_file" ]; then
                agent_name=$(basename "$agent_file" .md)
                echo "  - $agent_name"
            fi
        done
    fi
fi

# Display hooks information
if [ "$INSTALL_HOOKS" = true ]; then
    echo
    echo "Hooks installed:"
    echo "  - stop-notification.sh (plays sound when Claude finishes responding)"
    echo
    if [ "$INSTALL_SETTINGS" = true ]; then
        echo "✓ Global settings configured - hooks are now active!"
    else
        echo "To activate hooks, either:"
        echo "  1. Re-run with --with-settings flag to install global settings"
        echo "  2. Manually add the configuration from settings/global-settings.json to ~/.claude/settings.json"
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