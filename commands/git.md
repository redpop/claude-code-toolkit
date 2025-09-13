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
"Execute Git '$operation' with Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when Basic Memory MCP available):**

1. **Context Retrieval**: Search Basic Memory for project-specific commit patterns and conventions
2. **Pattern Application**: Apply successful commit strategies and messaging patterns from project history
3. **Smart Analysis**: Analyze changes with understanding of project architecture and recent decisions
4. **Pattern Learning**: Capture successful Git workflows and commit patterns to Basic Memory

**Standard Workflow (always available - no MCP required):**

1. **Convention Analysis**: Apply standard commit conventions and established messaging patterns
2. **Expert Workflow**: Use Git specialist expertise for professional commit creation and analysis
3. **Change Analysis**: Analyze changes with comprehensive understanding of codebase context
4. **Standard Execution**: Create conventional commits with proper formatting and best practices

**Universal Capabilities (always included):**

- Professional commit message generation with proper formatting
- Comprehensive change analysis and impact assessment
- Conflict resolution strategies and merge guidance
- Code review workflows and quality validation

Focus: intelligent commit creation, change analysis, conflict resolution, or code review based on operation.

Export results with enhanced project context when possible, professional Git workflows guaranteed.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Capture successful Git workflow patterns and commit strategies for version control knowledge enhancement
- Generate intelligent recommendations for workflow optimizations and team collaboration improvements
- Cross-reference Git operations with similar successful projects and workflow outcomes
- Track commit quality and workflow effectiveness to evolve Git practices based on team learning"
