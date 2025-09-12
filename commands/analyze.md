---
description: Intelligent code analysis with smart routing and automatic exports
argument-hint: [type] [target] [--help]
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Write
---

# Analyze - Intelligent Code Analysis

Smart analysis command that automatically routes to the best approach based on your needs. Zero configuration, maximum insight.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Analysis Types

**Automatically exports results in both JSON and Markdown formats with timestamped filenames.**

### Available Analysis Types

- `full` - Comprehensive analysis (default if no type specified)
- `quick` - Fast analysis for immediate feedback (30 seconds)
- `security` - Security-focused analysis with OWASP checks
- `performance` - Performance bottlenecks and optimization
- `quality` - Code quality metrics and trends
- `architecture` - Structure and design analysis
- `dependencies` - Dependency risks and licenses
- `tests` - Test coverage and quality assessment
- `docs` - Documentation health and completeness
- `refactor` - Refactoring opportunities identification
- `problem` - Deep root cause analysis for specific issues
- `structure` - Codebase mapping and exploration

## Usage

```bash
# Smart defaults - comprehensive analysis of current directory
/prefix:analyze

# Specific analysis types
/prefix:analyze quick          # Fast 30-second check
/prefix:analyze security       # Security audit
/prefix:analyze performance    # Performance analysis
/prefix:analyze quality        # Code quality metrics

# With custom target
/prefix:analyze security src/  # Security analysis of src/ directory
/prefix:analyze quick backend/ # Quick analysis of backend code
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine analysis type and target**

```bash
# Parse arguments
args=($ARGUMENTS)
analysis_type="full"  # default
target="."           # default to current directory

# Extract type if provided
if [[ ${#args[@]} -gt 0 ]] && [[ ${args[0]} != *"/"* ]]; then
    analysis_type=${args[0]}
    target=${args[1]:-"."}
else
    target=${args[0]:-"."}
fi
```

**Step 2: Route to appropriate analysis approach**

Based on analysis_type, execute the optimal strategy:

### Full Analysis (Default)

**Target**: Comprehensive analysis of `$target`
**Export**: Auto-generates `analysis-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="general-purpose":
"Perform comprehensive code analysis of '$target' using hybrid approach with simplified output. Include parallel scanning phase with security, performance, complexity, architecture, and quality agents. Follow up with expert analysis for critical findings. Export results in both JSON (for automation) and Markdown (for humans) with health scoring and actionable recommendations."

### Quick Analysis  

**Target**: Fast feedback for `$target`
**Export**: Auto-generates `quick-analysis-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="general-purpose":
"Perform rapid parallel code analysis of '$target' using 10 specialized agents simultaneously. Focus on immediate actionable issues, code smells, and quick wins. Expected completion: 30 seconds. Export results in both JSON and Markdown formats with prioritized findings."

### Security Analysis

**Target**: Security audit of `$target`  
**Export**: Auto-generates `security-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="security-specialist":
"Perform comprehensive security analysis of '$target' focusing on OWASP Top 10, authentication issues, data validation, encryption, and vulnerability patterns. Include both static analysis and configuration review. Export detailed security report with severity ratings and remediation guidance."

### Performance Analysis

**Target**: Performance profiling of `$target`
**Export**: Auto-generates `performance-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="performance-optimizer":
"Analyze '$target' for performance bottlenecks including algorithm complexity, memory usage, database queries, caching opportunities, and resource optimization. Identify hot paths and provide specific optimization recommendations with estimated impact."

### Quality Analysis

**Target**: Code quality assessment of `$target`
**Export**: Auto-generates `quality-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="code-architect":
"Assess code quality of '$target' including metrics, maintainability, technical debt, design patterns, SOLID principles, and best practices adherence. Provide quality scoring and improvement roadmap with prioritized actions."

### Architecture Analysis  

**Target**: Design and structure analysis of `$target`
**Export**: Auto-generates `architecture-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="code-architect":
"Analyze architectural design of '$target' including module structure, coupling, cohesion, design patterns, dependency organization, and scalability considerations. Create architectural assessment with improvement recommendations."

### Dependencies Analysis

**Target**: Dependency audit of `$target`
**Export**: Auto-generates `dependencies-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="security-specialist":
"Perform in-depth dependency analysis of '$target' covering security vulnerabilities, license compliance, outdated packages, transitive dependencies, and supply chain risks. Include upgrade recommendations and risk assessment."

### Tests Analysis

**Target**: Test quality assessment of `$target`  
**Export**: Auto-generates `tests-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="test-engineer":
"Analyze test coverage and quality of '$target' including coverage metrics, test pyramid adherence, edge case handling, mock usage, and test maintainability. Provide comprehensive testing assessment with improvement recommendations."

### Documentation Analysis

**Target**: Documentation health check of `$target`
**Export**: Auto-generates `docs-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="general-purpose":
"Evaluate documentation quality of '$target' including README completeness, API documentation, code comments, cross-references, outdated content, and documentation-code synchronization. Provide documentation health report with improvement priorities."

### Refactor Analysis

**Target**: Refactoring opportunities in `$target`
**Export**: Auto-generates `refactor-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="refactoring-expert":
"Identify refactoring opportunities in '$target' including code duplication, long methods, god classes, feature envy, and other code smells. Provide refactoring recommendations with impact analysis and step-by-step guidance."

### Problem Analysis

**Target**: Deep root cause analysis of issue in `$target`
**Export**: Auto-generates `problem-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="debugging-specialist":
"Perform deep root cause analysis for problems in '$target'. Use intensive reasoning to trace issues across systems, analyze patterns, and identify underlying causes. Provide detailed investigation report with actionable solutions."

### Structure Analysis  

**Target**: Codebase exploration and mapping of `$target`
**Export**: Auto-generates `structure-analysis-YYYYMMDD-HHMMSS.json`

Use Task tool with subagent_type="general-purpose":
"Create comprehensive codebase mapping of '$target' including directory structure, module organization, key components, data flow, and architectural overview. Generate detailed structure documentation and navigation guide."

## Next Steps Recommendations

After analysis completion, display context-aware recommendations:

```markdown
✅ [Analysis Type] analysis completed

📁 Results exported to: [filename]

💡 **Recommended next steps:**
   /prefix:fix [relevant-type]     # Apply fixes for found issues
   /prefix:work smart             # Route problems to specialists  
   /prefix:secure audit           # Deep security review (if security issues found)

   **Or describe your goal:** "I need to improve test coverage"
```

### Smart Next-Step Logic

Based on analysis results, suggest most relevant follow-up actions:

- **Critical security issues found** → Suggest `/prefix:fix security` and `/prefix:secure audit`
- **Performance issues detected** → Suggest `/prefix:fix performance` and `/prefix:analyze performance`
- **Low test coverage** → Suggest `/prefix:make tests` and `/prefix:analyze tests`
- **Code quality issues** → Suggest `/prefix:fix quick` and `/prefix:work refactor`
- **Documentation gaps** → Suggest `/prefix:make docs` and `/prefix:fix docs`

## Benefits

- **Zero Configuration**: Just specify what you want to analyze
- **Smart Routing**: Automatically uses the best analysis approach
- **Dual Export**: All results saved in both JSON (automation) and Markdown (human-readable) formats
- **Expert Analysis**: Routes to specialized agents for deep insights  
- **Clear Next Steps**: Always know what to do after analysis
- **Consolidated Interface**: One command replaces 12 specialized commands

*Consolidates: scan:deep, scan:quick, scan:security, scan:perf, scan:deps, scan:tests, scan:docs, scan:quality, scan:refactor, scan:root-cause, scan:explore, scan:map*
