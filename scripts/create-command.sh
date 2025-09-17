#!/bin/bash

# create-command.sh - Create new commands for Claude Code Toolkit
# Usage: ./scripts/create-command.sh --name "command-name" --type core|typo3|meta

set -euo pipefail

# Default values
COMMAND_NAME=""
COMMAND_TYPE="core"
DESCRIPTION=""
FORCE=false

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Create a new command for the Claude Code Toolkit (6-Command Architecture).

OPTIONS:
    -n, --name NAME           Name of the command (required)
    -t, --type TYPE          Command type: core|typo3|meta (default: core)
    -d, --description DESC   Brief description of the command
    -f, --force              Overwrite existing command
    -h, --help               Display this help message

COMMAND TYPES:
    core    - Core 6-command architecture (understand, improve, create, secure, ship, git)
    typo3   - TYPO3 CMS specific commands
    meta    - Toolkit management commands

EXAMPLES:
    # Create core command
    $0 --name "analyze" --type core --description "Deep code analysis"

    # Create TYPO3 command
    $0 --name "fluid-debug" --type typo3 --description "Debug Fluid templates"

    # Create meta command
    $0 --name "benchmark" --type meta --description "Performance benchmarks"

NOTES:
    - Core commands go in: commands/
    - TYPO3 commands go in: commands/typo3/
    - Meta commands go in: commands/meta/
    - After creation, run: ./scripts/update-readme.sh

EOF
}

# Function to validate command name
validate_command_name() {
    local name="$1"

    # Check if name is provided
    if [[ -z "$name" ]]; then
        echo -e "${RED}Error: Command name is required${NC}"
        return 1
    fi

    # Check for valid characters (lowercase, hyphens, numbers)
    if [[ ! "$name" =~ ^[a-z0-9-]+$ ]]; then
        echo -e "${RED}Error: Command name must contain only lowercase letters, numbers, and hyphens${NC}"
        return 1
    fi

    # Check length
    if [[ ${#name} -lt 2 || ${#name} -gt 30 ]]; then
        echo -e "${RED}Error: Command name must be between 2-30 characters${NC}"
        return 1
    fi

    return 0
}

# Function to get command directory based on type
get_command_dir() {
    local type="$1"
    local repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

    case "$type" in
        core)
            echo "$repo_root/commands"
            ;;
        typo3)
            echo "$repo_root/commands/typo3"
            ;;
        meta)
            echo "$repo_root/commands/meta"
            ;;
        *)
            echo -e "${RED}Error: Invalid command type: $type${NC}" >&2
            return 1
            ;;
    esac
}

# Function to create command file
create_command_file() {
    local name="$1"
    local type="$2"
    local description="$3"
    local target_dir="$4"
    local file_path="$target_dir/$name.md"

    # Check if file exists
    if [[ -f "$file_path" && "$FORCE" != "true" ]]; then
        echo -e "${RED}Error: Command file already exists: $file_path${NC}"
        echo -e "${YELLOW}Use --force to overwrite${NC}"
        return 1
    fi

    # Create directory if needed
    mkdir -p "$target_dir"

    # Generate command content based on type
    case "$type" in
        core)
            create_core_command "$file_path" "$name" "$description"
            ;;
        typo3)
            create_typo3_command "$file_path" "$name" "$description"
            ;;
        meta)
            create_meta_command "$file_path" "$name" "$description"
            ;;
    esac

    echo -e "${GREEN}✓ Created command: $file_path${NC}"
}

# Function to create core command
create_core_command() {
    local file_path="$1"
    local name="$2"
    local description="$3"

    cat > "$file_path" << EOF
---
description: $description
argument-hint: [target] [options]
---

# $name

$description with intelligent routing and learning persistence.

## Help Check

If "\$ARGUMENTS" contains "--help" or "-h":

📚 **Command Help**

**Command**: /prefix:$name
**Description**: $description
**Usage**: /prefix:$name [target] [options]

**Options**:
- \`--help\`, \`-h\` - Show this help
- \`--verbose\` - Enable detailed output
- \`--export-json\` - Export results to JSON
- \`--export-md\` - Export results to Markdown

**Examples**:
\`\`\`bash
# Basic usage
/prefix:$name .

# With export
/prefix:$name . --export-json

# Verbose mode
/prefix:$name . --verbose
\`\`\`

**Related Commands**:
- /prefix:understand - Code analysis
- /prefix:improve - Apply improvements
- /prefix:secure - Security analysis

Exit without executing the main command.

---

## Implementation

Use Task tool with appropriate specialists:

\`\`\`markdown
Use Task tool with subagent_type="code-architect":
"$description for the provided target: \$ARGUMENTS"
\`\`\`

## Learning Integration

This command integrates with the Knowledge-Driven Revolution:

1. **Intelligent Routing** - Automatically selects best agents
2. **Learning Persistence** - Builds knowledge over time
3. **Pattern Recognition** - Identifies common issues
4. **Context Awareness** - Adapts to project type

## Output

Provides structured analysis with:
- Executive summary
- Key findings
- Actionable recommendations
- Export options (JSON/Markdown)
EOF
}

# Function to create TYPO3 command
create_typo3_command() {
    local file_path="$1"
    local name="$2"
    local description="$3"

    cat > "$file_path" << EOF
---
description: $description
argument-hint: [options]
---

# typo3:$name

$description for TYPO3 v13+ development.

## Help Check

If "\$ARGUMENTS" contains "--help" or "-h":

📚 **TYPO3 Command Help**

**Command**: /prefix:typo3:$name
**Description**: $description
**Usage**: /prefix:typo3:$name [options]

**TYPO3 Options**:
- \`--help\`, \`-h\` - Show this help
- \`--version\` - Target TYPO3 version (default: 13.4)
- \`--sitepackage=path\` - Target sitepackage directory

**Examples**:
\`\`\`bash
# Basic usage
/prefix:typo3:$name

# With sitepackage
/prefix:typo3:$name --sitepackage=packages/my_sitepackage
\`\`\`

**Related TYPO3 Commands**:
- /prefix:typo3:sitepackage - Create sitepackage
- /prefix:typo3:content-blocks - Create content blocks
- /prefix:typo3:fluid-components - Create Fluid components

Exit without executing the main command.

---

## Implementation

Use Task tool with TYPO3 specialists:

\`\`\`markdown
Use Task tool with subagent_type="typo3-architect":
"$description with the following requirements: \$ARGUMENTS

Target TYPO3 version: 13.4+
Follow TYPO3 best practices and conventions."
\`\`\`

## TYPO3 Integration

This command supports:

- **TYPO3 v13.4+** compatibility
- **Site Sets** configuration
- **Content Blocks** integration
- **Fluid v4** templates
- **Composer** package management

## Output

Generates TYPO3-specific code with:
- Proper directory structure
- Configuration files
- Documentation
- Installation instructions
EOF
}

# Function to create meta command
create_meta_command() {
    local file_path="$1"
    local name="$2"
    local description="$3"

    cat > "$file_path" << EOF
---
description: $description
argument-hint: [options]
---

# meta:$name

$description for Claude Code Toolkit management.

## Help Check

If "\$ARGUMENTS" contains "--help" or "-h":

📚 **Meta Command Help**

**Command**: /prefix:meta:$name
**Description**: $description
**Usage**: /prefix:meta:$name [options]

**Meta Options**:
- \`--help\`, \`-h\` - Show this help
- \`--verbose\` - Enable detailed output
- \`--format=json|md\` - Output format

**Examples**:
\`\`\`bash
# Basic usage
/prefix:meta:$name

# Verbose output
/prefix:meta:$name --verbose

# JSON format
/prefix:meta:$name --format=json
\`\`\`

**Related Meta Commands**:
- /prefix:meta:health - Toolkit health check
- /prefix:meta:help - Command help system
- /prefix:meta:export - Export functionality

Exit without executing the main command.

---

## Implementation

\`\`\`markdown
$description for the Claude Code Toolkit.

Process the request: \$ARGUMENTS

Provide toolkit-specific insights and management functionality.
\`\`\`

## Toolkit Integration

This meta command:

- **Monitors** toolkit performance
- **Manages** toolkit configuration
- **Reports** on toolkit usage
- **Maintains** toolkit health

## Output

Provides toolkit management data:
- Status information
- Performance metrics
- Configuration details
- Recommendations
EOF
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            COMMAND_NAME="$2"
            shift 2
            ;;
        -t|--type)
            COMMAND_TYPE="$2"
            shift 2
            ;;
        -d|--description)
            DESCRIPTION="$2"
            shift 2
            ;;
        -f|--force)
            FORCE=true
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            exit 1
            ;;
    esac
done

# Main execution
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Claude Code Toolkit - Command Creator${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo

# Validate inputs
if ! validate_command_name "$COMMAND_NAME"; then
    exit 1
fi

if [[ -z "$DESCRIPTION" ]]; then
    DESCRIPTION="$COMMAND_NAME command for Claude Code Toolkit"
fi

# Validate command type
case "$COMMAND_TYPE" in
    core|typo3|meta)
        ;;
    *)
        echo -e "${RED}Error: Invalid command type: $COMMAND_TYPE${NC}"
        echo -e "${YELLOW}Valid types: core, typo3, meta${NC}"
        exit 1
        ;;
esac

# Get target directory
TARGET_DIR=$(get_command_dir "$COMMAND_TYPE")
if [[ $? -ne 0 ]]; then
    exit 1
fi

# Create the command
echo -e "${YELLOW}Creating $COMMAND_TYPE command: $COMMAND_NAME${NC}"
echo "Target directory: $TARGET_DIR"
echo "Description: $DESCRIPTION"
echo

if create_command_file "$COMMAND_NAME" "$COMMAND_TYPE" "$DESCRIPTION" "$TARGET_DIR"; then
    echo
    echo -e "${GREEN}✅ Command created successfully!${NC}"
    echo
    echo -e "${BLUE}Next steps:${NC}"
    echo "1. Edit the command file to customize implementation"
    echo "2. Update README: ${YELLOW}./scripts/update-readme.sh${NC}"
    case "$COMMAND_TYPE" in
        core)
            echo "3. Test command: ${YELLOW}/yourprefix:$COMMAND_NAME --help${NC}"
            ;;
        typo3)
            echo "3. Test command: ${YELLOW}/yourprefix:typo3:$COMMAND_NAME --help${NC}"
            ;;
        meta)
            echo "3. Test command: ${YELLOW}/yourprefix:meta:$COMMAND_NAME --help${NC}"
            ;;
    esac
else
    echo -e "${RED}❌ Failed to create command${NC}"
    exit 1
fi