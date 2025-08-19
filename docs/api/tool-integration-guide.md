# Claude Code Toolkit Tool Integration Guide

## Overview

Progressive enhancement approach for tool integration - commands work with basic tools and leverage advanced capabilities when available.

### Core Principles

- **Optional Enhancement**: Advanced tools enhance, never gate functionality
- **Graceful Degradation**: Always works, even without enhanced tools
- **Transparent Operation**: Users know which tools were used
- **Progressive Quality**: Better tools = better results

### Tool Hierarchy

```
┌─────────────────────────────────────┐
│   MCP-Enhanced (Best quality)       │
├─────────────────────────────────────┤
│   Local CLI Tools (Good quality)    │
├─────────────────────────────────────┤
│   Pattern-Based (Basic quality)     │
└─────────────────────────────────────┘
```

## MCP Server Integration

### Supported Servers

| Server | Purpose | Key Tools |
|--------|---------|----------|
| **Semgrep** | Security analysis | `mcp__semgrep__security_check`, `mcp__semgrep__semgrep_scan` |
| **GitHub** | Repository ops | `mcp__github__*` - PR, issue, repo operations |
| **GitLab** | GitLab integration | `mcp__gitlab__*` - GitLab API |
| **Perplexity** | Web search | `mcp__perplexity__*` - Documentation search |

### Declaration in Commands

```yaml
---
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
---
```

The `mcp-enhanced` field documents which MCP tools enhance a command (optional, not enforced).

## Fallback Mechanisms

### Three-Tier Strategy

**Tier 1: MCP-Enhanced**

- AST-based analysis
- Semantic understanding
- Lowest false positives

**Tier 2: Local Tools**

```bash
semgrep --config=auto --json .
```

**Tier 3: Pattern-Based**

- Ripgrep patterns
- Task Tool agents
- Basic heuristics

### Implementation Pattern

```markdown
1. Check MCP: Test `mcp__tool__*` availability
2. Check local: `Bash("which tool")`
3. Execute based on availability:
   - MCP → Enhanced analysis
   - Local → Standard analysis
   - Neither → Pattern fallback
```

## Tool Discovery

### Detection Process

1. **MCP Tools**: Test specific tool names (`mcp__semgrep__*`)
2. **Local Tools**: Check with `which` command
3. **Select Strategy**: Use best available option

```bash
# Example detection
which semgrep >/dev/null 2>&1 && echo "available" || echo "not found"
```

## Integration Patterns

### Common Patterns

**1. Conditional Usage**

```markdown
IF MCP available: Use enhanced features
ELSE IF local tool: Use standard features
ELSE: Use pattern fallback
```

**2. Progressive Enhancement**

- Base: Pattern detection (always works)
- Enhanced: Semantic analysis (with tools)
- Advanced: AST analysis (with MCP)

**3. Hybrid Approach**

- Phase 1: Parallel scanning
- Phase 2: Deep analysis with best tools
- Phase 3: Synthesize results

**4. Tool-Specific Features**

- MCP: AST, custom rules, CI/CD integration
- Local: Flexible config, offline operation
- Basic: Patterns, parallel execution

## Error Handling

### Failure Scenarios

| Error | Action | User Message |
|-------|--------|-------------|
| MCP not running | Fall back to local | "Using local tool (MCP unavailable)" |
| Local tool missing | Fall back to patterns | "Using patterns (tool not installed)" |
| Tool execution fails | Try fallback, use partial results | "Reduced confidence due to tool error" |

### Recovery Strategies

- **Partial Results**: Continue with available data
- **Timeout Management**: Fall back if tool hangs
- **Resource Limits**: Scale down for large codebases

### Status Reporting

```markdown
**Tool Status**:
- Attempted: Semgrep MCP ❌
- Fallback: Local Semgrep ❌
- Used: Patterns ✓

**Confidence**: Medium
```

## Security Considerations

### Tool Trust Levels

1. **MCP**: Highest (vetted, sandboxed)
2. **Local**: Medium (user-installed)
3. **Pattern**: Baseline (no dependencies)

### Best Practices

- **Input Validation**: Sanitize paths and patterns
- **Output Sanitization**: Never expose secrets
- **Tool Restrictions**: Use `allowed-tools` field
- **Data Handling**: Report findings without sensitive values

```yaml
# Example restriction
allowed-tools: Bash(semgrep:*), Bash(git:log)
```

## Best Practices

### Key Guidelines

1. **Always Check First**: Test tool availability before use
2. **Transparent Reporting**: Show which tools were used
3. **Progressive Design**: Core → Enhanced → Advanced features
4. **Performance Planning**: Optimize for each tool tier
5. **User Guidance**: Help users install enhanced tools
6. **Test All Scenarios**: MCP, local, and no-tools
7. **Clear Documentation**: Document tool requirements
8. **Graceful Degradation**: Smooth quality transitions

### Testing Matrix

| Scenario | Test Focus |
|----------|------------|
| Full MCP | Advanced features, performance |
| Local only | Fallback quality |
| No tools | Basic functionality |

### Quality Indicators

```markdown
MCP:     Semantic ✓ Cross-file ✓ Custom rules ✓
Local:   Semantic ✓ Cross-file ✓ Custom rules ✗
Pattern: Semantic ✗ Cross-file ✗ Custom rules ✗
```

## Examples

### Security with Progressive Enhancement

```yaml
---
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
allowed-tools: Task, Read, Grep, Bash(semgrep:*)
---

# Execution Strategy
- MCP: AST-based analysis, detailed remediation
- Local: Standard configs, JSON processing
- Pattern: Task agents, ripgrep patterns
```

### Multi-Tool Integration

```yaml
---
mcp-enhanced: mcp__semgrep__*, mcp__github__*, mcp__perplexity__*
---

# Tool Orchestra
1. Security: Semgrep MCP → Local → Patterns
2. Repository: GitHub MCP → Git CLI → Files
3. Docs: Perplexity → Local → Built-in

Each dimension degrades independently.
```

## Summary

Claude Code Toolkit tool integration principles:

- **Progressive Enhancement**: Basic → Enhanced → Advanced
- **Graceful Degradation**: Core functionality always works
- **Transparent Operation**: Clear tool status reporting
- **Quality Tiers**: MCP (best) → Local (good) → Patterns (basic)
- **Easy Adoption**: Clear paths for tool installation

Commands work everywhere, enhanced tools improve quality and performance.
