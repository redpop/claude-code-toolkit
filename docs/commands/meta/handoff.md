# /prefix:meta:handoff

Documents current problem context for handoff to another AI assistant.

## Purpose

Analyzes the current chat history to extract and document the latest unresolved problem, providing comprehensive context for another AI assistant to continue the work.

## Syntax

```bash
/prefix:meta:handoff [output-file] [-c|--compact|--brief] [-t|--technical] [--focus topic] [--skip topic] [--include topic] ["instructions"]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `output-file` | `handoff.md` | Output filename (must end with .md) |

## Options

| Option | Description |
|--------|-------------|
| `-c`, `--compact`, `--brief` | Generate compact handoff (max 10 sentences total) |
| `-t`, `--technical` | Force technical details even in compact mode |
| `--focus <topic>` | Focus on specific area (can be used multiple times) |
| `--skip <topic>` | Exclude specific topics (can be used multiple times) |
| `--include <topic>` | Explicitly include topics (can be used multiple times) |
| `"instructions"` | Additional free-form instructions |

## Examples

### Basic Usage

```bash
# Standard handoff
/prefix:meta:handoff

# Custom filename
/prefix:meta:handoff problem-context.md

# Compact mode
/prefix:meta:handoff --compact
/prefix:meta:handoff brief.md --compact
```

### Advanced Usage

```bash
# With focus flags
/prefix:meta:handoff --focus "database errors"
/prefix:meta:handoff --skip "UI issues"
/prefix:meta:handoff --include "error logs"

# Combinations
/prefix:meta:handoff debug.md --compact --technical
/prefix:meta:handoff --compact --focus "blockers" "emphasize workarounds"
/prefix:meta:handoff migration.md -c --skip "resolved" --include "SQL errors"
```

## What This Command Does

1. **Analyzes Chat History**: Reviews the entire conversation to understand context
2. **Identifies Current Problem**: Focuses on the most recent unresolved issue
3. **Extracts Key Information**: Problem statement, technical context, attempted solutions, current blockers
4. **Creates Structured Documentation**: Generates markdown file with all context needed for another AI

## Output Format

The generated documentation includes:

- **Executive Summary**: Brief problem description, current status, immediate next steps
- **Problem Context**: Original requirement/goal, importance, success criteria
- **Technical Environment**: Programming languages/frameworks, file structure, dependencies
- **Progress So Far**: What has been attempted, what worked/didn't work
- **Current Blockers**: Specific errors or issues preventing progress
- **Relevant Code & Files**: Key file paths, important code snippets, error messages
- **Suggested Next Steps**: Potential approaches to try, areas to investigate

## Safety Notice

⚠️ **This is a READ-ONLY analysis command that**:

- **NEVER modifies any code or files** (except creating the handoff document)
- **ONLY analyzes and summarizes** the current conversation
- **ONLY creates ONE output file** with the handoff documentation

## See Also

- Documentation best practices for AI handoffs
- Problem-solving methodologies for development issues
