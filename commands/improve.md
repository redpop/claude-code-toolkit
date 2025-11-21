---
description: Code improvement with intelligent routing and learning persistence
argument-hint: [type] [target] [--dry-run] [--severity] [--apply-insights] [--from-analysis] [--export-json] [--export-md] [--help]
allowed-tools: Task, mcp____search_notes, mcp____write_note, mcp____build_context, Read
---

# Improve

Improve code: "Make this code better."

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Code improvement with intelligent routing and learning persistence
- **Usage**: [type] [target] [--dry-run] [--severity] [--apply-insights] [--from-analysis]
- **Types**: quality, performance, security, architecture, style, dependencies, tests, docs, modernize
- **Options**:
- `--dry-run`: Show proposed changes without applying them
- `--severity`: Filter improvements by severity level (low, medium, high, critical)
- `--apply-insights`: Apply recommendations from previous analysis
- `--from-analysis`: Use existing analysis results for targeted improvements
- `--export-json`: Generate timestamped JSON report
- `--export-md`: Generate timestamped Markdown report

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches improvement types (quality, performance, security, architecture, style, dependencies, tests, docs, modernize, refactor), use as type
- Default: type="quality", target="."
- Handle --dry-run, --severity, --from-analysis, and --apply-insights flags

---

## Analysis File Discovery (when --from-analysis is specified)

**CRITICAL**: When --from-analysis is used, you MUST find and load the analysis file before proceeding!

**Step 1: Search Strategy**

Search for analysis files in this exact order (use Glob tool):

1. `.docs/analysis/analysis-*{basename}*.md` (most recent)
2. `docs/analysis/analysis-*{basename}*.md`
3. `.docs/architecture/analysis-*{basename}*.md`
4. `.docs/architecture/*{basename}*.md`
5. `**/*analysis*{basename}*.md` (last resort - any location, max depth 3)

Where {basename} is extracted from target:

- File: `api-routes.js` → search for `*api-routes*`
- Directory: `src/routes/` → search for `*routes*`

**Step 2: File Selection**

- Sort results by modification time (newest first)
- If multiple files found: Use the most recent one
- If NO files found: Use AskUserQuestion tool to ask user for the analysis file path
- If user provides path: Verify it exists with Read tool

**Step 3: Load Analysis File**

Once analysis file is located:

1. Use **Read** tool to load complete file
2. Parse the entire content (NOT just summary!)
3. Extract ALL sections that contain:
   - "Priority 1", "Priority 2", etc.
   - "Actionable Next Steps"
   - Any checkboxes `- [ ]` (uncompleted items)
   - "CRITICAL", "HIGH SEVERITY", "MEDIUM SEVERITY" markers
4. Create internal checklist of ALL items across ALL priorities

**Step 4: Confirm with User**

Display to user:

```
📄 Found analysis file: {full_path}
📅 Analysis date: {date}
📊 Extracted items:
   - Priority 1: X items (Y critical)
   - Priority 2: X items
   - Priority 3: X items
   - Priority 4: X items
   - Priority 5: X items

   Total: X actionable items across Y priorities

🎯 Will implement ALL items systematically (not just quick-wins!)
```

---

Route to knowledge-enhanced improvement:

Use Task tool with subagent_type="performance-optimizer" (for performance) or "security-specialist" (for security) or "refactoring-expert" (for quality/architecture/refactor):
"**CRITICAL CONTEXT**: This is a comprehensive improvement task based on previous analysis.

**Analysis Context** (when --from-analysis is used):

- Analysis file path: {analysis_file_path}
- Analysis date: {date}
- Total actionable items: {count}
- Priority breakdown: {priority_summary}

**Target**: '$target'
**Type**: '$type'
**Mode**: {'--from-analysis' if analysis file loaded else 'standard improvement'}

**YOUR TASK - COMPREHENSIVE IMPLEMENTATION**:

If --from-analysis was specified, you MUST implement ALL priorities systematically. This is NOT a quick-fix task!

**Phase 1: Planning & Preparation**

1. Read the entire analysis file (if provided)
2. Extract ALL priority sections (Priority 1, 2, 3, 4, 5)
3. Count total items: Should match the summary shown above
4. Create TodoWrite checklist with one item per Priority level

**Phase 2: Systematic Implementation**

For EACH priority level (starting with Priority 1):

1. **Announce Priority**: Display 'Starting Priority X: Y items'
2. **List ALL Items**: Show complete list before starting
3. **Implement EACH Item**:
   - Work through items sequentially
   - Do NOT skip items because they're 'hard' or 'time-consuming'
   - If an item is blocked, document why and continue
   - Mark completed items with ✅ in your progress updates
4. **Priority Completion**: Mark priority as completed in TodoWrite

**Example Progress Display**:

```
🔄 Priority 1: Critical Issues (5 items)
   ✅ Remove hardcoded credentials (lines 710-713)
   ✅ Fix variable name bug (email → username)
   ✅ Add OS+ HTTP status code compliance
   ⚠️  Add authentication middleware (blocked: needs auth strategy decision)
   ✅ Implement input validation

   Result: 4/5 items completed (80%)
```

**Phase 3: Completion Report**

At the end, provide a detailed completion report:

```markdown
## Implementation Summary

### Completion Statistics
- ✅ Priority 1: X/Y items (Z% - CRITICAL)
- ✅ Priority 2: X/Y items (Z% - Important)
- ⚠️  Priority 3: X/Y items (Z% - Nice-to-have)
- ✅ Priority 4: X/Y items (Z%)
- ❌ Priority 5: X/Y items (Z% - Skipped: reason)

**Overall**: X/Y items completed (Z%)

### What Was Implemented
[List major changes by priority]

### Blockers & Incomplete Items
[List any items not completed with reasons]

### Next Steps
[Recommendations for remaining items]

### Testing Recommendations
[What should be tested based on changes made]
```

**SUCCESS CRITERIA**:

- Minimum 80% completion for Priority 1-3 combined
- ALL items attempted (nothing silently skipped)
- Clear documentation for any incomplete items
- Structured completion report at end
- Code changes tested where possible

Improve '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when MCP services available):**

1. **Pattern Retrieval**: Search for successful improvement patterns and strategies
2. **Best Practice Application**: Apply knowledge-base patterns for technology-specific optimizations
3. **Context-Aware Enhancement**: Use project context and previous improvement decisions for targeted optimizations
4. **Learning Capture**: Persist successful patterns and insights for future use

**Standard Workflow (always available - no MCP required):**

1. **Best Practice Application**: Apply local knowledge-base/ patterns for technology-specific optimizations
2. **Expert Analysis**: Use built-in specialist expertise for comprehensive improvement recommendations
3. **Risk Assessment**: Apply established improvement strategies with safety considerations
4. **Standard Implementation**: Provide detailed improvement guidance with proven methodologies

**Universal Capabilities (always included):**

- Safe Implementation with risk assessment and testing guidance
- Before/after metrics and impact analysis
- Prioritized improvement recommendations
- Technology-specific optimization strategies

Improvement areas: code quality, performance optimization, security hardening, architectural refactoring, style consistency, dependency management, test coverage, documentation completeness, or modernization based on type.

Export results with enhanced insights when possible, comprehensive improvements guaranteed.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Capture successful improvement patterns and their effectiveness metrics for knowledge persistence
- Generate intelligent next-step recommendations based on improvement results and project context
- Cross-reference improvements with related code quality patterns and successful refactoring strategies
- Track improvement outcomes and refine optimization strategies based on accumulated learning"
