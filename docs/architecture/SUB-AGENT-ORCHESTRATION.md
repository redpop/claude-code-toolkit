# Sub-Agent Orchestration for Claude Code

## Overview

This system uses Claude Code's Task Tool for massive performance improvements through intelligent parallelization. By executing multiple specialized sub-agents simultaneously, complex analyses and tasks can be completed 5-10x faster than sequential processing.

### Core Benefits

- **5-10x performance improvement** for parallel tasks
- **Token-efficient analysis** through focused sub-agents
- **Scalable architecture** for complex codebases
- **Reusable commands** globally available
- **Best practices** from production use integrated

## Quick Start

### Installation

```bash
# Standard installation with "global" prefix
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/install.sh | bash -s -- global

# Custom prefix
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/install.sh | bash -s -- myprefix
```

### Getting Started

```bash
# Ultra-fast code analysis (10 parallel agents)
/global:orchestration:analyze-parallel src/

# Security audit (8 specialized agents)
/global:orchestration:security-audit

# Test coverage analysis (5 agents)
/global:orchestration:test-coverage
```

### Performance Comparison

| Task           | Sequential | Parallel | Speedup |
| -------------- | ---------- | -------- | ------- |
| Code Analysis  | 50-60s     | 5-8s     | ~10x    |
| Security Audit | 40-50s     | 5-7s     | ~8x     |
| Test Coverage  | 30-40s     | 4-6s     | ~7x     |
| Dependency Map | 45-55s     | 6-8s     | ~7x     |

## Architecture

### Task Tool as Orchestrator

The Task Tool is Claude Code's primary mechanism for sub-agent management:

```yaml
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(jq:*)
```

### Token Budget Management

Optimal token distribution for maximum efficiency:

- **Per Agent**: 2000-4000 tokens
- **Total Budget**: ~30000 tokens for 10 agents
- **Context Sharing**: Minimal, focused context per agent
- **Output Format**: Structured for easy synthesis

### Synthesis Strategies

After all sub-agents complete, results are intelligently merged:

1. **Structured Outputs** - JSON/Markdown for machine processing
2. **Deduplication** - Avoiding redundant information
3. **Prioritization** - Most important findings first
4. **Cross-Reference** - Connections between agent results

## Command Reference

### Orchestration Commands

#### `/global:orchestration:analyze-parallel`

Ultra-fast code analysis with 10 specialized agents:

- Code Complexity Analysis
- Duplicate Code Detection
- Style Violations
- Documentation Coverage
- Dead Code Detection
- Type Safety Analysis
- Security Patterns
- Performance Profiling
- Test Quality
- Dependency Analysis

#### `/global:orchestration:security-audit`

Comprehensive security scan with 8 agents:

- SQL Injection Detection
- XSS Vulnerability Scan
- Authentication Weaknesses
- Secret/Credential Exposure
- CORS Configuration
- Dependency CVEs
- CSRF Protection
- Information Disclosure

#### `/global:orchestration:refactor-impact`

Impact analysis for refactoring with 6 agents:

- Breaking Changes Detection
- API Contract Changes
- Test Impact Analysis
- Documentation Updates
- Migration Path Planning
- Risk Assessment

#### `/global:orchestration:test-coverage`

Test analysis with 5 agents:

- Coverage Metrics
- Test Quality Assessment
- Missing Test Cases
- Test Performance
- Flaky Test Detection

#### `/global:orchestration:performance-scan`

Performance profiling with 7 agents:

- Algorithm Complexity
- Database Query Analysis
- Memory Usage Patterns
- CPU Hotspots
- I/O Bottlenecks
- Caching Opportunities
- Optimization Suggestions

### Research Commands

#### `/global:research:deep-dive`

Multi-perspective research with 8 different viewpoints on a topic.

#### `/global:research:codebase-map`

Complete codebase mapping with 10 agents for different aspects.

#### `/global:research:dependency-trace`

In-depth dependency analysis with 6 specialized agents.

## Best Practices

### When to Use Sub-Agents

**ALWAYS use for:**

- Multi-file analyses
- Code quality checks
- Security audits
- Test coverage analysis
- Documentation tasks
- Performance profiling
- Migration planning
- Bug investigation across multiple files
- Architecture reviews
- Refactoring impact analysis

**AVOID for:**

- Single-file edits
- Small, sequential changes
- Direct code modifications
- Tasks with strong dependencies

### Task Decomposition Patterns

#### Pattern 1: Domain-based Division

```
Agent 1: Frontend Analysis
Agent 2: Backend Analysis
Agent 3: Database Layer
Agent 4: API Contracts
```

#### Pattern 2: Concern-based Division

```
Agent 1: Security Concerns
Agent 2: Performance Issues
Agent 3: Code Quality
Agent 4: Documentation
```

#### Pattern 3: File-based Division

```
Agent 1: Core Module Files
Agent 2: Test Files
Agent 3: Configuration
Agent 4: Documentation
```

### Performance Optimization

1. **Batch Start**: Start all agents in one tool call
2. **Clear Boundaries**: No task overlaps between agents
3. **Focused Prompts**: Specific, clearly defined tasks
4. **Structured Output**: Unified format for synthesis
5. **Early Termination**: Agents can terminate early when needed

### Debugging Multi-Agent Workflows

When troubleshooting sub-agent commands:

1. **Check individual agent outputs**: Each agent provides structured feedback
2. **Monitor token usage**: Avoid exceeding budget
3. **Identify task overlap**: Minimize redundant work
4. **Debug synthesis errors**: Ensure output format consistency

## Creating Custom Commands

### Using Helper Script

```bash
# Create simple command
./scripts/create-sub-agent-command.sh \
  --name "dependency-audit" \
  --agents 6 \
  --category "orchestration"
```

### Manual with Templates

1. Choose template from `commands/templates/`
2. Adapt for specific use case
3. Clearly define agent tasks
4. Document performance goals
5. Test and iterate

### Command Structure

```yaml
---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*)
description: Brief description for command list
argument-hint: [expected-arguments]
---

# Command Name

Detailed description of the command and its function.

## Sub-Agent Strategy

**IMMEDIATELY START [N] PARALLEL AGENTS:**

1. **Agent Name**: Specific task
2. **Agent Name**: Specific task
...

**Expected Performance**: Xx faster than sequential

## Synthesis

After all agents complete:
- How results are combined
- What output format is used
- Prioritization of findings
```

## Integration with Existing Workflows

### Git Hooks

```bash
# Pre-commit hook for automatic code analysis
#!/bin/bash
claude-code /global:orchestration:analyze-parallel --quick
```

### CI/CD Pipeline

```yaml
# GitHub Actions Example
- name: Claude Code Analysis
  run: |
    claude-code /global:orchestration:security-audit
    claude-code /global:orchestration:test-coverage
```

### VS Code Tasks

```json
{
  "label": "Claude Code Analysis",
  "type": "shell",
  "command": "claude-code /global:orchestration:analyze-parallel ${workspaceFolder}",
  "problemMatcher": []
}
```

## Advanced Configuration

The `.claude-commands.json` enables project-specific customizations:

```json
{
  "subAgentDefaults": {
    "tokenBudget": 3000,
    "timeout": 30000,
    "retryOnFailure": true
  },
  "performanceMode": "aggressive",
  "synthesis": {
    "format": "markdown",
    "deduplication": true,
    "prioritization": "severity"
  }
}
```

## Troubleshooting

### Common Issues

**"Token limit exceeded"**

- Reduce token budget per agent
- Use fewer agents
- Optimize context size

**"Agent timeout"**

- Increase timeout in configuration
- Reduce task scope
- Decrease parallelism

**"Synthesis failed"**

- Check agent output format
- Ensure structured outputs
- Improve error handling

## Metrics and Monitoring

### Performance Tracking

Commands automatically log performance metrics:

```
[PERF] analyze-parallel completed:
- Total time: 6.2s
- Agents: 10
- Sequential estimate: 58s
- Speedup: 9.4x
- Tokens used: 28,450
```

### Success Metrics

- **Execution time**: Target < 10s for most commands
- **Speedup factor**: Target > 5x vs. sequential
- **Token efficiency**: < 3000 tokens/agent
- **Error rate**: < 5% agent failures

## Future Development

### Planned Features

1. **Adaptive agent count** based on codebase size
2. **Caching** for repeated analyses
3. **Custom synthesis strategies** per command
4. **Real-time progress updates** during execution
5. **Integration with Claude Code Memory**

### Community Contributions

Contributions are welcome! Especially sought:

- New command ideas
- Performance optimizations
- Integration examples
- Documentation improvements

## References

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Task Tool Reference](https://docs.anthropic.com/claude-code/tools)
- [Original dotfiles Implementation](https://github.com/example/dotfiles)
