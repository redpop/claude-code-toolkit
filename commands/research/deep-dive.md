---
allowed-tools: Task, Read, WebSearch, WebFetch, Grep, Bash(fd:*), Bash(rg:*)
description: Multi-Perspective Deep Research with 8 different viewpoints on a topic
argument-hint: [topic] [--depth=surface|medium|deep] [--focus=technical|business|all]
---

# Deep Dive Research Command

This command conducts in-depth research on a topic by having 8 specialized agents investigate different perspectives in parallel.

## Execution

**IMMEDIATELY START 8 PARALLEL RESEARCH AGENTS:**

1. **Technical Architecture Agent**: Task(description="Technical Deep Dive", prompt="Conduct a technical analysis of '$ARGUMENTS'. Investigate: 1) Architecture patterns and design decisions, 2) Technology stack and dependencies, 3) Performance characteristics, 4) Scalability aspects, 5) Technical debt and limitations. Use code analysis and technical documentation. Return structured technical insights as Markdown.", subagent_type="general-purpose")

2. **Best Practices Agent**: Task(description="Industry Best Practices", prompt="Research best practices and standards for '$ARGUMENTS'. Analyze: 1) Industry standards and guidelines, 2) Common patterns vs anti-patterns, 3) Security best practices, 4) Performance optimizations, 5) Testing strategies. Search in code and documentation for proven approaches. Return Best Practice Guide as Markdown.", subagent_type="general-purpose")

3. **Implementation Examples Agent**: Task(description="Real-World Implementations", prompt="Find and analyze concrete implementations of '$ARGUMENTS'. Search: 1) Code examples in the codebase, 2) Usage patterns, 3) Edge case handlings, 4) Error handling strategies, 5) Configuration examples. Use grep and code search extensively. Return annotated code examples as Markdown.", subagent_type="general-purpose")

4. **Problem & Solution Agent**: Task(description="Common Problems Analysis", prompt="Identify common problems and solutions for '$ARGUMENTS'. Investigate: 1) Known issues and bugs, 2) Common pitfalls, 3) Troubleshooting guides, 4) Workarounds, 5) Migration challenges. Analyze code comments, issues, and error patterns. Return Problem-Solution Matrix as Markdown.", subagent_type="general-purpose")

5. **Evolution & History Agent**: Task(description="Historical Evolution", prompt="Analyze the evolution and history of '$ARGUMENTS'. Research: 1) Version history and breaking changes, 2) Design decisions evolution, 3) Deprecated features, 4) Future roadmap, 5) Community feedback. Use Git history, changelogs, and documentation. Return timeline with key milestones as Markdown.", subagent_type="general-purpose")

6. **Integration Patterns Agent**: Task(description="Integration Analysis", prompt="Examine integration aspects of '$ARGUMENTS'. Analyze: 1) API contracts and interfaces, 2) Integration points, 3) Data flow patterns, 4) Event-driven interactions, 5) Third-party integrations. Focus on interfaces and coupling. Return Integration Guide as Markdown.", subagent_type="general-purpose")

7. **Performance & Scale Agent**: Task(description="Performance Research", prompt="Deep-dive into performance aspects of '$ARGUMENTS'. Investigate: 1) Benchmark results, 2) Bottleneck analysis, 3) Optimization techniques, 4) Caching strategies, 5) Load testing results. Search for performance tests and profiling data. Return Performance Analysis Report as Markdown.", subagent_type="general-purpose")

8. **Alternative Approaches Agent**: Task(description="Alternative Solutions", prompt="Research alternative approaches to '$ARGUMENTS'. Compare: 1) Competing solutions, 2) Different implementation strategies, 3) Trade-off analysis, 4) Migration paths, 5) Future technologies. Create objective comparison. Return Alternatives Comparison as Markdown.", subagent_type="general-purpose")

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
   | Aspect | Pros | Cons |
   |--------|------|------|
   | Performance | ... | ... |
   | Complexity | ... | ... |
   | Maintenance | ... | ... |
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