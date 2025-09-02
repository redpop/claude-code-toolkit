---
allowed-tools: Read, Write, Edit, Bash(jq:*), Bash(grep:*)
argument-hint: "[project-directory] [--force] [--minimal]"
description: Setup Cipher memory integration by enhancing CLAUDE.md with memory usage instructions
---

# Setup Cipher Memory Integration for Claude Code Project

Automatically enhance the current project's CLAUDE.md file with comprehensive Cipher memory integration instructions. This tells Claude Code to actively use Cipher's memory functions for persistent, intelligent coding assistance.

**Critical**: Without these instructions in CLAUDE.md, Claude Code will NOT automatically use Cipher memory functions even when Cipher MCP is connected.

## Implementation Steps

### 1. Determine Project Directory and Parse Arguments

Parse arguments from `$ARGUMENTS` to extract project directory and flags:

```
PROJECT_DIR = first non-flag argument OR current directory
FORCE_FLAG = true if --force present
MINIMAL_FLAG = true if --minimal present
```

### 2. Validate Project and Gather Context

- Verify project directory exists and is accessible
- Extract project name from directory name or package.json
- Auto-detect tech stack from package.json, pyproject.toml, Cargo.toml, go.mod, etc.
- Extract important commands from package.json scripts if available

### 3. Handle Existing CLAUDE.md

If CLAUDE.md already exists:

- With `--force`: Backup existing file with timestamp
- Without `--force`: Show error and suggest using --force flag
- Always preserve existing content when possible

### 4. Generate Cipher Integration Content

Create or enhance CLAUDE.md with this structure:

```markdown
# CLAUDE.md

[... existing content preserved ...]

## Cipher Memory Integration

### CRITICAL: Active Memory Usage Required

Claude Code MUST actively use Cipher memory for this project. This is NOT automatic - follow these explicit patterns:

#### Before Starting Any Task
```

ALWAYS run: cipher_memory_search "search term related to current task"

```
- Search for similar problems solved before
- Check for established patterns in this project
- Review past architectural decisions

#### After Completing Any Task
```

ALWAYS run: cipher_extract_and_operate_memory "description of what was implemented and the approach used"

```
- Store successful implementations
- Document problem-solving approaches
- Save project-specific patterns

#### After Debugging/Problem Solving  
```

ALWAYS run: cipher_store_reasoning_memory "debugging approach and final resolution"

```
- Store debugging strategies that worked
- Document root causes and solutions
- Build troubleshooting knowledge base

### Project Context
- Project: [DETECTED PROJECT NAME]
- Tech Stack: [DETECTED TECH STACK]
- Key Commands: [DETECTED NPM SCRIPTS]

### Memory Usage Rules
1. NEVER skip memory searches before implementing features
2. ALWAYS store successful solutions for future reference
3. PROACTIVELY update project context when learning new patterns
4. USE project-specific sessions: `cipher session new "[PROJECT_NAME]-feature"`
5. STORE debugging approaches that work for this codebase

### Integration Verification
Test: `cipher_memory_search "project setup"` should return stored project context.
If empty: Run `/init` to analyze codebase and populate initial memory.

---
**This project uses Cipher for persistent memory across coding sessions.**
```

### 5. Auto-Population of Detected Values

Replace placeholders with detected information:

- `[DETECTED PROJECT NAME]`: From directory or package.json name
- `[DETECTED TECH STACK]`: Framework, language, build tools found
- `[DETECTED NPM SCRIPTS]`: Key commands from package.json

### 6. Success Confirmation

Display completion message with:

- Location of created/modified CLAUDE.md
- Auto-detected project information used
- Next steps for the user (restart Claude Code, run /init)
- Verification commands to test integration

## Command Flow Summary

1. **Parse** arguments and flags from `$ARGUMENTS`
2. **Validate** project directory and access
3. **Detect** project context (name, tech stack, commands)
4. **Backup** existing CLAUDE.md if needed
5. **Enhance** CLAUDE.md with Cipher integration instructions
6. **Auto-populate** detected project information
7. **Report** success with next steps

## Error Handling

- Invalid directory: Clear error message with suggestion
- Permission issues: Specific guidance on file permissions
- Missing tools (jq): Fallback to basic text processing
- Backup failures: Continue with warning

## Success Criteria

After running this command:

1. ✅ CLAUDE.md exists with comprehensive Cipher integration instructions
2. ✅ Project-specific context is auto-populated where possible
3. ✅ Claude Code will actively use Cipher memory functions in this project
4. ✅ User knows exact next steps to complete setup

This command transforms any project into a Cipher-enabled development environment where Claude Code intelligently uses persistent memory.
