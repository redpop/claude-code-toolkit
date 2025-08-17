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

The YAML frontmatter contains metadata that Claude Code uses to understand and execute commands. All fields are optional except `description`.

### Core Fields

#### `description` (Required)

Brief description of what the command does. This appears in command listings and auto-completion.

```yaml
description: Creates structured Git commits with Conventional Commit format and emojis
```

#### `argument-hint` (Optional)

Provides hints for expected arguments, shown in auto-completion and help.

```yaml
argument-hint: [directory] [--focus=security|performance|all] [--export-md]
```

Common patterns:

- `[optional-arg]` - Optional positional argument
- `<required-arg>` - Required positional argument
- `[--flag]` - Optional flag
- `[--option=value]` - Option with value
- `[arg1] [arg2] ...` - Multiple arguments

#### `allowed-tools` (Optional)

Specifies which Claude Code tools the command can use. This enables tool access control.

```yaml
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(semgrep:*), Write
```

Tool specifications:

- `Task` - Parallel task execution
- `Read` - File reading
- `Write` - File writing (use sparingly)
- `Grep` - Advanced search
- `Bash` - Command execution
- `Bash(command:*)` - Specific command allowlist

#### `mcp-enhanced` (Optional)

Lists MCP (Model Context Protocol) tools that enhance this command's functionality.

```yaml
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
```

Commands should:

1. Check if these tools are available
2. Use enhanced functionality if present
3. Fall back to traditional methods if not

### Complete Frontmatter Example

```yaml
---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
description: Deep code analysis combining parallel scanning with specialized sub-agent expertise
argument-hint: [directory] [--focus=security|performance|all] [--export-md] [--export-json]
---
```

## Command Body Format

The command body is written in Markdown and serves as the prompt/instructions for Claude Code. It should be structured, clear, and actionable.

### Standard Sections

#### 1. Command Title and Overview

```markdown
# Command Name

Brief description of what this command does and its primary use case.
```

#### 2. Usage Examples

````markdown
## Usage

```bash
/command basic-usage
/command with --options
/command complex example --option1=value --option2
```
````

## What This Command Does

1. **Step 1**: Clear description
2. **Step 2**: What happens next
3. **Step 3**: Final outcome

````

#### 3. Detailed Workflow

```markdown
## Workflow Steps

### Phase 1: Initialization
- Validate environment
- Check prerequisites
- Gather parameters

### Phase 2: Execution
- Main logic implementation
- Process data
- Handle edge cases

### Phase 3: Reporting
- Generate output
- Provide recommendations
- Suggest next steps
````

#### 4. Configuration Options

```markdown
## Configuration Options

### Focus Parameters

- `--focus=security`: Prioritize security analysis
- `--focus=performance`: Prioritize performance analysis
- `--focus=all`: Comprehensive analysis (default)

### Export Parameters

- `--export-md[=filename]`: Export markdown report
- `--export-json[=filename]`: Export JSON data
- `--export-dir=path`: Custom export directory
```

### Special Patterns

#### Tool Detection Pattern (MCP-aware commands)

```markdown
## Tool Detection

**FIRST, CHECK AVAILABLE TOOLS:**

1. **Check for [MCP Server]**: Test if `mcp__[server]__*` tools are available
2. **Check for local alternatives**: `Bash("which [tool]")`
3. **Adjust strategy** based on available tools
```

#### Parallel Execution Pattern

```markdown
## Phase 1: Parallel Scanning

**START PARALLEL SCANNING AGENTS:**

1. **Scanner 1**: Task(description="...", prompt="...", subagent_type="general-purpose")
2. **Scanner 2**: Task(description="...", prompt="...", subagent_type="general-purpose")
3. **Scanner 3**: Task(description="...", prompt="...", subagent_type="general-purpose")
```

#### Sub-Agent Delegation Pattern

```markdown
## Phase 2: Expert Analysis

Delegate to @specialist-agent:
"READ-ONLY ANALYSIS. DO NOT MODIFY ANY FILES.
Analyze: [specific areas]
Focus on: [key concerns]
Provide: [expected outputs]"
```

## Parameter Handling

### The $ARGUMENTS Variable

The `$ARGUMENTS` placeholder receives all user input after the command invocation:

```bash
/command some input --flag --option=value
         └────────────────────────────┘
                   $ARGUMENTS
```

### Parameter Parsing Patterns

#### 1. Simple Arguments

```markdown
Scan the directory specified in $ARGUMENTS for security issues.
If no directory is provided, use the current directory (.).
```

#### 2. Flag Detection

```markdown
Check if $ARGUMENTS contains:

- `--no-verify`: Skip verification steps
- `--fast`: Use quick mode
- `--push`: Push after completion
```

#### 3. Option Extraction

```markdown
Extract options from $ARGUMENTS:

- `--focus=<value>`: Extract focus area (security|performance|all)
- `--export-dir=<path>`: Extract custom export directory
- `--severity=<level>`: Extract severity filter
```

#### 4. Multiple File Handling

```markdown
Process all files/directories provided in $ARGUMENTS:

- If single path: analyze that path
- If multiple paths: process each separately
- If glob pattern: expand and process matches
```

### Validation Patterns

````markdown
## Parameter Validation

1. **Validate directory exists**:
   ```bash
   if [ ! -d "$DIRECTORY" ]; then
     echo "Error: Directory not found"
     exit 1
   fi
   ```
````

2. **Validate option values**:
   - Ensure --focus is one of: security, performance, architecture, all
   - Verify --duration matches pattern: 1w, 2w, 1m
   - Check --team-size is a positive integer

````

## Output Specifications

Commands should produce structured, actionable output following these patterns:

### 1. Structured Reports

```markdown
# Analysis Report

## Executive Summary
- **Duration**: X seconds
- **Tool Used**: [Enhanced|Traditional]
- **Issues Found**: X critical, Y high, Z medium
- **Health Score**: X/100

## Critical Findings

### 🔒 Security Issues
1. **SQL Injection** (Critical)
   - File: `src/db/query.js:45`
   - Risk: Remote code execution
   - Fix: Use parameterized queries

### ⚡ Performance Bottlenecks
[Performance findings...]

## Recommendations

### Immediate Actions (0-24h)
1. Fix critical security vulnerabilities
2. Apply emergency patches

### Short-term (1 week)
1. Improve test coverage
2. Refactor complex functions
````

### 2. Progress Indicators

```markdown
## Progress

Analyzing security patterns... ████████░░ 80%
Scanning dependencies... ██████████ 100%
Generating report... ████░░░░░░ 40%

Overall Progress: ████████░░ 75%
```

### 3. JSON Output Format

````markdown
When --export-json is specified, structure data as:

```json
{
  "metadata": {
    "timestamp": "2024-01-15T10:30:00Z",
    "command": "analyze-deep",
    "version": "2.3.0",
    "duration_seconds": 15.3
  },
  "summary": {
    "health_score": 75,
    "total_issues": 42,
    "critical": 3,
    "high": 12
  },
  "findings": [
    {
      "id": "SEC-001",
      "type": "security",
      "severity": "critical",
      "title": "SQL Injection Vulnerability",
      "file": "src/db/user.js",
      "line": 45,
      "description": "...",
      "remediation": "..."
    }
  ]
}
```
````

````

### 4. Export Handling

```markdown
## Report Export

After analysis, if export parameters are provided:

1. **Parse Export Parameters**:
   - Detect requested format(s)
   - Generate timestamp-based filename if not specified
   - Create export directory if needed

2. **Write Report Files**:
   ```bash
   # Create reports directory
   mkdir -p reports/

   # Write report with timestamp
   FILENAME="analyze-deep-$(date +%Y%m%d-%H%M%S).md"
   Write("reports/$FILENAME", reportContent)
````

3. **Success Message**:

   ```
   ✓ Report exported to: reports/analyze-deep-20240115-103000.md
   ```

````

## Integration with Claude Code

### 1. Command Discovery

Claude Code discovers commands through the filesystem structure:

```bash
~/.claude/
├── commands/
│   └── prefix/
│       ├── category/
│       │   └── command.md
│       └── another-category/
│           └── command.md
└── agents/
    └── agent-name.md
````

### 2. Command Invocation

Users invoke commands using the pattern:

```
/prefix:category:command [arguments]
```

Claude Code:

1. Parses the command path
2. Loads the corresponding `.md` file
3. Extracts frontmatter metadata
4. Executes the command body as instructions
5. Passes user arguments via `$ARGUMENTS`

### 3. Tool Access

Commands can only use tools specified in `allowed-tools`:

```yaml
allowed-tools: Task, Read, Grep, Bash(git:*), Write
```

This enables:

- `Task()` for parallel execution
- `Read()` for file access
- `Grep()` for searching
- `Bash("git ...")` for git commands
- `Write()` for file creation (use sparingly)

### 4. Sub-Agent Integration

Commands can delegate to specialized sub-agents:

```markdown
Delegate to @security-specialist:
"Perform deep security analysis on the following findings..."
```

Sub-agents:

- Run in isolated contexts
- Have specialized knowledge
- Return structured results
- Don't have file write access by default

### 5. MCP Integration

When MCP tools are available, commands can leverage enhanced functionality:

```markdown
**Check for MCP availability:**

1. Test if `mcp__semgrep__security_check` is available
2. If yes: Use enhanced AST-based analysis
3. If no: Fall back to pattern-based scanning
```

## Best Practices

### 1. Command Design

- **Single Responsibility**: Each command should do one thing well
- **Clear Purpose**: The command name and description should immediately convey its function
- **Predictable Behavior**: Similar commands should work similarly
- **Graceful Degradation**: Commands should work without optional tools

### 2. Error Handling

```markdown
## Error Handling

The command handles these scenarios:

- Missing required arguments
- Invalid option values
- Tool unavailability
- File access errors
- Network failures

For each error:

1. Provide clear error message
2. Suggest corrective action
3. Exit gracefully
```

### 3. Performance Considerations

```markdown
## Performance Expectations

- Phase 1: 5-8 seconds (parallel scanning)
- Phase 2: 10-20 seconds (expert analysis)
- Phase 3: 2-3 seconds (report generation)
- Total: ~30 seconds for comprehensive analysis

For large codebases:

- Use incremental analysis
- Implement progress indicators
- Consider sampling strategies
```

### 4. Security Guidelines

- **Read-Only by Default**: Avoid file modifications unless explicitly requested
- **Validate Inputs**: Check all parameters before use
- **Safe Defaults**: Choose secure options by default
- **Clear Warnings**: Alert users before destructive operations

### 5. Documentation Standards

Every command should include:

- Clear usage examples
- Complete parameter documentation
- Expected output format
- Performance expectations
- Error scenarios
- Integration notes

### 6. Testing Patterns

```markdown
## Testing Your Command

1. **Basic Invocation**:
   /your-command
2. **With Parameters**:
   /your-command src/ --option=value
3. **Edge Cases**:
   - Empty directory
   - Missing tools
   - Invalid parameters
   - Large datasets
```

## Examples

### Example 1: Simple Analysis Command

````yaml
---
description: Find and analyze TODO comments in code
argument-hint: [directory] [--format=list|grouped|json]
---

# Find TODOs Command

Searches for TODO, FIXME, and HACK comments in your codebase.

## Usage

```bash
/find-todos              # Search current directory
/find-todos src/         # Search specific directory
/find-todos --format=json # Output as JSON
````

## Workflow

1. **Search for patterns**:
   Use Grep to find: TODO, FIXME, HACK, NOTE, XXX
2. **Analyze context**:
   - Extract surrounding code
   - Identify author (if in git)
   - Calculate age
3. **Generate report**:
   Group by file, priority, or author based on --format

````

### Example 2: MCP-Enhanced Command

```yaml
---
allowed-tools: Task, Read, Grep, Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check
description: Security audit with enhanced scanning when available
argument-hint: [directory] [--severity=critical|high|all]
---

# Security Audit

Comprehensive security analysis with automatic tool detection.

## Tool Detection

**CHECK AVAILABLE TOOLS:**
1. Test for `mcp__semgrep__security_check`
2. Check for local semgrep: `Bash("which semgrep")`
3. Select best available method

## Execution

### With MCP (Preferred):
Use `mcp__semgrep__security_check` for:
- AST-based analysis
- Low false positives
- Comprehensive coverage

### Fallback Method:
Use pattern matching for:
- Basic security patterns
- Common vulnerabilities
- Known antipatterns

## Output

**Analysis Quality**: [Enhanced|Standard|Basic]
**Confidence Level**: [High|Medium|Low]

[Security findings...]
````

### Example 3: Workflow Command

```yaml
---
allowed-tools: Task, Read, Write, TodoWrite, Bash(git:*)
description: Orchestrate a complete code quality sprint
argument-hint: [--duration=1w|2w] [--team-size=N]
---

# Quality Sprint Workflow

Plans and tracks a code quality improvement sprint.

## Sprint Phases

### Phase 1: Planning
1. Run comprehensive analysis
2. Generate prioritized backlog
3. Assign tasks to team

### Phase 2: Execution
1. Track daily progress
2. Run quality gates
3. Update metrics

### Phase 3: Review
1. Generate sprint report
2. Calculate velocity
3. Plan next sprint

## Progress Tracking

Use TodoWrite to maintain sprint tasks:
- Mark tasks as in_progress when starting
- Update to completed when done
- Add new tasks as discovered
```

## Conclusion

The Claude Code Toolkit command format provides a flexible, powerful way to extend Claude Code's capabilities. By following these specifications and patterns, you can create commands that are:

- **Discoverable**: Clear names and descriptions
- **Predictable**: Consistent behavior and output
- **Powerful**: Leverage parallel execution and specialized agents
- **Reliable**: Graceful error handling and fallbacks
- **Integrated**: Work seamlessly with Claude Code's tool ecosystem

For more examples and templates, see the `/commands/templates/` directory in the toolkit repository.
