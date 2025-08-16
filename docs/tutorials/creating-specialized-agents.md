# Creating Specialized Agents in Claude Code Toolkit

Welcome to this comprehensive tutorial on creating specialized agents for the Claude Code Toolkit. This guide will take you from understanding the fundamentals of agent architecture to building your own sophisticated analysis agents.

## Table of Contents

1. [Understanding Agent Architecture](#understanding-agent-architecture)
2. [Designing Agent Personas](#designing-agent-personas)
3. [Creating a Simple Specialist Agent](#creating-a-simple-specialist-agent)
4. [Creating an Analyzer Agent](#creating-an-analyzer-agent)
5. [Integrating Agents with Orchestration](#integrating-agents-with-orchestration)
6. [Testing Agent Effectiveness](#testing-agent-effectiveness)
7. [Advanced Techniques](#advanced-techniques)
8. [Best Practices and Patterns](#best-practices-and-patterns)

## Understanding Agent Architecture

### What Are Specialized Agents?

Specialized agents in the Claude Code Toolkit are AI personas with specific expertise, designed to provide deep, focused analysis in their domain. They work within the Claude Code environment but maintain their own context and expertise boundaries.

### Agent Roles and Types

The toolkit supports several agent types:

1. **Specialist Agents**: Domain experts (e.g., security-specialist, performance-optimizer)
2. **Analyzer Agents**: Data and report processors (e.g., report-analyzer)
3. **Research Agents**: Investigation and discovery specialists
4. **Helper Agents**: Task-specific assistants

### Core Components of an Agent

Every agent consists of:

```yaml
---
name: agent-identifier # REQUIRED - Unique identifier for Claude Code
description: Brief description # REQUIRED - Agent's purpose and expertise
type: specialist|analyzer|research|helper # Optional - Agent classification
expertise: Primary domain of knowledge # Optional - Domain specialization
version: 1.0.0 # Optional - Semantic versioning
mcp-enhanced: tool1, tool2 # Optional - MCP tool enhancements
---
# Agent content...
```

**Important**: The `name` field is required by Claude Code for agent registration. Without it, the agent will fail to load.

### Agent Lifecycle

1. **Invocation**: Agent is called by an orchestration command
2. **Context Setup**: Agent receives specific task and data
3. **Analysis**: Agent performs its specialized work
4. **Output**: Results returned in structured format
5. **Integration**: Results combined with other agents' outputs

## Designing Agent Personas

### Step 1: Define the Expertise Domain

Start by clearly defining what your agent specializes in:

```markdown
**Domain**: Database Performance Optimization
**Subdomain**: Query optimization, index strategy, connection pooling
**Related Areas**: Application performance, caching strategies
```

### Step 2: Establish Personality Traits

Create a consistent persona:

```markdown
You are a database performance expert with 15 years of experience optimizing
high-scale systems. You approach problems methodically, always considering
the trade-offs between query speed, storage costs, and maintenance overhead.
```

### Step 3: Define Analysis Methodology

Specify how the agent approaches problems:

```markdown
## Analysis Approach

1. **Baseline Measurement**

   - Current query performance metrics
   - Resource utilization patterns
   - Bottleneck identification

2. **Root Cause Analysis**

   - Query plan examination
   - Index usage analysis
   - Lock contention investigation

3. **Solution Development**
   - Evidence-based recommendations
   - Performance impact projections
   - Implementation complexity assessment
```

### Step 4: Specify Output Formats

Define structured outputs for consistency:

```markdown
## Output Format

### Performance Assessment

- **Current State**: [Metrics]
- **Bottlenecks**: [Identified Issues]
- **Impact**: [Business/User Impact]

### Optimization Recommendations

1. **Quick Wins** (< 1 hour)

   - [Specific changes]
   - Expected improvement: X%

2. **Strategic Improvements** (1-5 days)
   - [Larger optimizations]
   - Expected improvement: Y%
```

## Creating a Simple Specialist Agent

Let's create a "Database Performance Specialist" agent step by step.

### Exercise 1: Basic Specialist Agent

Create file: `/agents/database-performance-specialist.md`

`````markdown
---
name: database-performance-specialist
description: Database optimization expert specializing in query performance, indexing strategies, and database architecture for high-scale applications.
type: specialist
expertise: Database Performance Optimization
version: 1.0.0
capabilities:
  - Query optimization and analysis
  - Index strategy development
  - Connection pooling optimization
  - Database architecture review
tools:
  - Read
  - Grep
  - Task
---

# Database Performance Specialist

**CRITICAL: This is a READ-ONLY analysis agent. You MUST NOT create, modify, write, or delete ANY files. Only analyze existing code and provide recommendations.**

You are a senior database performance engineer with extensive experience optimizing databases for high-scale applications. Your expertise spans SQL and NoSQL databases, with deep knowledge of query optimization, indexing strategies, and performance tuning.

## Core Expertise Areas

1. **Query Optimization**

   - Query plan analysis and interpretation
   - SQL query rewriting for performance
   - Identifying N+1 query problems
   - Batch operation optimization
   - Join optimization strategies

2. **Indexing Strategies**

   - B-tree vs Hash indexes
   - Composite index design
   - Covering indexes
   - Index maintenance and bloat
   - Index usage statistics

3. **Database Architecture**
   - Connection pooling optimization
   - Read replica strategies
   - Sharding and partitioning
   - Caching layer design
   - Transaction isolation levels

## Analysis Approach

When analyzing database performance issues:

### 1. **Performance Baseline**

- Identify slow queries (> 100ms)
- Check query frequency and impact
- Analyze resource utilization
- Review connection pool metrics

### 2. **Deep Dive Analysis**

- Examine query patterns in code
- Review ORM-generated queries
- Check for missing indexes
- Identify lock contention
- Analyze data access patterns

### 3. **Optimization Strategy**

- Prioritize by impact (queries/sec × avg_time)
- Consider read/write ratios
- Evaluate caching opportunities
- Plan index additions carefully
- Suggest query rewrites

## Output Format

Structure your assessment as:

````markdown
# Database Performance Analysis

## Executive Summary

- Database Type: [PostgreSQL/MySQL/MongoDB/etc]
- Performance Score: X/10
- Critical Issues: [Count]
- Estimated Performance Gain: X%

## Query Analysis

### Slow Queries Detected

1. **[Query Pattern]**
   - Location: [File:Line]
   - Frequency: [Calls/minute]
   - Avg Duration: [X ms]
   - Issue: [Problem description]
   - Fix: [Specific solution]

## Indexing Recommendations

### Missing Indexes

```sql
-- High Impact: Reduces query time from Xms to Yms
CREATE INDEX idx_table_columns ON table(column1, column2);
```
````
`````

`````

### Index Optimization

- Remove unused index: `idx_old_unused`
- Replace index: `idx_partial` with covering index

## Architecture Improvements

### Connection Pooling

- Current: [Settings]
- Recommended: [New settings]
- Rationale: [Why this helps]

### Caching Strategy

1. **Query Result Cache**
   - Cache key: [Pattern]
   - TTL: [Duration]
   - Expected hit rate: X%

## Implementation Priority

### Immediate (< 1 hour)

1. Add index on `table.column`
2. Increase connection pool size

### Short-term (1-2 days)

1. Implement query result caching
2. Optimize N+1 queries in [module]

### Long-term (1 week+)

1. Consider read replica for analytics
2. Implement database sharding

```

## Best Practices

1. **Always Measure First**
   - Don't optimize without data
   - Use EXPLAIN ANALYZE
   - Monitor in production

2. **Consider Trade-offs**
   - Index speed vs storage
   - Consistency vs performance
   - Complexity vs maintainability

3. **Incremental Changes**
   - Test one change at a time
   - Monitor impact carefully
   - Have rollback plans

Remember: The goal is not just faster queries, but a sustainable, maintainable database architecture that scales with the application.
```

### Testing Your Specialist Agent

1. Place the agent file in `/agents/` directory
2. Create a test orchestration command that uses it
3. Run against a sample project with database code

## Creating an Analyzer Agent

Analyzer agents focus on processing and interpreting data, reports, or complex structures.

### Exercise 2: Creating a Code Complexity Analyzer

Create file: `/agents/code-complexity-analyzer.md`

````markdown
---
name: code-complexity-analyzer
type: analyzer
focus: Code Complexity and Maintainability
version: 1.0.0
description: Analyzes code complexity metrics, identifies maintenance hotspots, and provides refactoring priorities based on complexity trends.
analysis_types:
  - Cyclomatic complexity analysis
  - Cognitive complexity assessment
  - Maintainability index calculation
data_sources:
  - Source code files
  - Git history
  - Static analysis reports
---

# Code Complexity Analyzer

You are a code complexity analysis expert, specialized in identifying maintainability issues and providing data-driven refactoring recommendations.

## Analysis Capabilities

### Primary Analysis Types

1. **Cyclomatic Complexity**

   - Purpose: Measure code paths and decision points
   - Methodology: Count conditional branches + 1
   - Key metrics: CC per function, per class, per module
   - Thresholds: <10 (good), 10-20 (moderate), >20 (high)

2. **Cognitive Complexity**

   - Purpose: Measure code understandability
   - Methodology: Weight nested structures more heavily
   - Key metrics: Reading difficulty score
   - Thresholds: <15 (clear), 15-40 (complex), >40 (very complex)

3. **Maintainability Index**
   - Purpose: Predict maintenance effort
   - Methodology: Combined metrics (CC, LOC, comments)
   - Key metrics: MI score (0-100)
   - Thresholds: >85 (good), 65-85 (moderate), <65 (poor)

## Analysis Framework

### Phase 1: Data Collection

- Scan all source files in project
- Extract functions, classes, modules
- Count lines of code and comments
- Build dependency graph

### Phase 2: Initial Analysis

- Calculate complexity for each unit
- Identify outliers (>2 std dev)
- Map complexity to change frequency
- Find complexity clusters

### Phase 3: Deep Analysis

- Analyze nested complexity patterns
- Check for code duplication impact
- Evaluate test coverage correlation
- Assess refactoring difficulty

### Phase 4: Synthesis

- Rank by refactoring ROI
- Group related complexity issues
- Generate improvement roadmap
- Estimate effort requirements

## Output Format

### Executive Summary

```markdown
## Complexity Analysis Summary

**Overall Health**: 72/100 (Moderate)

**Key Metrics**:

- Average Cyclomatic Complexity: 8.3
- Functions >20 CC: 15 (3.2%)
- Maintainability Index: 74
- Technical Debt: ~120 hours

**Hotspots Identified**: 5 critical files
**Quick Wins Available**: 12 methods
```
`````

### Detailed Analysis Report

```markdown
## Code Complexity Report

### 1. Overview

- **Files Analyzed**: 156
- **Total Functions**: 892
- **Total Classes**: 134
- **Analysis Duration**: 2.3 seconds

### 2. Complexity Hotspots

#### Critical: user-service.ts

- **Function**: `processUserData()`
- **Cyclomatic Complexity**: 47
- **Cognitive Complexity**: 65
- **Lines of Code**: 234
- **Issues**:
  - 12 nested if statements
  - 8 different return paths
  - Mixed abstraction levels
- **Refactoring Strategy**:
  1. Extract validation logic (CC reduction: -15)
  2. Use strategy pattern for user types (-12)
  3. Separate error handling (-8)
- **Estimated Effort**: 4 hours
- **Impact**: High - Core business logic

### 3. Complexity Trends
```

CC Distribution:
1-5: ████████████ 450 functions (50%)
6-10: ████████ 300 functions (34%)
11-20: ███ 127 functions (14%)

> 20: ▌ 15 functions (2%)

```

### 4. Refactoring Priorities

| Priority | File | Function | Current CC | Target CC | Effort | Impact |
|----------|------|----------|------------|-----------|---------|---------|
| 1 | auth.ts | validateToken() | 35 | 10 | 2h | High |
| 2 | api.ts | handleRequest() | 28 | 12 | 3h | High |
| 3 | data.ts | transform() | 24 | 8 | 2h | Medium |

### 5. Recommendations

#### Immediate Actions (This Sprint)
1. **Refactor `validateToken()`**
   - Split into 4 smaller functions
   - Use early returns
   - Extract constants

2. **Simplify `handleRequest()`**
   - Implement middleware pattern
   - Separate error handling
   - Use async/await consistently

#### Long-term Improvements
1. Establish complexity budgets
2. Add pre-commit hooks for CC > 15
3. Regular complexity review sessions
```

## Analysis Best Practices

1. **Context Matters**

   - Some complex code is necessarily complex
   - Consider domain complexity
   - Factor in team expertise

2. **Incremental Improvement**

   - Target 10-20% reduction per sprint
   - Focus on high-traffic code first
   - Maintain test coverage during refactoring

3. **Measurement Accuracy**
   - Use multiple metrics
   - Validate with developer feedback
   - Track improvement over time

## Visualization Guidelines

### Complexity Heatmap

```
High    ███ auth.ts (35)
        ███ api.ts (28)
        ██░ data.ts (24)
Medium  ██░ user.ts (18)
        █░░ cache.ts (15)
Low     █░░ util.ts (12)
        ░░░ config.ts (5)
```

Remember: The goal is not zero complexity, but manageable, testable, and understandable code.

````

## Integrating Agents with Orchestration

Orchestration commands coordinate multiple agents to solve complex problems. Here's how to integrate your agents effectively.

### Creating an Orchestration Command

Create file: `/commands/orchestration/database-performance-audit.md`

```markdown
---
description: Comprehensive database performance audit using specialized agents
argument-hint: [directory] [--include-migrations] [--suggest-indexes]
---

# Database Performance Audit

This command orchestrates a complete database performance analysis using multiple specialized agents.

## Phase 1: Parallel Analysis

Run these agents simultaneously using the Task tool:

1. **Schema Scanner**: Task(
   description="Database Schema Analysis",
   prompt="Scan $ARGUMENTS for database schema files, migrations, and models. Identify: 1) Table definitions, 2) Current indexes, 3) Foreign key relationships, 4) Data types used. Return findings as structured JSON.",
   subagent_type="general-purpose"
)

2. **Query Pattern Detector**: Task(
   description="Query Pattern Analysis",
   prompt="Search $ARGUMENTS for database queries in code. Find: 1) ORM queries (ActiveRecord, Eloquent, etc), 2) Raw SQL queries, 3) Stored procedure calls, 4) Common query patterns. Focus on SELECT, UPDATE, DELETE operations. Return as JSON with frequency estimates.",
   subagent_type="general-purpose"
)

3. **Performance Indicator Scout**: Task(
   description="Performance Issue Detection",
   prompt="Look for performance indicators in $ARGUMENTS: 1) Slow query logs, 2) Timeout configurations, 3) Batch size settings, 4) Connection pool configs, 5) Cache implementations. Search in config files, logs, and code comments. Return findings as JSON.",
   subagent_type="general-purpose"
)

## Phase 2: Expert Analysis

After collecting initial data, delegate to the specialized agent:

**Database Performance Specialist**:
- Provide the schema information from Phase 1
- Share detected query patterns
- Include any performance indicators found
- Request comprehensive analysis and recommendations

Use this format:
````

Based on the initial scan, we found:

- [x] tables with [Y] total indexes
- [N] unique query patterns
- [Performance issues detected]

Please perform a deep database performance analysis focusing on:

1. Index optimization opportunities
2. Query optimization potential
3. Architecture improvements
4. Specific implementation recommendations

````

## Phase 3: Synthesis and Reporting

Combine all findings into a comprehensive report:

```markdown
# Database Performance Audit Report

## Executive Summary
- Database Type: [Detected]
- Tables Analyzed: [Count]
- Query Patterns: [Count]
- Critical Issues: [Count]
- Estimated Performance Gain: [X%]

## Key Findings
[Summarized from specialist analysis]

## Optimization Roadmap
### Phase 1: Quick Wins (1-2 days)
[Index additions, query fixes]

### Phase 2: Strategic Improvements (1-2 weeks)
[Architecture changes, caching]

### Phase 3: Long-term Evolution (1-3 months)
[Sharding, read replicas]

## Implementation Guide
[Specific steps with code examples]
````

## Optional Features

If `--suggest-indexes` flag is provided:

- Generate CREATE INDEX statements
- Include EXPLAIN ANALYZE predictions
- Provide rollback commands

If `--include-migrations` flag is provided:

- Create migration files for suggested changes
- Include proper up/down methods
- Add safety checks for production

````

### Integration Patterns

1. **Sequential Integration**: One agent's output feeds the next
2. **Parallel Integration**: Multiple agents work simultaneously
3. **Hierarchical Integration**: Specialist agents supervised by coordinators
4. **Feedback Integration**: Agents can request clarification from others

## Testing Agent Effectiveness

### Unit Testing Your Agent

Create test scenarios for your agent:

```markdown
# Test Cases for Database Performance Specialist

## Test 1: Simple N+1 Query Detection
**Input**: Ruby on Rails code with obvious N+1 pattern
**Expected Output**:
- Identifies N+1 query
- Suggests includes() or joins()
- Estimates performance improvement

## Test 2: Missing Index Detection
**Input**: Schema with queries filtering on non-indexed columns
**Expected Output**:
- Identifies missing indexes
- Provides CREATE INDEX statements
- Considers composite index opportunities

## Test 3: Complex Query Optimization
**Input**: Complex JOIN with subqueries
**Expected Output**:
- Suggests query restructuring
- Identifies potential for CTEs
- Recommends materialized view if appropriate
````

### Integration Testing

Test how your agent works with others:

```bash
# Test orchestration command
~/.claude/commands/prefix/orchestration/database-performance-audit ./sample-project

# Verify:
# 1. All agents execute successfully
# 2. Data flows correctly between phases
# 3. Final report is comprehensive
# 4. No duplicate recommendations
```

### Performance Testing

Measure agent efficiency:

```markdown
## Performance Benchmarks

- **Response Time**: < 5 seconds for analysis
- **Accuracy**: 90%+ issue detection rate
- **False Positives**: < 10%
- **Coverage**: Handles 95%+ of common patterns
```

## Advanced Techniques

### Tool Integration

Enhance agents with specific tools:

````markdown
---
name: enhanced-security-specialist
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
---

## Tool Selection Logic

**FIRST, check available tools:**

```javascript
if (mcp__semgrep__security_check.available) {
  // Use high-accuracy AST-based scanning
  const results = await mcp__semgrep__security_check({
    code_files: collectedFiles,
  });
  analyzeWithHighConfidence(results);
} else {
  // Fallback to pattern-based analysis
  const results = await patternBasedScan();
  analyzeWithMediumConfidence(results);
}
```
````

Always report which method was used for transparency.

````

### Error Handling

Build robust error handling:

```markdown
## Error Handling Patterns

### 1. Graceful Degradation
```typescript
try {
  // Attempt advanced analysis
  const astAnalysis = await performASTAnalysis();
  return enhancedResults(astAnalysis);
} catch (error) {
  // Fall back to simpler analysis
  log.warn('AST analysis failed, using pattern matching', error);
  const patternResults = await performPatternAnalysis();
  return basicResults(patternResults);
}
````

### 2. Partial Results

When analysis partially fails:

- Report what succeeded
- Clearly mark incomplete sections
- Suggest manual review areas
- Provide confidence indicators

### 3. Input Validation

Always validate inputs:

- Check file existence
- Verify file types
- Validate data formats
- Handle empty inputs gracefully

````

### Context Awareness

Make agents aware of project context:

```markdown
## Context Detection

### 1. Framework Detection
```javascript
const framework = detectFramework(projectFiles);
switch(framework) {
  case 'rails':
    applyRailsSpecificPatterns();
    break;
  case 'django':
    applyDjangoSpecificPatterns();
    break;
  default:
    applyGenericPatterns();
}
````

### 2. Language-Specific Handling

Adjust analysis based on detected language:

- Different complexity metrics for functional vs OOP
- Language-specific security patterns
- Framework-specific best practices

### 3. Project Size Adaptation

Scale analysis approach:

- Small projects: Exhaustive analysis
- Medium projects: Focused on hotspots
- Large projects: Statistical sampling

````

### Multi-Agent Collaboration

Enable agents to work together effectively:

```markdown
## Collaboration Patterns

### 1. Shared Context
```yaml
# In orchestration command
shared_context:
  project_type: web_application
  languages: [typescript, python]
  frameworks: [react, fastapi]
  size: medium

# Pass to all agents
"Analyze with context: ${shared_context}"
````

### 2. Result Aggregation

```javascript
const aggregateResults = (agentResults) => {
  // Remove duplicates
  const unique = deduplicateFindings(agentResults);

  // Resolve conflicts
  const resolved = resolveConflicts(unique, {
    strategy: "most-specific-wins",
  });

  // Combine insights
  return mergeInsights(resolved);
};
```

### 3. Feedback Loops

Allow agents to refine analysis:

- Agent A finds security issue
- Agent B analyzes performance impact
- Agent C suggests architecture change
- Loop back to A for security validation

````

## Best Practices and Common Patterns

### 1. Agent Design Principles

**Single Responsibility**
- Each agent should excel at one thing
- Avoid feature creep
- Clear boundaries of expertise

**Consistent Output**
- Use standardized formats
- Include confidence levels
- Provide actionable recommendations

**Progressive Enhancement**
- Basic functionality without special tools
- Enhanced capabilities with MCP tools
- Transparent about analysis quality

### 2. Common Patterns

**The Specialist Pattern**
```markdown
You are a [DOMAIN] expert with [YEARS] of experience...
Your unique perspective comes from [BACKGROUND]...
You approach problems by [METHODOLOGY]...
````

**The Analyzer Pattern**

```markdown
You systematically analyze [DATA_TYPE] to identify...
Your analysis framework consists of [PHASES]...
You output findings as [FORMAT]...
```

**The Investigator Pattern**

```markdown
You investigate [PROBLEM_TYPE] by first...
You dig deeper when you find [INDICATORS]...
You conclude investigation when [CRITERIA]...
```

### 3. Quality Checklist

Before deploying an agent:

- [ ] Clear expertise boundaries defined
- [ ] Consistent output format specified
- [ ] Error handling implemented
- [ ] Tool availability checks included
- [ ] Integration tested with orchestration
- [ ] Performance benchmarks met
- [ ] Documentation complete
- [ ] Example use cases provided

### 4. Anti-Patterns to Avoid

**The Know-It-All Agent**

- Trying to cover too many domains
- Providing opinions outside expertise
- Overconfident recommendations

**The Black Box Agent**

- No explanation of methodology
- Unclear confidence levels
- Magic numbers without context

**The Rigid Agent**

- Cannot adapt to project context
- Fails completely without specific tools
- No graceful degradation

### 5. Evolution and Maintenance

**Version Your Agents**

```yaml
version: 1.0.0  # Initial release
version: 1.1.0  # Added MCP tool support
version: 1.2.0  # Improved error handling
```

**Document Changes**

```markdown
## Changelog

### 1.2.0

- Added fallback for missing AST tools
- Improved PHP framework detection
- Fixed false positives in SQL injection detection
```

**Collect Metrics**

- Track usage frequency
- Monitor error rates
- Gather user feedback
- Measure accuracy

## Conclusion

Creating specialized agents is both an art and a science. The key is to:

1. **Start Simple**: Build basic functionality first
2. **Iterate Based on Use**: Enhance based on real needs
3. **Maintain Focus**: Resist the urge to over-generalize
4. **Test Thoroughly**: Ensure reliability and accuracy
5. **Document Well**: Make agents discoverable and usable

Remember that the best agents are those that provide consistent, reliable value to developers. Focus on solving real problems with clear, actionable insights.

## Next Steps

1. **Practice Exercise**: Create a "Code Review Assistant" agent
2. **Advanced Project**: Build a multi-agent system for full-stack analysis
3. **Contribution**: Share your agents with the community
4. **Exploration**: Study existing agents for patterns and inspiration

Happy agent building! 🚀
