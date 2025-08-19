---
description: Lint and fix markdown files using markdownlint-cli2
argument-hint: <file-or-directory> [--fix] [--config <path>]
---

# Markdown Lint Command

Analyzes and optionally fixes markdown formatting issues using markdownlint-cli2.

## Core Functionality

This command provides comprehensive markdown linting with automatic detection of the best available runner:

1. **Auto-detection**: Prefers Homebrew installation, falls back to npx
2. **Recursive scanning**: Automatically processes all subdirectories
3. **Optional fixing**: Add `--fix` to automatically correct issues
4. **Custom config**: Support for custom markdownlint configuration

## Usage Examples

```bash
# Lint a single file
/prefix:fix:markdown README.md

# Lint and fix a file
/prefix:fix:markdown README.md --fix

# Lint entire directory recursively
/prefix:fix:markdown docs/

# Fix all markdown files in project
/prefix:fix:markdown . --fix

# Use custom config
/prefix:fix:markdown . --config .markdownlint.json
```

## Execution

Parse the arguments to understand:

1. Target file or directory
2. Whether to fix issues (`--fix`)
3. Custom config path (`--config`)

Then execute:

```bash
# First, check if markdownlint-cli2 is available
if command -v markdownlint-cli2 >/dev/null 2>&1; then
    echo "✅ Using markdownlint-cli2 from Homebrew/system"
    LINT_CMD="markdownlint-cli2"
else
    echo "📦 Using markdownlint-cli2 via npx"
    LINT_CMD="npx markdownlint-cli2"
fi

# Parse arguments
TARGET="$1"
FIX_FLAG=""
CONFIG_FLAG=""

# Check for --fix flag
if echo "$ARGUMENTS" | grep -q -- "--fix"; then
    FIX_FLAG="--fix"
fi

# Check for --config flag
if echo "$ARGUMENTS" | grep -q -- "--config"; then
    CONFIG_PATH=$(echo "$ARGUMENTS" | sed -n 's/.*--config \([^ ]*\).*/\1/p')
    CONFIG_FLAG="--config $CONFIG_PATH"
else
    # Use toolkit's default config if available
    DEFAULT_CONFIG="$HOME/.claude/claude-code-toolkit/markdown/.markdownlint-cli2.jsonc"
    if [ -f "$DEFAULT_CONFIG" ]; then
        echo "📋 Using Claude Code Toolkit default config"
        CONFIG_FLAG="--config $DEFAULT_CONFIG"
    elif [ -f ".markdownlint-cli2.jsonc" ] || [ -f ".markdownlint-cli2.json" ] || [ -f ".markdownlint.json" ]; then
        echo "📋 Using local project config"
    else
        echo "📋 Using markdownlint-cli2 defaults"
    fi
fi

# Determine if target is file or directory
if [ -f "$TARGET" ]; then
    echo "🔍 Linting file: $TARGET"
    GLOB_PATTERN="$TARGET"
elif [ -d "$TARGET" ]; then
    echo "🔍 Linting directory recursively: $TARGET"
    GLOB_PATTERN="$TARGET/**/*.md"
else
    echo "❌ Error: $TARGET not found"
    exit 1
fi

# Run markdownlint-cli2
echo "Running: $LINT_CMD $CONFIG_FLAG $FIX_FLAG \"$GLOB_PATTERN\""
$LINT_CMD $CONFIG_FLAG $FIX_FLAG "$GLOB_PATTERN"

# Check exit code
if [ $? -eq 0 ]; then
    if [ -n "$FIX_FLAG" ]; then
        echo "✅ All markdown issues fixed!"
    else
        echo "✅ No markdown issues found!"
    fi
else
    if [ -n "$FIX_FLAG" ]; then
        echo "⚠️  Some issues could not be automatically fixed"
        echo "💡 Run without --fix to see remaining issues"
    else
        echo "⚠️  Markdown issues found"
        echo "💡 Run with --fix to automatically fix issues"
    fi
fi
```

## Output

```markdown
✅ Markdown Lint Results

📊 Statistics:
- Files checked: {count}
- Issues found: {issues}
- Issues fixed: {fixed} (if --fix used)

💡 Tips:
- Use --fix to automatically correct issues
- Create .markdownlint.json for custom rules
- See https://github.com/DavidAnson/markdownlint for rule documentation
```

## Features

### Automatic Detection

The command intelligently detects the best available runner:

1. **Homebrew/System**: First checks for globally installed markdownlint-cli2
2. **npx Fallback**: Uses npx if not globally installed
3. **Clear Feedback**: Reports which method is being used

### Recursive Processing

When given a directory:

- Automatically finds all `.md` files
- Processes subdirectories recursively
- Uses glob patterns for efficient scanning

### Configuration Support

Supports custom markdownlint configuration with intelligent defaults:

- **Toolkit Default**: Uses `~/.claude/claude-code-toolkit/markdown/.markdownlint-cli2.jsonc` if installed
- **Project Config**: Falls back to local `.markdownlint-cli2.jsonc`, `.markdownlint-cli2.json`, or `.markdownlint.json`
- **Custom**: Override with `--config path/to/config`
- **Inline**: Respects inline markdownlint comments

### Common Rules

Markdownlint checks for:

- Heading styles and hierarchy
- List formatting consistency
- Line length limits
- Trailing spaces
- Blank line conventions
- Link and image formatting
- Code block languages
- Table formatting

## Examples

### Basic Linting

```bash
/prefix:fix:markdown README.md
```

Shows all formatting issues in README.md.

### Auto-fix Project

```bash
/prefix:fix:markdown . --fix
```

Automatically fixes all fixable issues in all markdown files.

### Custom Configuration

```bash
/prefix:fix:markdown docs/ --config .markdownlint-strict.json
```

Uses stricter rules for documentation directory.

## Notes

- Requires either Homebrew installation or npm/npx available
- Respects `.markdownlintignore` for excluding files
- Some issues require manual intervention
- Exit codes: 0 = success, 1 = issues found, 2 = errors
