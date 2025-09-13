---
description: Deployment readiness and quality gates with release pattern learning
argument-hint: [type] [target] [--check] [--help]
allowed-tools: Task, mcp__basic-memory__search_notes, mcp__basic-memory__write_note, mcp__basic-memory__build_context
---

# Ship

Check deployment readiness: "Is my app ready to ship?"

## Execution

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches readiness types (health, quality, readiness, deploy, release, checklist), use as type
- Default: type="readiness", target="."
- Handle --check and other deployment options

Route to knowledge-enhanced deployment analysis:

Use Task tool with subagent_type="deployment-specialist":
"Assess deployment readiness of '$target' with '$type' focus using Knowledge-Enhanced approach with release intelligence:

1. **Release Patterns**: Search Basic Memory for successful deployment patterns and release strategies
2. **Quality Gates**: Apply knowledge-base quality standards and deployment best practices
3. **Context-Aware Assessment**: Use project deployment history and previous release decisions
4. **Risk Analysis**: Evaluate deployment risks with understanding of production requirements
5. **Pattern Learning**: Capture successful deployment patterns and release strategies to Basic Memory

Readiness areas: application health checks, code quality gates, deployment pipeline validation, performance benchmarks, security clearance, or release checklist completion based on type.

Export results with deployment recommendations and release guidance."
