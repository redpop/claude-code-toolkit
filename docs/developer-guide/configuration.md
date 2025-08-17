# Configuration Guide

Configure the Claude Code Toolkit for different use cases and environments.

## Configuration Hierarchy

1. **System Defaults** → Built-in baseline
2. **Global Config** → Repository settings
3. **Project Config** → `.claude-commands.json` in project root
4. **Command Overrides** → Per-command settings
5. **Runtime** → CLI arguments and environment variables

Each level overrides the previous.

## Performance Modes

| Mode | Max Agents | Token Budget | Timeout | Use Case |
|------|------------|--------------|---------|----------|
| **Conservative** | 5 | 2000 | 20s | Limited resources, production |
| **Balanced** | 10 | 3000 | 30s | Standard development (default) |
| **Aggressive** | 20 | 4000 | 45s | Large codebases, powerful machines |

### Setting Performance Mode

```bash
# Environment variable
export CLAUDE_PERFORMANCE_MODE=aggressive

# Configuration file
{
  "performanceMode": "aggressive"
}

# Command override
{
  "commandOverrides": {
    "scan:deep": {
      "performanceMode": "aggressive"
    }
  }
}
```

## Configuration Reference

### Minimal Configuration
```json
{
  "performanceMode": "balanced"
}
```

### Standard Configuration
```json
{
  "version": "3.0.0",
  "performanceMode": "balanced",
  "subAgentOrchestration": {
    "enabled": true,
    "defaults": {
      "tokenBudget": 3000,
      "timeout": 30000,
      "parallelExecution": true
    }
  }
}
```

### Advanced Configuration
```json
{
  "subAgentOrchestration": {
    "performanceMode": "aggressive",
    "defaults": {
      "tokenBudget": 4000,
      "timeout": 45000,
      "maxRetries": 2
    },
    "synthesis": {
      "format": "markdown",
      "deduplication": true,
      "prioritization": "severity"
    },
    "errorHandling": {
      "continueOnAgentFailure": true,
      "minimumSuccessfulAgents": 0.7,
      "fallbackStrategy": "sequential"
    },
    "commandOverrides": {
      "scan:deep": {
        "tokenBudget": 5000
      },
      "sec:audit": {
        "performanceMode": "conservative"
      }
    }
  }
}
```

## Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `CLAUDE_PERFORMANCE_MODE` | Override performance mode | `aggressive` |
| `CLAUDE_TOKEN_BUDGET` | Set token budget | `5000` |
| `CLAUDE_DEBUG` | Enable debug mode | `true` |
| `CLAUDE_LOG_LEVEL` | Set log verbosity | `debug` |
| `CLAUDE_TIMEOUT` | Override timeout (ms) | `60000` |

## Project Configuration

Create `.claude-commands.json` in your project root:

```json
{
  "project": {
    "name": "my-project",
    "type": "react-app",
    "preferences": {
      "performanceMode": "conservative",
      "focusAreas": ["security", "performance"]
    }
  },
  "commandDefaults": {
    "scan:deep": {
      "focus": "security,performance"
    }
  }
}
```

## Common Configurations

### Security-Focused
```json
{
  "performanceMode": "conservative",
  "synthesis": {
    "prioritization": "cvss-score"
  },
  "commandDefaults": {
    "*": {
      "focus": "security"
    }
  }
}
```

### CI/CD Pipeline
```json
{
  "cicdMode": {
    "enabled": true,
    "outputFormat": "json",
    "failOnCritical": true,
    "performanceMode": "balanced",
    "timeout": 300000
  }
}
```

### Large Codebase
```json
{
  "performanceMode": "aggressive",
  "largeCodbaseOptimizations": {
    "incrementalScanning": true,
    "fileChunking": {
      "enabled": true,
      "chunkSize": "1MB"
    }
  }
}
```

## Error Handling Strategies

| Strategy | Description | Use Case |
|----------|-------------|----------|
| `sequential` | Run agents one by one | Fallback for parallel failures |
| `reduce` | Use fewer agents | Token limit issues |
| `abort` | Stop execution | Critical errors |
| `ignore` | Continue without failed | Non-critical agents |

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Token limit exceeded | Reduce `tokenBudget` or use `conservative` mode |
| Timeout errors | Increase timeout or simplify tasks |
| Memory issues | Disable caching, use `conservative` mode |
| Command not found | Check installation path matches prefix |

## Best Practices

1. **Start with defaults** - Don't over-configure
2. **Use project config** - Keep repo config minimal
3. **Document changes** - Add `_comment` fields
4. **Test changes** - Use `--dry-run` first
5. **Version control** - Commit configuration files

## Related Documentation

- [Architecture](architecture.md) - Performance characteristics
- [Extending](extending.md) - Command-specific configuration
- [Internals](internals.md) - Configuration loading details