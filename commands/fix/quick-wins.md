---
allowed-tools: Task, Read, Edit, MultiEdit, Grep, Bash(npm:*), Bash(yarn:*), Bash(git:*)
description: Apply high-ROI fixes from analysis reports - quick wins with maximum impact and minimal effort
argument-hint: [report.json] [--dry-run] [--category=security|performance|quality] [--max-effort=4h] [--min-roi=5] [--help]
options:
  --dry-run: Preview changes without applying them - shows what would be fixed
  --category: Filter fixes by category (security, performance, quality)
  --max-effort: Maximum effort threshold in hours (default: 4h)
  --min-roi: Minimum ROI score threshold (default: 5)
  --help: Show this help message
examples:
  - "/prefix:fix:quick-wins report.json --dry-run" - Preview all quick wins
  - "/prefix:fix:quick-wins report.json --category=security" - Apply only security fixes
  - "/prefix:fix:quick-wins report.json --max-effort=2h --min-roi=8" - High-ROI, low-effort fixes
  - "/prefix:fix:quick-wins --latest --dry-run" - Preview fixes from latest report
see-also:
  - /prefix:scan:deep - Generate comprehensive analysis reports
  - /prefix:scan:report - Analyze and summarize findings
  - /prefix:fix:security - Apply security-focused fixes
  - /prefix:verify:fixes - Validate applied fixes
---

# Fix Quick Wins Command

**Check for help request**

```bash
if [[ "$ARGUMENTS" == *"--help"* ]]; then
    echo "# Fix Quick Wins Help"
    echo ""
    echo "Apply high-ROI fixes from analysis reports - quick wins with maximum impact and minimal effort."
    echo ""
    echo "## Usage:"
    echo "  /prefix:fix:quick-wins [report.json] [options]"
    echo ""
    echo "## Options:"
    echo "  --dry-run             Preview changes without applying them"
    echo "  --category=TYPE       Filter by fix category (security|performance|quality)"
    echo "  --max-effort=HOURS    Maximum effort threshold (default: 4h)"
    echo "  --min-roi=SCORE       Minimum ROI score threshold (default: 5)"
    echo "  --help                Show this help message"
    echo ""
    echo "## Examples:"
    echo "  /prefix:fix:quick-wins report.json --dry-run"
    echo "  /prefix:fix:quick-wins report.json --category=security"
    echo "  /prefix:fix:quick-wins report.json --max-effort=2h --min-roi=8"
    echo "  /prefix:fix:quick-wins --latest --dry-run"
    echo ""
    echo "## See Also:"
    echo "  /prefix:scan:deep     - Generate comprehensive analysis reports"
    echo "  /prefix:scan:report   - Analyze and summarize findings"
    echo "  /prefix:fix:security  - Apply security-focused fixes"
    echo "  /prefix:verify:fixes  - Validate applied fixes"
    exit 0
fi
```

This command automatically applies high-ROI (Return on Investment) fixes identified in analysis reports. It focuses on issues that can be resolved quickly (< 4 hours) while providing significant impact.

## Usage Examples

```bash
# Preview all quick wins without applying
/fix-quick-wins report.json --dry-run

# Apply all quick wins
/fix-quick-wins report.json

# Fix only security quick wins
/fix-quick-wins report.json --category=security

# Fix issues taking less than 2 hours
/fix-quick-wins report.json --max-effort=2h

# Only fix issues with ROI > 8
/fix-quick-wins report.json --min-roi=8
```

## Workflow

### Phase 1: Load and Analyze Report

1. **Load Report**:
   - Parse the JSON report file
   - Validate report structure and version
   - Extract findings and metrics

2. **Calculate ROI Scores**:

   ```
   ROI = (Impact × 10) / Effort_Hours
   
   Where:
   - Impact = Severity_Weight × Scope × Business_Value
   - Effort_Hours = Estimated fix time
   ```

3. **Filter Quick Wins**:
   - Effort < max-effort (default: 4 hours)
   - ROI > min-roi (default: 5)
   - Category matches filter (if specified)
   - Has automated fix available

### Phase 2: Prepare Fix Plan

1. **Group Related Fixes**:
   - Identify fixes in same file/module
   - Order by dependencies
   - Batch for efficiency

2. **Safety Checks**:
   - Verify files exist and are readable
   - Check for uncommitted changes
   - Validate fix compatibility
   - Create backup branch

3. **Generate Fix Summary**:

   ```markdown
   ## Quick Wins Fix Plan
   
   **Issues to Fix**: 12
   **Total Effort**: 8.5 hours
   **Average ROI**: 7.2
   
   ### Fixes by Category:
   - Security: 3 issues (2.5h)
   - Performance: 5 issues (3h)
   - Code Quality: 4 issues (3h)
   ```

### Phase 3: Apply Fixes (if not dry-run)

For each quick win issue:

1. **Security Fixes**:
   - Input validation additions
   - SQL injection prevention
   - XSS protection
   - Authentication checks
   - Basic encryption

2. **Performance Fixes**:
   - Remove N+1 queries
   - Add missing indexes
   - Implement caching
   - Optimize loops
   - Reduce bundle size

3. **Code Quality Fixes**:
   - Remove dead code
   - Fix linting errors
   - Add missing types
   - Simplify complex conditions
   - Extract magic numbers

### Phase 4: Verification

1. **Run Tests**:

   ```bash
   npm test  # or appropriate test command
   ```

2. **Check Linting**:

   ```bash
   npm run lint
   ```

3. **Validate Fixes**:
   - Ensure issues are resolved
   - No new issues introduced
   - Performance not degraded

### Phase 5: Report Results

Generate fix summary:

```markdown
## Quick Wins Fix Results

✅ **Successfully Fixed**: 10/12 issues
⏭️ **Skipped**: 2 issues (conflicts detected)

### Fixed Issues:
1. ✅ [SECURITY] Added input validation to user form (ROI: 9.2)
2. ✅ [PERF] Removed N+1 query in dashboard (ROI: 8.5)
3. ✅ [QUALITY] Extracted constants from calculations (ROI: 6.1)
...

### Skipped Issues:
1. ⏭️ [PERF] Database optimization - requires migration
2. ⏭️ [SECURITY] Auth refactor - too complex for quick win

### Metrics Impact:
- Health Score: 72 → 78 (+6)
- Security Score: 85 → 92 (+7)
- Performance: Improved by ~25%

### Next Steps:
- Run full test suite
- Review changes: `git diff`
- Commit: `git commit -m "fix: apply quick wins from analysis"`
```

## Fix Categories

### Security Quick Wins

- Missing input validation
- Basic SQL injection prevention
- XSS protection gaps
- Missing CSRF tokens
- Insecure defaults
- Exposed sensitive data

### Performance Quick Wins

- N+1 query problems
- Missing database indexes
- Unnecessary re-renders
- Large bundle imports
- Synchronous operations
- Memory leaks

### Code Quality Quick Wins

- Dead code removal
- Linting violations
- Missing type annotations
- Complex conditionals
- Code duplication
- Magic numbers/strings

## Safety Features

1. **Dry Run Mode**:
   - Shows what would be fixed
   - No actual changes made
   - Estimates impact

2. **Backup Creation**:
   - Creates git branch before fixes
   - Easy rollback if needed
   - Preserves original state

3. **Incremental Application**:
   - Fix one issue at a time
   - Test after each fix
   - Stop on first failure

4. **Conflict Detection**:
   - Skip fixes with conflicts
   - Report skipped issues
   - Suggest manual resolution

## Configuration

Default thresholds:

- Max effort: 4 hours
- Min ROI: 5
- Categories: all
- Test command: auto-detected
- Backup branch: `quick-wins-backup-{timestamp}`

## Integration

Works seamlessly with:

- `/analyze-deep` - Generate reports
- `/analyze-report` - Identify quick wins
- `/verify-fixes` - Validate changes
- `/git-commit` - Commit fixes

This command transforms identified issues into immediate improvements, focusing on maximum value with minimum effort.
