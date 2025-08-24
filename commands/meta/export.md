---
description: Unified export management for all analysis results with format conversion
argument-hint: <report-files...> [--format=md|json|html|pdf] [--merge] [--template=name]
---

# Export Manager

Centralized export handling for all toolkit reports with format conversion and templating.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Export Capabilities

### Supported Formats

- **Markdown** (.md) - Human-readable reports
- **JSON** (.json) - Machine-readable data
- **HTML** (.html) - Web-viewable reports
- **PDF** (.pdf) - Shareable documents

### Format Conversion

Convert any analysis output to any format:

```bash
# JSON to Markdown
/prefix:meta:export analysis.json --format=md

# Markdown to HTML
/prefix:meta:export report.md --format=html

# Multiple files to PDF
/prefix:meta:export *.json --format=pdf --merge
```

## Templates

### Built-in Templates

1. **Executive Summary**
   - High-level overview
   - Key metrics only
   - Action items
2. **Technical Report**

   - Detailed findings
   - Code examples
   - Technical recommendations

3. **Progress Report**

   - Baseline comparison
   - Trend analysis
   - Improvement metrics

4. **Compliance Report**
   - Standards compliance
   - Audit trail
   - Remediation status

### Using Templates

```bash
# Executive summary from deep scan
/prefix:meta:export scan-results.json --template=executive --format=pdf

# Technical report with code
/prefix:meta:export analysis.json --template=technical --format=html

# Progress tracking
/prefix:meta:export current.json baseline.json --template=progress --merge
```

## Merge Capabilities

Combine multiple reports into unified output:

```bash
# Merge all JSON reports
/prefix:meta:export reports/*.json --merge --format=md

# Combine different analyses
/prefix:meta:export security.json quality.json perf.json --merge --template=executive
```

## Export Workflow

### Step 1: Gather Reports

Collect all analysis outputs:

```bash
# Run analyses with export
/prefix:scan:deep . --export-json=deep.json
/prefix:scan:quality . --export=quality.json
/prefix:sec:audit . --export-json=security.json
```

### Step 2: Process & Convert

Use Task tool with subagent_type="general-purpose":
"Convert these analysis reports to $FORMAT format: [list of files]. Apply $TEMPLATE template. If merging, consolidate findings by priority and category. Generate professional output suitable for [audience]."

### Step 3: Generate Output

Create formatted report with:

- Consistent styling
- Proper sections
- Visual elements (charts for HTML/PDF)
- Navigation (for HTML)
- Page breaks (for PDF)

## Advanced Features

### Custom Branding

Add your branding to exports:

```bash
/prefix:meta:export report.json --format=html --brand=company-logo.png
```

### Scheduled Exports

Automate regular reporting:

```bash
# Weekly quality report
/prefix:meta:export weekly-*.json --merge --template=progress --format=pdf --output=week-{date}.pdf
```

### Diff Reports

Compare two exports:

```bash
/prefix:meta:export current.json --compare=previous.json --format=md
```

## Integration Examples

### Email Reports

```bash
# Generate and email
/prefix:meta:export analysis.json --format=pdf --output=report.pdf
# Then use your email tool to send report.pdf
```

### Dashboard Integration

```bash
# Export for monitoring dashboards
/prefix:meta:export all-metrics.json --format=json --schema=prometheus
```

### Documentation Sites

```bash
# Generate for static site
/prefix:meta:export *.json --format=md --output-dir=docs/reports/
```

## Output Examples

### Executive Summary (Markdown)

```markdown
# Code Quality Report - Executive Summary

**Date**: 2024-01-30
**Overall Health**: 78/100 ↑

## Key Findings

- 3 critical security issues (fixed)
- Test coverage improved to 82%
- Performance optimized by 35%

## Recommended Actions

1. Address remaining security warnings
2. Increase test coverage to 90%
3. Review architectural debt

[View Full Report](full-report.html)
```

### Progress Report (HTML)

```html
<!DOCTYPE html>
<html>
  <head>
    <title>Progress Report</title>
    <style>
      /* Professional styling */
    </style>
  </head>
  <body>
    <h1>Quality Improvement Progress</h1>
    <canvas id="trend-chart"></canvas>
    <table class="metrics-table">
      <!-- Formatted metrics -->
    </table>
  </body>
</html>
```

## Best Practices

1. **Regular Exports**: Schedule weekly/monthly reports
2. **Version Control**: Store exports with timestamps
3. **Template Choice**: Match template to audience
4. **Format Selection**:
   - JSON for automation
   - Markdown for developers
   - HTML for web viewing
   - PDF for stakeholders

## Usage Patterns

### Daily Standup

```bash
/prefix:meta:export yesterday.json today.json --template=progress --format=md
```

### Sprint Review

```bash
/prefix:meta:export sprint-*.json --merge --template=executive --format=pdf
```

### Annual Audit

```bash
/prefix:meta:export year-*.json --merge --template=compliance --format=pdf --output=audit-2024.pdf
```
