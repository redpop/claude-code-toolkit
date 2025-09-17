---
description: Deployment readiness and quality gates with release pattern learning
argument-hint: [type] [target] [--check] [--prp] [--readiness-check] [--quality-gates] [--help]
allowed-tools: Task, mcp__basic-memory__search_notes, mcp__basic-memory__write_note, mcp__basic-memory__build_context
---

# Ship

Check deployment readiness: "Is my app ready to ship?"

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Deployment readiness and quality gates with release pattern learning
- **Usage**: [type] [target] [--check] [--prp] [--readiness-check] [--quality-gates]
- **Types**: readiness, deploy, release, validate, monitor, quality, health, checklist
- **Options**:
  - `--check=type`        Specific check: tests, build, security, performance
  - `--prp`               Activate PRP blueprint execution methodology
  - `--prp=fast`          Fast-track execution for tested patterns
  - `--prp=quality`       Enhanced quality validation during execution
  - `--prp=monitor`       Real-time execution monitoring with progress tracking
  - `--readiness-check`   Comprehensive deployment readiness assessment
  - `--quality-gates`     Apply quality gates before deployment

**Examples:**

/ prefix:ship
/ prefix:ship . --readiness-check
/ prefix:ship . --quality-gates
/ prefix:ship . --check=tests
/ prefix:ship . --prp=monitor
/ prefix:ship components/ --prp=fast
/ prefix:ship . --check=security

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches readiness types (health, quality, readiness, deploy, release, checklist), use as type
- Default: type="readiness", target="."
- Handle --check and other deployment options

**PRP Enhancement - Blueprint-Driven Execution:**

If arguments contain "--prp" flag, activate PRP blueprint execution methodology:

- `--prp` alone: Execute implementation blueprint with quality gates
- `--prp=fast`: Fast-track execution for tested patterns
- `--prp=quality`: Enhanced quality validation during execution
- `--prp=monitor`: Real-time execution monitoring with progress tracking

**PRP Execution Workflow:**

1. **Blueprint Validation**: Validate blueprint completeness via blueprint-architect
2. **Pattern-Consistent Implementation**: Execute using established patterns via specialized agents
3. **Quality Gate Enforcement**: Validate against defined quality criteria during execution
4. **Real-Time Monitoring**: Track progress and validate successful completion

Route to enhanced deployment analysis:

Use Task tool with subagent_type="deployment-specialist":
"Assess deployment readiness of '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when Basic Memory MCP available):**

1. **Release Patterns**: Search Basic Memory for successful deployment patterns and release strategies
2. **Quality Gates**: Apply knowledge-base quality standards and deployment best practices
3. **Context-Aware Assessment**: Use project deployment history and previous release decisions
4. **Pattern Learning**: Capture successful deployment patterns and release strategies to Basic Memory

**Standard Workflow (always available - no MCP required):**

1. **Quality Gates**: Apply local knowledge-base/ quality standards and deployment best practices
2. **Expert Assessment**: Use deployment specialist expertise for comprehensive readiness evaluation
3. **Risk Analysis**: Evaluate deployment risks using established production requirements
4. **Standard Checklist**: Apply proven release checklists and quality validation processes

**Universal Capabilities (always included):**

- Application health checks and system validation
- Code quality gates and compliance verification
- Deployment pipeline validation and testing
- Performance benchmarks and scalability assessment
- Security clearance and vulnerability screening

Readiness areas: application health checks, code quality gates, deployment pipeline validation, performance benchmarks, security clearance, or release checklist completion based on type.

Export results with enhanced release intelligence when possible, comprehensive readiness assessment guaranteed.

**Phase 3 Enhancement - Automatic Learning & Next-Steps:**

- Persist successful deployment patterns and release strategies for operational knowledge enhancement
- Generate intelligent recommendations for deployment optimizations and release pipeline improvements
- Cross-reference readiness assessments with similar successful releases and deployment outcomes
- Track release success metrics and evolve deployment strategies based on operational learning"
