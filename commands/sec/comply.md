---
allowed-tools: Task, Read, Grep, Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan, mcp__semgrep__semgrep_scan_with_custom_rule
description: Run compliance checks for OWASP, PCI-DSS, GDPR, and custom security policies
argument-hint: [directory] [--standard=owasp|pci-dss|gdpr|all] [--custom-rules=rules.yaml] [--export-report]
---

# Compliance Check Command

This command runs comprehensive compliance checks against industry standards and custom security policies. It leverages Semgrep MCP when available for accurate compliance validation.

## Tool Detection

**FIRST, CHECK AVAILABLE TOOLS:**

1. **Check for Semgrep MCP**: Test if `mcp__semgrep__*` tools are available
2. **Check for local Semgrep**: `Bash("which semgrep")`
3. **Select compliance check strategy** based on available tools

## Supported Standards

### OWASP Top 10 (2021)

- A01: Broken Access Control
- A02: Cryptographic Failures
- A03: Injection
- A04: Insecure Design
- A05: Security Misconfiguration
- A06: Vulnerable and Outdated Components
- A07: Identification and Authentication Failures
- A08: Software and Data Integrity Failures
- A09: Security Logging and Monitoring Failures
- A10: Server-Side Request Forgery (SSRF)

### PCI-DSS Key Requirements

- Requirement 2: Default passwords and security parameters
- Requirement 3: Protect stored cardholder data
- Requirement 4: Encrypt transmission of cardholder data
- Requirement 6: Develop and maintain secure systems
- Requirement 8: Identify and authenticate access

### GDPR Technical Measures

- Data minimization
- Encryption at rest and in transit
- Access controls and authentication
- Data retention policies
- Right to erasure implementation
- Consent management
- Data breach notification readiness

## Execution

### Option A: MCP-Enhanced Compliance Check (Preferred)

**IF Semgrep MCP is available:**

1. **OWASP Compliance**:

   ```markdown
   Use mcp**semgrep**semgrep_scan with config "p/owasp-top-ten"
   Map findings to OWASP categories
   Calculate compliance percentage
   ```

2. **PCI-DSS Compliance**:

   ```markdown
   Use mcp**semgrep**semgrep_scan with config "p/pci-dss"
   Check for credit card data handling
   Verify encryption implementations
   ```

3. **GDPR Compliance**:

   ```markdown
   Use mcp**semgrep**semgrep_scan_with_custom_rule for GDPR-specific checks:

   - Personal data identification patterns
   - Consent verification logic
   - Data retention implementations
   ```

4. **Custom Policy Compliance**:

   ```markdown
   If --custom-rules provided:

   - Load custom Semgrep rules
   - Use mcp**semgrep**semgrep_scan_with_custom_rule
   - Generate custom compliance report
   ```

### Option B: Local Semgrep Compliance

**IF local Semgrep is available but not MCP:**

```bash
# OWASP compliance
semgrep --config=p/owasp-top-ten --json . > owasp-compliance.json

# PCI-DSS compliance
semgrep --config=p/pci-dss --json . > pci-compliance.json

# Custom rules if provided
if [ -f "$CUSTOM_RULES" ]; then
  semgrep --config="$CUSTOM_RULES" --json . > custom-compliance.json
fi
```

### Option C: Pattern-Based Compliance

**IF no Semgrep tools available:**

Run basic pattern-based checks for common compliance issues:

- Hardcoded secrets (PCI-DSS)
- Unencrypted data transmission
- Missing authentication
- Personal data exposure (GDPR)

## Compliance Report Generation

### Standard Report Format

```markdown
# Compliance Report

## Executive Summary

- **Date**: [timestamp]
- **Standards Checked**: [OWASP, PCI-DSS, GDPR]
- **Analysis Tool**: [Semgrep MCP | Local Semgrep | Pattern-Based]
- **Overall Compliance**: [percentage]

## OWASP Top 10 Compliance

| Category                    | Status     | Issues | Compliance |
| --------------------------- | ---------- | ------ | ---------- |
| A01: Broken Access Control  | ⚠️ Partial | 3      | 75%        |
| A02: Cryptographic Failures | ✅ Pass    | 0      | 100%       |
| A03: Injection              | ❌ Fail    | 5      | 40%        |
| ...                         | ...        | ...    | ...        |

### Critical Findings

1. **SQL Injection** (A03)
   - Location: user-service.js:45
   - Risk: High
   - Remediation: Use parameterized queries

## PCI-DSS Compliance

### Requirement 3: Protect Stored Cardholder Data

- **Status**: ❌ Non-Compliant
- **Issues Found**:
  1. Credit card numbers stored in plain text (database.js:123)
  2. Missing encryption for sensitive data fields

### Requirement 6.5: Secure Coding

- **Status**: ⚠️ Partial Compliance (70%)
- **Issues Found**:
  1. Input validation missing in payment module
  2. Error messages expose system information

## GDPR Compliance

### Data Protection Measures

- **Encryption at Rest**: ✅ Implemented
- **Encryption in Transit**: ⚠️ Partial (HTTPS not enforced)
- **Access Controls**: ✅ RBAC implemented
- **Data Minimization**: ❌ Excessive data collection detected

### Privacy by Design

1. **Consent Management**: Not implemented
2. **Right to Erasure**: Partial implementation
3. **Data Portability**: Not implemented

## Recommendations

### Immediate Actions (Critical)

1. Fix SQL injection vulnerabilities (OWASP A03)
2. Implement credit card encryption (PCI-DSS Req 3)
3. Add consent management system (GDPR)

### Short-term (1-2 weeks)

1. Implement comprehensive input validation
2. Enforce HTTPS across all endpoints
3. Add data retention policies

### Long-term (1-3 months)

1. Implement full GDPR compliance framework
2. Achieve PCI-DSS Level 1 compliance
3. Automate compliance monitoring
```

## Custom Rules Support

When `--custom-rules` is provided:

```yaml
# Example custom-rules.yaml
rules:
  - id: company-no-test-credentials
    pattern: |
      $CRED = "test123"
    message: Test credentials found in production code
    severity: ERROR
    metadata:
      compliance: company-policy

  - id: company-secure-api-keys
    patterns:
      - pattern: api_key = "$KEY"
      - pattern-not: api_key = getenv(...)
    message: API keys must be loaded from environment
    severity: ERROR
```

## Export Options

With `--export-report`:

1. **HTML Report**: Interactive compliance dashboard
2. **JSON Report**: Machine-readable compliance data
3. **PDF Report**: Executive summary for management
4. **CSV Report**: Issue list for tracking

## Continuous Compliance

Integration with CI/CD:

```yaml
# GitHub Actions example
- name: Compliance Check
  run: |
    claude-code /security:compliance . --standard=all
    if [ $? -ne 0 ]; then
      echo "Compliance check failed!"
      exit 1
    fi
```

## Compliance Scores

Calculate and track compliance scores:

```json
{
  "compliance_scores": {
    "owasp": 85,
    "pci_dss": 72,
    "gdpr": 68,
    "custom": 90
  },
  "trend": "improving",
  "target_date": "2024-03-01",
  "blockers": ["SQL injection fixes", "Consent management implementation"]
}
```

## Tool Quality Impact

- **Semgrep MCP**:
  - Comprehensive rule coverage
  - Low false positive rate
  - Automated compliance mapping
- **Local Semgrep**:

  - Good coverage
  - Manual mapping required
  - Slower execution

- **Pattern-Based**:
  - Basic compliance checks only
  - Higher false positive rate
  - Manual verification needed

💡 **Recommendation**: For regulatory compliance, use Semgrep MCP to ensure comprehensive coverage and accurate results:

```bash
npm install -g @semgrep/mcp
```

This enables professional-grade compliance validation with detailed reporting.
