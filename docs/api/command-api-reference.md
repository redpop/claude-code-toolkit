# Claude Code Toolkit Command API Reference

This document provides a comprehensive technical reference for creating and structuring commands in the Claude Code Toolkit. It covers the markdown-based command format, frontmatter specifications, integration patterns, and best practices.

## Table of Contents

1. [Command Structure](#command-structure)
2. [Frontmatter Format](#frontmatter-format)
3. [Command Body Format](#command-body-format)
4. [Parameter Handling](#parameter-handling)
5. [Output Specifications](#output-specifications)
6. [Integration with Claude Code](#integration-with-claude-code)
7. [Best Practices](#best-practices)
8. [Examples](#examples)

## Command Structure

Claude Code Toolkit commands are structured as Markdown files with YAML frontmatter. Each command file follows this basic structure:

```markdown
---
# YAML frontmatter with command metadata
---

# Command content in Markdown format
```

### File Organization

Commands are organized in a hierarchical directory structure:

```
commands/
├── category/
│   ├── command-name.md
│   └── another-command.md
└── another-category/
    └── command.md
```

The directory structure determines the command namespace:

- File path: `commands/git/commit.md`
- Command invocation: `/prefix:git:commit`

### Naming Conventions

- **Command files**: `lowercase-with-hyphens.md`
- **Categories**: `lowercase` (single word preferred)
- **No prefixes in filenames** (prefixes are added during installation)

## Frontmatter Format

The YAML frontmatter contains metadata that Claude Code uses to understand and execute commands.

### Core Fields

| Field | Required | Description | Example |
|-------|----------|-------------|----------|
| `description` | **Yes** | Brief command description shown in listings and auto-completion | `description: Creates structured Git commits with Conventional Commit format` |
| `argument-hint` | No | Expected arguments for auto-completion | `argument-hint: [directory] [--focus=security\|performance] [--export-md]` |
| `allowed-tools` | No | Tools the command can use (access control) | `allowed-tools: Task, Read, Grep, Bash(git:*), Write` |
| `mcp-enhanced` | No | MCP tools that enhance this command | `mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan` |

### Tool Specifications

- `Task` - Parallel task execution with sub-agents
- `Read`, `Write`, `Edit`, `MultiEdit` - File operations
- `Grep` - Advanced pattern searching
- `Bash` - Command execution (all commands)
- `Bash(command:*)` - Specific command allowlist (e.g., `Bash(git:*)` for git only)
- `TodoWrite` - Task management

### Argument Patterns

- `[optional-arg]` - Optional positional
- `<required-arg>` - Required positional
- `[--flag]` - Optional flag
- `[--option=value]` - Option with value

### Example

```yaml
---
description: Deep code analysis combining parallel scanning with specialized sub-agent expertise
argument-hint: [directory] [--focus=security|performance|all] [--export-md] [--export-json]
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
---
```

## Command Body Format

The command body is a Markdown prompt/instructions for Claude Code.

### Standard Structure

```markdown
# Command Name
Brief description and primary use case.

## Usage
```bash
/command [arguments] [--options]
```

## Workflow
1. **Phase 1**: Initial step description
2. **Phase 2**: Main execution logic  
3. **Phase 3**: Output generation

## Options
- `--option=value`: Description
- `--flag`: Description
```

### Key Patterns

**Tool Detection (MCP-aware):**
```markdown
1. Check for MCP tools: `mcp__[server]__*`
2. Check local tools: `Bash("which [tool]")`
3. Adjust strategy based on availability
```

**Parallel Execution:**
```markdown
Use Task Tool with multiple agents:
- Task(description="...", prompt="...", subagent_type="...")
```

**Sub-Agent Delegation:**
```markdown
Delegate to @specialist-agent:
"READ-ONLY ANALYSIS. Analyze: [areas] Focus: [concerns]"
```

## Parameter Handling

### The $ARGUMENTS Variable

The `$ARGUMENTS` placeholder receives all user input after the command:

```bash
/command some input --flag --option=value
         └────────────────────────────┘
                   $ARGUMENTS
```

### Common Patterns

- **Default values**: `If no directory provided, use current directory (.)`
- **Flag detection**: `Check if $ARGUMENTS contains --no-verify`
- **Option extraction**: `Extract --focus=<value> from $ARGUMENTS`
- **Multiple paths**: `Process each path/glob pattern in $ARGUMENTS`
- **Validation**: Verify paths exist, options are valid

## Output Specifications

### Report Structure

```markdown
# Analysis Report

## Executive Summary
- Duration: X seconds
- Tool Used: [Enhanced|Traditional]
- Issues Found: X critical, Y high, Z medium

## Findings
### Category
1. **Issue Title** (Severity)
   - File: `path/file.js:line`
   - Impact: Description
   - Fix: Solution

## Recommendations
- Immediate: Critical fixes
- Short-term: Important improvements
```

### Export Formats

**JSON Export (`--export-json`):**
```json
{
  "metadata": { "timestamp": "...", "command": "..." },
  "summary": { "health_score": 75, "issues": {...} },
  "findings": [{ "id": "...", "severity": "...", ... }]
}
```

**Auto-generated filenames:**
- Pattern: `command-YYYYMMDD-HHMMSS.ext`
- Default directory: `reports/`

## Integration with Claude Code

### Command Discovery & Invocation

```bash
# File structure
~/.claude/commands/prefix/category/command.md

# Invocation pattern
/prefix:category:command [arguments]
```

Claude Code:
1. Parses command path
2. Loads `.md` file
3. Extracts frontmatter
4. Executes body as instructions
5. Passes arguments via `$ARGUMENTS`

### Tool Access Control

Commands only use tools in `allowed-tools`:
- `Task` - Parallel sub-agent execution
- `Read/Write/Edit` - File operations
- `Grep` - Pattern searching
- `Bash(cmd:*)` - Command-specific access

### Sub-Agent & MCP Integration

**Sub-agents:** Delegate specialized tasks
```markdown
Delegate to @agent-name: "Task description"
```

**MCP Enhancement:** Progressive enhancement
```markdown
If mcp__tool available: Use enhanced features
Else: Fall back to traditional methods
```

## Best Practices

### Command Design Principles

1. **Single Responsibility** - One clear purpose
2. **Graceful Degradation** - Works without optional tools
3. **Read-Only Default** - Avoid modifications unless requested
4. **Clear Documentation** - Usage, parameters, output format
5. **Input Validation** - Check parameters before use
6. **Error Handling** - Clear messages, graceful exits

### Performance Guidelines

- Target: <30 seconds for standard analysis
- Use parallel execution where possible
- Implement progress indicators for long operations
- Consider incremental processing for large codebases

### Testing Checklist

- [ ] Basic invocation works
- [ ] Parameters parse correctly
- [ ] Handles missing tools gracefully
- [ ] Validates input properly
- [ ] Produces expected output format

## Examples

### Basic Command

```yaml
---
description: Find and analyze TODO comments in code
argument-hint: [directory] [--format=list|grouped|json]
---

# Find TODOs
Searches for TODO, FIXME, HACK comments.

## Usage
/find-todos src/ --format=json

## Workflow
1. Search patterns with Grep
2. Extract context and metadata
3. Format output based on --format
```

### MCP-Enhanced Command

```yaml
---
description: Security audit with optional MCP enhancement
argument-hint: [directory] [--severity=critical|high|all]
allowed-tools: Task, Read, Grep, Bash(semgrep:*)
mcp-enhanced: mcp__semgrep__security_check
---

# Security Audit

## Tool Detection
1. Check mcp__semgrep__security_check
2. Check local semgrep
3. Fall back to patterns

## Execution
- With MCP: AST-based analysis
- Fallback: Pattern matching
```

### Workflow Command

```yaml
---
description: Orchestrate code quality sprint
argument-hint: [--duration=1w|2w] [--team-size=N]
allowed-tools: Task, Read, Write, TodoWrite, Bash(git:*)
---

# Quality Sprint

## Phases
1. Planning: Analysis → Prioritization → Assignment
2. Execution: Progress tracking → Quality gates
3. Review: Reports → Metrics → Next sprint

Use TodoWrite for task management.
```

## Summary

Claude Code Toolkit commands use Markdown files with YAML frontmatter to define reusable operations. Key aspects:

- **Frontmatter**: Defines metadata (`description`, `argument-hint`, `allowed-tools`, `mcp-enhanced`)
- **Body**: Contains instructions executed by Claude Code
- **Parameters**: Handled via `$ARGUMENTS` placeholder
- **Integration**: Supports sub-agents, MCP tools, and progressive enhancement
- **Best Practices**: Single responsibility, graceful degradation, clear documentation

For templates and examples, see `/commands/templates/` in the repository.
