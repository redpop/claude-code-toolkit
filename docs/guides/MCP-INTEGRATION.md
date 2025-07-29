# MCP Integration Guide

This guide explains how to integrate and use MCP (Model Context Protocol) servers with the Claude Code Toolkit, with a focus on the Semgrep MCP integration for enhanced security analysis.

## Overview

MCP servers extend Claude Code's capabilities by providing access to specialized tools. The Claude Code Toolkit is designed to leverage these tools when available while gracefully falling back to traditional methods when they're not.

## Semgrep MCP Integration

### Installation

To use Semgrep MCP with the toolkit:

1. Install the Semgrep MCP server globally:
   ```bash
   npm install -g @semgrep/mcp
   ```

2. Configure it in your Claude Desktop settings:
   ```json
   {
     "mcpServers": {
       "semgrep": {
         "command": "semgrep-mcp"
       }
     }
   }
   ```

3. Restart Claude Desktop to activate the MCP server

### Available Semgrep Tools

When Semgrep MCP is installed, the following tools become available:

- `mcp__semgrep__security_check` - Fast security vulnerability scanning
- `mcp__semgrep__semgrep_scan` - Comprehensive code analysis with configurable rules
- `mcp__semgrep__semgrep_scan_with_custom_rule` - Scan with custom security rules
- `mcp__semgrep__semgrep_findings` - Retrieve findings from CI/CD pipelines
- `mcp__semgrep__get_abstract_syntax_tree` - AST analysis for precise code understanding
- `mcp__semgrep__semgrep_rule_schema` - Get Semgrep rule schema for custom rules
- `mcp__semgrep__get_supported_languages` - Check language support

### How Commands Use MCP

#### 1. Detection Pattern

Commands check for MCP availability using this pattern:

```markdown
1. Check if mcp__semgrep__* tools are available
2. If available: Use MCP-powered analysis
3. If not available: Fall back to traditional methods
4. Notify user of analysis method used
```

#### 2. Fallback Strategy

When Semgrep MCP is not available, commands use:

- **Primary Fallback**: Local `semgrep` CLI if installed
- **Secondary Fallback**: Pattern-based analysis using `ripgrep`
- **Tertiary Fallback**: Task Tool agents with manual patterns

#### 3. Quality Indicators

Reports indicate the analysis quality achieved:

| Analysis Method | Quality | Speed | Coverage |
|----------------|---------|-------|----------|
| Semgrep MCP | Excellent | Fast | Complete |
| Local Semgrep | Very Good | Medium | Complete |
| Pattern-based | Basic | Fast | Limited |

## Usage in Commands

### Security Audit Command

With Semgrep MCP:
```markdown
Uses mcp__semgrep__security_check for:
- OWASP Top 10 vulnerability detection
- Known CVE identification
- Security best practice violations
```

Without Semgrep MCP:
```markdown
Falls back to:
- Regex patterns for common vulnerabilities
- Manual security checks
- Basic pattern matching
```

### Fix Security Command

With Semgrep MCP:
```markdown
1. Runs mcp__semgrep__semgrep_scan to identify issues
2. Uses AST analysis for precise fixes
3. Validates fixes with another scan
```

Without Semgrep MCP:
```markdown
1. Uses pattern matching to find issues
2. Applies template-based fixes
3. Manual validation required
```

### Deep Analysis Command

Integrates Semgrep as one of many analysis tools:
```markdown
Phase 1: Parallel scanning (includes Semgrep if available)
Phase 2: Expert delegation based on findings
Phase 3: Comprehensive report generation
```

## Best Practices

### 1. Conditional Tool Usage

Always check for tool availability:
```markdown
IF mcp__semgrep__security_check is available:
  Use MCP tool for accurate analysis
ELSE:
  Use fallback method and inform user
```

### 2. Transparent Reporting

Always indicate which analysis method was used:
```markdown
## Security Analysis Report

**Analysis Method**: Semgrep MCP (High Accuracy)
-- or --
**Analysis Method**: Pattern-based (Basic Coverage)

[Include appropriate caveats based on method]
```

### 3. Progressive Enhancement

Design commands to work at multiple quality levels:
- **Best**: Full MCP integration
- **Good**: Local tool availability
- **Basic**: Pattern-based fallbacks

### 4. User Guidance

When MCP is not available, provide installation instructions:
```markdown
💡 **Tip**: For enhanced security analysis, install Semgrep MCP:
npm install -g @semgrep/mcp
Then configure in Claude Desktop settings
```

## Creating MCP-Aware Commands

When creating new commands that can use MCP:

1. **List MCP tools in frontmatter** (when they enhance functionality):
   ```yaml
   ---
   allowed-tools: Task, Read, Grep, Bash, Write
   mcp-enhanced: mcp__semgrep__*
   description: Security analysis with MCP enhancement
   ---
   ```

2. **Implement detection logic**:
   ```markdown
   Check for MCP availability and adjust approach
   ```

3. **Document both paths**:
   ```markdown
   With MCP: [enhanced approach]
   Without MCP: [fallback approach]
   ```

4. **Test both scenarios**:
   - Test with MCP server running
   - Test with MCP server disabled

## Other MCP Integrations

While Semgrep is the primary example, the same patterns apply to other MCP servers:

### GitHub MCP
- Enhanced repository analysis
- PR and issue integration
- Direct API access

### Perplexity MCP
- Web search for documentation
- Current security advisories
- Best practice research

### GitLab MCP
- GitLab-specific operations
- CI/CD integration
- Merge request analysis

## Troubleshooting

### MCP Not Detected

1. Verify installation: `npm list -g @semgrep/mcp`
2. Check Claude Desktop settings
3. Restart Claude Desktop
4. Verify in Claude Code with available tools list

### Fallback Not Working

1. Check if local tools are installed
2. Verify ripgrep availability
3. Ensure proper error handling in commands

### Performance Issues

1. MCP tools are generally faster than fallbacks
2. Consider focused scans for large codebases
3. Use incremental analysis where possible

## Future Enhancements

- Auto-detection of available MCP servers
- Dynamic capability discovery
- Performance benchmarking
- Custom MCP server integration

## Summary

MCP integration in the Claude Code Toolkit follows these principles:

1. **Optional Enhancement**: MCP servers enhance but don't gate functionality
2. **Graceful Degradation**: Always have working fallbacks
3. **Transparent Operation**: Users know what analysis was performed
4. **Progressive Quality**: Better tools = better results

This approach ensures the toolkit remains useful in all environments while providing the best possible analysis when enhanced tools are available.