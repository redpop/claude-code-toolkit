# Quick Start Guide

Get started with Claude Code Toolkit in minutes! This guide shows the most efficient workflows for common tasks.

## 🎯 The 3-Step Quality Workflow

The most recommended workflow for any project:

```bash
# Step 1: Deep analysis (auto-generates timestamped report)
/prefix:scan:deep . --export-json

# Step 2: Generate action plan from latest report
/prefix:scan:report --latest --generate-action-plan

# Step 3: Execute the improvements
/prefix:auto:execute --latest
```

### What This Does

1. **Deep Scan**: Analyzes your entire codebase with multiple specialized agents
2. **Action Plan**: Creates a prioritized list of improvements with exact fix commands
3. **Execute**: Automatically applies the recommended fixes

## 💡 Key Features

### Automatic File Naming

No need to specify filenames! Commands auto-generate timestamped files:

```bash
--export-json              # Creates: analysis-20250803-143022.json
--export-md                # Creates: report-20250803-143022.md
--generate-action-plan     # Creates: action-plan-20250803-143022.md
```

### The --latest Flag

Automatically finds the most recent report:

```bash
/prefix:scan:report --latest              # Analyzes most recent report
/prefix:fix:quick-wins --latest           # Fixes from latest report
/prefix:auto:execute --latest             # Executes latest action plan
```

## 🚀 Common Workflows

### Quick Morning Check (2 minutes)

```bash
/prefix:scan:quick . --export-json
/prefix:fix:quick-wins --latest
```

### Security Audit (10 minutes)

```bash
/prefix:sec:audit . --export-json
/prefix:fix:security --latest --severity=critical,high
```

### Pre-Commit Quality Check (30 seconds)

```bash
/prefix:meta:pipelines quick-quality
```

### Full Refactoring Sprint (30 minutes)

```bash
/prefix:flow:refactor . --export
/prefix:flow:refactor . --safety=conservative --execute
```

## 📊 Tracking Progress

### Create Baseline

```bash
# Initial scan
/prefix:scan:deep . --export-json
mv analysis-*.json baseline.json
```

### Compare After Changes

```bash
# After improvements
/prefix:scan:deep . --export-json
/prefix:scan:report --latest --compare=baseline.json
```

## 🔗 Command Chaining

Chain commands for automation:

```bash
# Simple chain
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"

# With conditions
/prefix:meta:chain "scan:quick ." -> "fix:quick-wins {output}" ?> "scan:quality . --compare"
```

## 🎮 Smart Problem Solving

Let AI route your problem to the right specialists:

```bash
/prefix:flow:smart "My tests are slow and flaky"
# AI analyzes and delegates to performance-optimizer and test-engineer

/prefix:flow:smart "Need to add authentication to my API"
# Routes to security-specialist and code-architect
```

## 📁 File Organization

Reports are saved in the current directory by default:

```
project/
├── analysis-20250803-143022.json      # From scan:deep
├── action-plan-20250803-143515.md     # From scan:report
├── security-20250803-144021.json      # From sec:audit
└── quick-check-20250803-150132.json   # From scan:quick
```

## 🏃 Next Steps

1. **Install the toolkit**: `./install.sh prefix`
2. **Run your first scan**: `/prefix:scan:deep . --export-json`
3. **Review the report**: `/prefix:scan:report --latest`
4. **Apply improvements**: `/prefix:auto:execute --latest`

## 💬 Getting Help

- **List all commands**: Check the README.md command table
- **Command help**: Each command file contains detailed documentation
- **Workflows guide**: See [MODERN-WORKFLOW.md](MODERN-WORKFLOW.md)
- **Architecture**: See [docs/architecture/](../architecture/)

## 🎯 Pro Tips

1. **Start with quick wins** - They provide immediate value with minimal risk
2. **Use pipelines** for common workflows - They're pre-optimized sequences
3. **Export everything** - JSON reports enable automation and tracking
4. **Chain commands** - Build your own automated workflows
5. **Let AI route** - Use `/flow:smart` when unsure which command to use

Remember: The toolkit is designed to make code improvement effortless. Start with the 3-step workflow and explore from there!
