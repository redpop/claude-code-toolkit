# Internals Guide

How the Claude Code Toolkit works under the hood.

## System Flow

```
User Input → Command Resolution → Agent Orchestration → Result Synthesis → Output
```

## Command Resolution

### Path Mapping
```
/prefix:category:command arguments
         ↓
~/.claude/commands/prefix/category/command.md
```

### Loading Process
```javascript
function resolveCommand(input) {
  const [prefix, category, command] = input.split(":");
  const path = `~/.claude/commands/${prefix}/${category}/${command}.md`;
  
  if (exists(path)) {
    const { frontmatter, body } = parseFrontmatter(readFile(path));
    return {
      metadata: frontmatter,
      instructions: body,
      tools: parseTools(frontmatter.allowedTools),
      args: parseArguments()
    };
  }
  return resolveAlias(input);
}
```

## Agent Orchestration

### Execution Strategies

| Strategy | Implementation | Use Case |
|----------|---------------|----------|
| **Parallel** | `Promise.all(agents.map(execute))` | Phase 1 scanning |
| **Sequential** | `for await (agent of agents)` | Dependent operations |
| **Hybrid** | Parallel scan → Sequential analysis | Full workflows |

### Task Tool Pattern
```javascript
// Parallel execution with Task Tool
const results = await Promise.all(
  agents.map(agent => 
    TaskTool.execute({
      prompt: agent.prompt,
      subagent_type: "general-purpose",
      tokenBudget: config.tokenBudget,
      timeout: config.timeout
    })
  )
);
```

## Token Management

### Budget Distribution

```javascript
class TokenBudgetManager {
  allocate(strategy = "equal") {
    switch (strategy) {
      case "equal":
        return this.totalBudget / this.agentCount;
      case "weighted":
        // Complex agents get more tokens
        return this.calculateWeighted();
      case "dynamic":
        // Runtime adjustment based on feedback
        return this.adjustDynamic();
    }
  }
}
```

### Usage Tracking
- Track per-agent consumption
- Monitor total usage
- Throw `TokenLimitExceeded` when exceeded
- Generate efficiency reports

## Result Processing

### Synthesis Pipeline

1. **Aggregate** - Collect all agent results
2. **Normalize** - Convert to common format
3. **Deduplicate** - Remove redundant findings
4. **Prioritize** - Score by impact/effort
5. **Categorize** - Group by type/severity
6. **Export** - Format for output

### Deduplication Algorithm
```javascript
function deduplicate(findings) {
  const seen = new Map();
  return findings.filter(finding => {
    const key = `${finding.file}:${finding.line}:${finding.type}`;
    if (seen.has(key)) {
      seen.get(key).occurrences++;
      return false;
    }
    seen.set(key, finding);
    return true;
  });
}
```

### Priority Scoring
```javascript
function calculatePriority(finding) {
  const impact = calculateImpact(finding);
  const effort = calculateEffort(finding);
  const roi = (impact * 10) / effort;
  
  return {
    roi,
    priority: roi * 0.5 + finding.risk * 0.3 + impact * 0.2
  };
}
```

## Configuration Loading

### Hierarchy Resolution
```javascript
function loadConfiguration() {
  let config = loadSystemDefaults();
  config = merge(config, loadGlobal());
  config = merge(config, loadProject());
  config = mergeEnvironment(config);
  config = mergeRuntimeArgs(config);
  return config;
}
```

### Performance Mode Application
```javascript
const MODES = {
  conservative: { maxAgents: 5, tokenBudget: 2000 },
  balanced: { maxAgents: 10, tokenBudget: 3000 },
  aggressive: { maxAgents: 20, tokenBudget: 4000 }
};

function applyMode(mode) {
  return MODES[mode] || MODES.balanced;
}
```

## Error Handling

### Recovery Strategies

| Error Type | Recovery Method |
|------------|-----------------|
| `TIMEOUT` | Retry with longer timeout |
| `TOKEN_LIMIT` | Reduce agents or budget |
| `AGENT_FAILURE` | Continue with partial results |
| `PARSE_ERROR` | Fallback to text output |

### Error Handler Pattern
```javascript
try {
  const results = await executeAgents(tasks);
  return synthesize(results);
} catch (error) {
  if (error.recoverable) {
    return attemptRecovery(error);
  }
  throw error;
}
```

## Debugging

### Enable Debug Mode
```bash
export CLAUDE_DEBUG=true
export CLAUDE_LOG_LEVEL=debug
```

### Debug Output
- Command resolution steps
- Agent execution times
- Token usage per agent
- Error stack traces
- Performance metrics

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| Token exceeded | High agent count/budget | Reduce agents or use conservative |
| Timeout | Complex task | Increase timeout or simplify |
| Parsing failure | Invalid command syntax | Check frontmatter format |
| Agent failure | Missing dependencies | Verify agent definition |

## Performance Monitoring

### Metrics Collection
- Execution time per command
- Token usage efficiency
- Success/failure rates
- Agent performance distribution

### Optimization Points
- Cache frequently used results
- Pool agent connections
- Batch similar operations
- Progressive loading for large files

## Security Model

### Tool Permissions
```yaml
# Levels of access
allowed-tools: Read, Grep              # Read-only
allowed-tools: Read, Grep, Bash(git:*) # Git access
allowed-tools: Task, Read, Write, Edit # Full access
```

### Sandboxing
- Isolated execution contexts
- No persistent state
- Controlled file system access
- Network restrictions

## Memory Management

- Monitor heap usage
- Clear caches on pressure
- Reduce concurrent operations
- Force garbage collection when needed

## Related Documentation

- [Architecture](architecture.md) - High-level design
- [Configuration](configuration.md) - Settings details
- [Extending](extending.md) - Adding functionality