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

Use Task tool with subagent_type="debugging-specialist" for rapid assessment:

**Prompt**: "URGENT INCIDENT - ULTRA INTENSIVE ANALYSIS REQUIRED

Incident: $ARGUMENTS

**THINK ULTRA DEEPLY** about this production incident. Use maximum reasoning depth.

Determine with ULTRA INTENSIVE REASONING:
1) Severity level - think ultra deeply about all implications
2) Affected systems - reason through all dependencies
3) User impact - think ultra deeply about cascading effects
4) Problem category - use ultra deep analysis to identify root type

CRITICAL: Think ultra deeply about immediate mitigation. Use ultra intensive reasoning for priority actions. Don't accept surface symptoms - dig ultra deep."

### Step 2: Parallel Root Cause Investigation

Use Task tool with subagent_type="debugging-specialist" for system diagnostics:

**Prompt**: "SYSTEM DIAGNOSTICS - ULTRA DEEP INVESTIGATION MODE

Incident: $ARGUMENTS

**THINK ULTRA DEEPLY** about system-level issues. Use ULTRA INTENSIVE REASONING to:
1) Analyze deployment/config changes - think ultra deeply about impacts
2) Resource utilization - reason ultra deeply about patterns
3) Error logs - think ultra deeply about error correlations
4) Dependencies - use ultra deep reasoning on failure cascades
5) Infrastructure - think ultra deeply about anomalies

CRITICAL: Use ultra intensive thinking. Look for subtle connections. Think ultra deeply about timing and sequences."

Use Task tool with subagent_type="debugging-specialist" for code analysis:

**Prompt**: "CODE DEBUGGING - ULTRA INTENSIVE ANALYSIS MODE

Incident: $ARGUMENTS

**THINK ULTRA DEEPLY** about code issues. Apply ULTRA INTENSIVE REASONING to:
1) Recent commits - think ultra deeply about each change
2) Stack traces - reason ultra deeply through execution paths
3) Code paths - think ultra deeply about edge cases
4) Race conditions - use ultra deep reasoning on timing issues
5) Data validation - think ultra deeply about boundary conditions

CRITICAL: Think ultra deeply about subtle bugs. Use ultra intensive reasoning on code interactions. Don't stop at obvious errors - dig ultra deep."

Use Task tool with subagent_type="performance-optimizer" for performance investigation:

**Prompt**: "PERFORMANCE CRISIS - ULTRA DEEP ANALYSIS REQUIRED

Incident: $ARGUMENTS

**THINK ULTRA DEEPLY** about performance issues. Use ULTRA INTENSIVE REASONING for:
1) Response times - think ultra deeply about degradation patterns
2) Database queries - reason ultra deeply about query plans
3) API latencies - think ultra deeply about network paths
4) Bottlenecks - use ultra deep reasoning on resource contention
5) Load distribution - think ultra deeply about imbalances

CRITICAL: Think ultra deeply about compound effects. Use ultra intensive reasoning on performance cascades. Dig ultra deep into root causes."

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
