# Refactoring Expert Agent

## Overview

The Refactoring Expert is a knowledge-enhanced specialist in code refactoring, clean code principles, and systematic code improvement. This agent excels at identifying code smells, suggesting refactoring strategies, and guiding safe, incremental code improvements while maintaining functionality. Enhanced with Basic Memory integration, it learns from successful refactoring patterns across projects to provide proven improvement strategies.

## Capabilities

- **Code Smell Detection Excellence**: Long methods, large classes, duplicate code, feature envy, inappropriate intimacy, data clumps, primitive obsession, and complex conditionals
- **Refactoring Techniques Mastery**: Extract method/class/interface, move method/field, inline operations, conditional polymorphism replacement, parameter object introduction, and inheritance-delegation conversion
- **Clean Code Principles**: Single Responsibility Principle, DRY compliance, KISS methodology, Boy Scout Rule application, meaningful naming conventions, and optimal function sizing
- **Legacy System Modernization**: Strangler Fig pattern implementation, anti-corruption layer design, branch by abstraction technique, event interception strategies, and incremental migration planning
- **Pattern Database Access**: Successful refactoring patterns and outcomes from Basic Memory across projects
- **Success Tracking**: Learning from previous refactoring successes and failures to improve recommendations
- **Context-Aware Improvements**: Project-specific refactoring history and architectural decision context
- **Evolution Learning**: Tracking code quality improvements over time and refining strategies
- **Safety-First Approach**: Test-driven refactoring, incremental changes, and behavior preservation validation

## Usage

### Direct Invocation

Use the Task tool to invoke the Refactoring Expert directly:

```markdown
Use Task tool with subagent_type="refactoring-expert":
"Analyze the codebase for refactoring opportunities, focusing on code smells, maintainability issues, and areas where clean code principles can be applied. Provide a prioritized improvement plan."
```

### Through Core Commands

The Refactoring Expert integrates with core commands:

- **`/prefix:understand`**: Contributes code quality analysis during codebase understanding
- **`/prefix:improve`**: Primary integration point for refactoring recommendations and code improvement strategies
- **`/prefix:secure`**: Analyzes security implications of refactoring changes

### Legacy Modernization Mode

For legacy system transformation:

```markdown
Use Task tool with subagent_type="refactoring-expert":
"Our legacy monolithic system needs modernization. Analyze the codebase and create a safe, incremental refactoring strategy using proven patterns like Strangler Fig."
```

## Output Format

The Refactoring Expert delivers comprehensive refactoring analysis reports:

```markdown
# Refactoring Analysis Report

## Executive Summary
- Code quality score: X/10
- Critical code smells: [count]
- Refactoring effort estimate: [hours/days]
- Risk assessment: Low/Medium/High
- Modernization feasibility: [assessment]

## Code Smells Detected

### Priority 1: Critical Issues
#### [Code Smell Name] - High Impact
**Location**: `src/services/UserService.java:45-120`
**Severity**: High | **Type**: Long Method
**Description**: 75-line method with multiple responsibilities
**Impact**: Difficult to test, understand, and maintain

**Current Code Issues**:
- Mixed abstraction levels
- Multiple return points
- Complex conditional logic
- No single responsibility

**Refactoring Strategy**:
1. Extract method for validation logic
2. Extract method for business logic
3. Extract method for data persistence
4. Introduce service layer abstraction

**Expected Benefits**:
- 60% reduction in complexity
- Improved testability
- Enhanced readability
- Better maintainability

## Refactoring Roadmap

### Phase 1: Quick Wins (1-2 days)
- [ ] Extract method from `UserService.processUser()` → 4 hours
- [ ] Rename ambiguous variables in `OrderManager` → 2 hours
- [ ] Remove dead code in `PaymentProcessor` → 1 hour
- [ ] Inline single-use variables → 2 hours

### Phase 2: Structural Improvements (1 week)
- [ ] Split `UserController` into domain-specific controllers → 1 day
- [ ] Introduce Strategy pattern for payment processing → 2 days
- [ ] Consolidate duplicate validation logic → 1 day
- [ ] Extract common interfaces → 1 day

### Phase 3: Architecture Evolution (2-4 weeks)
- [ ] Implement hexagonal architecture boundaries → 1 week
- [ ] Separate domain logic from infrastructure → 1 week
- [ ] Introduce proper dependency injection → 3 days
- [ ] Establish clean package structure → 2 days

### Phase 4: Legacy Modernization (1-3 months)
- [ ] Implement Strangler Fig for user management → 3 weeks
- [ ] Create anti-corruption layer for external APIs → 2 weeks
- [ ] Migrate data access to repository pattern → 4 weeks
- [ ] Establish event-driven communication → 3 weeks

## Safe Refactoring Guidelines

### Pre-Refactoring Checklist
- [ ] Comprehensive test coverage exists (>80%)
- [ ] Create feature branch for changes
- [ ] Run full test suite to establish baseline
- [ ] Identify and document current behavior
- [ ] Plan rollback strategy

### Refactoring Process
1. **Single Responsibility**: One refactoring technique per commit
2. **Red-Green-Refactor**: Maintain test-driven approach
3. **Incremental Progress**: Small, verifiable changes
4. **Continuous Validation**: Run tests after each change
5. **Clear Documentation**: Descriptive commit messages

### Post-Refactoring Validation
- [ ] All tests pass without modification
- [ ] Performance benchmarks maintained
- [ ] Code coverage maintained or improved
- [ ] Stakeholder approval for behavior changes
- [ ] Documentation updated

## Legacy Modernization Strategies

### Strangler Fig Pattern Implementation
1. **Identify Seam**: Natural boundaries in legacy system
2. **Create Facade**: New interface matching old behavior
3. **Intercept Calls**: Route requests to new implementation
4. **Migrate Incrementally**: Move features systematically
5. **Monitor Both Systems**: Compare outputs for correctness
6. **Complete Migration**: Remove legacy when verified

### Anti-Corruption Layer Design
- **Purpose**: Protect new code from legacy concepts
- **Implementation**: Translation layer between systems
- **Benefits**: Clean domain model in modernized system
- **Maintenance**: Update as legacy system evolves
```

## Examples

### Example 1: Code Smell Analysis and Remediation

```bash
Use Task tool with subagent_type="refactoring-expert":
"Analyze our user management module for code smells. Focus on long methods, duplicated code, and complex conditionals. Provide specific refactoring recommendations with effort estimates."
```

**Expected Output**: Detailed code smell report with specific locations, refactoring techniques, effort estimates, and safety guidelines for each improvement.

### Example 2: Legacy System Modernization Planning

```bash
Use Task tool with subagent_type="refactoring-expert":
"Create a modernization strategy for our 10-year-old PHP monolith. We want to gradually migrate to a microservices architecture while maintaining business continuity."
```

**Expected Output**: Comprehensive modernization plan with Strangler Fig implementation, service boundary identification, migration phases, and risk mitigation strategies.

### Example 3: Clean Code Principles Application

```bash
Use Task tool with subagent_type="refactoring-expert":
"Review our codebase for clean code principle violations. Focus on naming conventions, function sizing, and SOLID principles adherence. Provide improvement guidance."
```

**Expected Output**: Clean code assessment with principle-by-principle analysis, violation examples, refactoring recommendations, and team education materials.

## Tools Used

- **Read**: Analyzes source code for refactoring opportunities, design patterns, and code quality issues
- **Grep**: Searches for code smell patterns, duplicate code, and refactoring opportunities across the codebase
- **Task**: Coordinates with other specialists and captures successful refactoring patterns to Basic Memory for continuous learning

## See Also

- [Code Understanding Specialist](code-understanding-specialist.md) - For architectural context in refactoring decisions
- [Performance Optimizer](performance-optimizer.md) - For performance-focused refactoring strategies
- [AI Specialist](ai-specialist.md) - For AI-powered code analysis and refactoring suggestions
- [Security Specialist](../security/security-specialist.md) - For security implications of refactoring changes
- [Report Analyzer](report-analyzer.md) - For tracking refactoring progress and code quality trends
- [Refactoring Guide](../../guides/REFACTORING-GUIDE.md) - Comprehensive refactoring methodologies
- [Clean Code Standards](../../guides/CLEAN-CODE-STANDARDS.md) - Code quality standards and best practices
- [Legacy Modernization](../../guides/LEGACY-MODERNIZATION.md) - Strategies for modernizing legacy systems
