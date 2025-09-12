---
description: Smart security operations with intelligent vulnerability scanning and compliance checking
argument-hint: [type] [target] [--help]
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan, mcp__semgrep__semgrep_findings
---

# Secure - Smart Security Operations

Intelligent security command that automatically performs audits, establishes baselines, and checks compliance. Zero configuration, maximum protection.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Security Types

**Automatically uses best available scanning tools (Semgrep MCP → Local Semgrep → Pattern-based) and exports results with timestamped reports.**

### Available Security Types

- `audit` - Comprehensive security vulnerability scanning (default)
- `baseline` - Establish and track security baseline over time
- `comply` - Compliance checks for OWASP, PCI-DSS, GDPR standards
- `scan` - Quick security scan with smart tool detection
- `check` - Security health check with recommendations
- `monitor` - Continuous security monitoring setup
- `review` - Expert security code review
- `fix` - Security vulnerability remediation

## Usage

```bash
# Smart defaults - comprehensive security audit
/prefix:secure

# Specific security operations
/prefix:secure audit                    # Comprehensive vulnerability scan
/prefix:secure baseline                 # Establish security baseline
/prefix:secure comply --standard=owasp # OWASP compliance check

# With specific targets
/prefix:secure audit src/              # Audit src/ directory
/prefix:secure baseline --compare=prev # Compare with previous baseline
/prefix:secure comply --standard=all   # All compliance standards

# Advanced options
/prefix:secure audit --severity=critical    # Critical issues only
/prefix:secure comply --custom-rules=rules  # Custom compliance rules
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine security operation type and target**

```bash
# Parse arguments
args=($ARGUMENTS)
security_type="audit"    # default to comprehensive audit
target="."               # default to current directory

# Extract type if provided
if [[ ${#args[@]} -gt 0 ]] && [[ ${args[0]} != *"/"* ]] && [[ ${args[0]} != *"."* ]] && [[ ${args[0]} != --* ]]; then
    security_type=${args[0]}
    target=${args[1]:-"."}
else
    target=${args[0]:-"."}
fi
```

**Step 2: Route to appropriate security strategy**

Based on security_type, execute the optimal approach:

### Comprehensive Security Audit (Default)

**Target**: Vulnerability scanning of `$target`
**Export**: Auto-generates `secure-audit-YYYYMMDD-HHMMSS.json` + `.md` + `.html`

Use Task tool with subagent_type="security-specialist":
"Perform comprehensive security audit of '$target' using best available tools. Tool detection order: 1) Semgrep MCP (preferred - high accuracy AST analysis), 2) Local Semgrep (good quality), 3) Pattern-based (fallback). Scan for OWASP Top 10, CWE patterns, authentication issues, injection vulnerabilities, data exposure, and security misconfigurations. Export in JSON (detailed), Markdown (readable), and HTML (interactive) formats with severity ratings and remediation guidance."

### Security Baseline Establishment

**Target**: Baseline creation for `$target`
**Export**: Auto-generates `secure-baseline-YYYYMMDD-HHMMSS.json` + comparison report

Use Task tool with subagent_type="security-specialist":
"Establish security baseline for '$target' using optimal scanning tools. Create comprehensive security snapshot including: vulnerability counts by severity, code quality metrics, compliance status, risk assessment. Generate baseline data for future comparisons. If comparing with previous baseline, highlight improvements/regressions. Track security debt and provide improvement roadmap."

### Compliance Checking

**Target**: Compliance validation for `$target`
**Export**: Auto-generates `secure-comply-YYYYMMDD-HHMMSS.json` + compliance report

Use Task tool with subagent_type="security-specialist":
"Run compliance checks for '$target' against industry standards. Supported frameworks: OWASP Top 10 (2021), PCI-DSS requirements, GDPR technical measures, custom security policies. Use enhanced scanning when available. Generate compliance scorecard with pass/fail status, remediation requirements, and certification readiness assessment. Include gap analysis and action plan."

### Quick Security Scan

**Target**: Fast security assessment of `$target`
**Export**: Auto-generates `secure-scan-YYYYMMDD-HHMMSS.json` + summary

Use Task tool with subagent_type="security-specialist":
"Perform rapid security scan of '$target' focusing on critical and high-severity vulnerabilities. Use intelligent tool selection for optimal speed/accuracy balance. Prioritize: authentication bypasses, injection vulnerabilities, data exposure, dangerous functions. Provide quick triage report with immediate action items and risk assessment."

### Security Health Check

**Target**: Security posture assessment for `$target`
**Export**: Auto-generates `secure-check-YYYYMMDD-HHMMSS.json` + health report

Use Task tool with subagent_type="security-specialist":
"Assess overall security health of '$target' including: code security patterns, configuration security, dependency vulnerabilities, authentication mechanisms, data protection measures, logging/monitoring setup. Provide security score, risk matrix, and strategic recommendations for security improvement."

### Security Monitoring Setup

**Target**: Monitoring configuration for `$target`
**Export**: Auto-generates monitoring configuration and setup guide

Use Task tool with subagent_type="security-specialist":
"Set up continuous security monitoring for '$target'. Analyze codebase to identify: critical security boundaries, sensitive data flows, authentication points, external integrations. Generate monitoring configuration for security tools, logging setup for security events, alerting rules for suspicious activities, and incident response triggers."

### Expert Security Review

**Target**: Expert-level security analysis of `$target`
**Export**: Auto-generates `secure-review-YYYYMMDD-HHMMSS.json` + expert report

Use Task tool with subagent_type="security-specialist":
"Conduct expert security code review of '$target' with deep analysis. Focus on: threat modeling, attack surface analysis, security architecture review, cryptographic implementations, input validation completeness, authorization logic correctness. Provide expert-level findings with exploitability assessment and strategic security recommendations."

### Security Fix Implementation

**Target**: Automated security remediation for `$target`
**Export**: Auto-generates fix report and implementation guide

Use Task tool with subagent_type="security-specialist":
"Implement automated security fixes for '$target' with safety-first approach. Analyze security issues and apply: safe automated fixes for low-risk issues, guided remediation for medium-risk issues, expert recommendations for high-risk issues. Include testing guidance and rollback procedures. Prioritize fixes by exploitability and business impact."

## Tool Auto-Detection

### Semgrep MCP (Preferred)

- High-accuracy AST-based analysis
- Enhanced vulnerability detection
- Precise fix recommendations
- Real-time rule updates

### Local Semgrep (Good Quality)

- Community and commercial rules
- Fast local scanning
- Comprehensive coverage
- CI/CD integration ready

### Pattern-Based (Fallback)

- Basic vulnerability detection
- Works without dependencies
- Fast execution
- Limited accuracy

## Next Steps Recommendations

After security operation completion, display context-aware recommendations:

```markdown
✅ [Security Type] completed successfully

🔒 **Security Status**: [Current security posture summary]
⚠️  **Critical Findings**: [Count and summary of critical issues]
📊 **Risk Assessment**: [Overall risk level and key concerns]

💡 **Recommended next steps:**
   /prefix:fix security          # Apply automated security fixes
   /prefix:secure baseline       # Establish security tracking
   /prefix:work incident         # Address critical vulnerabilities
   
   **Or describe your security goal:** "I need to fix authentication vulnerabilities"
```

### Smart Next-Step Logic

Based on security operation results, suggest relevant follow-up actions:

- **Critical vulnerabilities found** → Suggest `/prefix:work incident` for immediate response
- **Security audit completed** → Suggest `/prefix:secure baseline` for tracking
- **Baseline established** → Suggest scheduled `/prefix:secure audit` monitoring
- **Compliance gaps found** → Suggest `/prefix:fix security` and remediation plan
- **Security fixes applied** → Suggest `/prefix:secure audit` for verification

## Security Frameworks Supported

### OWASP Top 10 (2021)

- A01: Broken Access Control
- A02: Cryptographic Failures  
- A03: Injection
- A04: Insecure Design
- A05: Security Misconfiguration
- A06: Vulnerable Components
- A07: Authentication Failures
- A08: Data Integrity Failures
- A09: Logging/Monitoring Failures
- A10: Server-Side Request Forgery

### Compliance Standards

- **PCI-DSS**: Payment card security requirements
- **GDPR**: Data protection and privacy measures
- **CWE**: Common Weakness Enumeration patterns
- **SANS Top 25**: Most dangerous software errors

### Severity Classification

- **Critical** (CVSS 9.0-10.0): Immediate action required
- **High** (CVSS 7.0-8.9): Fix within 24-48 hours
- **Medium** (CVSS 4.0-6.9): Fix within sprint
- **Low** (CVSS 0.1-3.9): Track for future fix

## Benefits

- **Intelligent Tool Selection**: Automatically uses the best available security scanning tools
- **Comprehensive Coverage**: Supports auditing, baselining, and compliance in one interface
- **Expert Analysis**: Security-specialist agent provides deep security expertise
- **Multi-Format Export**: JSON (automation), Markdown (readable), HTML (interactive)
- **Continuous Tracking**: Baseline and monitoring capabilities for ongoing security
- **One Interface**: Replaces 3 specialized security commands

*Consolidates: sec:audit, sec:baseline, sec:comply*
