# Claude Code Toolkit

The complete toolkit for extending Claude Code with commands, agents, and tools. A comprehensive collection of slash commands, AI agents, and utilities that can be installed in `~/.claude/` with a custom prefix.

## 🚀 Quick Start: Transform Your Code Quality

### Recommended 3-Step Workflow for Project Optimization

```bash
# Step 1: Deep analysis with automatic report generation
/prefix:scan:deep . --export-json
# Creates: analysis-YYYYMMDD-HHMMSS.json

# Step 2: Generate action plan from latest report
/prefix:scan:report --latest --generate-action-plan
# Creates: action-plan-YYYYMMDD-HHMMSS.md

# Step 3: Execute the improvements
/prefix:auto:execute --latest
```

### Alternative Quick Workflows

**2-Step Quick Check:**

```bash
/prefix:scan:quick . --export-json    # Fast scan
/prefix:fix:quick-wins --latest       # Apply immediate fixes
```

**One-Command Pipeline:**

```bash
/prefix:meta:pipelines deep-quality    # Complete quality improvement
```

### 💡 Pro Tips

- `--export-json` without filename → Auto-generates timestamped files
- `--latest` → Automatically finds the most recent report
- Commands can be chained: `/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"`

**[See Full Workflow Guide →](docs/guides/MODERN-WORKFLOW.md)**

## Installation

### Step 1: Clone the Repository

```bash
# Clone the official repository
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit

# Or clone your fork
git clone https://github.com/YourUsername/your-fork.git
cd your-fork
```

### Step 2: Install with Your Prefix

```bash
# Install with your chosen prefix (e.g., "myprefix", "global", etc.)
./install.sh myprefix
```

The installation script will:

- Copy command files to `~/.claude/commands/myprefix/`
- Install AI agents to `~/.claude/agents/`
- Display all available commands and agents after installation
- Create backups of existing installations if needed

## Forking This Repository

Forking this repository allows you to:

- Create and maintain your own custom commands
- Share team-specific tools and workflows
- Contribute back improvements to the original repository
- Customize command behaviors for your specific needs

### Step-by-Step Forking Instructions

1. **Fork on GitHub**

   - Visit the [original repository](https://github.com/redpop/claude-code-toolkit)
   - Click the "Fork" button in the top right
   - Choose your account/organization as the destination

2. **Clone and Install Your Fork**

   ```bash
   # Clone your fork
   git clone https://github.com/YourUsername/your-fork.git
   cd your-fork

   # Install with your chosen prefix
   ./install.sh myprefix
   ```

3. **Verify Installation**

   ```bash
   # Check that commands are installed
   ls ~/.claude/commands/myprefix/

   # Check that agents are installed
   ls ~/.claude/agents/
   ```

### Benefits of Forking

- **Custom Commands**: Add proprietary or project-specific commands without affecting the original repository
- **Team Collaboration**: Share standardized workflows across your organization
- **Experimentation**: Test new command ideas before contributing upstream
- **Version Control**: Maintain your own release cycle and versioning

## Custom Prefix Support

You can install multiple command sets with different prefixes:

```bash
# Install the original toolkit
git clone https://github.com/redpop/claude-code-toolkit.git toolkit-original
cd toolkit-original
./install.sh global

# Install your team's fork
cd ..
git clone https://github.com/YourTeam/team-commands.git toolkit-team
cd toolkit-team
./install.sh team
```

This allows you to have both the original commands and your fork's commands available simultaneously:

## Usage

After installation, all commands are available with your chosen prefix:

```
# Original repository commands
/global:git:commit
/global:ai:handoff
/global:project:changelog

# Fork-specific commands
/team:deploy:staging
/team:testing:integration
/team:internal:setup
```

## Updates

To update your installation:

```bash
# 1. Pull the latest changes in your cloned repository
cd /path/to/claude-code-toolkit
git pull

# 2. Re-run the installation
./install.sh myprefix
```

The installation script will:

- Back up your existing installation (if you choose to)
- Copy the latest versions of all commands and agents
- Display the updated command list

## Command Categories

Commands are organized into logical categories for different workflows:

### 🔍 **Scan** - Analysis & Investigation

Deep code analysis, quality metrics, dependency tracing, and comprehensive scanning

### 🔧 **Fix** - Direct Corrections

Automated fixes for security issues, performance problems, code duplication, and documentation

### 🏭 **Gen** - Code & Documentation Generation

Generate tests, documentation, configurations, and other project artifacts

### 🌊 **Flow** - Multi-Agent Workflows

Intelligent problem routing, parallel analysis, and coordinated multi-agent operations

### 🤖 **Auto** - Automation & Orchestration

Sprint planning, continuous monitoring, and automated execution of improvement plans

### 🔒 **Sec** - Security Operations

Security audits, compliance checking, and vulnerability management

### 🗂️ **Git** - Version Control

Enhanced git operations with intelligent commit messages and workflow integration

### 🎯 **Meta** - Project & Toolkit Management

Project health checks, command chaining, export management, and toolkit utilities

## Available Commands

All commands require your chosen prefix (e.g., `myprefix`). Commands follow a consistent pattern: `/prefix:category:command`

<!-- COMMANDS:START - DO NOT EDIT -->

### Auto Commands

| Command                | Description                                                                                                    | Options                                                                                                                                                                                                                                                                  |
| ---------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `/prefix:auto:execute` | Execute action plans systematically with progress tracking and smart error handling                            | `<action-plan.md>\|--latest`, `--mode=supervised\|auto`, `--dry-run`, `--parallel=N`, `--focus=category`, `--force-all`, `--min-roi=threshold`, `--max-roi=threshold`                                                                                                    |
| `/prefix:auto:monitor` | Set up and manage continuous code quality monitoring with automated analysis, fixes, and reporting             | `directory`, `--schedule=daily\|weekly\|commit`, `--auto-fix=safe\|all\|none`, `--notify=email\|slack\|github`, `--init`                                                                                                                                                 |
| `/prefix:auto:report`  | Generate comprehensive completion report after action plan execution, showing results, metrics, and next steps | `--action-plan=<file>`, `--execution-log=<file>`, `--compare-baseline`, `--baseline=<file>`, `--current=<file>`, `--export-formats=md,json,html`, `--export-all`, `--export-json=<file>`, `--include-metrics`, `--include-git-log`, `--team-report`, `--recommendations` |
| `/prefix:auto:sprint`  | Plan and execute a complete code quality improvement sprint with analysis, prioritization, fixes, and tracking | `directory`, `--duration=1w\|2w\|1m`, `--team-size=N`, `--focus=security\|performance\|quality\|all`                                                                                                                                                                     |

### Fix Commands

| Command                     | Description                                                                                                           | Options                                                                                                                         |
| --------------------------- | --------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `/prefix:fix:documentation` | Fix documentation issues including broken links, parameter mismatches, missing cross-references, and outdated content | `report.json\|directory`, `--fix-links`, `--fix-params`, `--add-deprecation`, `--dry-run`, `--interactive`                      |
| `/prefix:fix:duplicates`    | Remove code duplication by extracting common functions, creating shared utilities, and applying DRY principles        | `report.json\|directory`, `--threshold=80`, `--min-lines=5`, `--dry-run`, `--create-utils`, `--group-by`, `--preserve-comments` |
| `/prefix:fix:performance`   | Automated performance issue fixes including O(n²) algorithms, memory optimization, and database batching              | `--target=algorithm\|memory\|database\|all`, `--file=path`, `--dry-run`                                                         |
| `/prefix:fix:quick-wins`    | Apply high-ROI fixes from analysis reports - quick wins with maximum impact and minimal effort                        | `report.json`, `--dry-run`, `--category=security\|performance\|quality`, `--max-effort=4h`, `--min-roi=5`                       |
| `/prefix:fix:security`      | Fix security vulnerabilities with MCP-enhanced analysis or traditional pattern matching                               | `report.json`, `--severity=critical,high,medium`, `--dry-run`, `--interactive`, `--owasp-top10`                                 |
| `/prefix:fix:shell`         | Automatically fix shell script issues using shellcheck analysis                                                       | `path/file`, `--check-only`, `--strict`, `--summary-only`                                                                       |

### Flow Commands

| Command                   | Description                                                                            | Options                                                                                                   |
| ------------------------- | -------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `/prefix:flow:debug-mode` | Switch to intensive debugging mode for current problem                                 | `--verbose`, `--trace`                                                                                    |
| `/prefix:flow:incident`   | Rapid incident response workflow for production issues with root cause analysis        | `<incident-description>`, `--severity=critical\|high\|medium`, `--system=component`                       |
| `/prefix:flow:refactor`   | Intelligent refactoring suggestions with impact analysis and step-by-step guidance     | `<file-or-pattern>`, `--type=extract\|rename\|restructure`, `--safety=conservative\|balanced\|aggressive` |
| `/prefix:flow:review`     | Comprehensive code review using multiple specialized agents for different perspectives | `<file-or-directory>`, `--focus=security\|performance\|architecture\|all`                                 |
| `/prefix:flow:smart`      | Intelligently analyze and route problems to the most appropriate specialized agents    | `<problem-description>`, `--verbose`, `--suggest-only`                                                    |

### Gen Commands

| Command              | Description                                                                                                     | Options                                                                                                                    |
| -------------------- | --------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `/prefix:gen:docs`   | Generate comprehensive documentation including API docs, README files, code comments, and architecture diagrams | `directory\|file`, `--types=api,readme,comments,diagrams`, `--format=markdown,html`, `--update-existing`                   |
| `/prefix:gen:format` | Create or convert content into various formats (HTML, Markdown, Confluence, Plain Text)                         | `<request-or-file>`, `--html\|--html-simple\|--markdown\|--confluence\|--text`                                             |
| `/prefix:gen:tests`  | Generate comprehensive test suites for uncovered code, including unit tests, integration tests, and edge cases  | `report.json\|file\|directory`, `--coverage-target=80`, `--framework=auto`, `--types=unit,integration`, `--mock-externals` |

### Git Commands

| Command              | Description                                                               | Options                           |
| -------------------- | ------------------------------------------------------------------------- | --------------------------------- |
| `/prefix:git:commit` | Creates structured Git commits with Conventional Commit format and emojis | `--no-verify`, `--fast`, `--push` |

### Meta Commands

| Command                        | Description                                                                                               | Options                                                                                                                          |
| ------------------------------ | --------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `/prefix:meta:analyze-toolkit` | Analyze toolkit commands and agents for redundancies, inconsistencies, and refactoring opportunities      | `--fix`, `--export-json`, `--export-md`, `--focus=<area>`                                                                        |
| `/prefix:meta:chain`           | Chain commands or execute pre-defined pipelines with intelligent data flow                                | `<pipeline-name`, `\|`, `command-chain>`, `--list`, `--save-as=name`, `--dry-run`                                                |
| `/prefix:meta:changelog`       | AI-powered CHANGELOG.md management that automatically determines version based on changes                 | `--analyze`, `--commit`, `--push`, `--update-version`                                                                            |
| `/prefix:meta:create`          | Intelligently create commands, agents, or workflows from your description                                 | `<what`, `you`, `need>`, `--type=auto\|command\|agent\|workflow`                                                                 |
| `/prefix:meta:export`          | Unified export management for all analysis results with format conversion                                 | `<report-files...>`, `--format=md\|json\|html\|pdf`, `--merge`, `--template=name`                                                |
| `/prefix:meta:find-cmd`        | Find the best command for your task from all available commands (global and local)                        | `<task-description>`, `--all`, `--local-only`, `--global-only`                                                                   |
| `/prefix:meta:handoff`         | Documents current problem context for handoff to another AI assistant                                     | `output-file`, `-c\|--compact`, `-t\|--technical`, `--focus`, `topic`, `--skip`, `topic`, `--include`, `topic`, `"instructions"` |
| `/prefix:meta:health`          | Comprehensive project health check with actionable insights and trend analysis                            | `--verbose`, `--compare=last-check.json`, `--export`                                                                             |
| `/prefix:meta:summary`         | Creates a chat summary for another AI with complete context                                               | `summaries/`                                                                                                                     |
| `/prefix:meta:test-guide`      | Generates interactive test guides for recent changes, suitable for both end-users and technical reviewers | `--type=all\|user\|technical`, `--format=md\|checklist\|jira`, `--lang=en\|de\|es\|fr`, `--output=file.md`                       |
| `/prefix:meta:update-docs`     | Intelligently updates project documentation based on code changes and implementation status               | `--scope=<type>`, `--analyze`, `--commit`                                                                                        |
| `/prefix:meta:version`         | Check installed toolkit version and available updates                                                     | `check\|update`                                                                                                                  |

### Scan Commands

| Command                   | Description                                                                                                            | Options                                                                                                                                            |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `/prefix:scan:deep`       | Deep code analysis with streamlined output and clear workflow guidance                                                 | `<directory>`, `--focus=security\|performance\|architecture\|all`, `--export-md`, `--export-json`                                                  |
| `/prefix:scan:deps`       | In-depth dependency analysis with 6 specialized agents for complete transparency                                       | `package-name\|file`, `--depth=direct\|transitive\|full`, `--check=security\|licenses\|all`                                                        |
| `/prefix:scan:docs`       | Analyze documentation health, validate code-doc synchronization, check cross-references, and identify outdated content | `directory`, `--scope=readme\|api\|all`, `--check-links`, `--validate-params`, `--export-report`                                                   |
| `/prefix:scan:explore`    | Multi-Perspective Deep Research with 8 different viewpoints on a topic                                                 | `topic`, `--depth=surface\|medium\|deep`, `--focus=technical\|business\|all`                                                                       |
| `/prefix:scan:map`        | Creates a comprehensive codebase mapping with 10 agents for different aspects                                          | `directory`, `--format=markdown\|json\|mermaid`, `--depth=overview\|detailed\|full`                                                                |
| `/prefix:scan:perf`       | Deep Performance Profiling with 7 Agents for Bottleneck Identification and Optimization                                | `directory`, `--profile=cpu\|memory\|io\|all`, `--export-md`, `--export-json`, `--export-html`, `--export-all`, `--export-dir=path`                |
| `/prefix:scan:quality`    | Comprehensive code quality metrics with trend analysis and improvement roadmap                                         | `<directory>`, `--baseline=previous.json`, `--threshold=80`, `--export`                                                                            |
| `/prefix:scan:quick`      | Quick parallel code analysis for rapid feedback (30 seconds)                                                           | `<directory>`, `--focus=area`, `--export-json`                                                                                                     |
| `/prefix:scan:refactor`   | Analyzes the impact of refactoring changes using 6 specialized agents                                                  | `file-or-pattern`, `--change-type=rename\|move\|signature\|structure`                                                                              |
| `/prefix:scan:report`     | Intelligent analysis of code quality reports with trend detection, prioritization, and actionable insights             | `report.json`, `--latest`, `--compare=other-report.json`, `--history`, `--trends`, `--quick-wins`, `--export-md`, `--generate-action-plan`         |
| `/prefix:scan:root-cause` | Deep root cause analysis with ultra intensive reasoning                                                                | `issue_description`                                                                                                                                |
| `/prefix:scan:tests`      | Comprehensive test coverage analysis with 5 specialized agents for test quality                                        | `directory`, `--framework=jest\|pytest\|go-test\|cargo-test`, `--export-md`, `--export-json`, `--export-html`, `--export-all`, `--export-dir=path` |

### Sec Commands

| Command                | Description                                                                             | Options                                                                                                                             |
| ---------------------- | --------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `/prefix:sec:audit`    | Comprehensive security audit with MCP-enhanced scanning or traditional fallback methods | `directory`, `--severity=critical\|high\|all`, `--export-md`, `--export-json`, `--export-html`, `--export-all`, `--export-dir=path` |
| `/prefix:sec:baseline` | Establish and track security baseline with MCP-enhanced scanning or traditional methods | `directory`, `--export-baseline`, `--compare=previous-baseline.json`, `--track-improvements`                                        |
| `/prefix:sec:comply`   | Run compliance checks for OWASP, PCI-DSS, GDPR, and custom security policies            | `directory`, `--standard=owasp\|pci-dss\|gdpr\|all`, `--custom-rules=rules.yaml`, `--export-report`                                 |

### Typo3 Commands

| Command                               | Description                                                                | Options                                                                                            |
| ------------------------------------- | -------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `/prefix:typo3:content-blocks`        | Generate TYPO3 Content Blocks v1.3 with modern field configurations        | `name`, `--type=element\|page`, `--fields=...`, `--sitepackage=path`                               |
| `/prefix:typo3:extension-kickstarter` | Create TYPO3 extensions using ext-kickstarter or manual scaffolding        | `extension-key`, `--type=...`, `--use-kickstarter`, `--composer-name=...`                          |
| `/prefix:typo3:fluid-components`      | Generate Fluid v4 Components for TYPO3 v13 with Atomic Design patterns     | `component-name`, `--type=atom\|molecule\|organism`, `--sitepackage=path`                          |
| `/prefix:typo3:make-content-block`    | Wrapper for TYPO3 make:content-block command with intelligent defaults     | `--vendor=...`, `--type=...`, `--skeleton-path=...`, `--config-path=...`                           |
| `/prefix:typo3:sitepackage`           | Create a TYPO3 v13.4 SitePackage based on official template with Site Sets | `vendor`, `package-name`, `--include-ddev`, `--include-docker`, `--author=name`, `--email=address` |

<!-- COMMANDS:END -->

## Sub-Agents

### Introduction to Sub-Agents

The Sub-Agents feature introduces a powerful new paradigm for complex code analysis and operations. By leveraging Claude's Task Tool capability to spawn multiple specialized AI agents, these commands can perform parallel analysis, cross-reference findings, and deliver comprehensive insights that would be impossible with sequential processing.

Each sub-agent operates independently with its own specialized focus area, then contributes its findings to a coordinated final report. This approach enables:

- **10x faster analysis** through parallel processing
- **Deeper insights** from specialized perspectives
- **Cross-validation** of findings between agents
- **Comprehensive coverage** of complex codebases

### Available Specialized Sub-Agents

Our sub-agent system includes seven core specialists that can be combined in various ways:

#### 1. Security Specialist 🔒

- **Expertise**: Vulnerability detection, authentication flows, encryption practices
- **Focus Areas**: SQL injection, XSS, CSRF, authentication bypasses, cryptographic weaknesses
- **Output**: Security risk matrix, vulnerability reports, remediation recommendations

#### 2. Performance Optimizer ⚡

- **Expertise**: Algorithm complexity, memory management, query optimization
- **Focus Areas**: O(n) analysis, memory leaks, database bottlenecks, caching opportunities
- **Output**: Performance hotspots, optimization strategies, benchmark comparisons

#### 3. Test Engineer 🧪

- **Expertise**: Test coverage analysis, edge case identification, test quality assessment
- **Focus Areas**: Missing tests, flaky tests, test pyramid analysis, mock usage
- **Output**: Coverage reports, test improvement plans, edge case scenarios

#### 4. Code Architect 🏗️

- **Expertise**: Design patterns, architectural principles, dependency management
- **Focus Areas**: SOLID violations, coupling analysis, modularity assessment, API design
- **Output**: Architecture diagrams, refactoring roadmaps, design pattern recommendations

#### 5. Refactoring Expert 🔧

- **Expertise**: Code smells, technical debt, maintainability improvements
- **Focus Areas**: Duplicate code, complex methods, naming conventions, dead code
- **Output**: Refactoring priorities, code quality metrics, improvement strategies

#### 6. Documentation Health Specialist 📚

- **Expertise**: Documentation quality, code-doc synchronization, technical writing best practices
- **Focus Areas**: Parameter validation, cross-reference checking, deprecation tracking, coverage analysis
- **Output**: Health scores, broken link reports, parameter mismatches, improvement recommendations

#### 7. Report Analyzer 📊

- **Expertise**: Code quality report analysis, trend detection, prioritization strategies
- **Focus Areas**: ROI analysis, quick wins identification, historical comparisons, sprint planning
- **Output**: Prioritized action items, trend reports, implementation roadmaps

### Hybrid Commands: Task Tool + Sub-Agents

The true power of sub-agents emerges in hybrid commands that orchestrate multiple specialists for comprehensive analysis:

#### Orchestration Commands

- **`/prefix:orchestration:analyze-parallel`**: Deploys 10 parallel agents for ultra-fast code analysis
- **`/prefix:orchestration:security-audit`**: 8 security-focused agents for comprehensive vulnerability scanning
- **`/prefix:orchestration:performance-scan`**: 7 agents profiling different performance aspects
- **`/prefix:orchestration:test-coverage`**: 5 agents analyzing test quality from multiple angles
- **`/prefix:orchestration:refactor-impact`**: 6 agents assessing refactoring risks and benefits

#### Research Commands

- **`/prefix:research:deep-dive`**: 8 agents providing different perspectives on technical topics
- **`/prefix:research:codebase-map`**: 10 agents creating comprehensive codebase documentation
- **`/prefix:research:dependency-trace`**: 6 agents analyzing dependency chains and impacts

### Example: Using the analyze-deep Hybrid Command

The `analyze-parallel` command demonstrates the power of orchestrated sub-agents:

```bash
# Analyze a complex module with 10 parallel agents
/myprefix:orchestration:analyze-parallel src/core --focus=security

# Output structure:
📊 PARALLEL ANALYSIS REPORT
========================

🔒 Security Agent Findings:
- Critical: Unvalidated user input in auth.js:142
- High: Missing CSRF protection in api/endpoints.js
- Medium: Weak password hashing algorithm

⚡ Performance Agent Findings:
- Bottleneck: O(n²) algorithm in data-processor.js
- Memory leak: Unclosed database connections
- Optimization: Cache opportunity for repeated API calls

🏗️ Architecture Agent Findings:
- SOLID Violation: Single Responsibility in UserService
- High Coupling: Direct database access in controllers
- Missing abstraction layer for external APIs

[... 7 more agent reports ...]

🎯 CONSOLIDATED RECOMMENDATIONS:
1. Immediate: Fix security vulnerabilities (2 critical, 5 high)
2. Short-term: Implement caching layer (30% performance gain)
3. Long-term: Refactor to hexagonal architecture
```

### Benefits of Sub-Agent Architecture

1. **Parallel Processing**: Multiple agents work simultaneously, reducing analysis time from hours to minutes
2. **Specialized Expertise**: Each agent brings deep knowledge in its domain
3. **Comprehensive Coverage**: No aspect is overlooked when multiple specialists collaborate
4. **Cross-Validation**: Agents can verify and enhance each other's findings
5. **Scalability**: Easy to add new specialist agents or create custom combinations

### Creating Custom Sub-Agent Commands

You can create your own sub-agent orchestrations using the provided templates:

```bash
# Use the analysis template for code analysis scenarios
/myprefix:project:create-command "Create a sub-agent command that analyzes API endpoints for REST best practices"

# Use the research template for information gathering
/myprefix:project:create-command "Create a research command that investigates modern authentication methods"
```

The sub-agent system represents a paradigm shift in how AI assistants approach complex software engineering tasks, enabling unprecedented depth and speed of analysis.

## Maintaining Your Fork

Keeping your fork up-to-date and contributing back to the community ensures everyone benefits from improvements.

### Syncing with Upstream

1. **Add the upstream remote** (one-time setup)

   ```bash
   cd /path/to/your/fork
   git remote add upstream https://github.com/redpop/claude-code-toolkit.git
   git remote -v  # Verify remotes
   ```

2. **Fetch and merge upstream changes**

   ```bash
   # Fetch upstream changes
   git fetch upstream

   # Merge into your main branch
   git checkout main
   git merge upstream/main

   # Push to your fork
   git push origin main
   ```

3. **Update your installations**
   ```bash
   # Update each installation
   cd ~/.claude/commands/myprefix
   git pull
   ```

### Contributing Back to Upstream

When you've created a useful command that could benefit the community:

1. **Ensure your command is general-purpose**

   - Remove any company-specific or proprietary logic
   - Use clear, descriptive naming
   - Include comprehensive documentation

2. **Create a feature branch**

   ```bash
   git checkout -b feature/new-command
   git add commands/category/new-command.md
   git commit -m "✨ feat: add new-command for X functionality"
   git push origin feature/new-command
   ```

3. **Submit a pull request**
   - Visit your fork on GitHub
   - Click "Compare & pull request"
   - Describe your command and its use cases
   - Reference any related issues

### Best Practices for Fork Management

1. **Organize Custom Commands**

   ```
   commands/
   ├── team/           # Team-specific commands
   ├── project/        # Project-specific commands
   ├── internal/       # Internal tools
   └── experimental/   # Commands under development
   ```

2. **Document Your Commands**

   - Always include frontmatter with `description` and `argument-hint`
   - Add usage examples in the command file
   - Update your fork's README with team-specific instructions

3. **Version Control Strategy**

   - Tag releases for your team (`v1.0.0-team`)
   - Maintain a CHANGELOG for your custom commands
   - Use semantic versioning for breaking changes

4. **Testing Commands**

   ```bash
   # Test in isolation
   ~/.claude/commands/test-prefix/

   # Validate command structure
   ./scripts/update-readme.sh
   ```

5. **Security Considerations**
   - Never commit sensitive data or credentials
   - Use environment variables for configuration
   - Review commands before sharing with your team

## Adding Custom Commands

1. Create a new folder under `commands/` for your category
2. Create a `.md` file with your command name
3. Write your command logic as a Markdown prompt

### Example structure for a new command:

```
# In original repository or fork
commands/
└── my-category/
    └── my-command.md

# Fork-specific organization
commands/
├── team/              # Team-specific commands
│   └── deploy.md     # Available as: /team:team:deploy
├── project/           # Project tools
│   └── setup.md      # Available as: /team:project:setup
└── my-category/       # General commands
    └── my-command.md  # Available as: /team:my-category:my-command
```

## Command Naming Conventions

- Use descriptive names in lowercase
- Separate words with hyphens (`-`)
- Group related commands in common folders

## Maintaining Commands

When adding or modifying commands:

1. Ensure each command has proper frontmatter with `description` and optional `argument-hint`
2. Run `./scripts/update-readme.sh` to update the command list below
3. The "Available Commands" section is auto-generated - do not edit manually

## Key Features

### 🚀 Intelligent Multi-Agent System

- **Parallel Processing**: Run up to 10 specialized agents simultaneously
- **Smart Routing**: AI automatically determines which agents to use
- **Cross-Validation**: Agents validate each other's findings
- **Deep Expertise**: Each agent has specialized domain knowledge

### 🔄 Advanced Command Chaining

- **Data Flow**: Automatic output passing between commands
- **Error Handling**: Intelligent error recovery and fallbacks
- **Conditional Logic**: Execute commands based on results
- **Pipeline Templates**: Pre-built workflows for common tasks

### 📊 Comprehensive Analysis

- **Multi-Dimensional**: Security, performance, architecture, and quality
- **Trend Detection**: Track improvements over time
- **ROI Prioritization**: Focus on high-impact changes
- **Export Flexibility**: Multiple formats (MD, JSON, HTML, PDF)

### 🤖 Automation First

- **Action Plans**: Executable improvement plans
- **Progress Tracking**: Real-time status updates
- **Batch Operations**: Fix multiple issues automatically
- **Quality Gates**: Enforce standards in CI/CD

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add your commands with proper frontmatter
4. Run `./scripts/update-readme.sh` to update documentation
5. Create a pull request

See [CLAUDE.md](CLAUDE.md) for development guidelines.

## License

MIT License - see [LICENSE](LICENSE) file for details.
