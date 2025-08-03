---
description: Rapid incident response workflow for production issues with root cause analysis
argument-hint: <incident-description> [--severity=critical|high|medium] [--system=component]
---

# Incident Response Workflow

This command provides rapid incident response for production issues, coordinating multiple agents to diagnose, mitigate, and resolve problems quickly while maintaining a clear audit trail.

## Incident Response Phases

### 🚨 Phase 1: Immediate Assessment (0-5 minutes)

1. **Severity Classification**

   - Critical: Service down, data loss risk, security breach
   - High: Major functionality impaired, performance degraded >50%
   - Medium: Minor functionality affected, performance degraded <50%

2. **Impact Analysis**

   - Affected systems and components
   - User impact and scope
   - Business impact assessment

3. **Initial Diagnostics**
   - Error patterns and symptoms
   - Recent changes or deployments
   - System health metrics

### 🔍 Phase 2: Root Cause Analysis (5-15 minutes)

Parallel investigation by specialized agents:

1. **System Diagnostics** (@ops-engineer)

   - Log analysis
   - Metric anomalies
   - Resource utilization
   - Network issues

2. **Code Analysis** (@debugger)

   - Recent code changes
   - Error stack traces
   - Code path analysis
   - Bug identification

3. **Performance Analysis** (@performance-optimizer)

   - Bottleneck identification
   - Resource contention
   - Query performance
   - Load patterns

4. **Security Check** (@security-specialist)
   - Attack indicators
   - Vulnerability exploitation
   - Access anomalies
   - Data integrity

### 🛠️ Phase 3: Mitigation & Resolution (15-30 minutes)

1. **Immediate Mitigation**

   - Quick fixes and workarounds
   - Service restoration steps
   - Rollback procedures if needed

2. **Root Cause Fix**

   - Permanent solution implementation
   - Code patches
   - Configuration changes
   - Infrastructure adjustments

3. **Verification**
   - Service health checks
   - Performance validation
   - Security verification
   - User impact resolution

### 📋 Phase 4: Post-Incident (30+ minutes)

1. **Documentation**

   - Incident timeline
   - Root cause summary
   - Actions taken
   - Lessons learned

2. **Prevention**
   - Monitoring improvements
   - Alert tuning
   - Preventive measures
   - Process improvements

## Execution Flow

**Incident**: $ARGUMENTS

### Step 1: Immediate Assessment

Analyzing incident severity and impact...

Use Task tool with subagent_type="general-purpose" for rapid assessment:

**Prompt**: "URGENT: Analyze this production incident: $ARGUMENTS. Determine: 1) Severity level (critical/high/medium), 2) Affected systems and components, 3) User impact scope, 4) Most likely problem category (infrastructure/code/performance/security). Provide immediate mitigation suggestions. Return as JSON with priority actions."

### Step 2: Parallel Root Cause Investigation

Use Task tool with subagent_type="general-purpose" for system diagnostics:

**Prompt**: "Investigate system-level issues for incident: $ARGUMENTS. Check: 1) Recent deployment or config changes, 2) Resource utilization (CPU/memory/disk/network), 3) Error log patterns, 4) Service dependencies status, 5) Infrastructure anomalies. Focus on changes in last 24 hours."

Use Task tool with subagent_type="general-purpose" for code analysis:

**Prompt**: "Debug code-related issues for incident: $ARGUMENTS. Analyze: 1) Recent code commits and deployments, 2) Error stack traces and exceptions, 3) Code paths leading to errors, 4) Potential race conditions, 5) Data validation issues. Identify exact code locations if possible."

Use Task tool with subagent_type="general-purpose" for performance investigation:

**Prompt**: "Analyze performance aspects of incident: $ARGUMENTS. Examine: 1) Response time degradation, 2) Database query performance, 3) API call latencies, 4) Resource bottlenecks, 5) Load distribution issues. Compare with baseline metrics."

### Step 3: Resolution Implementation

Based on findings, implement appropriate fixes:

1. **If Infrastructure Issue**:

   - Scale resources
   - Restart services
   - Fix configurations
   - Update load balancing

2. **If Code Issue**:

   - Deploy hotfix
   - Revert problematic commit
   - Apply emergency patch
   - Update feature flags

3. **If Performance Issue**:

   - Optimize queries
   - Add caching
   - Adjust connection pools
   - Redistribute load

4. **If Security Issue**:
   - Block malicious IPs
   - Patch vulnerabilities
   - Rotate credentials
   - Enable additional monitoring

## Incident Report Template

```markdown
## Incident Report

**Time**: [Timestamp]
**Severity**: [Critical/High/Medium]
**Duration**: [X minutes]
**Status**: [Resolved/Mitigated/Ongoing]

### Summary

[Brief description of incident and impact]

### Timeline

- T+0: Initial detection
- T+X: Root cause identified
- T+Y: Mitigation applied
- T+Z: Full resolution

### Root Cause

[Detailed explanation of what caused the incident]

### Resolution

[Steps taken to resolve the issue]

### Impact

- Users affected: [Number/Percentage]
- Services impacted: [List]
- Data loss: [Yes/No]

### Action Items

1. [Preventive measure 1]
2. [Monitoring improvement 2]
3. [Process update 3]

### Lessons Learned

[Key takeaways for preventing similar incidents]
```

## Usage Examples

```bash
# Critical production outage
/prefix:flow:incident "Website returning 502 errors for all users" --severity=critical

# Performance degradation
/prefix:flow:incident "API response times increased 10x in last hour" --severity=high

# Partial service issue
/prefix:flow:incident "Payment processing failing for some users" --system=payments

# Security incident
/prefix:flow:incident "Unusual spike in failed login attempts" --severity=high
```

## Options

- `--severity`: Set incident severity level (critical/high/medium)
- `--system`: Specify affected system/component for focused analysis
