#!/bin/bash

# Create Agent Script - Generate new agents from template with proper validation
# Usage: ./scripts/create-agent.sh <agent-name> <type> <category> "<description>"

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
TEMPLATE_FILE="$PROJECT_ROOT/templates/agent-template.md"
AGENTS_DIR="$PROJECT_ROOT/agents"

# Function to display usage
show_usage() {
    echo "Usage: $0 <agent-name> <type> <category> \"<description>\""
    echo ""
    echo "Arguments:"
    echo "  agent-name    : Unique identifier for the agent (lowercase, hyphenated)"
    echo "  type          : Agent type (specialist|analyzer|helper|research)"
    echo "  category      : Agent category (analysis|architecture|documentation|frontend|git|operations|research|security|testing|typo3)"
    echo "  description   : Brief description of the agent's purpose"
    echo ""
    echo "Examples:"
    echo "  $0 database-optimizer specialist operations \"Database performance optimization expert\""
    echo "  $0 code-reviewer analyzer security \"Automated code review and quality analysis\""
    echo "  $0 api-tester helper testing \"API testing and validation assistant\""
    exit 1
}

# Function to validate agent name
validate_agent_name() {
    local name="$1"
    if [[ ! "$name" =~ ^[a-z][a-z0-9-]*[a-z0-9]$ ]]; then
        echo -e "${RED}Error: Agent name must be lowercase, hyphenated, start with a letter, and end with a letter or number${NC}"
        echo -e "${RED}Invalid name: $name${NC}"
        exit 1
    fi
}

# Function to validate agent type
validate_agent_type() {
    local type="$1"
    if [[ ! "$type" =~ ^(specialist|analyzer|helper|research)$ ]]; then
        echo -e "${RED}Error: Agent type must be one of: specialist, analyzer, helper, research${NC}"
        echo -e "${RED}Invalid type: $type${NC}"
        exit 1
    fi
}

# Function to validate agent category
validate_agent_category() {
    local category="$1"
    if [[ ! "$category" =~ ^(analysis|architecture|documentation|frontend|git|operations|research|security|testing|typo3)$ ]]; then
        echo -e "${RED}Error: Agent category must be one of: analysis, architecture, documentation, frontend, git, operations, research, security, testing, typo3${NC}"
        echo -e "${RED}Invalid category: $category${NC}"
        exit 1
    fi
}

# Function to check if agent already exists
check_agent_exists() {
    local name="$1"
    local agent_file="$AGENTS_DIR/${name}.md"
    if [[ -f "$agent_file" ]]; then
        echo -e "${YELLOW}Warning: Agent '$name' already exists at $agent_file${NC}"
        read -p "Do you want to overwrite it? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo -e "${RED}Aborted: Agent creation cancelled${NC}"
            exit 1
        fi
    fi
}

# Function to determine expertise based on name and type
determine_expertise() {
    local name="$1"
    local type="$2"

    # Determine expertise based on keywords in name
    case "$name" in
        *database* | *db* | *sql*)
            echo "Database Optimization"
            ;;
        *security* | *auth* | *crypto*)
            echo "Application Security"
            ;;
        *performance* | *perf* | *optimize*)
            echo "Performance Optimization"
            ;;
        *frontend* | *ui* | *ux*)
            echo "Frontend Development"
            ;;
        *backend* | *api* | *server*)
            echo "Backend Development"
            ;;
        *test* | *qa* | *quality*)
            echo "Testing & Quality Assurance"
            ;;
        *documentation*)
            echo "Documentation & Technical Writing"
            ;;
        *doc*)
            echo "Documentation & Technical Writing"
            ;;
        *cloud* | *deploy* | *devops*)
            echo "Cloud & DevOps"
            ;;
        *)
            # Default based on type
            case "$type" in
                specialist)
                    echo "Domain Expertise"
                    ;;
                analyzer)
                    echo "Code Analysis"
                    ;;
                helper)
                    echo "Development Assistance"
                    ;;
                research)
                    echo "Technical Research"
                    ;;
                *)
                    echo "General Development"
                    ;;
            esac
            ;;
    esac
}

# Function to create agent from template
create_agent() {
    local name="$1"
    local type="$2"
    local category="$3"
    local description="$4"
    local expertise
    expertise=$(determine_expertise "$name" "$type")

    # Prepare output file
    local output_file="$AGENTS_DIR/${name}.md"

    # Create agents directory if it doesn't exist
    mkdir -p "$AGENTS_DIR"

    # Copy template and replace placeholders
    cp "$TEMPLATE_FILE" "$output_file"

    # Perform replacements based on agent name and type
    local title
    title=$(echo "$name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1')

    # Platform-specific sed in-place editing
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS
        sed -i '' "s/\[AGENT_NAME\]/$name/g" "$output_file"
        sed -i '' "s/\[AGENT_DESCRIPTION\]/$description/g" "$output_file"
        sed -i '' "s/\[CATEGORY\]/$category/g" "$output_file"
        sed -i '' "s/\[specialist|analyzer|helper|research\]/$type/g" "$output_file"
        sed -i '' "s/\[PRIMARY_DOMAIN\]/$expertise/g" "$output_file"
        sed -i '' "s/\[AGENT_TITLE\]/$title Agent/g" "$output_file"
        sed -i '' "s/\[MCP_TOOLS\]/# Add MCP tools if needed/g" "$output_file"
    else
        # Linux
        sed -i "s/\[AGENT_NAME\]/$name/g" "$output_file"
        sed -i "s/\[AGENT_DESCRIPTION\]/$description/g" "$output_file"
        sed -i "s/\[CATEGORY\]/$category/g" "$output_file"
        sed -i "s/\[specialist|analyzer|helper|research\]/$type/g" "$output_file"
        sed -i "s/\[PRIMARY_DOMAIN\]/$expertise/g" "$output_file"
        sed -i "s/\[AGENT_TITLE\]/$title Agent/g" "$output_file"
        sed -i "s/\[MCP_TOOLS\]/# Add MCP tools if needed/g" "$output_file"
    fi

    echo -e "${GREEN}✓ Agent created successfully at: $output_file${NC}"
    echo ""
    echo "Next steps:"
    echo "1. Edit the agent file to customize the template placeholders"
    echo "2. Define specific expertise areas and analysis methodology"
    echo "3. Test the agent with an orchestration command"
    echo "4. Run './scripts/update-readme.sh' to update documentation"
    echo ""
    echo "To use this agent in a command, reference it with:"
    echo "  subagent_type=\"$name\""
}

# Main script
main() {
    # Check if template exists
    if [[ ! -f "$TEMPLATE_FILE" ]]; then
        echo -e "${RED}Error: Template file not found at $TEMPLATE_FILE${NC}"
        exit 1
    fi

    # Check arguments
    if [[ $# -lt 4 ]]; then
        show_usage
    fi

    # Parse arguments
    AGENT_NAME="$1"
    AGENT_TYPE="$2"
    AGENT_CATEGORY="$3"
    AGENT_DESCRIPTION="$4"

    # Validate inputs
    validate_agent_name "$AGENT_NAME"
    validate_agent_type "$AGENT_TYPE"
    validate_agent_category "$AGENT_CATEGORY"

    # Check if agent already exists
    check_agent_exists "$AGENT_NAME"

    # Create the agent
    echo -e "${GREEN}Creating agent: $AGENT_NAME${NC}"
    echo "Type: $AGENT_TYPE"
    echo "Category: $AGENT_CATEGORY"
    echo "Description: $AGENT_DESCRIPTION"
    echo ""

    create_agent "$AGENT_NAME" "$AGENT_TYPE" "$AGENT_CATEGORY" "$AGENT_DESCRIPTION"
}

# Run main function
main "$@"
