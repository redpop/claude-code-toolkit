# Code Architect Agent

## Overview

The Code Architect is a knowledge-enhanced expert in software architecture, system design, and architectural patterns. This agent specializes in evaluating architectural decisions, identifying design improvements, and ensuring scalable, maintainable software architecture. With persistent learning capabilities through Basic Memory integration, it accumulates architectural insights across projects to provide increasingly sophisticated recommendations based on proven patterns and outcomes.

## Capabilities

- **Knowledge-Enhanced Architecture Intelligence**: Accesses architectural decisions and their outcomes from Basic Memory across projects for improved recommendations
- **Pattern Evolution Learning**: Learns from architectural successes and failures to continuously improve guidance quality
- **Context-Aware Design**: Utilizes project-specific architectural history and design decisions for tailored recommendations
- **Scalability Learning**: Tracks how architectural decisions affect system scalability over time for data-driven insights
- **Architectural Pattern Analysis**: Expert evaluation of microservices, monolithic, event-driven, DDD, hexagonal/clean architecture, and MV* patterns
- **Design Principle Assessment**: SOLID principles, DRY/KISS/YAGNI application, separation of concerns, and coupling/cohesion analysis
- **System Design Optimization**: Scalability patterns, resilience planning, data consistency, API design, and service boundary definition
- **Structure Assessment**: Module organization, layer separation, dependency analysis, and component boundary evaluation
- **Migration Planning**: Strategic roadmap creation for architectural evolution with step-by-step implementation guidance

## Usage

### Direct Invocation

Use the Task tool to invoke the Code Architect directly:

```markdown
Use Task tool with subagent_type="code-architect":
"Analyze the current system architecture, identify structural improvements, and provide a comprehensive architectural assessment with specific recommendations for scalability and maintainability."
```

### Through Core Commands

The Code Architect is integrated with key toolkit commands:

- **`/prefix:understand`**: Provides architectural analysis as part of comprehensive codebase understanding
- **`/prefix:improve`**: Focuses on architectural improvements and structural optimizations
- **`/prefix:create`**: Guides architectural decisions for new features and components
- **`/prefix:secure`**: Evaluates security architecture patterns and provides hardening recommendations

## Output Format

The Code Architect delivers comprehensive architectural assessment reports:

```markdown
# Architecture Analysis Report

## Executive Summary
- **Architecture Style**: [Monolithic | Microservices | SOA | Serverless | Hybrid]
- **Overall Health Score**: X/10
- **Maturity Level**: [Initial | Managed | Defined | Quantified | Optimizing]
- **Key Strengths**:
  - ✅ [Architectural strength with specific benefits]
  - ✅ [Design pattern success with impact metrics]
- **Critical Issues**:
  - ❌ [Architectural concern with business impact]
  - ❌ [Structural problem with technical debt implications]

## Current Architecture

### System Overview
[Comprehensive architecture diagram with component relationships]

### Component Analysis
[Detailed assessment of each architectural component including responsibility, dependencies, coupling scores, and improvement recommendations]

## Architectural Concerns

### Critical Issues
[Prioritized list of architectural problems with impact assessment, current state analysis, proposed solutions, and migration paths]

## Design Improvements

### Short-term (1-2 weeks)
[Quick wins and immediate improvements with implementation guides and code examples]

### Medium-term (1-3 months)
[Structural refactoring recommendations with effort estimates]

### Long-term (3-6 months)
[Major architectural evolution plans with strategic roadmaps]

## Recommended Patterns
[Specific architectural patterns applicable to the codebase with implementation guidance, benefits analysis, and trade-off considerations]

## Migration Strategy
[Detailed roadmap for architectural evolution including timeline, phases, and risk mitigation]

## Architecture Decision Records (ADRs)
[Documentation of key architectural decisions with context, rationale, and consequences]
```

## Examples

### Example 1: Legacy System Modernization

```markdown
Use Task tool with subagent_type="code-architect":
"Evaluate our monolithic e-commerce platform for microservices migration opportunities. Focus on service boundary identification, data separation strategies, and provide a phased migration plan with risk assessment."
```

**Expected Output**: Comprehensive modernization strategy with service decomposition analysis, data architecture evolution plan, migration timeline with phases, and risk mitigation strategies based on proven modernization patterns.

### Example 2: Scalability Architecture Review

```markdown
Use Task tool with subagent_type="code-architect":
"Assess our current architecture for scalability bottlenecks and provide recommendations for handling 10x traffic growth. Include caching strategies, database optimization, and service communication patterns."
```

**Expected Output**: Scalability assessment report with bottleneck identification, performance optimization recommendations, infrastructure scaling strategies, and architectural patterns for high-traffic scenarios.

### Example 3: Clean Architecture Implementation

```markdown
Use Task tool with subagent_type="code-architect":
"Review our current layered architecture and provide a roadmap for implementing clean architecture principles. Focus on dependency inversion, separation of concerns, and testability improvements."
```

**Expected Output**: Clean architecture transformation plan with layer restructuring guidance, dependency injection strategies, interface design recommendations, and testability enhancement approaches.

## Tools Used

- **Read**: Analyzes source code files, configuration files, and architectural documentation for comprehensive understanding
- **Grep**: Searches for architectural patterns, dependencies, design implementations, and structural elements across the codebase
- **Task**: Coordinates with other specialists for holistic analysis and captures architectural insights to Basic Memory for persistent learning

## See Also

- [Project Planner](project-planner.md) - For strategic development planning based on architectural insights
- [Code Understanding Specialist](../analysis/code-understanding-specialist.md) - For detailed code structure analysis supporting architectural decisions
- [Performance Optimizer](../analysis/performance-optimizer.md) - For performance-focused architectural analysis
- [Security Specialist](../security/security-specialist.md) - For security architecture assessment and hardening
- [Refactoring Expert](../analysis/refactoring-expert.md) - For tactical refactoring strategies aligned with architectural goals
- [Architecture Analysis Guide](../../guides/ARCHITECTURE-ANALYSIS.md) - Comprehensive architecture analysis methodologies
- [System Design Guide](../../guides/SYSTEM-DESIGN.md) - System design principles and patterns
- [Migration Planning Guide](../../guides/MIGRATION-PLANNING.md) - Best practices for architectural evolution
