---
description: Security analysis and vulnerability detection with threat intelligence learning
argument-hint: [type] [target] [--standard] [--help]
allowed-tools: Task, mcp__basic-memory__search_notes, mcp__basic-memory__write_note, mcp__basic-memory__build_context
---

# Secure

Analyze security: "Check for vulnerabilities in my auth system."

## Execution

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches security types (audit, baseline, comply, review, monitor, fix), use as type
- Default: type="audit", target="."
- Handle --standard and other security options

Route to knowledge-enhanced security analysis:

Use Task tool with subagent_type="security-specialist":
"Perform comprehensive security analysis of '$target' with '$type' focus using Knowledge-Enhanced approach with threat intelligence:

1. **Threat Intelligence**: Search Basic Memory for similar security issues and vulnerability patterns
2. **Security Knowledge**: Apply knowledge-base security patterns and compliance requirements
3. **Context-Aware Analysis**: Use project security context and previous security decisions
4. **Risk Assessment**: Analyze vulnerabilities with understanding of threat landscape
5. **Learning Persistence**: Capture new security insights and threat patterns to Basic Memory

Security focus areas: vulnerability scanning, compliance checking, threat modeling, security architecture review, penetration testing insights, or security monitoring based on type.

Export results with risk assessments and remediation guidance."
