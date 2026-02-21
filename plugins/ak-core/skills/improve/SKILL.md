---
name: improve
description: This skill should be used when the user asks to "improve code", "refactor", "optimize performance", "fix code quality", "make this better", or needs code improvement, quality enhancement, or applying insights from previous analysis.
---

# Improve

Improve code with intelligent routing to specialized improvement agents.

## Arguments

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches types (quality, performance, security, architecture, style, dependencies, tests, docs, modernize, refactor), use as type
- Default: type="quality", target="."
- Flags: `--dry-run`, `--severity`, `--apply-insights`, `--from-analysis`, `--export-json`, `--export-md`

## Analysis File Discovery (--from-analysis)

When `--from-analysis` is specified:

1. Search for analysis files using Glob:
   - `.docs/analysis/analysis-*{basename}*.md`
   - `docs/analysis/analysis-*{basename}*.md`
2. Use most recent file by modification time
3. If not found: ask user for path using AskUserQuestion
4. Read complete file and extract ALL priority sections

## Execution

Route to agent based on type:

- **performance**: subagent_type="performance-optimizer"
- **security**: subagent_type="security-specialist"
- **quality/architecture/refactor**: subagent_type="refactoring-expert"

Prompt for agent:
"Improve '$target' with '$type' focus:

**If --from-analysis**: Implement ALL priorities systematically from analysis file.

**Phase 1: Planning**

1. Read analysis file (if provided), extract all priority sections
2. Create TodoWrite checklist with one item per priority

**Phase 2: Implementation**
For each priority (starting with Priority 1):

1. Announce: 'Starting Priority X: Y items'
2. Implement each item sequentially
3. Mark completed items with checkmarks
4. Document blocked items with reasons

**Phase 3: Completion Report**

- Per-priority completion stats
- What was implemented
- Blockers and incomplete items
- Testing recommendations

**Standard improvement** (no analysis file):

1. Analyze current code against best practices
2. Identify improvements by severity
3. Apply safe, tested improvements
4. Provide before/after metrics

Success criteria: 80%+ completion for Priority 1-3, all items attempted, structured report."

## Output Format

```markdown
## Implementation Summary

### Completion Statistics
- Priority 1: X/Y items (Z%)
- Priority 2: X/Y items (Z%)
- Priority 3: X/Y items (Z%)

**Overall**: X/Y items completed (Z%)

### Changes Made
[List by priority]

### Testing Recommendations
[What to verify]
```
