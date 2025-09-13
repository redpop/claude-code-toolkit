---
allowed-tools: Task, mcp__basic-memory__search_notes, mcp__basic-memory__write_note
description: Workflow automation with 6-command architecture and intelligent next-steps
argument-hint: [workflow-name | command-chain] [--list] [--help] [--dry-run]
examples:
  - description: Run intelligent analysis workflow
    command: /prefix:meta:chain analyze
  - description: Complete improvement workflow
    command: /prefix:meta:chain improve-cycle
  - description: Security hardening workflow
    command: /prefix:meta:chain security
  - description: Simple command chain
    command: /prefix:meta:chain "understand ." -> "improve {insights}"
  - description: Custom workflow with git integration
    command: /prefix:meta:chain "secure . --audit" -> "ship . --check" -> "git commit"
see-also:
  - understand: Deep codebase analysis and insights
  - improve: Code improvements and fixes
  - create: Generate documentation and tests
  - secure: Security analysis and hardening
  - ship: Deployment readiness checks
  - git: Smart Git operations
---

# Chain

Workflow automation: "Run analysis then improvements, then commit."

## Execution

Parse arguments: `$ARGUMENTS`

Extract workflow, options, and chain syntax:

- If first argument matches workflow names (analyze, improve-cycle, security, deploy), use as workflow
- If argument contains `->`, parse as command chain
- Default: workflow="analyze"
- Handle --list, --help, and --dry-run flags

Route to knowledge-enhanced workflow automation:

Use Task tool with subagent_type="workflow-optimizer":
"Execute workflow automation for '$ARGUMENTS' using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when Basic Memory MCP available):**

1. **Workflow Intelligence**: Search Basic Memory for successful workflow patterns and automation strategies
2. **Smart Sequencing**: Apply learned command sequences and timing patterns from project history
3. **Context-Aware Execution**: Use workflow context and previous automation decisions for optimization
4. **Pattern Learning**: Capture successful automation patterns and workflow outcomes to Basic Memory

**Standard Workflow (always available - no MCP required):**

1. **Expert Workflows**: Apply established workflow patterns and automation best practices
2. **Intelligent Sequencing**: Use workflow optimization expertise for efficient command execution
3. **Professional Automation**: Execute workflows using proven development and deployment patterns
4. **Standard Execution**: Run workflows with established timing and error handling

**Universal Capabilities (always included):**

- Pre-defined intelligent workflows for common development tasks
- Command chaining with automatic output passing and data flow
- Error handling and recovery strategies for workflow reliability
- Integration with all 6 core commands (understand, improve, create, secure, ship, git)

Focus: workflow automation, intelligent sequencing, command chaining, or pre-defined workflows based on arguments.

Export results with enhanced workflow intelligence when possible, professional automation guaranteed.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Capture successful workflow patterns and automation strategies for development efficiency enhancement
- Generate intelligent recommendations for workflow optimizations and automation improvements  
- Cross-reference workflow outcomes with similar successful automation patterns and timing strategies
- Track automation effectiveness and evolve workflow strategies based on development team learning"

## Quick Start

### Pre-defined Workflows

Simple one-command workflows for common tasks:

```bash
# Complete analysis and improvement cycle
/prefix:meta:chain analyze          # understand -> improve -> create docs

# Security hardening workflow  
/prefix:meta:chain security         # secure -> improve -> git commit

# Deployment readiness check
/prefix:meta:chain deploy           # secure -> ship -> git tag

# Full improvement cycle
/prefix:meta:chain improve-cycle    # understand -> improve -> create -> ship
```

### Custom Command Chains

Create specific workflows with automatic data flow:

```bash
# Simple analysis to improvement
/prefix:meta:chain "understand ." -> "improve {insights}"

# Security to deployment
/prefix:meta:chain "secure . --audit" -> "ship . --check" -> "git commit"

# Full documentation workflow
/prefix:meta:chain "understand . --docs" -> "create docs {analysis}" -> "git commit"
```

## Workflow Intelligence

The chain command learns from successful patterns and suggests optimal workflows:

### Intelligent Detection

The command automatically detects what you need:

1. **Workflow name** → Runs pre-defined intelligent workflow
2. **Chain syntax** (contains `->`) → Creates custom command sequence  
3. **Context analysis** → Suggests best workflow based on project state

### Pre-defined Intelligent Workflows

#### 🔍 analyze

**Purpose**: Complete codebase analysis and insights

```bash
/prefix:meta:chain analyze
# Executes: understand . -> create docs {insights}
```

#### 🔧 improve-cycle  

**Purpose**: Full improvement workflow with validation

```bash
/prefix:meta:chain improve-cycle
# Executes: understand . -> improve {analysis} -> create tests -> ship . --check
```

#### 🛡️ security

**Purpose**: Security hardening with automated fixes

```bash
/prefix:meta:chain security  
# Executes: secure . --audit -> improve {findings} -> git commit
```

#### 🚀 deploy

**Purpose**: Deployment readiness validation

```bash  
/prefix:meta:chain deploy
# Executes: secure . -> ship . --readiness -> git tag
```

## Custom Chaining Syntax

Simple chaining with the 6 core commands:

### Sequential Execution

Commands execute in order, passing insights forward:

```bash
/prefix:meta:chain "understand . --focus=performance" -> "improve {insights}"
```

### Complete Workflows

Multi-step workflows for comprehensive results:

```bash
/prefix:meta:chain "understand ." -> "secure {analysis}" -> "ship . --check" -> "git commit"
```

## Data Flow

### Automatic Output Passing

Commands automatically pass insights to the next command:

- `{insights}` - Previous command's analysis and insights
- `{analysis}` - Detailed analysis results  
- `{findings}` - Security or quality findings
- `{output}` - General command output

### Example Data Flow

```bash
# Analysis insights flow to improvement suggestions
/prefix:meta:chain "understand . --focus=security" -> "improve {insights}"

# Security findings inform deployment checks  
/prefix:meta:chain "secure . --audit" -> "ship . --security-check {findings}"
```

## Common Patterns

### Analysis → Improvement → Verification

```bash
/prefix:meta:chain "understand ." -> "improve {analysis}" -> "ship . --check"
```

### Security → Fix → Commit

```bash
/prefix:meta:chain "secure . --audit" -> "improve {findings}" -> "git commit"
```

### Documentation Workflow

```bash
/prefix:meta:chain "understand . --docs" -> "create docs {insights}" -> "git commit"
```

## Best Practices

1. **Start Simple**: Use pre-defined workflows for common tasks
2. **Chain Logically**: Follow natural development flow (understand → improve → verify)
3. **Use Context**: Let commands pass relevant insights to the next step
4. **Test First**: Use `--dry-run` to preview complex workflows

## Integration Examples

### CI/CD Pipeline

```yaml
# GitHub Actions
- name: Quality Gate
  run: /prefix:meta:chain security

- name: Deployment Check
  run: /prefix:meta:chain deploy
```

### Git Hooks

```bash
# pre-commit
/prefix:meta:chain "secure . --quick" -> "improve {findings}"

# pre-push  
/prefix:meta:chain "understand . --quick" -> "ship . --check"
```

### Development Workflow

```bash
# Daily development workflow
/prefix:meta:chain analyze

# Before pull request
/prefix:meta:chain improve-cycle

# Weekly maintenance
/prefix:meta:chain "understand . --health" -> "improve {insights}" -> "git commit"
```
