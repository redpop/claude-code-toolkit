# Claude Code Toolkit

The complete toolkit for extending Claude Code with commands, agents, hooks, and tools. A comprehensive collection of slash commands, AI agents, automation hooks, knowledge base, and utilities that can be installed in `~/.claude/` with a custom prefix.

## 📑 Table of Contents

- [🚀 Quick Start](#-quick-start-transform-your-code-quality)
- [✨ Key Features](#-key-features)
- [📋 Prerequisites](#prerequisites)
- [📦 Installation](#installation)
- [🍴 Forking Guide](#forking-this-repository)
- [📚 Available Commands](#available-commands)
- [🤖 AI Agents](#ai-agents)
- [🔊 Hooks & Automation](#step-3-configure-hooks-optional)
- [🔧 Configuration](#configuration)
- [📖 Documentation](#documentation)
- [🤝 Contributing](#contributing)
- [📜 License](#license)

## 🚀 Quick Start

```bash
# Install in 30 seconds
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit
./install.sh global --with-settings

# Transform your code quality
/global:scan:deep . --export-json        # Analyze codebase
/global:scan:report --latest             # Generate action plan  
/global:auto:execute --latest            # Apply improvements

# Or use one-command pipeline
/global:meta:chain "scan:deep . --export-json" -> "scan:report --latest" -> "auto:execute --latest"  # Full optimization
```

💡 **Pro tip**: Replace `global` with your custom prefix • [Full Guide →](docs/guides/MODERN-WORKFLOW.md)

## ✨ Key Features

| Component | Description |
|-----------|-------------|
| **60+ Commands** | Code analysis, fixing, generation, workflow automation |
| **16+ AI Agents** | Security, performance, architecture, debugging experts |
| **9 Automation Hooks** | Sound notifications, markdown formatting, error detection, session logging |
| **3 Hook Profiles** | Basic (minimal), Minimal (+ errors), Advanced (full suite) |
| **Knowledge Base** | TYPO3, UI patterns, framework guides, best practices |
| **Smart Workflows** | Command chaining, parallel processing, auto-exports |
| **MCP Support** | Enhanced functionality with optional MCP servers |

## Prerequisites

### Required

- **Claude Code** (claude.ai/code)
- **Bash shell** (macOS/Linux/WSL)
- **Git** for cloning the repository

### Optional Dependencies

These tools enhance specific features but are not required for basic functionality:

| Tool | Purpose | Installation | Feature |
|------|---------|--------------|---------|
| **markdownlint-cli2** | Auto-format Markdown files | `brew install markdownlint-cli2` | Markdown formatting hook |
| **npx** | Fallback for markdownlint | Comes with Node.js | Auto-installs tools on demand |
| **afplay** | Sound notifications (macOS) | Built-in on macOS | Completion sounds |
| **Python 3** | Settings file merging | Usually pre-installed | Hook configuration |

> **Note**: The toolkit will work without these dependencies and gracefully fall back to alternatives or skip the feature.

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
# Basic installation
./install.sh myprefix

# Install with sound notifications (recommended)
./install.sh myprefix --with-settings

# Install specific components only
./install.sh myprefix --install commands,agents,hooks
```

The installation script will:

- Copy command files to `~/.claude/commands/myprefix/`
- Install AI agents to `~/.claude/agents/`
- Install hooks for notifications to `~/.claude/claude-code-toolkit/hooks/`
- Optionally configure global settings for hooks (with `--with-settings`)
- Display all available commands, agents, and hooks after installation
- Create backups of existing installations if needed

### Step 3: Configure Hooks (Optional)

The toolkit includes 9 automation hooks organized in 3 profiles (`settings/`):

```bash
# Choose your automation level
./install.sh myprefix --with-settings                          # Basic profile
./install.sh myprefix --with-settings --hooks-profile minimal  # + Error detection
./install.sh myprefix --with-settings --hooks-profile advanced # Full suite
```

#### 🔧 Available Hooks

| Hook | Trigger | Purpose | Profiles |
|------|---------|---------|----------|
| `stop-notification.sh` | Claude finishes | Completion sound (Glass.aiff) | ✅ Basic, Minimal, Advanced |
| `markdown-format.sh` | File edits | Auto-format `.md` files with markdownlint | ✅ Basic, Minimal, Advanced |
| `error-detection.sh` | Tool errors | Critical alerts & security warnings | ❌ Basic / ✅ Minimal, Advanced |
| `success-notification.sh` | Successful ops | Celebration sounds for milestones | ❌ Basic, Minimal / ✅ Advanced |
| `tool-specific-notification.sh` | Tool usage | Different sounds per tool type | ❌ Basic, Minimal / ✅ Advanced |
| `subagent-notification.sh` | Agent complete | Agent-specific completion sounds | ❌ Basic, Minimal / ✅ Advanced |
| `system-notification.sh` | Important events | macOS native notifications | ❌ Basic, Minimal / ✅ Advanced |
| `command-chain-notification.sh` | Chain progress | Track multi-command workflows | ❌ Basic, Minimal / ✅ Advanced |
| `session-logger.sh` | Session events | JSON logs with metrics | ❌ Basic, Minimal / ✅ Advanced |

#### 📦 Profile Contents

| Profile | Active Hooks | Use Case |
|---------|-------------|----------|
| **basic** | stop, markdown | Minimal disruption, essential features |
| **minimal** | basic + error-detection | Add safety checks |
| **advanced** | All 9 hooks | Full automation & monitoring |

See [Sound Notifications Guide](docs/guides/SOUND-NOTIFICATIONS.md) for customization options

## Command Categories

| Category | Purpose | Examples |
|----------|---------|----------|
| **🔍 Scan** | Analysis & investigation | `scan:deep`, `scan:quality`, `scan:deps` |
| **🔧 Fix** | Automated corrections | `fix:security`, `fix:performance`, `fix:duplicates` |
| **🏭 Gen** | Code & doc generation | `gen:tests`, `gen:docs`, `gen:format` |
| **🌊 Flow** | Multi-agent workflows | `flow:smart`, `flow:review`, `flow:incident` |
| **🤖 Auto** | Automation & orchestration | `auto:execute`, `auto:sprint`, `auto:monitor` |
| **🔒 Sec** | Security operations | `sec:audit`, `sec:baseline`, `sec:comply` |
| **🗂️ Git** | Version control | `git:commit`, `git:review`, `git:conflict-resolver` |
| **🎨 CSS** | CSS & styling operations | `css:tailwind-optimize` |
| **🏛️ TYPO3** | TYPO3 CMS development | `typo3:content-blocks`, `typo3:sitepackage` |
| **🎯 Meta** | Toolkit management | `meta:chain`, `meta:health`, `meta:help` |

## Available Commands

All commands require your chosen prefix (e.g., `myprefix`). Commands follow a consistent pattern: `/prefix:category:command`

<!-- COMMANDS:START - DO NOT EDIT -->

### Auto Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:auto:execute` | Execute action plans systematically with progress tracking and smart error handling | `<action-plan.md>\|--latest`, `--mode=supervised\|auto`, `--dry-run`, `--parallel=N`, `--focus=category`, `--force-all`, `--min-roi=threshold`, `--max-roi=threshold` | - |
| `/prefix:auto:monitor` | Set up and manage continuous code quality monitoring with automated analysis, fixes, and reporting | `directory`, `--schedule=daily\|weekly\|commit`, `--auto-fix=safe\|all\|none`, `--notify=email\|slack\|github`, `--init` | - |
| `/prefix:auto:report` | Generate comprehensive completion report after action plan execution, showing results, metrics, and next steps | `--action-plan=<file>`, `--execution-log=<file>`, `--compare-baseline`, `--baseline=<file>`, `--current=<file>`, `--export-formats=md,json,html`, `--export-all`, `--export-json=<file>`, `--include-metrics`, `--include-git-log`, `--team-report`, `--recommendations` | - |
| `/prefix:auto:sprint` | Plan and execute a complete code quality improvement sprint with analysis, prioritization, fixes, and tracking | `directory`, `--duration=1w\|2w\|1m`, `--team-size=N`, `--focus=security\|performance\|quality\|all` | - |

### Cipher Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:cipher:setup-project` | Setup Cipher memory integration by enhancing CLAUDE.md with memory usage instructions | `project-directory`, `--force`, `--minimal` | - |

### Css Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:css:figma-to-styles` | Convert Figma designs to modular CSS architecture with responsive breakpoints | `component-name`, `--css\|--tailwind\|--scss` | - |
| `/prefix:css:tailwind-optimize` | Analyze and optimize Tailwind CSS implementation with v4 best practices | `path`, `--check-migration`, `--export-json\|--export-md` | - |

### Fix Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:fix:documentation` | Fix documentation issues including broken links, parameter mismatches, missing cross-references, and outdated content | `report.json\|directory`, `--fix-links`, `--fix-params`, `--add-deprecation`, `--dry-run`, `--interactive` | - |
| `/prefix:fix:duplicates` | Remove code duplication by extracting common functions, creating shared utilities, and applying DRY principles | `report.json\|directory`, `--threshold=80`, `--min-lines=5`, `--dry-run`, `--create-utils`, `--group-by`, `--preserve-comments` | - |
| `/prefix:fix:lint` | Automatically detect and fix linting errors across multiple languages with intelligent agent orchestration | `path`, `or`, `custom`, `instructions` | - |
| `/prefix:fix:markdown` | Lint and fix markdown files using markdownlint-cli2 | `<file-or-directory>`, `--fix`, `--config`, `<path>` | - |
| `/prefix:fix:performance` | Automated performance issue fixes including O(n²) algorithms, memory optimization, and database batching | `--target=algorithm\|memory\|database\|all`, `--file=path`, `--dry-run` | - |
| `/prefix:fix:quick-wins` | Apply high-ROI fixes from analysis reports - quick wins with maximum impact and minimal effort | `report.json`, `--dry-run`, `--category=security\|performance\|quality`, `--max-effort=4h`, `--min-roi=5`, `--help` | ✓ |
| `/prefix:fix:security` | Fix security vulnerabilities with MCP-enhanced analysis or traditional pattern matching | `report.json`, `--severity=critical,high,medium`, `--dry-run`, `--interactive`, `--owasp-top10` | - |
| `/prefix:fix:shell` | Automatically fix shell script issues using shellcheck analysis | `path/file`, `--check-only`, `--strict`, `--summary-only` | - |

### Flow Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:flow:debug-mode` | Switch to intensive debugging mode for current problem | `--verbose`, `--trace` | - |
| `/prefix:flow:incident` | Rapid incident response workflow for production issues with root cause analysis | `<incident-description>`, `--severity=critical\|high\|medium`, `--system=component` | - |
| `/prefix:flow:refactor` | Intelligent refactoring suggestions with impact analysis and step-by-step guidance | `<file-or-pattern>`, `--type=extract\|rename\|restructure`, `--safety=conservative\|balanced\|aggressive` | - |
| `/prefix:flow:review` | Comprehensive code review using multiple specialized agents for different perspectives | `<file-or-directory>`, `--focus=security\|performance\|architecture\|all` | - |
| `/prefix:flow:smart` | Intelligently analyze and route problems to the most appropriate specialized agents | `<problem-description>`, `--verbose`, `--suggest-only` | - |

### Gen Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:gen:docs` | Generate comprehensive documentation including API docs, README files, code comments, and architecture diagrams | `directory\|file`, `--types=api,readme,comments,diagrams`, `--format=markdown,html`, `--update-existing` | - |
| `/prefix:gen:format` | Create or convert content into various formats (HTML, Markdown, Confluence, Plain Text) | `<request-or-file>`, `--html\|--html-simple\|--markdown\|--confluence\|--text` | - |
| `/prefix:gen:tests` | Generate comprehensive test suites for uncovered code, including unit tests, integration tests, and edge cases | `report.json\|file\|directory`, `--coverage-target=80`, `--framework=auto`, `--types=unit,integration`, `--mock-externals` | - |

### Git Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:git:commit-simple` | Creates clean Git commits with optional branch prefix extraction and intelligent grouping | `--no-verify`, `--fast`, `--push`, `--single`, `--brief` | - |
| `/prefix:git:commit` | Creates structured Git commits with Conventional Commit format and emojis | `--no-verify`, `--fast`, `--push` | - |
| `/prefix:git:conflict-resolver` | Interactive Git conflict resolution with step-by-step guidance and recommendations | `source-branch`, `target-branch`, `--strategy:merge\|rebase\|theirs\|ours`, `--rebase-feature`, `--test-command="npm`, `test"`, `--help` | ✓ |
| `/prefix:git:review` | Reviews all Git changes before commit to ensure code quality and identify issues | `--staged-only`, `--detailed` | - |

### Meta Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:meta:analyze-toolkit` | Analyze toolkit commands and agents for redundancies, inconsistencies, and refactoring opportunities | `--fix`, `--export-json`, `--export-md`, `--focus=<area>` | - |
| `/prefix:meta:chain` | Chain commands or execute pre-defined pipelines with intelligent data flow | `<pipeline-name`, `\|`, `command-chain>`, `--list`, `--save-as=name`, `--dry-run` | ✓ |
| `/prefix:meta:changelog` | AI-powered CHANGELOG.md management that automatically determines version based on changes | `--commit`, `--push`, `--fast`, `--update-version` | - |
| `/prefix:meta:create` | Intelligently create commands, agents, or workflows from your description | `<what`, `you`, `need>`, `--type=auto\|command\|agent\|workflow` | - |
| `/prefix:meta:docs-sync` | Verify and synchronize all documentation files with actual codebase structure | `--fix`, `--export-json`, `--export-md` | - |
| `/prefix:meta:export` | Unified export management for all analysis results with format conversion | `<report-files...>`, `--format=md\|json\|html\|pdf`, `--merge`, `--template=name` | - |
| `/prefix:meta:find-cmd` | Find the best command for your task from all available commands (global and local) | `<task-description>`, `--all`, `--local-only`, `--global-only` | - |
| `/prefix:meta:handoff` | Documents current problem context for handoff to another AI assistant | `output-file`, `-c\|--compact`, `-t\|--technical`, `--focus`, `topic`, `--skip`, `topic`, `--include`, `topic`, `"instructions"` | - |
| `/prefix:meta:health` | Comprehensive project health check with actionable insights and trend analysis | `--verbose`, `--compare=last-check.json`, `--export` | - |
| `/prefix:meta:help-handler` | Display help information for any toolkit command | `<command-path>`, `--verbose` | - |
| `/prefix:meta:help` | Display help for commands or list available commands | `command-name`, `--list`, `--search`, `<keyword>`, `--categories` | - |
| `/prefix:meta:summary` | Creates a chat summary for another AI with complete context | `summaries/` | - |
| `/prefix:meta:test-guide` | Generates interactive test guides for recent changes, suitable for both end-users and technical reviewers | `--type=all\|user\|technical`, `--format=md\|checklist\|jira`, `--lang=en\|de\|es\|fr`, `--output=file.md` | - |
| `/prefix:meta:update-docs` | Intelligently updates project documentation based on code changes and implementation status | `--scope=<type>`, `--analyze`, `--commit` | - |
| `/prefix:meta:version` | Check installed toolkit version and available updates | `check\|update` | - |

### Scan Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:scan:deep` | Deep code analysis with streamlined output and clear workflow guidance | `<directory>`, `--focus=security\|performance\|architecture\|all`, `--export-md`, `--export-json` | ✓ |
| `/prefix:scan:deps` | In-depth dependency analysis with 6 specialized agents for complete transparency | `package-name\|file`, `--depth=direct\|transitive\|full`, `--check=security\|licenses\|all` | - |
| `/prefix:scan:docs` | Analyze documentation health, validate code-doc synchronization, check cross-references, and identify outdated content | `directory`, `--scope=readme\|api\|all`, `--check-links`, `--validate-params`, `--export-report` | - |
| `/prefix:scan:explore` | Multi-Perspective Deep Research with 8 different viewpoints on a topic | `topic`, `--depth=surface\|medium\|deep`, `--focus=technical\|business\|all` | - |
| `/prefix:scan:map` | Creates a comprehensive codebase mapping with 10 agents for different aspects | `directory`, `--format=markdown\|json\|mermaid`, `--depth=overview\|detailed\|full` | - |
| `/prefix:scan:perf` | Deep Performance Profiling with 7 Agents for Bottleneck Identification and Optimization | `directory`, `--profile=cpu\|memory\|io\|all`, `--export-md`, `--export-json`, `--export-html`, `--export-all`, `--export-dir=path` | - |
| `/prefix:scan:quality` | Comprehensive code quality metrics with trend analysis and improvement roadmap | `<directory>`, `--baseline=previous.json`, `--threshold=80`, `--export` | - |
| `/prefix:scan:quick` | Quick parallel code analysis for rapid feedback (30 seconds) | `<directory>`, `--focus=area`, `--export-json` | - |
| `/prefix:scan:refactor` | Analyzes the impact of refactoring changes using 6 specialized agents | `file-or-pattern`, `--change-type=rename\|move\|signature\|structure` | - |
| `/prefix:scan:report` | Intelligent analysis of code quality reports with trend detection, prioritization, and actionable insights | `report.json`, `--latest`, `--compare=other-report.json`, `--history`, `--trends`, `--quick-wins`, `--export-md`, `--generate-action-plan` | - |
| `/prefix:scan:root-cause` | Deep root cause analysis with ultra intensive reasoning | `issue_description` | - |
| `/prefix:scan:tests` | Comprehensive test coverage analysis with 5 specialized agents for test quality | `directory`, `--framework=jest\|pytest\|go-test\|cargo-test`, `--export-md`, `--export-json`, `--export-html`, `--export-all`, `--export-dir=path` | - |

### Sec Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:sec:audit` | Comprehensive security audit with MCP-enhanced scanning or traditional fallback methods | `directory`, `--severity=critical\|high\|all`, `--export-md`, `--export-json`, `--export-html`, `--export-all`, `--export-dir=path` | ✓ |
| `/prefix:sec:baseline` | Establish and track security baseline with MCP-enhanced scanning or traditional methods | `directory`, `--export-baseline`, `--compare=previous-baseline.json`, `--track-improvements` | - |
| `/prefix:sec:comply` | Run compliance checks for OWASP, PCI-DSS, GDPR, and custom security policies | `directory`, `--standard=owasp\|pci-dss\|gdpr\|all`, `--custom-rules=rules.yaml`, `--export-report` | - |

### Typo3 Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:typo3:content-blocks` | Generate TYPO3 Content Blocks v1.3 with modern field configurations | `name`, `--type=element\|page`, `--fields=...`, `--sitepackage=path` | - |
| `/prefix:typo3:extension-kickstarter` | Create TYPO3 extensions using ext-kickstarter or manual scaffolding | `extension-key`, `--type=...`, `--use-kickstarter`, `--composer-name=...` | - |
| `/prefix:typo3:fluid-components` | Generate Fluid v4 Components for TYPO3 v13 with Atomic Design patterns and Fluid analysis | `component-name`, `--type=atom\|molecule\|organism`, `--sitepackage=path`, `--analyze` | - |
| `/prefix:typo3:make-content-block` | Wrapper for TYPO3 make:content-block command with intelligent defaults | `--vendor=...`, `--type=...`, `--skeleton-path=...`, `--config-path=...` | - |
| `/prefix:typo3:sitepackage` | Create a TYPO3 v13.4 SitePackage based on official template with Site Sets | `vendor`, `package-name`, `--include-ddev`, `--include-docker`, `--author=name`, `--email=address` | - |

## Help System

Some commands provide detailed help information when called with the `--help` option. Commands with help support are marked with ✓ in the Help column above.

### Usage

To get detailed help for any supported command:

```bash
/prefix:category:command --help
```

This will show:

- Detailed description and usage
- All available options with explanations  
- Examples with real use cases
- Related commands and workflows
- MCP enhancement information (if applicable)

### Example

```bash
/prefix:git:conflict-resolver --help
```

Shows comprehensive guide for Git conflict resolution including strategies, workflows, and team best practices.

### Generate Help Documentation

You can also generate formatted help output using the helper script:

```bash
./scripts/generate-help.sh <category>/<command>.md
```

This provides additional formatting options and can be used for documentation generation.

<!-- COMMANDS:END -->

## AI Agents

The toolkit includes 16+ specialized AI agents that work independently or in parallel:

| Agent | Specialization | Key Focus |
|-------|---------------|----------|
| **security-specialist** 🔒 | Vulnerability detection | OWASP Top 10, authentication, encryption |
| **performance-optimizer** ⚡ | Speed & efficiency | Algorithm complexity, memory, caching |
| **test-engineer** 🧪 | Test quality | Coverage, edge cases, test pyramid |
| **code-architect** 🏗️ | Design patterns | SOLID principles, coupling, modularity |
| **refactoring-expert** 🔧 | Code quality | Technical debt, duplication, complexity |
| **debugging-specialist** 🐛 | Issue resolution | Stack traces, root cause analysis |
| **frontend-specialist** 🎨 | UI/UX code | React, performance, accessibility |
| **deployment-specialist** 🚀 | CI/CD & DevOps | Docker, Kubernetes, pipelines |
| **workflow-optimizer** ⚙️ | Developer productivity | Automation, tooling, efficiency |
| **report-analyzer** 📊 | Analysis insights | Trends, prioritization, ROI |

### Multi-Agent Commands

Commands that orchestrate multiple agents for comprehensive analysis:

```bash
# Deep analysis with 10 parallel agents
/prefix:scan:deep . --export-json

# Security audit with 8 specialized agents  
/prefix:sec:audit . --export-md

# Performance profiling with 7 agents
/prefix:scan:perf . --export-all
```

**Benefits**: 10x faster analysis • Specialized expertise • Cross-validation • Comprehensive coverage

## Forking & Customization

### Creating Your Own Fork

```bash
# 1. Fork on GitHub (click Fork button)
# 2. Clone and install your fork
git clone https://github.com/YourUsername/your-fork.git
cd your-fork
./install.sh myprefix

# 3. Install multiple versions
./install.sh global        # Original toolkit
./install.sh team          # Your team's fork
```

### Maintaining Your Fork

```bash
# Sync with upstream
git remote add upstream https://github.com/redpop/claude-code-toolkit.git
git fetch upstream && git merge upstream/main && git push

# Update installation
cd /path/to/toolkit && git pull && ./install.sh myprefix
```

### Fork Best Practices

| Area | Practice |
|------|----------|
| **Organization** | Use folders: `team/`, `project/`, `internal/`, `experimental/` |
| **Documentation** | Include frontmatter, examples, team-specific README |
| **Versioning** | Tag releases (`v1.0-team`), maintain CHANGELOG |
| **Security** | No credentials in code, use environment variables |
| **Contributing** | Remove proprietary code before submitting PRs |

## Adding Custom Commands

Create new commands by adding `.md` files to the `commands/` directory:

```bash
commands/
├── category/          # Command category
│   └── command.md    # Available as: /prefix:category:command
├── team/             # Team-specific commands
│   └── deploy.md     # Available as: /prefix:team:deploy
└── project/          # Project tools
    └── setup.md      # Available as: /prefix:project:setup
```

**Requirements**: Include frontmatter with `description` and optional `argument-hint`. Run `./scripts/update-readme.sh` after adding commands.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add your commands with proper frontmatter
4. Run `./scripts/update-readme.sh` to update documentation
5. Create a pull request

See [CLAUDE.md](CLAUDE.md) for development guidelines.

## License

MIT License - see [LICENSE](LICENSE) file for details.
