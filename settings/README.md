# Settings Directory

This directory contains hook configuration profiles for Claude Code.

## Available Profiles

- **basic-hooks-settings.json** - Basic profile with stop notification and markdown formatting
- **minimal-hooks-settings.json** - Minimal profile with critical error detection and markdown formatting  
- **advanced-hooks-settings.json** - Full profile with all hooks enabled

## Note on JSON Schema

The `$schema` property has been intentionally removed from these files because the JSON schema at `https://json.schemastore.org/claude-code-settings.json` may not yet include all hook types that Claude Code supports (such as `SessionStart`).

According to the Claude Code documentation, `SessionStart` is a valid hook type that requires a `matcher` property with values: `startup`, `resume`, or `clear`.

## Installation

These settings are installed using the main install script:

```bash
./install.sh <prefix> --with-settings --hooks-profile [basic|minimal|advanced]
```

The installation script merges these settings with any existing `~/.claude/settings.json` file, preserving user customizations while adding hook configurations.
