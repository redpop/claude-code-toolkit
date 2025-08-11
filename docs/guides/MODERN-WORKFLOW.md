# Modern Workflow Guide

The Claude Code Toolkit v3.0 provides powerful workflows for code quality improvement. This guide covers all approaches from smart automation to detailed manual control.

## 🚀 Quick Start: Choose Your Approach

### 1. Smart Problem Solving (Fastest)

```bash
# Let AI analyze and solve your problem
/prefix:flow:smart "describe your problem here"
```

**Best for**: Complex problems, unclear solutions, multi-faceted issues

### 2. Pre-Built Pipelines (Structured)

```bash
# Run a complete workflow
/prefix:meta:pipelines deep-quality
```

**Available pipelines**:

- `quick-quality` - 30-second check before commits
- `deep-quality` - Comprehensive analysis with fixes
- `security-hardening` - Security-focused improvements
- `refactoring-sprint` - Code structure improvements
- `release-prep` - Pre-release validation

### 3. Command Chaining (Flexible)

```bash
# Build custom workflows
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}" -> "meta:health"
```

**Features**:

- `->` Sequential execution
- `[cmd1, cmd2]` Parallel execution
- `{output}` Data passing
- `?>` Conditional execution

## 📊 Deep Analysis Workflows

### Security-First Approach

```bash
# Chain: Audit → Fix → Verify
/prefix:meta:chain "sec:audit ." -> "fix:security {output}" -> "sec:comply"
```

### Performance Optimization

```bash
# Smart performance improvements
/prefix:flow:smart "Application is slow, especially database queries"
```

### Quality Improvement Sprint

```bash
# Automated 1-week sprint
/prefix:auto:sprint . --duration=1w --focus=quality
```

## 🔧 Manual Control Flow

For granular control, use individual commands:

### Step 1: Analysis

```bash
# Choose your focus
/prefix:scan:deep . --focus=all        # Everything
/prefix:scan:security .                 # Security only
/prefix:scan:perf .                     # Performance
/prefix:scan:quality .                  # Code quality
```

### Step 2: Review & Plan

```bash
# Generate action plan
/prefix:scan:report analysis.json --generate-action-plan

# Or get quick wins only
/prefix:scan:report analysis.json --quick-wins
```

### Step 3: Execute

```bash
# Automated execution
/prefix:auto:execute action-plan.md --mode=auto

# Or supervised mode
/prefix:auto:execute action-plan.md --mode=supervised
```

### Step 4: Verify

```bash
# Check improvements
/prefix:meta:health --compare=before.json
```

## 🎯 Specialized Workflows

### Incident Response

```bash
/prefix:flow:incident "Production API returning 500 errors"
```

### Code Review

```bash
/prefix:flow:review src/ --focus=changes
```

### Refactoring

```bash
/prefix:flow:refactor src/legacy --safety=conservative
```

## 📈 Continuous Improvement

### Set Up Monitoring

```bash
/prefix:auto:monitor . --schedule=daily --auto-fix=safe
```

### Track Progress

```bash
# Weekly health checks
/prefix:meta:chain --schedule="weekly@monday" \
  "meta:health --export" -> \
  "meta:export {output} --template=progress"
```

## 💡 Best Practices

1. **Start with Smart**: Use `/flow:smart` for complex problems
2. **Use Pipelines**: Pre-built pipelines for common tasks
3. **Chain Commands**: Build reusable workflows
4. **Export Results**: Always export for tracking
5. **Verify Changes**: Include verification in chains

## 🔗 Common Patterns

### Before Commit

```bash
/prefix:meta:pipelines quick-quality
```

### Before PR

```bash
/prefix:meta:chain "flow:review ." -> "gen:docs --update" -> "git:commit"
```

### Weekly Maintenance

```bash
/prefix:meta:pipelines continuous-improvement
```

### Emergency Response

```bash
/prefix:flow:incident "describe the issue"
```

## 📚 Next Steps

- See [MIGRATION-GUIDE.md](../archive/MIGRATION-GUIDE.md) for v3.0 changes
- Check [command reference](../../README.md#available-commands) for all commands
- Try `/prefix:flow:smart "help me get started"` for personalized guidance
