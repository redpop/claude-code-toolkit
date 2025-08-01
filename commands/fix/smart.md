---
allowed-tools: Task, Read, Edit, Write, MultiEdit
description: Intelligent fix router that analyzes issues and applies appropriate fixes
argument-hint: <report.json|issue-description> [--mode=safe|aggressive] [--preview]
---

# Smart Fix Command

This command intelligently analyzes issues from reports or descriptions and routes to the appropriate fix strategies. It's your one-stop solution for automated fixes.

## How It Works

1. **Issue Analysis**: Understands the problem from report or description
2. **Fix Selection**: Routes to appropriate fix commands
3. **Safe Execution**: Applies fixes with validation
4. **Progress Tracking**: Reports what was fixed

## Execution

**Input**: $ARGUMENTS

### Phase 1: Issue Analysis

Use Task tool with subagent_type="general-purpose":
"Analyze the input: $ARGUMENTS
If it's a JSON report, extract key issues by category.
If it's a description, identify the problem domain.
Categorize issues as:
- Security vulnerabilities
- Performance bottlenecks
- Code duplication
- Documentation gaps
- Test coverage issues
- Quick wins (easy fixes)
Return structured analysis with fix priorities."

### Phase 2: Fix Routing

Based on analysis, execute appropriate fixes:

**For Security Issues:**
- Use fix:security for vulnerabilities
- Prioritize by severity
- Validate fixes don't break functionality

**For Performance Issues:**
- Use fix:performance for bottlenecks
- Focus on algorithmic improvements
- Measure impact

**For Code Quality:**
- Use fix:duplicates for duplication
- Use fix:quick-wins for easy improvements
- Maintain code style

**For Documentation:**
- Use fix:documentation for missing docs
- Sync with code changes

**For Testing:**
- Use gen:tests for coverage gaps
- Focus on critical paths

### Phase 3: Validation & Report

## Fix Summary

### ✅ Successfully Fixed
- [List of fixed issues with impact]

### ⚠️ Requires Manual Review
- [Issues that need human intervention]

### ❌ Could Not Fix
- [Issues that failed with reasons]

### 📊 Improvement Metrics
- **Before**: [Health score, coverage, etc.]
- **After**: [Updated metrics]
- **Impact**: [Percentage improvements]

## 🎯 Next Steps

Based on what was fixed and what remains:

### 1. **Verify Changes**
```bash
# Run tests to ensure nothing broke
npm test

# Quick scan to verify improvements
/prefix:scan:quick . --compare={before-state}
```

### 2. **Address Remaining Issues**
```bash
# For issues requiring manual intervention
/prefix:flow:smart "{description-of-remaining-issues}"

# For architectural changes
/prefix:flow:refactor . --focus={problem-area}
```

### 3. **Prevent Regressions**
```bash
# Set up continuous monitoring
/prefix:auto:monitor . --watch={fixed-areas}

# Create baseline for tracking
/prefix:scan:quality . --save-baseline
```

## Usage Examples

```bash
# Fix from analysis report
/prefix:fix:smart analysis-report.json

# Fix from description
/prefix:fix:smart "fix security vulnerabilities in auth module"

# Preview mode
/prefix:fix:smart report.json --preview

# Aggressive mode (more fixes, slightly riskier)
/prefix:fix:smart report.json --mode=aggressive
```

## Safety Features

- **Preview Mode**: See what would be changed
- **Incremental Fixes**: Apply one category at a time
- **Validation**: Each fix is tested
- **Rollback**: Can undo if issues arise

## 📤 Fix Report
- **Report saved to**: `fix-summary-{timestamp}.md`
- **Changed files**: Listed in report
- **Backup created**: Before any changes

💡 **Pro tip**: Always use preview mode first for critical codebases. The smart fix command learns from your codebase patterns for better fixes.