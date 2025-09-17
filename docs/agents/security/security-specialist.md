# Security Specialist

## Overview

Deep security analysis expert specializing in vulnerability detection, OWASP compliance, and security best practices. This agent performs thorough security audits, identifies potential vulnerabilities, and provides remediation strategies.

## Capabilities

- **OWASP Top 10 Analysis**: Comprehensive checking for injection vulnerabilities, broken authentication, sensitive data exposure
- **Vulnerability Detection**: AST-based analysis when Semgrep MCP tools are available, pattern-based fallback
- **Security Code Review**: Input validation, cryptographic implementations, hardcoded secrets detection
- **Compliance Checking**: GDPR, PCI DSS, SOC 2 requirements assessment
- **Risk Assessment**: CVSS scoring, exploitability analysis, business impact evaluation

## Usage

### Direct Invocation

```bash
# Use Task tool with security specialist
Use Task tool with subagent_type="security-specialist":
"Perform comprehensive security audit focusing on OWASP Top 10 vulnerabilities"
```

### Through Core Commands

```bash
/prefix:secure . --audit
/prefix:secure . --compliance-check
```

## Output Format

- **Executive Summary**: Overall security posture, critical findings count
- **Vulnerability Findings**: Categorized by severity (Critical/High/Medium/Low)
- **Security Recommendations**: Immediate actions, short-term improvements, long-term strategy
- **Compliance Status**: OWASP, GDPR, PCI DSS assessment

## Enhanced Features

### With MCP Tools

- **Semgrep Integration**: Zero false positive AST-based analysis
- **Custom Security Rules**: Project-specific vulnerability patterns
- **Comprehensive Coverage**: Language and framework-specific rules

### Knowledge-Enhanced

- **Threat Intelligence**: Access to similar security issues across projects
- **Pattern Learning**: Successful remediation strategies from knowledge base
- **Context-Aware Assessment**: Project-specific security history

## Examples

### Vulnerability Assessment

```bash
# Comprehensive security audit
Use Task tool with subagent_type="security-specialist":
"Audit the authentication system for security vulnerabilities, focusing on session management and password handling"
```

### Compliance Review

```bash
# GDPR compliance check
Use Task tool with subagent_type="security-specialist":
"Review data handling practices for GDPR compliance, including data collection, processing, and deletion"
```

## Tools Used

- **Read**: Code analysis and file inspection
- **Grep**: Pattern-based vulnerability detection
- **Task**: Coordination with other specialists
- **MCP**: Semgrep security scanning (when available)

## Debugging Specialist Integration

The Security Specialist includes comprehensive debugging capabilities for security-related issues:

### Debug-Focused Security Analysis

- **Vulnerability Root Cause Analysis**: Deep debugging of security vulnerabilities to understand exploitation vectors
- **Authentication Flow Debugging**: Step-by-step analysis of authentication failures and session management issues
- **Authorization Logic Debugging**: Debugging complex permission systems and access control failures
- **Cryptographic Implementation Debugging**: Analysis of encryption/decryption failures and key management issues
- **Input Validation Debugging**: Detailed analysis of input sanitization failures and injection vulnerabilities

### Debug Output Format

When debugging security issues, the specialist provides:

- **Execution Flow Analysis**: Step-by-step breakdown of security-relevant code execution
- **State Inspection**: Analysis of security-related variables and system state at failure points
- **Attack Vector Mapping**: Detailed explanation of how vulnerabilities can be exploited
- **Remediation Debugging**: Step-by-step guide for implementing security fixes
- **Testing Validation**: Debug approaches for validating security fix effectiveness

### Debug Examples

```bash
# Debug authentication failure
Use Task tool with subagent_type="security-specialist":
"Debug why user authentication is failing intermittently, focusing on session management and token validation logic"

# Debug authorization bypass
Use Task tool with subagent_type="security-specialist":
"Debug the authorization system to understand why users can access resources they shouldn't have permission for"

# Debug injection vulnerability
Use Task tool with subagent_type="security-specialist":
"Debug the SQL injection vulnerability in the user search functionality and provide detailed remediation steps"
```

### Integration with Testing

- **Security Test Debugging**: Debug failing security tests and validation scripts
- **Penetration Test Analysis**: Analyze and debug results from security penetration testing
- **Vulnerability Scanner Integration**: Debug and validate findings from automated security scanning tools

## See Also

- [Security Guide](../../guides/SECURITY-GUIDE.md)
- [Security Command](../../commands/secure.md)
- [Test Engineer](../testing/test-engineer.md)
