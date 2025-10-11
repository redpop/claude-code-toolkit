---
description: Deployment readiness and quality gates with release pattern learning
argument-hint: [type] [target] [--check] [--readiness-check] [--quality-gates] [--help]
allowed-tools: Task, mcp____search_notes, mcp____write_note, mcp____build_context
---

# Ship

Check deployment readiness: "Is my app ready to ship?"

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Deployment readiness and quality gates with release pattern learning
- **Usage**: [type] [target] [--check] [--readiness-check] [--quality-gates]
- **Types**: readiness, deploy, release, validate, monitor, quality, health, checklist
- **Options**:
- `--check=type`    Specific check: tests, build, security, performance
- `--readiness-check`  Comprehensive deployment readiness assessment
- `--quality-gates`   Apply quality gates before deployment

**Examples:**

/prefix:ship
/prefix:ship . --readiness-check
/prefix:ship . --quality-gates
/prefix:ship . --check=tests
/prefix:ship . --check=security

Then exit without executing the main command.

---

## Execution

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches readiness types (health, quality, readiness, deploy, release, checklist), use as type
- Default: type="readiness", target="."
- Handle --check and other deployment options

Route to enhanced deployment analysis:

Use Task tool with subagent_type="deployment-specialist":
"Assess deployment readiness of '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when MCP services available):**

1. **Release Patterns**: Search for successful deployment patterns and release strategies
2. **Quality Gates**: Apply knowledge-base quality standards and deployment best practices
3. **Context-Aware Assessment**: Use project deployment history and previous release decisions
4. **Pattern Learning**: Capture successful deployment patterns and release strategies

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
