---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(ast-grep:*)
description: Template for code analysis commands with multiple specialized agents
argument-hint: [target] [--option=value]
---

# [Analysis Command Name]

This command analyzes [description] using [N] specialized agents working in parallel.

## Analysis Strategy

The analysis is divided into the following areas:
- **Structural Analysis**: [Description]
- **Qualitative Analysis**: [Description]
- **Quantitative Metrics**: [Description]

## Execution

**IMMEDIATELY START [N] PARALLEL ANALYSIS AGENTS:**

1. **Structure Analysis Agent**: Task(description="Analyze Code Structure", prompt="Analyze the structure of $ARGUMENTS. Examine: 1) [Aspect 1], 2) [Aspect 2], 3) [Aspect 3]. Use ast-grep for precise AST analysis. Focus on [main focus]. Return structured findings as JSON with schema: {findings: [{type, location, severity, description, suggestion}]}.", subagent_type="general-purpose")

2. **Pattern Detection Agent**: Task(description="Detect Code Patterns", prompt="Identify patterns in $ARGUMENTS. Search for: 1) [Pattern 1], 2) [Pattern 2], 3) Anti-patterns like [examples]. Use rg with advanced regex patterns. Return found patterns as JSON with schema: {patterns: [{name, occurrences, locations, impact}]}.", subagent_type="general-purpose")

3. **Metrics Calculation Agent**: Task(description="Calculate Metrics", prompt="Calculate metrics for $ARGUMENTS. Capture: 1) [Metric 1], 2) [Metric 2], 3) [Metric 3]. Use statistical analysis for trends. Return metrics dashboard as JSON with schema: {metrics: {metric_name: {value, trend, benchmark}}}.", subagent_type="general-purpose")

[Additional specialized agents...]

## Synthesis

After all analysis agents complete:

1. **Consolidate Findings**:
   - Deduplicate overlapping findings
   - Group by severity
   - Identify patterns across multiple agents

2. **Create Analysis Dashboard**:
   ```markdown
   # [Analysis Type] Report
   
   ## Executive Summary
   - Overall Score: [Score/Grade]
   - Critical Issues: [Count]
   - Improvement Areas: [Top 3]
   
   ## Detailed Findings
   
   ### Critical Issues
   | Issue | Location | Impact | Fix Effort |
   |-------|----------|--------|------------|
   | ...   | ...      | ...    | ...        |
   
   ### Recommendations
   1. **Immediate Actions**
      - [Action 1]
      - [Action 2]
   
   2. **Short-term Improvements**
      - [Improvement 1]
      - [Improvement 2]
   ```

3. **Generate Visualizations**:
   ```mermaid
   pie title Issue Distribution
     "Critical" : [count]
     "High" : [count]
     "Medium" : [count]
     "Low" : [count]
   ```

4. **Create Fix Priorities**:
   - ROI-based prioritization
   - Consider dependencies
   - Plan team capacity

**Performance Expectation**: Analysis completed in [X-Y] seconds, [Z]x faster than sequential.

**Output Formats**: 
- JSON for tool integration
- Markdown for human-readable reports
- CSV for data export