---
allowed-tools: Task, Read, WebSearch, WebFetch, Grep, Bash(fd:*), Bash(rg:*)
description: Multi-Perspective Deep Research with 8 different viewpoints on a topic
argument-hint: [topic] [--depth=surface|medium|deep] [--focus=technical|business|all]
---

**IMPORTANT: This is a READ-ONLY research command. Do NOT create, modify, or write any files. Only research and report findings.**

# Deep Dive Research Command

This command conducts in-depth research on a topic by having 8 specialized agents investigate different perspectives in parallel.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Multi-Perspective Deep Research with 8 different viewpoints on a topic
- **Usage**: [topic] [--depth=surface|medium|deep] [--focus=technical|business|all]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Execution

**IMMEDIATELY START 8 PARALLEL RESEARCH AGENTS:**

1. **Technical Architecture Agent**:

Use Task tool with subagent_type="general-purpose":
"Conduct a technical analysis of '$ARGUMENTS'. Investigate: 1) Architecture patterns and design decisions, 2) Technology stack and dependencies, 3) Performance characteristics, 4) Scalability aspects, 5) Technical debt and limitations. Use code analysis and technical documentation. Return structured technical insights as Markdown."

2. **Best Practices Agent**:

Use Task tool with subagent_type="general-purpose":
"Research best practices and standards for '$ARGUMENTS'. Analyze: 1) Industry standards and guidelines, 2) Common patterns vs anti-patterns, 3) Security best practices, 4) Performance optimizations, 5) Testing strategies. Search in code and documentation for proven approaches. Return Best Practice Guide as Markdown."

3. **Implementation Examples Agent**:

Use Task tool with subagent_type="general-purpose":
"Find and analyze concrete implementations of '$ARGUMENTS'. Search: 1) Code examples in the codebase, 2) Usage patterns, 3) Edge case handlings, 4) Error handling strategies, 5) Configuration examples. Use grep and code search extensively. Return annotated code examples as Markdown."

4. **Problem & Solution Agent**:

Use Task tool with subagent_type="general-purpose":
"Identify common problems and solutions for '$ARGUMENTS'. Investigate: 1) Known issues and bugs, 2) Common pitfalls, 3) Troubleshooting guides, 4) Workarounds, 5) Migration challenges. Analyze code comments, issues, and error patterns. Return Problem-Solution Matrix as Markdown."

5. **Evolution & History Agent**:

Use Task tool with subagent_type="general-purpose":
"Analyze the evolution and history of '$ARGUMENTS'. Research: 1) Version history and breaking changes, 2) Design decisions evolution, 3) Deprecated features, 4) Future roadmap, 5) Community feedback. Use Git history, changelogs, and documentation. Return timeline with key milestones as Markdown."

6. **Integration Patterns Agent**:

Use Task tool with subagent_type="general-purpose":
"Examine integration aspects of '$ARGUMENTS'. Analyze: 1) API contracts and interfaces, 2) Integration points, 3) Data flow patterns, 4) Event-driven interactions, 5) Third-party integrations. Focus on interfaces and coupling. Return Integration Guide as Markdown."

7. **Performance & Scale Agent**:

Use Task tool with subagent_type="general-purpose":
"Deep-dive into performance aspects of '$ARGUMENTS'. Investigate: 1) Benchmark results, 2) Bottleneck analysis, 3) Optimization techniques, 4) Caching strategies, 5) Load testing results. Search for performance tests and profiling data. Return Performance Analysis Report as Markdown."

8. **Alternative Approaches Agent**:

Use Task tool with subagent_type="general-purpose":
"Research alternative approaches to '$ARGUMENTS'. Compare: 1) Competing solutions, 2) Different implementation strategies, 3) Trade-off analysis, 4) Migration paths, 5) Future technologies. Create objective comparison. Return Alternatives Comparison as Markdown."

## Synthesis

After completion of all Research Agents:

1. **Create Executive Summary**:

   ```markdown
   # Deep Dive: [Topic]

   ## Executive Summary

   [2-3 paragraph overview of the most important findings]

   ## Key Insights

   - Technical: [Most important technical insight]
   - Best Practice: [Most important best practice]
   - Performance: [Most important performance insight]
   - Future: [Most important future aspect]
   ```

2. **Structure Findings by Categories**:

   ```markdown
   ## Technical Architecture

   [Summary of Architecture Findings]

   ## Implementation Guide

   ### Best Practices

   [Consolidated Best Practices]

   ### Code Examples

   [Best code examples with explanations]

   ### Common Pitfalls

   [Most common errors and how to avoid them]
   ```

3. **Create Decision Matrix**:

   ```markdown
   ## Decision Guide

   ### When to Use [Topic]

   - Scenario 1: [Description]
   - Scenario 2: [Description]

   ### When NOT to Use

   - Scenario 1: [Description]
   - Alternative: [Better option]

   ### Trade-offs

   | Aspect      | Pros | Cons |
   | ----------- | ---- | ---- |
   | Performance | ...  | ...  |
   | Complexity  | ...  | ...  |
   | Maintenance | ...  | ...  |
   ```

4. **Generate Action Items**:

   ```markdown
   ## Recommended Actions

   ### Immediate (This Sprint)

   1. [Specific action based on findings]
   2. [Additional action]

   ### Short-term (Next Month)

   1. [Major improvement]
   2. [Refactoring suggestion]

   ### Long-term (Quarterly)

   1. [Strategic change]
   2. [Architecture Evolution]
   ```

5. **Create Knowledge Base Entry**:
   - Summary for team wiki
   - FAQ based on Common Problems
   - Implementation checklist
   - Links to relevant resources

**Performance Expectation**: Deep Dive in 6-8 seconds, compared to 45-60 seconds sequentially.

**Output Format**: Structured Markdown document, ready for Confluence/Wiki or as technical documentation.
