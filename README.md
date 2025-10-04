# Claude Code Toolkit

Complete extension for Claude Code with commands, agents, and automation. Transform your development workflow with 6 core commands plus specialized extensions, all backed by intelligent AI agents.

## 🚀 Quick Start

```bash
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit
./install.sh myprefix --with-settings

# Use anywhere in your projects
/myprefix:understand --comprehensive      # Deep analysis (. is default)
/myprefix:improve --apply-insights        # Fix issues
/myprefix:secure --audit                  # Security scan
/myprefix:ship --readiness-check          # Deployment validation
```

## ✨ Features

- **5 Core Commands**: understand, improve, create, secure, ship
- **25+ AI Agents**: Security, performance, architecture, research and planning specialists
- **Sound Notifications**: Audio feedback for command completion
- **TYPO3 Integration**: Specialized CMS development tools
- **MCP Compatible**: Enhanced with optional MCP servers
- **Knowledge-Driven**: Pattern learning and intelligent workflow optimization

## 📦 Installation

```bash
# Basic installation
./install.sh myprefix

# With notifications (recommended) - adds sound feedback and smart suggestions
./install.sh myprefix --with-settings
```

Installs to `~/.claude/commands/myprefix/`, `~/.claude/agents/`, and `~/.claude/claude-code-toolkit/`

## Available Commands

The toolkit uses the **5-Command Architecture** for core operations, plus specialized commands for specific domains. Use your custom prefix (e.g., `myprefix`):

> 💡 **Click any command** for detailed documentation with syntax, examples, and workflows.

<!-- COMMANDS:START - DO NOT EDIT -->

### Core Commands (5-Command Architecture)

| Command | Description | Options |
|---------|-------------|---------|
| [`/prefix:create`](docs/commands/create.md) | Code and content generation with intelligent templating and pattern learning | `type`, `target`, `--format`, `--from-analysis`, `--template`, `--help` |
| [`/prefix:improve`](docs/commands/improve.md) | Code improvement with intelligent routing and learning persistence | `type`, `target`, `--dry-run`, `--severity`, `--apply-insights`, `--from-analysis`, `--export-json`, `--export-md`, `--help` |
| [`/prefix:secure`](docs/commands/secure.md) | Security analysis and vulnerability detection with threat intelligence learning | `type`, `target`, `--standard`, `--help` |
| [`/prefix:ship`](docs/commands/ship.md) | Deployment readiness and quality gates with release pattern learning | `type`, `target`, `--check`, `--readiness-check`, `--quality-gates`, `--help` |
| [`/prefix:understand`](docs/commands/understand.md) | Code analysis and comprehension with intelligent problem routing | `type`, `target`, `--comprehensive`, `--quick`, `--export-json`, `--export-md`, `--help` |

### Git Commands

| Command | Description | Options |
|---------|-------------|---------|
| [`/prefix:git:operations`](docs/commands/git/operations.md) | Smart Git operations with project context and commit pattern learning | `operation`, `--push`, `--no-verify`, `--smart`, `--pattern-learn`, `--interactive`, `--dry-run`, `--help` |

### Meta Commands

| Command | Description | Options |
|---------|-------------|---------|
| [`/prefix:meta:changelog`](docs/commands/meta/changelog.md) | AI-powered CHANGELOG.md management that automatically determines version based on changes | `--commit`, `--push`, `--fast`, `--update-version` |
| [`/prefix:meta:handoff`](docs/commands/meta/handoff.md) | Documents current problem context for handoff to another AI assistant | `output-file`, `-c\|--compact\|--brief`, `-t\|--technical`, `--focus`, `topic`, `--skip`, `topic`, `--include`, `topic`, `"instructions"` |
| [`/prefix:meta:mcp`](docs/commands/meta/mcp.md) | Manage MCP (Model Context Protocol) servers for Claude Code | `install\|remove\|list\|info`, `server-name`, `--scope`, `local\|project\|user` |

### TYPO3 Commands

| Command | Description | Options |
|---------|-------------|---------|
| [`/prefix:typo3:content-blocks`](docs/commands/typo3/content-blocks.md) | Generate TYPO3 Content Blocks v1.3 with modern field configurations | `name`, `--type=element\|page`, `--fields=...`, `--sitepackage=path`, `--with-components`, `--component-type=inline\|external` |
| [`/prefix:typo3:extension-kickstarter`](docs/commands/typo3/extension-kickstarter.md) | Create TYPO3 extensions using ext-kickstarter or manual scaffolding | `extension-key`, `--type=...`, `--use-kickstarter`, `--composer-name=...`, `--with-backend-module`, `--with-plugin`, `--with-middleware`, `--with-command`, `--with-event-listener`, `--with-tests` |
| [`/prefix:typo3:fluid-components`](docs/commands/typo3/fluid-components.md) | Generate Fluid v4 Components for TYPO3 v13 with Atomic Design patterns and Fluid analysis | `component-name`, `--type=atom\|molecule\|organism`, `--sitepackage=path`, `--analyze` |
| [`/prefix:typo3:make-content-block`](docs/commands/typo3/make-content-block.md) | Wrapper for TYPO3 make:content-block command with intelligent defaults | `--vendor=...`, `--type=...`, `--skeleton-path=...`, `--config-path=...`, `--create-skeleton`, `--batch=...`, `--migrate-from=...` |
| [`/prefix:typo3:sitepackage`](docs/commands/typo3/sitepackage.md) | Create a TYPO3 v13.4 SitePackage based on official template with Site Sets | `vendor`, `package-name`, `--include-ddev`, `--include-docker`, `--author=name`, `--email=address` |

## Help System

Most commands provide detailed help information when called with `--help` or `-h`:

```bash
/prefix:command --help
/prefix:category:command -h
```

This shows detailed descriptions, all options, examples, and related workflows.

**Example:**

```bash
/prefix:understand --help
```

<!-- COMMANDS:END -->

## 🤖 AI Agents

<!-- AGENTS:START -->
<!-- This section is auto-generated by scripts/update-agents.sh - DO NOT EDIT MANUALLY -->

### 📋 Agent Catalog

Specialized AI agents provide domain expertise for various development tasks. Each agent name links to detailed documentation.

#### Analysis Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [ai-specialist](docs/agents/analysis/ai-specialist.md) | AI integration expert specializing in prompt engineering, LLM optimization, and AI-powered featur... | Read,Grep,Task |
| [code-understanding-specialist](docs/agents/analysis/code-understanding-specialist.md) | Expert in comprehensive code analysis, architecture comprehension, and pattern recognition with p... | Read,Grep,Glob,Task |
| [performance-optimizer](docs/agents/analysis/performance-optimizer.md) | Performance analysis and optimization expert specializing in identifying bottlenecks, memory leak... | Read,Grep,Task |
| [refactoring-expert](docs/agents/analysis/refactoring-expert.md) | Code refactoring specialist with expertise in clean code principles, design patterns, and systema... | Read,Grep,Task |
| [report-analyzer](docs/agents/analysis/report-analyzer.md) | Analysis report expert specializing in interpreting code quality reports, identifying trends, com... | Read,Grep,Task |

#### Architecture Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [code-architect](docs/agents/architecture/code-architect.md) | Software architecture expert specializing in system design, code structure analysis, and architec... | Read,Grep,Task |
| [project-planner](docs/agents/architecture/project-planner.md) | Strategic development planning expert specializing in project architecture, comprehensive task de... | Read,Grep,Task,TodoWrite |

#### Documentation Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [documentation-health-specialist](docs/agents/documentation/documentation-health-specialist.md) | Expert in documentation quality analysis, technical writing best practices, and maintaining docum... | Read,Grep,Task |
| [documentation-specialist](docs/agents/documentation/documentation-specialist.md) | Alias for documentation-health-specialist - Knowledge-Enhanced expert in content generation and t... | Read,Grep,Task |

#### Frontend Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [frontend-specialist](docs/agents/frontend/frontend-specialist.md) | Frontend development expert specializing in modern JavaScript frameworks, component architecture,... | Read,Grep,Task |
| [tailwind-css-specialist](docs/agents/frontend/tailwind-css-specialist.md) | Tailwind CSS v4 expert specializing in best practices, installation, configuration, and integrati... | Read,Grep,Glob,WebFetch,WebSearch,Task |

#### Git Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [git-conflict-specialist](docs/agents/git/git-conflict-specialist.md) | Expert in Git conflict analysis, resolution strategies, and merge semantics | Read,Grep,Task |
| [git-workflow-specialist](docs/agents/git/git-workflow-specialist.md) | Knowledge-Enhanced Git workflow expert specializing in intelligent commit execution, change analy... | Read,Grep,Bash(git:*) |

#### Operations Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [deployment-specialist](docs/agents/operations/deployment-specialist.md) | CI/CD and deployment expert specializing in automated pipelines, containerization, and production... | Read,Grep,Task |
| [workflow-optimizer](docs/agents/operations/workflow-optimizer.md) | Developer workflow and productivity expert focused on reducing friction, automating repetitive ta... | Read,Grep,Task,mcp__basic-memory__search_notes,... |

#### Research Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [blueprint-architect](docs/agents/research/blueprint-architect.md) | Implementation blueprint creation expert combining requirements, patterns, and research into exec... | Read,Grep,Task |
| [codebase-research-specialist](docs/agents/research/codebase-research-specialist.md) | Deep codebase pattern analysis expert specializing in discovering implementation patterns, archit... | Read,Grep,Glob,Task |
| [external-research-specialist](docs/agents/research/external-research-specialist.md) | External documentation and best practices research expert with web search and API documentation a... | Read,Grep,Task |
| [requirements-analyst](docs/agents/research/requirements-analyst.md) | Requirements validation and completeness expert specializing in gap analysis, stakeholder require... | Read,Grep,Glob,Task |

#### Security Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [debugging-specialist](docs/agents/security/debugging-specialist.md) | Expert in systematic debugging, log analysis, and root cause identification. This agent helps tra... | Read,Grep,Task |
| [security-specialist](docs/agents/security/security-specialist.md) | Deep security analysis expert specializing in vulnerability detection, OWASP compliance, and secu... | Read,Grep,Task |

#### TYPO3 Agents

| Agent | Purpose | Tools |
|-------|---------|-------|
| [typo3-architect](docs/agents/typo3/typo3-architect.md) | TYPO3 architecture expert specializing in enterprise CMS solutions, extension architecture, and p... | Read,Grep,Task |
| [typo3-content-blocks-specialist](docs/agents/typo3/typo3-content-blocks-specialist.md) | TYPO3 Content Blocks expert specializing in creating, configuring, and optimizing content blocks ... | Read,Grep,Task |
| [typo3-extension-developer](docs/agents/typo3/typo3-extension-developer.md) | TYPO3 extension development expert specializing in creating, maintaining, and optimizing TYPO3 ex... | Read,Grep,Task |
| [typo3-fluid-expert](docs/agents/typo3/typo3-fluid-expert.md) | TYPO3 Fluid Template Engine expert with latest conventions, ViewHelper mastery, and Context7 inte... | Read,Grep,Task |
| [typo3-typoscript-expert](docs/agents/typo3/typo3-typoscript-expert.md) | TYPO3 TypoScript expert specializing in template configuration, setup optimization, and TypoScrip... | Read,Grep,Task |

**Total Agents**: 26 across 9 categories

<!-- AGENTS:END -->

## 🔊 Sound Notifications

Three automation profiles available:

- **basic**: Essential notifications only
- **minimal**: + Error detection + Smart suggestions
- **advanced**: Full notification suite + Smart suggestions

Configure during installation with `--with-settings`

## 💡 Smart Suggestions

The toolkit provides intelligent workflow recommendations:

- **Context-Aware**: Suggestions based on file types (security, tests, docs, etc.)
- **Learning Tool**: Helps users discover relevant commands in the 6-command architecture
- **Customizable**: JSON configuration for patterns and suggestions
- **Non-Intrusive**: 30-second cooldown prevents suggestion spam

**Examples:**

- Edit `auth.py` → `💡 Security code modified. Consider: /prefix:secure . --quick`
- Create `test_user.py` → `💡 Test file created. Consider: /prefix:understand . --test-coverage`

## 🔧 Configuration

### Prerequisites

- **Claude Code** (claude.ai/code)
- **Bash shell** (macOS/Linux/WSL)
- **Git**

### Optional Enhancements

- **markdownlint-cli2**: Auto-format markdown files
- **afplay** (macOS): Sound notifications
- **MCP servers**: Enhanced functionality (Semgrep, GitHub, GitLab)

## 📁 Directory Structure

```bash
claude-code-toolkit/
├── commands/         # Core 6-command architecture
├── agents/          # Specialized AI agents
├── hooks/           # Automation hooks
├── knowledge-base/  # Domain expertise
├── templates/       # Command templates
└── settings/        # Hook profiles
```

## 🍴 Forking & Customization

```bash
# Fork on GitHub, then:
git clone https://github.com/YourUsername/your-fork.git
cd your-fork
./install.sh myteam

# Install multiple versions
./install.sh global    # Official toolkit
./install.sh myteam    # Your customizations
```

## 📚 Documentation

- [Architecture Overview](docs/architecture/)
- [Command Development](docs/guides/)
- [Agent Creation](agents/CLAUDE.md)
- [Hook Configuration](hooks/CLAUDE.md)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch
3. Add commands with proper frontmatter
4. Run `./scripts/update-readme.sh`
5. Submit pull request

## 📜 License

MIT License - see [LICENSE](LICENSE) file for details.
