#!/bin/bash

# Script to add --help support to all commands in the Claude Code Toolkit
# This ensures every command can display its documentation when called with --help

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the repository root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMMANDS_DIR="$REPO_ROOT/commands"

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}   Adding --help Support to All Commands${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo

# Help check content to add
HELP_CHECK_CONTENT='## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

📚 **Command Help**

Display this command'\''s documentation:
- **Description**: Extract from frontmatter `description` field
- **Usage**: Extract from frontmatter `argument-hint` field
- **Options**: Extract from frontmatter `options` field if present
- **Examples**: Extract from frontmatter `examples` field if present
- **Related**: Extract from frontmatter `see-also` field if present

Format the help output clearly and exit without executing the main command.

---
'

# Counter for tracking changes
updated=0
skipped=0
total=0

# Function to check if a file already has help support
has_help_support() {
    local file="$1"
    # Check for various help patterns
    if grep -q '## Help Check' "$file" 2>/dev/null || \
       grep -q 'contains "--help"' "$file" 2>/dev/null || \
       grep -q '\["\$ARGUMENTS" == "--help"\]' "$file" 2>/dev/null; then
        return 0
    fi
    return 1
}

# Function to add help check to a command file
add_help_check() {
    local file="$1"
    local relative_path="${file#$REPO_ROOT/}"
    
    # Skip if already has help support
    if has_help_support "$file"; then
        echo -e "${YELLOW}⏭  Skipping${NC} $relative_path (already has help support)"
        ((skipped++))
        return
    fi
    
    # Create temporary file
    local temp_file="${file}.tmp"
    
    # Process the file
    local in_frontmatter=false
    local frontmatter_ended=false
    local help_added=false
    local first_heading_found=false
    
    # Add debug output
    echo -e "${BLUE}  Processing: ${NC}${relative_path}"
    
    while IFS= read -r line; do
        # Track frontmatter boundaries
        if [[ "$line" == "---" ]]; then
            if [[ "$in_frontmatter" == false && "$frontmatter_ended" == false ]]; then
                in_frontmatter=true
            elif [[ "$in_frontmatter" == true ]]; then
                in_frontmatter=false
                frontmatter_ended=true
            fi
            echo "$line" >> "$temp_file"
            continue
        fi
        
        # After frontmatter, look for first heading to insert help check
        if [[ "$frontmatter_ended" == true && "$help_added" == false ]]; then
            # Check if this is a main heading (# Command Name)
            if [[ "$line" =~ ^#[[:space:]] ]]; then
                first_heading_found=true
                echo "$line" >> "$temp_file"
                
                # Read the next line to see if it's a description
                if IFS= read -r next_line; then
                    echo "$next_line" >> "$temp_file"
                    
                    # Add help check after description
                    echo "" >> "$temp_file"
                    echo "$HELP_CHECK_CONTENT" >> "$temp_file"
                    help_added=true
                fi
                continue
            fi
        fi
        
        echo "$line" >> "$temp_file"
    done < "$file"
    
    # If help wasn't added (no heading found), add it at the beginning after frontmatter
    if [[ "$help_added" == false && "$frontmatter_ended" == true ]]; then
        # Rewrite file with help check right after frontmatter
        local temp_file2="${file}.tmp2"
        in_frontmatter=false
        frontmatter_ended=false
        
        while IFS= read -r line; do
            echo "$line" >> "$temp_file2"
            
            if [[ "$line" == "---" ]]; then
                if [[ "$in_frontmatter" == false && "$frontmatter_ended" == false ]]; then
                    in_frontmatter=true
                elif [[ "$in_frontmatter" == true ]]; then
                    in_frontmatter=false
                    frontmatter_ended=true
                    echo "" >> "$temp_file2"
                    echo "$HELP_CHECK_CONTENT" >> "$temp_file2"
                fi
            fi
        done < "$temp_file"
        
        mv "$temp_file2" "$temp_file"
    fi
    
    # Replace original file
    mv "$temp_file" "$file"
    echo -e "${GREEN}✅ Updated${NC} $relative_path"
    ((updated++))
}

# Process all command files
echo -e "${BLUE}Scanning command files...${NC}"
echo

# Process files - use array to avoid subshell issues
files=()
while IFS= read -r -d '' file; do
    files+=("$file")
done < <(/usr/bin/find "$COMMANDS_DIR" -type f -name "*.md" -print0)

total=${#files[@]}

for file in "${files[@]}"; do
    add_help_check "$file"
done

echo
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✅ Complete!${NC}"
echo -e "   Total commands: $total"
echo -e "   Updated: ${GREEN}$updated${NC}"
echo -e "   Skipped: ${YELLOW}$skipped${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"

# Update README if changes were made
if [[ $updated -gt 0 ]]; then
    echo
    echo -e "${BLUE}Updating README documentation...${NC}"
    if [[ -x "$REPO_ROOT/scripts/update-readme.sh" ]]; then
        "$REPO_ROOT/scripts/update-readme.sh"
        echo -e "${GREEN}✅ README updated${NC}"
    else
        echo -e "${YELLOW}⚠️  update-readme.sh not found or not executable${NC}"
    fi
fi

echo
echo -e "${GREEN}All commands now support --help!${NC}"
echo -e "Test with: ${BLUE}/prefix:category:command --help${NC}"