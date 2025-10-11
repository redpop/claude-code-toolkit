# Project Planner Agent

## Overview

The Project Planner is a knowledge-enhanced strategic development planning expert specializing in project architecture, comprehensive task decomposition, and intelligent resource allocation. This agent transforms complex requirements into actionable, well-structured development roadmaps optimized for the Claude Code Toolkit's 6-command architecture. With persistent learning capabilities through knowledge base integration, it accumulates project planning insights across initiatives to provide increasingly sophisticated strategic guidance based on proven methodologies and outcomes.

## Capabilities

- **Knowledge-Enhanced Strategic Intelligence**: Accesses similar project structures and successful approaches across projects for improved planning accuracy
- **Historical Learning Application**: Applies lessons learned from previous planning successes and challenges to optimize new project strategies
- **Context-Aware Planning**: Utilizes project-specific development history and architectural decisions for tailored roadmap creation
- **Toolkit Optimization**: Leverages deep understanding of Claude Code Toolkit's 6-command workflow for maximum development efficiency
- **Strategic Project Analysis**: Requirements analysis, technical feasibility assessment, architecture planning, technology stack evaluation, and resource estimation
- **Systematic Task Decomposition**: Breaking complex features into atomic tasks, creating parallel execution opportunities, establishing dependencies, and defining completion criteria
- **Development Roadmap Creation**: Multi-phase project structuring, milestone definition, risk identification, timeline estimation, and quality gate establishment
- **Agent Orchestration Planning**: Identifying optimal agent sequences, mapping specialists to deliverables, creating coordination protocols, and planning knowledge transfer

## Usage

### Direct Invocation

Use the Task tool to invoke the Project Planner directly:

```markdown
Use Task tool with subagent_type="project-planner":
"Create a comprehensive development roadmap for implementing OAuth2 authentication in our microservices platform. Include task decomposition, agent orchestration plan, risk assessment, and timeline with Claude Code Toolkit integration."
```

### Through Core Commands

The Project Planner is integrated with strategic toolkit workflows:

- **`/prefix:understand`**: Provides project analysis and requirement assessment for informed planning
- **`/prefix:create`**: Guides strategic planning document creation and roadmap development
- **`/prefix:improve`**: Optimizes existing project plans based on current progress and learnings
- **`/prefix:ship`**: Plans deployment strategies and release coordination workflows

## Output Format

The Project Planner delivers comprehensive strategic development plans in structured YAML format:

```yaml
# Strategic Development Plan
project_name: "[Project Name]"
generated_date: "[YYYY-MM-DD]"
planner_version: "1.0.0"
toolkit_optimization: true

## Executive Summary
overview: |
  [Comprehensive project overview with strategic approach and key insights]

key_objectives:
  - [SMART objective with measurable outcomes]
  - [Strategic goal with business value alignment]
  - [Technical objective with quality metrics]

success_metrics:
  - metric: "[Specific, measurable outcome]"
    target: "[Quantified target value]"
    timeline: "[Achievement timeframe]"

## Technology Stack & Architecture
recommended_stack:
  frontend: "[Technology choices with rationale and future-proofing considerations]"
  backend: "[Technology selections with scalability and maintainability factors]"
  database: "[Data architecture decisions with performance implications]"
  infrastructure: "[Infrastructure choices with cost and reliability factors]"

architecture_decisions:
  - decision: "[Strategic architectural choice]"
    rationale: "[Evidence-based reasoning for decision]"
    implications: "[Impact on development workflow and team structure]"

## Phase Structure
phases:
  - phase_name: "[Descriptive Phase Name]"
    duration: "[Realistic timeline estimate with buffer]"
    goals: "[Clear phase objectives and deliverables]"

    features:
      - feature_name: "[Feature Name]"
        priority: "high|medium|low"
        complexity: "simple|moderate|complex"
        estimated_effort: "[Evidence-based effort estimate]"

        tasks:
          - task_name: "[Atomic, actionable task description]"
            toolkit_command: "/understand|/improve|/create|/secure|/ship|/git"
            agent_assignment: "[optimal-specialist-agent]"
            effort_estimate: "[Hours with justification]"
            dependencies: ["[prerequisite-task-ids]"]
            acceptance_criteria:
              - "[Specific, testable criteria]"
              - "[Quality gate requirement]"

            claude_toolkit_workflow: |
              # Optimized command sequence:
              /prefix:understand . --analysis-focus="[specific-aspect]"
              /prefix:improve . --optimization-target="[improvement-area]"
              /prefix:create feature --implementation-approach="[strategy]"

## Agent Orchestration Plan
agent_sequences:
  - workflow_name: "[Strategic Workflow Name]"
    description: "[Workflow objectives and outcomes]"
    agents:
      - agent: "[specialist-agent-name]"
        role: "[Specific responsibility and expertise area]"
        inputs: "[Required information and context]"
        outputs: "[Expected deliverables and knowledge artifacts]"
        handoff_to: "[next-agent-in-sequence]"

## Risk Management
identified_risks:
  - category: "technical|resource|timeline|external"
    risk: "[Specific risk description with probability factors]"
    impact: "[Detailed consequence analysis]"
    mitigation: "[Proactive prevention strategies]"
    contingency: "[Reactive response plans]"
    owner: "[Responsible party for monitoring]"

## Timeline & Milestones
timeline:
  start_date: "[YYYY-MM-DD]"
  estimated_completion: "[YYYY-MM-DD with confidence intervals]"

milestones:
  - milestone: "[Achievement-focused milestone name]"
    date: "[Target completion date]"
    deliverables: ["[Concrete deliverable 1]", "[Measurable deliverable 2]"]
    success_criteria: "[Specific completion requirements]"
    review_process: "[Validation and approval workflow]"

## Quality Assurance Plan
quality_gates:
  - phase: "[Phase identifier]"
    standards: ["[Quality standard 1]", "[Performance benchmark 2]"]
    validation_approach: "[Testing and review methodology]"
    tools: ["[Automated tool 1]", "[Manual process 2]"]

## Resource Planning
team_requirements:
  - role: "[Specific role designation]"
    skills_needed: ["[Technical skill 1]", "[Domain expertise 2]"]
    time_commitment: "[Realistic availability requirement]"
    critical_periods: ["[High-demand phases and milestones]"]
```

## Examples

### Example 1: Microservices Platform Planning

```markdown
Use Task tool with subagent_type="project-planner":
"Create a strategic development plan for migrating our monolithic application to microservices architecture. Include service decomposition strategy, data migration planning, and team coordination protocols with 6-month timeline."
```

**Expected Output**: Comprehensive migration roadmap with phase-by-phase service extraction plan, data architecture evolution strategy, team skill development requirements, and risk mitigation protocols optimized for Claude Code Toolkit workflows.

### Example 2: AI Integration Project Planning

```markdown
Use Task tool with subagent_type="project-planner":
"Plan the integration of machine learning capabilities into our existing e-commerce platform. Focus on recommendation engine implementation, data pipeline architecture, and performance optimization with quality gates."
```

**Expected Output**: Strategic AI integration plan with ML pipeline architecture, data engineering requirements, model deployment strategies, performance benchmarking protocols, and agent orchestration for specialized AI development tasks.

### Example 3: Security Modernization Initiative

```markdown
Use Task tool with subagent_type="project-planner":
"Develop a comprehensive security modernization roadmap including OAuth2 implementation, security audit workflows, compliance validation, and team training programs with measurable security improvements."
```

**Expected Output**: Security transformation strategy with compliance framework implementation, security architecture evolution, team capability development plan, and continuous security validation workflows integrated with toolkit security commands.

## Tools Used

- **Read**: Analyzes existing project documentation, requirements, and architectural artifacts for comprehensive planning context
- **Grep**: Searches for project patterns, dependencies, and architectural elements to inform strategic decisions
- **Task**: Coordinates with specialized agents for domain-specific planning insights and captures strategic patterns
- **TodoWrite**: Creates structured task management artifacts for complex project coordination and progress tracking

## See Also

- [Code Architect](code-architect.md) - For architectural analysis and design decisions supporting strategic planning
- [Blueprint Architect](../../research/blueprint-architect.md) - For implementation blueprint creation and development planning
- [Requirements Analyst](../../research/requirements-analyst.md) - For detailed requirement analysis feeding into strategic planning
- [Code Understanding Specialist](../analysis/code-understanding-specialist.md) - For current state analysis informing project planning decisions
- [Security Specialist](../security/security-specialist.md) - For security planning integration and compliance roadmapping
- [Project Planning Guide](../../guides/PROJECT-PLANNING-GUIDE.md) - Comprehensive project planning methodologies and best practices
- [Agent Orchestration Guide](../../guides/AGENT-ORCHESTRATION.md) - Best practices for coordinating multiple specialists in complex projects
