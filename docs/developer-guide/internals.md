# Internals Guide

This document explains the internal workings of the Claude Code Toolkit for developers who want to understand, debug, or modify the core system.

## 🎯 System Overview

The toolkit operates as a command interpreter layer on top of Claude Code, transforming user commands into orchestrated AI agent executions.

```
User Input → Command Parser → Orchestration Engine → Agent Execution → Result Synthesis → Output
```

## 🔍 Command Resolution

### Path Resolution

```
/prefix:category:command arguments --options
         ↓
~/.claude/commands/prefix/category/command.md
```

### Resolution Process

```javascript
function resolveCommand(input) {
  const [prefix, category, command] = input.split(":");
  const path = `~/.claude/commands/${prefix}/${category}/${command}.md`;

  if (exists(path)) {
    return loadCommand(path);
  }

  // Fallback to aliases
  return resolveAlias(input);
}
```

### Command Loading

```javascript
function loadCommand(path) {
  const content = readFile(path);
  const { frontmatter, body } = parseFrontmatter(content);

  return {
    metadata: frontmatter,
    instructions: body,
    tools: parseTools(frontmatter.allowedTools),
    args: parseArguments(),
  };
}
```

## 🎭 Agent Orchestration

### Task Tool Integration

The Task Tool enables parallel execution:

```javascript
// Conceptual implementation
async function executeTaskAgents(agents) {
  const promises = agents.map((agent) =>
    TaskTool.run({
      description: agent.description,
      prompt: agent.prompt,
      subagent_type: "general-purpose",
      timeout: config.timeout,
      tokenBudget: config.tokenBudget,
    })
  );

  return Promise.all(promises);
}
```

### Sub-Agent Loading

```javascript
function loadSubAgent(name) {
  const path = `~/.claude/agents/${name}.md`;
  const content = readFile(path);

  return {
    name: name,
    expertise: parseExpertise(content),
    approach: parseApproach(content),
    outputFormat: parseOutputFormat(content),
  };
}
```

### Execution Strategies

#### Parallel Execution

```javascript
// Used in Phase 1 scanning
async function parallelScan(scanners) {
  const results = await Promise.all(
    scanners.map((scanner) => executeWithTimeout(scanner, config.timeout))
  );

  return mergeResults(results);
}
```

#### Sequential Execution

```javascript
// Used for dependent operations
async function sequentialExecute(tasks) {
  const results = [];

  for (const task of tasks) {
    const result = await execute(task);
    results.push(result);

    // Pass result to next task
    if (task.passResult) {
      tasks[index + 1].context = result;
    }
  }

  return results;
}
```

#### Hybrid Execution

```javascript
// Combines parallel and sequential
async function hybridExecute(phases) {
  const scanResults = await parallelScan(phases.scan);
  const analysis = await delegateToExperts(scanResults);
  const synthesis = await synthesize(scanResults, analysis);

  return synthesis;
}
```

## 📊 Data Flow

### Input Processing Pipeline

```
Raw Input
    ↓
Argument Parser
    ↓
Variable Substitution ($ARGUMENTS)
    ↓
Context Injection
    ↓
Agent Instructions
```

### Result Aggregation Pipeline

```
Individual Agent Results
    ↓
Format Normalization
    ↓
Deduplication
    ↓
Priority Scoring
    ↓
Categorization
    ↓
Synthesis
    ↓
Export Formatting
```

### Context Preservation

```javascript
class ContextManager {
  constructor() {
    this.results = new Map();
    this.timestamps = new Map();
  }

  saveResult(command, result) {
    const filename = `${command}-${timestamp()}.json`;
    writeFile(filename, result);
    this.results.set(command, filename);
    return filename;
  }

  getLastResult(command) {
    return this.results.get(command);
  }

  chainContext(previousResult) {
    return {
      previous: previousResult,
      timestamp: new Date(),
      chain_id: generateId(),
    };
  }
}
```

## 🔧 Configuration System

### Configuration Loading Hierarchy

```javascript
function loadConfiguration() {
  // 1. System defaults
  let config = loadSystemDefaults();

  // 2. Global configuration
  const globalConfig = loadFile("~/.claude-commands.json");
  config = merge(config, globalConfig);

  // 3. Project configuration
  const projectConfig = loadFile("./.claude-commands.json");
  config = merge(config, projectConfig);

  // 4. Environment variables
  config = mergeEnvironment(config);

  // 5. Runtime arguments
  config = mergeRuntimeArgs(config);

  return config;
}
```

### Performance Mode Implementation

```javascript
const PERFORMANCE_MODES = {
  conservative: {
    maxConcurrentAgents: 5,
    tokenBudgetPerAgent: 2000,
    timeout: 20000,
    retryPolicy: "conservative",
  },
  balanced: {
    maxConcurrentAgents: 10,
    tokenBudgetPerAgent: 3000,
    timeout: 30000,
    retryPolicy: "standard",
  },
  aggressive: {
    maxConcurrentAgents: 20,
    tokenBudgetPerAgent: 4000,
    timeout: 45000,
    retryPolicy: "aggressive",
  },
};

function applyPerformanceMode(mode) {
  return PERFORMANCE_MODES[mode] || PERFORMANCE_MODES.balanced;
}
```

## 🧠 Token Management

### Token Budget Distribution

```javascript
class TokenBudgetManager {
  constructor(totalBudget, agentCount) {
    this.totalBudget = totalBudget;
    this.agentCount = agentCount;
    this.used = 0;
  }

  allocate(strategy = "equal") {
    switch (strategy) {
      case "equal":
        return this.totalBudget / this.agentCount;

      case "weighted":
        return this.weightedAllocation();

      case "dynamic":
        return this.dynamicAllocation();
    }
  }

  weightedAllocation() {
    // Complex agents get more tokens
    const weights = this.calculateWeights();
    return weights.map((w) => this.totalBudget * w);
  }
}
```

### Token Usage Tracking

```javascript
class TokenTracker {
  track(agentName, tokens) {
    this.usage[agentName] = (this.usage[agentName] || 0) + tokens;
    this.total += tokens;

    if (this.total > this.limit) {
      throw new TokenLimitExceeded();
    }
  }

  getReport() {
    return {
      total: this.total,
      limit: this.limit,
      byAgent: this.usage,
      efficiency: this.calculateEfficiency(),
    };
  }
}
```

## 🔄 Result Synthesis

### Deduplication Algorithm

```javascript
function deduplicateFindings(results) {
  const seen = new Map();

  return results.filter((finding) => {
    const key = generateFindingKey(finding);
    if (seen.has(key)) {
      // Merge with existing
      const existing = seen.get(key);
      existing.occurrences++;
      existing.agents.push(finding.agent);
      return false;
    }

    seen.set(key, finding);
    return true;
  });
}

function generateFindingKey(finding) {
  return `${finding.file}:${finding.line}:${finding.type}`;
}
```

### Priority Scoring

```javascript
function calculatePriority(finding) {
  const impactScore = calculateImpact(finding);
  const effortScore = calculateEffort(finding);
  const riskScore = calculateRisk(finding);

  // ROI-based scoring
  const roi = (impactScore * 10) / effortScore;

  // Weighted priority
  return {
    roi: roi,
    priority: roi * 0.5 + riskScore * 0.3 + impactScore * 0.2,
    breakdown: { impact, effort, risk },
  };
}
```

### Report Generation

```javascript
class ReportGenerator {
  generate(results, format = "markdown") {
    const synthesized = this.synthesize(results);

    switch (format) {
      case "markdown":
        return this.generateMarkdown(synthesized);
      case "json":
        return this.generateJSON(synthesized);
      case "html":
        return this.generateHTML(synthesized);
    }
  }

  synthesize(results) {
    return {
      summary: this.generateSummary(results),
      critical: this.filterCritical(results),
      quickWins: this.identifyQuickWins(results),
      trends: this.analyzeTrends(results),
      recommendations: this.generateRecommendations(results),
    };
  }
}
```

## 🐛 Debugging System

### Debug Logging

```javascript
class DebugLogger {
  constructor(enabled = false) {
    this.enabled = enabled || process.env.CLAUDE_DEBUG;
    this.logFile = "~/.claude/logs/debug.log";
  }

  log(level, message, data) {
    if (!this.enabled) return;

    const entry = {
      timestamp: new Date().toISOString(),
      level,
      message,
      data,
      stack: new Error().stack,
    };

    this.writeLog(entry);
  }

  performance(operation, duration) {
    this.log("PERF", `${operation} took ${duration}ms`);
  }
}
```

### Error Handling

```javascript
class ErrorHandler {
  handle(error, context) {
    // Log error
    logger.error(error, context);

    // Determine severity
    const severity = this.classifyError(error);

    // Handle based on severity
    switch (severity) {
      case "critical":
        return this.handleCritical(error);
      case "recoverable":
        return this.attemptRecovery(error, context);
      case "warning":
        return this.logWarning(error);
    }
  }

  attemptRecovery(error, context) {
    if (error.type === "TIMEOUT") {
      return this.retryWithLongerTimeout(context);
    }

    if (error.type === "TOKEN_LIMIT") {
      return this.retryWithFewerAgents(context);
    }
  }
}
```

## 📈 Performance Monitoring

### Metrics Collection

```javascript
class MetricsCollector {
  constructor() {
    this.metrics = {
      commands: new Map(),
      agents: new Map(),
      operations: [],
    };
  }

  recordCommand(command, duration, result) {
    const stats = this.metrics.commands.get(command) || {
      count: 0,
      totalDuration: 0,
      failures: 0,
    };

    stats.count++;
    stats.totalDuration += duration;
    if (!result.success) stats.failures++;

    this.metrics.commands.set(command, stats);
  }

  getPerformanceReport() {
    return {
      averageExecutionTime: this.calculateAverage(),
      slowestCommands: this.getSlowest(),
      failureRate: this.getFailureRate(),
      tokenEfficiency: this.getTokenEfficiency(),
    };
  }
}
```

### Memory Management

```javascript
class MemoryManager {
  constructor(limit = 500 * 1024 * 1024) {
    // 500MB
    this.limit = limit;
    this.checkInterval = 5000;
    this.startMonitoring();
  }

  startMonitoring() {
    setInterval(() => {
      const usage = process.memoryUsage();

      if (usage.heapUsed > this.limit) {
        this.handleMemoryPressure();
      }
    }, this.checkInterval);
  }

  handleMemoryPressure() {
    // Clear caches
    CacheManager.clear();

    // Reduce concurrent operations
    config.maxConcurrentAgents = Math.floor(config.maxConcurrentAgents / 2);

    // Force garbage collection if available
    if (global.gc) global.gc();
  }
}
```

## 🔐 Security Considerations

### Tool Permission System

```javascript
class ToolPermissionManager {
  constructor(allowedTools) {
    this.allowed = new Set(allowedTools);
  }

  validate(requestedTool) {
    // Check exact match
    if (this.allowed.has(requestedTool)) return true;

    // Check wildcards
    for (const pattern of this.allowed) {
      if (this.matchesPattern(requestedTool, pattern)) {
        return true;
      }
    }

    throw new UnauthorizedToolError(requestedTool);
  }

  matchesPattern(tool, pattern) {
    // e.g., "Bash(fd:*)" matches "Bash(fd:find)"
    const regex = pattern.replace("*", ".*");
    return new RegExp(`^${regex}$`).test(tool);
  }
}
```

### Sandboxing

```javascript
class Sandbox {
  constructor(restrictions) {
    this.restrictions = restrictions;
  }

  execute(operation) {
    // Validate operation
    this.validate(operation);

    // Apply restrictions
    const sandboxed = this.applySandbox(operation);

    // Execute with monitoring
    return this.monitoredExecute(sandboxed);
  }

  applySandbox(operation) {
    return {
      ...operation,
      filesystem: this.restrictFilesystem(operation),
      network: this.restrictNetwork(operation),
      timeout: this.enforceTimeout(operation),
    };
  }
}
```

## 🏁 Summary

Understanding these internals helps you:

- Debug complex issues
- Optimize performance
- Extend functionality
- Contribute to core development

The system is designed to be:

- **Modular**: Easy to extend and modify
- **Performant**: Parallel execution where possible
- **Reliable**: Comprehensive error handling
- **Secure**: Controlled tool access and sandboxing
