# Split-Role Sub-Agents Design Document

## Overview

Split-Role Sub-Agents enable multiple perspectives to analyze the same problem simultaneously, providing comprehensive multi-faceted insights that reduce blind spots and enhance decision-making quality.

## Core Concept

### Traditional Single-Agent Analysis

```
User Request → Single Agent → Single Perspective → Limited Analysis
```

### Split-Role Multi-Agent Analysis

```
User Request → Orchestrator → Multiple Agents → Multiple Perspectives → Comprehensive Analysis
                             ├─ Security Expert
                             ├─ Senior Engineer
                             ├─ Performance Analyst
                             └─ Creative Innovator
```

## Architecture Design

### 1. Perspective Definitions

Each perspective focuses on specific aspects:

```yaml
perspectives:
  security_expert:
    focus: "Security vulnerabilities, attack vectors, compliance"
    questions:
      - "What security risks does this code introduce?"
      - "Are there any OWASP Top 10 vulnerabilities?"
      - "How can we strengthen authentication/authorization?"

  senior_engineer:
    focus: "Architecture, maintainability, best practices"
    questions:
      - "Is this code following SOLID principles?"
      - "How will this scale with growth?"
      - "What are the long-term maintenance implications?"

  performance_analyst:
    focus: "Speed, efficiency, resource optimization"
    questions:
      - "Where are the performance bottlenecks?"
      - "How can we optimize memory usage?"
      - "Are there unnecessary computations?"

  creative_innovator:
    focus: "Alternative approaches, modern patterns"
    questions:
      - "What alternative approaches exist?"
      - "How could we leverage modern libraries/patterns?"
      - "What would a complete redesign look like?"
```

### 2. Implementation Structure

#### Directory Layout

```
agents/
├── split-role-analyzer.md          # Main orchestrator
└── perspectives/
    ├── security-perspective.md     # Security expert viewpoint
    ├── senior-perspective.md       # Senior engineer viewpoint
    ├── performance-perspective.md  # Performance analyst viewpoint
    └── creative-perspective.md     # Creative innovator viewpoint
```

#### Agent Frontmatter Structure

```yaml
---
name: split-role-analyzer
description: Orchestrates multi-perspective analysis using specialized viewpoints
category: orchestrator
tools: Read, Grep, Task
model: opus
perspectives:
  - security-perspective
  - senior-perspective
  - performance-perspective
  - creative-perspective
parallel: true
---
```

### 3. Invocation Patterns

#### Command Integration

```bash
# Full multi-perspective analysis
/prefix:analyze . --split-role

# Specific perspectives only
/prefix:analyze auth.js --split-role --perspectives="security,senior"

# With custom focus
/prefix:analyze . --split-role --focus="authentication system"
```

#### Task Tool Integration

```markdown
Use Task tool with subagent_type="split-role-analyzer":
"Analyze the user authentication system from security, architecture, and performance perspectives. Focus on identifying vulnerabilities, design improvements, and optimization opportunities."
```

#### Direct Perspective Access

```bash
# Individual perspective analysis
/prefix:analyze . --perspective="security"
/prefix:analyze . --perspective="performance"
```

## Implementation Details

### 1. Split-Role Analyzer Agent

```markdown
# Split-Role Analyzer

You are a master orchestrator that coordinates multiple expert perspectives to provide comprehensive analysis. Your role is to:

1. **Decompose the analysis request** into perspective-specific tasks
2. **Invoke specialized perspective agents** in parallel using Task tool
3. **Synthesize insights** from all perspectives into unified recommendations
4. **Identify conflicts** and provide balanced resolution suggestions

## Analysis Process

### Step 1: Request Decomposition
- Identify the code/system to analyze
- Determine which perspectives are most relevant
- Create focused analysis prompts for each perspective

### Step 2: Parallel Perspective Analysis
- Launch security perspective agent
- Launch senior engineer perspective agent
- Launch performance perspective agent
- Launch creative innovator perspective agent

### Step 3: Result Synthesis
- Collect insights from all perspectives
- Identify overlapping concerns
- Resolve conflicting recommendations
- Prioritize improvements by impact and effort

### Step 4: Unified Recommendations
- Present consolidated findings
- Provide implementation roadmap
- Suggest next steps for each perspective area
```

### 2. Perspective Agent Template

```markdown
# [Perspective Name] Agent

You are a [role] providing specialized analysis from your expert perspective.

## Your Focus Areas
[List of specific concerns for this perspective]

## Analysis Questions
[Key questions to address in every analysis]

## Analysis Format

### [Perspective] Assessment
**Current State**: [Brief evaluation]
**Key Findings**: [3-5 bullet points]
**Risk Level**: [High/Medium/Low with justification]

### Specific Issues
1. **[Issue Name]**
   - Problem: [Description]
   - Impact: [Consequences]
   - Recommendation: [Specific solution]

### Recommendations
**Immediate Actions**: [Quick wins]
**Short-term Goals**: [2-4 weeks]
**Long-term Strategy**: [Strategic improvements]

### Implementation Notes
[Perspective-specific implementation considerations]
```

### 3. Parallel Processing Logic

```markdown
## Orchestration Flow

1. **Receive Analysis Request**
   - Parse target (files, directories, specific components)
   - Identify scope and focus areas
   - Determine relevant perspectives

2. **Launch Parallel Analysis**
   ```python
   # Pseudo-code for parallel invocation
   perspectives = ['security', 'senior', 'performance', 'creative']
   results = []

   for perspective in perspectives:
       task = create_task(
           subagent_type=f"{perspective}-perspective",
           prompt=f"Analyze {target} from {perspective} viewpoint"
       )
       results.append(launch_parallel(task))

   return aggregate_results(results)
   ```

3. **Result Aggregation**
   - Collect all perspective reports
   - Identify common themes
   - Resolve conflicting recommendations
   - Create unified action plan

```

## Output Format

### Comprehensive Analysis Report

```markdown
# Multi-Perspective Analysis: [Target]

## Executive Summary
[High-level findings and recommendations across all perspectives]

## Perspective Insights

### 🔒 Security Analysis
[Security expert findings with risk assessment]

### 🏗️ Architecture Analysis
[Senior engineer findings with maintainability focus]

### ⚡ Performance Analysis
[Performance analyst findings with optimization opportunities]

### 💡 Innovation Analysis
[Creative innovator findings with alternative approaches]

## Cross-Perspective Synthesis

### Consensus Recommendations
[Areas where all perspectives agree]

### Balanced Trade-offs
[Areas with conflicting recommendations and suggested resolution]

### Priority Matrix
| Priority | Security | Architecture | Performance | Innovation |
|----------|----------|--------------|-------------|------------|
| High     | [items]  | [items]      | [items]     | [items]    |
| Medium   | [items]  | [items]      | [items]     | [items]    |
| Low      | [items]  | [items]      | [items]     | [items]    |

## Implementation Roadmap

### Phase 1: Critical Issues (Week 1-2)
[Highest priority items across all perspectives]

### Phase 2: Core Improvements (Week 3-6)
[Medium priority architectural and performance improvements]

### Phase 3: Strategic Enhancements (Week 7-12)
[Long-term innovation and optimization initiatives]
```

## Integration with Existing Commands

### 1. Enhanced /understand Command

```bash
# Traditional single-perspective understanding
/prefix:understand .

# Multi-perspective comprehensive understanding
/prefix:understand . --split-role --comprehensive
```

### 2. Enhanced /improve Command

```bash
# Apply improvements from all perspectives
/prefix:improve . --split-role --apply-insights
```

### 3. Enhanced /secure Command

```bash
# Security-focused with architectural considerations
/prefix:secure . --split-role --focus="security,architecture"
```

## Benefits and Use Cases

### Benefits

- **Comprehensive Coverage**: No blind spots in analysis
- **Balanced Perspective**: Multiple viewpoints prevent tunnel vision
- **Parallel Efficiency**: Faster than sequential analysis
- **Quality Assurance**: Cross-validation of recommendations
- **Learning Opportunity**: Exposure to different expert approaches

### Ideal Use Cases

- **Legacy System Analysis**: Understanding complex, undocumented systems
- **Security Audits**: Comprehensive vulnerability assessment
- **Performance Optimization**: Multi-angle performance improvement
- **Architecture Reviews**: Holistic system design evaluation
- **Code Quality Assessment**: 360-degree code health analysis

### Example Scenarios

```bash
# Before major refactoring
/prefix:analyze legacy-auth-system/ --split-role

# Security compliance review
/prefix:analyze api/ --split-role --perspectives="security,architecture"

# Performance optimization planning
/prefix:analyze data-processing/ --split-role --focus="performance,architecture"

# Innovation opportunity assessment
/prefix:analyze user-interface/ --split-role --perspectives="creative,senior"
```

## Technical Considerations

### Context Window Management

- Each perspective agent gets isolated context
- Lean analysis prompts to maximize efficiency
- Aggregation happens at orchestrator level

### Error Handling

- Graceful degradation if some perspectives fail
- Timeout handling for parallel processing
- Partial results still provide value

### Performance Optimization

- Perspective agents can run truly parallel
- Caching of common analysis components
- Smart perspective selection based on code type

## Future Enhancements

### Dynamic Perspective Selection

- AI-driven perspective relevance assessment
- Custom perspective definitions
- Domain-specific perspective sets (e.g., TYPO3, React, etc.)

### Interactive Analysis

- Follow-up questions per perspective
- Deep-dive analysis on specific findings
- Progressive refinement of recommendations

### Integration Opportunities

- Export to project planning tools
- Integration with CI/CD pipelines
- Automated periodic analysis scheduling

---

*Document Version: 1.0*
*Created: 2025-09-16*
*Part of: Agent System Enhancement Plan*
