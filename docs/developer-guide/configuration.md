# Configuration Guide

This guide explains how to configure the Claude Code Toolkit for different use cases, performance requirements, and environments.

## 📋 Configuration Overview

The toolkit uses a hierarchical configuration system:

1. **System Defaults** → Built-in baseline settings
2. **Global Configuration** → `.claude-commands.json` in repo root
3. **Project Configuration** → `.claude-commands.json` in project root
4. **Command Overrides** → Specific command settings
5. **Runtime Parameters** → CLI arguments

Each level overrides the previous, allowing fine-grained control.

## 🔧 The .claude-commands.json File

### Complete Configuration Reference

```json
{
  "repo_owner": "username",
  "repo_name": "claude-code-toolkit",
  "default_branch": "main",
  "description": "Toolkit description",
  "version": "3.3.0",

  "subAgentOrchestration": {
    "enabled": true,
    "version": "2.0.0",
    "description": "Sub-Agent Orchestration System",

    "defaults": {
      "tokenBudget": 3000,
      "timeout": 30000,
      "retryOnFailure": true,
      "maxRetries": 2,
      "parallelExecution": true
    },

    "performanceMode": "balanced",
    "performanceModes": {
      "conservative": {
        "maxConcurrentAgents": 5,
        "tokenBudgetPerAgent": 2000,
        "timeout": 20000
      },
      "balanced": {
        "maxConcurrentAgents": 10,
        "tokenBudgetPerAgent": 3000,
        "timeout": 30000
      },
      "aggressive": {
        "maxConcurrentAgents": 20,
        "tokenBudgetPerAgent": 4000,
        "timeout": 45000
      }
    },

    "synthesis": {
      "format": "markdown",
      "deduplication": true,
      "prioritization": "severity",
      "includeMetrics": true,
      "generateActionItems": true
    },

    "outputFormats": {
      "default": "markdown",
      "available": ["markdown", "json", "csv", "mermaid"],
      "includeTimestamps": true,
      "includeAgentMetadata": false
    },

    "errorHandling": {
      "continueOnAgentFailure": true,
      "minimumSuccessfulAgents": 0.7,
      "fallbackStrategy": "sequential",
      "logErrors": true
    },

    "caching": {
      "enabled": false,
      "ttl": 3600,
      "cacheLocation": "~/.claude/cache/sub-agents"
    },

    "commandOverrides": {
      "scan:deep": {
        "performanceMode": "aggressive",
        "defaults": {
          "tokenBudget": 4000
        }
      }
    }
  },

  "hybridMode": {
    "enabled": true,
    "description": "Hybrid architecture settings",

    "agentRegistry": {
      "security-specialist": {
        "type": "sub-agent",
        "location": "agents/security-specialist.md",
        "autoInvoke": ["security", "vulnerability", "CVE"],
        "priority": "high"
      }
    },

    "delegationStrategy": {
      "automatic": true,
      "thresholdScore": 0.7,
      "maxDelegations": 3,
      "parallelDelegation": true
    }
  }
}
```

## 🎯 Configuration Sections

### Repository Metadata

```json
{
  "repo_owner": "username",
  "repo_name": "claude-code-toolkit",
  "default_branch": "main",
  "version": "3.3.0"
}
```

**Purpose**: Identifies the toolkit and version for compatibility checking.

### Performance Modes

Configure how aggressively the toolkit uses resources:

#### Conservative Mode

```json
{
  "performanceMode": "conservative"
}
```

- **Use Case**: Limited resources, production environments
- **Agents**: Maximum 5 concurrent
- **Tokens**: 2000 per agent
- **Timeout**: 20 seconds

#### Balanced Mode (Default)

```json
{
  "performanceMode": "balanced"
}
```

- **Use Case**: Standard development
- **Agents**: Maximum 10 concurrent
- **Tokens**: 3000 per agent
- **Timeout**: 30 seconds

#### Aggressive Mode

```json
{
  "performanceMode": "aggressive"
}
```

- **Use Case**: Large codebases, powerful machines
- **Agents**: Maximum 20 concurrent
- **Tokens**: 4000 per agent
- **Timeout**: 45 seconds

### Token Budget Management

Control token usage to prevent exceeding limits:

```json
{
  "defaults": {
    "tokenBudget": 3000,
    "tokenDistribution": "equal",
    "reserveTokens": 500
  }
}
```

**Strategies**:

- `equal`: Divide tokens equally among agents
- `weighted`: More tokens for complex agents
- `dynamic`: Adjust based on agent feedback

### Output Configuration

Control how results are formatted and exported:

```json
{
  "outputFormats": {
    "default": "markdown",
    "available": ["markdown", "json", "csv", "html"],
    "includeTimestamps": true,
    "includeAgentMetadata": false,
    "compression": "none"
  }
}
```

### Error Handling

Define behavior when things go wrong:

```json
{
  "errorHandling": {
    "continueOnAgentFailure": true,
    "minimumSuccessfulAgents": 0.7,
    "fallbackStrategy": "sequential",
    "retryPolicy": {
      "maxRetries": 2,
      "backoffMultiplier": 2,
      "initialDelay": 1000
    }
  }
}
```

**Fallback Strategies**:

- `sequential`: Run agents one by one
- `reduce`: Use fewer agents
- `abort`: Stop execution
- `ignore`: Continue without failed agents

## 📝 Command-Specific Overrides

Override settings for specific commands:

```json
{
  "commandOverrides": {
    "scan:deep": {
      "performanceMode": "aggressive",
      "synthesis": {
        "format": "json"
      }
    },
    "sec:audit": {
      "performanceMode": "conservative",
      "defaults": {
        "tokenBudget": 5000
      },
      "errorHandling": {
        "continueOnAgentFailure": false
      }
    }
  }
}
```

## 🌍 Environment Variables

Override configuration via environment:

```bash
# Performance mode
export CLAUDE_PERFORMANCE_MODE=aggressive

# Token budget
export CLAUDE_TOKEN_BUDGET=5000

# Debug mode
export CLAUDE_DEBUG=true
export CLAUDE_LOG_LEVEL=debug

# Cache settings
export CLAUDE_CACHE_ENABLED=true
export CLAUDE_CACHE_DIR=~/.my-cache

# Timeout
export CLAUDE_TIMEOUT=60000
```

## 🏢 Project-Level Configuration

Create `.claude-commands.json` in your project root:

```json
{
  "project": {
    "name": "my-project",
    "type": "react-app",
    "preferences": {
      "performanceMode": "conservative",
      "focusAreas": ["security", "performance"],
      "ignorePatterns": ["node_modules", "build", "*.test.js"]
    }
  },

  "commandDefaults": {
    "scan:deep": {
      "focus": "security,performance"
    },
    "fix:quick-wins": {
      "autoApprove": false
    }
  }
}
```

## 🔐 Security Configuration

### Restricted Mode

For sensitive environments:

```json
{
  "security": {
    "restrictedMode": true,
    "allowedTools": ["Read", "Grep"],
    "deniedTools": ["Write", "Bash"],
    "sandboxEnabled": true,
    "auditLogging": true
  }
}
```

### Audit Configuration

Track all operations:

```json
{
  "audit": {
    "enabled": true,
    "logLocation": "~/.claude/audit/",
    "logFormat": "json",
    "includeResults": false,
    "retention": "30d"
  }
}
```

## 📊 Performance Tuning

### For Large Codebases

```json
{
  "largeCodbaseOptimizations": {
    "enableIndexing": true,
    "indexLocation": "~/.claude/index/",
    "incrementalScanning": true,
    "fileChunking": {
      "enabled": true,
      "chunkSize": "1MB"
    }
  }
}
```

### For CI/CD Environments

```json
{
  "cicdMode": {
    "enabled": true,
    "outputFormat": "json",
    "failOnCritical": true,
    "performanceMode": "balanced",
    "timeout": 300000,
    "retryOnNetworkError": true
  }
}
```

## 🧪 Development Configuration

### Debug Settings

```json
{
  "development": {
    "debugMode": true,
    "verboseLogging": true,
    "performanceMetrics": true,
    "mockMode": false,
    "breakOnError": true
  }
}
```

### Testing Configuration

```json
{
  "testing": {
    "testMode": true,
    "mockAgents": false,
    "deterministicMode": true,
    "seedValue": 12345,
    "captureSnapshots": true
  }
}
```

## 💾 Caching Configuration

### Basic Cache Settings

```json
{
  "caching": {
    "enabled": true,
    "strategy": "lru",
    "maxSize": "500MB",
    "ttl": 3600,
    "location": "~/.claude/cache/"
  }
}
```

### Advanced Cache Control

```json
{
  "caching": {
    "rules": [
      {
        "pattern": "scan:*",
        "ttl": 1800,
        "condition": "unchanged-files"
      },
      {
        "pattern": "sec:audit",
        "ttl": 300,
        "condition": "always"
      }
    ]
  }
}
```

## 🔄 Migration from Older Versions

### From v2.x to v3.x

```json
{
  "migration": {
    "compatibilityMode": true,
    "warnOnDeprecated": true,
    "autoMigrate": {
      "enabled": true,
      "backupLocation": "~/.claude/backup/"
    }
  }
}
```

## 📋 Configuration Best Practices

### 1. Start with Defaults

Don't over-configure. The defaults work well for most cases.

### 2. Use Project Configuration

Keep repository configuration minimal, use project-specific settings.

### 3. Document Changes

```json
{
  "_comment": "Increased token budget for complex codebase",
  "tokenBudget": 5000
}
```

### 4. Version Control

- Commit `.claude-commands.json` to repository
- Use `.gitignore` for project-specific configs
- Document configuration changes in CHANGELOG

### 5. Test Configuration Changes

```bash
# Validate configuration
/global:meta:validate-config

# Test with dry-run
/global:scan:deep . --dry-run
```

## 🚨 Common Configuration Issues

### Token Limit Exceeded

```json
{
  "defaults": {
    "tokenBudget": 2000
  }
}
```

### Timeout Errors

```json
{
  "defaults": {
    "timeout": 60000
  }
}
```

### Memory Issues

```json
{
  "performanceMode": "conservative",
  "caching": {
    "enabled": false
  }
}
```

## 📚 Configuration Examples

### Security-Focused Setup

```json
{
  "performanceMode": "conservative",
  "commandDefaults": {
    "*": {
      "focus": "security"
    }
  },
  "synthesis": {
    "prioritization": "cvss-score"
  }
}
```

### Speed-Optimized Setup

```json
{
  "performanceMode": "aggressive",
  "caching": {
    "enabled": true,
    "strategy": "aggressive"
  },
  "parallelExecution": true
}
```

### Minimal Setup

```json
{
  "performanceMode": "balanced"
}
```

That's it! The rest uses smart defaults.
