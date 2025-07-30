---
description: Chain multiple commands with intelligent data flow and error handling
argument-hint: <command1> [-> command2] [-> command3...] [--stop-on-error] [--parallel]
---

# Command Chaining

Execute multiple commands in sequence with automatic data passing and intelligent error handling.

## Chaining Syntax

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
      "flow:parallel . --export-json" -> \
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

### Quick Quality Fix
```bash
/prefix:meta:chain "flow:parallel ." -> "fix:quick-wins {output}"
```

### Full Analysis Pipeline
```bash
/prefix:meta:chain \
  "scan:deep . --export-all" -> \
  "flow:review {output}" -> \
  "meta:export {outputs} --merge --template=technical"
```

### Automated Improvement
```bash
/prefix:meta:chain \
  "meta:health --export" as health -> \
  "flow:smart 'Improve lowest scoring area from {health}'" -> \
  "meta:health --compare={health}"
```