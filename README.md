# Claude Code Toolkit

Complete extension for Claude Code with commands, agents, and automation. Transform your development workflow with 6 core commands plus specialized extensions, all backed by intelligent AI agents.

## 🚀 Quick Start

```bash
git clone https://github.com/redpop/claude-code-toolkit.git
cd claude-code-toolkit
./install.sh myprefix --with-settings

# Use anywhere in your projects
/myprefix:understand . --comprehensive    # Deep analysis
/myprefix:improve . --apply-insights      # Fix issues
/myprefix:secure . --audit               # Security scan

# NEW: PRP Blueprint-Driven Development
/myprefix:understand . --prp --requirements="OAuth2 auth"
/myprefix:create . --prp --from-analysis
/myprefix:ship . --prp --quality-gates
```

## ✨ Features

- **6 Core Commands**: understand, improve, create, secure, ship, git
- **20+ AI Agents**: Security, performance, architecture specialists + PRP agents
- **PRP Methodology**: Blueprint-driven development with pattern learning
- **Sound Notifications**: Audio feedback for command completion
- **TYPO3 Integration**: Specialized CMS development tools
- **MCP Compatible**: Enhanced with optional MCP servers

## 📦 Installation

```bash
# Basic installation
./install.sh myprefix

# With notifications (recommended)
./install.sh myprefix --with-settings
```

Installs to `~/.claude/commands/myprefix/`, `~/.claude/agents/`, and `~/.claude/claude-code-toolkit/prp/`

## Available Commands

The toolkit uses the **6-Command Architecture** for core operations, plus specialized commands for specific domains. Use your custom prefix (e.g., `myprefix`):

<!-- COMMANDS:START - DO NOT EDIT -->

### Core Commands (6-Command Architecture)

| Command | Description | Options | Help |
|---------|-------------|---------|------|

| `/prefix:create` | Code and content generation with intelligent templating and pattern learning | `type`, `target`, `--format`, `--help` | - |
| `/prefix:git` | Smart Git operations with project context and commit pattern learning | `operation`, `--push`, `--no-verify` | - |
| `/prefix:improve` | Code improvement with intelligent routing and learning persistence | `type`, `target`, `--dry-run`, `--severity` | - |
| `/prefix:secure` | Security analysis and vulnerability detection with threat intelligence learning | `type`, `target`, `--standard`, `--help` | - |
| `/prefix:ship` | Deployment readiness and quality gates with release pattern learning | `type`, `target`, `--check`, `--help` | - |
| `/prefix:understand` | Code analysis and comprehension with intelligent problem routing | `type`, `target` | - |


### Meta Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:meta:changelog` | AI-powered CHANGELOG.md management that automatically determines version based on changes | `--commit`, `--push`, `--fast`, `--update-version` | - |
| `/prefix:meta:handoff` | Documents current problem context for handoff to another AI assistant | `output-file`, `-c\|--compact`, `-t\|--technical`, `--focus`, `topic`, `--skip`, `topic`, `--include`, `topic`, `"instructions"` | - |


### Typo3 Commands

| Command | Description | Options | Help |
|---------|-------------|---------|------|
| `/prefix:typo3:content-blocks` | Generate TYPO3 Content Blocks v1.3 with modern field configurations | `name`, `--type=element\|page`, `--fields=...`, `--sitepackage=path` | - |
| `/prefix:typo3:extension-kickstarter` | Create TYPO3 extensions using ext-kickstarter or manual scaffolding | `extension-key`, `--type=...`, `--use-kickstarter`, `--composer-name=...` | - |
| `/prefix:typo3:fluid-components` | Generate Fluid v4 Components for TYPO3 v13 with Atomic Design patterns and Fluid analysis | `component-name`, `--type=atom\|molecule\|organism`, `--sitepackage=path`, `--analyze` | - |
| `/prefix:typo3:make-content-block` | Wrapper for TYPO3 make:content-block command with intelligent defaults | `--vendor=...`, `--type=...`, `--skeleton-path=...`, `--config-path=...` | - |
| `/prefix:typo3:sitepackage` | Create a TYPO3 v13.4 SitePackage based on official template with Site Sets | `vendor`, `package-name`, `--include-ddev`, `--include-docker`, `--author=name`, `--email=address` | - |

<!-- COMMANDS:END -->

## 🎯 Examples

### Code Quality Workflow

```bash
/myprefix:understand . --comprehensive     # Analyze entire codebase
/myprefix:improve . --apply-insights       # Apply discovered improvements
/myprefix:secure . --audit                # Security scan
/myprefix:ship . --readiness-check        # Pre-deployment validation
```

### TYPO3 Development

```bash
# Create extension
/myprefix:typo3:sitepackage acme my-site --include-ddev

# Add content block
/myprefix:typo3:content-blocks testimonial --type=element --fields="name:text,quote:textarea"

# Create Fluid component
/myprefix:typo3:fluid-components hero --type=molecule --analyze
```

### Git Integration

```bash
/myprefix:git smart-commit              # Intelligent commit with analysis
/myprefix:git conflict-resolver         # Resolve merge conflicts
/myprefix:understand . --git-history    # Analyze code changes over time
```

### Hook Management

```bash
# Intelligent development experience
./scripts/manage-hooks.sh list                    # View all available hooks
./scripts/manage-hooks.sh enable session-end-summary  # Smart session summaries
./scripts/manage-hooks.sh doctor                  # System health check

# Enhanced features automatically provide:
# - Session summaries with Basic Memory integration
# - Command statistics and usage patterns
# - Context preservation across sessions
# - Smart notifications and project insights
# - Intelligent workflow suggestions based on file modifications
```

## 🤖 AI Agents

16+ specialized agents work behind the scenes:

- **security-specialist**: OWASP compliance, vulnerability detection
- **performance-optimizer**: Speed, memory, algorithm optimization
- **code-architect**: Design patterns, architecture review
- **test-engineer**: Coverage analysis, test quality
- **debugging-specialist**: Root cause analysis, error tracking

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
