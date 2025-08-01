# Migration Guide: Claude Code Toolkit v3.0

This guide helps you migrate from the previous command structure to the new streamlined organization.

## Overview of Changes

The Claude Code Toolkit has been completely reorganized for better clarity, consistency, and power:

- **New Category Structure**: Commands are now organized into 8 clear categories
- **Shorter Names**: Commands use concise, action-oriented names
- **Enhanced Workflows**: New multi-agent workflow commands
- **Command Chaining**: Powerful automation through command pipelines
- **Explicit Syntax**: Clear Task tool invocation patterns

## Command Migration Map

### Analysis → Scan

| Old Command | New Command | What Changed |
|-------------|-------------|--------------|
| `/prefix:analyze-deep` | `/prefix:scan:deep` | Shorter name, clearer phases |
| `/prefix:analyze-report` | `/prefix:scan:report` | Same functionality, new category |
| `/prefix:doc-health` | `/prefix:scan:docs` | More concise name |
| `/prefix:five-whys` | `/prefix:scan:root-cause` | Clearer purpose |

### Orchestration → Flow

| Old Command | New Command | What Changed |
|-------------|-------------|--------------|
| `/prefix:analyze-parallel` | `/prefix:scan:quick` | Moved to scan category for fast analysis |
| `/prefix:performance-scan` | `/prefix:scan:perf` | Moved to scan category |
| `/prefix:refactor-impact` | `/prefix:scan:refactor` | Moved to scan category |
| `/prefix:security-audit` | `/prefix:sec:audit` | Moved to security category |
| `/prefix:test-coverage` | `/prefix:scan:tests` | Moved to scan category |

### Project → Meta

| Old Command | New Command | What Changed |
|-------------|-------------|--------------|
| `/prefix:project:create-command` | `/prefix:meta:create-cmd` | Shorter name |
| `/prefix:project:changelog` | `/prefix:meta:changelog` | Category change only |
| `/prefix:project:update-docs` | `/prefix:meta:update-docs` | Category change only |
| `/prefix:ai:handoff` | `/prefix:meta:handoff` | Better category fit |

### Workflow → Auto

| Old Command | New Command | What Changed |
|-------------|-------------|--------------|
| `/prefix:execute-action-plan` | `/prefix:auto:execute` | Much shorter name |
| `/prefix:completion-report` | `/prefix:auto:report` | Clearer relationship |
| `/prefix:continuous-quality` | `/prefix:auto:monitor` | More descriptive |
| `/prefix:quality-sprint` | `/prefix:auto:sprint` | Shorter name |

### Research → Scan

| Old Command | New Command | What Changed |
|-------------|-------------|--------------|
| `/prefix:codebase-map` | `/prefix:scan:map` | Shorter, clearer |
| `/prefix:deep-dive` | `/prefix:scan:explore` | More descriptive |
| `/prefix:dependency-trace` | `/prefix:scan:deps` | Much shorter |

### Other Changes

| Old Command | New Command | What Changed |
|-------------|-------------|--------------|
| `/prefix:code:shellcheck` | `/prefix:fix:shell` | Better category |
| `/prefix:generate:documentation` | `/prefix:gen:docs` | Shorter name |
| `/prefix:generate:tests` | `/prefix:gen:tests` | Shorter name |

## New Commands

### Flow Commands (Multi-Agent Workflows)

- **`/prefix:flow:smart`** - Intelligent problem analysis and routing
- **`/prefix:flow:review`** - Multi-perspective code review
- **`/prefix:flow:incident`** - Rapid incident response
- **`/prefix:flow:refactor`** - Intelligent refactoring workflow

### Meta Commands (Integration & Management)

- **`/prefix:meta:health`** - Comprehensive project health check
- **`/prefix:meta:pipelines`** - Pre-defined command workflows
- **`/prefix:meta:chain`** - Advanced command chaining
- **`/prefix:meta:export`** - Unified export management

### Quality Commands

- **`/prefix:scan:quality`** - Code quality metrics and trends
- **`/prefix:fix:performance`** - Automated performance fixes

## Migration Steps

### 1. Update Your Scripts

Replace old command names in your scripts:

```bash
# Old
/myprefix:analyze-deep . --export-json

# New
/myprefix:scan:deep . --export-json
```

### 2. Learn New Workflows

Try the new intelligent workflows:

```bash
# Smart problem solving
/myprefix:flow:smart "My tests are failing and the app is slow"

# Pre-defined quality pipeline
/myprefix:meta:pipelines deep-quality

# Command chaining
/myprefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"
```

### 3. Update CI/CD

Update your CI/CD pipelines to use new commands:

```yaml
# Old
- run: /prefix:analyze-deep . --export-json
- run: /prefix:analyze-report analysis.json --generate-action-plan
- run: /prefix:execute-action-plan action-plan.md

# New
- run: /prefix:meta:pipelines deep-quality
```

### 4. Explore New Features

- **Smart Routing**: Let AI determine the best approach
- **Parallel Analysis**: 10x faster with multi-agent execution
- **Command Chaining**: Automate complex workflows
- **Export Management**: Unified format conversion

## Quick Reference

### Command Pattern

```
/prefix:category:command
```

### Categories

- **scan** - Analysis & investigation
- **fix** - Direct corrections
- **gen** - Code & doc generation
- **flow** - Multi-agent workflows
- **auto** - Automation & orchestration
- **sec** - Security operations
- **git** - Version control
- **meta** - Project & toolkit management

### Common Workflows

```bash
# Quick quality check
/prefix:meta:pipelines quick-quality

# Deep analysis with fixes
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"

# Smart problem solving
/prefix:flow:smart "describe your problem here"

# Multi-perspective review
/prefix:flow:review src/
```

## Getting Help

- Run any command with `--help` for usage information
- Check `CLAUDE.md` for development guidelines
- See `docs/guides/MODERN-WORKFLOW.md` for detailed workflows
- Report issues at the GitHub repository

## Rollback

If you need to rollback to the previous version:

```bash
cd ~/Workspace/Projects/claude-code-toolkit
git checkout main
./install.sh myprefix
```

The new structure is designed to be more intuitive and powerful while maintaining all the functionality you rely on.