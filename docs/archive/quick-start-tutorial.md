# Quick Start Tutorial: Claude Code Toolkit

Welcome to the Claude Code Toolkit! This tutorial will walk you through getting started with this powerful set of tools for code analysis, security auditing, and automated improvements. By the end of this tutorial, you'll be analyzing and improving your codebase automatically! 🚀

## 🎯 NEW: Zero-Friction Workflow

The Claude Code Toolkit now features an automated workflow that takes you from analysis to completed fixes in just 3 commands:

```bash
# 1. Analyze your code
/analyze-deep . --export-json

# 2. Generate fix plan  
/analyze-report reports/*.json --generate-action-plan

# 3. Execute fixes
/execute-action-plan reports/action-plan-*.md
```

That's it! The toolkit handles everything else. For details, see our [Automated Workflow Guide](../guides/AUTOMATED-WORKFLOW.md).

## Table of Contents

1. [Prerequisites and Setup Verification](#prerequisites-and-setup-verification)
2. [Installing the Toolkit](#installing-the-toolkit)
3. [Option A: Automated Workflow (Recommended)](#option-a-automated-workflow-recommended)
4. [Option B: Traditional Step-by-Step](#option-b-traditional-step-by-step)
5. [Understanding the Output](#understanding-the-output)
6. [Troubleshooting Common Issues](#troubleshooting-common-issues)
7. [Next Steps](#next-steps)

## Prerequisites and Setup Verification

Before we begin, let's ensure you have everything needed to use the Claude Code Toolkit effectively.

### Required Software

1. **Claude Code (claude.ai/code)** - You need access to Claude Code
2. **Git** - For cloning the repository
3. **Bash shell** - For running the installation script (macOS/Linux have this by default)

### Verify Your Environment

Open your terminal and run these commands:

```bash
# Check if git is installed
git --version
# Expected output: git version 2.x.x

# Check your shell
echo $SHELL
# Expected output: /bin/bash or /bin/zsh (both work)

# Check if you have the Claude directory
ls ~/.claude/
# If this doesn't exist yet, that's okay - we'll create it during installation
```

> **💡 Tip:** If you're on Windows, use Git Bash or WSL (Windows Subsystem for Linux) for the best experience.

## Installing the Toolkit

Let's install the Claude Code Toolkit step by step.

### Step 1: Clone the Repository

First, clone the toolkit repository to your local machine:

```bash
# Navigate to where you keep your projects
cd ~/projects  # Or wherever you prefer

# Clone the repository
git clone https://github.com/yourusername/claude-code-toolkit.git

# Enter the directory
cd claude-code-toolkit
```

### Step 2: Run the Installation Script

Now, let's install the toolkit with a custom prefix. The prefix helps you organize commands if you have multiple toolkit installations.

```bash
# Run the installer with a prefix (I'll use 'tk' for toolkit)
./install.sh tk
```

You'll see output like this:

```
🚀 Claude Code Toolkit Installer
================================

📦 Installing with prefix: tk

Creating directories...
✅ Created ~/.claude/commands/tk/
✅ Created ~/.claude/agents/

Copying commands...
✅ Installed 42 commands

Copying agents...
✅ Installed 7 agents

Installation complete! 🎉

Available commands:
  /tk:analyze:deep - Deep code analysis using hybrid Task Tool + Sub-Agent approach
  /tk:analyze:report - Analyze code quality reports with ROI prioritization
  /tk:fix:quick-wins - Automatically implement high-value, low-effort fixes
  ... (more commands listed)
```

### Step 3: Verify Installation

In Claude Code, test that your commands are available:

1. Open Claude Code (claude.ai/code)
2. Type `/tk:` and you should see autocomplete suggestions
3. Try a simple command like `/tk:help` to see available commands

> **🔧 Troubleshooting:** If commands don't appear, try refreshing Claude Code or check that the installation path `~/.claude/commands/tk/` contains the command files.

## Option A: Automated Workflow (Recommended)

This is the fastest way to improve your codebase. The toolkit will analyze, prioritize, and fix issues automatically.

### Step 1: Run Deep Analysis

Navigate to your project and run the comprehensive analysis:

```bash
# Navigate to your project
cd ~/my-project

# Run deep analysis with all export formats
/tk:analysis:analyze-deep . --export-all
```

This will:

- Scan your entire codebase using 10 parallel agents
- Analyze security, performance, architecture, testing, and more
- Generate reports in JSON, Markdown, and HTML formats
- Take about 30-60 seconds depending on project size

**Expected Output:**

```
⏺ Phase 1: Quick Scan (10 agents working in parallel)...
⏺ Phase 2: Deep Analysis with specialized agents...
⏺ Phase 3: Synthesizing results...

✅ Analysis Complete!
📁 Generated Reports:
- reports/analyze-deep-20250129-103000.md
- reports/analyze-deep-20250129-103000.json
- reports/analyze-deep-20250129-103000.html

Key Findings:
🔴 Critical Issues: 3 (Security vulnerabilities)
🟡 High Priority: 8 (Quick wins available)
🟢 Enhancements: 12 (Long-term improvements)
```

### Step 2: Generate Action Plan

Now let's create an executable action plan from the analysis:

```bash
cd ~/projects/my-node-app
```

### Step 2: Run the Deep Analysis

In Claude Code, use the deep analysis command:

```
/tk:analyze:deep
```

The command will:

1. **Phase 1**: Perform parallel scanning of your codebase
2. **Phase 2**: Delegate findings to specialized AI agents
3. **Phase 3**: Synthesize results into a comprehensive report
4. **Phase 4**: Export the report in multiple formats

### What Happens During Analysis

You'll see progress updates like:

```
🔍 Starting Deep Code Analysis
==============================

📊 Phase 1: Parallel Scanning
-----------------------------
✓ Security scan completed
✓ Performance scan completed
✓ Architecture scan completed
✓ Documentation scan completed

🧠 Phase 2: Expert Analysis
---------------------------
→ Delegating to security-specialist...
→ Delegating to performance-optimizer...
→ Delegating to code-architect...

📝 Phase 3: Synthesis
--------------------
Combining insights from all agents...

📄 Phase 4: Report Generation
-----------------------------
Report saved to: ~/.claude/reports/deep-analysis-2024-01-15-143022.md
```

## Understanding the Output

The deep analysis produces a comprehensive report. Let's break down what you'll find:

### Report Structure

```markdown
# Deep Code Analysis Report

## Executive Summary
- Overall code health score: 78/100
- Critical issues: 2
- High priority issues: 5
- Quick wins identified: 12

## Security Analysis
### Critical Findings
1. SQL Injection vulnerability in user.js:45
   - Risk: Critical
   - Effort: Low
   - ROI: High
   - Fix: Use parameterized queries

### Recommendations
- Implement input validation framework
- Add security headers middleware
- Enable CSRF protection

## Performance Analysis
### Bottlenecks Identified
1. N+1 query problem in posts controller
   - Impact: 3.2s average response time
   - Fix: Add eager loading
   - Expected improvement: 80% reduction

## Architecture Analysis
### Design Patterns
- MVC pattern well implemented
- Service layer could be extracted
- Consider implementing repository pattern

## Quick Wins
1. Add missing indexes (5 min effort, high impact)
2. Enable gzip compression (2 min effort, medium impact)
3. Fix ESLint errors (10 min effort, low impact)
```

### Key Sections Explained

1. **Executive Summary**: Quick overview for decision makers
2. **Security Analysis**: Vulnerabilities ranked by severity
3. **Performance Analysis**: Bottlenecks with measurable impact
4. **Architecture Analysis**: Design improvements and patterns
5. **Quick Wins**: Low-effort, high-impact improvements

> **📊 Pro Tip:** The ROI (Return on Investment) score helps prioritize which issues to tackle first. Focus on High ROI items for maximum impact with minimal effort.

# Generate an action plan with specific fix commands

/tk:analysis:analyze-report reports/analyze-deep-*.json --generate-action-plan

```

This creates a prioritized todo list with:
- Exact fix commands for each issue
- Time estimates for each task
- ROI-based prioritization
- Clear impact descriptions

**Expected Output:**
```

✅ Action Plan Generated!
📄 File: reports/action-plan-20250129-103100.md

Summary:

- Total Tasks: 23
- Estimated Effort: 32h
- Critical Security: 3 tasks (8h)
- Quick Wins: 8 tasks (12h)
- Enhancements: 12 tasks (12h)

Top 3 Priorities:

1. Input Sanitization (3h) - Prevents XSS attacks
2. JSON Validation (2h) - Stops injection attacks
3. Remove Code Duplication (2h) - Saves 140 lines

```

### Step 3: Execute the Action Plan

Now the magic happens - let the toolkit fix the issues:

```bash
# Preview what will be done (dry run)
/tk:workflow:execute-action-plan reports/action-plan-*.md --dry-run

# Execute in supervised mode (recommended for first time)
/tk:workflow:execute-action-plan reports/action-plan-*.md --mode=supervised
```

In supervised mode, you'll see:

```
🔄 Executing: Input Sanitization (3h estimated)
Command: /tk:fix:security --focus="xss,sanitization" --auto-fix
Files to modify: 15 components

Proceed? [Y/n]: Y

✅ Task completed successfully!
- Added DOMPurify to 15 components
- All inputs now sanitized
- XSS vulnerability eliminated

Next task: JSON Validation...
```

### Step 4: View Results

After execution completes, view the comprehensive report:

```bash
/tk:workflow:completion-report
```

**Expected Output:**

```
# Workflow Completion Report

Overall Success Rate: 87%

✅ Completed (20/23):
- All security vulnerabilities fixed
- Test coverage increased from 30% to 55%
- Performance improved by 25%
- Code duplication reduced by 60%

⚠️ Partial (2/23):
- Legacy migration (needs manual intervention)
- Complex refactoring (requires architectural decision)

❌ Failed (1/23):
- Dependency upgrade (version conflict)

Key Metrics:
- Security Score: 45 → 85 (+89%)
- Code Quality: C → A
- Estimated hours saved per month: 15
```

## Option B: Traditional Step-by-Step

If you prefer more control, you can run each phase manually:

After running the deep analysis, use the report analyzer:

```
/tk:analyze:report ~/.claude/reports/deep-analysis-2024-01-15-143022.md
```

### Step 2: Understanding the Analysis

The report analyzer provides:

```markdown
# Report Analysis Summary

## Prioritized Action Plan
### Sprint 1 (This Week)
1. **Fix SQL Injection** (2 hours)
   - Critical security issue
   - Clear implementation path
   - Prevents potential data breach

2. **Add Database Indexes** (30 minutes)
   - 70% query performance improvement
   - Simple ALTER TABLE commands
   - No code changes required

### Sprint 2 (Next Week)
1. **Implement Caching Layer** (1 day)
   - Reduce server load by 40%
   - Use Redis for session management
   - Clear documentation available

## Trend Analysis
Comparing to previous report (if available):
- Security score improved: 65 → 78 (+13)
- New issues introduced: 3
- Issues resolved: 8
- Overall trend: Positive 📈

## Team Recommendations
- Schedule security training for SQL injection prevention
- Add performance testing to CI pipeline
- Consider weekly code quality reviews
```

### Manual Analysis and Fixes

1. **Run targeted analyses:**

   ```bash
   /tk:security:audit . --export-json
   /tk:orchestration:performance-scan .
   /tk:orchestration:test-coverage .
   ```

2. **Analyze reports individually:**

   ```bash
   /tk:analysis:analyze-report security-audit.json --quick-wins
   ```

3. **Apply specific fixes:**

   ```bash
   /tk:fix:security --priority=critical
   /tk:fix:duplicates --threshold=80
   /tk:generate:tests --coverage-target=60
   ```

For detailed manual workflow, see [Comprehensive Workflow Guide](../guides/COMPREHENSIVE-WORKFLOW.md).

Use the quick wins command:

```
/tk:fix:quick-wins --dry-run
```

The `--dry-run` flag shows what would be fixed without making changes:

```
🎯 Quick Wins Analysis
=====================

Found 12 quick wins:

1. **Add missing database indexes**
   - Tables: users, posts, comments
   - Performance gain: ~70% for common queries
   - Auto-fix available: YES

2. **Enable gzip compression**
   - File: server.js
   - Bandwidth savings: ~60%
   - Auto-fix available: YES

3. **Fix ESLint errors**
   - Files: 23 files with auto-fixable issues
   - Code quality improvement
   - Auto-fix available: YES

4. **Add security headers**
   - Missing: X-Frame-Options, X-Content-Type-Options
   - Security score improvement: +5 points
   - Auto-fix available: YES

Total estimated time: 45 minutes
Automated fixes available: 10/12
```

### Step 2: Apply Quick Wins

When you're ready, apply the fixes:

```
/tk:fix:quick-wins --apply
```

The command will:

1. Create backups of modified files
2. Apply automated fixes
3. Run tests (if available)
4. Generate a summary report

Example output:

```
✅ Quick Wins Applied
====================

Files modified: 28
Tests status: All passing ✓
Backup created: ~/.claude/backups/quickwins-2024-01-15-150234/

Changes summary:
- Added 3 database indexes
- Enabled compression middleware
- Fixed 127 ESLint issues
- Added 5 security headers

Next steps:
1. Review changes in your git diff
2. Run your test suite
3. Commit with: git commit -m "🎯 Apply quick wins from code analysis"
```

### Step 3: Verify the Improvements

After applying fixes, run a focused analysis to see the improvements:

```
/tk:analyze:deep --focus security,performance
```

## Troubleshooting Common Issues

### Commands Not Found

**Problem:** `/tk:` commands don't appear in Claude Code

**Solution:**

```bash
# Check installation
ls ~/.claude/commands/tk/

# If empty, reinstall:
cd ~/projects/claude-code-toolkit
./install.sh tk --force
```

### Analysis Takes Too Long

**Problem:** Deep analysis seems stuck

**Solution:**

- For large codebases, use focused analysis:

  ```
  /tk:analyze:deep --focus security --max-files 100
  ```

- Check Claude Code's activity indicator
- Try analyzing a smaller directory first

### Permission Errors

**Problem:** Can't write reports or apply fixes

**Solution:**

```bash
# Check permissions
ls -la ~/.claude/

# Fix permissions if needed
chmod -R 755 ~/.claude/
```

### Incorrect Analysis Results

**Problem:** Analysis seems to miss files or show wrong information

**Solution:**

- Ensure you're in the correct directory
- Check if files are ignored by `.gitignore`
- Try clearing Claude Code's context and rerunning

## Common Questions

### Q: Is it safe to run fixes automatically?

A: Yes! The toolkit has multiple safety measures:

- Always creates git commits before changes
- Runs in dry-run mode by default
- Validates changes don't break tests
- Supports rollback if needed

### Q: How long does the full workflow take?

A: Typically:

- Analysis: 30-60 seconds
- Action plan generation: 5-10 seconds
- Fix execution: 1-4 hours (depending on scope)
- Most quick wins complete in under 5 minutes each

### Q: Can I customize what gets fixed?

A: Absolutely! You can:

- Use `--focus=security` to fix only security issues
- Set `--max-effort=4h` to limit scope
- Run specific fix commands manually
- Edit the action plan before execution

## Next Steps

Congratulations! You've learned the automated workflow. Here's what to explore next:

### 1. Advanced Analysis Commands

Explore specialized analysis commands:

```
/tk:security:audit          # Comprehensive security audit
/tk:performance:scan        # Detailed performance analysis
/tk:architecture:review     # Architecture and design patterns
```

### 2. Workflow Integration

Set up continuous quality monitoring:

```
/tk:workflow:continuous-quality
```

This creates:

- Scheduled analysis runs
- Automated fix policies
- Progress tracking dashboards

### 3. Team Collaboration

Use the sprint planning features:

```
/tk:workflow:quality-sprint --team-size 4 --duration 2-weeks
```

### 4. Custom Commands

Create your own commands:

```
/tk:project:create-command "Analyze React component complexity"
```

### 5. Learn More

- Read the [Modern Workflow Guide](../guides/MODERN-WORKFLOW.md)
- Explore [Sub-Agent Orchestration](../architecture/SUB-AGENT-ORCHESTRATION.md)
- Check out [Security Commands](../../commands/sec/)

### 6. Join the Community

- Star the repository on GitHub
- Report issues or suggest features
- Share your success stories

## Summary

You've learned how to:

- ✅ Install the Claude Code Toolkit
- ✅ Run deep code analysis
- ✅ Understand analysis reports
- ✅ Find and fix quick wins
- ✅ Use the report analyzer for planning

The Claude Code Toolkit is now your powerful ally in maintaining and improving code quality. Start with quick wins, gradually tackle bigger improvements, and watch your codebase transform!

Happy coding! 🚀

---

> **Need Help?** Open an issue on GitHub.
