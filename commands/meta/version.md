---
description: Check installed toolkit version and available updates
argument-hint: "[check|update]"
---

# Version Check Command

Check the installed Claude Code Toolkit version and see if updates are available.

## Usage

- `/$PREFIX:meta:version` - Show installed version information
- `/$PREFIX:meta:version check` - Check for available updates
- `/$PREFIX:meta:version update` - Show update instructions

## Workflow

### Step 1: Read Installed Version

First, check if version file exists and read the installation information:

```bash
if [ -f "$HOME/.claude/claude-code-toolkit/.installed-version" ]; then
    cat "$HOME/.claude/claude-code-toolkit/.installed-version"
else
    echo "No version information found. Toolkit may not be installed or needs reinstallation."
fi
```

### Step 2: Display Version Information

Parse and display the version information in a user-friendly format:

1. **Installed Commit**: Show the Git commit hash
2. **Installation Date**: When it was installed
3. **Source Directory**: Where the repository is located
4. **Branch**: Which branch was used
5. **Last Commit Message**: What was the last change

### Step 3: Check for Updates (if requested)

If the user wants to check for updates:

1. Check if source directory still exists
2. Navigate to source directory
3. Run `git fetch` to get latest information
4. Compare installed hash with latest
5. Show number of new commits available

### Step 4: Provide Update Instructions

If updates are available, provide clear instructions:

```
Updates available! To update your toolkit:

1. Navigate to your repository:
   cd [SOURCE_DIR]

2. Pull the latest changes:
   git pull

3. Run the installation again:
   ./install.sh [PREFIX]

This will show you all changes since your last installation.
```

## Implementation

When executed, perform these checks:

1. **Read version file**: `~/.claude/claude-code-toolkit/.installed-version`
2. **Parse information**: Extract commit hash, dates, and paths
3. **Format output**: Present information clearly
4. **Check source**: Verify if source repository still exists
5. **Suggest actions**: Provide appropriate next steps

## Example Output

```
Claude Code Toolkit Version Information
========================================

Installed Version:
  Commit: 55fcaec (2025-01-13 10:45:23)
  Message: 🐛 fix: use self-closing br tags in HTML format
  Branch: main
  Installed: 2025-01-13 14:30:00
  Prefix: mytools

Source Repository:
  Location: /Users/username/repos/claude-code-toolkit
  Status: ✓ Repository found

To check for updates:
  cd /Users/username/repos/claude-code-toolkit
  git pull
  ./install.sh mytools
```

## Notes

- Version tracking uses Git commit hashes for precise version identification
- No manual version numbers needed - every commit is trackable
- Works with any installation prefix
- Supports both global and local installations