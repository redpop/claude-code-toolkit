---
description: Display help information for any toolkit command
argument-hint: <command-path> [--verbose]
---

# Toolkit Command Help Handler

This command displays help information for any installed Claude Code Toolkit command.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## How It Works

When you pass a command path with `--help`, this handler:

1. Parses the command structure (prefix:category:command)
2. Locates the correct .md file in ~/.claude/commands/
3. Displays formatted help information

## Execution

**Target Command**: $ARGUMENTS

### Step 1: Parse Command Request

```bash
# Extract command components from input
FULL_ARGS="$ARGUMENTS"

# Check if this is a help request
if [[ "$FULL_ARGS" == *"--help"* ]]; then
    # Remove --help flag to get command path
    COMMAND_PATH="${FULL_ARGS/ --help/}"
    COMMAND_PATH="${COMMAND_PATH/--help /}"
    COMMAND_PATH="${COMMAND_PATH/--help/}"
    
    # Parse command structure (prefix:category:command)
    IFS=':' read -r PREFIX CATEGORY COMMAND <<< "$COMMAND_PATH"
    
    # Clean up any leading slash
    PREFIX="${PREFIX#/}"
    
    # Construct file path
    if [[ -n "$PREFIX" && -n "$CATEGORY" && -n "$COMMAND" ]]; then
        FILE_PATH="$HOME/.claude/commands/$PREFIX/$CATEGORY/$COMMAND.md"
    elif [[ -n "$PREFIX" && -n "$CATEGORY" ]]; then
        # Try to find in category without prefix
        FILE_PATH="$HOME/.claude/commands/$CATEGORY/$PREFIX.md"
    fi
    
    # Display help if file exists
    if [[ -f "$FILE_PATH" ]]; then
        echo "📚 Help for /$COMMAND_PATH"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        
        # Extract and display metadata
        if grep -q "^description:" "$FILE_PATH"; then
            DESC=$(grep "^description:" "$FILE_PATH" | sed 's/description: //')
            echo "📋 Description: $DESC"
            echo ""
        fi
        
        if grep -q "^argument-hint:" "$FILE_PATH"; then
            ARGS=$(grep "^argument-hint:" "$FILE_PATH" | sed 's/argument-hint: //')
            echo "⚙️  Arguments: $ARGS"
            echo ""
        fi
        
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        
        # Display main content (skip frontmatter)
        awk '/^---$/ && !f {f=1; next} f && /^---$/ {f=0; next} !f' "$FILE_PATH"
    else
        echo "❌ Command not found: $COMMAND_PATH"
        echo ""
        echo "Looking for: $FILE_PATH"
        echo ""
        echo "Available commands in this category:"
        CATEGORY_PATH="$HOME/.claude/commands/$PREFIX/$CATEGORY/"
        if [[ -d "$CATEGORY_PATH" ]]; then
            ls -1 "$CATEGORY_PATH" | sed 's/\.md$//' | sed 's/^/  - /'
        fi
    fi
else
    # If no --help flag, show general help
    echo "ℹ️  Claude Code Toolkit Help System"
    echo ""
    echo "Usage: /prefix:meta:help-handler <command> --help"
    echo ""
    echo "Examples:"
    echo "  /global:meta:help-handler flow:refactor --help"
    echo "  /global:meta:help-handler scan:deep --help"
    echo ""
    echo "Or use directly with any command:"
    echo "  /global:flow:refactor --help"
fi
```

### Step 2: Format and Display Help

The help output includes:

- Command description
- Argument hints
- Full documentation
- Usage examples
- Related commands

## Integration with Commands

This handler should be invoked automatically when any toolkit command receives `--help`.

## Examples

```bash
# Get help for refactor command
/global:meta:help-handler flow:refactor --help

# Get help for deep scan
/global:meta:help-handler scan:deep --help

# Direct usage (if integrated)
/global:flow:refactor --help
```
