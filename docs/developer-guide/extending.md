# Extending Guide

Create new commands, agents, and workflows for the Claude Code Toolkit.

## Quick Start

```bash
# Create multi-agent command
./scripts/create-sub-agent-command.sh \
  --name "analyzer" \
  --agents 6 \
  --category scan

# Create agent from template
cp agents/security-specialist.md agents/my-specialist.md
```

## Creating Commands

### Command Structure

Every command is a Markdown file in `commands/{category}/{name}.md`:

```markdown
---
allowed-tools: Task, Read, Grep, Bash(cmd:*)
description: Brief description
argument-hint: <directory> [--options]
mcp-enhanced: mcp__tool1  # Optional
---

# Command Name

## Phase 1: Parallel Scanning
Use Task tool with subagent_type="general-purpose":
"Scan for X in $ARGUMENTS. Return JSON."

## Phase 2: Synthesis
[Process results and generate report]

## Next Steps
1. `/prefix:fix:issues report.json`
2. `/prefix:scan:deep --verify`
```

### Command Categories

| Category | Purpose | Example Commands |
|----------|---------|------------------|
| `scan` | Analysis & investigation | `deep`, `quick`, `report` |
| `fix` | Direct corrections | `security`, `quick-wins` |
| `gen` | Code generation | `tests`, `docs` |
| `flow` | Multi-agent workflows | `smart`, `continuous` |
| `auto` | Automation | `execute`, `monitor` |
| `sec` | Security operations | `audit`, `compliance` |
| `meta` | Toolkit management | `chain`, `pipelines` |

### Best Practices

1. **Clear phases** - Scan → Analyze → Report
2. **Structured output** - JSON for machines, Markdown for humans
3. **Export capability** - Support `--export-json` and `--export-md`
4. **Next steps** - Always suggest follow-up commands

## Creating Agents

### Agent Structure

Agents are Markdown files in `agents/{name}.md`:

```markdown
---
name: domain-specialist
description: Expert in specific domain
mcp-enhanced: mcp__context7  # Optional
---

You are an expert in [domain].

## Core Expertise
- Area 1: Specific knowledge
- Area 2: Deep understanding

## Analysis Approach
1. Identify patterns
2. Analyze issues
3. Suggest improvements

## Output Format
Return JSON with:
- findings: array of issues
- severity: critical|high|medium|low
- recommendations: actionable fixes
```

### Agent Types

| Type | Focus | Example |
|------|-------|---------|
| **Analysis** | Pattern detection | `pattern-analyzer` |
| **Fix** | Remediation | `security-fixer` |
| **Generation** | Code creation | `test-generator` |
| **Review** | Quality assessment | `code-reviewer` |

### Agent Guidelines

- **Single responsibility** - One domain per agent
- **Clear output** - Specify exact format
- **Actionable results** - Specific recommendations

## Creating Workflows

### Simple Chain

```bash
/prefix:meta:chain \
  "scan:deep ." -> \
  "fix:quick-wins {output}" -> \
  "scan:deep . --verify"
```

### Complex Flow

Create `commands/flow/my-workflow.md`:

```markdown
---
allowed-tools: Task, Read, Write
description: Complete workflow
---

# My Workflow

## Step 1: Analyze
[Analysis logic]

## Step 2: Fix Critical
[Fix high-priority items]

## Step 3: Verify
[Ensure fixes work]
```

## Templates

| Template | Location | Use Case |
|----------|----------|----------|
| Basic command | `templates/commands/basic-sub-agent.md` | Simple analysis |
| Multi-agent | `templates/commands/orchestration-template.md` | Complex workflows |
| Agent | `templates/agents/specialist-template.md` | Domain expert |

## Testing Extensions

```bash
# Install locally
./install.sh test --force

# Test command
/test:category:command ./test-project

# Verify output
cat command-*.json | jq .

# Run tests
./tests/commands/test-my-command.sh
```

## Integration Points

### Command Discovery
```
commands/{category}/{name}.md
→ /prefix:category:name
```

### Configuration Override
```json
{
  "commandOverrides": {
    "category:name": {
      "performanceMode": "aggressive",
      "tokenBudget": 5000
    }
  }
}
```

### MCP Enhancement
```yaml
mcp-enhanced: mcp__tool1, mcp__tool2
```

## Extension Checklist

- [ ] Clear, descriptive name
- [ ] Proper frontmatter
- [ ] Structured output format
- [ ] Export support
- [ ] Next steps guidance
- [ ] Test coverage
- [ ] Documentation updated
- [ ] Added to README

## Contributing

1. Fork repository
2. Create feature branch
3. Add extension with tests
4. Update documentation
5. Submit pull request

## Ideas for Extensions

### Commands
- Database analyzer
- API scanner
- Localization checker
- Accessibility auditor

### Agents
- DevOps specialist
- Mobile expert
- Cloud architect
- i18n expert

### Workflows
- Full-stack analysis
- Microservice health
- Migration assistant

## Related Documentation

- [Architecture](architecture.md) - System design
- [Configuration](configuration.md) - Settings
- [Testing](testing.md) - Test requirements