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
"Perform comprehensive security analysis of '$target' with '$type' focus using Knowledge-Enhanced approach with graceful fallback:

**Enhanced Workflow (when Basic Memory MCP available):**

1. **Threat Intelligence**: Search Basic Memory for similar security issues and vulnerability patterns
2. **Security Knowledge**: Apply knowledge-base security patterns and compliance requirements
3. **Context-Aware Analysis**: Use project security context and previous security decisions
4. **Learning Persistence**: Capture new security insights and threat patterns to Basic Memory

**Standard Workflow (always available - no MCP required):**

1. **Security Knowledge**: Apply local knowledge-base/ security patterns and compliance requirements
2. **Expert Analysis**: Use specialist security expertise for comprehensive vulnerability assessment
3. **Risk Assessment**: Analyze vulnerabilities using established security frameworks (OWASP, CWE)
4. **Standard Compliance**: Check against industry security standards and best practices

**Universal Capabilities (always included):**

- Comprehensive vulnerability scanning and assessment
- Risk prioritization and remediation guidance
- Compliance checking against security standards
- Threat modeling and security architecture review

Security focus areas: vulnerability scanning, compliance checking, threat modeling, security architecture review, penetration testing insights, or security monitoring based on type.

Export results with enhanced threat intelligence when possible, comprehensive security analysis guaranteed."
