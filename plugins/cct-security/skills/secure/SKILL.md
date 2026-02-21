---
name: secure
description: This skill should be used when the user asks to "check for vulnerabilities", "security audit", "scan for security issues", "OWASP check", or needs security analysis, threat modeling, or compliance validation.
---

# Secure

Perform comprehensive security analysis with vulnerability detection and compliance checking.

## Arguments

Parse arguments: `$ARGUMENTS`

Extract type, target, and options:

- If first argument matches types (audit, baseline, comply, review, monitor, fix), use as type
- Default: type="audit", target="."
- Flags: `--standard`

## Execution

Use Task tool with subagent_type="security-specialist":
"Perform comprehensive security analysis of '$target' with '$type' focus:

1. **Vulnerability Scanning**: Identify security vulnerabilities using OWASP Top 10 framework
2. **Risk Assessment**: Analyze vulnerabilities using CWE classification and CVSS scoring
3. **Compliance Checking**: Validate against security standards and best practices
4. **Threat Modeling**: Assess attack surface and potential threat vectors

Focus areas based on type:

- **audit**: Full security audit with OWASP Top 10 coverage
- **baseline**: Establish security baseline for the project
- **comply**: Check against specific compliance standard (--standard)
- **review**: Security-focused code review
- **monitor**: Check for known vulnerabilities in dependencies
- **fix**: Remediate identified vulnerabilities

Include:

- Vulnerability severity classification (Critical, High, Medium, Low)
- Specific file locations and affected code
- Remediation guidance with code examples
- Dependency vulnerability check (npm audit, pip audit, etc.)"

## Output Format

```markdown
# Security Analysis: {target}

**Date:** {YYYY-MM-DD} | **Type:** {type} | **Risk Level:** HIGH/MEDIUM/LOW

## Vulnerabilities Found

### Critical
| # | Vulnerability | CWE | Location | Remediation |
|---|-------------|-----|----------|-------------|
| 1 | [description] | CWE-XXX | file:line | [fix] |

### High
[...]

## Dependency Audit
| Package | Version | Vulnerability | Fix |
|---------|---------|--------------|-----|
| [pkg] | [ver] | [CVE] | Upgrade to [ver] |

## Compliance Status
| Standard | Status | Details |
|----------|--------|---------|
| OWASP A01 | PASS/FAIL | [notes] |

## Recommendations
1. [Priority remediation actions]
```
