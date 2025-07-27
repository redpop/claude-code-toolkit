#!/usr/bin/env bash

# create-sub-agent-command.sh - Helper script to create new sub-agent commands
# Usage: ./create-sub-agent-command.sh --name "command-name" --agents 5 --category "orchestration"

set -euo pipefail

# Default values
COMMAND_NAME=""
AGENT_COUNT=5
CATEGORY="orchestration"
TEMPLATE="basic"
DESCRIPTION=""
TYPE="task"

# Color codes for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    cat << EOF
Usage: $0 [OPTIONS]

Create a new sub-agent command with the specified parameters.

OPTIONS:
    -n, --name NAME           Name of the command (required)
    -a, --agents COUNT        Number of agents (default: 5)
    -c, --category CATEGORY   Category: orchestration|research|custom (default: orchestration)
    -t, --template TEMPLATE   Template to use: basic|analysis|research (default: basic)
    -d, --description DESC    Brief description of the command
    --type TYPE              Command type: task|hybrid|both (default: task)
                             - task: Parallel task execution with specialized agents
                             - hybrid: Three-phase command (scan, delegate, synthesize)
                             - both: Creates both task and hybrid versions
    -h, --help               Display this help message

EXAMPLES:
    $0 --name "code-review" --agents 6 --category orchestration
    $0 -n "api-research" -a 8 -c research -t research -d "Research API patterns"
    $0 --name "codebase-analysis" --type hybrid --agents 8 --category research
    $0 --name "security-audit" --type both --agents 10 --category orchestration
EOF
    exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -n|--name)
            COMMAND_NAME="$2"
            shift 2
            ;;
        -a|--agents)
            AGENT_COUNT="$2"
            shift 2
            ;;
        -c|--category)
            CATEGORY="$2"
            shift 2
            ;;
        -t|--template)
            TEMPLATE="$2"
            shift 2
            ;;
        -d|--description)
            DESCRIPTION="$2"
            shift 2
            ;;
        --type)
            TYPE="$2"
            shift 2
            ;;
        -h|--help)
            usage
            ;;
        *)
            echo -e "${RED}Error: Unknown option $1${NC}"
            usage
            ;;
    esac
done

# Validate required parameters
if [[ -z "$COMMAND_NAME" ]]; then
    echo -e "${RED}Error: Command name is required${NC}"
    usage
fi

# Validate agent count
if ! [[ "$AGENT_COUNT" =~ ^[0-9]+$ ]] || [[ "$AGENT_COUNT" -lt 2 ]] || [[ "$AGENT_COUNT" -gt 20 ]]; then
    echo -e "${RED}Error: Agent count must be a number between 2 and 20${NC}"
    exit 1
fi

# Validate category
if [[ ! "$CATEGORY" =~ ^(orchestration|research|custom)$ ]]; then
    echo -e "${RED}Error: Category must be orchestration, research, or custom${NC}"
    exit 1
fi

# Validate template
if [[ ! "$TEMPLATE" =~ ^(basic|analysis|research)$ ]]; then
    echo -e "${RED}Error: Template must be basic, analysis, or research${NC}"
    exit 1
fi

# Validate type
if [[ ! "$TYPE" =~ ^(task|hybrid|both)$ ]]; then
    echo -e "${RED}Error: Type must be task, hybrid, or both${NC}"
    exit 1
fi

# Set default description if not provided
if [[ -z "$DESCRIPTION" ]]; then
    DESCRIPTION="Parallel execution with $AGENT_COUNT specialized agents"
fi

# Create directory if it doesn't exist
COMMAND_DIR="commands/$CATEGORY"
mkdir -p "$COMMAND_DIR"

# Suggest appropriate sub-agents based on category
suggest_subagents() {
    local category=$1
    case $category in
        "orchestration")
            echo "code-analysis, testing, documentation, refactoring, architecture"
            ;;
        "research")
            echo "data-collection, pattern-analysis, technical-research, api-explorer, documentation-scanner"
            ;;
        "custom")
            echo "general-purpose, specialized-analysis, integration, automation, validation"
            ;;
    esac
}

# Function to create a command file
create_command_file() {
    local cmd_type=$1
    local cmd_file=$2
    local template_type=$3
    
    # Select appropriate template based on command type
    local template_file
    if [[ "$cmd_type" == "hybrid" ]]; then
        template_file="commands/templates/hybrid-sub-agent.md"
    else
        template_file="commands/templates/${template_type}-sub-agent.md"
    fi
    
    # Check if template exists, fall back to basic if not
    if [[ ! -f "$template_file" ]]; then
        if [[ "$cmd_type" == "hybrid" ]]; then
            echo -e "${YELLOW}Warning: Hybrid template not found, creating from basic template${NC}"
            template_file="commands/templates/basic-sub-agent.md"
        else
            echo -e "${RED}Error: Template file $template_file not found${NC}"
            return 1
        fi
    fi
    
    # Copy template
    cp "$template_file" "$cmd_file"
    
    # Replace placeholders
    sed -i '' "s/\[Command Name\]/${COMMAND_NAME}/g" "$cmd_file"
    sed -i '' "s/\[N\]/$AGENT_COUNT/g" "$cmd_file"
    
    # Set appropriate description based on type
    local desc
    if [[ "$cmd_type" == "hybrid" ]]; then
        desc="${DESCRIPTION:-Three-phase hybrid analysis with scanning and expert delegation}"
    else
        desc="${DESCRIPTION:-Parallel execution with $AGENT_COUNT specialized agents}"
    fi
    sed -i '' "s/description: \[Brief description of the command\]/description: $desc/g" "$cmd_file"
    sed -i '' "s/argument-hint: \[expected-arguments\]/argument-hint: [directory]/g" "$cmd_file"
    
    # Generate performance expectations
    local sequential_time=$((AGENT_COUNT * 8))
    local parallel_min=$((AGENT_COUNT / 2 + 2))
    local parallel_max=$((AGENT_COUNT / 2 + 4))
    
    sed -i '' "s/\[X-Y seconds for parallel execution, compared to Z seconds sequential\]/${parallel_min}-${parallel_max} seconds for parallel execution, compared to ${sequential_time} seconds sequential/g" "$cmd_file"
    
    # Add suggested sub-agents as a comment
    local suggested_agents=$(suggest_subagents "$CATEGORY")
    echo -e "\n<!-- Suggested sub-agent types for $CATEGORY: $suggested_agents -->" >> "$cmd_file"
    
    return 0
}

# Determine which files to create
FILES_TO_CREATE=()
if [[ "$TYPE" == "both" ]]; then
    FILES_TO_CREATE=("task:$COMMAND_DIR/${COMMAND_NAME}.md" "hybrid:$COMMAND_DIR/${COMMAND_NAME}-hybrid.md")
elif [[ "$TYPE" == "hybrid" ]]; then
    FILES_TO_CREATE=("hybrid:$COMMAND_DIR/${COMMAND_NAME}.md")
else
    FILES_TO_CREATE=("task:$COMMAND_DIR/${COMMAND_NAME}.md")
fi

# Check if files already exist
for file_spec in "${FILES_TO_CREATE[@]}"; do
    file_path="${file_spec#*:}"
    if [[ -f "$file_path" ]]; then
        echo -e "${YELLOW}Warning: Command file '$file_path' already exists${NC}"
        read -p "Overwrite? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Aborted."
            exit 1
        fi
    fi
done

# Create command files
for file_spec in "${FILES_TO_CREATE[@]}"; do
    cmd_type="${file_spec%%:*}"
    cmd_file="${file_spec#*:}"
    echo -e "${GREEN}Creating $cmd_type command: $cmd_file${NC}"
    if ! create_command_file "$cmd_type" "$cmd_file" "$TEMPLATE"; then
        exit 1
    fi
done

# Generate agent sections based on count and type
generate_agents() {
    local count=$1
    local command_type=$2
    local agents=""
    
    if [[ "$command_type" == "hybrid" ]]; then
        # For hybrid commands, suggest scanning agents for phase 1
        agents+="\n## Phase 1: Parallel Scanning Agents\n"
        for ((i=1; i<=count/2; i++)); do
            agents+="\n$i. **Scanner Agent $i**: Task(description=\"Scan for specific patterns/areas\", prompt=\"Scan \$ARGUMENTS for [specific aspect]. Look for [patterns/files/structures]. Return findings as structured JSON.\", subagent_type=\"file-scanner\")\n"
        done
        
        agents+="\n## Phase 2: Expert Delegation (Dynamic)\n"
        agents+="\nBased on Phase 1 findings, delegate to specialized experts:\n"
        agents+="\n- **Code Expert**: For implementation details and code quality"
        agents+="\n- **Architecture Expert**: For system design and patterns"
        agents+="\n- **Testing Expert**: For test coverage and quality"
        agents+="\n- **Documentation Expert**: For docs and comments"
        agents+="\n- **[Domain] Expert**: Add domain-specific experts as needed\n"
    else
        # Traditional task-based agents
        for ((i=1; i<=count; i++)); do
            agents+="\n$i. **Agent $i Name**: Task(description=\"Agent $i Task\", prompt=\"Detailed prompt for agent $i. Describe what to analyze for \$ARGUMENTS. Be specific about tools to use and output format. Return results as JSON.\", subagent_type=\"general-purpose\")\n"
        done
    fi
    
    echo -e "$agents"
}

# Display success message and next steps
echo -e "${GREEN}✓ Command(s) created successfully!${NC}"
echo
echo "Created files:"
for file_spec in "${FILES_TO_CREATE[@]}"; do
    file_path="${file_spec#*:}"
    echo "  - $file_path"
done
echo
echo "Suggested sub-agent types for $CATEGORY category:"
echo "  $(suggest_subagents "$CATEGORY")"
echo
echo "Next steps:"
echo "1. Edit the command file(s) to customize:"
if [[ "$TYPE" == "hybrid" ]] || [[ "$TYPE" == "both" ]]; then
    echo "   For hybrid commands:"
    echo "   - Phase 1: Configure scanning agents"
    echo "   - Phase 2: Define expert delegation logic"
    echo "   - Phase 3: Customize synthesis approach"
fi
echo "   - Agent names and descriptions"
echo "   - Detailed prompts for each agent"
echo "   - Output format and report structure"
echo
echo "2. Test your command(s):"
for file_spec in "${FILES_TO_CREATE[@]}"; do
    cmd_type="${file_spec%%:*}"
    base_name="${COMMAND_NAME}"
    if [[ "$cmd_type" == "hybrid" ]] && [[ "$TYPE" == "both" ]]; then
        base_name="${COMMAND_NAME}-hybrid"
    fi
    echo "   /yourprefix:$CATEGORY:$base_name [arguments]"
done
echo
echo "3. Update README:"
echo "   ./scripts/update-readme.sh"

# Offer to open files in editor
if command -v "${EDITOR:-vim}" >/dev/null 2>&1; then
    if [[ ${#FILES_TO_CREATE[@]} -eq 1 ]]; then
        read -p "Open in editor? (Y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            file_path="${FILES_TO_CREATE[0]#*:}"
            "${EDITOR:-vim}" "$file_path"
        fi
    else
        read -p "Open all files in editor? (Y/n): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Nn]$ ]]; then
            for file_spec in "${FILES_TO_CREATE[@]}"; do
                file_path="${file_spec#*:}"
                "${EDITOR:-vim}" "$file_path"
            done
        fi
    fi
fi