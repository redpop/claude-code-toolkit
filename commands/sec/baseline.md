---
allowed-tools: Task, Read, Grep, Bash(semgrep:*), Write
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan, mcp__semgrep__semgrep_findings
description: Establish and track security baseline with MCP-enhanced scanning or traditional methods
argument-hint: [directory] [--export-baseline] [--compare=previous-baseline.json] [--track-improvements]
---

# Security Baseline Command

This command establishes a security baseline for your project, allowing you to track security improvements and regressions over time. It leverages Semgrep MCP when available for comprehensive analysis.

## Tool Detection

**FIRST, CHECK AVAILABLE TOOLS:**

1. **Check for Semgrep MCP**: Test if `mcp__semgrep__*` tools are available
2. **Check for local Semgrep**: `Bash("which semgrep")`
3. **Select baseline strategy** based on available tools

## Execution

### Option A: MCP-Enhanced Baseline (Preferred)

**IF Semgrep MCP is available:**

1. **Comprehensive Security Scan**:
   - Use `mcp__semgrep__security_check` for initial assessment
   - Use `mcp__semgrep__semgrep_scan` with multiple configs:
     - `p/security` - General security rules
     - `p/owasp-top-ten` - OWASP Top 10
     - `p/r2c-security-audit` - Security audit rules

2. **Retrieve Existing Findings** (if in CI/CD):
   - Use `mcp__semgrep__semgrep_findings` to get historical data
   - Compare with current scan results

3. **Generate Baseline Data**:
   ```json
   {
     "timestamp": "ISO-8601",
     "tool": "Semgrep MCP",
     "project": "$ARGUMENTS",
     "summary": {
       "total_issues": 0,
       "critical": 0,
       "high": 0,
       "medium": 0,
       "low": 0
     },
     "issues": [],
     "metrics": {
       "security_score": 0,
       "owasp_coverage": {},
       "cwe_distribution": {}
     }
   }
   ```

### Option B: Local Semgrep Baseline

**IF local Semgrep is available but not MCP:**

```bash
# Run comprehensive baseline scan
semgrep --config=auto --json --metrics=on . > baseline-raw.json

# Additional security-focused scans
semgrep --config=p/security --json . >> baseline-security.json
semgrep --config=p/owasp-top-ten --json . >> baseline-owasp.json
```

### Option C: Pattern-Based Baseline

**IF no Semgrep tools available:**

Run pattern-based security checks and generate basic baseline metrics using ripgrep and custom patterns.

## Baseline Comparison

When `--compare` flag is provided:

1. **Load Previous Baseline**
2. **Compare Metrics**:
   - New vulnerabilities introduced
   - Fixed vulnerabilities
   - Changed severity levels
   - Overall security score delta

3. **Generate Comparison Report**:
   ```markdown
   # Security Baseline Comparison
   
   ## Summary
   - **Previous Date**: [timestamp]
   - **Current Date**: [timestamp]
   - **Tool Used**: [Semgrep MCP | Local Semgrep | Pattern-Based]
   
   ## Progress
   - **Security Score**: 72 → 85 (+13) ✅
   - **Critical Issues**: 3 → 0 (-3) ✅
   - **High Issues**: 8 → 4 (-4) ✅
   - **New Issues**: 2 ⚠️
   
   ## Fixed Vulnerabilities
   1. SQL Injection in user.js:45
   2. XSS in template.html:23
   
   ## New Vulnerabilities
   1. Hardcoded credential in config.js:12
   2. Missing CSRF protection in api.js:89
   
   ## Recommendations
   - Address new vulnerabilities before next release
   - Continue improving test coverage
   - Update dependencies with known CVEs
   ```

## Tracking Improvements

With `--track-improvements` flag:

1. **Maintain History File** (`.security-baseline-history.json`):
   - Append each baseline with timestamp
   - Track trend over time
   - Calculate improvement velocity

2. **Generate Trend Analysis**:
   ```markdown
   ## Security Trend Analysis
   
   ### Last 30 Days
   - Average improvement: +2.5 points/week
   - Issues fixed: 23
   - Issues introduced: 5
   - Net improvement: 18 issues resolved
   
   ### Projection
   - Target score (90): ~4 weeks at current pace
   - Critical issues zero date: Already achieved ✅
   ```

## Export Options

### Baseline Export (`--export-baseline`):

```json
{
  "version": "1.0",
  "timestamp": "2024-01-15T10:30:00Z",
  "tool": {
    "name": "Semgrep MCP",
    "accuracy": "high",
    "coverage": "comprehensive"
  },
  "project": {
    "path": "./src",
    "files_scanned": 156,
    "lines_of_code": 12453
  },
  "findings": {
    "total": 15,
    "by_severity": {
      "critical": 0,
      "high": 4,
      "medium": 8,
      "low": 3
    },
    "by_category": {
      "injection": 2,
      "authentication": 3,
      "xss": 4,
      "configuration": 6
    }
  },
  "compliance": {
    "owasp_top_10": {
      "A01": "pass",
      "A02": "fail",
      "A03": "partial"
    }
  },
  "security_score": 85
}
```

## Integration with CI/CD

This baseline can be integrated into CI/CD pipelines:

```yaml
# Example GitHub Actions
- name: Security Baseline Check
  run: |
    claude-code /security:baseline . --compare=.security-baseline.json
    if [ $? -ne 0 ]; then
      echo "Security regression detected!"
      exit 1
    fi
```

## Best Practices

1. **Regular Baselines**:
   - Run weekly or with each release
   - Track improvements over time
   - Set security score targets

2. **Baseline Storage**:
   - Commit baseline to repository
   - Track changes in version control
   - Use for release notes

3. **Team Communication**:
   - Share progress in standups
   - Celebrate improvements
   - Address regressions quickly

## Tool Quality Notes

- **With Semgrep MCP**: Professional-grade baseline with high accuracy
- **With Local Semgrep**: Good baseline quality, slightly slower
- **Pattern-Based**: Basic baseline, may miss complex issues

💡 **Tip**: For best results, install Semgrep MCP:
```bash
npm install -g @semgrep/mcp
```

This enables comprehensive security baselines with minimal false positives.