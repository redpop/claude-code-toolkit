# Claude Code Toolkit Tool Integration Guide

This guide provides comprehensive documentation for integrating tools into Claude Code Toolkit commands, with a focus on MCP (Model Context Protocol) servers and graceful fallback mechanisms.

## Table of Contents

1. [Tool Integration Overview](#tool-integration-overview)
2. [MCP Server Integration](#mcp-server-integration)
3. [Fallback Mechanisms](#fallback-mechanisms)
4. [Tool Discovery](#tool-discovery)
5. [Integration Patterns](#integration-patterns)
6. [Error Handling](#error-handling)
7. [Security Considerations](#security-considerations)
8. [Best Practices](#best-practices)

## Tool Integration Overview

The Claude Code Toolkit uses a progressive enhancement approach to tool integration. Commands are designed to work with basic tools while leveraging advanced capabilities when available.

### Core Principles

1. **Optional Enhancement**: Advanced tools enhance but never gate functionality
2. **Graceful Degradation**: Commands always work, even without enhanced tools
3. **Transparent Operation**: Users always know which tools were used
4. **Progressive Quality**: Better tools yield better results

### Tool Hierarchy

```
┌─────────────────────────────────────┐
│       MCP-Enhanced Tools            │ ← Best quality
│   (Semgrep, GitHub, GitLab, etc.)   │
├─────────────────────────────────────┤
│        Local CLI Tools              │ ← Good quality
│    (semgrep, git, npm, etc.)       │
├─────────────────────────────────────┤
│      Pattern-Based Tools            │ ← Basic quality
│   (ripgrep, Task agents, bash)     │
└─────────────────────────────────────┘
```

## MCP Server Integration

MCP servers extend Claude Code's capabilities through specialized tools. The toolkit currently supports several MCP servers:

### Supported MCP Servers

#### Semgrep MCP

Provides advanced security analysis with AST-based scanning:

- `mcp__semgrep__security_check` - Fast security vulnerability scanning
- `mcp__semgrep__semgrep_scan` - Comprehensive code analysis
- `mcp__semgrep__semgrep_scan_with_custom_rule` - Custom rule scanning
- `mcp__semgrep__semgrep_findings` - Retrieve CI/CD findings
- `mcp__semgrep__get_abstract_syntax_tree` - AST analysis
- `mcp__semgrep__semgrep_rule_schema` - Rule schema access
- `mcp__semgrep__get_supported_languages` - Language support check

#### GitHub MCP

Repository and pull request integration:

- `mcp__github__*` - Various GitHub operations

#### GitLab MCP

GitLab-specific operations:

- `mcp__gitlab__*` - GitLab API integration

#### Perplexity MCP

Web search and documentation:

- `mcp__perplexity__*` - Web search capabilities

### Declaring MCP Enhancement

Commands declare MCP enhancement in their frontmatter:

```yaml
---
allowed-tools: Task, Read, Grep, Bash, Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
description: Security analysis with MCP enhancement when available
argument-hint: [directory] [--severity=high]
---
```

The `mcp-enhanced` field:

- Lists MCP tools that enhance the command
- Serves as documentation for available enhancements
- Does not enforce tool availability

## Fallback Mechanisms

Commands implement a three-tier fallback strategy to ensure functionality in all environments:

### Tier 1: MCP-Enhanced Execution

When MCP tools are available, commands use them for:

- Higher accuracy analysis
- Faster processing
- Advanced features (AST analysis, semantic understanding)
- Better false-positive reduction

### Tier 2: Local Tool Fallback

When MCP is unavailable but local tools exist:

````markdown
**IF local Semgrep is available but not MCP:**

```bash
# Use local CLI with appropriate parameters
semgrep --config=auto --json --severity=ERROR,WARNING .
```
````

````

### Tier 3: Basic Pattern Fallback

When neither MCP nor local tools are available:
```markdown
**IF no specialized tools available:**

Use Task Tool agents for parallel pattern-based analysis:
- SQL injection patterns with ripgrep
- XSS vulnerability detection
- Basic security checks
- Manual pattern matching
````

### Fallback Implementation Example

```markdown
## Tool Detection Phase

**FIRST, CHECK AVAILABLE TOOLS:**

1. **Check for Semgrep MCP**: Test if `mcp__semgrep__*` tools are available
2. **Check for local Semgrep**: `Bash("which semgrep")`
3. **Determine execution strategy** based on available tools

## Execution Strategy

### Option A: MCP-Enhanced (Preferred)

IF mcp**semgrep**security_check is available:

- Use MCP tool for comprehensive analysis
- Leverage AST-based detection
- Get semantic understanding

### Option B: Local Tool Fallback

ELSE IF local semgrep is available:

- Run semgrep with appropriate configs
- Process JSON output
- Apply similar analysis logic

### Option C: Pattern-Based Fallback

ELSE:

- Use ripgrep for pattern matching
- Deploy Task agents for parallel scanning
- Apply heuristic-based detection
```

## Tool Discovery

Commands discover available tools through a systematic check process:

### 1. MCP Tool Detection

Commands check for MCP availability by testing specific tool names:

```markdown
1. **Check for Semgrep MCP**:
   - Test if `mcp__semgrep__security_check` is callable
   - Verify other required MCP tools
   - Note available capabilities
```

### 2. Local Tool Detection

Use Bash to check for local installations:

````markdown
2. **Check for local tools**:

   ```bash
   # Check if semgrep is installed
   which semgrep >/dev/null 2>&1 && echo "available" || echo "not found"

   # Check version if needed
   semgrep --version 2>/dev/null || echo "not installed"
   ```
````

````

### 3. Capability Assessment

Based on discovery results:
- Select the best available execution path
- Adjust analysis depth and features
- Set user expectations appropriately

## Integration Patterns

### Pattern 1: Conditional Tool Usage

The most common pattern checks availability before use:

```markdown
**IF Semgrep MCP is available:**

1. Use `mcp__semgrep__security_check` for initial scan
2. If issues found, use `mcp__semgrep__semgrep_scan` for details
3. Apply AST-based analysis for precise fixes

**ELSE IF local Semgrep available:**

1. Run `semgrep --config=auto` for scanning
2. Parse JSON output for issue processing
3. Apply pattern-based fixes

**ELSE:**

1. Use ripgrep with security patterns
2. Deploy parallel Task agents
3. Apply manual security checks
````

### Pattern 2: Progressive Enhancement

Start with basic functionality and enhance when possible:

```markdown
## Base Analysis (Always Available)

- Pattern-based vulnerability detection
- Basic code quality checks
- Simple security scans

## Enhanced with Local Tools

- Semantic analysis
- Better false-positive reduction
- More vulnerability types

## Enhanced with MCP

++ AST-based precision
++ Cross-file analysis
++ Custom rule support
++ CI/CD integration
```

### Pattern 3: Hybrid Approach

Combine multiple tools for comprehensive analysis:

```markdown
## Phase 1: Parallel Scanning

- Deploy multiple Task agents simultaneously
- Use MCP tools if available for specific agents
- Collect all results in structured format

## Phase 2: Deep Analysis

- Delegate critical findings to specialized tools
- Use MCP for high-priority issues
- Fall back to patterns for others

## Phase 3: Synthesis

- Combine results from all sources
- Weight findings by tool quality
- Generate unified report
```

### Pattern 4: Tool-Specific Features

Leverage unique capabilities when available:

```markdown
**MCP-Specific Features:**

- AST analysis for precise code understanding
- Custom rule creation and execution
- CI/CD findings integration
- Language-specific semantic analysis

**Local Tool Features:**

- Configuration flexibility
- Offline operation
- Custom rule paths

**Basic Features:**

- Pattern matching
- Parallel execution
- Cross-platform compatibility
```

## Error Handling

Robust error handling ensures commands continue functioning even when tools fail:

### Tool Failure Scenarios

#### 1. MCP Server Not Running

```markdown
**Error**: MCP tool not found
**Action**: Automatically fall back to local tool
**User Notification**: "Using local Semgrep for analysis (MCP not available)"
```

#### 2. Local Tool Missing

```markdown
**Error**: Command not found
**Action**: Fall back to pattern-based approach
**User Notification**: "Using pattern-based analysis (Semgrep not installed)"
```

#### 3. Tool Execution Failure

```markdown
**Error**: Tool returned non-zero exit code
**Action**:

1. Log error details
2. Attempt fallback method
3. Continue with partial results if possible
   **User Notification**: Include error in report with reduced confidence
```

### Error Recovery Strategies

1. **Partial Result Handling**

   - Continue analysis with available data
   - Mark incomplete sections clearly
   - Provide confidence indicators

2. **Timeout Management**

   - Set reasonable timeouts for each tool
   - Fall back if tool exceeds timeout
   - Inform user of timeout occurrence

3. **Resource Constraints**
   - Monitor memory/CPU usage
   - Scale down analysis for large codebases
   - Use incremental processing

### Error Reporting Format

```markdown
## Analysis Report

**Tool Status**:

- Attempted: Semgrep MCP ❌ (server not running)
- Fallback: Local Semgrep ❌ (not installed)
- Used: Pattern-based analysis ✓

**Confidence Level**: Medium (pattern-based analysis)

**Note**: Install Semgrep MCP for enhanced analysis:
npm install -g @semgrep/mcp
```

## Security Considerations

### Tool Trust Levels

1. **MCP Tools**: Highest trust

   - Vetted by MCP ecosystem
   - Consistent API and behavior
   - Sandboxed execution

2. **Local Tools**: Medium trust

   - User-installed and configured
   - Version variability
   - Direct system access

3. **Pattern-Based**: Baseline trust
   - No external dependencies
   - Limited to read operations
   - Predictable behavior

### Security Best Practices

1. **Input Validation**

   ```markdown
   - Sanitize file paths before passing to tools
   - Validate tool output format
   - Escape special characters in patterns
   ```

2. **Output Sanitization**

   ```markdown
   - Never expose actual secrets found
   - Sanitize error messages
   - Limit information in logs
   ```

3. **Tool Restrictions**

   ```yaml
   # Restrict Bash access to specific commands
   allowed-tools: Bash(semgrep:*), Bash(npm:view), Bash(git:log)
   ```

4. **Sensitive Data Handling**
   ```markdown
   **When detecting secrets:**

   - Report type and location only
   - Never log actual secret values
   - Use secure deletion for temp files
   ```

## Best Practices

### 1. Always Check First

Never assume tool availability:

```markdown
**FIRST, CHECK AVAILABLE TOOLS:**

1. Test specific MCP tools needed
2. Check for local alternatives
3. Have fallback ready
```

### 2. Transparent Reporting

Always indicate which tools were used:

```markdown
## Security Analysis Report

**Analysis Method**: Semgrep MCP (High Accuracy)
**Tool Version**: mcp\_\_semgrep v1.2.3
**Scan Duration**: 2.3 seconds
**Files Analyzed**: 156

[If using fallback, explain limitations]
```

### 3. Progressive Enhancement Design

Structure commands for enhancement:

```markdown
1. **Core Functionality** (always works)
   - Basic pattern matching
   - Essential features
2. **Enhanced Features** (when tools available)
   - Advanced analysis
   - Better accuracy
   - Additional insights
```

### 4. Performance Optimization

Consider performance across tool tiers:

```markdown
**Performance Planning:**

- MCP tools: Usually fastest (optimized)
- Local tools: Medium speed (varies by system)
- Pattern fallback: Can be slow on large codebases

**Optimization Strategies:**

- Use focused scans when possible
- Implement progress reporting
- Allow incremental analysis
```

### 5. User Guidance

Help users get the best experience:

````markdown
💡 **Tip**: For enhanced security analysis, install Semgrep MCP:

```bash
npm install -g @semgrep/mcp
```
````

Then configure in Claude Desktop settings:
{
"mcpServers": {
"semgrep": {
"command": "semgrep-mcp"
}
}
}

This enables:

- 3x faster analysis
- 90% fewer false positives
- AST-based precision

````

### 6. Testing Strategies

Test commands in all scenarios:

1. **With Full MCP**
   - All enhanced tools available
   - Verify advanced features work
   - Check performance benefits

2. **With Local Tools Only**
   - MCP disabled
   - Local tools installed
   - Verify fallback quality

3. **With No Tools**
   - Bare environment
   - Only built-in tools
   - Ensure basic functionality

### 7. Documentation Standards

Document tool requirements clearly:
```yaml
---
# Command metadata
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
description: Security audit with progressive enhancement via Semgrep MCP
---

# In command description:
This command provides security analysis with three quality levels:
- **Best**: With Semgrep MCP (recommended)
- **Good**: With local Semgrep
- **Basic**: Pattern-based fallback
````

### 8. Graceful Degradation Patterns

Implement smooth quality transitions:

```markdown
## Quality Indicators

With MCP:

- Semantic analysis ✓
- Cross-file tracking ✓
- Custom rules ✓
- CI/CD integration ✓

With Local Tools:

- Semantic analysis ✓
- Cross-file tracking ✓
- Custom rules ✗
- CI/CD integration ✗

Pattern-Based:

- Semantic analysis ✗
- Cross-file tracking ✗
- Custom rules ✗
- CI/CD integration ✗
```

## Examples

### Example 1: Security Command with Full Integration

```markdown
---
allowed-tools: Task, Read, Grep, Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
description: Comprehensive security analysis with progressive enhancement
---

# Security Analysis Command

## Tool Detection

1. Check for Semgrep MCP availability
2. Check for local Semgrep installation
3. Select appropriate strategy

## Execution

### With MCP (Preferred)

- Use mcp**semgrep**security_check for rapid scan
- Deep dive with mcp**semgrep**semgrep_scan
- Generate detailed remediation guide

### With Local Semgrep

- Run semgrep with security configs
- Process JSON output
- Generate standard report

### Pattern-Based Fallback

- Deploy security-focused Task agents
- Use ripgrep for vulnerability patterns
- Generate basic security report
```

### Example 2: Performance Analysis with Tool Tiers

```markdown
---
allowed-tools: Task, Read, Grep, Bash
mcp-enhanced: mcp__performance__analyze
description: Performance profiling with optional MCP enhancement
---

# Performance Analysis

## Available Analysis Levels

**Tier 1 - MCP Enhanced**:

- Runtime profiling
- Memory allocation tracking
- CPU flame graphs
- Precise bottleneck identification

**Tier 2 - Local Profiler**:

- Basic runtime analysis
- Memory usage estimates
- Performance patterns

**Tier 3 - Static Analysis**:

- Complexity analysis
- Pattern-based bottleneck detection
- Algorithm efficiency review
```

### Example 3: Multi-Tool Integration

```markdown
---
allowed-tools: Task, Read, Grep, Bash, Write
mcp-enhanced: mcp__semgrep__*, mcp__github__*, mcp__perplexity__*
description: Multi-dimensional analysis using multiple MCP servers
---

# Comprehensive Analysis

## Tool Orchestra

1. **Security (Semgrep MCP)**

   - Vulnerability scanning
   - Compliance checking

2. **Repository (GitHub MCP)**

   - PR history analysis
   - Issue correlation

3. **Documentation (Perplexity MCP)**
   - Best practice lookup
   - Security advisory search

## Graceful Degradation

Each dimension degrades independently:

- Security → Local Semgrep → Patterns
- Repository → Git CLI → File analysis
- Documentation → Local docs → Built-in knowledge
```

## Summary

Tool integration in Claude Code Toolkit follows these key principles:

1. **Progressive Enhancement**: Start basic, enhance when possible
2. **Graceful Degradation**: Always maintain core functionality
3. **Transparent Operation**: Users know what's happening
4. **Quality Indication**: Clear communication about analysis depth
5. **Easy Adoption**: Provide clear upgrade paths

This approach ensures commands work everywhere while providing the best possible experience when enhanced tools are available. The toolkit remains useful for all users while rewarding those who install additional tools with better analysis quality and performance.
