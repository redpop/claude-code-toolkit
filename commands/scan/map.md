---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(tree:*), Bash(cloc:*)
description: Creates a comprehensive codebase mapping with 10 agents for different aspects
argument-hint: [directory] [--format=markdown|json|mermaid] [--depth=overview|detailed|full]
---

**IMPORTANT: This is a READ-ONLY mapping command. Do NOT create, modify, or write any files. Only analyze and generate a codebase map.**

# Codebase Mapping Command

This command creates a comprehensive mapping of the entire codebase with 10 specialized agents that analyze different aspects in parallel.

## Execution

**IMMEDIATELY START 10 PARALLEL MAPPING AGENTS:**

1. **Structure Overview Agent**: Task(description="Map Directory Structure", prompt="Create an overview of the directory structure of $ARGUMENTS. Analyze: 1) Main directories and their purpose, 2) File Organization Patterns, 3) Naming Conventions, 4) Module Boundaries, 5) Hidden/Config Directories. Use tree and fd for the analysis. Return hierarchical structure with annotations as JSON.", subagent_type="general-purpose")

2. **Technology Stack Agent**: Task(description="Identify Tech Stack", prompt="Identify the complete technology stack in $ARGUMENTS. Analyze: 1) Programming Languages (with version hints), 2) Frameworks and Libraries, 3) Build Tools and Package Managers, 4) Testing Frameworks, 5) Development Tools. Examine config files, dependencies, and imports. Return Tech Stack Matrix as JSON.", subagent_type="general-purpose")

3. **Entry Points Agent**: Task(description="Find Entry Points", prompt="Locate all entry points in $ARGUMENTS. Search for: 1) Main Functions/Files, 2) CLI Entry Points, 3) API Endpoints, 4) Web Server Routes, 5) Background Job Handlers, 6) Event Listeners. Use pattern matching for various frameworks. Return Entry Point Map as JSON.", subagent_type="general-purpose")

4. **Core Components Agent**: Task(description="Identify Core Components", prompt="Identify Core Business Logic Components in $ARGUMENTS. Analyze: 1) Domain Models/Entities, 2) Services/Use Cases, 3) Controllers/Handlers, 4) Data Access Layer, 5) Utility Modules. Focus on central business logic. Return Component Architecture as JSON.", subagent_type="general-purpose")

5. **Data Flow Agent**: Task(description="Map Data Flow", prompt="Analyze Data Flow Patterns in $ARGUMENTS. Examine: 1) Input Sources (APIs, Files, DBs), 2) Data Transformations, 3) Storage Locations, 4) Output Destinations, 5) Cache Layers. Trace typical data journeys. Return Data Flow Diagram as JSON/Mermaid.", subagent_type="general-purpose")

6. **Configuration Agent**: Task(description="Configuration Analysis", prompt="Map all configuration aspects in $ARGUMENTS. Find: 1) Config Files and Formats, 2) Environment Variables, 3) Feature Flags, 4) Build Configurations, 5) Deployment Configs. Analyze config hierarchy and overrides. Return Configuration Map as JSON.", subagent_type="general-purpose")

7. **External Dependencies Agent**: Task(description="Map External Dependencies", prompt="Map all external dependencies in $ARGUMENTS. Analyze: 1) Third-party Libraries (with versions), 2) External APIs/Services, 3) Database Connections, 4) Message Queues, 5) Cloud Services. Check transitive dependencies as well. Return Dependency Graph as JSON.", subagent_type="general-purpose")

8. **Test Architecture Agent**: Task(description="Test Structure Mapping", prompt="Map the test architecture in $ARGUMENTS. Examine: 1) Test File Organization, 2) Unit vs Integration vs E2E Tests, 3) Test Utilities/Helpers, 4) Mock/Stub Structure, 5) Test Data/Fixtures. Analyze test coverage distribution. Return Test Architecture Map as JSON.", subagent_type="general-purpose")

9. **Build & Deploy Agent**: Task(description="Build Pipeline Analysis", prompt="Analyze build and deployment setup in $ARGUMENTS. Examine: 1) Build Scripts/Commands, 2) CI/CD Configurations, 3) Docker/Container Setup, 4) Deployment Targets, 5) Release Processes. Focus on automation. Return Build/Deploy Pipeline as JSON.", subagent_type="general-purpose")

10. **Code Metrics Agent**: Task(description="Calculate Code Metrics", prompt="Calculate code metrics for $ARGUMENTS. Analyze: 1) Lines of Code per Language, 2) File/Function Counts, 3) Complexity Metrics, 4) Code Duplication Ratio, 5) Comment Density. Use cloc and custom analysis. Return Metrics Dashboard as JSON.", subagent_type="general-purpose")

## Synthesis

After completion of all mapping agents:

1. **Create Visual Codebase Map**:

   ```mermaid
   graph TB
     subgraph "Frontend"
       UI[UI Components]
       State[State Management]
       Routes[Routing]
     end

     subgraph "Backend"
       API[API Layer]
       BL[Business Logic]
       DAL[Data Access]
     end

     subgraph "Infrastructure"
       DB[(Database)]
       Cache[(Redis)]
       Queue[Message Queue]
     end

     UI --> API
     API --> BL
     BL --> DAL
     DAL --> DB
     BL --> Cache
     BL --> Queue
   ```

2. **Generate Codebase Overview**:

   ```markdown
   # Codebase Map: [Project Name]

   ## Quick Stats

   - Total Files: X,XXX
   - Lines of Code: XXX,XXX
   - Primary Language: TypeScript (65%)
   - Test Coverage: 78%
   - Dependencies: 142

   ## Architecture Overview

   [High-level architecture description]

   ## Key Components

   1. **Frontend (React + Redux)**

      - Location: `/src/client`
      - Entry: `src/client/index.tsx`
      - 45k LOC, 234 components

   2. **API Server (Node.js + Express)**
      - Location: `/src/server`
      - Entry: `src/server/app.ts`
      - 23k LOC, 89 endpoints
   ```

3. **Create Developer Onboarding Guide**:

   ```markdown
   ## Developer Quick Start

   ### 1. Understanding the Structure

   - Start with: `src/server/app.ts` (main entry)
   - Core logic in: `src/core/`
   - API routes: `src/server/routes/`

   ### 2. Key Patterns

   - Dependency Injection via `src/core/container`
   - Event-driven via `src/events/`
   - Repository pattern in `src/data/`

   ### 3. Development Workflow

   1. Install: `npm install`
   2. Dev mode: `npm run dev`
   3. Tests: `npm test`
   4. Build: `npm run build`
   ```

4. **Generate Interactive Documentation**:

   - Clickable component map
   - Dependency explorer
   - Code navigation guide
   - Architecture decision records

5. **Create Maintenance Dashboard**:

   ```markdown
   ## Maintenance Priorities

   ### Technical Debt Hotspots

   1. Legacy API v1 (`/src/api/v1/`) - 40% of bugs
   2. User Service (`/src/services/user/`) - High complexity
   3. Database migrations - 15 pending

   ### Refactoring Opportunities

   - Extract shared components (12 duplicates found)
   - Consolidate error handling (5 different patterns)
   - Update deprecated dependencies (8 packages)
   ```

**Performance Expectation**: Complete codebase map in 6-8 seconds, compared to 60+ seconds sequentially.

**Output Formats**: Markdown for documentation, JSON for tools, Mermaid for visualization.
