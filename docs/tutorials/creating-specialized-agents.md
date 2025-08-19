# Creating Specialized Agents Tutorial

Learn to build specialized AI agents for Claude Code Toolkit.

## Agent Architecture

### Required Components

```yaml
---
name: agent-identifier # REQUIRED
description: Brief description # REQUIRED
type: specialist|analyzer|helper # Optional
---
# Agent content
```

**Critical**: `name` field is mandatory for agent registration.

### Agent Types

| Type | Purpose | Example |
|------|---------|----------|
| **Specialist** | Domain expert | security-specialist |
| **Analyzer** | Data processor | report-analyzer |
| **Helper** | Task assistant | test-helper |

## Quick Agent Creation

### Using the Creation Script

```bash
# Create agent with script
./scripts/create-agent.sh <name> <type> "<description>"

# Examples
./scripts/create-agent.sh database-optimizer specialist "Database optimization"
./scripts/create-agent.sh code-reviewer analyzer "Code review analysis"
```

### Manual Creation

```bash
# Copy template
cp templates/agent-template.md agents/my-agent.md
# Edit with required fields
```

See [Agent Creation Workflow Guide](../guides/AGENT-CREATION-WORKFLOW.md) for detailed instructions.

## Example: Database Performance Specialist

Create `/agents/database-performance-specialist.md`:

```markdown
---
name: database-performance-specialist
description: Database optimization expert for query performance and indexing
type: specialist
---

# Database Performance Specialist

**READ-ONLY AGENT**: Analyzes but never modifies files.

You are a database performance expert specializing in:
- Query optimization and N+1 detection
- Index strategy and design
- Connection pooling and caching

## Analysis Approach

1. **Baseline**: Identify slow queries (>100ms)
2. **Deep Dive**: Examine patterns, missing indexes
3. **Optimize**: Prioritize by impact (queries/sec × time)

## Output Format

```markdown
# Database Performance Analysis

**Score**: X/10
**Critical Issues**: [count]
**Estimated Gain**: X%

## Slow Queries
1. [Pattern] - File:Line - Xms - [Fix]

## Missing Indexes
```sql
CREATE INDEX idx_name ON table(columns);
```

## Priorities

- Immediate: Add indexes, adjust pool
- Short-term: Implement caching
- Long-term: Architecture changes

```

## Example: Code Complexity Analyzer

```markdown
---
name: code-complexity-analyzer
type: analyzer
description: Analyzes complexity metrics and identifies refactoring priorities
---

# Code Complexity Analyzer

Analyzes cyclomatic/cognitive complexity and maintainability.

## Metrics

| Metric | Good | Moderate | High |
|--------|------|----------|------|
| Cyclomatic | <10 | 10-20 | >20 |
| Cognitive | <15 | 15-40 | >40 |
| Maintainability | >85 | 65-85 | <65 |

## Output

```markdown
**Health**: X/100
**Avg CC**: 8.3
**Hotspots**: 5 files
**Tech Debt**: ~120h

## Hotspots
1. processUserData() - CC:47 - 4h effort
2. validateToken() - CC:35 - 2h effort

## Priorities
| File | Function | CC | Target | Effort |
|------|----------|-----|--------|--------|
| auth.ts | validateToken | 35 | 10 | 2h |
| api.ts | handleRequest | 28 | 12 | 3h |
```

```

## Integration with Commands

Use agents in orchestration commands:

```markdown
# In your command file:

Use Task tool with subagent_type="database-performance-specialist":
"Analyze database performance in $ARGUMENTS"

# For multiple agents:
Phase 1: Run parallel scanners
Phase 2: Delegate to specialists
Phase 3: Synthesize results
```

See [Sub-Agent Orchestration Guide](../architecture/SUB-AGENT-ORCHESTRATION.md) for patterns.

## Testing Agents

### Quick Test

```bash
# Test agent loading
head -20 agents/your-agent.md
grep "^name:" agents/your-agent.md

# Run claude doctor
claude doctor

# Test with command
/prefix:test:your-agent .
```

### Common Issues

| Issue | Solution |
|-------|----------|
| Agent not loading | Check frontmatter syntax |
| Missing name field | Add `name: agent-name` |
| Not found by commands | Verify name matches exactly |

## MCP Enhancement

```yaml
---
name: enhanced-agent
mcp-enhanced: mcp__semgrep__security_check
---

# Check tool availability
if tool_available:
    use_enhanced_analysis()
else:
    use_fallback_patterns()
```

## Best Practices

### Design Principles

- **Single Responsibility**: One expertise domain
- **Consistent Output**: Standardized format
- **Progressive Enhancement**: Fallbacks for missing tools

### Quality Checklist

- [ ] Name field present
- [ ] Clear expertise defined
- [ ] Output format specified
- [ ] Error handling included
- [ ] Tested with claude doctor

### Anti-Patterns

- ❌ Trying to do everything
- ❌ No explanation of methods
- ❌ Failing without specific tools

## Summary

1. Use creation script or template
2. Include required `name` and `description` fields
3. Test with `claude doctor`
4. Integrate with commands using Task tool
5. Add MCP tools for enhancement

## Resources

- [Agent Creation Workflow](../guides/AGENT-CREATION-WORKFLOW.md)
- [Sub-Agent Orchestration](../architecture/SUB-AGENT-ORCHESTRATION.md)
- [Agent Template](../../templates/agent-template.md)
- [Example Agents](../../agents/)
