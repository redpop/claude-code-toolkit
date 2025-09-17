# PRP Methodology - Project Requirements Proposal

**PRP (Project Requirements Proposal)** is a blueprint-driven development methodology integrated into the Claude Code Toolkit that transforms ad-hoc coding into structured, pattern-consistent implementation.

## Overview

PRP replaces "vibe coding" with systematic analysis, planning, and execution phases, ensuring 10x faster development while maintaining high quality and pattern consistency.

## Core Workflow

### 1. Analysis Phase (`/prefix:understand . --prp`)

**Comprehensive requirement and codebase analysis:**

```bash
# Full PRP analysis
/prefix:understand . --prp --requirements="OAuth2 authentication with MFA"

# Focus on external research
/prefix:understand . --prp=research --framework="Express.js" --topic="OAuth2"

# Focus on internal patterns
/prefix:understand . --prp=patterns --domain="authentication"

# Focus on requirements validation
/prefix:understand . --prp=requirements
```

**What happens:**

- **Requirements Analysis**: Validates requirements completeness via `requirements-analyst`
- **Pattern Discovery**: Identifies existing codebase patterns via `codebase-research-specialist`
- **External Research**: Researches framework best practices via `external-research-specialist`
- **Gap Analysis**: Identifies missing requirements and technical risks

**Output**: Comprehensive analysis stored in `~/.claude/claude-code-toolkit/prp/analysis/`

### 2. Blueprint Phase (`/prefix:create . --prp`)

**Detailed implementation planning:**

```bash
# Generate comprehensive blueprint
/prefix:create . --prp --from-analysis="auth-prp-2024-001"

# Create from template
/prefix:create . --prp=template --pattern="rest-api-crud"

# Validate blueprint patterns
/prefix:create . --prp=validation --blueprint="auth-blueprint-2024-001"

# Quick blueprint for simple features
/prefix:create . --prp=fast --template="crud-operations"
```

**What happens:**

- **Blueprint Generation**: Creates detailed implementation plan via `blueprint-architect`
- **Pattern Application**: Applies discovered patterns for consistency
- **Task Breakdown**: Decomposes implementation into manageable tasks
- **Quality Gate Definition**: Establishes comprehensive validation criteria

**Output**: Implementation blueprint stored in `~/.claude/claude-code-toolkit/prp/blueprints/`

### 3. Execution Phase (`/prefix:ship . --prp`)

**Blueprint-driven implementation:**

```bash
# Execute blueprint with quality gates
/prefix:ship . --prp --blueprint="auth-blueprint-2024-001"

# Fast-track execution
/prefix:ship . --prp=fast --template="crud-operations"

# Enhanced quality validation
/prefix:ship . --prp=quality --document-decisions

# Real-time monitoring
/prefix:ship . --prp=monitor --progress-tracking
```

**What happens:**

- **Blueprint Validation**: Ensures blueprint completeness
- **Pattern-Consistent Implementation**: Uses specialized agents for execution
- **Quality Gate Enforcement**: Validates against defined criteria
- **Real-Time Monitoring**: Tracks progress and validates completion

**Output**: Implemented code with execution log in `~/.claude/claude-code-toolkit/prp/execution/`

## PRP Agents

### Core PRP Agents

1. **`requirements-analyst`**
   - Requirements validation and completeness
   - Gap analysis and missing requirements
   - Acceptance criteria definition
   - Risk assessment

2. **`codebase-research-specialist`**
   - Pattern discovery and analysis
   - Code consistency validation
   - Template extraction
   - Dependency analysis

3. **`external-research-specialist`**
   - Framework documentation research
   - Industry best practices discovery
   - Third-party integration patterns
   - Compliance and standards research

4. **`blueprint-architect`**
   - Implementation blueprint creation
   - Task breakdown and planning
   - Pattern-consistent planning
   - Quality gate definition

## Benefits

### For Developers

- **10x Faster Development**: Systematic approach eliminates trial-and-error
- **Pattern Consistency**: Automatic application of existing codebase patterns
- **Quality Assurance**: Built-in validation and testing strategies
- **Knowledge Retention**: Patterns and blueprints are preserved for reuse

### For Projects

- **Reduced Technical Debt**: Pattern-consistent implementations
- **Better Maintainability**: Well-planned architecture and documentation
- **Risk Mitigation**: Comprehensive analysis identifies issues early
- **Knowledge Transfer**: Blueprints serve as documentation

## Usage Patterns

### Traditional Enhanced Workflow

```bash
# Current approach enhanced with PRP
/prefix:understand . --comprehensive
# Enhanced with PRP analysis
/prefix:understand . --prp --requirements="E-commerce checkout"

# Traditional implementation
/prefix:create auth --oauth2
# Enhanced with blueprint
/prefix:create . --prp --requirements="OAuth2 with MFA"
/prefix:ship . --prp
```

### Full PRP Methodology

```bash
# Complete PRP workflow
/prefix:understand . --prp --requirements="E-commerce checkout system"
# → Generates comprehensive analysis with patterns and research

/prefix:create . --prp --from-analysis
# → Creates detailed implementation blueprint

/prefix:ship . --prp
# → Executes blueprint with real-time monitoring
```

### Template-Driven Development

```bash
# Quick development using established patterns
/prefix:understand . --prp=patterns --domain="API development"
/prefix:create . --prp=template --pattern="rest-api-crud" --customize="user-management"
/prefix:ship . --prp=fast
```

### Research-Heavy Implementation

```bash
# For cutting-edge or complex integrations
/prefix:understand . --prp=research --framework="Next.js 14" --topic="Server Actions"
/prefix:create . --prp --research-driven
/prefix:ship . --prp=quality --document-decisions
```

## Directory Structure

PRP data is organized in `~/.claude/claude-code-toolkit/prp/`:

```
prp/
├── analysis/           # Requirements & Research Results
│   ├── templates/     # Analysis templates
│   └── library/       # Reusable analysis patterns
├── blueprints/        # Implementation Plans
│   ├── templates/     # Blueprint templates
│   └── library/       # Reusable blueprints
├── patterns/          # Discovered Code Patterns
│   ├── architectural/ # High-level patterns
│   ├── implementation/# Code-level patterns
│   └── integration/   # Integration patterns
├── research/          # External Research Cache
│   ├── frameworks/    # Framework documentation
│   ├── best-practices/# Industry standards
│   └── apis/          # Third-party API docs
├── execution/         # Execution History
│   ├── logs/          # Execution logs
│   ├── metrics/       # Performance metrics
│   └── retrospectives/# Post-execution analysis
└── config.yaml        # PRP configuration
```

## Configuration

PRP behavior can be configured via `~/.claude/claude-code-toolkit/prp/config.yaml`:

```yaml
prp_configuration:
  analysis:
    external_research_enabled: true
    pattern_discovery_depth: "comprehensive"  # basic, standard, comprehensive
    research_cache_ttl: "24h"

  blueprint:
    template_validation: "strict"  # lenient, standard, strict
    pattern_consistency_threshold: 0.85
    quality_gates_required: true

  execution:
    parallel_execution: false
    real_time_monitoring: true
    automatic_rollback: true

  learning:
    pattern_learning_enabled: true
    cross_project_sharing: true
    template_evolution: true
```

## Best Practices

### When to Use PRP

- **Complex Features**: Multi-component implementations requiring coordination
- **New Domains**: When working with unfamiliar frameworks or patterns
- **Pattern Creation**: When establishing new patterns for the codebase
- **Quality Critical**: When implementation quality is paramount

### When to Skip PRP

- **Simple Tasks**: Single-file changes or trivial implementations
- **Prototype Code**: Quick experiments or proof-of-concepts
- **Familiar Patterns**: Well-understood implementations with existing templates

### Success Tips

1. **Start Small**: Begin with simpler features to learn PRP workflow
2. **Invest in Analysis**: Thorough analysis phase pays dividends in execution
3. **Maintain Patterns**: Keep pattern library updated and organized
4. **Review Blueprints**: Validate blueprints before execution
5. **Learn from Outcomes**: Use retrospectives to improve future implementations

## Integration with Existing Workflow

PRP integrates seamlessly with the 6-Command Architecture:

- **Traditional Commands**: Continue to work as before
- **PRP Enhanced**: Add `--prp` flag for blueprint-driven approach
- **Mixed Workflow**: Use PRP for complex features, traditional for simple tasks
- **Gradual Adoption**: Start with analysis phase, progress to full PRP

PRP transforms development from reactive coding to proactive architecture, ensuring every implementation builds on proven patterns while maintaining the flexibility and transparency of the Claude Code Toolkit.
