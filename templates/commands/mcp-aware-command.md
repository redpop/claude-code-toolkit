---
allowed-tools: Task, Read, Grep, Bash, Write
mcp-enhanced: # List MCP tools that enhance this command
description: Template for creating MCP-aware commands with graceful fallback
argument-hint: [arguments] [--options]
---

# MCP-Aware Command Template

This template demonstrates how to create commands that leverage MCP servers when available while providing fallback functionality.

## Tool Detection Phase

**FIRST, CHECK AVAILABLE TOOLS:**

1. **Check for [MCP Server Name]**: Test if `mcp__[server]__*` tools are available
2. **Check for local alternatives**: `Bash("which [tool]")`
3. **Determine execution strategy** based on available tools

## Execution Strategy

### Option A: MCP-Enhanced Execution (Preferred)

**IF MCP tools are available, USE THIS APPROACH:**

1. **Enhanced Functionality**:
   - Use `mcp__[server]__[tool]` for advanced features
   - Leverage MCP-specific capabilities
   - Benefit from higher accuracy/performance

2. **MCP-Specific Features**:
   - List unique capabilities only available with MCP
   - Describe enhanced accuracy or performance
   - Note any additional data available

### Option B: Local Tool Fallback

**IF MCP is NOT available BUT local tools exist:**

```bash
# Use local tool with appropriate parameters
[local-tool] --param1 --param2 $ARGUMENTS
```

### Option C: Basic Fallback

**IF neither MCP nor local tools are available:**

Implement basic functionality using standard tools:

- Use Task Tool agents for parallel processing
- Use ripgrep for pattern matching
- Use bash scripts for basic operations

## Result Processing

Regardless of execution method:

1. **Normalize Results**:
   - Convert different output formats to common structure
   - Ensure consistent data regardless of tool used

2. **Quality Indication**:

   ```markdown
   ## Analysis Report
   
   **Tool Used**: [MCP Server | Local Tool | Basic Patterns]
   **Quality Level**: [High | Medium | Basic]
   **Confidence**: [percentage]
   ```

3. **Tool Recommendations**:
   - If using fallback, suggest MCP installation
   - Explain benefits of enhanced tools
   - Provide installation instructions

## Example Implementation

```markdown
### If analyzing code quality:

With MCP:
- AST-based analysis
- Semantic understanding
- Cross-file analysis

Without MCP:
- Pattern-based checks
- Single-file scope
- Basic heuristics
```

## Best Practices

1. **Always Check First**:
   - Don't assume MCP availability
   - Test specific tools needed
   - Have fallback ready

2. **Transparent Reporting**:
   - Tell users which method was used
   - Explain quality differences
   - Suggest improvements

3. **Graceful Degradation**:
   - Core functionality always works
   - Enhanced features are bonuses
   - Never fail due to missing MCP

4. **Performance Considerations**:
   - MCP tools often faster
   - Plan for slower fallbacks
   - Set appropriate timeouts

## Configuration

```yaml
# In command frontmatter:
allowed-tools: Task, Read, Grep, Bash, Write
mcp-enhanced: mcp__semgrep__security_check, mcp__gitlab__get_file_contents
description: Your command description mentioning MCP enhancement
```

## Output Format

Always indicate tool usage in output:

```markdown
## Results

**Analysis completed using**: [Tool Name]
**Enhanced features used**: [Yes/No]
**Recommendation**: [If fallback used, suggest MCP installation]

[Rest of output...]
```

## Testing

Test your command in three scenarios:

1. With MCP server installed and running
2. With local tools but no MCP
3. With neither MCP nor local tools

Ensure graceful handling in all cases.

## Documentation

In your command description:

- Mention MCP enhancement capability
- Don't require MCP for basic function
- List benefits of MCP when available

This template ensures commands provide value in all environments while taking advantage of enhanced capabilities when available.
