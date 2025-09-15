# Performance Optimizer Agent

## Overview

The Performance Optimizer is a knowledge-enhanced specialist in performance analysis and optimization, focusing on identifying bottlenecks, memory leaks, and algorithmic inefficiencies. This agent provides detailed performance profiling, optimization strategies, and helps achieve optimal application performance through systematic analysis and proven optimization patterns accumulated via Basic Memory integration.

## Capabilities

- **Performance Profiling Excellence**: CPU utilization analysis, memory usage patterns, I/O bottleneck identification, network latency analysis, and database query optimization
- **Algorithmic Optimization**: Time complexity analysis (Big O), space complexity optimization, data structure selection, algorithm design patterns, and cache optimization strategies
- **System-Level Performance**: Concurrency and parallelization analysis, asynchronous programming patterns, resource pooling, connection management, and load balancing techniques
- **Memory Analysis Expertise**: Memory leak detection, garbage collection pattern analysis, object allocation optimization, circular reference detection, and heap usage monitoring
- **Database Performance Tuning**: N+1 query problem identification, query execution plan analysis, index optimization, connection pooling evaluation, and caching strategy implementation
- **Concurrency and Scaling**: Race condition detection, thread contention analysis, lock contention identification, async/await optimization, and parallelization opportunities
- **Cross-Project Learning**: Apply successful optimization patterns from previous projects via Basic Memory
- **Pattern Recognition**: Identify recurring performance issues and proven solutions from accumulated knowledge
- **Ultra-Intensive Analysis**: When in PERFORMANCE CRISIS mode, uses maximum reasoning depth to uncover subtle bottlenecks and compound performance issues

## Usage

### Direct Invocation

Use the Task tool to invoke the Performance Optimizer directly:

```markdown
Use Task tool with subagent_type="performance-optimizer":
"Analyze the application for performance bottlenecks, focusing on API response times, database queries, and memory usage patterns. Provide optimization strategies with impact estimates."
```

### Through Core Commands

The Performance Optimizer integrates with core commands:

- **`/prefix:understand`**: Contributes performance context during codebase analysis
- **`/prefix:improve`**: Provides performance-specific optimization recommendations
- **`/prefix:secure`**: Analyzes performance implications of security implementations

### Performance Crisis Mode

For critical performance issues, use intensive analysis:

```markdown
Use Task tool with subagent_type="performance-optimizer":
"PERFORMANCE CRISIS: Our API response times have degraded to 5+ seconds. Perform ultra-intensive analysis to identify all contributing factors and provide emergency optimization plan."
```

## Output Format

The Performance Optimizer delivers comprehensive performance assessment reports:

```markdown
# Performance Analysis Report

## Executive Summary
- Overall performance score: X/100
- Critical bottlenecks identified: [count]
- Potential performance gains: up to X% improvement
- Recommended optimization timeline: [timeframe]

## Performance Bottlenecks

### [Bottleneck Name] - Critical
**Severity**: Critical | **Location**: `path/to/file.js:123-145`
**Current Performance**:
- Execution time: 2.5s avg (target: <500ms)
- Memory allocated: 150MB per request
- CPU usage: 45% for single operation

**Impact Analysis**:
- User experience: 3s page load time
- System capacity: Blocks 5 concurrent requests
- Business impact: 15% cart abandonment rate

**Root Cause**: O(n³) complexity in nested loops

**Optimization Strategy**:
1. **Quick Win** (2-4 hours): Add result caching → 60% improvement
2. **Algorithm Fix** (2-3 days): Replace with hash map → 95% improvement
3. **Architecture Change** (1-2 weeks): Background processing → 99% improvement

## Performance Metrics Dashboard

| Endpoint/Function | P50 | P95 | P99 | Target | Status |
|------------------|-----|-----|-----|--------|--------|
| `/api/users` | 45ms | 120ms | 250ms | <100ms | ⚠️ |
| `/api/products` | 200ms | 800ms | 1.5s | <200ms | ❌ |
| `processOrder()` | 1.2s | 3.5s | 5s | <1s | ❌ |

## Resource Utilization Analysis

| Resource | Current | Optimal | Impact | Priority |
|----------|---------|---------|--------|----------|
| CPU Usage | 85% avg | <70% | High | Critical |
| Memory | 4.2GB/8GB | <3GB | Medium | High |
| DB Connections | 95/100 | <80 | High | Critical |
| Cache Hit Rate | 45% | >90% | High | High |

## Optimization Roadmap
- **Phase 1** (1-2 days): Quick wins and immediate fixes
- **Phase 2** (1 week): Structural improvements and algorithm optimization
- **Phase 3** (2-4 weeks): Architecture changes and system redesign
```

## Examples

### Example 1: API Performance Analysis

```bash
Use Task tool with subagent_type="performance-optimizer":
"Our REST API endpoints are showing slow response times. Analyze the request/response cycle, database interactions, and serialization processes to identify optimization opportunities."
```

**Expected Output**: Detailed API performance report with request flow analysis, database query optimization, caching recommendations, and serialization improvements.

### Example 2: Memory Leak Investigation

```bash
Use Task tool with subagent_type="performance-optimizer":
"Memory usage is continuously growing in our Node.js application. Investigate potential memory leaks, analyze garbage collection patterns, and recommend fixes."
```

**Expected Output**: Memory analysis report with leak detection, GC pattern analysis, object lifecycle tracking, and remediation strategies.

### Example 3: Database Performance Optimization

```bash
Use Task tool with subagent_type="performance-optimizer":
"Database queries are the primary bottleneck in our application. Analyze query patterns, index usage, and connection pooling for optimization opportunities."
```

**Expected Output**: Database performance report with query analysis, index recommendations, connection pool optimization, and caching strategy.

## Tools Used

- **Read**: Analyzes performance-critical code, configuration files, and profiling data
- **Grep**: Searches for performance patterns, inefficient algorithms, and resource usage across the codebase
- **Task**: Coordinates with other specialists for comprehensive performance analysis and captures optimization patterns to Basic Memory

## See Also

- [Code Understanding Specialist](code-understanding-specialist.md) - For architectural context in performance analysis
- [Refactoring Expert](refactoring-expert.md) - For performance-focused refactoring strategies
- [AI Specialist](ai-specialist.md) - For AI system performance optimization
- [Security Specialist](../security/security-specialist.md) - For performance impact of security measures
- [Report Analyzer](report-analyzer.md) - For performance trend analysis over time
- [Performance Guide](../../guides/PERFORMANCE-OPTIMIZATION.md) - Performance optimization methodologies
- [Monitoring Guide](../../guides/PERFORMANCE-MONITORING.md) - Performance monitoring best practices
