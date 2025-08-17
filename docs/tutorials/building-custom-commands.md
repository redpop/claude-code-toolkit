# Building Custom Commands Tutorial

Create powerful commands for Claude Code Toolkit.

## Command Structure

### Required Components

```markdown
---
allowed-tools: Task, Read, Grep, Bash, Write
description: Brief description
argument-hint: [args] [--options]
---
# Command content
```

### Naming Convention

```
commands/category/command.md → /prefix:category:command
```

## Template Selection

| Template | Use Case |
|----------|----------|
| `basic-sub-agent` | Simple parallel tasks |
| `mcp-aware-command` | Enhanced with MCP tools |
| `hybrid-sub-agent` | Multi-phase analysis |
| `specialist-agent` | Domain expertise |

## Example: Anti-Pattern Detection

Create `commands/analysis/anti-patterns.md`:

```markdown
---
allowed-tools: Task, Read, Grep
description: Detect common anti-patterns
argument-hint: [directory] [--language]
---

# Anti-Pattern Detection

## Parallel Scanners

1. **God Object**: Task(
   prompt="Find classes >20 methods or >500 lines"
   subagent_type="general-purpose"
)

2. **Spaghetti Code**: Task(
   prompt="Find >5 nesting levels"
   subagent_type="general-purpose"
)

3. **Magic Numbers**: Task(
   prompt="Find hardcoded values"
   subagent_type="general-purpose"
)

## Output

```markdown
# Report
**Anti-Patterns**: [count]
**Critical**: [count]

## By Severity
- Critical: [list]
- Warning: [list]
```

## Example: MCP-Enhanced Command

```markdown
---
allowed-tools: Task, Read, Grep, Bash
mcp-enhanced: mcp__semgrep__get_abstract_syntax_tree
description: Analyze documentation quality
---

# Doc Quality Check

## Tool Detection

```python
if mcp_tool_available:
    use_ast_analysis()
elif local_tool_available:
    use_tool_based()
else:
    use_pattern_based()
```

## Graceful Fallback

- AST analysis when available
- Tool-based as fallback
- Pattern matching as last resort
- Always report method used

## Output

```markdown
**Method**: {strategy}
**Score**: X/100

| Metric | Current | Target |
|--------|---------|--------|
| Documented | 75% | 90% |
```

## Example: Hybrid Command

```markdown
---
allowed-tools: Task, Read, Grep, Bash, Write
description: Multi-phase code review
---

# Code Review

## Phase 1: Parallel Scanning

- Style Scanner
- Security Scanner  
- Performance Scanner
- Test Scanner
- Architecture Scanner

All run in parallel using Task tool.

## Phase 2: Expert Delegation

Based on findings, delegate to:
- security-specialist (if high-severity issues)
- performance-optimizer (if bottlenecks)
- code-architect (if structural issues)
- test-engineer (if coverage < 70%)

## Phase 3: Synthesis

Combine findings into report:

```markdown
# Review Report

**Overall Score**: X/10

| Category | Score |
|----------|-------|
| Security | X/10 |
| Performance | X/10 |
| Tests | X/10 |

## Critical Issues
[List]

## Action Plan
- Immediate: [fixes]
- Short-term: [improvements]
```
```

## Testing Commands

### Quick Test

```bash
# Test installation
ls ~/.claude/commands/prefix/

# Run command
/prefix:category:command ./test
```

### Common Issues

| Issue | Solution |
|-------|----------|
| Command not found | Check frontmatter syntax |
| Tool not allowed | Add to allowed-tools |
| Tasks not parallel | Check Task syntax |
| JSON errors | Use json.dumps() |

## Best Practices

### Do's

- ✅ Specific prompts with structured output
- ✅ Error handling and fallbacks
- ✅ Progressive enhancement with MCP
- ✅ Parallel execution for speed
- ✅ Export only when requested

### Don'ts

- ❌ Vague prompts
- ❌ One agent doing everything
- ❌ Creating files without permission
- ❌ Sequential when parallel possible
- ❌ Missing edge case handling

## Publishing Commands

### Repository Structure

```
your-commands/
├── README.md
├── install.sh
├── commands/
│   └── category/
│       └── command.md
└── agents/
    └── specialist.md
```

### Installation Script

```bash
#!/bin/bash
PREFIX="${1:-yourprefix}"
cp -r commands/* ~/.claude/commands/$PREFIX/
echo "✅ Installed commands"
```

### Quality Checklist

- [ ] Frontmatter complete
- [ ] Usage examples included
- [ ] Error handling implemented
- [ ] Tested with claude doctor
- [ ] Documentation clear

## Summary

1. Use templates for quick start
2. Add required frontmatter fields
3. Test with real scenarios
4. Use parallel Task execution
5. Add MCP enhancement with fallbacks
6. Export only when requested

## Resources

- [Command Templates](../../templates/)
- [Command Examples](../../commands/)
- [Command API Reference](../api/command-api-reference.md)
- [Sub-Agent Orchestration](../architecture/SUB-AGENT-ORCHESTRATION.md)
