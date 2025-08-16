# Agent Creation Workflow Guide

This guide explains the standardized workflow for creating new agents in the Claude Code Toolkit, ensuring all agents are properly formatted and compatible with Claude Code.

## Table of Contents

1. [Overview](#overview)
2. [Quick Start](#quick-start)
3. [Using the Creation Script](#using-the-creation-script)
4. [Template Structure](#template-structure)
5. [Required Fields](#required-fields)
6. [Best Practices](#best-practices)
7. [Testing Your Agent](#testing-your-agent)
8. [Troubleshooting](#troubleshooting)

## Overview

The Claude Code Toolkit uses a standardized workflow for creating agents to ensure:

- All required fields are present (especially the `name` field)
- Consistent structure across all agents
- No parsing errors when Claude Code loads agents
- Proper integration with commands and orchestration

## Quick Start

### Method 1: Using the Creation Script (Recommended)

```bash
# Basic usage
./scripts/create-agent.sh <agent-name> <type> "<description>"

# Examples
./scripts/create-agent.sh database-optimizer specialist "Database performance optimization expert"
./scripts/create-agent.sh code-reviewer analyzer "Automated code review and quality analysis"
./scripts/create-agent.sh api-tester helper "API testing and validation assistant"
```

### Method 2: Using the Meta Create Command

```bash
# Let the AI determine the best approach
/prefix:meta:create "Database optimization expert"

# Force agent creation
/prefix:meta:create "React performance specialist" --type=agent
```

### Method 3: Manual Creation from Template

```bash
# Copy the template
cp templates/agent-template.md agents/my-new-agent.md

# Edit the file and replace all placeholders
```

## Using the Creation Script

The `scripts/create-agent.sh` script automates agent creation with validation:

### Script Parameters

- **agent-name**: Unique identifier (lowercase, hyphenated)

  - Valid: `database-optimizer`, `api-tester`, `security-scanner`
  - Invalid: `Database_Optimizer`, `API Tester`, `security scanner`

- **type**: Agent classification

  - `specialist`: Domain experts with deep knowledge
  - `analyzer`: Data and report processors
  - `helper`: Task-specific assistants
  - `research`: Investigation specialists

- **description**: Brief description of the agent's purpose

### Script Features

1. **Validation**: Ensures proper naming conventions
2. **Duplicate Check**: Warns if agent already exists
3. **Template Application**: Uses standardized template
4. **Expertise Detection**: Auto-determines domain based on name
5. **Platform Compatibility**: Works on macOS and Linux

## Template Structure

The agent template (`templates/agent-template.md`) includes:

```yaml
---
name: [AGENT_NAME] # REQUIRED - Unique identifier
description: [AGENT_DESCRIPTION] # REQUIRED - Agent's purpose
type: [specialist|analyzer|helper|research] # Optional - Classification
expertise: [PRIMARY_DOMAIN] # Optional - Domain specialization
version: 1.0.0 # Optional - Semantic version
capabilities: # Optional - Specific capabilities
  - [CAPABILITY_1]
tools: # Optional - Available tools
  - Read
  - Grep
  - Task
mcp-enhanced: [MCP_TOOLS] # Optional - MCP enhancements
---
[Agent content...]
```

## Required Fields

### Mandatory Fields

1. **name** (string, required)

   - Unique identifier for the agent
   - Must be lowercase and hyphenated
   - Used by Claude Code for agent registration
   - Example: `security-specialist`

2. **description** (string, required)
   - Brief description of agent's purpose
   - Should be clear and concise
   - Example: `Deep security analysis expert specializing in vulnerability detection`

### Why `name` is Critical

Without the `name` field, Claude Code will fail to load the agent with this error:

```
Failed to parse agent file: Missing required "name" field in frontmatter
```

This was discovered when `claude doctor` showed multiple agents failing to load due to missing `name` fields.

## Best Practices

### 1. Naming Conventions

```yaml
# Good names
name: database-optimizer
name: security-specialist
name: react-performance-analyzer

# Bad names
name: DatabaseOptimizer      # No camelCase
name: database_optimizer     # No underscores
name: DB-Opt                # Too abbreviated
```

### 2. Clear Expertise Definition

```yaml
expertise: Database Performance Optimization # Specific
# Not: expertise: Databases                   # Too generic
```

### 3. Comprehensive Capabilities

```yaml
capabilities:
  - Query optimization and analysis # Specific action
  - Index strategy development # Clear outcome
  - Connection pooling optimization # Technical detail
  # Not: - Database stuff                    # Too vague
```

### 4. Tool Selection

Only include tools the agent actually needs:

```yaml
tools:
  - Read # For reading files
  - Grep # For searching code
  - Task # For delegating to other agents
  # Don't include: Write, Edit (agents are read-only by default)
```

### 5. MCP Enhancement

If your agent benefits from specific MCP tools:

```yaml
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
```

## Testing Your Agent

### 1. Verify File Structure

```bash
# Check if agent loads correctly
head -20 agents/your-agent.md

# Verify required fields are present
grep "^name:" agents/your-agent.md
grep "^description:" agents/your-agent.md
```

### 2. Test with Claude Doctor

```bash
# Run claude doctor to verify all agents load
claude doctor

# Look for your agent in the output
# Should show under "Agent Configurations"
```

### 3. Create Test Command

Create a simple command to test your agent:

```markdown
---
description: Test command for new agent
---

# Test Agent Command

Use Task tool with subagent_type="your-agent-name":
"Analyze the current directory and provide insights."
```

### 4. Integration Test

```bash
# Run your test command
/prefix:test:your-agent .

# Verify the agent executes and provides expected output
```

## Troubleshooting

### Common Issues and Solutions

#### Issue: Agent Not Loading

**Symptom**: Agent doesn't appear in `claude doctor` output

**Solution**: Check frontmatter format

```bash
# Ensure proper YAML syntax
head -10 agents/your-agent.md

# Common issues:
# - Missing --- delimiters
# - Incorrect indentation
# - Missing colon after field names
```

#### Issue: "Missing required name field"

**Symptom**: Error in `claude doctor` output

**Solution**: Add the name field

```yaml
---
name: your-agent-name # Add this line
description: Your description
---
```

#### Issue: Agent Not Found by Commands

**Symptom**: Commands can't find your agent

**Solution**: Ensure name matches exactly

```markdown
# In your command:

subagent_type="database-optimizer" # Must match agent's name field exactly
```

#### Issue: Duplicate Agent Warning

**Symptom**: Script warns about existing agent

**Solution**: Choose a different name or confirm overwrite

```bash
# Check existing agents
ls agents/*.md | grep similar-name

# Use a more specific name
./scripts/create-agent.sh specific-database-optimizer specialist "..."
```

## Advanced Topics

### Custom Expertise Detection

Modify `scripts/create-agent.sh` to add custom expertise detection:

```bash
# In determine_expertise() function
case "$name" in
    *your-keyword*)
        echo "Your Custom Domain"
        ;;
```

### Batch Agent Creation

Create multiple related agents:

```bash
#!/bin/bash
# create-agent-suite.sh

agents=(
    "api-validator:analyzer:Validates API contracts and responses"
    "api-documenter:helper:Generates API documentation"
    "api-tester:specialist:Comprehensive API testing expert"
)

for agent in "${agents[@]}"; do
    IFS=':' read -r name type desc <<< "$agent"
    ./scripts/create-agent.sh "$name" "$type" "$desc"
done
```

### Agent Versioning

Track agent evolution:

```yaml
---
name: security-specialist
version: 1.2.0 # Semantic versioning
# 1.0.0 - Initial release
# 1.1.0 - Added OWASP Top 10 analysis
# 1.2.0 - Enhanced with MCP tools
---
```

## Integration with Commands

### Using Agents in Commands

```markdown
# In your command file

Use Task tool with subagent_type="your-agent-name":
"Your detailed prompt for the agent"
```

### Orchestrating Multiple Agents

```markdown
# Phase 1: Parallel Analysis

Run these agents simultaneously:

1. Task(subagent_type="agent-1", prompt="...")
2. Task(subagent_type="agent-2", prompt="...")
3. Task(subagent_type="agent-3", prompt="...")

# Phase 2: Synthesis

Combine results from all agents...
```

## Maintenance

### Regular Reviews

1. **Quarterly Agent Audit**

   - Check for unused agents
   - Update capabilities based on feedback
   - Ensure consistency with latest practices

2. **Template Updates**

   - Keep template current with Claude Code requirements
   - Add new optional fields as needed
   - Update examples and placeholders

3. **Documentation Sync**
   - Update this guide when workflow changes
   - Keep examples current
   - Add new troubleshooting scenarios

## Conclusion

Following this standardized workflow ensures:

- ✅ All agents load correctly in Claude Code
- ✅ Consistent quality across all agents
- ✅ Easy maintenance and updates
- ✅ Smooth integration with commands
- ✅ No parsing errors or missing fields

For questions or improvements to this workflow, please contribute to the repository or open an issue.
