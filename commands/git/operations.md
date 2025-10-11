---
description: Smart Git operations with project context and commit pattern learning
argument-hint: [operation] [--push] [--no-verify] [--smart] [--pattern-learn] [--interactive] [--dry-run] [--help]
allowed-tools: Task, Bash(git:*), mcp____search_notes, mcp____write_note
---

# Git

Save changes intelligently: "Git workflow with project context."

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Smart Git operations with project context and commit pattern learning
- **Usage**: [operation] [--push] [--no-verify] [--smart] [--pattern-learn]
- **Operations**: commit, review, resolve, smart-commit, conflict-resolver
- **Options**:
- `--push`: Push changes to remote repository after committing
- `--no-verify`: Skip pre-commit hooks and verification steps
- `--smart`: Use intelligent commit message generation
- `--pattern-learn`: Learn from project commit patterns for better messages
- `--interactive`: Interactive mode for complex Git operations
- `--dry-run`: Show proposed Git operations without executing them

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract operation and options:

- If first argument matches git operations (commit, review, resolve), use as operation
- Default: operation="commit"
- Handle --push and --no-verify flags

Route to knowledge-enhanced Git workflow:

Use Task tool with subagent_type="git-workflow-specialist":
"Execute Git '$operation' with Knowledge-Enhanced approach with graceful fallback.

**IMPORTANT**: NEVER include Claude Code signature or Co-Authored-By lines in commit messages. This command creates commits without automation signatures.

**Enhanced Workflow (when MCP services available):**

1. **Context Retrieval**: Search for project-specific commit patterns and conventions
2. **Pattern Application**: Apply successful commit strategies and messaging patterns from project history
3. **Smart Analysis**: Analyze changes with understanding of project architecture and recent decisions
4. **Pattern Learning**: Capture successful Git workflows and commit patterns

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
