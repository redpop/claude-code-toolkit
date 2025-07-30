---
description: Apply the Five Whys root cause analysis technique to investigate issues
argument-hint: "[issue_description]"
---

**IMPORTANT: This is a READ-ONLY analysis command. Do NOT create, modify, or write any files. Only analyze and provide root cause analysis.**

# Claude Command: Five Whys Analysis

Apply the Five Whys root cause analysis technique to systematically investigate issues and identify their root causes. This command helps you drill down from surface-level symptoms to the fundamental reasons behind problems.

## Usage

```
/prefix:analysis:five-whys [issue_description]
```

## What This Command Does

1. **Problem Definition**: Clearly state the issue or symptom you're investigating
2. **Iterative Analysis**: Ask "why" at least 5 times to dig deeper into causes
3. **Root Cause Identification**: Discover the fundamental reason behind the problem
4. **Validation**: Work backwards to ensure the logic chain is sound
5. **Solution Development**: Propose fixes that address the root cause, not just symptoms

## Workflow Steps

### 1. Problem Statement
- Start with a clear, specific description of the issue
- Focus on observable symptoms or failures
- Include relevant context (when, where, how often)
- Avoid jumping to conclusions about causes

### 2. Five Whys Analysis
For each level, I will:
- Ask "Why did this happen?" or "Why is this occurring?"
- Document the answer based on evidence
- Examine if this is truly a cause or just another symptom
- Consider multiple possible reasons at each level
- Continue asking "why" for each answer

### 3. Root Cause Validation
- Review the chain of causation from root to symptom
- Verify each connection is logical and evidence-based
- Check if addressing the root cause would prevent recurrence
- Identify any additional contributing factors

### 4. Solution Development
- Propose solutions targeting the root cause
- Consider preventive measures to avoid recurrence
- Evaluate feasibility and impact of solutions
- Create action items with clear ownership

## Analysis Format

```
PROBLEM STATEMENT
├─ What is happening: [Observable issue]
├─ When it occurs: [Frequency/triggers]
├─ Impact: [Consequences]
└─ Initial context: [Relevant details]

FIVE WHYS ANALYSIS
Why 1: [First level cause]
  Evidence: [Supporting data/observations]
  
Why 2: [Second level cause]
  Evidence: [Supporting data/observations]
  
Why 3: [Third level cause]
  Evidence: [Supporting data/observations]
  
Why 4: [Fourth level cause]
  Evidence: [Supporting data/observations]
  
Why 5: [Fifth level cause - often the root]
  Evidence: [Supporting data/observations]

ROOT CAUSE SUMMARY
├─ Primary root cause: [Main underlying issue]
├─ Contributing factors: [Additional causes]
└─ Validation: [Why this is the true root]

RECOMMENDED SOLUTIONS
1. Immediate fix: [Address current problem]
2. Root cause fix: [Prevent recurrence]
3. Systemic improvement: [Process/system changes]
```

## Best Practices

### Effective Questioning
- Ask open-ended "why" questions
- Avoid leading questions that assume causes
- Focus on processes and systems, not blame
- Consider both technical and human factors
- Look for patterns across similar issues

### Common Pitfalls to Avoid
- Stopping at human error (dig deeper into why the error occurred)
- Accepting "lack of resources" without examining why resources are lacking
- Confusing correlation with causation
- Stopping too early when a deeper cause exists
- Focusing only on technical causes while ignoring process issues

### When to Go Beyond Five Whys
- Complex problems may need more than 5 iterations
- Multiple root causes may require separate analysis branches
- Stop when you reach a cause you can realistically address
- Continue if the current "root" is outside your control

## Example Analyses

### Example 1: Application Performance Issue
```
PROBLEM: Users report the dashboard loads slowly

Why 1: Database queries take too long
  → Why 2: Queries aren't using indexes
    → Why 3: Indexes were removed during migration
      → Why 4: Migration script had a bug
        → Why 5: No review process for migration scripts

ROOT CAUSE: Lack of code review process for database migrations
SOLUTION: Implement mandatory reviews for all migration scripts
```

### Example 2: Frequent Deployment Failures
```
PROBLEM: Production deployments fail 30% of the time

Why 1: Environment configuration mismatches
  → Why 2: Config files differ between staging and production
    → Why 3: Manual config updates aren't synchronized
      → Why 4: No centralized configuration management
        → Why 5: Team lacks awareness of config management tools

ROOT CAUSE: Missing configuration management strategy
SOLUTION: Implement centralized config management with automation
```

## Error Handling

The analysis handles:
- **Vague problem statements**: Will prompt for specific details
- **Circular reasoning**: Detects and breaks circular why chains
- **Multiple root causes**: Explores different causal branches
- **Insufficient information**: Identifies what data is needed
- **Premature conclusions**: Challenges assumptions with evidence

## Integration Points

### Documentation
- Generate analysis reports in markdown
- Create tickets for identified action items
- Link to relevant logs or monitoring data
- Reference similar past analyses

### Follow-up Actions
- Track implementation of solutions
- Schedule reviews to verify effectiveness
- Update runbooks with findings
- Share learnings with the team

## Important Notes

- The Five Whys technique is most effective for straightforward problems
- Complex issues may require additional analysis methods (fishbone diagrams, fault tree analysis)
- Always validate conclusions with data when possible
- Focus on systemic improvements, not quick fixes
- Document the analysis for future reference and learning

Remember: The goal isn't exactly five whys—it's finding the true root cause. Sometimes that takes 3 whys, sometimes 7. The key is to keep digging until you find a cause you can meaningfully address.