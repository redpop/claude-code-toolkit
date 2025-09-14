# Project Planning Examples - Real-World Scenarios

**Version:** 1.0.0
**Agent:** project-planner
**Related Guide:** [PROJECT-PLANNING-GUIDE.md](PROJECT-PLANNING-GUIDE.md)

## Overview

This guide provides concrete examples of using the `project-planner` agent for real-world development scenarios. Each example demonstrates different aspects of strategic planning within the Claude Code Toolkit ecosystem.

## 🎯 Quick Reference Commands

### Basic Planning Commands

```bash
# Strategic analysis and planning
/prefix:understand . --strategic-planning
/prefix:understand . --project-architecture
/prefix:understand . --impact-analysis

# Implementation planning
/prefix:improve . --refactoring-strategy
/prefix:create project --development-roadmap
/prefix:ship . --release-planning

# Direct agent invocation
Use Task tool with subagent_type="project-planner":
"[Your detailed planning request]"
```

## 📋 Example 1: Smart Suggestions System

### Scenario

Implementing the Smart Suggestions System we designed - a context-aware system that provides intelligent command recommendations after file modifications.

### Planning Request

```bash
Use Task tool with subagent_type="project-planner":
"Create comprehensive strategic plan for Smart Suggestions System implementation.

Requirements:
- 3-phase development over 3 weeks
- Extend existing hook infrastructure without breaking functionality
- Context-aware suggestions based on file modifications
- User configuration system (enable/disable, patterns, cooldown)
- Performance requirement: <10ms impact on existing hooks
- Integration with 6-command architecture
- Support for pattern matching (security files, tests, dependencies)

Include agent orchestration, risk mitigation, and quality gates."
```

### Expected Planning Output Structure

```yaml
project_name: "Smart Suggestions System"
generated_date: "2024-01-15"
toolkit_optimization: true

executive_summary:
  overview: |
    Context-aware suggestion system that provides intelligent workflow
    recommendations after file modifications, extending the existing hook
    infrastructure while maintaining performance standards.

  key_objectives:
    - Implement intelligent suggestion engine with <10ms performance impact
    - Create user-configurable pattern matching system
    - Integrate seamlessly with 6-command architecture
    - Maintain 100% backward compatibility with existing hooks

phases:
  - phase_name: "Foundation & Hook Integration"
    duration: "1 week"
    features:
      - feature_name: "Smart Suggestion Engine"
        tasks:
          - task_name: "Context Analysis Library"
            toolkit_command: "/create"
            agent_assignment: "workflow-optimizer"
            claude_toolkit_workflow: |
              /prefix:understand . --hook-system-analysis
              /prefix:create hooks --suggestion-engine
              /prefix:ship . --performance-validation

  - phase_name: "Intelligence & Configuration"
    duration: "1 week"
    features:
      - feature_name: "Pattern Recognition System"
        tasks:
          - task_name: "File Pattern Matching"
            toolkit_command: "/improve"
            agent_assignment: "performance-optimizer"

agent_sequences:
  - workflow_name: "Suggestion System Development"
    agents:
      - agent: "workflow-optimizer"
        role: "Hook system analysis and integration design"
        handoff_to: "performance-optimizer"
      - agent: "performance-optimizer"
        role: "Performance optimization and caching strategy"
        handoff_to: "test-engineer"

timeline:
  start_date: "2024-01-15"
  estimated_completion: "2024-02-05"

quality_gates:
  - phase: "Foundation"
    standards: ["<10ms execution time", "100% backward compatibility"]
    validation_approach: "Performance testing + integration validation"
```

### Key Learning Points

- **Performance-First Design**: Every task includes performance validation
- **Backward Compatibility**: Explicit requirement in quality gates
- **Agent Sequencing**: Logical flow from workflow analysis to optimization to testing
- **Toolkit Integration**: Every task maps to specific commands

## 📋 Example 2: E-commerce Authentication System

### Scenario

Building a comprehensive authentication system for an e-commerce platform with OAuth2, multi-factor authentication, and role-based access control.

### Planning Request

```bash
Use Task tool with subagent_type="project-planner":
"Design strategic plan for e-commerce authentication system implementation.

Requirements:
- OAuth2 integration with Google, Facebook, GitHub
- Multi-factor authentication (TOTP, SMS, email)
- Role-based access control (customer, admin, moderator)
- Session management with refresh tokens
- Security compliance (OWASP ASVS Level 2)
- Performance target: <200ms authentication response
- Database integration with user profiles and preferences
- API-first design with comprehensive documentation

Timeline: 4-6 weeks
Include security validation, testing strategy, and deployment planning."
```

### Expected Agent Orchestration

```yaml
agent_sequences:
  - workflow_name: "Authentication System Development"
    description: "Complete OAuth2 authentication with RBAC"
    agents:
      - agent: "security-specialist"
        role: "Security architecture and OWASP compliance design"
        inputs: "Requirements and security standards"
        outputs: "Security architecture and threat model"
        handoff_to: "code-architect"

      - agent: "code-architect"
        role: "System architecture and database design"
        inputs: "Security requirements and system constraints"
        outputs: "Database schema and API architecture"
        handoff_to: "frontend-specialist"

      - agent: "frontend-specialist"
        role: "Authentication UI and user experience"
        inputs: "API contracts and user flow requirements"
        outputs: "Authentication components and user workflows"
        handoff_to: "test-engineer"

      - agent: "test-engineer"
        role: "Security testing and validation strategy"
        inputs: "Complete implementation and security requirements"
        outputs: "Test suites and security validation"
        handoff_to: "deployment-specialist"

knowledge_transfer:
  - checkpoint: "Security Architecture Review"
    knowledge_items:
      - "OAuth2 flow implementation details"
      - "Token management and refresh strategies"
      - "RBAC model and permission structures"
    documentation_required: "Security Architecture Document"

  - checkpoint: "API Design Completion"
    knowledge_items:
      - "API endpoint specifications"
      - "Authentication middleware patterns"
      - "Error handling and logging strategies"
    documentation_required: "API Documentation and Integration Guide"
```

### Key Learning Points

- **Security-First Approach**: Security specialist leads the orchestration
- **Knowledge Transfer**: Explicit documentation requirements at each phase
- **Multi-Specialist Coordination**: Complex handoffs between different domains
- **Compliance Integration**: OWASP standards built into requirements

## 📋 Example 3: Legacy System Migration

### Scenario

Migrating a monolithic PHP application to a modern Node.js microservices architecture while maintaining business continuity.

### Planning Request

```bash
Use Task tool with subagent_type="project-planner":
"Create migration strategy for legacy PHP monolith to Node.js microservices.

Current System:
- PHP 7.4 monolith with MySQL database
- ~50,000 lines of code across 200+ files
- No automated testing
- Shared database with complex interdependencies
- Critical business operations (cannot have downtime)

Target Architecture:
- Node.js microservices with TypeScript
- Event-driven architecture with message queues
- Containerized deployment with Docker/Kubernetes
- Comprehensive API documentation
- 90%+ test coverage

Constraints:
- Zero-downtime migration required
- Gradual migration over 6-8 months
- Team training on new technologies needed
- Legacy system must remain operational during migration

Include risk mitigation, rollback procedures, and team coordination."
```

### Expected Risk Management

```yaml
identified_risks:
  - category: "technical"
    risk: "Data migration complexity with legacy database structure"
    impact: "Critical system failure or data loss"
    mitigation: "Implement comprehensive data validation and migration testing"
    contingency: "Automated rollback procedures with data restore capability"
    owner: "code-architect + database specialist"

  - category: "resource"
    risk: "Team skill gaps in Node.js and microservices architecture"
    impact: "Development delays and quality issues"
    mitigation: "Structured training program and pair programming"
    contingency: "External consulting support for critical phases"
    owner: "workflow-optimizer"

  - category: "timeline"
    risk: "Legacy system maintenance competing with migration work"
    impact: "Extended timeline and resource conflicts"
    mitigation: "Dedicated migration team with clear priorities"
    contingency: "Phased approach with extended timeline"
    owner: "project-planner coordination"

migration_phases:
  - phase_name: "Assessment & Preparation"
    duration: "4 weeks"
    goals: "Complete legacy analysis and target architecture design"
    key_tasks:
      - task_name: "Legacy Code Analysis"
        toolkit_command: "/understand"
        agent_assignment: "code-architect"
        claude_toolkit_workflow: |
          /prefix:understand . --legacy-analysis
          /prefix:improve . --architecture-assessment
          /prefix:create migration-plan --strategy

  - phase_name: "Pilot Service Migration"
    duration: "6 weeks"
    goals: "Migrate non-critical service as proof of concept"
    risks:
      - risk: "Integration challenges with legacy system"
        mitigation: "API gateway for gradual transition"
```

### Key Learning Points

- **Risk-Centric Planning**: Extensive risk identification and mitigation
- **Gradual Migration Strategy**: Phased approach with pilot projects
- **Business Continuity**: Zero-downtime requirements drive architecture decisions
- **Team Development**: Skill building integrated into timeline planning

## 📋 Example 4: Performance Optimization Program

### Scenario

Systematic performance improvement program for a React application experiencing slow page loads and poor user experience.

### Planning Request

```bash
Use Task tool with subagent_type="project-planner":
"Design 8-week performance optimization program for React application.

Current Issues:
- Page load times >5 seconds
- Bundle size >2MB
- Memory leaks in long-running sessions
- Poor Core Web Vitals scores
- No performance monitoring

Performance Goals:
- Page load <2 seconds
- Bundle size <500KB
- Perfect Lighthouse scores (90+ in all categories)
- Real user monitoring implementation
- Automated performance testing in CI/CD

Include measurement strategy, optimization techniques, and monitoring setup."
```

### Expected Optimization Sequence

```yaml
optimization_phases:
  - phase_name: "Baseline Establishment & Analysis"
    duration: "1 week"
    agent_sequence: ["performance-optimizer", "frontend-specialist"]
    deliverables:
      - "Performance baseline measurements"
      - "Bundle analysis and optimization opportunities"
      - "Memory usage profiling"

  - phase_name: "Critical Path Optimization"
    duration: "3 weeks"
    optimization_targets:
      - target: "Bundle size reduction"
        techniques: ["Code splitting", "Tree shaking", "Dynamic imports"]
        success_metric: "<500KB total bundle size"

      - target: "Runtime performance"
        techniques: ["React.memo", "useMemo", "Virtual scrolling"]
        success_metric: "60fps scrolling performance"

    tasks:
      - task_name: "Code Splitting Implementation"
        toolkit_command: "/improve"
        agent_assignment: "frontend-specialist"
        claude_toolkit_workflow: |
          /prefix:understand . --bundle-analysis
          /prefix:improve . --code-splitting
          /prefix:ship . --performance-validation

  - phase_name: "Monitoring & Continuous Improvement"
    duration: "2 weeks"
    monitoring_implementation:
      - tool: "Real User Monitoring"
        integration: "Custom analytics dashboard"
        alerts: "Performance regression detection"

      - tool: "Automated Performance Testing"
        integration: "CI/CD pipeline"
        thresholds: "Bundle size, page load time, memory usage"

quality_gates:
  - phase: "Critical Path Optimization"
    performance_thresholds:
      - metric: "First Contentful Paint"
        target: "<1.5s"
        validation: "Lighthouse CI testing"
      - metric: "Largest Contentful Paint"
        target: "<2.5s"
        validation: "Real user monitoring"
      - metric: "Cumulative Layout Shift"
        target: "<0.1"
        validation: "Automated visual testing"
```

### Key Learning Points

- **Measurement-Driven**: Every optimization includes specific metrics and validation
- **Phased Approach**: Baseline → Optimization → Monitoring
- **Continuous Validation**: Performance gates at each phase
- **Tool Integration**: CI/CD pipeline integration for ongoing monitoring

## 📋 Example 5: API Documentation & Developer Experience

### Scenario

Creating comprehensive API documentation and developer experience improvements for a REST API used by external developers.

### Planning Request

```bash
Use Task tool with subagent_type="project-planner":
"Plan comprehensive API documentation and developer experience project.

Current State:
- REST API with 45 endpoints
- Minimal documentation (basic README)
- No interactive documentation
- Poor developer onboarding experience
- No SDK or client libraries

Target Goals:
- Interactive OpenAPI documentation
- SDK generation for JavaScript, Python, Go
- Developer portal with tutorials and guides
- API testing playground
- Comprehensive code examples
- Developer feedback system

Timeline: 6 weeks
Include content strategy, technical implementation, and user experience design."
```

### Expected Documentation Strategy

```yaml
content_strategy:
  - content_type: "API Reference Documentation"
    approach: "OpenAPI 3.0 specification with rich examples"
    agent_assignment: "documentation-specialist"
    tools: ["Swagger UI", "Redoc", "Custom portal"]

  - content_type: "Developer Tutorials"
    approach: "Step-by-step guides with working code examples"
    agent_assignment: "frontend-specialist"
    integration: "Interactive code playground"

  - content_type: "SDK Documentation"
    approach: "Auto-generated from OpenAPI spec"
    agent_assignment: "code-architect"
    languages: ["JavaScript", "Python", "Go"]

implementation_phases:
  - phase_name: "Documentation Foundation"
    duration: "2 weeks"
    tasks:
      - task_name: "OpenAPI Specification Creation"
        toolkit_command: "/create"
        agent_assignment: "documentation-specialist"
        claude_toolkit_workflow: |
          /prefix:understand . --api-analysis
          /prefix:create docs --openapi-spec
          /prefix:ship . --validation

      - task_name: "Developer Portal Setup"
        toolkit_command: "/create"
        agent_assignment: "frontend-specialist"
        integration: "Static site generator with interactive components"

  - phase_name: "SDK Development & Testing"
    duration: "3 weeks"
    parallel_workstreams:
      - workstream: "JavaScript SDK"
        agent: "frontend-specialist"
        deliverables: ["NPM package", "TypeScript definitions", "Examples"]

      - workstream: "Python SDK"
        agent: "code-architect"
        deliverables: ["PyPI package", "Type hints", "Jupyter examples"]

      - workstream: "Go SDK"
        agent: "performance-optimizer"
        deliverables: ["Go module", "Comprehensive tests", "CLI examples"]

developer_experience_features:
  - feature: "Interactive API Explorer"
    implementation: "Swagger UI with custom branding"
    user_journey: "Discover → Test → Integrate"

  - feature: "Code Generation Playground"
    implementation: "Browser-based code generator"
    supported_languages: ["curl", "JavaScript", "Python", "Go", "PHP"]

  - feature: "Feedback & Support System"
    implementation: "GitHub Discussions integration"
    moderation: "Community-driven with maintainer oversight"
```

### Key Learning Points

- **Multi-Modal Documentation**: Different content types for different user needs
- **Parallel Development**: SDK development can happen concurrently
- **User Journey Focus**: Documentation designed around developer experience
- **Community Integration**: Feedback systems for continuous improvement

## 🔧 Integration Patterns

### Pattern 1: Analysis-First Planning

```bash
# Always start with understanding before planning
/prefix:understand . --comprehensive-analysis
# Then invoke project-planner based on findings
Use Task tool with subagent_type="project-planner":
"Based on the analysis results, create strategic plan for [specific requirements]"
```

### Pattern 2: Iterative Planning

```bash
# Phase 1 planning
/prefix:understand . --strategic-planning --phase=foundation
# Implement Phase 1
/prefix:create phase1 --implementation
# Re-plan based on learnings
/prefix:understand . --strategic-planning --phase=next --lessons-learned
```

### Pattern 3: Risk-Driven Planning

```bash
# High-risk projects need extensive risk analysis
Use Task tool with subagent_type="project-planner":
"Create comprehensive risk assessment and mitigation plan for [project].
Focus on technical risks, timeline risks, and resource constraints.
Include contingency planning and rollback procedures."
```

### Pattern 4: Performance-Critical Planning

```bash
# Performance requirements drive architecture
Use Task tool with subagent_type="project-planner":
"Design implementation plan with strict performance requirements: [requirements].
Include performance validation at each phase and automated performance testing."
```

## 📊 Success Metrics Templates

### Development Project Metrics

```yaml
success_metrics:
  - category: "Technical Quality"
    metrics:
      - metric: "Test Coverage"
        target: ">90%"
        measurement: "Automated coverage reporting"
      - metric: "Code Quality Score"
        target: "A grade (SonarQube)"
        measurement: "Static analysis integration"

  - category: "Performance"
    metrics:
      - metric: "Response Time"
        target: "<200ms 95th percentile"
        measurement: "APM monitoring"
      - metric: "Memory Usage"
        target: "No memory leaks"
        measurement: "Load testing validation"

  - category: "Security"
    metrics:
      - metric: "Vulnerability Count"
        target: "0 critical, 0 high"
        measurement: "Security scanning integration"
      - metric: "Security Compliance"
        target: "OWASP ASVS Level 2"
        measurement: "Security specialist validation"
```

### Migration Project Metrics

```yaml
migration_success_metrics:
  - category: "Business Continuity"
    metrics:
      - metric: "System Downtime"
        target: "0 minutes"
        measurement: "Uptime monitoring"
      - metric: "Data Integrity"
        target: "100% accuracy"
        measurement: "Data validation testing"

  - category: "User Experience"
    metrics:
      - metric: "Performance Improvement"
        target: ">50% faster response times"
        measurement: "Before/after benchmarking"
      - metric: "Feature Parity"
        target: "100% feature coverage"
        measurement: "Functional testing validation"
```

## 🎯 Conclusion

These examples demonstrate the versatility and depth of strategic planning possible with the `project-planner` agent. Each scenario showcases different planning approaches:

- **Smart Suggestions**: Performance-focused, incremental enhancement
- **Authentication System**: Security-first, multi-specialist coordination
- **Legacy Migration**: Risk-heavy, gradual transformation
- **Performance Optimization**: Measurement-driven, systematic improvement
- **API Documentation**: User experience-focused, parallel development

The key to successful project planning is matching the planning approach to the project characteristics and constraints. The `project-planner` agent provides the flexibility and depth needed for any development scenario while maintaining tight integration with the Claude Code Toolkit ecosystem.
