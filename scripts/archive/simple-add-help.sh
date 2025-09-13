#!/bin/bash

# Simpler script to add --help support to all commands

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMMANDS_DIR="$REPO_ROOT/commands"

# Help content to add after first heading
HELP_CONTENT='
## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

📚 **Command Help**

Display this command'"'"'s documentation:
- **Description**: Extract from frontmatter `description` field
- **Usage**: Extract from frontmatter `argument-hint` field  
- **Options**: Extract from frontmatter `options` field if present
- **Examples**: Extract from frontmatter `examples` field if present
- **Related**: Extract from frontmatter `see-also` field if present

Format the help output clearly and exit without executing the main command.

---
'

echo "Adding --help support to commands..."

# Process each command file
for file in $(/usr/bin/find "$COMMANDS_DIR" -type f -name "*.md"); do
    # Skip if already has help support
    if grep -q '## Help Check\|"--help"\|contains "--help"' "$file" 2>/dev/null; then
        echo "Skipping: $file (already has help)"
        continue
    fi
    
    echo "Updating: $file"
    
    # Use awk to insert help after the first main heading
    awk -v help="$HELP_CONTENT" '
        /^# / && !help_added {
            print
            getline
            print
            print help
            help_added = 1
            next
        }
        {print}
    ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
done

echo "Done! All commands now support --help"