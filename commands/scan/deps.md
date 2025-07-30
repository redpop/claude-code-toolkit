---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(npm:*), Bash(pip:*), Bash(cargo:*)
description: In-depth dependency analysis with 6 specialized agents for complete transparency
argument-hint: [package-name|file] [--depth=direct|transitive|full] [--check=security|licenses|all]
---

**IMPORTANT: This is a READ-ONLY dependency analysis. Do NOT create, modify, or write any files. Only analyze and report dependency findings.**

# Dependency Trace Command

This command performs a comprehensive dependency analysis, with 6 specialized agents that examine different aspects of dependencies in parallel.

## Execution

**IMMEDIATELY START 6 PARALLEL DEPENDENCY AGENTS:**

1. **Direct Dependencies Agent**: Task(description="Analyze Direct Dependencies", prompt="Analyze direct dependencies for $ARGUMENTS. Examine: 1) Package.json, requirements.txt, go.mod, Cargo.toml dependencies, 2) Version constraints and ranges, 3) Dev vs Production dependencies, 4) Optional/Peer dependencies, 5) Local/File dependencies. Create complete list with version info. Return Direct Dependency Tree as JSON.", subagent_type="general-purpose")

2. **Transitive Dependencies Agent**: Task(description="Trace Transitive Dependencies", prompt="Trace transitive dependencies for $ARGUMENTS. Analyze: 1) Complete dependency chain, 2) Version conflicts/resolutions, 3) Duplicate packages (different versions), 4) Dependency depth (how deep the chain goes), 5) Total unique packages. Use lock files if available. Return complete dependency graph as JSON.", subagent_type="general-purpose")

3. **Security Vulnerabilities Agent**: Task(description="Security Dependency Scan", prompt="Scan dependencies for security issues for $ARGUMENTS. Check: 1) Known CVEs in dependencies, 2) Outdated packages with security fixes, 3) Packages with security advisories, 4) Unmaintained/Abandoned packages, 5) Packages with suspicious patterns. Use available security databases. Return vulnerabilities with severity as JSON.", subagent_type="general-purpose")

4. **License Compliance Agent**: Task(description="License Analysis", prompt="Analyze licenses of all dependencies for $ARGUMENTS. Examine: 1) License types (MIT, GPL, Apache, etc.), 2) License compatibility matrix, 3) Commercial use restrictions, 4) Attribution requirements, 5) Copyleft obligations. Identify problematic license combinations. Return license report as JSON.", subagent_type="general-purpose")

5. **Usage Analysis Agent**: Task(description="Dependency Usage Tracking", prompt="Analyze how dependencies are used in $ARGUMENTS. Find: 1) Import statements and require calls, 2) Actual usage vs declared dependencies, 3) Unused dependencies, 4) Missing dependencies (used but not declared), 5) Feature usage (which parts of the lib are used). Return usage report with recommendations as JSON.", subagent_type="general-purpose")

6. **Update Impact Agent**: Task(description="Update Impact Analysis", prompt="Evaluate update impact for dependencies in $ARGUMENTS. Analyze: 1) Available updates (Major/Minor/Patch), 2) Breaking changes in updates, 3) Migration effort estimation, 4) Update priority (Security/Features/Bugs), 5) Dependency update order. Check changelogs and release notes. Return update strategy as JSON.", subagent_type="general-purpose")

## Synthesis

After completion of all Dependency Agents:

1. **Create Dependency Health Score**:
   ```markdown
   # Dependency Analysis Report
   
   ## Health Score: B- (72/100)
   
   ### Breakdown
   - Security: C (65/100) - 3 high vulnerabilities
   - Maintenance: B (78/100) - 2 abandoned packages
   - License Risk: A (95/100) - All compatible
   - Update Status: C+ (68/100) - 40% outdated
   ```

2. **Visualize Dependency Graph**:
   ```mermaid
   graph LR
     App[Your App]
     App --> Express[express@4.18.2]
     App --> React[react@18.2.0]
     Express --> BodyParser[body-parser@1.20.1]
     Express --> Cookie[cookie@0.5.0]
     React --> ReactDOM[react-dom@18.2.0]
     
     style Express fill:#f9f,stroke:#333
     style React fill:#bbf,stroke:#333
   ```

3. **Generate Security Action Plan**:
   ```markdown
   ## Critical Security Updates Required
   
   ### High Priority (Fix within 24h)
   1. **lodash@4.17.20** → 4.17.21
      - CVE-2021-23337: Prototype Pollution
      - Used in: 15 places
      - Breaking changes: None
   
   ### Medium Priority (Fix this week)
   1. **axios@0.21.1** → 0.27.2
      - Multiple security fixes
      - Used in: API client
      - Breaking changes: Minor API changes
   ```

4. **Create License Compliance Report**:
   ```markdown
   ## License Summary
   
   ### License Distribution
   - MIT: 125 packages (78%)
   - Apache-2.0: 20 packages (13%)
   - ISC: 10 packages (6%)
   - GPL-3.0: 2 packages (1.3%) ⚠️
   - Other: 3 packages (1.7%)
   
   ### Compliance Issues
   ⚠️ GPL-3.0 packages require source disclosure:
   - package-xyz: Consider alternative
   - lib-abc: Required, need legal review
   ```

5. **Generate Optimization Recommendations**:
   ```markdown
   ## Dependency Optimization
   
   ### Remove Unused (Save 15MB)
   - moment.js → Use native Dates
   - lodash → Use ES6 methods
   - request → Use native fetch
   
   ### Consolidate Duplicates
   - 3 different UUID libraries → standardize
   - 2 date formatting libs → pick one
   
   ### Bundle Size Impact
   | Package | Size | Alternatives |
   |---------|------|--------------|
   | moment | 290KB | date-fns (12KB) |
   | lodash | 600KB | lodash-es (tree-shakeable) |
   ```

**Performance Expectation**: Complete dependency analysis in 5-7 seconds, compared to 35-45 seconds sequentially.

**Integration**: Can be integrated into CI/CD for automatic dependency monitoring.