---
description: Smart Git operations with project context and commit pattern learning
argument-hint: [operation] [--push] [--no-verify]
allowed-tools: Task, Bash(git:*), mcp__basic-memory__search_notes, mcp__basic-memory__write_note
---

# Git

Save changes intelligently: "Git workflow with project context."

## Execution

Parse arguments: `$ARGUMENTS`

Extract operation and options:

- If first argument matches git operations (commit, review, resolve), use as operation
- Default: operation="commit"
- Handle --push and --no-verify flags

Route to knowledge-enhanced Git workflow:

Use Task tool with subagent_type="git-workflow-specialist":
"Execute Git '$operation' with Knowledge-Enhanced context awareness:

1. **Context Retrieval**: Search Basic Memory for project-specific commit patterns and conventions
2. **Pattern Application**: Apply successful commit strategies and messaging patterns from project history
3. **Smart Analysis**: Analyze changes with understanding of project architecture and recent decisions  
4. **Professional Execution**: Create conventional commits with proper formatting and context
5. **Pattern Learning**: Capture successful Git workflows and commit patterns to Basic Memory

Focus: intelligent commit creation, change analysis, conflict resolution, or code review based on operation.

Export commit messages and workflow documentation."
