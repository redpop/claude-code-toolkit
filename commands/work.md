---
description: Smart workflow coordination with intelligent problem routing and expert orchestration
argument-hint: [type] [target] [--help]
allowed-tools: Task, Read, Write
---

# Work - Smart Workflow Coordination

Intelligent workflow command that automatically routes problems to the right experts and coordinates multi-agent solutions. Zero configuration, maximum expertise.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Workflow Types

**Automatically coordinates specialized agents and exports results with timestamped reports.**

### Available Workflow Types

- `smart` - Intelligent problem routing to appropriate specialists (default)
- `review` - Multi-perspective code review with expert analysis
- `refactor` - Intelligent refactoring with impact analysis and safety
- `incident` - Rapid incident response for production issues
- `debug` - Intensive debugging mode for complex problems
- `fix` - Problem resolution with expert coordination
- `assess` - Comprehensive assessment with multiple perspectives
- `plan` - Strategic planning with architectural guidance
- `optimize` - Performance and quality optimization workflow

## Usage

```bash
# Smart defaults - intelligent problem routing
/prefix:work "Authentication failing after user login"

# Specific workflow types
/prefix:work smart "API performance issues"     # Auto-route to performance experts
/prefix:work review src/auth/                   # Multi-expert code review
/prefix:work refactor legacy-parser.js         # Safe refactoring with impact analysis
/prefix:work incident "Database connection lost" # Rapid incident response

# Specialized workflows
/prefix:work debug --verbose                    # Intensive debugging mode
/prefix:work optimize backend/                  # Performance optimization
/prefix:work plan "Microservices migration"    # Strategic planning
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine workflow type and target**

```bash
# Parse arguments
args=($ARGUMENTS)
workflow_type="smart"    # default to intelligent routing
target_or_description="${args[*]}"

# Check if first arg is a workflow type
workflow_types=("smart" "review" "refactor" "incident" "debug" "fix" "assess" "plan" "optimize")
if [[ " ${workflow_types[@]} " =~ " ${args[0]} " ]]; then
    workflow_type=${args[0]}
    target_or_description="${args[@]:1}"
fi
```

**Step 2: Route to appropriate workflow strategy**

Based on workflow_type, execute the optimal approach:

### Smart Problem Routing (Default)

**Target**: Intelligent analysis and routing of `$target_or_description`
**Export**: Auto-generates `work-smart-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="general-purpose":
"INTELLIGENT PROBLEM ROUTING: Analyze the problem '$target_or_description' and determine the most appropriate specialized agents. Categories: Code/Bugs (debugging-specialist), Performance (performance-optimizer), Security (security-specialist), Architecture (code-architect), Testing (test-engineer), Documentation (documentation-health-specialist). Route to 1-3 most relevant agents with context-aware prompts. Coordinate their work and synthesize solutions."

### Multi-Expert Code Review

**Target**: Comprehensive review of `$target_or_description`
**Export**: Auto-generates `work-review-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="code-architect":
"Coordinate comprehensive code review of '$target_or_description' using multiple specialized perspectives. Execute parallel analysis: code quality (design patterns, SOLID principles, complexity), security review (vulnerabilities, authentication, input validation), architecture assessment (coupling, scalability, API design), performance analysis (bottlenecks, algorithms, memory usage). Synthesize findings with prioritized recommendations and consensus opinion."

### Intelligent Refactoring Workflow

**Target**: Safe refactoring analysis for `$target_or_description`
**Export**: Auto-generates `work-refactor-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="refactoring-expert":
"Execute intelligent refactoring workflow for '$target_or_description'. Phase 1: Analyze code structure and identify refactoring opportunities (code smells, duplication, coupling issues). Phase 2: Assess impact radius (dependencies, tests, external contracts). Phase 3: Generate step-by-step refactoring plan with safety levels (conservative/balanced/aggressive) and risk assessment. Provide ROI-prioritized recommendations."

### Rapid Incident Response

**Target**: Production incident handling for `$target_or_description`
**Export**: Auto-generates `work-incident-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="debugging-specialist":
"INCIDENT RESPONSE MODE: Handle production incident '$target_or_description'. Phase 1: Immediate assessment (severity classification, impact analysis, initial diagnostics). Phase 2: Root cause analysis (system diagnostics, code analysis, infrastructure review). Phase 3: Mitigation strategy (immediate fixes, rollback options, monitoring). Phase 4: Resolution plan with audit trail. Coordinate multiple agents for rapid response."

### Intensive Debugging Mode

**Target**: Deep debugging analysis for `$target_or_description`
**Export**: Auto-generates `work-debug-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="debugging-specialist":
"INTENSIVE DEBUG MODE ACTIVATED: Ultra-intensive reasoning for '$target_or_description'. Analyze current context, error patterns, implementation state, and failed approaches. Apply systematic debugging: reproduce issue, isolate components, trace execution paths, analyze data flows, test hypotheses. Use advanced debugging techniques: binary search isolation, state inspection, dependency analysis. Provide detailed diagnosis with actionable solutions."

### Problem Resolution Workflow

**Target**: Comprehensive problem solving for `$target_or_description`
**Export**: Auto-generates `work-fix-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="general-purpose":
"Execute comprehensive problem resolution for '$target_or_description'. Analyze problem domain and route to appropriate specialists. Coordinate solution development: initial diagnosis, solution options analysis, implementation planning, risk assessment, testing strategy. Provide complete resolution plan with step-by-step guidance and fallback options."

### Comprehensive Assessment

**Target**: Multi-dimensional assessment of `$target_or_description`
**Export**: Auto-generates `work-assess-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="code-architect":
"Perform comprehensive assessment of '$target_or_description' using multiple expert perspectives. Evaluate: technical quality (code, architecture, performance), security posture, maintainability, scalability, documentation health, test coverage, operational readiness. Coordinate parallel analysis by relevant specialists. Provide scored assessment with improvement roadmap and strategic recommendations."

### Strategic Planning

**Target**: Strategic guidance for `$target_or_description`
**Export**: Auto-generates `work-plan-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="code-architect":
"Provide strategic planning for '$target_or_description'. Analyze current state, define objectives, identify constraints and dependencies, evaluate solution approaches, assess risks and mitigation strategies. Create phased implementation plan with milestones, resource requirements, and success metrics. Include architectural guidance and technical decision recommendations."

### Optimization Workflow

**Target**: Performance and quality optimization for `$target_or_description`
**Export**: Auto-generates `work-optimize-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="performance-optimizer":
"Execute optimization workflow for '$target_or_description'. Analyze current performance metrics, identify bottlenecks and inefficiencies, evaluate optimization opportunities (algorithms, caching, resource usage, architecture). Coordinate with quality specialists for code improvements. Provide optimization roadmap with impact estimates, implementation complexity, and monitoring recommendations."

## Next Steps Recommendations

After workflow completion, display context-aware recommendations:

```markdown
✅ [Workflow Type] completed successfully

📋 **Expert Analysis**: [Summary of specialist findings]
🎯 **Key Recommendations**: [Top 3 actionable items]
⚠️  **Critical Issues**: [Any urgent items requiring attention]

💡 **Recommended next steps:**
   /prefix:fix [relevant-type]      # Apply recommended fixes
   /prefix:analyze [follow-up]      # Verify improvements
   /prefix:work [next-workflow]     # Continue with related workflow

   **Or describe your next goal:** "I need to implement the recommended changes"
```

### Smart Next-Step Logic

Based on workflow results, suggest most relevant follow-up actions:

- **Smart routing completed** → Suggest specific fixes based on identified issues
- **Code review completed** → Suggest `/prefix:work refactor` or `/prefix:fix quality`
- **Refactoring plan created** → Suggest `/prefix:work debug` for validation or implementation
- **Incident resolved** → Suggest `/prefix:analyze security` or monitoring setup
- **Debugging completed** → Suggest `/prefix:fix quick` or `/prefix:work review`
- **Assessment completed** → Suggest `/prefix:work plan` or priority fixes

## Agent Coordination Patterns

### Sequential Coordination

For complex problems requiring step-by-step analysis:

1. Initial analysis agent
2. Specialized deep-dive agent  
3. Solution synthesis agent

### Parallel Coordination

For comprehensive reviews requiring multiple perspectives:

1. Launch multiple specialists simultaneously
2. Collect diverse expert opinions
3. Synthesize consensus recommendations

### Iterative Coordination

For problems requiring refinement:

1. Initial solution attempt
2. Validation and feedback
3. Refinement and re-evaluation

## Benefits

- **Expert Orchestration**: Automatically coordinates the right specialists for each problem
- **Intelligent Routing**: Analyzes problems and selects optimal workflow strategies
- **Multi-Perspective Analysis**: Combines insights from different expert domains
- **Comprehensive Solutions**: Addresses problems holistically rather than in isolation
- **Safety-First Approach**: Includes risk assessment and impact analysis
- **One Interface**: Replaces 5 specialized workflow commands with unified approach

*Consolidates: flow:smart, flow:review, flow:refactor, flow:incident, flow:debug-mode*
