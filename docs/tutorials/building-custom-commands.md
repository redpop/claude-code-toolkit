# Building Custom Commands: A Comprehensive Tutorial

This hands-on tutorial will teach you how to create powerful custom commands for the Claude Code Toolkit. By the end, you'll be able to build commands ranging from simple utilities to complex multi-agent orchestrations.

## Table of Contents

1. [Understanding Command Structure](#understanding-command-structure)
2. [Choosing the Right Template](#choosing-the-right-template)
3. [Building a Simple Analysis Command](#building-a-simple-analysis-command)
4. [Creating an MCP-Enhanced Command](#creating-an-mcp-enhanced-command)
5. [Building a Hybrid Command with Sub-Agents](#building-a-hybrid-command-with-sub-agents)
6. [Testing and Debugging](#testing-and-debugging)
7. [Best Practices](#best-practices)
8. [Publishing and Sharing](#publishing-and-sharing)

## Understanding Command Structure

### Anatomy of a Command

Every Claude Code command is a Markdown file with specific components:

```markdown
---
# Frontmatter (YAML)
allowed-tools: Task, Read, Grep, Bash, Write
description: Brief description for command listing
argument-hint: [expected-arguments] [--options]
---

# Command Content
Command documentation and implementation instructions...
```

### Key Components

1. **Frontmatter**: YAML metadata that Claude Code uses
   - `description`: Appears in command listings
   - `argument-hint`: Shows expected arguments for auto-completion
   - `allowed-tools`: Tools the command can use
   - `mcp-enhanced`: Optional MCP tools that enhance functionality

2. **Command Body**: Markdown instructions that guide Claude Code
   - Clear workflow steps
   - Tool usage patterns
   - Output formatting
   - Error handling

### Command Naming Convention

Commands follow a hierarchical namespace:

```
commands/category/subcategory/command-name.md
→ /prefix:category:subcategory:command-name
```

Example:
```
commands/analysis/security-scan.md → /prefix:analysis:security-scan
commands/git/advanced/cherry-pick.md → /prefix:git:advanced:cherry-pick
```

## Choosing the Right Template

### Template Overview

| Template | Use Case | Key Features |
|----------|----------|--------------|
| `basic-sub-agent.md` | Simple parallel tasks | Quick parallel scanning with Task Tool |
| `mcp-aware-command.md` | Enhanced with external tools | Graceful fallback, tool detection |
| `hybrid-sub-agent.md` | Complex multi-phase analysis | Scanning → Expert delegation → Synthesis |
| `analysis-sub-agent.md` | Focused analysis tasks | Single-purpose deep analysis |
| `specialist-agent.md` | Domain expert commands | Specialized knowledge application |

### Decision Tree

```
Need parallel processing?
├─ Yes → Multiple related tasks?
│   ├─ Yes → Need expert analysis? 
│   │   ├─ Yes → hybrid-sub-agent.md
│   │   └─ No → basic-sub-agent.md
│   └─ No → analysis-sub-agent.md
└─ No → Need external tools?
    ├─ Yes → mcp-aware-command.md
    └─ No → specialist-agent.md
```

## Building a Simple Analysis Command

Let's create a command that analyzes code for common anti-patterns.

### Step 1: Create the Command File

Create `commands/analysis/anti-patterns.md`:

```markdown
---
allowed-tools: Task, Read, Grep
description: Detect common anti-patterns in your codebase
argument-hint: [directory] [--language=javascript|python|java]
---

# Anti-Pattern Detection Command

This command scans your codebase for common anti-patterns and provides recommendations for improvement.

## Execution

**START 5 PARALLEL SCANNING AGENTS:**

1. **God Object Scanner**: Task(
   description="Detect God Objects/Classes",
   prompt="Scan $ARGUMENTS for God Objects. Look for:
   - Classes with >20 methods
   - Classes with >500 lines
   - Classes handling multiple unrelated responsibilities
   Return findings as JSON with: {file, class_name, method_count, line_count, responsibilities}",
   subagent_type="general-purpose"
)

2. **Spaghetti Code Scanner**: Task(
   description="Detect tangled code flow",
   prompt="Scan $ARGUMENTS for spaghetti code patterns:
   - Functions with >5 levels of nesting
   - Goto-like patterns (multiple returns, breaks)
   - Complex conditional chains (>4 if-else)
   Return as JSON: {file, function, nesting_level, complexity_score}",
   subagent_type="general-purpose"
)

3. **Copy-Paste Scanner**: Task(
   description="Find duplicate code blocks",
   prompt="Detect copy-paste programming in $ARGUMENTS:
   - Duplicate code blocks (>10 lines similar)
   - Similar function implementations
   - Repeated patterns that could be abstracted
   Return as JSON: {original_location, duplicate_locations, similarity_percentage}",
   subagent_type="general-purpose"
)

4. **Magic Number Scanner**: Task(
   description="Find hardcoded values",
   prompt="Scan $ARGUMENTS for magic numbers and strings:
   - Hardcoded numeric values (not 0, 1, -1)
   - Hardcoded strings (not simple labels)
   - Configuration values in code
   Return as JSON: {file, line, value, context, suggested_constant_name}",
   subagent_type="general-purpose"
)

5. **Long Method Scanner**: Task(
   description="Find overly complex methods",
   prompt="Identify long methods in $ARGUMENTS:
   - Methods >50 lines
   - Methods with >10 parameters
   - Methods doing multiple unrelated things
   Return as JSON: {file, method, line_count, parameter_count, responsibilities}",
   subagent_type="general-purpose"
)

## Synthesis

After all agents complete:

1. **Aggregate Results**: Combine all JSON findings
2. **Calculate Severity**: Score each anti-pattern by impact
3. **Generate Report**:

```markdown
# Anti-Pattern Analysis Report

## Summary
- **Files Analyzed**: [count]
- **Anti-Patterns Found**: [total]
- **Critical Issues**: [count]

## Findings by Severity

### 🔴 Critical (Immediate Action Required)
[List critical anti-patterns with locations]

### 🟡 Warning (Should Be Addressed)
[List warning-level anti-patterns]

### 🟢 Minor (Nice to Fix)
[List minor issues]

## Recommendations

### Quick Wins (< 1 hour)
1. [Specific refactoring with example]

### Medium Effort (1-4 hours)
1. [Refactoring requiring more work]

### Major Refactoring (> 4 hours)
1. [Significant architectural changes]
```

## Notes
- Focuses on language-agnostic patterns by default
- Use --language flag for language-specific anti-patterns
- Provides actionable refactoring suggestions
```

### Step 2: Test the Command

```bash
# Install locally for testing
./install.sh test

# Run the command
/test:analysis:anti-patterns ./src --language=javascript
```

### Step 3: Iterate and Improve

Based on testing:
1. Adjust detection patterns
2. Refine JSON output format
3. Improve report formatting
4. Add language-specific rules

## Creating an MCP-Enhanced Command

Let's build a documentation quality checker that uses MCP when available.

### Step 1: Create the Command

Create `commands/analysis/doc-quality.md`:

```markdown
---
allowed-tools: Task, Read, Grep, Bash
mcp-enhanced: mcp__semgrep__get_abstract_syntax_tree
description: Analyze documentation quality with optional AST analysis
argument-hint: [directory] [--strict] [--format=markdown|json]
---

# Documentation Quality Analysis

Comprehensive documentation quality checker that leverages AST analysis when available for deeper insights.

## Tool Detection

**FIRST, CHECK AVAILABLE TOOLS:**

```python
# Check for MCP AST tool
ast_available = check_tool("mcp__semgrep__get_abstract_syntax_tree")

# Check for local alternatives
jsdoc_available = bash("which jsdoc") == 0
pydoc_available = bash("which pydoc") == 0

# Determine strategy
if ast_available:
    strategy = "ast_enhanced"
elif jsdoc_available or pydoc_available:
    strategy = "tool_based"
else:
    strategy = "pattern_based"

print(f"Using {strategy} analysis strategy")
```

## Execution Strategy

### Option A: AST-Enhanced Analysis (Preferred)

**IF AST tool is available:**

1. **Deep Function Analysis**: For each file:
   ```python
   # Get AST
   ast = mcp__semgrep__get_abstract_syntax_tree(
       code=file_content,
       language=detected_language
   )
   
   # Extract all functions/methods
   functions = extract_functions_from_ast(ast)
   
   # Check each function for:
   # - Missing docstring/comment
   # - Parameter mismatches
   # - Return type documentation
   # - Complexity vs documentation detail
   ```

2. **Semantic Documentation Check**:
   - Compare documented parameters with actual parameters
   - Verify return type documentation matches code
   - Check if complex functions have examples
   - Validate that documented exceptions are actually thrown

### Option B: Tool-Based Analysis

**IF local documentation tools available:**

```bash
# For JavaScript
jsdoc -X $file | jq '.[] | select(.undocumented == true)'

# For Python
python -m pydoc -w $module
# Parse output for missing docs
```

### Option C: Pattern-Based Fallback

**IF no specialized tools available:**

```python
# Use regex patterns to find:
# - Function definitions without preceding comments
# - TODO/FIXME comments indicating incomplete docs
# - Outdated copyright years
# - Broken markdown links
# - Missing README sections
```

## Result Processing

```python
def process_results(findings, strategy_used):
    """Normalize results from different strategies"""
    
    report = {
        "summary": {
            "files_analyzed": len(findings),
            "strategy_used": strategy_used,
            "quality_score": calculate_score(findings),
            "enhancement_available": strategy_used != "ast_enhanced"
        },
        "findings": normalize_findings(findings),
        "recommendations": generate_recommendations(findings)
    }
    
    if strategy_used != "ast_enhanced":
        report["enhancement_note"] = (
            "Install Semgrep MCP for deeper analysis including:\n"
            "- Automatic parameter verification\n"
            "- Return type checking\n"
            "- Exception documentation validation"
        )
    
    return report
```

## Output Format

```markdown
# Documentation Quality Report

**Analysis Method**: {strategy_used}
**Quality Score**: {score}/100 {emoji}

## Coverage Summary

| Metric | Current | Target | Status |
|--------|---------|--------|--------|
| Functions Documented | 75% | 90% | 🟡 |
| Parameters Documented | 60% | 95% | 🔴 |
| Examples Provided | 40% | 70% | 🟡 |
| README Completeness | 85% | 100% | 🟢 |

## Critical Issues

### Missing Documentation
{list of undocumented functions with severity}

### Parameter Mismatches
{list of functions where docs don't match code}

### Broken References
{list of broken links and references}

## Recommendations

{if not using AST}
💡 **Enhance This Analysis**: Install Semgrep MCP for automatic parameter verification and deeper insights.
```

## Best Practices

1. **Always provide fallback**: Never require MCP for basic functionality
2. **Report enhancement opportunities**: Tell users what they're missing
3. **Normalize output**: Same format regardless of tool used
4. **Progressive enhancement**: Better tools = better analysis, not different analysis
```

## Building a Hybrid Command with Sub-Agents

Let's create a comprehensive code review command that combines parallel scanning with expert analysis.

### Step 1: Design the Architecture

```
Phase 1: Parallel Scanning (5 agents, ~5 seconds)
    ↓
Phase 2: Expert Delegation (2-3 specialists, ~15 seconds)
    ↓
Phase 3: Synthesis & Reporting (~2 seconds)
```

### Step 2: Create the Command

Create `commands/review/comprehensive.md`:

```markdown
---
allowed-tools: Task, Read, Grep, Bash, Write
description: Comprehensive code review with expert analysis
argument-hint: [directory] [--pr-mode] [--export-report]
---

# Comprehensive Code Review

Multi-phase code review combining rapid scanning with deep expert analysis.

## Phase 1: Parallel Scanning (7 agents)

**IMMEDIATELY START ALL SCANNING AGENTS:**

```python
# Define scanning configuration
scanners = [
    {
        "name": "Style Scanner",
        "task": Task(
            description="Check code style consistency",
            prompt="""Scan $ARGUMENTS for style issues:
            - Inconsistent naming (camelCase vs snake_case)
            - Inconsistent indentation
            - Line length violations (>100 chars)
            - Trailing whitespace
            Return JSON: {file, issues[], style_score}""",
            subagent_type="general-purpose"
        )
    },
    {
        "name": "Security Scanner",
        "task": Task(
            description="Quick security check",
            prompt="""Scan $ARGUMENTS for security issues:
            - Hardcoded credentials
            - SQL injection risks
            - XSS vulnerabilities
            - Insecure dependencies
            Flag items needing expert review.
            Return JSON: {file, vulnerabilities[], needs_expert}""",
            subagent_type="general-purpose"
        )
    },
    {
        "name": "Logic Scanner",
        "task": Task(
            description="Find logic errors",
            prompt="""Scan $ARGUMENTS for logic issues:
            - Off-by-one errors
            - Null reference risks
            - Race conditions
            - Infinite loops
            Return JSON: {file, logic_issues[], severity}""",
            subagent_type="general-purpose"
        )
    },
    {
        "name": "Performance Scanner",
        "task": Task(
            description="Detect performance issues",
            prompt="""Scan $ARGUMENTS for performance problems:
            - N+1 queries
            - Unnecessary loops
            - Memory leaks
            - Blocking I/O
            Return JSON: {file, perf_issues[], impact}""",
            subagent_type="general-purpose"
        )
    },
    {
        "name": "Test Scanner",
        "task": Task(
            description="Analyze test quality",
            prompt="""Analyze tests in $ARGUMENTS:
            - Test coverage gaps
            - Missing edge cases
            - Test quality issues
            - Flaky test patterns
            Return JSON: {coverage_gaps[], test_quality_score}""",
            subagent_type="general-purpose"
        )
    },
    {
        "name": "Documentation Scanner",
        "task": Task(
            description="Check documentation",
            prompt="""Check docs in $ARGUMENTS:
            - Missing function docs
            - Outdated comments
            - TODO/FIXME items
            - API documentation gaps
            Return JSON: {doc_issues[], completeness_score}""",
            subagent_type="general-purpose"
        )
    },
    {
        "name": "Architecture Scanner",
        "task": Task(
            description="Review architecture",
            prompt="""Review architecture in $ARGUMENTS:
            - SOLID violations
            - Coupling issues
            - Layer violations
            - Circular dependencies
            Return JSON: {arch_issues[], needs_refactor[]}""",
            subagent_type="general-purpose"
        )
    }
]

# Execute all scanners in parallel
results = execute_parallel(scanners)
```

## Phase 2: Intelligent Expert Delegation

```python
def analyze_and_delegate(scan_results):
    """Determine which experts to consult based on findings"""
    
    delegations = []
    
    # Security expert for high-severity security issues
    security_issues = extract_security_issues(scan_results)
    if any(issue.severity == "high" for issue in security_issues):
        delegations.append({
            "expert": "@security-specialist",
            "prompt": f"""READ-ONLY SECURITY REVIEW
            
            Critical security issues found:
            {format_issues(security_issues)}
            
            Please provide:
            1. Severity assessment with CVSS scores
            2. Exploitation scenarios
            3. Specific remediation code
            4. Prevention strategies
            
            Focus on: {', '.join(critical_files)}"""
        })
    
    # Performance expert for significant performance issues
    perf_issues = extract_performance_issues(scan_results)
    if perf_issues.total_impact > PERF_THRESHOLD:
        delegations.append({
            "expert": "@performance-optimizer",
            "prompt": f"""READ-ONLY PERFORMANCE ANALYSIS
            
            Performance bottlenecks detected:
            {format_issues(perf_issues)}
            
            Please provide:
            1. Performance impact quantification
            2. Root cause analysis
            3. Optimization strategies with examples
            4. Benchmark expectations
            
            Critical paths: {', '.join(hot_paths)}"""
        })
    
    # Architecture expert for structural issues
    arch_issues = extract_architecture_issues(scan_results)
    if arch_issues.refactoring_needed:
        delegations.append({
            "expert": "@code-architect",
            "prompt": f"""READ-ONLY ARCHITECTURE REVIEW
            
            Architectural concerns:
            {format_issues(arch_issues)}
            
            Please provide:
            1. Impact on maintainability
            2. Refactoring approach
            3. Migration strategy
            4. Pattern recommendations
            
            Affected components: {', '.join(components)}"""
        })
    
    # Test expert if coverage is low
    test_metrics = extract_test_metrics(scan_results)
    if test_metrics.coverage < 70 or test_metrics.quality_score < 6:
        delegations.append({
            "expert": "@test-engineer",
            "prompt": f"""READ-ONLY TEST STRATEGY REVIEW
            
            Test quality issues:
            {format_issues(test_metrics)}
            
            Please provide:
            1. Coverage gap analysis
            2. Critical paths needing tests
            3. Test strategy recommendations
            4. Example test cases for complex logic
            
            Uncovered critical paths: {', '.join(uncovered)}"""
        })
    
    return delegations
```

## Phase 3: Synthesis and Reporting

```python
def synthesize_results(scan_results, expert_analyses):
    """Combine all findings into comprehensive report"""
    
    # Calculate overall scores
    scores = {
        "security": calculate_security_score(scan_results, expert_analyses),
        "performance": calculate_performance_score(scan_results, expert_analyses),
        "quality": calculate_quality_score(scan_results),
        "tests": calculate_test_score(scan_results),
        "architecture": calculate_architecture_score(scan_results, expert_analyses)
    }
    
    overall_score = sum(scores.values()) / len(scores)
    
    # Generate report sections
    report = f"""# Comprehensive Code Review Report

## Executive Summary

**Overall Score**: {overall_score:.1f}/10 {get_emoji(overall_score)}
**Review Type**: {"Pull Request" if args.pr_mode else "Full Codebase"}
**Analysis Duration**: {duration} seconds
**Experts Consulted**: {len(expert_analyses)}

### Scores by Category

| Category | Score | Status | Trend |
|----------|-------|--------|-------|
| Security | {scores['security']}/10 | {get_status(scores['security'])} | {get_trend()} |
| Performance | {scores['performance']}/10 | {get_status(scores['performance'])} | {get_trend()} |
| Code Quality | {scores['quality']}/10 | {get_status(scores['quality'])} | {get_trend()} |
| Test Coverage | {scores['tests']}/10 | {get_status(scores['tests'])} | {get_trend()} |
| Architecture | {scores['architecture']}/10 | {get_status(scores['architecture'])} | {get_trend()} |

## Critical Issues Requiring Immediate Attention

{format_critical_issues(scan_results, expert_analyses)}

## Detailed Findings

### 🔒 Security Analysis
{expert_analyses.get('security', scan_results['security'])}

### ⚡ Performance Analysis  
{expert_analyses.get('performance', scan_results['performance'])}

### 🏗️ Architecture Review
{expert_analyses.get('architecture', scan_results['architecture'])}

### 🧪 Test Coverage Analysis
{expert_analyses.get('tests', scan_results['tests'])}

### 📝 Code Quality Issues
{format_quality_issues(scan_results)}

## Action Plan

### Immediate (Before Merge)
{generate_immediate_actions(critical_issues)}

### Short-term (This Sprint)  
{generate_short_term_actions(major_issues)}

### Long-term (Technical Debt)
{generate_long_term_actions(arch_issues)}

## Metrics Comparison

{generate_metrics_comparison()}

---
Generated by Claude Code Toolkit - Comprehensive Review v2.3.0
"""
    
    return report
```

## Export Handling

```python
if args.export_report:
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")
    filename = f"review-{timestamp}.md"
    
    Write(
        file_path=f"reports/{filename}",
        content=report
    )
    
    # Also generate JSON metrics
    metrics = {
        "timestamp": timestamp,
        "scores": scores,
        "issues": {
            "critical": count_critical(scan_results),
            "major": count_major(scan_results),
            "minor": count_minor(scan_results)
        },
        "expert_consultations": len(expert_analyses)
    }
    
    Write(
        file_path=f"reports/review-{timestamp}.json",
        content=json.dumps(metrics, indent=2)
    )
    
    print(f"✅ Report exported to reports/{filename}")
```

## Performance Optimization

1. **Parallel Execution**: All scanners run simultaneously
2. **Smart Delegation**: Only consult experts when needed
3. **Cached Results**: Store intermediate results for debugging
4. **Progressive Loading**: Stream results as they complete

## Usage Examples

```bash
# Basic review
/prefix:review:comprehensive ./src

# PR mode with export
/prefix:review:comprehensive ./src --pr-mode --export-report

# Focus on specific directory
/prefix:review:comprehensive ./src/api --export-report
```
```

## Testing and Debugging Your Commands

### Testing Strategy

#### 1. Unit Testing (Individual Components)

Create a test harness for your command:

```bash
#!/bin/bash
# test-command.sh

# Test directory setup
TEST_DIR="/tmp/command-test-$$"
mkdir -p "$TEST_DIR"

# Create test files
cat > "$TEST_DIR/test.js" << 'EOF'
// Test file with known issues
function complexFunction(a, b, c, d, e, f) {  // Too many parameters
    if (a > 0) {
        if (b > 0) {
            if (c > 0) {
                if (d > 0) {  // Deep nesting
                    return e + f;
                }
            }
        }
    }
    return 0;
}

const magicNumber = 42;  // Magic number
const apiKey = "sk-1234567890";  // Hardcoded credential
EOF

# Run your command
echo "Testing command with known issues..."
/test:analysis:anti-patterns "$TEST_DIR"

# Cleanup
rm -rf "$TEST_DIR"
```

#### 2. Integration Testing

Test with real-world scenarios:

```markdown
## Test Cases

### Test Case 1: Empty Directory
- Expected: Graceful handling, clear message
- Command: `/prefix:your:command /empty/dir`

### Test Case 2: Large Codebase
- Expected: Complete within timeout, handle scale
- Command: `/prefix:your:command /large/project`

### Test Case 3: Mixed Languages
- Expected: Detect and handle multiple languages
- Command: `/prefix:your:command /polyglot/project`

### Test Case 4: No Permissions
- Expected: Clear error message, graceful failure
- Command: `/prefix:your:command /restricted/dir`

### Test Case 5: With All Options
- Expected: All features work together
- Command: `/prefix:your:command /project --option1 --option2 --export`
```

#### 3. Debugging Techniques

Add debug output to your commands:

```markdown
## Debug Mode

When `--debug` flag is present:

```python
if "--debug" in args:
    print("🔍 DEBUG: Starting Phase 1")
    print(f"🔍 DEBUG: Found {len(scanners)} scanners")
    
    for i, result in enumerate(results):
        print(f"🔍 DEBUG: Scanner {i} returned: {len(result)} items")
        print(f"🔍 DEBUG: Sample: {json.dumps(result[:2], indent=2)}")
```
```

### Common Issues and Solutions

#### Issue 1: Command Not Found

```bash
# Check installation
ls ~/.claude/commands/yourprefix/

# Verify command structure
head -20 ~/.claude/commands/yourprefix/category/command.md

# Test frontmatter
grep -A3 "^---" ~/.claude/commands/yourprefix/category/command.md
```

#### Issue 2: Tool Not Allowed

```markdown
Error: Tool 'Write' not in allowed-tools
Solution: Add to frontmatter:
---
allowed-tools: Task, Read, Grep, Bash, Write
---
```

#### Issue 3: Parallel Tasks Not Running

```markdown
# Ensure proper Task Tool syntax
Task(
    description="Clear description",  # Required
    prompt="Detailed prompt",         # Required
    subagent_type="general-purpose"   # Required
)
```

#### Issue 4: Output Formatting Issues

```python
# Always stringify JSON before including in prompts
prompt = f"Analyze this data: {json.dumps(data)}"

# Format markdown carefully
report = f"""# Title

## Section
{content}
"""  # No extra indentation
```

### Performance Profiling

Add timing to identify bottlenecks:

```python
import time

phase_times = {}

# Phase 1
start = time.time()
scan_results = run_scanners()
phase_times['scanning'] = time.time() - start

# Phase 2
start = time.time()
expert_results = run_experts()
phase_times['experts'] = time.time() - start

# Report timing
print(f"""
Performance Breakdown:
- Scanning: {phase_times['scanning']:.1f}s
- Expert Analysis: {phase_times['experts']:.1f}s
- Total: {sum(phase_times.values()):.1f}s
""")
```

## Best Practices and Common Pitfalls

### Best Practices

#### 1. Clear and Specific Prompts

```python
# ❌ Bad: Vague prompt
Task(prompt="Check for issues")

# ✅ Good: Specific and structured
Task(prompt="""Scan $ARGUMENTS for security vulnerabilities:
1. SQL injection (look for string concatenation in queries)
2. XSS risks (unescaped user input in HTML)
3. Path traversal (.. in file operations)

Return JSON: {
  "file": "path/to/file",
  "line": 123,
  "type": "sql_injection",
  "severity": "high",
  "code_snippet": "query = 'SELECT * FROM users WHERE id=' + userId"
}""")
```

#### 2. Robust Error Handling

```python
# Handle missing arguments
target = args or "."
if not os.path.exists(target):
    print(f"❌ Error: Directory '{target}' not found")
    return

# Handle tool failures
try:
    results = run_analysis()
except Exception as e:
    print(f"⚠️ Analysis failed: {str(e)}")
    print("Falling back to basic scan...")
    results = run_basic_scan()
```

#### 3. Meaningful Output Structure

```markdown
# ✅ Good: Structured and actionable
## Critical Security Issues (Fix Immediately)

1. **SQL Injection** in `api/users.js:45`
   ```javascript
   query = `SELECT * FROM users WHERE id=${userId}`
   ```
   **Fix**: Use parameterized queries
   ```javascript
   query = 'SELECT * FROM users WHERE id = ?'
   db.query(query, [userId])
   ```

# ❌ Bad: Unstructured dump
Found issues:
- SQL problem in users.js
- Some performance issues
- Tests could be better
```

#### 4. Progressive Enhancement

```python
# Start with basic functionality
results = basic_analysis()

# Enhance if tools available
if has_tool("mcp__semgrep__security_check"):
    results = enhance_with_semgrep(results)
    results["quality"] = "enhanced"
else:
    results["quality"] = "basic"
    results["upgrade_tip"] = "Install Semgrep MCP for deeper analysis"
```

#### 5. Respect User Intent

```python
# Parse user options
focus = extract_option(args, "--focus", default="all")
export = "--export" in args
verbose = "--verbose" in args

# Adapt behavior
if focus != "all":
    scanners = filter_scanners(scanners, focus)
    print(f"🎯 Focusing on {focus} analysis")

if verbose:
    print("📊 Verbose mode enabled")
    # Add detailed logging
```

### Common Pitfalls to Avoid

#### 1. Overloading Single Agents

```python
# ❌ Bad: One agent doing everything
Task(prompt="Analyze security, performance, tests, docs, and architecture")

# ✅ Good: Specialized agents
security_agent = Task(prompt="Focus only on security vulnerabilities")
perf_agent = Task(prompt="Focus only on performance issues")
```

#### 2. Creating Files Without Permission

```python
# ❌ Bad: Always creating files
Write(file_path="report.md", content=report)

# ✅ Good: Only when requested
if "--export" in args:
    Write(file_path="report.md", content=report)
    print("✅ Report exported to report.md")
else:
    print(report)  # Display to user
```

#### 3. Ignoring Edge Cases

```python
# ❌ Bad: Assuming happy path
files = Grep(pattern="class", path=target).split('\n')

# ✅ Good: Handle edge cases
grep_result = Grep(pattern="class", path=target)
if not grep_result:
    print("No classes found")
    return

files = [f for f in grep_result.split('\n') if f.strip()]
```

#### 4. Poor JSON Handling in Prompts

```python
# ❌ Bad: Direct object interpolation
Task(prompt=f"Analyze {data}")  # May break with quotes

# ✅ Good: Proper JSON serialization
Task(prompt=f"Analyze this data: {json.dumps(data)}")
```

#### 5. Blocking on Slow Operations

```python
# ❌ Bad: Sequential expert consultation
for expert in experts:
    result = consult_expert(expert)  # Blocks on each

# ✅ Good: Parallel execution
with ThreadPoolExecutor(max_workers=len(experts)) as executor:
    futures = [executor.submit(consult_expert, exp) for exp in experts]
    results = [f.result() for f in as_completed(futures)]
```

## Publishing and Sharing Commands

### Preparing for Publication

#### 1. Documentation

Ensure your command has:

```markdown
---
description: Clear, concise description
argument-hint: [required] [--optional]
author: Your Name
version: 1.0.0
---

# Command Name

## Overview
What this command does and why it's useful.

## Installation
```bash
./install.sh yourprefix
```

## Usage Examples
```bash
# Basic usage
/yourprefix:category:command target

# With options
/yourprefix:category:command target --option value
```

## Requirements
- Required tools or dependencies
- Minimum Claude Code version

## Changelog
- v1.0.0: Initial release
```

#### 2. Testing Checklist

- [ ] Command loads without errors
- [ ] Handles missing arguments gracefully  
- [ ] Works with minimal permissions
- [ ] Completes within reasonable time
- [ ] Produces helpful output
- [ ] Follows naming conventions
- [ ] Includes usage examples

#### 3. Quality Standards

```python
# Code quality checks
def validate_command(cmd_path):
    """Validate command meets quality standards"""
    
    with open(cmd_path) as f:
        content = f.read()
    
    # Check frontmatter
    assert "---" in content, "Missing frontmatter"
    assert "description:" in content, "Missing description"
    
    # Check documentation
    assert "## Usage" in content, "Missing usage section"
    assert "```" in content, "Missing code examples"
    
    # Check for common issues
    assert "TODO" not in content, "Contains TODO items"
    assert len(content) > 500, "Too short - add more detail"
    
    print("✅ Command passes quality checks")
```

### Distribution Methods

#### 1. GitHub Repository

Structure your commands repository:

```
your-commands/
├── README.md
├── LICENSE
├── install.sh
├── commands/
│   ├── category1/
│   │   ├── command1.md
│   │   └── command2.md
│   └── category2/
│       └── command3.md
├── agents/
│   └── your-specialist.md
├── examples/
│   ├── example1.md
│   └── example2.md
└── tests/
    └── test-commands.sh
```

#### 2. Installation Script

Create a simple installer:

```bash
#!/bin/bash
# install.sh

PREFIX="${1:-yourprefix}"
CLAUDE_DIR="$HOME/.claude"
CMD_DIR="$CLAUDE_DIR/commands/$PREFIX"

echo "Installing commands with prefix: $PREFIX"

# Create directory
mkdir -p "$CMD_DIR"

# Copy commands
cp -r commands/* "$CMD_DIR/"

echo "✅ Installed $(find commands -name "*.md" | wc -l) commands"
echo ""
echo "Usage: /prefix:category:command"
```

#### 3. Package Documentation

Create a comprehensive README:

```markdown
# Your Command Collection

A collection of powerful commands for Claude Code Toolkit.

## Features

- 🚀 Fast parallel analysis
- 🔒 Security scanning
- 📊 Performance profiling
- 🏗️ Architecture review

## Installation

```bash
git clone https://github.com/you/your-commands
cd your-commands
./install.sh yourprefix
```

## Commands

| Command | Description |
|---------|-------------|
| `/yourprefix:analysis:deep` | Comprehensive code analysis |
| `/yourprefix:review:security` | Security-focused review |

## Examples

[Include real-world usage examples]

## Contributing

[Contribution guidelines]

## License

MIT
```

### Sharing Best Practices

#### 1. Version Your Commands

```yaml
---
description: Your command description
version: 1.2.0
changelog: |
  - 1.2.0: Added MCP support
  - 1.1.0: Improved performance  
  - 1.0.0: Initial release
---
```

#### 2. Provide Migration Guides

```markdown
## Upgrading from v1.x to v2.x

### Breaking Changes
- Changed `--output` to `--export`
- Removed deprecated `--legacy` flag

### Migration Steps
1. Update your scripts to use `--export`
2. Remove any `--legacy` flags
```

#### 3. Create Command Bundles

```markdown
## Security Bundle

Related commands for security analysis:

- `/prefix:security:scan` - Quick security scan
- `/prefix:security:audit` - Deep security audit  
- `/prefix:security:fix` - Apply security fixes
- `/prefix:security:monitor` - Continuous monitoring

Install all: `./install.sh prefix-security`
```

#### 4. Community Engagement

- Create example use cases
- Share success stories
- Provide troubleshooting guides
- Respond to user feedback
- Accept contributions

## Summary

You've learned how to:

1. **Understand** Claude Code command structure and components
2. **Choose** the right template for your use case
3. **Build** simple analysis commands with parallel processing
4. **Create** MCP-enhanced commands with graceful fallbacks
5. **Develop** complex hybrid commands with multiple phases
6. **Test** and debug your commands effectively
7. **Apply** best practices and avoid common pitfalls
8. **Publish** and share your commands with the community

### Next Steps

1. Start with a simple command using `basic-sub-agent.md`
2. Add MCP enhancement for better functionality
3. Build a hybrid command for complex scenarios
4. Share your commands with the community
5. Contribute improvements back to the toolkit

Remember: The best commands are those that solve real problems. Start with your own workflow pain points and build commands that make your development life easier.

Happy command building!