---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(time:*), Bash(prof:*)
description: Deep Performance Profiling with 7 Agents for Bottleneck Identification and Optimization
argument-hint: [directory] [--profile=cpu|memory|io|all]
---

# Performance Scan Command

This command performs deep performance profiling with 7 specialized agents. Identifies performance bottlenecks and suggests concrete optimizations.

## Execution

**IMMEDIATELY START 7 PARALLEL PERFORMANCE AGENTS:**

1. **Algorithm Complexity Agent**: Task(description="Analyze Algorithm Complexity", prompt="Analyze algorithmic complexity in $ARGUMENTS. Identify: 1) Nested Loops (O(n²) or worse), 2) Recursive Functions without Memoization, 3) Inefficient Sorting Algorithms, 4) Brute-Force Approaches, 5) Polynomial/Exponential Complexity. Use code pattern analysis. Return Hot Spots with Big-O Notation and optimization suggestions as JSON.", subagent_type="general-purpose")

2. **Database Query Agent**: Task(description="Database Performance Analysis", prompt="Examine Database Query Performance in $ARGUMENTS. Check: 1) N+1 Query Problems, 2) Missing Indexes (JOINs, WHERE clauses), 3) Full Table Scans, 4) Inefficient Subqueries, 5) Missing Query Caching, 6) Transaction Scope Issues. Search for SQL/ORM Patterns. Return problematic queries with Optimization Hints as JSON.", subagent_type="general-purpose")

3. **Memory Usage Agent**: Task(description="Memory Pattern Analysis", prompt="Analyze Memory Usage Patterns in $ARGUMENTS. Identify: 1) Memory Leaks (unreleased resources), 2) Large Object Allocations, 3) Inefficient Data Structures, 4) Circular References, 5) Cache Misuse, 6) String Concatenation in Loops. Focus on Memory-intensive Operations. Return Memory Hot Spots with fix strategies as JSON.", subagent_type="general-purpose")

4. **CPU Hotspot Agent**: Task(description="CPU Usage Profiling", prompt="Find CPU-intensive code areas in $ARGUMENTS. Analyze: 1) Tight Loops with heavy Computations, 2) Synchronous Blocking Operations, 3) Regex Catastrophic Backtracking, 4) JSON Parse/Stringify in Loops, 5) Crypto Operations, 6) Image/Video Processing. Return CPU Hotspots with parallelization possibilities as JSON.", subagent_type="general-purpose")

5. **I/O Bottleneck Agent**: Task(description="I/O Performance Analysis", prompt="Identify I/O Bottlenecks in $ARGUMENTS. Examine: 1) Synchronous File Operations, 2) Network Calls in Loops, 3) Missing Batch Operations, 4) Inefficient Streaming, 5) Missing Compression, 6) Serial instead of Parallel I/O. Search for fs, http, database I/O Patterns. Return I/O Bottlenecks with Async/Batch alternatives as JSON.", subagent_type="general-purpose")

6. **Caching Opportunity Agent**: Task(description="Cache Optimization Analysis", prompt="Find caching opportunities in $ARGUMENTS. Analyze: 1) Repeated Expensive Calculations, 2) Redundant API/DB Calls, 3) Missing HTTP Cache Headers, 4) Missing Memoization, 5) Static Data Recomputation, 6) Missing CDN Usage. Calculate potential Performance Gains. Return Caching Opportunities with implementation strategies as JSON.", subagent_type="general-purpose")

7. **Optimization Strategy Agent**: Task(description="Performance Optimization Plan", prompt="Develop Optimization Strategies for $ARGUMENTS based on Common Patterns. Create: 1) Quick Wins (< 1h effort), 2) Medium Optimizations (1-5h), 3) Major Refactoring (> 5h). Consider: Code Splitting, Lazy Loading, Worker Threads, Debouncing, Virtual Scrolling. Return prioritized Optimization Roadmap as JSON.", subagent_type="general-purpose")

## Synthesis

After completion of all Performance Agents:

1. **Create Performance Score Card**:
   ```markdown
   # Performance Analysis Report
   
   ## Overall Performance Score: C+ (65/100)
   
   ### Breakdown by Category
   - Algorithm Efficiency: B (75/100)
   - Database Performance: D (45/100)
   - Memory Management: C (60/100)
   - CPU Utilization: B- (70/100)
   - I/O Efficiency: C- (55/100)
   ```

2. **Identify Top Bottlenecks**:
   ```markdown
   ## Critical Performance Issues
   
   1. **Database N+1 Problem** (Impact: HIGH)
      - Location: UserService.getWithPosts()
      - Current: 100 queries per request
      - Solution: Add eager loading
      - Expected Improvement: 95% reduction
   
   2. **O(n³) Algorithm** (Impact: HIGH)
      - Location: DataProcessor.correlate()
      - Current: 5s for 1000 items
      - Solution: Use hash maps
      - Expected Improvement: 99% reduction
   ```

3. **Generate Optimization Roadmap**:
   ```markdown
   ## Performance Optimization Roadmap
   
   ### Phase 1: Quick Wins (1 day)
   - [ ] Add database indexes (2h, +40% query speed)
   - [ ] Enable HTTP caching (1h, -30% server load)
   - [ ] Fix N+1 queries (3h, -90% DB load)
   
   ### Phase 2: Medium Impact (1 week)
   - [ ] Implement Redis caching (8h, +60% response time)
   - [ ] Optimize algorithms (12h, +80% processing speed)
   - [ ] Add pagination (4h, -70% memory usage)
   
   ### Phase 3: Architecture (1 month)
   - [ ] Implement job queues (40h)
   - [ ] Add microservice caching layer (60h)
   - [ ] Database sharding (80h)
   ```

4. **Code-Level Optimizations**:
   ```javascript
   // Before: O(n²) search
   function findDuplicates(arr) {
     const duplicates = [];
     for (let i = 0; i < arr.length; i++) {
       for (let j = i + 1; j < arr.length; j++) {
         if (arr[i] === arr[j]) duplicates.push(arr[i]);
       }
     }
   }
   
   // After: O(n) with Set
   function findDuplicates(arr) {
     const seen = new Set();
     const duplicates = new Set();
     for (const item of arr) {
       if (seen.has(item)) duplicates.add(item);
       seen.add(item);
     }
     return Array.from(duplicates);
   }
   ```

5. **Performance Budget**:
   - Page Load: < 3s (currently 5.2s)
   - API Response: < 200ms (currently 450ms)
   - Memory Usage: < 512MB (currently 780MB)

**Performance Expectation**: Analysis in 6-8 seconds, compared to 45-55 seconds sequentially.

**Follow-up**: Use profiling tools like Chrome DevTools, New Relic, or Datadog for detailed monitoring.