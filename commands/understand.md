---
description: Code analysis and comprehension with intelligent problem routing
argument-hint: [type] [target] [--comprehensive] [--quick] [--export-json] [--export-md] [--help]
allowed-tools: Task, mcp____search_notes, mcp____write_note, mcp____build_context
---

# Understand

Analyze code: "What does this code do?"

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Code analysis and comprehension with intelligent problem routing
- **Usage**: [type] [target] [--comprehensive] [--quick] [--export-json] [--export-md]
- **Types**: code, performance, security, architecture, debug, flow, dependencies, tests, docs, legacy
- **Options**:
- `--comprehensive`: Deep analysis with full context
- `--quick`: Fast analysis for immediate insights
- `--export-json`: Generate timestamped JSON report
- `--export-md`: Generate timestamped Markdown report

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract type and target:

- If first argument matches analysis types (code, performance, security, architecture, debug, flow, dependencies, tests, docs, legacy), use as type
- Default: type="code", target="."

Route to enhanced analysis:

Use Task tool with subagent_type="code-understanding-specialist":
"Perform comprehensive analysis of '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when MCP services available):**

1. **Knowledge Retrieval**: Search for similar analysis patterns and previous insights
2. **Domain Expertise**: Reference knowledge-base for technology-specific patterns and best practices
3. **Cross-Project Learning**: Apply accumulated learning from successful analyses across projects
4. **Learning Persistence**: Automatically capture key insights and patterns for future use

**Standard Workflow (always available - no MCP required):**

1. **Domain Expertise**: Reference local knowledge-base/ for technology-specific patterns and best practices
2. **Built-in Analysis**: Apply comprehensive code understanding using established expertise
3. **Real-Time Context**: Analyze current codebase with full contextual understanding
4. **Standard Export**: Generate detailed analysis reports with actionable recommendations

Focus areas: code structure, logic explanation, performance patterns, security implications, architectural decisions, dependencies, testing strategies, documentation gaps, or modernization opportunities based on type.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Automatically extract key insights and architectural patterns for knowledge persistence
- Generate intelligent next-step recommendations based on analysis results
- Cross-reference findings with related knowledge entries and similar analyses
- Create structured knowledge entries linking analysis patterns to successful outcomes

---

**CRITICAL: Export Implementation (when --export-md or --export-json is specified)**

If user requested export via --export-md or --export-json flags, you MUST create the export file. This is NOT optional!

**Export File Creation Steps:**

1. **Determine Export Directory:**
   - First check if `.docs/analysis/` exists
   - If not, check if `docs/analysis/` exists
   - If neither exists, create `.docs/analysis/` directory using Bash tool
   - Fallback: Use `.docs/architecture/` if it exists

2. **Generate Filename:**
   - Pattern: `analysis-{basename}-{YYYY-MM-DD}.{ext}`
   - Extract basename from target file/directory:
     - For file: Use filename without extension
     - For directory: Use directory name
     - Example: `api-routes.js` → `analysis-api-routes-2025-11-21.md`
   - Use current date in YYYY-MM-DD format

3. **Create Export File:**
   - Use the **Write** tool (NOT echo or heredoc!)
   - Full path example: `.docs/analysis/analysis-api-routes-2025-11-21.md`
   - Content structure for Markdown:

     ```markdown
     # Comprehensive Code Analysis: {target}

     **Analysis Date:** {YYYY-MM-DD}
     **File Path:** {full_path}
     **Focus:** {type}
     **Total Lines:** {line_count}

     ## Executive Summary
     [High-level overview of findings]

     ## Detailed Analysis
     [Comprehensive analysis with sections]

     ## Actionable Next Steps

     ### Priority 1: Critical Issues
     - [ ] Item 1
     - [ ] Item 2

     ### Priority 2: Important Improvements
     - [ ] Item 1

     [Continue with all priorities]
     ```

4. **Verify and Report:**
   - After creating file, confirm it exists
   - Display full path to user: '✅ Analysis exported to: {full_path}'
   - If file creation fails, explain why and show the analysis in console

**Export Requirements:**

- File MUST contain complete analysis (not just summary)
- Include all findings, recommendations, and priorities
- Use proper Markdown formatting with headers and lists
- Include timestamps and metadata
- Structure with clear sections for easy navigation
- Add checkboxes [ ] for actionable items

**Example Success Message:**

```
✅ Analysis exported to: .docs/analysis/analysis-api-routes-2025-11-21.md

The analysis contains:
- Executive Summary
- 5 Priority levels with 16 actionable items
- Security findings (3 critical, 2 medium)
- Performance recommendations (4 high-impact)
- Code quality improvements (8 items)

Use this file with: /prefix:improve refactor {target} --from-analysis
```"
