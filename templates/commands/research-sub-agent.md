---
allowed-tools: Task, Read, WebSearch, WebFetch, Grep, Bash(fd:*), Bash(rg:*)
description: Template for research commands that search various information sources in parallel
argument-hint: [research-topic] [--scope=local|web|all]
---

# [Research Command Name]

This command performs comprehensive research on [topic] by having [N] specialized research agents investigate different aspects in parallel.

## Research Strategy

The research covers the following areas:
- **Technical Perspective**: [Description]
- **Practical Implementation**: [Description]
- **Best Practices & Standards**: [Description]
- **Problems & Solutions**: [Description]

## Execution

**IMMEDIATELY START [N] PARALLEL RESEARCH AGENTS:**

1. **Technical Documentation Agent**: Task(description="Research Technical Docs", prompt="Research technical documentation for '$ARGUMENTS'. Investigate: 1) Official documentation, 2) API references, 3) Architecture guides, 4) Technical specifications. Focus on [main aspects]. Use local docs and code comments. Return structured technical insights as Markdown.", subagent_type="general-purpose")

2. **Implementation Examples Agent**: Task(description="Find Implementation Examples", prompt="Find concrete implementation examples for '$ARGUMENTS'. Search: 1) Code examples in the codebase, 2) Common usage patterns, 3) Real-world implementations, 4) Test cases as examples. Use grep/rg extensively. Return annotated code examples with explanations as Markdown.", subagent_type="general-purpose")

3. **Problem Analysis Agent**: Task(description="Research Common Problems", prompt="Identify common problems and solutions for '$ARGUMENTS'. Research: 1) Known issues and bugs, 2) Common pitfalls, 3) Troubleshooting patterns, 4) Workarounds. Analyze code comments, TODOs, and error handling. Return problem-solution matrix as Markdown.", subagent_type="general-purpose")

4. **Best Practices Agent**: Task(description="Compile Best Practices", prompt="Collect best practices for '$ARGUMENTS'. Analyze: 1) Coding standards, 2) Design patterns, 3) Performance optimizations, 4) Security considerations. Search in style guides and established patterns. Return best practice guide as Markdown.", subagent_type="general-purpose")

[Additional research agents as needed...]

## Synthesis

After all research agents complete:

1. **Create Comprehensive Knowledge Base**:
   ```markdown
   # [Topic] Research Findings
   
   ## Overview
   [2-3 paragraph summary of key findings]
   
   ## Key Insights
   
   ### Technical Foundation
   [Consolidated technical insights]
   
   ### Implementation Guide
   #### Recommended Approach
   [Step-by-step guide based on best practices]
   
   #### Code Examples
   ```[language]
   // Best example from research
   ```
   
   ### Common Challenges & Solutions
   | Challenge | Solution | Example |
   |-----------|----------|---------|
   | ...       | ...      | ...     |
   ```

2. **Generate Decision Matrix**:
   ```markdown
   ## Decision Guide
   
   ### When to Use [Topic]
   ✅ Scenario 1: [Description]
   ✅ Scenario 2: [Description]
   
   ### When to Avoid
   ❌ Scenario 1: [Description]
   ❌ Alternative: [Better option]
   
   ### Comparison with Alternatives
   | Aspect | [Topic] | Alternative 1 | Alternative 2 |
   |--------|---------|---------------|---------------|
   | ...    | ...     | ...           | ...           |
   ```

3. **Create Learning Path**:
   - Beginner: Start here
   - Intermediate: These concepts
   - Advanced: These optimizations

4. **Compile Resource List**:
   - Key documentation
   - Helpful tools
   - Community resources
   - Further reading

**Performance Expectation**: Research completed in [X-Y] seconds.

**Output**: Complete Markdown document, ready for team wiki or documentation.