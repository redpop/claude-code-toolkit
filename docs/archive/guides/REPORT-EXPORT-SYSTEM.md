# Report & Export System

Complete guide to exporting, analyzing, and processing toolkit reports.

## Export Options

### Automatic File Naming

All export flags auto-generate timestamped filenames:

| Flag | Format | Example Output |
|------|--------|----------------|
| `--export-json` | JSON | `analysis-20250803-143022.json` |
| `--export-md` | Markdown | `report-20250803-143022.md` |
| `--export-all` | Both | Both JSON and MD files |
| `--export-json=file.json` | JSON | `file.json` (custom name) |

### The --latest Flag

Automatically uses the most recent file:

```bash
/prefix:scan:report --latest           # Uses newest JSON report
/prefix:fix:quick-wins --latest        # Applies fixes from latest
/prefix:auto:execute --latest          # Executes latest action plan
```

## Report Formats

### JSON Structure

```json
{
  "timestamp": "2025-08-03T14:30:22Z",
  "command": "scan:deep",
  "target": ".",
  "summary": {
    "files_analyzed": 847,
    "issues_found": 234,
    "critical": 5,
    "high": 28,
    "medium": 89,
    "low": 112
  },
  "results": [
    {
      "file": "src/api.js",
      "line": 42,
      "type": "security",
      "severity": "critical",
      "message": "SQL injection vulnerability",
      "fix": "Use parameterized queries",
      "effort_hours": 0.5,
      "impact": 9,
      "roi": 180
    }
  ],
  "metrics": {
    "execution_time": "6.2s",
    "tokens_used": 28450,
    "agents_deployed": 10
  }
}
```

### Markdown Format

```markdown
# Analysis Report

**Date**: 2025-08-03 14:30:22
**Target**: .
**Command**: scan:deep

## Summary

- Files Analyzed: 847
- Issues Found: 234
- Critical: 5
- High: 28

## Critical Issues

### 1. SQL Injection (src/api.js:42)
**Severity**: Critical
**Impact**: 9/10
**Effort**: 30 minutes
**ROI**: 180

Fix: Use parameterized queries
```

## Report Analysis

### Generate Action Plans

```bash
# From latest report
/prefix:scan:report --latest --generate-action-plan

# From specific file
/prefix:scan:report analysis.json --generate-action-plan

# With team assignments
/prefix:scan:report analysis.json --generate-action-plan --team-mode
```

### Compare Reports

```bash
# Compare with baseline
/prefix:scan:report current.json --compare=baseline.json

# Output shows:
# Security Score: 42 → 78 (+86%)
# Performance: 3.8s → 1.6s (-58%)
# Test Coverage: 23% → 51% (+122%)
```

### Filter & Focus

```bash
# Quick wins only (ROI > 8)
/prefix:scan:report report.json --quick-wins

# Critical issues only
/prefix:scan:report report.json --severity=critical

# Specific categories
/prefix:scan:report report.json --category=security,performance

# Maximum effort threshold
/prefix:scan:report report.json --max-effort=4h
```

## CI/CD Integration

### JSON for Automation

```bash
# Parse with jq
CRITICAL_COUNT=$(jq '.summary.critical' report.json)
if [ "$CRITICAL_COUNT" -gt 0 ]; then
  exit 1
fi

# Extract specific data
jq '.results[] | select(.severity=="critical")' report.json

# Generate metrics
jq '.metrics' report.json > metrics.json
```

### Quality Gates

```bash
# Exit codes based on severity
/prefix:scan:report report.json --fail-on-critical  # Exit 1 if critical
/prefix:scan:report report.json --fail-on-high      # Exit 1 if high+
/prefix:scan:report report.json --fail-on-regression # Exit 1 if worse
```

## Advanced Examples

### Multi-Project Reporting

```bash
# Analyze multiple projects
for project in frontend backend mobile; do
  /prefix:scan:deep $project --export-json=${project}.json
done

# Combine reports
/prefix:scan:report frontend.json backend.json mobile.json \
  --export-md=combined-report.md
```

### Trend Analysis

```bash
# Weekly reports
for week in {1..4}; do
  /prefix:scan:deep . --export-json=week${week}.json
  sleep 604800  # Wait 1 week
done

# Generate trend report
/prefix:scan:report week*.json --trend-analysis --export-md=trends.md
```

### Custom Templates

Create `.claude-templates/report.md`:

```markdown
# {{project_name}} Quality Report

Generated: {{timestamp}}

## Key Metrics
- Quality Score: {{quality_score}}/100
- Technical Debt: {{tech_debt_hours}}h
- ROI if Fixed: {{total_roi}}

## Top Issues
{{#each top_issues}}
- {{this.message}} ({{this.file}}:{{this.line}})
{{/each}}
```

Use template:

```bash
/prefix:scan:report report.json --template=report.md
```

## Export Best Practices

1. **Always export JSON** for automation and tracking
2. **Use --latest** to avoid filename tracking
3. **Create baselines** for comparison
4. **Archive reports** for trend analysis
5. **Use custom names** for specific workflows

## Related Documentation

- [QUICK-START.md](QUICK-START.md) - Basic usage
- [AUTOMATED-WORKFLOW.md](AUTOMATED-WORKFLOW.md) - CI/CD integration
- [REPORT-ANALYZER-EXAMPLES.md](REPORT-ANALYZER-EXAMPLES.md) - Analysis examples
