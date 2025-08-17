# Workflow Guide

Essential workflow patterns for getting the most out of Claude Code Toolkit.

## Quick Workflow Selection

| Scenario | Best Approach | Command |
|----------|---------------|---------|
| **Any Problem** | Smart routing | `/prefix:flow:smart "describe issue"` |
| **Pre-commit** | Quick check | `/prefix:scan:quick . --export-json` |
| **Deep Analysis** | Full pipeline | `/prefix:scan:deep . --export-json` |
| **Fix Issues** | Auto-fix | `/prefix:fix:quick-wins report.json` |
| **Security Focus** | Security audit | `/prefix:sec:audit . --compliance=owasp` |

## Core Workflows

### 1. Smart Problem Solving

Let AI handle complex problems automatically:

```bash
# Examples
/prefix:flow:smart "my tests are slow and flaky"
/prefix:flow:smart "production errors in authentication"
/prefix:flow:smart "need to improve performance"
```

**Result**: AI analyzes, routes to specialists, provides solutions.

### 2. Quality Improvement Cycle

Standard improvement workflow:

```bash
# 1. Analyze
/prefix:scan:deep . --export-json

# 2. Fix high-impact issues  
/prefix:fix:quick-wins analysis-*.json

# 3. Verify improvements
/prefix:scan:quality . --compare=baseline.json
```

### 3. Security Hardening

Security-focused workflow:

```bash
# 1. Security audit
/prefix:sec:audit . --compliance=owasp --export-json

# 2. Fix critical vulnerabilities
/prefix:fix:security audit-*.json --severity=critical,high

# 3. Verify fixes
/prefix:sec:audit . --verify
```

### 4. Performance Optimization

Performance-focused workflow:

```bash
# 1. Performance analysis
/prefix:scan:perf . --profile --export-json

# 2. Apply optimizations
/prefix:fix:performance perf-*.json --safe-only

# 3. Benchmark improvements
/prefix:scan:perf . --compare=baseline.json
```

### 5. Command Chaining

Chain commands for automation:

```bash
# Simple chain
/prefix:meta:chain "scan:quick ." -> "fix:quick-wins {output}"

# Multi-step workflow
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}" -> "scan:quality . --verify"
```

For advanced chaining patterns, see [Advanced Workflows](../guides/ADVANCED-WORKFLOWS.md).

## Working with Results

### Automatic File Management

Commands automatically create timestamped files:

```bash
# Analysis creates: analysis-20250117-143022.json
/prefix:scan:deep . --export-json

# Use latest results
/prefix:fix:quick-wins --latest
/prefix:scan:report --latest --generate-action-plan
```

### Comparing Progress

Track improvements over time:

```bash
# Create baseline
/prefix:scan:quality . --export-json
mv analysis-*.json baseline.json

# Compare after changes
/prefix:scan:quality . --export-json
/prefix:scan:report --latest --compare=baseline.json
```

## Best Practices

### 1. Start Smart

Always try `flow:smart` first for complex problems:

```bash
/prefix:flow:smart "help me understand what's wrong with my code"
```

### 2. Export Everything

Always use `--export-json` to track progress:

```bash
/prefix:scan:deep . --export-json  # Creates timestamped file
```

### 3. Verify Changes

Test fixes with comparison scans:

```bash
/prefix:scan:quality . --compare=before-fix.json
```

### 4. Use Incremental Approach

Fix high-impact issues first:

```bash
/prefix:fix:quick-wins report.json --threshold=8  # Only high-ROI fixes
```

## Common Issues

### Commands Not Found

```bash
# Verify installation
ls ~/.claude/commands/yourprefix/

# Check command exists
/prefix:meta:find-cmd "scan deep analysis"
```

### Analysis Takes Too Long

```bash
# Focus on specific areas
/prefix:scan:deep . --focus=security

# Use quick scan instead
/prefix:scan:quick . --export-json
```

### No Issues Found

```bash
# Lower thresholds
/prefix:fix:quick-wins report.json --threshold=5

# Try different focus areas
/prefix:scan:deep . --focus=performance
```

### Results Not Clear

```bash
# Get help interpreting results
/prefix:flow:smart "explain my analysis results"

# Generate action plan
/prefix:scan:report report.json --generate-action-plan
```

## Next Steps

- **Basics**: See [Quick Start Guide](../guides/QUICK-START.md)
- **Advanced**: See [Advanced Workflows](../guides/ADVANCED-WORKFLOWS.md)  
- **Syntax**: See [Command Reference](command-reference.md)
- **Issues**: See [Troubleshooting](troubleshooting.md)