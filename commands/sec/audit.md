---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan, mcp__semgrep__semgrep_findings
description: Comprehensive security audit with MCP-enhanced scanning or traditional fallback methods
argument-hint: [directory] [--severity=critical|high|all] [--export-md] [--export-json] [--export-html] [--export-all] [--export-dir=path]
---

**IMPORTANT: This command performs security analysis and optionally exports reports. File creation is ONLY allowed for report export when --export flags are used.**

# Security Audit Command

This command performs a deep security audit using the best available tools, with automatic fallback to traditional methods when enhanced tools are not available.

## Tool Detection Phase

**FIRST, CHECK AVAILABLE SECURITY TOOLS:**

1. **Check for Semgrep MCP**: Test if `mcp__semgrep__*` tools are available
2. **Check for local Semgrep**: `Bash("which semgrep")`
3. **Determine analysis strategy** based on available tools

## Execution Strategy

### Option A: MCP-Enhanced Security Audit (Preferred)

**IF Semgrep MCP tools are available, USE THIS APPROACH:**

1. **Comprehensive MCP Security Scan**:
   - Use `mcp__semgrep__security_check` for fast initial security assessment
   - If critical issues found, proceed with detailed analysis

2. **Detailed Vulnerability Analysis**:
   - Use `mcp__semgrep__semgrep_scan` with config "p/security" for comprehensive scanning
   - Collect all code files using Read/Glob tools
   - Submit files for analysis with proper structure

3. **Check Existing Findings** (if applicable):
   - Use `mcp__semgrep__semgrep_findings` to retrieve any existing security findings from CI/CD
   - Filter by severity and status

4. **Custom Rule Scanning** (for specific concerns):
   - Create custom rules for project-specific security patterns
   - Use `mcp__semgrep__semgrep_scan_with_custom_rule` for targeted analysis

### Option B: Local Semgrep Fallback

**IF Semgrep MCP is NOT available BUT local semgrep is installed:**

```bash
# Run comprehensive security scan
semgrep --config=auto --json --severity=ERROR,WARNING $ARGUMENTS

# Run OWASP specific checks
semgrep --config=p/owasp-top-ten --json $ARGUMENTS

# Run security audit
semgrep --config=p/security-audit --json $ARGUMENTS
```

### Option C: Traditional Pattern-Based Audit

**IF neither MCP nor local Semgrep is available, START 8 PARALLEL SECURITY AGENTS:**

1. **SQL Injection Agent**: Task(description="SQL Injection Detection", prompt="Scan $ARGUMENTS for SQL injection vulnerabilities. Search for: 1) String concatenation in SQL queries, 2) Unescaped user input in queries, 3) Dynamic query building, 4) Raw SQL without prepared statements. Use rg for patterns like 'SELECT.*\\+|WHERE.*\\$|query\\(.*\\+'. Return all findings with severity and code location as JSON.", subagent_type="general-purpose")

2. **XSS Vulnerability Agent**: Task(description="XSS Detection", prompt="Identify XSS vulnerabilities in $ARGUMENTS. Check: 1) Unescaped output in templates (innerHTML, document.write), 2) User input in HTML/JavaScript, 3) Missing Content Security Policy, 4) Unsafe eval() usage. Search in .js, .jsx, .ts, .tsx, .html files. Return structured findings with exploit examples as JSON.", subagent_type="general-purpose")

3. **Authentication Weakness Agent**: Task(description="Auth Security Check", prompt="Analyze authentication/authorization weaknesses in $ARGUMENTS. Examine: 1) Hardcoded credentials, 2) Weak password policies, 3) Missing rate limiting, 4) Session management issues, 5) JWT vulnerabilities, 6) Missing CSRF protection. Focus on auth*, login*, session* patterns. Return critical findings as JSON.", subagent_type="general-purpose")

4. **Secret Exposure Agent**: Task(description="Secret/Credential Scanner", prompt="Find exposed secrets in $ARGUMENTS. Scan for: 1) API keys (AWS, Azure, GCP), 2) Private keys, 3) Passwords/tokens in code, 4) Database credentials, 5) .env files in Git. Use regex patterns for various secret formats. IMPORTANT: Return only secret type and location, NEVER the actual secret! JSON format.", subagent_type="general-purpose")

5. **CORS Configuration Agent**: Task(description="CORS Security Analysis", prompt="Check CORS configurations in $ARGUMENTS. Analyze: 1) Wildcard origins (*), 2) Credentials with unsafe origins, 3) Missing CORS headers, 4) Overly permissive policies. Search in API routes, server configs, middleware. Return misconfigurations with risk level as JSON.", subagent_type="general-purpose")

6. **Dependency CVE Agent**: Task(description="Vulnerable Dependencies", prompt="Scan dependencies for known CVEs in $ARGUMENTS. Check: 1) package.json, requirements.txt, go.mod, Cargo.toml, 2) Outdated packages with security issues, 3) Dependencies with critical CVEs. If possible, use local tools. Return top 10 most critical vulnerabilities with CVE IDs as JSON.", subagent_type="general-purpose")

7. **CSRF Protection Agent**: Task(description="CSRF Vulnerability Check", prompt="Identify CSRF vulnerabilities in $ARGUMENTS. Examine: 1) Missing CSRF tokens in forms, 2) State-changing GET requests, 3) Missing SameSite cookie attributes, 4) Unprotected API endpoints. Focus on web frameworks and API routes. Return findings with exploit scenarios as JSON.", subagent_type="general-purpose")

8. **Information Disclosure Agent**: Task(description="Info Disclosure Scanner", prompt="Find information disclosure issues in $ARGUMENTS. Search for: 1) Stack traces in production, 2) Debug mode enabled, 3) Verbose error messages, 4) Source maps in production, 5) Exposed admin panels, 6) Directory listing. Return all findings with sensitivity level as JSON.", subagent_type="general-purpose")

## Synthesis

After completion of security analysis (regardless of method used):

1. **Consolidate all findings** from the chosen analysis method
2. **Classify by CVSS Score**:
   - Critical (9.0-10.0): Immediate Action Required
   - High (7.0-8.9): Fix within 24-48 hours
   - Medium (4.0-6.9): Fix within Sprint
   - Low (0.1-3.9): Track for future fix

3. **Group by exploit likelihood**:
   - Actively Exploited in Wild
   - Easy to Exploit
   - Requires Specific Conditions
   - Theoretical Risk

4. **Create Security Report**:
   ```markdown
   # Security Audit Report
   
   ## Analysis Method
   - **Tool Used**: [Semgrep MCP | Local Semgrep | Pattern-Based Analysis]
   - **Accuracy Level**: [High | Medium | Basic]
   - **Scan Duration**: X seconds
   
   ## Executive Summary
   - Total Vulnerabilities: X
   - Critical: X | High: X | Medium: X | Low: X
   - Immediate Action Items: X
   
   ## Critical Vulnerabilities
   [List with remediation steps]
   
   ## High Priority Fixes
   [Sorted by exploit risk]
   
   ## Compliance Issues
   - OWASP Top 10 Coverage
   - PCI DSS Relevant Findings
   - GDPR Implications
   
   ## Remediation Roadmap
   1. Emergency Fixes (0-24h)
   2. Short-term (1-7 days)
   3. Long-term improvements
   
   ## Security Posture Score
   [Based on findings: A-F rating]
   
   ## Tool Recommendations
   [If not using MCP, include upgrade suggestion]
   ```

5. **Generate Actionable Tickets**:
   - Title, description, severity
   - Proof of Concept (where safe)
   - Remediation Steps
   - Testing Instructions

## Quality Indicators

Include in report based on analysis method:

### With Semgrep MCP:
```markdown
✅ **High-Accuracy Analysis**: Using Semgrep's AST-based scanning
✅ **Comprehensive Coverage**: All OWASP Top 10 categories checked
✅ **Low False Positive Rate**: Advanced semantic analysis
```

### With Local Semgrep:
```markdown
⚡ **Good Analysis Quality**: Using local Semgrep installation
⚡ **Strong Coverage**: Most security patterns detected
⚠️ **Note**: Consider installing Semgrep MCP for faster analysis
```

### With Pattern-Based:
```markdown
⚠️ **Basic Analysis**: Using pattern matching (reduced accuracy)
⚠️ **Limited Coverage**: May miss complex vulnerabilities
💡 **Recommendation**: Install Semgrep MCP for professional-grade analysis:
   npm install -g @semgrep/mcp
```

## Performance Expectations

- **Semgrep MCP**: 3-5 seconds for comprehensive scan
- **Local Semgrep**: 10-15 seconds depending on codebase size
- **Pattern-based**: 5-7 seconds with parallel agents

**Security notice**: This audit does not replace professional penetration testing or security reviews, but serves as a first analysis layer. Results quality depends on available tools.