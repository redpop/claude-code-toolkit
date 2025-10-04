#!/usr/bin/env bash

# Claude Code Toolkit - Hook Management CLI
# Provides user-friendly management of Claude Code hooks
# Usage: ./scripts/manage-hooks.sh [command] [options]

set -euo pipefail

# Configuration
HOOKS_DIR="$HOME/.claude/claude-code-toolkit/hooks"
STATS_DIR="$HOME/.claude/claude-code-toolkit/stats"
LOG_DIR="$HOME/.claude/claude-code-toolkit/logs"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Hook definitions with metadata
declare -A HOOKS=(
    ["markdown-format"]="Auto-format MD files after modifications|PostToolUse|markdownlint-cli2"
    ["stop-notification"]="Sound notification when Claude stops|Stop|afplay"
    ["session-logger"]="Log session activity and metrics|SessionStart/Stop|jq"
    ["error-detection"]="Detect and highlight error patterns|PostToolUse|none"
    ["system-notification"]="System notifications for Claude events|Multiple|osascript"
    ["command-chain-notification"]="Notifications for command chains|PostToolUse|afplay"
    ["subagent-notification"]="Notifications for sub-agent activities|PostToolUse|afplay"
    ["success-notification"]="Success notifications with sound|PostToolUse|afplay"
    ["tool-specific-notification"]="Tool-specific notification system|PostToolUse|afplay"
    ["session-end-summary"]="Intelligent session summaries w/ Memory|Stop|jq,Basic Memory MCP"
    ["enhanced-command-logger"]="Enhanced command statistics tracking|PostToolUse|jq"
)

# Helper functions
print_header() {
    echo ""
    echo -e "${BOLD}${BLUE}════════════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${BLUE}🎣 Claude Code Toolkit - Hook Management CLI${NC}"
    echo -e "${BOLD}${BLUE}════════════════════════════════════════════════════════════════${NC}"
    echo ""
}

print_usage() {
    echo -e "${BOLD}USAGE:${NC}"
    echo "  ./scripts/manage-hooks.sh <command> [options]"
    echo ""
    echo -e "${BOLD}COMMANDS:${NC}"
    echo -e "  ${GREEN}list${NC}                    Show all available hooks with status"
    echo -e "  ${GREEN}enable${NC} <hook>           Enable a specific hook"
    echo -e "  ${GREEN}disable${NC} <hook>          Disable a specific hook"
    echo -e "  ${GREEN}info${NC} <hook>             Show detailed information about a hook"
    echo -e "  ${GREEN}doctor${NC}                  Run diagnostic checks on hook system"
    echo -e "  ${GREEN}create${NC} <name>           Create a new custom hook (interactive)"
    echo -e "  ${GREEN}stats${NC}                   Show hook usage statistics"
    echo -e "  ${GREEN}cleanup${NC}                 Clean up old logs and temporary files"
    echo -e "  ${GREEN}backup${NC}                  Backup current hook configuration"
    echo ""
    echo -e "${BOLD}EXAMPLES:${NC}"
    echo "  ./scripts/manage-hooks.sh list"
    echo "  ./scripts/manage-hooks.sh enable session-end-summary"
    echo "  ./scripts/manage-hooks.sh info markdown-format"
    echo "  ./scripts/manage-hooks.sh doctor"
    echo "  ./scripts/manage-hooks.sh stats"
    echo ""
    echo -e "${BOLD}HOOKS DIRECTORY:${NC}"
    echo "  $HOOKS_DIR"
    echo ""
    echo -e "${BOLD}DOCUMENTATION:${NC}"
    echo "  https://github.com/redpop/claude-code-toolkit/blob/main/docs/guides/ENHANCED-HOOKS.md"
}

# Check if hook exists and is executable
check_hook_status() {
    local hook_name="$1"
    local hook_file="$HOOKS_DIR/${hook_name}.sh"

    if [ -f "$hook_file" ] && [ -x "$hook_file" ]; then
        echo "enabled"
    elif [ -f "$hook_file" ]; then
        echo "disabled"
    else
        echo "not_found"
    fi
}

# Get hook metadata
get_hook_info() {
    local hook_name="$1"
    if [[ -v HOOKS[$hook_name] ]]; then
        echo "${HOOKS[$hook_name]}"
    else
        echo "Unknown hook|Unknown|none"
    fi
}

# List all available hooks
list_hooks() {
    print_header
    echo -e "${BOLD}AVAILABLE HOOKS:${NC}"
    echo "────────────────────────────────────────────────────────────────────────────────"

    printf "%-28s %-40s %s\n" "HOOK NAME" "DESCRIPTION" "STATUS"
    echo "────────────────────────────────────────────────────────────────────────────────"

    for hook_name in "${!HOOKS[@]}"; do
        local info
        info=$(get_hook_info "$hook_name")
        local description
        description=$(echo "$info" | cut -d'|' -f1)
        local status
        status=$(check_hook_status "$hook_name")

        case "$status" in
            "enabled")
                printf "%-28s %-40s ${GREEN}✅ ENABLED${NC}\n" "$hook_name" "$description"
                ;;
            "disabled")
                printf "%-28s %-40s ${YELLOW}❌ DISABLED${NC}\n" "$hook_name" "$description"
                ;;
            "not_found")
                printf "%-28s %-40s ${RED}🚫 NOT FOUND${NC}\n" "$hook_name" "$description"
                ;;
        esac
    done

    echo ""
    echo -e "${BOLD}COMMANDS:${NC}"
    echo -e "  ${GREEN}enable <hook>${NC}     Enable a specific hook"
    echo -e "  ${GREEN}disable <hook>${NC}    Disable a specific hook"
    echo -e "  ${GREEN}info <hook>${NC}       Show detailed hook information"
    echo -e "  ${GREEN}doctor${NC}            Diagnose hook system health"
    echo ""
}

# Show detailed hook information
show_hook_info() {
    local hook_name="$1"
    local info
    info=$(get_hook_info "$hook_name")
    local description
    description=$(echo "$info" | cut -d'|' -f1)
    local hook_type
    hook_type=$(echo "$info" | cut -d'|' -f2)
    local dependencies
    dependencies=$(echo "$info" | cut -d'|' -f3)
    local status
    status=$(check_hook_status "$hook_name")
    local hook_file="$HOOKS_DIR/${hook_name}.sh"

    print_header
    echo -e "${BOLD}🎣 HOOK: ${CYAN}$hook_name${NC}"
    echo "────────────────────────────────────────────────────────────────"
    echo -e "${BOLD}📝 Description:${NC} $description"
    echo -e "${BOLD}🔧 Type:${NC} $hook_type"
    echo -e "${BOLD}📋 Dependencies:${NC} $dependencies"

    case "$status" in
        "enabled")
            echo -e "${BOLD}⚡ Status:${NC} ${GREEN}✅ ENABLED${NC}"
            ;;
        "disabled")
            echo -e "${BOLD}⚡ Status:${NC} ${YELLOW}❌ DISABLED (file exists but not executable)${NC}"
            ;;
        "not_found")
            echo -e "${BOLD}⚡ Status:${NC} ${RED}🚫 NOT FOUND${NC}"
            ;;
    esac

    echo -e "${BOLD}📁 File Path:${NC} $hook_file"

    if [ -f "$hook_file" ]; then
        local file_size
        file_size=$(du -h "$hook_file" | cut -f1)
        local mod_time
        mod_time=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M" "$hook_file")
        echo -e "${BOLD}📊 File Size:${NC} $file_size"
        echo -e "${BOLD}⏰ Modified:${NC} $mod_time"
    fi

    # Show dependencies status
    echo ""
    echo -e "${BOLD}🔍 DEPENDENCY CHECK:${NC}"
    echo "────────────────────────────────────────────────────────────────"

    IFS=',' read -ra DEPS <<< "$dependencies"
    for dep in "${DEPS[@]}"; do
        dep=$(echo "$dep" | xargs) # trim whitespace
        if [ "$dep" = "none" ]; then
            echo -e "   ${GREEN}✅ No dependencies required${NC}"
        elif command -v "$dep" &> /dev/null; then
            echo -e "   ${GREEN}✅ $dep${NC} - Available"
        else
            echo -e "   ${RED}❌ $dep${NC} - Not found"
        fi
    done

    # Show usage example
    echo ""
    echo -e "${BOLD}💡 USAGE:${NC}"
    echo "────────────────────────────────────────────────────────────────"
    echo "   Enable:  ./scripts/manage-hooks.sh enable $hook_name"
    echo "   Disable: ./scripts/manage-hooks.sh disable $hook_name"
    if [ "$status" = "not_found" ]; then
        echo "   ${RED}Note: Hook file not found. You may need to create it first.${NC}"
    fi
    echo ""
}

# Enable a hook
enable_hook() {
    local hook_name="$1"
    local hook_file="$HOOKS_DIR/${hook_name}.sh"

    if [ ! -f "$hook_file" ]; then
        echo -e "${RED}❌ Error: Hook file not found: $hook_file${NC}"
        echo -e "${YELLOW}💡 Use 'create $hook_name' to create a new hook${NC}"
        return 1
    fi

    if [ -x "$hook_file" ]; then
        echo -e "${YELLOW}⚠️  Hook '$hook_name' is already enabled${NC}"
        return 0
    fi

    chmod +x "$hook_file"
    echo -e "${GREEN}✅ Hook '$hook_name' enabled successfully!${NC}"

    # Check dependencies
    local info
    info=$(get_hook_info "$hook_name")
    local dependencies
    dependencies=$(echo "$info" | cut -d'|' -f3)

    echo ""
    echo -e "${BOLD}🔍 Checking dependencies...${NC}"

    IFS=',' read -ra DEPS <<< "$dependencies"
    local missing_deps=()

    for dep in "${DEPS[@]}"; do
        dep=$(echo "$dep" | xargs)
        if [ "$dep" != "none" ] && ! command -v "$dep" &> /dev/null; then
            missing_deps+=("$dep")
        fi
    done

    if [ ${#missing_deps[@]} -gt 0 ]; then
        echo -e "${YELLOW}⚠️  Warning: Missing dependencies: ${missing_deps[*]}${NC}"
        echo -e "${YELLOW}   Hook may not function correctly without these dependencies${NC}"
    else
        echo -e "${GREEN}✅ All dependencies satisfied${NC}"
    fi
}

# Disable a hook
disable_hook() {
    local hook_name="$1"
    local hook_file="$HOOKS_DIR/${hook_name}.sh"

    if [ ! -f "$hook_file" ]; then
        echo -e "${RED}❌ Error: Hook file not found: $hook_file${NC}"
        return 1
    fi

    if [ ! -x "$hook_file" ]; then
        echo -e "${YELLOW}⚠️  Hook '$hook_name' is already disabled${NC}"
        return 0
    fi

    chmod -x "$hook_file"
    echo -e "${GREEN}✅ Hook '$hook_name' disabled successfully!${NC}"
}

# Run diagnostic checks
run_doctor() {
    print_header
    echo -e "${BOLD}🔍 HOOK SYSTEM DIAGNOSTICS${NC}"
    echo "────────────────────────────────────────────────────────────────"
    echo ""

    local issues=0

    # Check directories
    echo -e "${BOLD}📁 Directory Check:${NC}"
    for dir in "$HOOKS_DIR" "$STATS_DIR" "$LOG_DIR"; do
        if [ -d "$dir" ]; then
            echo -e "   ${GREEN}✅ $dir${NC} - OK"
        else
            echo -e "   ${RED}❌ $dir${NC} - Missing"
            ((issues++))
        fi
    done

    echo ""
    echo -e "${BOLD}🎣 Hook Files Check:${NC}"
    for hook_name in "${!HOOKS[@]}"; do
        local hook_file="$HOOKS_DIR/${hook_name}.sh"
        local status
        status=$(check_hook_status "$hook_name")

        case "$status" in
            "enabled")
                echo -e "   ${GREEN}✅ $hook_name${NC} - Enabled and executable"
                ;;
            "disabled")
                echo -e "   ${YELLOW}⚠️  $hook_name${NC} - File exists but not executable"
                ;;
            "not_found")
                echo -e "   ${RED}❌ $hook_name${NC} - File not found"
                ((issues++))
                ;;
        esac
    done

    echo ""
    echo -e "${BOLD}🔧 Dependencies Check:${NC}"
    local all_deps=("jq" "afplay" "osascript" "markdownlint-cli2")
    for dep in "${all_deps[@]}"; do
        if command -v "$dep" &> /dev/null; then
            echo -e "   ${GREEN}✅ $dep${NC} - Available"
        else
            echo -e "   ${YELLOW}⚠️  $dep${NC} - Not found (some hooks may not work)"
        fi
    done

    echo ""
    echo -e "${BOLD}📊 System Health Summary:${NC}"
    echo "────────────────────────────────────────────────────────────────"

    if [ $issues -eq 0 ]; then
        echo -e "${GREEN}✅ Hook system is healthy!${NC}"
        echo -e "   All directories exist and core hooks are available."
    else
        echo -e "${YELLOW}⚠️  Found $issues issues${NC}"
        echo -e "   Some hooks may not function correctly."
        echo ""
        echo -e "${BOLD}💡 Recommendations:${NC}"
        echo -e "   • Run installation: ./install.sh <prefix>"
        echo -e "   • Check missing dependencies"
        echo -e "   • Enable required hooks"
    fi
    echo ""
}

# Show statistics
show_stats() {
    print_header
    echo -e "${BOLD}📊 HOOK USAGE STATISTICS${NC}"
    echo "────────────────────────────────────────────────────────────────"

    local enabled_count=0
    local total_count=${#HOOKS[@]}

    for hook_name in "${!HOOKS[@]}"; do
        if [ "$(check_hook_status "$hook_name")" = "enabled" ]; then
            ((enabled_count++))
        fi
    done

    echo -e "${BOLD}📈 Overview:${NC}"
    echo "   Total hooks: $total_count"
    echo "   Enabled: $enabled_count"
    echo "   Disabled: $((total_count - enabled_count))"
    echo ""

    # Show command statistics if available
    local stats_file="$STATS_DIR/command-stats.json"
    if [ -f "$stats_file" ] && command -v jq &> /dev/null; then
        echo -e "${BOLD}🎯 Command Usage (Today):${NC}"
        jq -r '.daily | to_entries | sort_by(.value.count) | reverse | limit(5;.[]) | "   • \(.key): \(.value.count)x"' "$stats_file" 2> /dev/null || echo "   No command data available"
    else
        echo -e "${BOLD}🎯 Command Usage:${NC}"
        echo "   Statistics not available (enable enhanced-command-logger hook)"
    fi
    echo ""

    # Show log file sizes
    if [ -d "$LOG_DIR" ]; then
        echo -e "${BOLD}📋 Log Files:${NC}"
        for log_file in "$LOG_DIR"/*.{log,txt,json}; do
            if [ -f "$log_file" ]; then
                local size
                size=$(du -h "$log_file" | cut -f1)
                local name
                name=$(basename "$log_file")
                echo "   • $name: $size"
            fi
        done 2> /dev/null
    fi
    echo ""
}

# Create a new hook
create_hook() {
    local hook_name="$1"
    local hook_file="$HOOKS_DIR/${hook_name}.sh"

    if [ -f "$hook_file" ]; then
        echo -e "${YELLOW}⚠️  Hook '$hook_name' already exists${NC}"
        read -p "Overwrite? [y/N]: " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Cancelled."
            return 0
        fi
    fi

    echo -e "${BOLD}🎣 Creating new hook: $hook_name${NC}"
    echo ""

    # Interactive hook creation
    echo "Hook Type:"
    echo "1) PostToolUse - Runs after each tool execution"
    echo "2) Stop - Runs when Claude stops responding"
    echo "3) SessionStart - Runs at session start"
    echo "4) SessionStop - Runs at session end"
    read -p "Choose hook type [1-4]: " -n 1 -r hook_type_choice
    echo

    case "$hook_type_choice" in
        1) hook_type="PostToolUse" ;;
        2) hook_type="Stop" ;;
        3) hook_type="SessionStart" ;;
        4) hook_type="SessionStop" ;;
        *)
            echo "Invalid choice. Using PostToolUse."
            hook_type="PostToolUse"
            ;;
    esac

    read -rp "Hook description: " hook_description

    # Create hook file
    cat > "$hook_file" << EOF
#!/usr/bin/env bash

# $hook_name - $hook_description
# This script is invoked by the $hook_type hook in Claude Code

# Read JSON input from stdin (provided by Claude Code)
INPUT=\$(cat)

# Extract relevant information
TOOL_NAME=\$(echo "\$INPUT" | jq -r '.tool_name // "unknown"')
TIMESTAMP=\$(date '+%Y-%m-%d %H:%M:%S')

# Your hook logic here
echo "[$hook_name] \$TIMESTAMP - Hook triggered for tool: \$TOOL_NAME"

# Example: Log to file
# echo "[\$TIMESTAMP] $hook_name executed" >> "$LOG_DIR/${hook_name}.log"

# Example: Conditional logic based on tool
# case "\$TOOL_NAME" in
#     "Bash")
#         # Handle Bash tool
#         ;;
#     "Edit")
#         # Handle Edit tool
#         ;;
#     *)
#         # Handle other tools
#         ;;
# esac

exit 0
EOF

    chmod +x "$hook_file"
    echo -e "${GREEN}✅ Hook '$hook_name' created successfully!${NC}"
    echo -e "${BLUE}📁 Location: $hook_file${NC}"
    echo -e "${YELLOW}💡 Edit the file to customize your hook behavior${NC}"
}

# Main command processing
main() {
    if [ $# -eq 0 ]; then
        list_hooks
        return 0
    fi

    local command="$1"

    case "$command" in
        "list" | "ls")
            list_hooks
            ;;
        "enable")
            if [ $# -ne 2 ]; then
                echo -e "${RED}❌ Usage: $0 enable <hook_name>${NC}"
                return 1
            fi
            enable_hook "$2"
            ;;
        "disable")
            if [ $# -ne 2 ]; then
                echo -e "${RED}❌ Usage: $0 disable <hook_name>${NC}"
                return 1
            fi
            disable_hook "$2"
            ;;
        "info")
            if [ $# -ne 2 ]; then
                echo -e "${RED}❌ Usage: $0 info <hook_name>${NC}"
                return 1
            fi
            show_hook_info "$2"
            ;;
        "doctor" | "check")
            run_doctor
            ;;
        "stats" | "statistics")
            show_stats
            ;;
        "create" | "new")
            if [ $# -ne 2 ]; then
                echo -e "${RED}❌ Usage: $0 create <hook_name>${NC}"
                return 1
            fi
            create_hook "$2"
            ;;
        "help" | "-h" | "--help")
            print_usage
            ;;
        *)
            echo -e "${RED}❌ Unknown command: $command${NC}"
            echo ""
            print_usage
            return 1
            ;;
    esac
}

# Ensure hooks directory exists
mkdir -p "$HOOKS_DIR"
mkdir -p "$STATS_DIR"
mkdir -p "$LOG_DIR"

# Run main function with all arguments
main "$@"
