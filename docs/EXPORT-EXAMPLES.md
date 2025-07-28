# Report Export Examples

This document provides practical examples of how to use the report export functionality in Claude Code Toolkit.

## Basic Export Examples

### Markdown Report Export
```bash
# Basic markdown export (default filename with timestamp)
/analyze-deep --export-md

# Custom filename
/analyze-deep --export-md=security-review-2025-01-28.md

# Export to custom directory
/analyze-deep --export-md --export-dir=reports/security/
```

### JSON Data Export
```bash
# Basic JSON export for CI/CD integration
/security-audit --export-json

# Custom filename for automation
/performance-scan --export-json=perf-data-$(date +%Y%m%d).json

# Multiple formats
/analyze-deep --export-md --export-json
```

### All Formats Export
```bash
# Export all available formats
/analyze-deep --export-all

# All formats to custom directory
/test-coverage --export-all --export-dir=audit-reports/
```

## Workflow Integration Examples

### Daily Security Check
```bash
#!/bin/bash
# daily-security-check.sh

echo "Running daily security audit..."
/security-audit --export-md=security-$(date +%Y-%m-%d).md --export-dir=reports/daily/

# Check if critical issues found
if grep -q "Critical:" reports/daily/security-$(date +%Y-%m-%d).md; then
    echo "⚠️  Critical security issues found! Check report."
    # Send notification, create issue, etc.
fi
```

### CI/CD Pipeline Integration
```yaml
# .github/workflows/code-analysis.yml
name: Code Analysis
on: [push, pull_request]

jobs:
  analysis:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run comprehensive analysis
        run: |
          /analyze-deep --export-json=analysis-results.json
          
      - name: Check quality gate
        run: |
          HEALTH_SCORE=$(jq '.summary.health_score' analysis-results.json)
          if (( $(echo "$HEALTH_SCORE < 70" | bc -l) )); then
            echo "❌ Quality gate failed: Health score $HEALTH_SCORE < 70"
            exit 1
          fi
          
      - name: Upload analysis report
        uses: actions/upload-artifact@v3
        with:
          name: analysis-report
          path: analysis-results.json
```

### Team Review Workflow
```bash
#!/bin/bash
# weekly-team-review.sh

WEEK=$(date +%Y-W%U)
REPORT_DIR="reports/weekly/$WEEK"

mkdir -p "$REPORT_DIR"

echo "📊 Generating weekly code analysis for team review..."

# Comprehensive analysis
/analyze-deep --export-all --export-dir="$REPORT_DIR"

# Focused reports
/security-audit --export-md="$REPORT_DIR/security-audit.md"
/performance-scan --export-md="$REPORT_DIR/performance-analysis.md"
/test-coverage --export-json="$REPORT_DIR/test-metrics.json"

echo "✅ Reports generated in $REPORT_DIR"
echo "📧 Sending to team..."

# Email or Slack notification
echo "Weekly code analysis complete. Reports: $REPORT_DIR" | mail -s "Code Analysis $WEEK" team@company.com
```

## Custom Tooling Examples

### Quality Dashboard Script
```javascript
#!/usr/bin/env node
// quality-dashboard.js

const fs = require('fs');
const path = require('path');

// Run analysis and get JSON
const { execSync } = require('child_process');
execSync('/analyze-deep --export-json=current-analysis.json');

// Load results
const analysis = JSON.parse(fs.readFileSync('current-analysis.json'));

// Generate dashboard
console.log(`
📊 CODE QUALITY DASHBOARD
========================

🏥 Health Score: ${analysis.summary.health_score}/100
🐛 Issues: ${analysis.summary.total_issues} total
   - Critical: ${analysis.summary.severity_breakdown.critical}
   - High: ${analysis.summary.severity_breakdown.high}
   - Medium: ${analysis.summary.severity_breakdown.medium}

📈 Metrics:
   - Security: ${analysis.metrics.security_score}/100
   - Performance: ${analysis.metrics.performance_score}/100
   - Test Coverage: ${analysis.metrics.test_coverage}%

🎯 Top Priority Actions:
`);

// Show top 3 critical findings
analysis.findings
  .filter(f => f.severity === 'critical')
  .slice(0, 3)
  .forEach((finding, i) => {
    console.log(`   ${i+1}. ${finding.title} (${finding.file})`);
  });
```

### Report Comparison Tool
```bash
#!/bin/bash
# compare-reports.sh

REPORT1=$1
REPORT2=$2

if [ -z "$REPORT1" ] || [ -z "$REPORT2" ]; then
    echo "Usage: compare-reports.sh <old-report.json> <new-report.json>"
    exit 1
fi

echo "📊 Comparing analysis reports..."

OLD_SCORE=$(jq '.summary.health_score' "$REPORT1")
NEW_SCORE=$(jq '.summary.health_score' "$REPORT2")
OLD_ISSUES=$(jq '.summary.total_issues' "$REPORT1")
NEW_ISSUES=$(jq '.summary.total_issues' "$REPORT2")

SCORE_DIFF=$(echo "$NEW_SCORE - $OLD_SCORE" | bc)
ISSUES_DIFF=$(echo "$NEW_ISSUES - $OLD_ISSUES" | bc)

echo "Health Score: $OLD_SCORE → $NEW_SCORE (${SCORE_DIFF:+$SCORE_DIFF})"
echo "Total Issues: $OLD_ISSUES → $NEW_ISSUES (${ISSUES_DIFF:+$ISSUES_DIFF})"

if (( $(echo "$SCORE_DIFF > 0" | bc -l) )); then
    echo "✅ Code quality improved!"
else
    echo "⚠️  Code quality declined"
fi
```

## Advanced Export Patterns

### Automated Report Archive
```bash
#!/bin/bash
# archive-reports.sh

# Create monthly archive
MONTH=$(date +%Y-%m)
ARCHIVE_DIR="archives/$MONTH"

mkdir -p "$ARCHIVE_DIR"

# Run comprehensive analysis
/analyze-deep --export-all --export-dir="$ARCHIVE_DIR"

# Compress and store
tar -czf "$ARCHIVE_DIR.tar.gz" "$ARCHIVE_DIR"
rm -rf "$ARCHIVE_DIR"

echo "📦 Monthly archive created: $ARCHIVE_DIR.tar.gz"
```

### Multi-Project Analysis
```bash
#!/bin/bash
# multi-project-analysis.sh

PROJECTS=("frontend" "backend" "mobile-app")
TIMESTAMP=$(date +%Y%m%d-%H%M%S)

for project in "${PROJECTS[@]}"; do
    echo "🔍 Analyzing $project..."
    
    cd "$project" || continue
    
    /analyze-deep --export-json="../reports/${project}-${TIMESTAMP}.json"
    
    cd ..
done

echo "📊 Generating combined report..."

# Combine all project reports
node combine-reports.js reports/*-${TIMESTAMP}.json > "combined-analysis-${TIMESTAMP}.json"
```

### Git Hook Integration
```bash
#!/bin/bash
# .git/hooks/pre-push

echo "🔍 Running pre-push analysis..."

# Quick security check
/security-audit --export-json=.tmp-security-check.json

CRITICAL_ISSUES=$(jq '.findings | map(select(.severity == "critical")) | length' .tmp-security-check.json)

if [ "$CRITICAL_ISSUES" -gt 0 ]; then
    echo "❌ PUSH BLOCKED: $CRITICAL_ISSUES critical security issues found"
    echo "Run '/security-audit --export-md' for details"
    rm .tmp-security-check.json
    exit 1
fi

rm .tmp-security-check.json
echo "✅ Security check passed"
```

## Integration with External Tools

### SonarQube Integration
```bash
# Export JSON for SonarQube generic format conversion
/analyze-deep --export-json=claude-analysis.json

# Convert to SonarQube format
node convert-to-sonar.js claude-analysis.json > sonar-issues.json

# Upload to SonarQube
sonar-scanner -Dsonar.externalIssuesReportPaths=sonar-issues.json
```

### Slack Notifications
```bash
#!/bin/bash
# slack-notify.sh

/analyze-deep --export-json=analysis.json

HEALTH_SCORE=$(jq '.summary.health_score' analysis.json)
CRITICAL_ISSUES=$(jq '.summary.severity_breakdown.critical' analysis.json)

WEBHOOK_URL="https://hooks.slack.com/your/webhook/url"

if [ "$CRITICAL_ISSUES" -gt 0 ]; then
    MESSAGE="🚨 Code Analysis Alert: $CRITICAL_ISSUES critical issues found (Health: $HEALTH_SCORE/100)"
    COLOR="danger"
else
    MESSAGE="✅ Code Analysis Complete: Health score $HEALTH_SCORE/100"
    COLOR="good"
fi

curl -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\", \"color\":\"$COLOR\"}" \
    "$WEBHOOK_URL"
```

## Report Storage Strategies

### Time-Based Organization
```
reports/
├── 2025/
│   ├── 01/  # January
│   │   ├── analyze-deep-20250115-143022.md
│   │   └── security-audit-20250120-091234.json
│   └── 02/  # February
└── archives/
    └── 2024-Q4.tar.gz
```

### Project-Based Organization
```
reports/
├── frontend/
│   ├── daily/
│   ├── weekly/
│   └── releases/
├── backend/
│   ├── security/
│   ├── performance/
│   └── coverage/
└── shared/
    └── comparison-reports/
```

These examples show how the report export system can be integrated into various development workflows, from simple local analysis to complex CI/CD pipelines and team collaboration processes.