# Command Reference

Complete reference for all Claude Code Toolkit commands organized by category.

## Command Format

All commands follow this pattern:
```bash
/prefix:category:command [arguments] [--options]
```

- **prefix**: Your installation prefix (e.g., `global`)
- **category**: Command category (e.g., `scan`, `fix`)
- **command**: Specific command name
- **arguments**: Required or optional arguments
- **options**: Command-specific flags

## 📊 Scan Commands

Analysis and investigation commands for understanding your codebase.

### scan:deep
**Deep comprehensive analysis with parallel scanning**
```bash
/global:scan:deep <directory> [--focus=security|performance|all] [--export-md] [--export-json]
```
- Runs 10+ parallel scanners
- Delegates to expert agents
- Generates actionable report

### scan:quality
**Code quality metrics and scoring**
```bash
/global:scan:quality <directory> [--baseline] [--compare=file.json] [--export]
```
- Calculates health score
- Tracks quality trends
- Identifies improvements

### scan:perf
**Performance profiling and bottleneck detection**
```bash
/global:scan:perf <directory> [--profile] [--algorithms] [--memory]
```
- Finds O(n²) algorithms
- Detects memory leaks
- Identifies slow operations

### scan:deps
**Dependency analysis and vulnerability scanning**
```bash
/global:scan:deps [--outdated] [--vulnerabilities] [--unused]
```
- Checks for outdated packages
- Scans for known vulnerabilities
- Finds unused dependencies

### scan:docs
**Documentation health and coverage**
```bash
/global:scan:docs <directory> [--coverage] [--sync] [--missing]
```
- Checks documentation coverage
- Validates code-doc sync
- Finds missing documentation

### scan:tests
**Test coverage and quality analysis**
```bash
/global:scan:tests <directory> [--coverage] [--quality] [--missing]
```
- Analyzes test coverage
- Evaluates test quality
- Identifies untested code

### scan:report
**Intelligent report analysis with action plan generation**
```bash
/global:scan:report <report.json> [--compare] [--trends] [--generate-action-plan]
```
- Analyzes existing reports
- Generates action plans
- Tracks progress over time

## 🔧 Fix Commands

Direct correction commands for addressing identified issues.

### fix:quick-wins
**Apply high-ROI fixes from analysis reports**
```bash
/global:fix:quick-wins <report.json> [--threshold=8] [--preview]
```
- Fixes issues with ROI > threshold
- Safe, automated corrections
- Preview mode available

### fix:security
**Fix security vulnerabilities**
```bash
/global:fix:security <report.json> [--severity=critical,high] [--auto-fix]
```
- Addresses security issues
- Prioritizes by severity
- Validates fixes

### fix:performance
**Optimize performance bottlenecks**
```bash
/global:fix:performance <report.json> [--target=algorithm|memory|io]
```
- Optimizes algorithms
- Reduces memory usage
- Improves I/O operations

### fix:duplicates
**Remove code duplication**
```bash
/global:fix:duplicates [--file=path] [--extract-shared] [--threshold=10]
```
- Identifies duplicate code
- Extracts shared functions
- Configurable threshold

### fix:documentation
**Update and fix documentation**
```bash
/global:fix:documentation [--add-missing] [--update-outdated] [--sync]
```
- Adds missing docs
- Updates outdated content
- Syncs with code changes

## 🚀 Flow Commands

Multi-agent workflow commands for complex operations.

### flow:smart
**Intelligent problem routing to specialized agents**
```bash
/global:flow:smart "<problem description>" [--verbose] [--suggest-only]
```
- Analyzes problem
- Routes to best agents
- Provides solutions

### flow:review
**Multi-perspective code review**
```bash
/global:flow:review <directory> [--focus=changes] [--depth=thorough]
```
- 5 parallel reviewers
- Different perspectives
- Consolidated feedback

### flow:incident
**Rapid incident response workflow**
```bash
/global:flow:incident "<incident description>" [--severity=high]
```
- Root cause analysis
- Immediate fixes
- Prevention strategies

### flow:refactor
**Safe refactoring workflow**
```bash
/global:flow:refactor <directory> [--safety=conservative] [--preview]
```
- Identifies opportunities
- Plans safe changes
- Validates results

### scan:quick
**Quick parallel code analysis**
```bash
/global:scan:quick <directory> [--focus=area] [--export-json]
```
- 30-second analysis
- 10 parallel agents
- Rapid feedback

## 🤖 Auto Commands

Automation and continuous improvement commands.

### auto:execute
**Execute action plans automatically**
```bash
/global:auto:execute <action-plan.md> [--mode=supervised|auto|dry-run]
```
- Executes fix commands
- Progress tracking
- Rollback support

### auto:monitor
**Continuous quality monitoring**
```bash
/global:auto:monitor <directory> [--schedule=daily] [--auto-fix=safe]
```
- Scheduled scans
- Automatic fixes
- Trend tracking

### auto:sprint
**Quality improvement sprints**
```bash
/global:auto:sprint <directory> --duration=1w [--focus=quality]
```
- Sprint planning
- Daily progress
- Sprint review

### auto:report
**Generate completion and progress reports**
```bash
/global:auto:report [--compare-baseline] [--format=md|json]
```
- Success metrics
- Progress tracking
- Next steps

## 📝 Gen Commands

Code and documentation generation commands.

### gen:docs
**Generate or update documentation**
```bash
/global:gen:docs [--update-all] [--api-docs] [--readme]
```
- Generates missing docs
- Updates existing docs
- Multiple formats

### gen:tests
**Generate test cases**
```bash
/global:gen:tests [--coverage-target=80] [--focus=critical] [--framework=jest]
```
- Creates test cases
- Improves coverage
- Framework-specific

## 🔒 Sec Commands

Security-focused commands.

### sec:audit
**Comprehensive security audit**
```bash
/global:sec:audit <directory> [--standard=owasp] [--export-json]
```
- OWASP compliance
- Vulnerability scanning
- Remediation advice

### sec:baseline
**Create security baseline**
```bash
/global:sec:baseline [--save] [--compare] [--track]
```
- Baseline creation
- Progress tracking
- Drift detection

### sec:comply
**Compliance checking**
```bash
/global:sec:comply [--standard=owasp|pci|hipaa] [--report]
```
- Standard compliance
- Gap analysis
- Remediation plan

## 🔗 Meta Commands

Toolkit management and utility commands.

### meta:pipelines
**Pre-defined workflow pipelines**
```bash
/global:meta:pipelines <workflow-name> [--customize] [--dry-run]
```

Available workflows:
- `quick-quality`
- `deep-quality`
- `security-hardening`
- `refactoring-sprint`
- `release-prep`

### meta:chain
**Command chaining for custom workflows**
```bash
/global:meta:chain "cmd1" -> "cmd2 {output}" -> "cmd3"
```
- Sequential with `->`
- Parallel with `[cmd1, cmd2]`
- Conditional with `?>`

### meta:health
**Project health assessment**
```bash
/global:meta:health [--verbose] [--compare=baseline] [--export]
```
- Overall health score
- Trend analysis
- Recommendations

### meta:export
**Export and format results**
```bash
/global:meta:export <input-file> [--format=md|json|csv|html] [--template=name]
```
- Multiple formats
- Custom templates
- Batch export

### meta:changelog
**Update project changelog**
```bash
/global:meta:changelog [--version=patch|minor|major] [--auto-generate]
```
- Version bumping
- Auto-generation
- Format compliance

## 🔀 Git Commands

Version control integration.

### git:commit
**Smart commit with analysis**
```bash
/global:git:commit [--analyze] [--fix-before-commit]
```
- Pre-commit analysis
- Auto-fixes
- Message generation

## 🎯 Command Options

### Common Options

- `--export-json`: Export results as JSON
- `--export-md`: Export results as Markdown
- `--verbose`: Detailed output
- `--quiet`: Minimal output
- `--dry-run`: Preview without changes
- `--force`: Skip confirmations
- `--help`: Command help

### Export Options

- `--export`: Default export format
- `--export-all`: Export in all formats
- `--output=file`: Specific output file
- `--template=name`: Use template

### Filtering Options

- `--include=pattern`: Include files
- `--exclude=pattern`: Exclude files
- `--focus=area`: Focus analysis
- `--depth=level`: Analysis depth

## 💡 Usage Tips

### Chaining Commands
```bash
# Analyze → Plan → Execute
/global:scan:deep . && \
/global:scan:report analysis-*.json --generate-action-plan && \
/global:auto:execute action-plan-*.md
```

### Using Wildcards
```bash
# Process latest report
/global:scan:report analysis-*.json

# Compare all reports
/global:scan:report reports/*.json --trends
```

### Focusing Analysis
```bash
# Security only
/global:scan:deep . --focus=security

# Multiple areas
/global:scan:deep . --focus=security,performance
```

### Export Formats
```bash
# Multiple formats
/global:scan:deep . --export-json --export-md

# Custom location
/global:scan:deep . --output=~/reports/analysis.json
```

## 🔍 Finding Commands

### By Goal
- **Improve quality**: Start with `/flow:smart`
- **Fix issues**: Use `/fix:*` commands
- **Analyze code**: Use `/scan:*` commands
- **Automate**: Use `/auto:*` commands

### By Time
- **30 seconds**: `/meta:pipelines quick-quality`
- **5 minutes**: `/scan:deep`
- **20 minutes**: `/meta:pipelines release-prep`

### By Expertise
- **Beginners**: `/flow:smart`
- **Intermediate**: `/meta:pipelines`
- **Advanced**: `/meta:chain`