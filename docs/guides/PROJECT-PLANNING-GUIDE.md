# Project Planning Guide - Strategic Development with Claude Code Toolkit

**Version:** 1.0.0
**Agent:** project-planner
**Integration:** 6-Command Architecture

## Overview

The Claude Code Toolkit includes a sophisticated **project-planner** agent that transforms complex development requirements into structured, executable roadmaps. Unlike generic planning tools, this agent is specifically optimized for the toolkit's 6-command architecture and specialized agent ecosystem.

## 🎯 When to Use Project Planning

### Ideal Scenarios

- **Complex Feature Development**: Multi-component features requiring orchestrated development
- **System Architecture Changes**: Major refactoring or architectural evolution
- **Integration Projects**: Adding new technologies or external systems
- **Quality Improvement Initiatives**: Systematic technical debt reduction
- **Security Enhancement Projects**: Comprehensive security upgrades
- **Performance Optimization Programs**: Multi-phase performance improvements

### Project Complexity Indicators

- **High Complexity**: >20 files affected, multiple agents needed, cross-system integration
- **Medium Complexity**: 5-20 files, specialized domain knowledge required
- **Low Complexity**: <5 files, single-agent capable

## 🚀 Integration with 6-Command Architecture

The project-planner maps all tasks to optimal toolkit commands:

### Command-Specific Planning

| Command | Task Types | Planning Focus |
|---------|------------|----------------|
| **`/understand`** | Analysis, exploration, assessment | Code comprehension, architecture analysis, impact assessment |
| **`/improve`** | Refactoring, optimization, enhancement | Code quality improvements, performance optimization, technical debt reduction |
| **`/create`** | Development, documentation, setup | New feature implementation, documentation creation, configuration setup |
| **`/secure`** | Security audits, compliance, fixes | Security reviews, vulnerability remediation, compliance validation |
| **`/ship`** | Deployment, quality assurance | Release preparation, quality validation, deployment coordination |
| **`/git`** | Version control, collaboration | Branch strategy, collaboration workflows, release management |

### Example Task Mapping

```yaml
# Strategic task decomposition
task_name: "Implement OAuth2 Authentication"
toolkit_command: "/create"
agent_assignment: "security-specialist"
claude_toolkit_workflow: |
  /prefix:understand . --security-analysis
  /prefix:secure . --authentication-design
  /prefix:create auth --oauth2-implementation
  /prefix:ship . --security-validation
```

## 📋 Usage Patterns

### 1. Strategic Project Planning

**Use Case**: Large-scale feature development or system changes

```bash
# Command integration
/prefix:understand . --strategic-planning

# Agent invocation
Use Task tool with subagent_type="project-planner":
"Create comprehensive development plan for user authentication system with OAuth2,
including security considerations, testing strategy, and deployment approach."
```

**Output**: Complete YAML-based development roadmap with:

- Multi-phase implementation strategy
- Task decomposition with effort estimates
- Agent orchestration sequences
- Risk assessment and mitigation plans
- Quality gates and success metrics

### 2. Architecture Evolution Planning

**Use Case**: Major architectural changes or technology migrations

```bash
# Command integration
/prefix:improve . --architecture-evolution

# Agent invocation
Use Task tool with subagent_type="project-planner":
"Plan migration from monolithic architecture to microservices, including database
refactoring, API design, and gradual migration strategy."
```

**Output**: Structured migration plan with:

- Dependency analysis and sequencing
- Risk mitigation strategies
- Rollback procedures
- Performance validation checkpoints

### 3. Quality Improvement Programs

**Use Case**: Systematic code quality and technical debt reduction

```bash
# Command integration
/prefix:improve . --quality-program

# Agent invocation
Use Task tool with subagent_type="project-planner":
"Design 6-week technical debt reduction program focusing on performance, security,
and maintainability improvements across the entire codebase."
```

**Output**: Quality improvement roadmap with:

- Prioritized improvement areas
- Measurement and validation approaches
- Team coordination and knowledge transfer
- Continuous improvement processes

## 🔧 Agent Orchestration Planning

The project-planner excels at designing complex agent workflows:

### Example: Full-Stack Feature Development

```yaml
agent_sequences:
  - workflow_name: "E-commerce Checkout Implementation"
    description: "Complete checkout system with payment integration"
    agents:
      - agent: "code-architect"
        role: "System design and database schema"
        inputs: "Requirements and existing architecture"
        outputs: "Architecture decisions and database design"
        handoff_to: "frontend-specialist"

      - agent: "frontend-specialist"
        role: "UI implementation and user experience"
        inputs: "Design specifications and API contracts"
        outputs: "React components and user workflows"
        handoff_to: "security-specialist"

      - agent: "security-specialist"
        role: "Payment security and PCI compliance"
        inputs: "Payment flow and security requirements"
        outputs: "Security implementation and validation"
        handoff_to: "test-engineer"

      - agent: "test-engineer"
        role: "Comprehensive testing strategy"
        inputs: "Complete implementation and security measures"
        outputs: "Test suites and quality validation"
        handoff_to: "deployment-specialist"

      - agent: "deployment-specialist"
        role: "Production deployment and monitoring"
        inputs: "Tested implementation and deployment requirements"
        outputs: "Deployment pipeline and monitoring setup"
```

### Knowledge Transfer Planning

```yaml
knowledge_transfer:
  - checkpoint: "Architecture Decision Review"
    knowledge_items:
      - "Database schema rationale"
      - "API design principles"
      - "Security architecture decisions"
    documentation_required: "Architecture Decision Records (ADRs)"

  - checkpoint: "Implementation Handoff"
    knowledge_items:
      - "Component interaction patterns"
      - "Error handling strategies"
      - "Performance optimization techniques"
    documentation_required: "Implementation guides and code comments"
```

## 🎯 Output Formats and Templates

### Strategic Development Plan Structure

The project-planner generates comprehensive YAML-based plans:

```yaml
# Complete example structure
project_name: "User Authentication System"
generated_date: "2024-01-15"
planner_version: "1.0.0"
toolkit_optimization: true

executive_summary:
  overview: |
    Implementation of comprehensive OAuth2 authentication system
    with multi-factor authentication and role-based access control
  key_objectives:
    - Secure user authentication and authorization
    - Seamless integration with existing system
    - Compliance with security standards
  success_metrics:
    - metric: "Authentication response time"
      target: "<200ms"
      timeline: "End of Phase 2"
    - metric: "Security compliance score"
      target: "100% OWASP ASVS Level 2"
      timeline: "Before production deployment"

phases:
  - phase_name: "Foundation & Security Design"
    duration: "1 week"
    goals: "Security architecture and core authentication logic"
    deliverables:
      - "OAuth2 provider integration"
      - "User model and database schema"
      - "Security policy framework"

    features:
      - feature_name: "OAuth2 Integration"
        priority: "high"
        complexity: "complex"
        estimated_effort: "3 days"

        tasks:
          - task_name: "OAuth2 Provider Configuration"
            toolkit_command: "/create"
            agent_assignment: "security-specialist"
            effort_estimate: "8 hours"
            dependencies: []
            acceptance_criteria:
              - "OAuth2 flow successfully authenticates test users"
              - "Token validation and refresh mechanism works"
              - "Security headers and CSRF protection implemented"

            claude_toolkit_workflow: |
              # Recommended command sequence:
              /prefix:understand . --security-requirements
              /prefix:secure . --oauth2-design
              /prefix:create auth --oauth2-implementation
              /prefix:ship . --security-validation

        risks:
          - risk: "OAuth2 provider service disruption"
            impact: "high"
            probability: "low"
            mitigation: "Implement fallback authentication mechanism"

timeline:
  start_date: "2024-01-15"
  estimated_completion: "2024-02-05"

milestones:
  - milestone: "Security Foundation Complete"
    date: "2024-01-22"
    deliverables: ["OAuth2 integration", "User authentication flow"]
    success_criteria: "All security tests pass"
    review_process: "Security specialist validation"

quality_gates:
  - phase: "Security Implementation"
    standards: ["OWASP ASVS Level 2", "OAuth2 RFC compliance"]
    validation_approach: "Automated security testing + manual review"
    tools: ["security-specialist agent", "OWASP ZAP", "Custom tests"]
```

## 📊 Best Practices

### 1. Effective Planning Strategies

**Start with Clear Objectives**

- Define measurable success criteria
- Identify key stakeholders and constraints
- Document assumptions and dependencies

**Leverage Toolkit Strengths**

- Map every task to optimal commands
- Plan agent orchestration for knowledge transfer
- Use specialized agents for domain expertise

**Plan for Adaptability**

- Build in decision points and review cycles
- Create modular deliverables
- Plan iterative validation approaches

### 2. Agent Orchestration Optimization

**Sequence Planning**

- Start with analysis agents (code-architect, security-specialist)
- Progress through implementation agents (frontend-specialist, etc.)
- End with validation agents (test-engineer, deployment-specialist)

**Knowledge Transfer**

- Plan explicit handoff points between agents
- Document key decisions and rationale
- Create reusable patterns and templates

**Quality Validation**

- Include quality gates at each phase
- Plan both automated and manual validation
- Establish clear acceptance criteria

### 3. Risk Management

**Proactive Risk Identification**

- Technical risks (complexity, integration challenges)
- Resource risks (skill gaps, availability)
- External risks (dependencies, changing requirements)

**Mitigation Strategies**

- Plan research spikes for unknowns
- Create fallback options for high-risk items
- Build buffer time into estimates

## 🔍 Integration Examples

### Example 1: Smart Suggestions System

**Scenario**: Implementing the Smart Suggestions System designed earlier

**Planning Command**:

```bash
Use Task tool with subagent_type="project-planner":
"Create strategic plan for Smart Suggestions System with 3-phase implementation
over 3 weeks. Must extend existing hooks, provide user configuration, and
integrate with 6-command architecture. Performance requirement: <10ms impact."
```

**Key Planning Elements**:

- **Phase 1**: Foundation (hook extension, basic patterns)
- **Phase 2**: Intelligence (context analysis, agent integration)
- **Phase 3**: Enhancement (learning system, optimization)
- **Agent Sequence**: workflow-optimizer → performance-optimizer → test-engineer

### Example 2: API Development Project

**Scenario**: Building comprehensive REST API with authentication

**Planning Command**:

```bash
Use Task tool with subagent_type="project-planner":
"Design development plan for REST API with authentication, rate limiting,
documentation, and monitoring. Include database design, security validation,
and deployment strategy."
```

**Key Planning Elements**:

- **Architecture Phase**: Database and API design
- **Implementation Phase**: Core API and authentication
- **Quality Phase**: Testing, documentation, performance validation
- **Agent Sequence**: code-architect → security-specialist → test-engineer → deployment-specialist

### Example 3: Legacy System Modernization

**Scenario**: Migrating legacy PHP application to modern architecture

**Planning Command**:

```bash
Use Task tool with subagent_type="project-planner":
"Create migration plan for legacy PHP monolith to microservices architecture.
Include gradual migration strategy, data migration, API design, and risk mitigation."
```

**Key Planning Elements**:

- **Assessment Phase**: Legacy code analysis and dependency mapping
- **Design Phase**: New architecture and migration strategy
- **Implementation Phase**: Gradual service extraction
- **Validation Phase**: Performance testing and rollback procedures

## 📚 Advanced Features

### 1. Knowledge-Enhanced Planning

The project-planner integrates with Basic Memory for historical learning:

- **Pattern Recognition**: Learns from successful project patterns
- **Risk Prediction**: Identifies risks based on similar past projects
- **Effort Estimation**: Improves estimates based on historical data
- **Best Practice Application**: Suggests proven approaches from past successes

### 2. Multi-Project Coordination

For complex initiatives spanning multiple projects:

- **Dependency Management**: Cross-project dependency tracking
- **Resource Coordination**: Shared resource allocation
- **Timeline Synchronization**: Coordinated milestone planning
- **Knowledge Sharing**: Cross-project learning and pattern sharing

### 3. Continuous Improvement Integration

Built-in learning and improvement mechanisms:

- **Retrospective Planning**: Post-project analysis integration
- **Pattern Evolution**: Continuous improvement of planning templates
- **Success Metric Tracking**: Long-term outcome measurement
- **Process Optimization**: Planning process improvement over time

## 🛠️ Troubleshooting

### Common Planning Challenges

**Overly Complex Plans**

- **Problem**: Plans become too detailed and rigid
- **Solution**: Focus on key milestones and decision points
- **Best Practice**: Create adaptive plans with regular review cycles

**Agent Orchestration Conflicts**

- **Problem**: Agents have conflicting requirements or outputs
- **Solution**: Plan explicit handoff protocols and knowledge transfer
- **Best Practice**: Test agent sequences with smaller scope first

**Unrealistic Timelines**

- **Problem**: Estimates don't account for complexity or unknowns
- **Solution**: Include buffer time and plan research spikes
- **Best Practice**: Validate estimates with historical project data

### Performance Optimization

**Large Project Planning**

- Use phased approaches for projects >3 months
- Focus on near-term detail, high-level for later phases
- Plan regular re-planning cycles for adaptation

**Resource Optimization**

- Balance specialist agent usage with general-purpose agents
- Plan concurrent work streams where possible
- Consider skill development time in resource planning

## 🎯 Conclusion

The project-planner agent represents a powerful addition to the Claude Code Toolkit, providing strategic development planning that's specifically optimized for the toolkit's architecture and agent ecosystem. By following the patterns and practices outlined in this guide, development teams can create comprehensive, executable project plans that maximize the toolkit's effectiveness while delivering exceptional software solutions.

The agent's integration with the 6-command architecture ensures that every planned task has a clear execution path, while the sophisticated agent orchestration capabilities enable complex, multi-specialist workflows that would be difficult to coordinate manually.

For additional support and examples, refer to the agent's built-in methodology documentation and the comprehensive YAML output templates provided with each planning session.
