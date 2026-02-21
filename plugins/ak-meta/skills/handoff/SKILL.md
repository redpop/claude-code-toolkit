---
name: handoff
description: This skill should be used when the user asks to "create a handoff", "document context for another AI", "prepare handoff document", or needs to transfer problem context to another AI assistant.
---

# Handoff

Document current problem context for handoff to another AI assistant.

**SAFETY**: This is a READ-ONLY command. NEVER modify code — only create the handoff document.

## Arguments

Parse arguments: `$ARGUMENTS`

- **filename**: First `.md` argument (default: "handoff.md")
- `--compact`, `-c`: Generate compact handoff (max 10 sentences)
- `--technical`, `-t`: Force technical details in compact mode
- `--focus <topic>`: Emphasize specific area
- `--skip <topic>`: Exclude specific topics
- Remaining text: additional instructions

## Execution

1. **Analyze conversation history** (Read only)
2. **Identify current unresolved problem** (ignore resolved issues)
3. **Extract key information**: problem statement, tech context, attempted solutions, blockers, code snippets
4. **Write handoff document** using Write tool

## Output Format (Standard)

```markdown
# AI Handoff Document

## Executive Summary
**Problem**: [description]
**Status**: [current state]
**Next Steps**: [immediate actions]

## Problem Context
[Original requirement, success criteria]

## Technical Environment
[Languages, frameworks, key files, constraints]

## Progress So Far
[Attempted solutions with outcomes]

## Current Blockers
[Specific errors, what prevents progress]

## Relevant Code & Files
[Key paths, code snippets, error messages]

## Suggested Next Steps
[Approaches to try, areas to investigate]
```

## Compact Mode (--compact)

Maximum 10 sentences total:

```markdown
# Compact Handoff

## Requirement (2 sentences)
## Current State (2 sentences)
## Main Blocker (2 sentences)
## Failed Attempts (1 sentence each, max 3)
## Solution Paths (2 sentences)
## Technical Context (with --technical only)
```
