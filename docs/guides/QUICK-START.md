# Quick Start Guide

Get started with Claude Code Toolkit in 2 minutes.

## Installation

```bash
git clone https://github.com/user/claude-code-toolkit.git
cd claude-code-toolkit
./install.sh myprefix
```

## The 3-Step Workflow

```bash
# 1. Analyze - Auto-generates timestamped report
/myprefix:scan:deep . --export-json

# 2. Plan - Creates prioritized action plan  
/myprefix:scan:report --latest --generate-action-plan

# 3. Execute - Applies improvements
/myprefix:auto:execute --latest
```

That's it! The toolkit handles file naming, report generation, and execution automatically.

## Key Features

### Automatic File Management

| Flag | Creates | Example |
|------|---------|---------|
| `--export-json` | Timestamped JSON | `analysis-20250803-143022.json` |
| `--export-md` | Timestamped Markdown | `report-20250803-143022.md` |
| `--latest` | Uses most recent file | Finds newest report automatically |

### Smart Problem Solving

```bash
# Let AI route your problem to specialists
/myprefix:flow:smart "My tests are slow and flaky"
# → Routes to performance-optimizer and test-engineer

/myprefix:flow:smart "Need to add authentication"  
# → Routes to security-specialist and code-architect
```

## Common Workflows

| Task | Command | Time |
|------|---------|------|
| **Quick Check** | `/myprefix:scan:quick . --export-json` | 30s |
| **Security Audit** | `/myprefix:sec:audit . --export-json` | 5m |
| **Fix Quick Wins** | `/myprefix:fix:quick-wins --latest` | 2m |
| **Pre-Commit** | `/myprefix:meta:pipelines quick-quality` | 30s |
| **Full Analysis** | `/myprefix:meta:pipelines deep-quality` | 10m |

## Command Chaining

```bash
# Simple chain
/myprefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"

# With verification
/myprefix:meta:chain "scan:quick ." -> "fix:quick-wins {output}" -> "scan:quick . --verify"
```

## Tracking Progress

```bash
# Create baseline
/myprefix:scan:deep . --export-json
mv analysis-*.json baseline.json

# Compare after changes
/myprefix:scan:deep . --export-json
/myprefix:scan:report --latest --compare=baseline.json
```

## Pro Tips

1. **Start with quick wins** - High ROI, low risk
2. **Use `--latest`** - No need to track filenames
3. **Export everything** - Enables automation
4. **Try `/flow:smart`** - When unsure what to do

## Next Steps

- **List commands**: See [Command Reference](../../README.md#available-commands)
- **Advanced workflows**: See [ADVANCED-WORKFLOWS.md](ADVANCED-WORKFLOWS.md)
- **CI/CD setup**: See [AUTOMATED-WORKFLOW.md](AUTOMATED-WORKFLOW.md)