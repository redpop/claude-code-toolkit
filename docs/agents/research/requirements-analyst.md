# Requirements Analyst

## Overview

Expert in requirement gathering, analysis, and validation for comprehensive project understanding. This specialist transforms high-level feature requests into detailed, actionable requirements while ensuring feasibility, completeness, and alignment with business objectives and technical constraints.

## Capabilities

- **Requirement Elicitation**: Extract and clarify detailed requirements from high-level requests
- **Feasibility Analysis**: Assess technical and business viability of proposed features
- **Stakeholder Analysis**: Identify and analyze different stakeholder perspectives and needs
- **Risk Assessment**: Identify potential challenges and mitigation strategies
- **Acceptance Criteria**: Define clear, testable success criteria for implementations
- **Requirement Validation**: Ensure completeness, consistency, and achievability

## Usage

### Direct Invocation

```bash
# Use Task tool with requirements analyst
Use Task tool with subagent_type="requirements-analyst":
"Analyze the user authentication feature request and develop comprehensive requirements including security, usability, and performance considerations"
```

### Through Core Commands

```bash
/prefix:understand . --prp --requirements="feature-name"
/prefix:create . --requirements-driven
```

## Output Format

- **Requirement Specification**: Detailed functional and non-functional requirements
- **Acceptance Criteria**: Clear, testable success conditions
- **Risk Analysis**: Potential challenges with mitigation strategies
- **Stakeholder Impact**: Analysis of effects on different user groups
- **Implementation Priorities**: Recommended development phases and priorities

## Core Capabilities

### Requirement Elicitation

- Extract detailed requirements from high-level feature requests
- Identify implicit requirements and assumptions
- Clarify ambiguous or incomplete specifications
- Gather requirements from multiple stakeholder perspectives

### Feasibility Analysis

- Assess technical feasibility within existing architecture
- Evaluate resource requirements and constraints
- Analyze integration complexity and dependencies
- Determine realistic timelines and effort estimates

### Stakeholder Analysis

- Identify all affected stakeholder groups
- Analyze different user roles and their specific needs
- Understand business objectives and constraints
- Balance competing requirements and priorities

### Risk Assessment

- Identify technical implementation risks
- Analyze business and operational risks
- Assess security and compliance implications
- Define mitigation strategies for identified risks

## Examples

### Feature Requirement Analysis

```bash
# Comprehensive feature requirement development
Use Task tool with subagent_type="requirements-analyst":
"Analyze the request for 'user dashboard with analytics' and develop detailed requirements including data visualization needs, performance requirements, and user interaction patterns"
```

### Integration Requirement Assessment

```bash
# Third-party integration analysis
Use Task tool with subagent_type="requirements-analyst":
"Analyze requirements for integrating with payment processing system, including security, compliance, and user experience considerations"
```

### Security Requirement Definition

```bash
# Security-focused requirement analysis
Use Task tool with subagent_type="requirements-analyst":
"Define comprehensive security requirements for the user authentication system including data protection, access control, and audit capabilities"
```

## Analysis Framework

### Functional Requirements

- Core functionality and feature specifications
- User interaction flows and behavior expectations
- Data processing and transformation requirements
- Integration points and external system interactions

### Non-Functional Requirements

- Performance benchmarks and scalability needs
- Security and compliance requirements
- Usability and accessibility standards
- Reliability and availability expectations

### Business Requirements

- Business objectives and success metrics
- Stakeholder needs and constraints
- Regulatory and compliance considerations
- Cost and resource limitations

### Technical Requirements

- Architecture and design constraints
- Technology stack and platform requirements
- Integration and compatibility needs
- Maintenance and operational considerations

## Integration Points

### Command Integration

- **understand command**: Primary integration for requirement analysis
- **PRP methodology**: Core component of Project Requirements Proposal workflow
- **create command**: Requirement-driven development guidance

### Agent Collaboration

- **External Research Specialist**: Validate requirements against industry standards
- **Codebase Research Specialist**: Ensure requirements align with existing architecture
- **Blueprint Architect**: Transform requirements into implementation blueprints

## Requirement Categories

### User Requirements

- User stories and use cases
- User interface and experience expectations
- Accessibility and usability requirements
- User role definitions and permissions

### System Requirements

- Functional behavior and capabilities
- Data requirements and constraints
- Integration and interoperability needs
- Performance and scalability expectations

### Quality Requirements

- Security and privacy requirements
- Reliability and availability standards
- Maintainability and extensibility needs
- Testing and validation criteria

## Best Practices

### Requirement Gathering

- Ask clarifying questions to uncover implicit requirements
- Consider multiple stakeholder perspectives
- Identify and document assumptions early
- Validate requirements against business objectives

### Requirement Documentation

- Use clear, unambiguous language
- Define measurable acceptance criteria
- Prioritize requirements by business value and risk
- Maintain traceability throughout development

### Validation and Verification

- Ensure requirements are complete and consistent
- Validate feasibility with technical constraints
- Review requirements with stakeholders
- Plan for requirement changes and evolution

## Tools Used

- **Read**: Existing documentation and specification analysis
- **Grep**: Pattern discovery and requirement validation
- **Task**: Coordination with research and architecture specialists

## See Also

- [Blueprint Architect](blueprint-architect.md)
- [External Research Specialist](external-research-specialist.md)
- [Codebase Research Specialist](codebase-research-specialist.md)
