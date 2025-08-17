# Advanced Workflows

Complex scenarios and team workflows for the Claude Code Toolkit.

## Multi-Project Analysis

Analyze multiple projects in a monorepo:

```bash
# Analyze each project
/prefix:scan:deep frontend/ --export-json=frontend.json
/prefix:scan:deep backend/ --export-json=backend.json
/prefix:scan:deep mobile/ --export-json=mobile.json

# Cross-project analysis
/prefix:scan:report frontend.json backend.json mobile.json --export-md=cross-project.md
```

## ROI-Based Prioritization

The toolkit calculates Return on Investment for each improvement:

```
ROI = (Impact × 10) / Effort_Hours

Where:
- Impact = Severity × Scope × Business_Value
- Effort_Hours = Estimated fix time
```

### Sprint Planning

```bash
# Generate sprint backlog with ROI priorities
/prefix:scan:report report.json --sprint-planning --export-json=sprint.json

# Quick wins for current sprint (< 4h effort)
/prefix:scan:report report.json --quick-wins --max-effort=4h

# Technical debt items
/prefix:scan:report report.json --tech-debt --export-md=tech-debt.md
```

## Team Collaboration

### Team-Based Action Plans

```bash
# Generate team assignments
/prefix:scan:report analysis.json --generate-action-plan --team-mode

# Output shows:
# Senior Dev: Security fixes (8h)
# Mid-level: Performance & tests (16h)  
# Junior: Documentation & quick wins (8h)
```

### Parallel Execution by Team

```bash
# Senior focuses on security
/prefix:auto:execute action-plan.md --assignee="Senior Developer"

# Mid-level works on performance
/prefix:auto:execute action-plan.md --assignee="Mid-level Developer" --parallel=2

# Junior handles quick wins
/prefix:auto:execute action-plan.md --assignee="Junior Developer" --focus=quick-wins
```

## Zero-to-Hero Quality Improvement

For projects with poor code quality:

```bash
# Week 1: Baseline and critical fixes
/prefix:scan:deep . --comprehensive --export-all --output-dir=baseline/
/prefix:scan:report baseline/report.json --generate-action-plan --sprint=12-weeks
/prefix:auto:execute action-plan.md --focus=critical --checkpoint=week1

# Week 2-4: Quick wins
/prefix:auto:execute action-plan.md --focus=quick-wins --checkpoint=week2-4

# Week 5-8: Architecture improvements
/prefix:auto:execute action-plan.md --focus=architecture --checkpoint=week5-8

# Week 9-12: Performance & polish
/prefix:auto:execute action-plan.md --focus=enhancement --checkpoint=week9-12

# Final assessment
/prefix:scan:deep . --export-json=final.json
/prefix:scan:report final.json --compare=baseline/report.json
```

## Real-World Example: E-commerce Platform

```bash
# Initial State: Security score 42/100, 3.8s load time, 23% test coverage

# Day 1: Analysis (30 min)
/prefix:scan:deep . --export-json
# → 847 files analyzed, 5 critical security issues, 12 performance bottlenecks

/prefix:scan:report --latest --generate-action-plan --sprint=1-week
# → 18 tasks, 42h estimated, 5 critical items

# Day 1-2: Critical Security (8h)
/prefix:auto:execute action-plan.md --focus=critical
# → Fixed XSS in 12 components, added Zod validation, removed PII logs
# → Security score: 42 → 71

# Day 3: Performance Quick Wins (4h)
/prefix:auto:execute action-plan.md --focus=performance --max-effort=4h
# → Implemented query batching, lazy loading, optimized calculations
# → Page load: 3.8s → 1.6s

# Day 4: Test Coverage (6h)
/prefix:auto:execute action-plan.md --task="Increase Test Coverage"
# → Generated 125 unit tests, added integration tests
# → Coverage: 23% → 51%

# Results after 30 days:
# - Cart abandonment: -23%
# - Conversion rate: +12%
# - Support tickets: -45%
# - Revenue impact: +$47K/month
```

## Execution Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| `--mode=auto` | Fully automated | CI/CD pipelines |
| `--mode=supervised` | Asks confirmation | Default for safety |
| `--focus=critical` | Critical items only | Emergency fixes |
| `--focus=quick-wins` | High ROI items | Sprint planning |
| `--max-effort=4h` | Time-boxed execution | Limited resources |

## Workflow Customization

### Custom Pipelines

Create reusable workflows in `.claude-pipelines.json`:

```json
{
  "pipelines": {
    "morning-check": [
      "scan:quick . --export-json",
      "fix:quick-wins --latest",
      "scan:quick . --verify"
    ],
    "release-prep": [
      "scan:deep . --export-all",
      "sec:audit . --fail-on-critical",
      "test:coverage . --min=80",
      "gen:changelog --from=last-tag"
    ]
  }
}
```

### Conditional Execution

```bash
# Execute only if issues found
/prefix:meta:chain \
  "scan:security ." -> \
  "fix:security {output}" ?> \
  "sec:audit . --verify"

# Different paths based on severity
/prefix:meta:chain \
  "scan:deep ." -> \
  "[critical] ? flow:incident {output}" : \
  "[high] ? fix:quick-wins {output}" : \
  "meta:health"
```

## Performance Benchmarking

```bash
# Baseline performance
/prefix:scan:perf . --export-json=perf-baseline.json

# After optimizations
/prefix:scan:perf . --export-json=perf-after.json
/prefix:scan:report perf-after.json --compare=perf-baseline.json

# Typical improvements:
# - Execution time: 52s → 6.2s (8.4x speedup)
# - Token usage: 28,450 total (2,845/agent)
# - Parallel efficiency: 87%
```

## Related Documentation

- [QUICK-START.md](QUICK-START.md) - Basic workflows
- [AUTOMATED-WORKFLOW.md](AUTOMATED-WORKFLOW.md) - CI/CD integration
- [REPORT-EXPORT-SYSTEM.md](REPORT-EXPORT-SYSTEM.md) - Export options