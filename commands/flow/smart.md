---
description: Intelligently analyze and route problems to the most appropriate specialized agents
argument-hint: <problem-description> [--verbose] [--suggest-only]
---

# Smart Problem Routing

This command intelligently analyzes your problem and automatically routes it to the most appropriate specialized agents for resolution. It's like having an expert consultant who knows exactly which specialist to call for each type of issue.

## How It Works

1. **Problem Analysis**: First, I analyze your problem description to understand:

   - Problem domain (code, performance, security, architecture, etc.)
   - Severity and urgency
   - Required expertise
   - Potential solution approaches

2. **Agent Selection**: Based on the analysis, I select the best agents:

   - Single agent for focused problems
   - Multiple agents for complex, multi-faceted issues
   - Sequential agents when one solution depends on another

3. **Intelligent Execution**: Agents are invoked with:
   - Context-aware prompts
   - Relevant problem details
   - Coordination between multiple agents

## Problem Categories & Routing

### 🐛 Code Errors & Bugs

**Indicators**: error messages, exceptions, crashes, unexpected behavior
**Routes to**: @debugger
**Example**: "TypeError in auth.js line 42"

### ⚡ Performance Issues

**Indicators**: slow, latency, memory leak, high CPU, bottleneck
**Routes to**: @performance-optimizer
**Example**: "API endpoint taking 5 seconds to respond"

### 🔒 Security Concerns

**Indicators**: vulnerability, CVE, authentication, encryption, injection
**Routes to**: @security-specialist
**Example**: "Possible SQL injection in user input handling"

### 🏗️ Architecture Problems

**Indicators**: design pattern, coupling, scalability, microservices
**Routes to**: @code-architect
**Example**: "How to decouple payment service from main app"

### 🧪 Testing Gaps

**Indicators**: coverage, test, TDD, unit test, integration test
**Routes to**: @test-engineer
**Example**: "Need tests for new authentication flow"

### 📚 Documentation Issues

**Indicators**: outdated docs, missing README, API docs, comments
**Routes to**: @documentation-health-specialist
**Example**: "Documentation doesn't match current API"

### 🔧 Code Quality

**Indicators**: refactor, code smell, duplicate, complexity, maintenance
**Routes to**: @refactoring-expert
**Example**: "Too much duplicate code in controllers"

### 📊 Report Analysis

**Indicators**: analyze report, metrics, trends, ROI, prioritize
**Routes to**: @report-analyzer
**Example**: "Help me understand this code quality report"

## Multi-Agent Coordination

For complex problems spanning multiple domains:

### Example: "Application is slow and possibly insecure"

1. Use Task tool with subagent_type="performance-optimizer"
   - Analyze performance bottlenecks
   - Identify slow queries and algorithms
2. Use Task tool with subagent_type="security-specialist"
   - Check for security vulnerabilities
   - Ensure performance fixes don't compromise security
3. Synthesize findings and provide unified solution

### Example: "Refactor legacy module for better testing"

1. Use Task tool with subagent_type="code-architect"
   - Analyze current architecture
   - Design testable structure
2. Use Task tool with subagent_type="refactoring-expert"
   - Plan refactoring steps
   - Identify code smells
3. Use Task tool with subagent_type="test-engineer"
   - Design test strategy
   - Create test templates

## Usage Examples

### Simple Routing

```
/prefix:flow:smart "Getting 'undefined is not a function' in UserService"
→ Routes to debugger agent
```

### Performance Analysis

```
/prefix:flow:smart "Dashboard takes forever to load with 1000 users"
→ Routes to performance-optimizer agent
```

### Complex Multi-Domain

```
/prefix:flow:smart "Need to modernize authentication system for better security and performance"
→ Routes to security-specialist + code-architect + performance-optimizer
```

### Exploratory Help

```
/prefix:flow:smart "Not sure why my tests are flaky sometimes"
→ Analyzes and routes to test-engineer with focus on flaky test patterns
```

## Options

- `--verbose`: Show detailed routing decision process
- `--suggest-only`: Only suggest which agents to use without executing

## Smart Routing Process

$ARGUMENTS

### Phase 1: Ultra Deep Problem Analysis

Use Task tool with subagent_type="general-purpose":
"ULTRA INTENSIVE PROBLEM ANALYSIS FOR SMART ROUTING

Problem: $ARGUMENTS

**THINK ULTRA DEEPLY** about this problem. Use ULTRA INTENSIVE REASONING to:

1. **Core Issue Identification**
   - Think ultra deeply about the real problem vs symptoms
   - Use ultra deep reasoning to identify hidden complexities
   - Think ultra deeply about interconnected issues

2. **Domain Classification**
   - Reason ultra deeply about problem categories
   - Think ultra deeply about cross-domain aspects
   - Use ultra intensive analysis for edge cases

3. **Specialist Selection**
   - Think ultra deeply about which agents are needed
   - Reason ultra deeply about execution order
   - Use ultra deep thinking for coordination strategy

CRITICAL: Think ultra deeply about subtle nuances. Don't accept surface-level categorization. Use ultra intensive reasoning to find the optimal routing strategy."

### Phase 2: Specialist Execution

Based on ultra deep analysis, invoke appropriate specialists with ultra intensive thinking directives:
- Each specialist receives "THINK ULTRA DEEPLY" instructions
- Coordination includes ultra deep reasoning requirements
- Synthesis uses ultra intensive analysis

### Phase 3: Solution Integration
- Combining insights with ultra deep reasoning
- Cross-validating solutions
- Providing comprehensive action plan
