# Quick Start: Claude Code Toolkit v3.0

Get started with the Claude Code Toolkit in 5 minutes! 🚀

## Installation

```bash
# Clone and install
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit
./install.sh tk
```

## Your First Command

Just describe your problem:

```bash
/tk:flow:smart "My tests are failing and the app is slow"
```

The AI will analyze your problem and coordinate the right specialists to fix it!

## Three Powerful Workflows

### 1. Smart Problem Solving 🧠

```bash
# Natural language problem solving
/tk:flow:smart "Production API returning 500 errors"
/tk:flow:smart "Need to improve test coverage"
/tk:flow:smart "App performance is degrading"
```

### 2. One-Command Pipelines 🚀

```bash
# Pre-built workflows
/tk:meta:pipelines quick-quality    # 30-second quality check
/tk:meta:pipelines deep-quality     # Full analysis + fixes
/tk:meta:pipelines security-hardening # Security focus
/tk:meta:pipelines release-prep     # Pre-release validation
```

### 3. Command Chaining 🔗

```bash
# Build custom workflows
/tk:meta:chain "scan:deep ." -> "fix:quick-wins {output}" -> "meta:health"

# Parallel execution
/tk:meta:chain ["scan:security .", "scan:perf ."] -> "meta:export {outputs}"
```

## Essential Commands

### Analysis

```bash
/tk:scan:deep .          # Comprehensive analysis
/tk:scan:quality .       # Code quality metrics
/tk:scan:security .      # Security audit
/tk:scan:perf .          # Performance profiling
```

### Fixes

```bash
/tk:fix:quick-wins report.json    # High-ROI fixes
/tk:fix:security report.json      # Security patches
/tk:fix:performance               # Speed optimizations
```

### Workflows

```bash
/tk:flow:review .        # Multi-perspective code review
/tk:flow:incident "API down"      # Emergency response
/tk:flow:refactor src/legacy      # Smart refactoring
```

### Management

```bash
/tk:meta:health          # Project health check
/tk:auto:sprint .        # Plan improvement sprint
/tk:meta:export reports/ # Export all reports
```

## Real-World Examples

### Before Committing

```bash
/tk:meta:pipelines quick-quality
```

### Fix Everything Automatically

```bash
# One command to analyze and fix
/tk:meta:chain "scan:deep ." -> "auto:execute {output} --mode=auto"
```

### Weekly Maintenance

```bash
/tk:auto:monitor . --schedule=weekly --auto-fix=safe
```

### Production Issue

```bash
/tk:flow:incident "Users can't login, getting 401 errors"
```

## Understanding Output

### Smart Flow Results

```
🧠 Problem Analysis:
- Type: Performance + Testing
- Severity: High
- Affected Systems: API, Database

📋 Action Plan:
1. Database query optimization (2h)
2. Add caching layer (1h)
3. Fix failing tests (30m)

✅ Executing fixes...
```

### Analysis Reports

```
📊 Code Quality Report
- Score: 78/100 (B+)
- Security: 85/100 ✓
- Performance: 72/100 ⚠️
- Tests: 65/100 ⚠️

🎯 Quick Wins (5):
- Add DB indexes (30m, +40% speed)
- Enable compression (5m, -60% bandwidth)
- Fix linting errors (15m, cleaner code)
```

## Tips & Tricks

### 1. Start Smart

Always try `/flow:smart` first - it's the easiest way!

### 2. Export Everything

```bash
/tk:scan:deep . --export-all
```

### 3. Dry Run First

```bash
/tk:auto:execute plan.md --dry-run
```

### 4. Focus Analysis

```bash
/tk:scan:deep . --focus=security
```

### 5. Compare Progress

```bash
/tk:meta:health --compare=last-week.json
```

## Common Issues

### Commands Not Found

```bash
# Verify installation
ls ~/.claude/commands/tk/
```

### Analysis Too Slow

```bash
# Analyze specific directories
/tk:scan:deep src/ --max-files=100
```

### Need Help?

```bash
# Get personalized guidance
/tk:flow:smart "help me get started with the toolkit"
```

## Next Steps

1. **Try it now**: `/tk:flow:smart "analyze my code"`
2. **Read more**: [Modern Workflow Guide](../guides/MODERN-WORKFLOW.md)
3. **See changes**: [Migration Guide](../archive/MIGRATION-GUIDE.md)
4. **Go deep**: [Command Reference](../../README.md#available-commands)

## Quick Reference Card

```bash
# Problem? Use smart flow
/tk:flow:smart "your problem"

# Quality check
/tk:meta:pipelines quick-quality

# Fix everything
/tk:meta:chain "scan:deep ." -> "fix:quick-wins {output}"

# Check health
/tk:meta:health
```

Welcome to effortless code quality! 🎉
