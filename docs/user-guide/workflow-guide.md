# Claude Code Toolkit - Workflow Guide

This guide shows you how to use the Claude Code Toolkit effectively for different scenarios. Each workflow is designed to guide you step-by-step to achieve specific goals.

## 🎯 Choose Your Workflow Approach

### 1. Smart Problem Solving (Fastest) 🤖

Let AI analyze your problem and automatically route to the right solution:

```bash
/global:flow:smart "describe your problem here"
```

**Best for:**

- Complex, multi-faceted problems
- When you're not sure where to start
- Quick problem resolution
- Incident response

### 2. Pre-Built Pipelines (Structured) 🚀

Use tested workflow sequences for common tasks:

```bash
/global:meta:pipelines [workflow-name]
```

**Available pipelines:**

- `quick-quality` - 30-second pre-commit check
- `deep-quality` - Comprehensive analysis with fixes
- `security-hardening` - Find and fix vulnerabilities
- `refactoring-sprint` - Improve code structure
- `release-prep` - Ensure code is production-ready

### 3. Command Chaining (Flexible) 🔗

Build custom workflows by chaining commands:

```bash
/global:meta:chain "cmd1" -> "cmd2 {output}" -> "cmd3"
```

**Features:**

- Sequential execution with `->`
- Parallel execution with `[cmd1, cmd2]`
- Data passing with `{output}`
- Conditional execution with `?>`

### 4. Manual Control (Granular) 🔧

Execute individual commands for specific tasks:

```bash
/global:scan:deep .
/global:fix:security critical-issues.json
/global:gen:tests uncovered-code.json
```

## 📊 Common Workflows

### 🚦 Before Committing Code

**Goal**: Ensure code quality before committing

#### Quick Check (30 seconds)

```bash
/global:meta:pipelines quick-quality
```

#### Or Manual Steps:

```bash
# 1. Fast analysis
/global:scan:quick . --export-json=pre-commit.json

# 2. Review findings
/global:scan:report pre-commit.json --quick-wins

# 3. Fix if needed
/global:fix:quick-wins pre-commit.json
```

### 🐛 Debugging Performance Issues

**Goal**: Find and fix performance bottlenecks

#### Smart Approach:

```bash
/global:flow:smart "application is slow, especially database queries"
```

#### Or Structured Approach:

```bash
# 1. Performance analysis
/global:scan:perf . --export-json=perf-analysis.json

# 2. Generate optimization plan
/global:scan:report perf-analysis.json --focus=performance

# 3. Apply optimizations
/global:fix:performance perf-analysis.json --target=critical
```

### 🔒 Security Audit & Hardening

**Goal**: Find and fix security vulnerabilities

#### Pipeline Approach:

```bash
/global:meta:pipelines security-hardening
```

#### Or Step-by-Step:

```bash
# 1. Security audit
/global:sec:audit . --export-json=security-audit.json

# 2. Review vulnerabilities
/global:scan:report security-audit.json --severity=critical,high

# 3. Fix critical issues first
/global:fix:security security-audit.json --severity=critical

# 4. Verify compliance
/global:sec:comply . --standard=owasp
```

### 🏗️ Major Refactoring

**Goal**: Safely refactor code with confidence

```bash
# 1. Analyze refactoring opportunities
/global:flow:refactor . --export=refactor-plan.md

# 2. Execute safe refactorings
/global:flow:refactor . --safety=conservative --execute

# 3. Verify no regressions
/global:scan:quality . --compare=baseline.json
```

### 📈 Weekly Quality Improvement

**Goal**: Continuous code quality improvement

```bash
# Run the continuous improvement pipeline
/global:meta:pipelines continuous-improvement

# Or custom weekly workflow:
/global:meta:chain \
  "scan:quality . --baseline" -> \
  "auto:sprint . --duration=1w" -> \
  "scan:quality . --compare-baseline"
```

### 🚨 Incident Response

**Goal**: Quickly diagnose and fix production issues

```bash
# Smart incident response
/global:flow:incident "API returning 500 errors after deployment"

# This will:
# 1. Analyze recent changes
# 2. Check logs and errors
# 3. Identify root cause
# 4. Suggest immediate fixes
# 5. Provide rollback options
```

### 📚 Documentation Update

**Goal**: Keep documentation in sync with code

```bash
# 1. Check documentation health
/global:scan:docs . --export=doc-health.json

# 2. Fix documentation issues
/global:fix:documentation doc-health.json

# 3. Generate missing docs
/global:gen:docs --update-all
```

## 🔄 Working with Results

### Context Preservation

All commands export results that can be used in subsequent commands:

```bash
# Results are automatically saved with timestamps
analysis-20250201-143022.json
action-plan-20250201-143122.md
security-audit-20250201-143222.json

# Use in next command
/global:fix:quick-wins analysis-*.json

# Or reference specific file
/global:scan:report analysis-20250201-143022.json
```

### Comparing Results

Track progress over time:

```bash
# Create baseline
/global:scan:quality . --export=baseline.json

# After improvements
/global:scan:quality . --compare=baseline.json

# View trends
/global:scan:report *.json --trends
```

## 🎯 Next Steps Pattern

Every command provides recommended next steps. Follow the wizard-like guidance:

```markdown
## 🎯 Next Steps

Based on the analysis, I recommend:

1. **Quick Fix** (5 min):
   `/global:fix:quick-wins report.json`

2. **Comprehensive** (30 min):
   `/global:meta:workflow quality-sprint`

3. **Custom Approach**:
   - [ ] Security: `/global:sec:audit`
   - [ ] Performance: `/global:scan:perf`
   - [ ] Tests: `/global:gen:tests`
```

## 💡 Best Practices

### 1. Start with Baselines

```bash
# Before any major work
/global:scan:deep . --export=baseline.json
/global:sec:baseline --save
```

### 2. Use Smart Commands for Complex Problems

```bash
# Instead of figuring out commands yourself
/global:flow:smart "help me improve test coverage to 80%"
```

### 3. Chain Commands for Automation

```bash
# Create reusable workflows
/global:meta:chain \
  "scan:deep ." -> \
  "fix:quick-wins {output}" -> \
  "gen:tests {output}" -> \
  "scan:tests . --verify"
```

### 4. Export Everything

```bash
# Always use --export flags
/global:scan:deep . --export-all
```

### 5. Verify Changes

```bash
# After fixes, always verify
/global:scan:quality . --compare=before.json
```

## 🔗 Advanced Patterns

### Conditional Workflows

```bash
# Only proceed if issues found
/global:meta:chain \
  "scan:security ." ?> \
  "fix:security {output}" ?> \
  "sec:comply --verify"
```

### Parallel Analysis

```bash
# Run multiple scans simultaneously
/global:meta:chain \
  ["scan:security .", "scan:perf .", "scan:tests ."] -> \
  "scan:report {outputs} --unified"
```

### Custom Pipelines

```bash
# Define your own pipeline
/global:meta:chain --save="my-pipeline" \
  "scan:deep . --focus=critical" -> \
  "fix:quick-wins {output}" -> \
  "gen:tests {output}" -> \
  "meta:health --verify"

# Reuse later
/global:meta:pipelines my-pipeline
```

## 📊 Progress Tracking

### Daily Progress

```bash
# Morning check
/global:meta:health --compare=yesterday

# Evening review
/global:auto:report --today
```

### Sprint Progress

```bash
# Start of sprint
/global:auto:sprint . --duration=2w --start

# Daily updates
/global:auto:sprint --status

# Sprint review
/global:auto:sprint --complete
```

## 🆘 When Things Go Wrong

### Rollback Changes

```bash
# If automated fixes cause issues
/global:meta:rollback --to=checkpoint

# Or use git
git stash
git checkout .
```

### Debug Mode

```bash
# Run commands with debug output
/global:scan:deep . --debug --verbose
```

### Get Help

```bash
# Ask for help
/global:flow:smart "help me understand why this command failed"

# Check command documentation
/global:meta:help scan:deep
```

## 📋 Workflow Cheat Sheet

| Goal                 | Command                                  |
| -------------------- | ---------------------------------------- |
| Quick quality check  | `/global:meta:pipelines quick-quality`   |
| Find security issues | `/global:sec:audit .`                    |
| Fix performance      | `/global:flow:smart "app is slow"`       |
| Improve tests        | `/global:gen:tests --coverage-target=80` |
| Refactor safely      | `/global:flow:refactor . --safe`         |
| Update docs          | `/global:fix:documentation`              |
| Full analysis        | `/global:scan:deep .`                    |
| Execute fixes        | `/global:auto:execute plan.md`           |

---

**Remember**: The toolkit is designed to guide you. When in doubt, use:

```bash
/global:flow:smart "what should I do next?"
```
