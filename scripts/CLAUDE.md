# CLAUDE.md - Scripts Directory

This file provides context for Claude Code when working with utility scripts in this directory.

## Available Scripts

### Core Scripts

**install.sh**
- Main installation script for the toolkit
- Copies commands and agents to `~/.claude/`
- Supports custom prefix installation
- Creates backups when updating existing installations
- Must be run from inside the cloned repository

**update-readme.sh**
- Auto-generates command documentation in README.md
- Scans all `.md` files in `commands/` directory
- Extracts frontmatter metadata
- Updates section between `<!-- COMMANDS:START -->` and `<!-- COMMANDS:END -->`
- Preserves manual sections of README

### Creation Scripts

**create-agent.sh**
- Standardized agent creation with validation
- Usage: `./scripts/create-agent.sh <agent-name> <type> "<description>"`
- Ensures required frontmatter fields
- Uses templates for consistency
- Validates agent names and types

**create-sub-agent.sh**
- Creates new sub-agent definitions
- Generates proper structure
- Includes boilerplate code

**create-sub-agent-command.sh**
- Scaffolds new sub-agent orchestration commands
- Generates boilerplate with proper structure
- Ensures consistent command format

### Analysis Scripts

**report-history.js**
- Manages report history and tracking
- Analyzes trends across multiple reports
- JavaScript-based for JSON processing

**trend-analyzer.sh**
- Analyzes code quality trends over time
- Compares metrics across reports
- Generates trend visualizations

## Installation Script Details

The `install.sh` script handles toolkit installation:

### Key Features
- Simple file copy installation (no git in target)
- Supports multiple installations with different prefixes
- Creates backups of existing installations
- Lists all available commands after installation
- Clean separation between repository and installation

### Installation Process
1. Validates running from repository root
2. Prompts for installation prefix
3. Creates target directories
4. Copies command files to `~/.claude/commands/PREFIX/`
5. Copies agent files to `~/.claude/agents/`
6. Lists installed commands and agents

### Usage
```bash
# Basic installation
./install.sh

# With specific prefix
./install.sh myproject
```

## Code Quality & Linting

### Shellcheck for Bash Scripts

All bash scripts should be validated with shellcheck:

```bash
# Check individual script
shellcheck install.sh

# Check all scripts
shellcheck scripts/*.sh install.sh
```

### Shellcheck Best Practices

- Always quote variables: `"$variable"` instead of `$variable`
- Use `[[ ]]` instead of `[ ]` for conditional expressions
- Prefer `$()` over backticks for command substitution
- Handle potential failures with proper error checking
- Use proper array handling syntax

### Common Issues to Avoid

1. **Unquoted variables**: Can cause word splitting
2. **Missing error handling**: Scripts should check return codes
3. **Hardcoded paths**: Use variables for flexibility
4. **No input validation**: Always validate user input
5. **Missing dependencies check**: Verify required tools exist

## README Maintenance

The `update-readme.sh` script maintains command documentation:

### Auto-generated Section
- Section between markers is automatically maintained
- **DO NOT manually edit** content between markers
- Changes will be overwritten on next update

### Update Process
1. Scans all `.md` files in `commands/` directory
2. Extracts frontmatter metadata (`description` and `argument-hint`)
3. Generates formatted table with all commands
4. Updates only marked section in README.md

### When to Run
- After adding new commands
- After modifying command frontmatter
- Before committing command changes
- As part of release process

## Script Development Guidelines

### Creating New Scripts

1. **Purpose**: Each script should have a single, clear purpose
2. **Documentation**: Include usage comments at script top
3. **Error Handling**: Implement proper error checking
4. **Validation**: Validate all inputs and prerequisites
5. **Feedback**: Provide clear user feedback

### Script Structure Template

```bash
#!/usr/bin/env bash
set -euo pipefail

# Script: script-name.sh
# Purpose: Brief description
# Usage: ./script-name.sh [arguments]

# Constants
readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly ROOT_DIR="$(dirname "$SCRIPT_DIR")"

# Functions
function usage() {
    echo "Usage: $0 [arguments]"
    echo "  -h, --help    Show this help"
    exit 0
}

function main() {
    # Main logic here
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help) usage ;;
        *) echo "Unknown option: $1"; usage ;;
    esac
    shift
done

# Run main function
main "$@"
```

## Testing Scripts

Before committing new or modified scripts:

1. Run shellcheck for linting
2. Test with various inputs
3. Test error conditions
4. Verify idempotency where applicable
5. Check compatibility across environments

## CI Integration

Consider adding to CI pipeline:
- Shellcheck validation
- Script execution tests
- Dependency verification
- Cross-platform testing