---
description: Comprehensive code review using multiple specialized agents for different perspectives
argument-hint: <file-or-directory> [--focus=security|performance|architecture|all]
---

# Multi-Perspective Code Review

This command performs a comprehensive code review by coordinating multiple specialized agents, each providing their unique perspective on code quality, security, performance, and architecture.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Comprehensive code review using multiple specialized agents for different perspectives
- **Usage**: <file-or-directory> [--focus=security|performance|architecture|all]
- **Options**:
  - `--focus=security`: Emphasize security aspects
  - `--focus=performance`: Deep dive into performance
  - `--focus=architecture`: Architectural analysis priority
  - `--focus=all`: Equal weight to all aspects (default)

Then exit without executing the main command.

---

## Review Process

### Phase 1: Parallel Analysis

Multiple specialized agents review your code simultaneously:

1. **Code Quality Review** (@code-reviewer)

   - Style and readability
   - SOLID principles adherence
   - Design patterns usage
   - Code duplication
   - Complexity metrics

2. **Security Review** (@security-auditor)

   - Authentication/authorization flaws
   - Input validation
   - Injection vulnerabilities
   - Sensitive data exposure
   - Security misconfigurations

3. **Architecture Review** (@architect-reviewer)

   - Service boundaries
   - Coupling and cohesion
   - Scalability considerations
   - Design pattern appropriateness
   - API design quality

4. **Performance Review** (@performance-analyst)

   - Algorithm efficiency
   - Resource usage
   - Potential bottlenecks
   - Caching opportunities
   - Database query optimization

5. **Test Quality Review** (@test-specialist)
   - Test coverage
   - Test quality and assertions
   - Edge case handling
   - Test maintainability

### Phase 2: Synthesis

All findings are consolidated into a unified report with:

- Critical issues requiring immediate attention
- Important improvements for code quality
- Minor suggestions and nice-to-haves
- Positive findings and good practices

## Execution Strategy

**Target**: $ARGUMENTS

### Step 1: Code Quality Review

Use Task tool with subagent_type="general-purpose" to perform code quality review:

**Prompt**: "Review code in $ARGUMENTS for quality. Check: 1) Readability and naming conventions, 2) SOLID principles compliance, 3) Design patterns and anti-patterns, 4) Code duplication (DRY violations), 5) Function/class complexity, 6) Documentation completeness. Return findings as structured JSON with severity levels."

### Step 2: Security Review

Use Task tool with subagent_type="general-purpose" to perform security analysis:

**Prompt**: "Conduct security review of $ARGUMENTS. Identify: 1) Authentication/authorization vulnerabilities, 2) Input validation issues, 3) SQL injection, XSS, CSRF risks, 4) Hardcoded secrets or credentials, 5) Insecure dependencies, 6) OWASP Top 10 compliance. Return security findings as JSON with CVE references where applicable."

### Step 3: Architecture Review

Use Task tool with subagent_type="general-purpose" to evaluate architecture:

**Prompt**: "Review architecture and design in $ARGUMENTS. Assess: 1) Service boundaries and separation of concerns, 2) Coupling and cohesion metrics, 3) Scalability and extensibility, 4) Design pattern usage and appropriateness, 5) API design and contracts, 6) Dependency management. Return architectural findings as JSON."

### Step 4: Performance Review

Use Task tool with subagent_type="general-purpose" to analyze performance:

**Prompt**: "Analyze performance characteristics in $ARGUMENTS. Look for: 1) O(n²) or worse algorithms, 2) Inefficient data structures, 3) Memory leaks or excessive allocation, 4) Blocking I/O operations, 5) Missing caching opportunities, 6) Database query optimization needs. Return performance findings as JSON."

### Step 5: Test Quality Review

Use Task tool with subagent_type="general-purpose" to assess testing:

**Prompt**: "Review test quality in $ARGUMENTS. Evaluate: 1) Test coverage percentage, 2) Quality of test assertions, 3) Edge case coverage, 4) Test maintainability and clarity, 5) Mock/stub usage appropriateness, 6) Integration vs unit test balance. Return test quality findings as JSON."

## Consolidated Review Report

After all agents complete their analysis:

### 🚨 Critical Issues

[Security vulnerabilities, broken functionality, major architectural flaws]

### ⚠️ Important Issues

[Performance problems, code quality issues, missing tests]

### 💡 Suggestions

[Style improvements, minor refactoring, documentation gaps]

### ✅ Good Practices

[Well-designed components, good test coverage, security best practices]

## Usage Examples

```bash
# Review a specific file
/prefix:flow:review src/auth/UserService.js

# Review an entire module
/prefix:flow:review src/payment/

# Focus on security aspects
/prefix:flow:review src/api/ --focus=security

# Comprehensive review of everything
/prefix:flow:review . --focus=all
```

## Focus Options

- `--focus=security`: Emphasize security aspects
- `--focus=performance`: Deep dive into performance
- `--focus=architecture`: Architectural analysis priority
- `--focus=all`: Equal weight to all aspects (default)
