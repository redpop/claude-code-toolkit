---
description: Smart toolkit management with health monitoring, help system, and command assistance
argument-hint: [type] [target] [--help]
allowed-tools: Task, Read, Grep, Write
---

# Toolkit - Smart Toolkit Management

Intelligent toolkit command that automatically manages project health, provides help, and assists with command discovery. Zero configuration, maximum productivity insights.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Toolkit Operations

**Automatically monitors project health and provides intelligent assistance with comprehensive reporting.**

### Available Toolkit Operations

- `health` - Comprehensive project health assessment (default)
- `help` - Interactive help system and command assistance
- `version` - Version information and update checking
- `analyze` - Toolkit usage analysis and optimization
- `create` - Create new commands and extensions
- `guide` - Interactive testing and workflow guidance
- `find` - Command discovery by capability and description

## Usage

```bash
# Smart defaults - comprehensive project health check
/prefix:toolkit

# Specific toolkit operations
/prefix:toolkit health              # Project health assessment
/prefix:toolkit help command-name   # Get help for specific command
/prefix:toolkit version             # Version and update info
/prefix:toolkit analyze usage       # Toolkit usage analysis

# Interactive assistance
/prefix:toolkit find "security audit"    # Find security-related commands
/prefix:toolkit guide testing           # Interactive testing guidance
/prefix:toolkit create new-command      # Create new command
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine toolkit operation and target**

```bash
# Parse arguments
args=($ARGUMENTS)
toolkit_operation="health"    # default to health check
target_or_query="${args[*]}"

# Check for operation type
toolkit_operations=("health" "help" "version" "analyze" "create" "guide" "find")
if [[ " ${toolkit_operations[@]} " =~ " ${args[0]} " ]]; then
    toolkit_operation=${args[0]}
    target_or_query="${args[@]:1}"
fi
```

**Step 2: Execute appropriate toolkit operation**

Based on toolkit_operation, execute optimal strategy:

### Project Health Assessment (Default)

**Process**: Comprehensive project health analysis across multiple dimensions
**Export**: Auto-generates `toolkit-health-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="general-purpose":
"PROJECT HEALTH ASSESSMENT: Comprehensive health analysis of current project. Evaluate multiple dimensions: 1) **Development Health** (code quality, architecture, technical debt), 2) **Testing Health** (coverage, CI/CD, bug rates), 3) **Documentation Health** (README, API docs, comments), 4) **Security Health** (vulnerabilities, dependencies, practices), 5) **Performance Health** (metrics, bottlenecks, optimization), 6) **Maintenance Health** (dependencies, updates, sustainability). Generate health score, trend analysis, and actionable improvement roadmap with priorities."

### Interactive Help System

**Process**: Intelligent help and command assistance
**Output**: Contextual help and command recommendations

Use Task tool with subagent_type="general-purpose":
"INTERACTIVE HELP SYSTEM: Provide intelligent help for '$target_or_query'. Process: 1) If specific command requested, provide detailed help for that command, 2) If topic/capability requested, find and recommend relevant commands, 3) If no specific request, provide overview of toolkit capabilities, 4) Include usage examples and common workflows, 5) Suggest next steps and related commands. Make help contextual and actionable."

### Version Information and Updates

**Process**: Version checking and update recommendations
**Output**: Current version info and update guidance

**Implementation:**

```bash
# Check toolkit version
if [[ -f ~/.claude/claude-code-toolkit/.version ]]; then
    current_version=$(cat ~/.claude/claude-code-toolkit/.version)
    echo "Claude Code Toolkit Version: $current_version"
else
    echo "Version information not found - may need reinstallation"
fi

# Check for updates (if applicable)
# Provide update instructions and changelog highlights
```

### Toolkit Usage Analysis

**Process**: Analysis of toolkit command usage patterns and optimization
**Export**: Auto-generates `toolkit-analyze-YYYYMMDD-HHMMSS.json` usage report

Use Task tool with subagent_type="general-purpose":
"TOOLKIT USAGE ANALYSIS: Analyze toolkit usage patterns and optimization opportunities. Examine: 1) Command usage frequency and patterns, 2) Workflow effectiveness and efficiency, 3) Underutilized features and capabilities, 4) Command chaining and automation opportunities, 5) Performance metrics and bottlenecks, 6) User productivity insights. Generate usage optimization recommendations with workflow improvements and training suggestions."

### Command Creation Assistant

**Process**: Guided creation of new commands and extensions
**Output**: Generated command template and integration guidance

Use Task tool with subagent_type="general-purpose":
"COMMAND CREATION ASSISTANT: Guide creation of new command '$target_or_query'. Process: 1) Understand command purpose and functionality, 2) Analyze similar existing commands for patterns, 3) Generate command template with proper frontmatter, 4) Create documentation and examples, 5) Provide integration guidance and testing instructions. Follow toolkit conventions: proper frontmatter, argument-hint format, help system integration, tool permissions."

### Interactive Testing and Workflow Guidance

**Process**: Step-by-step guidance for testing and workflow setup
**Output**: Interactive guidance and setup instructions

Use Task tool with subagent_type="test-engineer":
"INTERACTIVE TESTING GUIDANCE: Provide testing guidance for '$target_or_query'. Process: 1) Assess current testing setup and coverage, 2) Identify testing gaps and opportunities, 3) Recommend testing strategies and tools, 4) Provide step-by-step implementation guidance, 5) Create testing workflow and automation. Include: unit testing, integration testing, CI/CD setup, quality gates, performance testing."

### Command Discovery by Capability

**Process**: Intelligent command finding based on capabilities and descriptions
**Output**: Relevant command recommendations with usage examples

Use Task tool with subagent_type="general-purpose":
"COMMAND DISCOVERY: Find commands matching '$target_or_query' capabilities. Process: 1) Search command descriptions and capabilities, 2) Match intent with available functionality, 3) Rank results by relevance and usefulness, 4) Provide usage examples for top matches, 5) Suggest workflow combinations and next steps. Include: primary matches, related commands, workflow suggestions, learning resources."

## Health Assessment Framework

### Development Health Metrics

- **Code Quality Score**: Complexity, maintainability, best practices
- **Architecture Soundness**: Design patterns, coupling, cohesion
- **Technical Debt Level**: Code smells, refactoring opportunities
- **Dependency Health**: Outdated packages, security vulnerabilities

### Testing Health Metrics

- **Test Coverage**: Unit, integration, end-to-end coverage
- **Test Quality**: Test effectiveness, maintainability
- **CI/CD Health**: Pipeline success rates, deployment frequency
- **Bug Discovery Rate**: Defect trends and resolution time

### Documentation Health Metrics

- **README Completeness**: Installation, usage, contribution guides
- **API Documentation**: Coverage, accuracy, examples
- **Code Comments**: Coverage, quality, maintainability
- **Knowledge Base**: Team knowledge sharing and documentation

### Security Health Metrics

- **Vulnerability Status**: Known security issues and fixes
- **Dependency Safety**: Vulnerable dependencies and updates
- **Security Practices**: Authentication, authorization, encryption
- **Compliance Status**: Security standards and regulations

### Performance Health Metrics

- **Performance Metrics**: Load times, throughput, resource usage
- **Bottleneck Identification**: Performance constraints and limits
- **Optimization Opportunities**: Caching, algorithms, resources
- **Monitoring Coverage**: Performance tracking and alerting

## Health Scoring System

### Overall Health Score (0-100)

- **Excellent (90-100)**: All dimensions healthy, minimal issues
- **Good (75-89)**: Minor issues, regular maintenance needed
- **Fair (50-74)**: Moderate issues, focused improvement required
- **Poor (25-49)**: Major issues, significant work needed
- **Critical (0-24)**: Severe problems, immediate attention required

### Dimension Weights

- Development Health: 25%
- Security Health: 25%
- Testing Health: 20%
- Documentation Health: 15%
- Performance Health: 15%

## Next Steps Recommendations

After toolkit operation completion, display context-aware recommendations:

```markdown
✅ [Toolkit Operation] completed successfully

📊 **Health Score**: [Overall score and dimension breakdown]
🎯 **Priority Actions**: [Top 3 recommended improvements]
📈 **Trend**: [Health trend compared to previous assessments]

💡 **Recommended next steps:**
   /prefix:fix quick            # Apply quick health improvements
   /prefix:secure audit         # Address security concerns
   /prefix:analyze quality      # Deep dive into quality issues

   **Or describe your goal:** "I want to improve test coverage"
```

### Smart Next-Step Logic

Based on toolkit operation results:

- **Health issues identified** → Suggest specific fixes and improvements
- **Help provided** → Suggest trying recommended commands
- **Commands created** → Suggest testing and integration steps
- **Usage analysis completed** → Suggest workflow optimizations
- **Version outdated** → Suggest update procedures and migration

## Command Integration

### Help System Integration

All toolkit commands integrate with the help system:

- **Context-Aware Help**: Understands current project and situation
- **Example Generation**: Provides relevant usage examples
- **Workflow Suggestions**: Recommends command sequences and patterns

### Health Monitoring Integration

- **Trend Tracking**: Compares health metrics over time
- **Alert System**: Identifies degrading health dimensions
- **Improvement Tracking**: Measures progress on health initiatives

### Command Discovery Integration

- **Capability Mapping**: Understands what each command can do
- **Intent Matching**: Finds commands based on user goals
- **Workflow Building**: Suggests command combinations for complex tasks

## Benefits

- **Holistic Health Monitoring**: Comprehensive project health assessment across all dimensions
- **Intelligent Help System**: Context-aware assistance and command discovery
- **Usage Optimization**: Identifies opportunities to improve toolkit utilization
- **Command Creation Support**: Guided creation of custom commands and extensions
- **Trend Analysis**: Tracks project health and improvement over time
- **One Interface**: Replaces multiple meta-management commands

*Consolidates: meta:health, meta:help, meta:help-handler, meta:version, meta:analyze-toolkit, meta:create, meta:test-guide, meta:find-cmd*
