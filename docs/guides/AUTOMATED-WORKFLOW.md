# Automated Workflow & CI/CD Integration

Integrate Claude Code Toolkit into your CI/CD pipeline and automation workflows.

## GitHub Actions

### Basic Quality Check

```yaml
name: Code Quality
on: [push, pull_request]

jobs:
  quality:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Run Analysis
        run: |
          /prefix:scan:deep . --export-json=report.json
          
      - name: Check Quality Gate
        run: |
          /prefix:scan:report report.json --fail-on-critical
          
      - name: Upload Report
        uses: actions/upload-artifact@v3
        with:
          name: quality-report
          path: report.json
```

### Automated Fix Pipeline

```yaml
name: Auto-Fix
on:
  schedule:
    - cron: '0 2 * * 1'  # Weekly on Monday

jobs:
  auto-fix:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Deep Analysis
        run: /prefix:scan:deep . --export-json
        
      - name: Generate Action Plan
        run: /prefix:scan:report --latest --generate-action-plan
        
      - name: Execute Fixes
        run: /prefix:auto:execute --latest --mode=auto --focus=quick-wins
        
      - name: Create PR
        uses: peter-evans/create-pull-request@v5
        with:
          title: "🤖 Automated Quick Wins"
          body: "Applied high-ROI improvements from toolkit analysis"
          branch: auto-fixes
```

## GitLab CI

```yaml
stages:
  - analyze
  - fix
  - verify

analyze:
  stage: analyze
  script:
    - /prefix:scan:deep . --export-json=analysis.json
    - /prefix:scan:report analysis.json --generate-action-plan
  artifacts:
    paths:
      - analysis.json
      - action-plan-*.md

fix:
  stage: fix
  script:
    - /prefix:auto:execute --latest --mode=auto --max-effort=2h
  only:
    - develop

verify:
  stage: verify
  script:
    - /prefix:scan:quick . --export-json=verify.json
    - /prefix:scan:report verify.json --compare=analysis.json
```

## Jenkins Pipeline

```groovy
pipeline {
    agent any
    
    stages {
        stage('Analysis') {
            steps {
                sh '/prefix:scan:deep . --export-json'
                sh '/prefix:scan:report --latest --generate-action-plan'
            }
        }
        
        stage('Quality Gate') {
            steps {
                script {
                    def result = sh(
                        script: '/prefix:scan:report --latest --check-quality',
                        returnStatus: true
                    )
                    if (result != 0) {
                        error "Quality gate failed"
                    }
                }
            }
        }
        
        stage('Fix') {
            when {
                branch 'develop'
            }
            steps {
                sh '/prefix:auto:execute --latest --mode=auto --focus=safe'
            }
        }
    }
    
    post {
        always {
            archiveArtifacts artifacts: '*.json, *.md'
        }
    }
}
```

## Quality Gates

### Exit Codes

| Code | Meaning | Use in CI |
|------|---------|-----------|
| 0 | Success, no critical issues | Continue pipeline |
| 1 | Critical issues found | Block deployment |
| 2 | High issues found | Warning, allow continue |
| 3 | Medium/low issues only | Info only |

### Fail Conditions

```bash
# Fail on critical security issues
/prefix:sec:audit . --fail-on-critical

# Fail if coverage drops
/prefix:test:coverage . --min=80 --fail-on-decrease

# Fail if performance degrades
/prefix:scan:perf . --fail-on-regression
```

## Scheduled Automation

### Daily Quality Check

```bash
# crontab entry
0 9 * * * cd /project && /prefix:scan:quick . --export-json=daily-$(date +\%Y\%m\%d).json
```

### Weekly Deep Analysis

```bash
# weekly-analysis.sh
#!/bin/bash
set -e

# Run analysis
/prefix:scan:deep . --export-json

# Generate report
/prefix:scan:report --latest --generate-action-plan

# Execute safe fixes
/prefix:auto:execute --latest --mode=auto --focus=safe

# Send notification
/prefix:scan:report --latest --format=summary | mail -s "Weekly Code Quality Report" team@company.com
```

## Docker Integration

```dockerfile
FROM node:18

# Install toolkit
RUN git clone https://github.com/user/claude-code-toolkit.git /toolkit
RUN cd /toolkit && ./install.sh ci

# Run analysis as part of build
RUN /ci:scan:deep /app --export-json=/reports/analysis.json
RUN /ci:scan:report /reports/analysis.json --fail-on-critical

# Continue with build...
```

## Execution Modes for CI

| Mode | Safety | Speed | Use Case |
|------|--------|-------|----------|
| `--mode=auto` | Low | Fast | Trusted branches |
| `--mode=dry-run` | High | Fast | PR validation |
| `--focus=safe` | High | Medium | Auto-merge allowed |
| `--focus=critical` | Medium | Fast | Hotfix branches |

## Monitoring & Alerts

### Slack Integration

```bash
#!/bin/bash
# Send results to Slack
REPORT=$(/prefix:scan:report --latest --format=summary)
curl -X POST -H 'Content-type: application/json' \
  --data "{\"text\":\"Code Quality Report:\n$REPORT\"}" \
  $SLACK_WEBHOOK_URL
```

### Metrics Collection

```bash
# Export metrics for monitoring
/prefix:scan:deep . --export-json=metrics.json
/prefix:meta:export metrics.json --format=prometheus > /metrics/code_quality.prom
```

## Best Practices

1. **Start with dry-run** in CI to validate before applying changes
2. **Use quality gates** to prevent regressions
3. **Focus on safe fixes** for automated execution
4. **Archive reports** for trend analysis
5. **Set appropriate timeouts** for long-running analyses

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Timeout in CI | Use `--quick` mode or increase timeout |
| Token limits | Use `--focus` to limit scope |
| Merge conflicts | Use `--mode=dry-run` first |
| False positives | Adjust severity thresholds |

## Related Documentation

- [QUICK-START.md](QUICK-START.md) - Basic usage
- [ADVANCED-WORKFLOWS.md](ADVANCED-WORKFLOWS.md) - Complex scenarios
- [REPORT-EXPORT-SYSTEM.md](REPORT-EXPORT-SYSTEM.md) - Report formats
