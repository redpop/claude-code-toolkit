---
allowed-tools: Task, Read, Write, Bash(npm:*), Bash(git:*), TodoWrite
description: Plan and execute a complete code quality improvement sprint with analysis, prioritization, fixes, and tracking
argument-hint: [directory] [--duration=1w|2w|1m] [--team-size=N] [--focus=security|performance|quality|all]
---

# Quality Sprint Workflow

This command orchestrates a complete code quality improvement sprint, from initial analysis through implementation and verification. It generates sprint plans, tracks progress, and ensures systematic quality improvements.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Usage Examples

```bash
# Plan a 2-week quality sprint
/quality-sprint . --duration=2w --team-size=4

# Focus on security for 1 week
/quality-sprint src/ --duration=1w --focus=security

# Full month quality improvement
/quality-sprint . --duration=1m --focus=all
```

## Sprint Workflow

### Phase 1: Sprint Planning (Day 1)

1. **Comprehensive Analysis**:

   ```bash
   # Run deep analysis
   /analyze-deep . --focus=all --export-all
   
   # Analyze report for priorities
   /analyze-report latest-report.json --sprint-planning
   ```

2. **Sprint Backlog Generation**:

   ```markdown
   ## Sprint Backlog (2 Weeks, 4 Developers)
   
   ### Week 1: High-Impact Fixes
   #### Critical Security (16h)
   - [ ] Fix SQL injection in user search (4h) - Dev 1
   - [ ] Add CSRF protection (4h) - Dev 2
   - [ ] Patch XSS vulnerabilities (8h) - Dev 3 & 4
   
   #### Quick Wins (32h)
   - [ ] Remove code duplication (8h) - Dev 1
   - [ ] Fix linting errors (4h) - Dev 2
   - [ ] Add missing validations (12h) - Dev 3
   - [ ] Optimize database queries (8h) - Dev 4
   
   ### Week 2: Strategic Improvements
   #### Test Coverage (20h)
   - [ ] Add unit tests for services (12h) - Dev 1 & 2
   - [ ] Integration tests for APIs (8h) - Dev 3 & 4
   
   #### Performance (20h)
   - [ ] Implement caching layer (8h) - Dev 1
   - [ ] Optimize bundle size (6h) - Dev 2
   - [ ] Database indexing (6h) - Dev 3
   ```

3. **Task Assignment**:

   ```javascript
   // Generate JIRA/GitHub issues
   const sprintTasks = [
     {
       title: "Fix SQL injection in user search",
       assignee: "dev1",
       estimate: "4h",
       priority: "Critical",
       labels: ["security", "sprint-1"]
     },
     // ... more tasks
   ];
   ```

### Phase 2: Daily Execution

1. **Daily Standup Report**:

   ```markdown
   ## Day 3 Progress Report
   
   ### Completed Yesterday
   - ✅ Fixed SQL injection (Dev 1)
   - ✅ Added CSRF tokens (Dev 2)
   - ✅ 50% XSS fixes (Dev 3 & 4)
   
   ### Today's Focus
   - 🔄 Complete XSS fixes
   - 🔄 Start code duplication removal
   - 🔄 Begin validation additions
   
   ### Blockers
   - ⚠️ Need security review for CSRF implementation
   ```

2. **Progress Tracking**:

   ```
   Sprint Progress: ████████░░░░░░░░ 45%
   
   By Category:
   - Security:     ███████░░░ 70%
   - Quick Wins:   ████░░░░░░ 35%
   - Performance:  ░░░░░░░░░░ 0%
   - Testing:      ░░░░░░░░░░ 0%
   ```

3. **Quality Gates**:

   ```bash
   # After each fix
   npm test
   npm run lint
   /analyze-deep --quick --compare=baseline
   ```

### Phase 3: Mid-Sprint Review

```markdown
## Mid-Sprint Review (Day 5)

### Velocity Analysis
- Planned: 48h
- Completed: 42h
- Velocity: 87.5%

### Quality Metrics
| Metric | Start | Current | Target | Status |
|--------|-------|---------|--------|--------|
| Health Score | 68 | 74 | 80 | 🟡 On Track |
| Security | 72 | 88 | 90 | 🟢 Good |
| Coverage | 62% | 68% | 75% | 🟡 On Track |
| Tech Debt | 145h | 128h | 100h | 🟡 On Track |

### Adjustments
- Defer complex refactoring to next sprint
- Add pair programming for difficult tasks
- Schedule code review sessions
```

### Phase 4: Implementation Patterns

1. **Security Fix Day**:

   ```bash
   # Morning: Analysis
   /security-audit . --severity=critical,high
   
   # Fix implementation
   /fix-security report.json --severity=critical
   
   # Afternoon: Verification
   npm run test:security
   /security-audit . --verify-fixes
   ```

2. **Performance Day**:

   ```bash
   # Profile current state
   /performance-scan . --profile=all
   
   # Apply optimizations
   /fix-quick-wins report.json --category=performance
   
   # Measure improvements
   /performance-scan . --compare=morning-baseline
   ```

3. **Test Coverage Day**:

   ```bash
   # Generate tests for uncovered code
   /generate-tests report.json --coverage-target=80
   
   # Run and verify
   npm test -- --coverage
   
   # Generate coverage report
   /test-coverage . --export-html
   ```

### Phase 5: Sprint Completion

1. **Final Report**:

   ```markdown
   ## Sprint Summary
   
   ### Achievements
   - 🎯 Completed 28/32 planned tasks (87.5%)
   - 📈 Health Score: 68 → 82 (+14 points)
   - 🔒 Security Score: 72 → 94 (+22 points)
   - 🧪 Test Coverage: 62% → 78% (+16%)
   - ⚡ Performance: 15% faster page loads
   
   ### Key Improvements
   1. **Security**: All critical vulnerabilities fixed
   2. **Code Quality**: 60% less duplication
   3. **Testing**: Added 145 new tests
   4. **Performance**: Optimized 8 critical paths
   
   ### Deferred Items
   - Complex authentication refactor (20h)
   - Full microservices migration (40h)
   - Advanced caching implementation (16h)
   
   ### Team Performance
   - Dev 1: 102% velocity, security specialist
   - Dev 2: 95% velocity, quality focus
   - Dev 3: 98% velocity, testing expert
   - Dev 4: 92% velocity, performance guru
   ```

2. **Retrospective**:

   ```markdown
   ## Sprint Retrospective
   
   ### What Went Well
   - Quick wins provided immediate value
   - Pair programming accelerated complex fixes
   - Daily quality checks caught regressions
   
   ### What Could Improve
   - Better estimation for security fixes
   - More automated verification
   - Earlier code reviews
   
   ### Action Items
   - Create security fix checklist
   - Automate daily quality reports
   - Schedule mid-task reviews
   ```

## Workflow Automation

### Daily Automation Script

```bash
#!/bin/bash
# daily-quality-check.sh

echo "🔍 Running Daily Quality Check..."

# Quick analysis
/analyze-deep . --quick --export-json=daily-$(date +%Y%m%d).json

# Compare with yesterday
/analyze-report daily-$(date +%Y%m%d).json \
  --compare=daily-$(date -d yesterday +%Y%m%d).json \
  --export-md=daily-progress.md

# Update sprint board
/update-sprint-progress daily-progress.md

# Send team update
/generate-standup-report daily-progress.md | slack-send
```

### CI/CD Integration

```yaml
# .github/workflows/quality-sprint.yml
name: Quality Sprint Checks

on:
  push:
    branches: [quality-sprint-*]

jobs:
  quality-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Run Quality Analysis
        run: |
          /analyze-deep . --quick
          /verify-sprint-progress
      
      - name: Update Sprint Dashboard
        run: |
          /update-sprint-metrics
          /generate-burndown-chart
```

## Sprint Templates

### Security Sprint

- Week 1: Critical vulnerabilities
- Week 2: OWASP Top 10 compliance
- Focus: Zero security debt

### Performance Sprint  

- Week 1: Quick optimizations
- Week 2: Architecture improvements
- Focus: 50% faster response times

### Quality Sprint

- Week 1: Code cleanup
- Week 2: Test coverage
- Focus: 90% coverage, zero lint errors

### Technical Debt Sprint

- Week 1: Refactoring
- Week 2: Modernization
- Focus: Reduce debt by 40%

## Metrics & KPIs

Track throughout sprint:

- Velocity (story points/day)
- Quality scores (health, security, etc.)
- Test coverage percentage
- Performance benchmarks
- Team satisfaction

## Best Practices

1. **Start Small**: First sprint should focus on quick wins
2. **Measure Everything**: Track metrics daily
3. **Communicate Progress**: Daily updates to stakeholders
4. **Celebrate Wins**: Acknowledge improvements
5. **Learn and Adapt**: Use retrospectives effectively

This workflow transforms ad-hoc quality improvements into systematic, measurable sprints that deliver consistent results.
