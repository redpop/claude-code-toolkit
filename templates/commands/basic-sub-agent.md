---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*)
description: [Brief description of the command]
argument-hint: [expected-arguments]
---

# [Command Name]

[Detailed description of what this command does and when it should be used]

## Execution

**IMMEDIATELY START [N] PARALLEL AGENTS:**

1. **[Agent Name]**: Task(description="[Task Description]", prompt="[Detailed prompt for the agent. Describe exactly what should be analyzed, which tools should be used, and in what format the results should be returned. End with: Return results as JSON.]", subagent_type="general-purpose")

2. **[Agent Name]**: Task(description="[Task Description]", prompt="[Detailed prompt]", subagent_type="general-purpose")

3. **[Agent Name]**: Task(description="[Task Description]", prompt="[Detailed prompt]", subagent_type="general-purpose")

[Additional agents as needed...]

## Synthesis

After all agents complete:

1. **[Synthesis Step 1]**:
   - [Description of how results are merged]
   - [What prioritization is applied]

2. **[Synthesis Step 2]**:

   ```markdown
   # [Report Title]
   
   ## [Section 1]
   [Description of report format]
   
   ## [Section 2]
   [Additional sections]
   ```

3. **[Action Items]**:
   - [How concrete next steps are generated]
   - [What recommendations are given]

**Performance Expectation**: [X-Y seconds for parallel execution, compared to Z seconds sequentially]

**Notes**:

- [Special usage notes]
- [Limitations or prerequisites]
