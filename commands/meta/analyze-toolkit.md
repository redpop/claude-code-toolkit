---
allowed-tools: Read, Grep, Task
description: Analyze toolkit commands and agents for redundancies, inconsistencies, and refactoring opportunities
argument-hint: [--fix] [--export-json] [--export-md] [--focus=<area>]
---

# Toolkit Self-Analysis Command

This command performs a comprehensive analysis of the Claude Code Toolkit itself, identifying redundancies, inconsistencies, and refactoring opportunities across all commands and agents.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Analyze toolkit commands and agents for redundancies, inconsistencies, and refactoring opportunities
- **Usage**: [--fix] [--export-json] [--export-md] [--focus=<area>]
- **Options**:
  - `--fix`: Apply automated fixes where possible
  - `--export-json`: Export analysis results as JSON
  - `--export-md`: Export analysis results as Markdown
  - `--focus`: Focus analysis on specific area

Then exit without executing the main command.

---

## Purpose

As the toolkit grows with new commands and agents, it's essential to periodically analyze the codebase for:

- Redundant or overlapping functionality
- Inconsistent patterns or naming conventions
- Opportunities for consolidation and refactoring
- Quality and documentation gaps
- Evolution trends and technical debt

## Execution

**Input**: $ARGUMENTS

### Phase 1: Command Structure Analysis

Use Task tool with subagent_type="general-purpose":
"Analyze all command files in the toolkit:

1. Read and parse all .md files in commands/ directory
2. Extract and validate frontmatter for each command:
   - Check for required fields (description, argument-hint)
   - Note optional fields (allowed-tools, mcp-enhanced)
   - Identify missing or malformed frontmatter
3. Analyze command structure:
   - Count phases/sections per command
   - Measure command complexity (lines, tools used)
   - Check for consistent Task tool invocation patterns
4. Categorize commands by:
   - Directory/namespace (scan, fix, flow, meta, etc.)
   - Functionality type (analysis, generation, automation)
   - Tool usage patterns
Return structured data with all findings."

### Phase 2: Agent Analysis

Use Task tool with subagent_type="general-purpose":
"Analyze all agent files in agents/ directory:

1. Parse each agent definition
2. Extract key characteristics:
   - Expertise areas
   - Tool requirements
   - Output formats
   - Dependencies on other agents
3. Map agent usage across commands:
   - Which commands invoke which agents
   - Frequency of agent usage
   - Agent collaboration patterns
4. Identify:
   - Overlapping agent capabilities
   - Unused or underutilized agents
   - Missing agent types based on command needs
Return structured analysis data."

### Phase 3: Redundancy Detection

Use Task tool with subagent_type="code-architect":
"Analyze the command and agent data for redundancies:

1. Semantic similarity analysis:
   - Commands with similar descriptions
   - Commands with overlapping functionality
   - Example: 'flow:smart' vs 'fix:smart' routing logic
2. Code pattern duplication:
   - Repeated phase structures
   - Common Task tool invocation patterns
   - Similar error handling approaches
3. Agent overlap:
   - Agents with similar expertise areas
   - Redundant agent capabilities
4. Namespace organization:
   - Commands that might belong in different categories
   - Potential for new categories or consolidation
Provide specific recommendations for each redundancy found."

### Phase 4: Consistency & Quality Check

Use Task tool with subagent_type="general-purpose":
"Perform consistency and quality checks:

1. Naming conventions:
   - Command naming patterns (verb-noun, action-oriented)
   - Category naming consistency
   - File naming vs command naming alignment
2. Documentation quality:
   - Commands with insufficient documentation
   - Missing usage examples
   - Outdated or incorrect information
3. Pattern consistency:
   - Task tool invocation syntax
   - Export parameter handling
   - Error handling patterns
4. Integration points:
   - MCP integration consistency
   - Export/import data flow
   - Command chaining compatibility
Rate each area and provide specific improvements."

### Phase 5: Evolution & Trend Analysis

Use Task tool with subagent_type="general-purpose":
"Analyze toolkit evolution and trends:

1. Growth metrics:
   - Commands added over time (using git history if available)
   - Category expansion patterns
   - Complexity trends
2. Usage patterns (if logs available):
   - Most frequently used commands
   - Common command sequences
   - Unused or deprecated commands
3. Technical debt indicators:
   - Commands needing updates
   - Deprecated patterns still in use
   - Missing test coverage
4. Future opportunities:
   - Gaps in functionality
   - Potential new categories
   - Integration opportunities
Provide trend analysis and forward-looking recommendations."

### Phase 6: Generate Refactoring Plan

Use Task tool with subagent_type="report-analyzer":
"Synthesize all analysis results into actionable refactoring plan:

1. Prioritized issue list:
   - [CRITICAL] Breaking issues or major inconsistencies
   - [HIGH] Significant redundancies or quality issues
   - [MEDIUM] Pattern improvements and consolidation
   - [LOW] Minor enhancements and nice-to-haves
2. Specific refactoring actions:
   - Commands to merge or consolidate
   - Agents to combine or deprecate
   - Naming changes for consistency
   - Documentation updates needed
3. Implementation roadmap:
   - Quick wins (< 1 hour)
   - Medium tasks (1-4 hours)
   - Major refactoring (> 4 hours)
4. Risk assessment:
   - Breaking changes
   - User impact
   - Migration requirements

Format as both:

- Markdown report for human review
- JSON structure for automated processing"

### Phase 7: Optional Auto-Fix

If --fix flag is provided:

Use Task tool with subagent_type="refactoring-expert":
"Apply safe, non-breaking fixes automatically:

1. Fix missing or malformed frontmatter
2. Standardize Task tool invocation syntax
3. Update inconsistent naming (with user confirmation)
4. Add missing documentation sections
5. Generate deprecation notices where needed

Only apply fixes that:

- Don't change functionality
- Don't break existing usage
- Improve consistency and quality
Report all changes made."

## Output Format

### Default Output (Terminal)

```
═══════════════════════════════════════════════════
    CLAUDE CODE TOOLKIT ANALYSIS REPORT
═══════════════════════════════════════════════════

📊 STATISTICS
├── Commands: 48 total (10 categories)
├── Agents: 16 total (4 TYPO3-specific)
├── Avg Complexity: 215 lines/command
└── Coverage: 87% documented

🔍 REDUNDANCIES DETECTED (3)
├── [HIGH] flow:smart ←→ fix:smart (70% overlap)
│   └── Recommendation: Merge into flow:smart-router
├── [MEDIUM] scan:deep ←→ scan:explore (45% overlap)
│   └── Recommendation: Differentiate or combine
└── [LOW] Multiple TYPO3 agents with overlap
    └── Recommendation: Create typo3:universal agent

⚠️ INCONSISTENCIES FOUND (5)
├── Missing frontmatter: 5 commands
├── Non-standard naming: typo3/* commands
├── Inconsistent Task syntax: 8 occurrences
├── Mixed export patterns: 12 commands
└── Undocumented features: 3 commands

✨ REFACTORING OPPORTUNITIES
├── Extract common patterns → templates/patterns/
├── Consolidate scan commands → scan:unified
├── Standardize error handling across all commands
└── Create shared utilities for export handling

📈 TRENDS & INSIGHTS
├── Growth: +15 commands in last month
├── Most used: scan:deep, fix:quick-wins, meta:chain
├── Underutilized: 6 commands (< 5% usage)
└── Technical debt: Growing complexity in flow/*

✅ ACTION PLAN (Prioritized)
1. [CRITICAL] Fix missing frontmatter (5 files)
2. [HIGH] Merge flow:smart and fix:smart
3. [HIGH] Standardize Task tool syntax
4. [MEDIUM] Reorganize TYPO3 commands
5. [MEDIUM] Update documentation gaps
6. [LOW] Rename for consistency
```

### JSON Export (--export-json)

```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "statistics": {
    "commands": {
      "total": 48,
      "byCategory": {"scan": 12, "fix": 7, ...},
      "avgComplexity": 215
    },
    "agents": {
      "total": 16,
      "specialized": {"typo3": 4, ...}
    }
  },
  "redundancies": [
    {
      "severity": "HIGH",
      "items": ["flow:smart", "fix:smart"],
      "overlap": 0.7,
      "recommendation": "Merge into flow:smart-router"
    }
  ],
  "inconsistencies": [...],
  "refactoring": [...],
  "actionPlan": [...]
}
```

### Markdown Export (--export-md)

Full detailed report with code examples, detailed explanations, and implementation guidance.

## Options

- `--fix`: Automatically apply safe, non-breaking fixes
- `--export-json[=filename]`: Export analysis as JSON
- `--export-md[=filename]`: Export detailed markdown report
- `--focus=<area>`: Focus on specific area (redundancy|consistency|quality|trends)
- `--verbose`: Include detailed analysis data
- `--compare=<previous.json>`: Compare with previous analysis

## Examples

```bash
# Basic analysis
/prefix:meta:analyze-toolkit

# Auto-fix safe issues
/prefix:meta:analyze-toolkit --fix

# Export for tracking
/prefix:meta:analyze-toolkit --export-json --export-md

# Focus on redundancies
/prefix:meta:analyze-toolkit --focus=redundancy

# Compare with last analysis
/prefix:meta:analyze-toolkit --compare=analysis-2024-01-01.json
```

## Benefits

1. **Maintain Quality**: Regular analysis prevents degradation
2. **Reduce Redundancy**: Identify and eliminate duplication
3. **Improve Consistency**: Enforce patterns and standards
4. **Track Evolution**: Understand toolkit growth and trends
5. **Plan Refactoring**: Data-driven improvement decisions

## Integration

This command integrates with:

- `/prefix:meta:health` - For overall project health
- `/prefix:meta:chain` - Can be part of maintenance pipelines
- `/prefix:auto:monitor` - For continuous toolkit quality monitoring
- `/prefix:meta:update-docs` - To update documentation after refactoring

## Notes

- Run monthly or after significant additions
- Review report before applying auto-fixes
- Use JSON export for trend tracking
- Consider creating custom pipelines for toolkit maintenance
