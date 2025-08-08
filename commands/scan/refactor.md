---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(ast-grep:*)
description: Analyzes the impact of refactoring changes using 6 specialized agents
argument-hint: [file-or-pattern] [--change-type=rename|move|signature|structure]
---

**IMPORTANT: This is a READ-ONLY impact analysis. Do NOT create, modify, or write any files. Only analyze and report refactoring impacts.**

# Refactor Impact Analysis Command

This command analyzes the impact of planned refactoring changes through 6 parallel working agents. Ideal before major code restructuring.

## Execution

**IMMEDIATELY START 6 PARALLEL IMPACT AGENTS:**

1. **Breaking Changes Agent**:

Use Task tool with subagent_type="general-purpose":
"Analyze potential Breaking Changes for refactoring in $ARGUMENTS. Identify: 1) Public API Changes, 2) Interface/Contract Modifications, 3) Signature Changes in exported Functions, 4) Removed/Renamed Public Members, 5) Changed Return Types. Use ast-grep or rg for precise analysis. Return all Breaking Changes with Severity as JSON."

2. **API Contract Agent**:

Use Task tool with subagent_type="general-purpose":
"Examine API Contract Changes in $ARGUMENTS. Check: 1) REST Endpoint Changes, 2) GraphQL Schema Modifications, 3) gRPC Service Definitions, 4) WebSocket Message Formats, 5) Event/Message Bus Contracts. Find all Consumers of these APIs. Return affected services and necessary adjustments as JSON."

3. **Test Impact Agent**:

Use Task tool with subagent_type="general-purpose":
"Evaluate test impacts for refactoring in $ARGUMENTS. Analyze: 1) Directly affected tests, 2) Integration tests that need adjustment, 3) Mocking/Stubbing Updates, 4) Test Data/Fixtures changes, 5) Performance Test Baselines. Return list of all affected tests with update strategy as JSON."

4. **Documentation Agent**:

Use Task tool with subagent_type="general-purpose":
"Identify necessary Documentation Updates for $ARGUMENTS. Check: 1) Code Comments/JSDoc, 2) README Files, 3) API Documentation, 4) Architecture Diagrams, 5) Usage Examples, 6) Migration Guides. Search for references to refactored code. Return all update locations as JSON."

5. **Migration Path Agent**:

Use Task tool with subagent_type="general-purpose":
"Develop Migration Strategy for refactoring in $ARGUMENTS. Plan: 1) Gradual Migration vs Big Bang, 2) Backward Compatibility Layer, 3) Feature Flags for rollout, 4) Deprecation Warnings, 5) Rollback Plan. Consider codebase size and team velocity. Return detailed Migration Steps as JSON."

6. **Risk Assessment Agent**:

Use Task tool with subagent_type="general-purpose":
"Conduct Risk Assessment for refactoring in $ARGUMENTS. Evaluate: 1) Code Complexity of the change, 2) Business Critical Paths affected, 3) Team Expertise Level, 4) Time Constraints, 5) Rollback Complexity. Calculate Overall Risk Score (1-10). Return Risk Matrix with Mitigation Strategies as JSON."

## Synthesis

After completion of all Impact Agents:

1. **Create Impact Summary**:

   - Total Files Affected
   - Breaking Changes Count
   - Test Updates Required
   - Documentation Changes
   - Estimated Migration Effort

2. **Generate Risk Matrix**:

   ```
   Risk Level | Impact Area | Mitigation
   -----------|-------------|------------
   HIGH       | Public API  | Versioning Strategy
   MEDIUM     | Tests       | Automated Updates
   LOW        | Docs        | Batch Updates
   ```

3. **Develop Refactoring Plan**:

   ```markdown
   # Refactoring Execution Plan

   ## Pre-Refactoring Checklist

   - [ ] Backup current state
   - [ ] Notify affected teams
   - [ ] Setup feature flags

   ## Phase 1: Preparation (Day 1)

   - Update deprecation warnings
   - Create compatibility layer
   - Prepare migration scripts

   ## Phase 2: Core Changes (Day 2-3)

   - Execute main refactoring
   - Run migration scripts
   - Update direct dependencies

   ## Phase 3: Propagation (Day 4-5)

   - Update consuming services
   - Migrate tests
   - Update documentation

   ## Phase 4: Cleanup (Day 6)

   - Remove compatibility layer
   - Delete deprecated code
   - Final testing

   ## Rollback Plan

   [Detailed rollback steps]
   ```

4. **Create Affected Teams Matrix**:

   ```markdown
   | Team | Components | Action Required | Timeline |
   | ---- | ---------- | --------------- | -------- |
   | API  | Gateway    | Update routes   | Day 2    |
   | UI   | Dashboard  | New SDK version | Day 3    |
   ```

5. **Generate Automated Migration Scripts**:
   - Code transformation scripts
   - Test update scripts
   - Documentation update templates

**Performance Expectation**: Impact analysis in 4-6 seconds, compared to 30-40 seconds sequentially.

**Best Practice**: Run this analysis BEFORE starting a major refactoring to avoid surprises.
