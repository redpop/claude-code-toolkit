#!/bin/bash

# update-readme.sh - Generate command documentation for README.md
# This script scans all command files and updates the README with a current list

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to capitalize first letter of a word
capitalize_first() {
    local word="$1"
    local first_letter
    local rest
    first_letter=$(echo "$word" | cut -c1 | tr '[:lower:]' '[:upper:]')
    rest=$(echo "$word" | cut -c2-)
    echo "${first_letter}${rest}"
}

# Get script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$( cd "$SCRIPT_DIR/.." && pwd )"
COMMANDS_DIR="$PROJECT_ROOT/commands"
README_FILE="$PROJECT_ROOT/README.md"

# Temporary file for building the commands section
TEMP_FILE=$(mktemp)

# Function to extract frontmatter value
extract_frontmatter() {
    local file=$1
    local key=$2
    
    # Extract the value between --- markers
    awk -v key="$key" '
        /^---$/ { if (in_fm) exit; in_fm = 1; next }
        in_fm && $0 ~ "^" key ": " {
            sub("^" key ": ", "")
            # Remove surrounding quotes if present
            gsub(/^["'\''"]|["'\''"]$/, "")
            print
            exit
        }
    ' "$file"
}

# Function to extract first paragraph after frontmatter as fallback description
extract_first_paragraph() {
    local file=$1
    
    awk '
        /^---$/ { if (in_fm) { in_fm = 0; found_end = 1 } else { in_fm = 1 }; next }
        found_end && NF > 0 && !found_para { 
            # Skip headers
            if ($0 !~ /^#/) {
                print
                found_para = 1
            }
            next
        }
        found_para && NF == 0 { exit }
        found_para { print }
    ' "$file" | head -1
}

echo -e "${YELLOW}Scanning commands directory...${NC}"

# Start building the commands section
cat > "$TEMP_FILE" << 'EOF'
<!-- COMMANDS:START - DO NOT EDIT -->
EOF

# Track if we have any commands
has_commands=false

# Process each category directory
for category_dir in "$COMMANDS_DIR"/*; do
    if [ -d "$category_dir" ]; then
        category_name=$(basename "$category_dir")
        category_title=$(capitalize_first "$category_name")
        category_has_commands=false
        
        # Temporary storage for this category
        category_content=""
        
        # Process each command file in the category
        for cmd_file in "$category_dir"/*.md; do
            if [ -f "$cmd_file" ]; then
                cmd_name=$(basename "$cmd_file" .md)
                
                # Extract metadata
                description=$(extract_frontmatter "$cmd_file" "description")
                if [ -z "$description" ]; then
                    # Fallback to first paragraph
                    description=$(extract_first_paragraph "$cmd_file")
                fi
                
                argument_hint=$(extract_frontmatter "$cmd_file" "argument-hint")
                
                # Build command entry
                if [ "$category_has_commands" = false ]; then
                    category_content+="\n### ${category_title} Commands\n\n"
                    category_content+="| Command | Description | Options |\n"
                    category_content+="|---------|-------------|---------|"
                    category_has_commands=true
                    has_commands=true
                fi
                
                # Format options from argument-hint
                options=""
                if [ -n "$argument_hint" ]; then
                    # Clean up the argument hint and format as code
                    # Remove brackets and wrap each option in backticks
                    cleaned=$(echo "$argument_hint" | sed 's/\[//g; s/\]//g')
                    # Only wrap in backticks if not empty after cleaning
                    if [ -n "$cleaned" ]; then
                        # Split by spaces and wrap each option in backticks
                        # Also escape pipe characters for markdown tables
                        options=$(echo "$cleaned" | awk '{
                            for(i=1; i<=NF; i++) {
                                if(i>1) printf ", "
                                # Escape pipe characters in the option
                                gsub(/\|/, "\\|", $i)
                                printf "`%s`", $i
                            }
                        }')
                    fi
                fi
                
                # Add command row
                category_content+="\n| \`/prefix:${category_name}:${cmd_name}\` | ${description:-No description} | ${options:--} |"
            fi
        done
        
        # Add category to output if it has commands
        if [ "$category_has_commands" = true ]; then
            echo -e "$category_content" >> "$TEMP_FILE"
            echo "" >> "$TEMP_FILE"
        fi
    fi
done

# Close the commands section
# No need to add END marker to temp file since it's already in README

if [ "$has_commands" = false ]; then
    echo -e "${YELLOW}No commands found in $COMMANDS_DIR${NC}"
    rm "$TEMP_FILE"
    exit 0
fi

# Update README.md
echo -e "${YELLOW}Updating README.md...${NC}"

# Create backup
cp "$README_FILE" "${README_FILE}.bak"

# Replace the content between the markers
awk '
    /<!-- COMMANDS:START/ { 
        print
        skip = 1
        next
    }
    /<!-- COMMANDS:END/ { 
        print
        skip = 0
        next
    }
    skip && !done { 
        # Insert new content once
        while ((getline line < "'"$TEMP_FILE"'") > 0) {
            # Skip the first marker line from temp file
            if (line !~ /<!-- COMMANDS:START/) {
                print line
            }
        }
        close("'"$TEMP_FILE"'")
        done = 1
    }
    !skip { print }
' "${README_FILE}.bak" > "$README_FILE"

# Clean up
rm "$TEMP_FILE"
rm "${README_FILE}.bak"

echo -e "${GREEN}✓ README.md updated successfully!${NC}"