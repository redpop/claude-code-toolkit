# Report Analyzer Examples

This document provides practical examples of using the Report Analyzer agent and commands.

## Quick Start

### Basic Report Analysis
```bash
# Analyze a single report
/analyze-report reports/analyze-deep-20250128.json

# Focus on quick wins only
/analyze-report report.json --quick-wins

# Export analysis as markdown
/analyze-report report.json --export-md=analysis-summary.md
```

### Report Comparison
```bash
# Compare two reports
/analyze-report current.json --compare=previous.json

# Compare multiple reports with trend analysis
/analyze-report reports/*.json --trends
```

## Real-World Scenarios

### 1. Daily Standup Report
```bash
#!/bin/bash
# daily-standup.sh - Generate progress report for standup

YESTERDAY=$(date -d "yesterday" +%Y%m%d)
TODAY=$(date +%Y%m%d)

# Run analysis and compare
/analyze-report \
  reports/analyze-deep-${TODAY}*.json \
  --compare=reports/analyze-deep-${YESTERDAY}*.json \
  --export-md=standup-report.md

# Extract key metrics
echo "📊 Daily Progress Update:"
echo "========================"
jq -r '.summary | "Health Score: \(.health_score) (\(.health_change))"' standup-report.json
jq -r '.resolved_issues | "✅ Issues Fixed: \(length)"' standup-report.json
jq -r '.new_issues | "🆕 New Issues: \(length)"' standup-report.json
```

### 2. Sprint Planning
```bash
# sprint-planning.sh - Generate sprint backlog from quick wins

# Analyze latest report for quick wins
/analyze-report latest-report.json --quick-wins --export-json=quick-wins.json

# Convert to story points
jq -r '.quick_wins[] | 
  "[\(.severity | ascii_upcase)] \(.title)",
  "  Effort: \(.estimated_effort)",
  "  Impact: \(.impact)",
  "  ROI: \(.roi_score)",
  ""' quick-wins.json > sprint-backlog.txt

# Calculate sprint capacity
TOTAL_HOURS=$(jq '[.quick_wins[].effort_hours] | add' quick-wins.json)
echo "Total Quick Wins Effort: ${TOTAL_HOURS} hours"
```

### 3. Weekly Team Review
```bash
# weekly-review.sh - Comprehensive weekly analysis

WEEK=$(date +%Y-W%U)

# Collect all reports from this week
/analyze-report reports/*-$(date +%Y%m)*.json \
  --trends \
  --export-all \
  --export-dir=weekly-reviews/$WEEK/

# Generate executive summary
cat > weekly-reviews/$WEEK/executive-summary.md << EOF
# Weekly Code Quality Review - $WEEK

## Key Metrics
$(jq -r '.metrics | to_entries[] | "- \(.key): \(.value)"' weekly-reviews/$WEEK/*.json)

## Top Achievements
$(jq -r '.improvements[:3][] | "- \(.title) (\(.impact))"' weekly-reviews/$WEEK/*.json)

## Focus Areas for Next Week
$(jq -r '.recommendations[:5][] | "- \(.action) (ROI: \(.roi_score))"' weekly-reviews/$WEEK/*.json)
EOF
```

### 4. Quality Gate Check
```bash
# quality-gate.sh - CI/CD quality gate

# Run analysis
/analyze-deep --export-json=current-analysis.json

# Analyze against baseline
/analyze-report current-analysis.json \
  --compare=baseline-analysis.json \
  --export-json=gate-result.json

# Check quality gates
HEALTH_SCORE=$(jq '.summary.health_score' gate-result.json)
REGRESSION=$(jq '.regression_detected' gate-result.json)
CRITICAL_ISSUES=$(jq '.summary.severity_breakdown.critical' gate-result.json)

if [ "$REGRESSION" = "true" ]; then
    echo "❌ Quality Gate FAILED: Regression detected"
    exit 1
fi

if [ "$CRITICAL_ISSUES" -gt 0 ]; then
    echo "❌ Quality Gate FAILED: $CRITICAL_ISSUES critical issues"
    exit 1
fi

if [ "$HEALTH_SCORE" -lt 70 ]; then
    echo "❌ Quality Gate FAILED: Health score $HEALTH_SCORE < 70"
    exit 1
fi

echo "✅ Quality Gate PASSED"
```

### 5. ROI-Based Prioritization
```bash
# roi-prioritization.sh - Generate work items by ROI

/analyze-report latest-report.json --export-json=analysis.json

# Extract and sort by ROI
jq -r '.findings[] | 
  select(.roi_score > 5) | 
  {
    roi: .roi_score,
    title: .title,
    effort: .estimated_effort,
    impact: .impact,
    file: .file
  }' analysis.json | \
jq -s 'sort_by(.roi) | reverse[] | 
  "ROI: \(.roi) - \(.title)",
  "  File: \(.file)",
  "  Effort: \(.effort) | Impact: \(.impact)",
  ""'
```

### 6. Historical Trend Analysis
```bash
# trend-analysis.sh - Analyze long-term trends

# Use the trend analyzer script
./scripts/trend-analyzer.sh reports/*.json

# Or use the command with history
/analyze-report --history --trends --export-md=trend-report.md

# Generate trend chart
jq -r '.historical_data | 
  map("\(.date): \(.health_score)") | 
  join("\n")' trend-report.json | \
gnuplot -e "set terminal dumb; plot '-' with lines"
```

## Advanced Usage

### Multi-Project Portfolio Analysis
```bash
# portfolio-analysis.sh - Analyze multiple projects

PROJECTS=("frontend" "backend" "mobile" "shared")

for project in "${PROJECTS[@]}"; do
    echo "Analyzing $project..."
    /analyze-report $project/reports/latest.json \
      --export-json=portfolio/$project-analysis.json
done

# Aggregate results
jq -s '
  {
    portfolio_health: (map(.summary.health_score) | add / length),
    total_issues: (map(.summary.total_issues) | add),
    projects: map({
      name: .metadata.project,
      health: .summary.health_score,
      critical_issues: .summary.severity_breakdown.critical
    })
  }' portfolio/*-analysis.json > portfolio-summary.json

# Generate dashboard
echo "📊 Portfolio Health Dashboard"
echo "============================"
jq -r '.projects[] | "\(.name): \(.health)/100 (\(.critical_issues) critical)"' portfolio-summary.json
```

### Anomaly Detection
```bash
# anomaly-detection.sh - Detect unusual changes

/analyze-report latest.json --compare=previous.json --export-json=comparison.json

# Check for anomalies
jq -r '
  if .metrics.health_score_delta < -10 then
    "⚠️ ANOMALY: Health score dropped by \(.metrics.health_score_delta) points!"
  else empty end,
  
  if .new_critical_issues > 3 then
    "⚠️ ANOMALY: \(.new_critical_issues) new critical issues detected!"
  else empty end,
  
  if .metrics.test_coverage_delta < -5 then
    "⚠️ ANOMALY: Test coverage dropped by \(.metrics.test_coverage_delta)%!"
  else empty end
' comparison.json
```

### Team Performance Metrics
```bash
# team-metrics.sh - Track team improvement velocity

# Analyze last 30 days
/analyze-report --history --days=30 --export-json=team-metrics.json

# Calculate metrics
jq -r '
  {
    velocity: .average_issues_fixed_per_week,
    improvement_rate: .health_score_improvement_per_week,
    estimated_weeks_to_target: .weeks_to_80_score,
    top_contributors: .contributors[:3]
  }' team-metrics.json
```

## Integration Patterns

### GitHub Actions
```yaml
name: Code Quality Analysis
on: [push, pull_request]

jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run deep analysis
        run: /analyze-deep --export-json=report.json
        
      - name: Analyze report
        run: |
          /analyze-report report.json \
            --compare=.baseline/report.json \
            --export-json=analysis.json
          
      - name: Comment on PR
        if: github.event_name == 'pull_request'
        run: |
          SUMMARY=$(jq -r '.summary_markdown' analysis.json)
          gh pr comment ${{ github.event.pull_request.number }} \
            --body "$SUMMARY"
```

### Slack Integration
```bash
#!/bin/bash
# slack-report.sh - Send analysis to Slack

/analyze-report latest.json --quick-wins --export-json=analysis.json

# Format for Slack
HEALTH=$(jq '.summary.health_score' analysis.json)
QUICK_WINS=$(jq '.quick_wins | length' analysis.json)
TOP_ISSUE=$(jq -r '.quick_wins[0] | "\\(.title) (\\(.estimated_effort))"' analysis.json)

curl -X POST -H 'Content-type: application/json' \
  --data '{
    "text": "📊 Code Quality Update",
    "blocks": [
      {
        "type": "section",
        "text": {
          "type": "mrkdwn",
          "text": "*Health Score:* '"$HEALTH"'/100\\n*Quick Wins Available:* '"$QUICK_WINS"'\\n*Top Priority:* '"$TOP_ISSUE"'"
        }
      }
    ]
  }' \
  $SLACK_WEBHOOK_URL
```

These examples demonstrate how the Report Analyzer can be integrated into various development workflows, from daily standups to CI/CD pipelines and team performance tracking.