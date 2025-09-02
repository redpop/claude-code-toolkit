---
allowed-tools: Task, Read
description: Chain commands or execute pre-defined pipelines with intelligent data flow
argument-hint: <pipeline-name | command-chain> [--list] [--save-as=name] [--dry-run]
options:
  --parallel: Execute commands in parallel where possible
  --stop-on-error: Stop chain if any command fails (default: continue on error)
  --help: Show help message with syntax examples and available pipelines
  --list: List all available pre-defined pipelines
  --save-as: Save custom chain as named pipeline for reuse
  --dry-run: Preview execution without running commands
examples:
  - description: Run pre-defined pipeline
    command: /prefix:meta:chain deep-quality
  - description: Sequential execution with output passing
    command: /prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"
  - description: Parallel execution of multiple commands
    command: /prefix:meta:chain ["scan:security .", "scan:quality .", "scan:tests ."] -> "meta:export {outputs} --merge"
  - description: Conditional execution based on results
    command: /prefix:meta:chain "scan:deep ." ?> "fix:all {output}" -> "meta:health"
  - description: Error fallback with recovery command
    command: /prefix:meta:chain "risky:command" !> "fallback:command" -> "continue:normally"
  - description: Stop chain on any error
    command: /prefix:meta:chain --stop-on-error "critical:scan ." -> "deploy:production"
  - description: Save custom pipeline for reuse
    command: /prefix:meta:chain --save-as="my-workflow" "scan:deep ." -> "fix:all" -> "scan:verify"
see-also:
  - meta:pipelines: Discover pre-defined workflow templates
  - auto:execute: Execute analysis reports automatically
  - scan:report: Generate comprehensive analysis reports
  - flow:review: Perform code reviews with recommendations
---

# Command Chaining & Pipelines

Execute commands in sequence, run pre-defined pipelines, or create your own workflows with automatic data passing and intelligent error handling.

```bash
# Help detection
if [[ "$ARGUMENTS" == "--help" ]] || [[ "$ARGUMENTS" == "-h" ]]; then
    echo "Command Chaining & Pipelines"
    echo "=============================="
    echo ""
    echo "USAGE:"
    echo "  /prefix:meta:chain <pipeline-name | command-chain> [options]"
    echo ""
    echo "OPTIONS:"
    echo "  --parallel         Execute commands in parallel where possible"
    echo "  --stop-on-error    Stop chain if any command fails (default: continue on error)"
    echo "  --help             Show this help message"
    echo "  --list             List all available pre-defined pipelines"
    echo "  --save-as=name     Save custom chain as named pipeline for reuse"
    echo "  --dry-run          Preview execution without running commands"
    echo ""
    echo "CHAIN SYNTAX:"
    echo "  ->     Sequential execution (pass output to next command)"
    echo "  ?>     Conditional execution (continue if previous succeeded)"
    echo "  !>     Error fallback (run if previous failed)"
    echo "  [a,b]  Parallel execution (run commands simultaneously)"
    echo ""
    echo "EXAMPLES:"
    echo "  # Run pre-defined pipeline"
    echo "  /prefix:meta:chain deep-quality"
    echo ""
    echo "  # Sequential execution with output passing"
    echo "  /prefix:meta:chain \"scan:deep .\" -> \"fix:quick-wins {output}\""
    echo ""
    echo "  # Parallel execution"
    echo "  /prefix:meta:chain [\"scan:security .\", \"scan:quality .\"] -> \"meta:export {outputs}\""
    echo ""
    echo "  # Conditional execution"
    echo "  /prefix:meta:chain \"scan:deep .\" ?> \"fix:all {output}\" -> \"meta:health\""
    echo ""
    echo "  # Error fallback"
    echo "  /prefix:meta:chain \"risky:command\" !> \"fallback:command\" -> \"continue:normally\""
    echo ""
    echo "AVAILABLE PIPELINES:"
    echo "  quick-quality         Fast quality assessment (~30s)"
    echo "  deep-quality          Comprehensive analysis (~5m)"
    echo "  security-hardening    Security audit and fixes (~10m)"
    echo "  refactoring-sprint    Systematic code improvements (~30m)"
    echo "  release-prep          Release readiness check (~20m)"
    echo "  continuous-improvement Weekly quality improvement (~2h)"
    echo ""
    echo "SEE ALSO:"
    echo "  /prefix:meta:pipelines    Discover workflow templates"
    echo "  /prefix:auto:execute      Execute analysis reports"
    echo "  /prefix:scan:report       Generate analysis reports"
    echo "  /prefix:flow:review       Code review with recommendations"
    exit 0
fi
```

## Quick Start

### Pre-defined Pipelines

Run optimized workflows with a single command:

```bash
# Run a pre-defined pipeline
/prefix:meta:chain deep-quality
/prefix:meta:chain security-hardening
/prefix:meta:chain release-prep

# List all available pipelines
/prefix:meta:chain --list
```

### Custom Command Chains

Create ad-hoc command sequences:

```bash
# Simple chain
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"

# Save as reusable pipeline
/prefix:meta:chain --save-as="my-workflow" "scan:deep ." -> "fix:all"
```

## Intelligent Detection

The command automatically detects what you want:

1. **Pipeline name** (no arrows) → Runs pre-defined pipeline
2. **Chain syntax** (contains `->`) → Creates ad-hoc chain
3. **Pipeline + extension** → Runs pipeline then additional steps

## Pre-defined Pipelines

### 🚀 quick-quality

**Purpose**: Fast quality assessment before commits (~30 seconds)

```bash
/prefix:meta:chain quick-quality
# Executes:
# - scan:quick . --export-json
# - scan:report --latest --quick-wins
```

### 🔍 deep-quality

**Purpose**: Comprehensive analysis with actionable fixes (~5 minutes)

```bash
/prefix:meta:chain deep-quality
# Executes:
# - scan:deep . --export-json
# - scan:report --latest --generate-action-plan  
# - auto:execute --latest --dry-run
```

### 🛡️ security-hardening

**Purpose**: Find and fix security vulnerabilities (~10 minutes)

```bash
/prefix:meta:chain security-hardening
# Executes:
# - sec:audit . --export-json
# - fix:security --latest --severity=critical,high
# - sec:comply . --standard=owasp
```

### 🏗️ refactoring-sprint

**Purpose**: Improve code structure systematically (~30 minutes)

```bash
/prefix:meta:chain refactoring-sprint
# Executes:
# - flow:refactor . --export=refactor-plan.md
# - flow:refactor . --safety=conservative --execute
# - test:run --all
# - scan:quality . --compare=baseline.json
```

### 📈 release-prep

**Purpose**: Ensure code is release-ready (~20 minutes)

```bash
/prefix:meta:chain release-prep
# Executes:
# - scan:deep . --export-all
# - fix:quick-wins analysis.json
# - gen:docs --update-all
# - meta:changelog --update-version
# - meta:health --export=release-health.json
```

### 🔄 continuous-improvement

**Purpose**: Weekly code quality improvement (~2 hours)

```bash
/prefix:meta:chain continuous-improvement
# Executes:
# - scan:quality . --export=week-start.json
# - auto:sprint . --duration=1w --focus=quality
# - scan:quality . --baseline=week-start.json
# - auto:report --compare-baseline
```

## Custom Chaining Syntax

### Sequential Execution

Commands execute one after another, passing data forward:

```bash
/prefix:meta:chain "scan:deep ." -> "scan:report {output} --generate-action-plan" -> "auto:execute {output}"
```

### Parallel Groups

Execute independent commands simultaneously:

```bash
/prefix:meta:chain ["scan:security .", "scan:quality .", "scan:tests ."] -> "meta:export {outputs} --merge"
```

### Conditional Chains

Continue based on previous results:

```bash
/prefix:meta:chain "scan:deep . --export-json" -> "fix:quick-wins {output}" ?> "meta:health"
```

## Data Flow

### Automatic Output Capture

Each command's output is automatically:

1. Captured and stored
2. Made available to next command as `{output}`
3. Accumulated in `{outputs}` array
4. Logged for debugging

### Variable Substitution

- `{output}` - Previous command's output file/data
- `{outputs}` - All previous outputs
- `{output.1}` - Specific command's output by index
- `{timestamp}` - Current timestamp
- `{date}` - Current date

## Error Handling

### Default Behavior

- Log error and continue to next command
- Mark failed commands in final report
- Return partial success status

### Stop on Error

```bash
/prefix:meta:chain --stop-on-error "critical:command" -> "dependent:command"
```

### Error Recovery

```bash
/prefix:meta:chain "risky:command" !> "fallback:command" -> "continue:normally"
```

## Common Patterns

### Analysis → Fix → Verify

```bash
/prefix:meta:chain \
  "scan:deep . --export-json" -> \
  "fix:quick-wins {output}" -> \
  "scan:deep . --compare={output.1}"
```

### Parallel Analysis → Merge

```bash
/prefix:meta:chain \
  ["scan:security .", "scan:quality .", "scan:perf ."] -> \
  "meta:export {outputs} --merge --format=md"
```

### Conditional Improvement

```bash
/prefix:meta:chain \
  "scan:quality . --export" -> \
  "fix:quality {output} --if-score<80" ?> \
  "meta:health --verify"
```

## Advanced Features

### Named Outputs

Assign names to outputs for clarity:

```bash
/prefix:meta:chain \
  "scan:deep . --export-json" as baseline -> \
  "auto:sprint . --week" -> \
  "scan:deep . --compare={baseline}"
```

### Loop Execution

Repeat until condition met:

```bash
/prefix:meta:chain \
  "scan:tests ." -> \
  "gen:tests --coverage-target=90" -> \
  "scan:tests ." \
  --repeat-until="coverage>=90" \
  --max-iterations=5
```

### Scheduled Chains

```bash
/prefix:meta:chain \
  --schedule="daily@09:00" \
  "scan:quality ." -> \
  "meta:export {output} --format=html" -> \
  "notify:slack quality-report"
```

## Integration Examples

### CI/CD Pipeline

```yaml
- name: Quality Gate
  run: |
    /prefix:meta:chain \
      "scan:quick . --export-json" -> \
      "scan:report {output} --threshold=85" \
      --stop-on-error
```

### Git Hooks

```bash
# pre-commit
/prefix:meta:chain \
  "scan:quick . --staged-only" -> \
  "fix:style {files} --auto" \
  --stop-on-error
```

### Development Workflow

```bash
# Before PR
/prefix:meta:chain \
  "flow:review . --focus=changes" -> \
  "gen:docs --update-changed" -> \
  "git:commit --message='Ready for review'"
```

## Execution Report

After chain execution:

```markdown
# Chain Execution Report

**Started**: 2024-01-30 10:00:00
**Completed**: 2024-01-30 10:05:23
**Duration**: 5m 23s

## Command Results

✅ scan:deep . --export-json
Output: analysis-20240130.json
Duration: 45s

✅ fix:quick-wins analysis-20240130.json  
 Fixed: 23 issues
Duration: 2m 10s

✅ scan:deep . --compare=analysis-20240130.json
Improvement: +15 quality points
Duration: 48s

## Summary

- Commands executed: 3/3
- Success rate: 100%
- Total improvement: +15 points
```

## Best Practices

1. **Test First**: Dry-run complex chains
2. **Name Outputs**: Use meaningful names for clarity
3. **Handle Errors**: Plan for failure scenarios
4. **Log Results**: Keep execution history
5. **Modularize**: Create reusable chain templates

## Usage Examples

### Pipeline Operations

```bash
# Run pre-defined pipeline
/prefix:meta:chain deep-quality

# Extend a pipeline
/prefix:meta:chain deep-quality -> "git:commit --message='Quality improvements'"

# Preview pipeline execution
/prefix:meta:chain release-prep --dry-run

# List all pipelines
/prefix:meta:chain --list
```

### Custom Chains

```bash
# Quick quality fix
/prefix:meta:chain "scan:quick ." -> "fix:quick-wins {output}"

# Full analysis pipeline
/prefix:meta:chain \
  "scan:deep . --export-all" -> \
  "flow:review {output}" -> \
  "meta:export {outputs} --merge --template=technical"

# Save custom pipeline
/prefix:meta:chain --save-as="my-analysis" \
  "scan:deep ." -> "fix:all" -> "scan:verify"
```

### Hybrid Usage

```bash
# Start with pipeline, add custom steps
/prefix:meta:chain quick-quality -> "notify:slack 'Quality check complete'"

# Chain multiple pipelines
/prefix:meta:chain security-hardening -> refactoring-sprint
```

## Creating Custom Pipelines

### Save for Reuse

```bash
# Define and save
/prefix:meta:chain --save-as="test-improvement" \
  "scan:tests ." -> \
  "gen:tests --coverage-target=90" -> \
  "scan:tests . --verify"

# Use saved pipeline
/prefix:meta:chain test-improvement
```

### Define with Task Tool

For complex pipelines:

Use Task tool with subagent_type="general-purpose":
"Create a command pipeline for: $ARGUMENTS. Include: 1) Analysis phase, 2) Action phase, 3) Verification phase. Output as chain syntax."

## Integration Examples

### CI/CD

```yaml
# GitHub Actions
- name: Quality Gate
  run: /prefix:meta:chain deep-quality --stop-on-error

- name: Security Check  
  run: /prefix:meta:chain security-hardening
```

### Git Hooks

```bash
# pre-commit
/prefix:meta:chain quick-quality || exit 1

# pre-push
/prefix:meta:chain release-prep --dry-run
```

### Scheduled Tasks

```bash
# Daily quality check (cron)
0 9 * * * /prefix:meta:chain deep-quality

# Weekly improvement
0 9 * * MON /prefix:meta:chain continuous-improvement
```
