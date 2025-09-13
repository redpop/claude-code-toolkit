# Claude Code Toolkit Agent Interface Specification

Version: 1.0.0  
Last Updated: 2025-01-29

## Table of Contents

1. [Overview](#overview)
2. [Agent Definition Format](#agent-definition-format)
3. [Agent Persona Specification](#agent-persona-specification)
4. [Communication Protocols](#communication-protocols)
5. [Input/Output Specifications](#inputoutput-specifications)
6. [Agent Capabilities](#agent-capabilities)
7. [Integration with Commands](#integration-with-commands)
8. [Agent Types and Specializations](#agent-types-and-specializations)
9. [Best Practices for Agent Design](#best-practices-for-agent-design)
10. [Implementation Examples](#implementation-examples)

## Overview

Claude Code Toolkit Sub-Agents are specialized AI personas defined as Markdown files that provide deep expertise in specific domains. They work within the Claude Code ecosystem to analyze code, provide insights, and guide improvements while maintaining strict boundaries on their actions.

### Key Principles

1. **Read-Only by Default**: Most agents are analysis-only and cannot modify files
2. **Domain Expertise**: Each agent has deep, focused knowledge in a specific area
3. **Structured Output**: Agents provide consistent, parseable output formats
4. **Tool Integration**: Agents can leverage MCP tools when available
5. **Context Isolation**: Agents work in separate contexts for focused analysis

## Agent Definition Format

### File Structure

Agent files are Markdown documents with YAML frontmatter stored in the `/agents/` directory:

```markdown
---
name: agent-identifier
description: Brief description of agent's expertise and purpose
type: specialist|analyzer|helper|research
expertise: Primary domain of expertise
version: Semantic version (e.g., 1.0.0)
capabilities:
  - Capability 1
  - Capability 2
tools:
  - Tool 1
  - Tool 2
mcp-enhanced: mcp__tool1, mcp__tool2 (optional)
---

[Agent persona and instructions in Markdown]
```

### Frontmatter Fields

| Field          | Required | Type   | Description                                                  |
| -------------- | -------- | ------ | ------------------------------------------------------------ |
| `name`         | Yes      | string | Unique identifier for the agent (lowercase, hyphenated)      |
| `description`  | Yes      | string | One-line description of agent's purpose                      |
| `type`         | No       | enum   | Agent classification: specialist, analyzer, helper, research |
| `expertise`    | No       | string | Primary domain of expertise                                  |
| `version`      | No       | string | Semantic version number                                      |
| `capabilities` | No       | array  | List of specific capabilities                                |
| `tools`        | No       | array  | Tools the agent can use                                      |
| `mcp-enhanced` | No       | string | Comma-separated list of MCP tools for enhancement            |

### Example Frontmatter

```yaml
---
name: security-specialist
description: Deep security analysis expert specializing in vulnerability detection, OWASP compliance, and security best practices
type: specialist
expertise: Application Security
version: 1.0.0
capabilities:
  - Vulnerability detection and analysis
  - OWASP Top 10 compliance checking
  - Security best practices guidance
  - Threat modeling
tools:
  - Read
  - Grep
  - Task
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
---
```

**Important**: Without the `name` field, Claude Code will fail to load the agent with an error:

```
Failed to parse agent file: Missing required "name" field in frontmatter
```

## Agent Persona Specification

### Structure Components

1. **Critical Instructions**

   ```markdown
   **CRITICAL: This is a READ-ONLY analysis agent. You MUST NOT create, modify, write, or delete ANY files.**
   ```

2. **Persona Introduction**

   ```markdown
   You are [role] with extensive experience in [domains]. Your role is to [primary purpose].
   ```

3. **Core Expertise Areas**

   - Detailed breakdown of knowledge domains
   - Specific skills and methodologies
   - Industry standards and frameworks

4. **Analysis Approach**

   - Step-by-step methodology
   - Specific techniques and patterns to look for
   - Prioritization criteria

5. **Output Format**
   - Structured templates for different scenarios
   - Consistent formatting guidelines
   - Example outputs

### Example Persona Definition

```markdown
You are a principal software architect with extensive experience in system design, architectural patterns, and building scalable software systems. Your role is to analyze code architecture, identify structural improvements, and guide developers toward better architectural decisions.

## Core Expertise Areas

1. **Architectural Patterns**

   - Microservices vs Monolithic architecture
   - Event-driven architecture
   - Domain-driven design (DDD)
   - Hexagonal/Clean architecture

2. **Design Principles**
   - SOLID principles application
   - DRY, KISS, YAGNI principles
   - Separation of concerns
```

## Communication Protocols

### Task Reception

Agents receive tasks through two primary mechanisms:

1. **Direct Invocation via Commands**

   ```markdown
   Delegate to @security-specialist:
   "READ-ONLY ANALYSIS. DO NOT MODIFY ANY FILES.
   Perform deep security analysis on: [specific files/patterns]
   Focus on: [identified vulnerabilities]
   Provide remediation strategies and secure code examples."
   ```

2. **Task Tool Integration**

   ```javascript
   Task(
     (description = "Security analysis"),
     (prompt = "[Detailed task instructions]"),
     (subagent_type = "security-specialist")
   );
   ```

### Context Passing

1. **File References**

   - Absolute paths to analyze
   - Glob patterns for broader analysis
   - Specific code snippets

2. **Analysis Parameters**

   - Focus areas
   - Severity thresholds
   - Output format preferences

3. **Prior Findings**
   - Results from Phase 1 scanning
   - Related issues from other agents
   - Historical context if available

### Response Protocol

Agents must:

1. Acknowledge the task scope
2. Indicate analysis method (MCP-enhanced or traditional)
3. Provide structured findings
4. Include confidence levels
5. Suggest next steps

## Input/Output Specifications

### Input Format

```typescript
interface AgentInput {
  task: string; // Task description
  context: {
    files?: string[]; // Files to analyze
    patterns?: string[]; // Patterns to search for
    findings?: Finding[]; // Prior findings to investigate
    parameters?: {
      // Analysis parameters
      severity?: "critical" | "high" | "medium" | "low";
      focus?: string[];
      depth?: "quick" | "standard" | "deep";
    };
  };
  constraints?: string[]; // Any specific constraints
}
```

### Output Format

```typescript
interface AgentOutput {
  summary: {
    analysisMethod: string; // e.g., "Semgrep MCP" | "Pattern-Based"
    confidence: number; // 0-100
    duration: number; // seconds
    issueCount: number;
  };
  findings: Finding[];
  recommendations: Recommendation[];
  metrics?: Record<string, any>;
}

interface Finding {
  id: string;
  category: string;
  severity: "critical" | "high" | "medium" | "low";
  title: string;
  description: string;
  location: {
    file: string;
    line?: number;
    column?: number;
  };
  evidence?: string;
  impact: string;
  remediation: string;
  references?: string[];
}

interface Recommendation {
  priority: "immediate" | "short-term" | "long-term";
  title: string;
  description: string;
  effort: string; // e.g., "2 hours", "1 day"
  impact: string;
  implementation?: string;
}
```

### Structured Report Templates

Agents should use consistent markdown templates:

```markdown
# [Analysis Type] Report

## Executive Summary

- **Analysis Method**: [Method used]
- **Confidence Level**: [High/Medium/Low]
- **Key Findings**: [Count and severity]

## Critical Findings

### [Finding Title]

- **Severity**: [Level]
- **Location**: [File:Line]
- **Impact**: [Description]
- **Remediation**: [Steps]

## Recommendations

### Immediate Actions

1. [Action with effort estimate]

### Long-term Improvements

1. [Strategic recommendation]
```

## Agent Capabilities

### Core Capabilities

1. **Analysis-Only Agents**

   - Read and analyze code
   - Generate reports and insights
   - Provide recommendations
   - Cannot modify files

2. **Report-Generating Agents**

   - All analysis capabilities
   - Can write report files when explicitly requested
   - Limited to specific output directories

3. **Tool-Enhanced Agents**
   - Leverage MCP tools when available
   - Graceful fallback to traditional methods
   - Report which tools were used

### Capability Boundaries

| Capability                      | Allowed | Not Allowed |
| ------------------------------- | ------- | ----------- |
| Read files                      | ✅      | -           |
| Analyze code patterns           | ✅      | -           |
| Generate insights               | ✅      | -           |
| Provide recommendations         | ✅      | -           |
| Export reports (when requested) | ✅      | -           |
| Modify source code              | ❌      | ✅          |
| Create source files             | ❌      | ✅          |
| Delete files                    | ❌      | ✅          |
| Execute code                    | ❌      | ✅          |
| Install packages                | ❌      | ✅          |

### MCP Tool Integration

When `mcp-enhanced` is specified:

```python
# Pseudo-code for tool selection
if mcp_tools_available(agent.mcp_enhanced):
    use_mcp_enhanced_analysis()
    report_method = "MCP-Enhanced"
else:
    use_traditional_analysis()
    report_method = "Pattern-Based"
```

## Integration with Commands

### Command Invocation Patterns

1. **Direct Sub-Agent Invocation**

   ```markdown
   Delegate to @agent-name:
   "[CONSTRAINTS]
   [TASK DESCRIPTION]
   [EXPECTED OUTPUT]"
   ```

2. **Hybrid Architecture Integration**

   ```markdown
   ## Phase 1: Parallel Scanning

   [Task Tool agents for quick scan]

   ## Phase 2: Expert Analysis

   [Delegate findings to specialized sub-agents]

   ## Phase 3: Synthesis

   [Combine all results]
   ```

3. **Conditional Delegation**

   ```markdown
   ### If security issues found (severity >= high):

   Delegate to @security-specialist:
   "..."

   ### If performance bottlenecks found:

   Delegate to @performance-optimizer:
   "..."
   ```

### Parameter Passing

Commands pass parameters to agents through:

1. **File Lists**: Specific files to analyze
2. **Pattern Specifications**: What to look for
3. **Focus Areas**: Specific concerns to address
4. **Prior Context**: Results from other phases
5. **Output Requirements**: Format and detail level

## Agent Types and Specializations

### Current Agent Roster

| Agent                             | Type       | Primary Domain          | Key Capabilities                          |
| --------------------------------- | ---------- | ----------------------- | ----------------------------------------- |
| `code-architect`                  | Specialist | Software Architecture   | System design, patterns, scalability      |
| `security-specialist`             | Specialist | Application Security    | Vulnerability detection, OWASP compliance |
| `performance-optimizer`           | Specialist | Performance Engineering | Bottleneck identification, optimization   |
| `test-engineer`                   | Specialist | Testing Strategy        | Coverage analysis, test design            |
| `refactoring-expert`              | Specialist | Code Quality            | Code smell detection, refactoring plans   |
| `documentation-health-specialist` | Analyzer   | Documentation Quality   | Doc-code sync, coverage analysis          |
| `report-analyzer`                 | Analyzer   | Data Analysis           | Trend detection, prioritization           |

### Agent Type Definitions

1. **Specialist Agents**

   - Deep expertise in specific domain
   - Provide authoritative guidance
   - Complex analysis capabilities
   - Domain-specific methodologies

2. **Analyzer Agents**

   - Focus on data processing and insights
   - Pattern recognition and trend analysis
   - Comparative analysis capabilities
   - Metric generation

3. **Helper Agents**

   - Task-specific assistance
   - Straightforward operations
   - Clear, focused outputs
   - Limited scope

4. **Research Agents**
   - Exploratory analysis
   - Information gathering
   - Cross-domain investigation
   - Comprehensive reporting

## Best Practices for Agent Design

### 1. Clear Boundaries

```markdown
**CRITICAL: This is a READ-ONLY analysis agent. You MUST NOT create, modify, write, or delete ANY files.**
```

- State constraints upfront
- Repeat critical limitations
- Use bold/caps for emphasis

### 2. Structured Expertise

```markdown
## Core Expertise Areas

1. **Primary Domain**

   - Specific skill 1
   - Specific skill 2

2. **Secondary Domains**
   - Related area 1
   - Related area 2
```

- Organize knowledge hierarchically
- Be specific about capabilities
- Include related domains

### 3. Methodical Approach

```markdown
## Analysis Approach

### 1. **Initial Assessment**

- Step 1
- Step 2

### 2. **Deep Analysis**

- Methodology
- Techniques
```

- Number steps clearly
- Provide specific techniques
- Include decision criteria

### 4. Consistent Output

````markdown
## Output Format

Structure your assessment as:

```markdown
# [Report Type]

## Executive Summary

[Template structure]
```
````

````

- Provide clear templates
- Use consistent formatting
- Include examples

### 5. Tool Awareness

```markdown
**TOOL AVAILABILITY NOTE**: When MCP tools are available, use them for enhanced analysis. Otherwise, use traditional methods.
````

- Check tool availability first
- Provide fallback methods
- Report which method was used

### 6. Quality Indicators

```markdown
## Best Practices

1. **Be Specific and Actionable**
   - Provide exact fixes
   - Include code examples
   - Reference documentation
```

- Set quality standards
- Provide guidance principles
- Include examples

### 7. Error Handling

- Acknowledge limitations
- Suggest alternatives when blocked
- Report confidence levels
- Identify when other agents needed

## Examples

### Security Analysis

**Invocation:**

```markdown
Delegate to @security-specialist:
"READ-ONLY. Analyze: src/api/auth/* Focus: Authentication vulnerabilities"
```

**Response:**

```markdown
# Security Report

## Summary
- Method: Semgrep MCP
- Critical: 2, High: 3

## Findings
### Session Validation Issue
- Severity: Critical
- Location: auth/session.js:45
- Fix: Validate session properly
```

### Performance Analysis

**Invocation:**

```markdown
Delegate to @performance-optimizer:
"Analyze O(n²) algorithm in search.js:42"
```

**Response:**

```markdown
# Performance Report

## Issue
- Complexity: O(n²) nested loops
- Impact: 25s for 10k items

## Solution
- Use O(n log n) algorithm
- Expected: 50x improvement
```

## Summary

Claude Code Toolkit agents are specialized AI personas providing domain expertise:

- **Format**: Markdown files with YAML frontmatter (`name` and `description` required)
- **Capabilities**: Read-only analysis, structured reporting, MCP tool integration
- **Integration**: Via commands (`Delegate to @agent`) or Task Tool
- **Best Practices**: Clear boundaries, structured output, graceful fallbacks

For templates, see `/templates/` in the repository.
