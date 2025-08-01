# Claude Code Toolkit - Quick Start Guide

## 🚀 In 5 Minutes

Get up and running with the Claude Code Toolkit to improve your code quality instantly.

### Installation

```bash
# Clone the repository
git clone https://github.com/user/claude-code-toolkit.git
cd claude-code-toolkit

# Install with your preferred prefix
./install.sh global
```

The toolkit is now available in Claude Code with your chosen prefix!

### Your First Analysis

#### Option 1: Smart Problem Solving (Recommended)
```bash
# Let AI analyze and solve your problem
/global:flow:smart "my application is running slow"
```

The smart command will:
- Analyze your problem
- Route to appropriate specialists
- Provide targeted solutions

#### Option 2: Pre-Built Workflows
```bash
# Quick quality check (30 seconds)
/global:meta:pipelines quick-quality

# Deep analysis (5 minutes)
/global:meta:pipelines deep-quality

# Security hardening
/global:meta:pipelines security-hardening
```

### The 3-Step Quality Workflow

Transform your code quality in three simple steps:

```bash
# Step 1: Analyze your codebase
/global:scan:deep .

# Step 2: Generate an action plan
/global:scan:report analysis-*.json --generate-action-plan

# Step 3: Execute fixes automatically
/global:auto:execute action-plan-*.md
```

## 📊 What Can It Do?

### Code Analysis
- 🔒 **Security**: Find vulnerabilities, OWASP compliance
- ⚡ **Performance**: Identify bottlenecks, optimize algorithms
- 🏗️ **Architecture**: Detect design issues, coupling problems
- 🧪 **Testing**: Coverage gaps, test quality
- 📚 **Documentation**: Sync issues, missing docs

### Automated Fixes
- Quick wins with high ROI
- Security vulnerability patches
- Performance optimizations
- Code duplication removal
- Documentation updates

### Intelligent Workflows
- Smart problem routing
- Multi-agent coordination
- Progress tracking
- Team task allocation

## 🎯 Common Use Cases

### Before Committing Code
```bash
/global:meta:pipelines quick-quality
```

### After Major Feature Development
```bash
/global:flow:smart "review my new feature implementation"
```

### Weekly Code Quality Check
```bash
/global:meta:pipelines continuous-improvement
```

### Incident Response
```bash
/global:flow:incident "production API returning 500 errors"
```

## 📤 Working with Results

All commands export results for chaining:

```bash
# Results are automatically saved
analysis-20250201-143022.json
action-plan-20250201-143122.md

# Use results in next commands
/global:fix:quick-wins analysis-*.json
/global:scan:report latest.json --compare=baseline.json
```

## 🔗 Command Chaining

Build powerful automated workflows:

```bash
# Simple chain
/global:meta:chain "scan:deep ." -> "fix:quick-wins {output}"

# Complex workflow
/global:meta:chain \
  "scan:security ." -> \
  "fix:security {output}" -> \
  "scan:security . --verify"
```

## 💡 Best Practices

1. **Start with Smart Commands**: Use `/flow:smart` for complex problems
2. **Export Everything**: Always save results for tracking progress
3. **Follow Suggestions**: Commands provide next-step recommendations
4. **Test After Fixes**: Verify improvements with comparison scans
5. **Use Workflows**: Pre-built pipelines save time and ensure consistency

## 🆘 Getting Help

### Within Claude Code
```bash
# Get command help
/global:flow:smart "help me understand this toolkit"

# See all available commands
/global:meta:list-commands
```

### Documentation
- **This Guide**: Quick start and overview
- **[Workflow Guide](workflow-guide.md)**: Detailed workflow documentation
- **[Command Reference](command-reference.md)**: All commands explained
- **[Troubleshooting](troubleshooting.md)**: Common issues and solutions

### Next Steps
1. Try the smart command with a real problem
2. Run a quality check on your project
3. Explore the [workflow guide](workflow-guide.md) for advanced usage

---

**Ready to improve your code?** Start with:
```bash
/global:flow:smart "analyze my project and suggest improvements"
```