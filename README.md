# Claude Code Toolkit

The complete toolkit for extending Claude Code with commands, agents, and tools. A comprehensive collection of slash commands, AI agents, and utilities that can be installed in `~/.claude/` with a custom prefix.

## Installation

Use the installation script to set up the commands with your desired prefix:

```bash
# Install with your chosen prefix (e.g., "myprefix", "global", etc.)
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/install.sh | bash -s -- myprefix

# Or from your own fork (automatic detection)
export CLAUDE_COMMANDS_REPO_URL="https://github.com/YourUsername/your-fork.git"
curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix

# Or as a one-liner
CLAUDE_COMMANDS_REPO_URL="https://github.com/YourUsername/your-fork.git" curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix
```

The installation script will:

- Clone the repository using Git sparse checkout
- Set up command files in `~/.claude/commands/myprefix/`
- Install AI agents in `~/.claude/agents/`
- Create a Git repository structure that allows easy updates
- Display all available commands and agents after installation
- Automatically detect fork URLs and configure accordingly

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
   # The install script automatically detects fork URLs
   curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix

   # Or explicitly set the repository URL
   CLAUDE_COMMANDS_REPO_URL="https://github.com/YourUsername/your-fork.git" \
     curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix
   ```

3. **Verify Fork Configuration**

   ```bash
   # Check the remote URL
   cd ~/.claude/commands/myprefix
   git remote -v

   # Should show your fork URL:
   # origin  https://github.com/YourUsername/your-fork.git (fetch)
   # origin  https://github.com/YourUsername/your-fork.git (push)
   ```

### Benefits of Forking

- **Custom Commands**: Add proprietary or project-specific commands without affecting the original repository
- **Team Collaboration**: Share standardized workflows across your organization
- **Experimentation**: Test new command ideas before contributing upstream
- **Version Control**: Maintain your own release cycle and versioning

## Fork Configuration

Your fork can be customized using the `.claude-commands.json` configuration file in the repository root.

### Configuration File Structure

Create a `.claude-commands.json` file in your fork's root directory:

```json
{
  "name": "My Team's Claude Commands",
  "description": "Custom commands for our development workflow",
  "defaultPrefix": "team",
  "upstream": "https://github.com/redpop/claude-code-toolkit.git",
  "customCommands": {
    "categories": ["deploy", "testing", "internal"]
  }
}
```

### Configuration Options

- **name**: Display name for your command collection
- **description**: Brief description of your fork's purpose
- **defaultPrefix**: Suggested prefix for installations (users can override)
- **upstream**: Original repository URL for syncing updates
- **customCommands**: Metadata about your custom command categories

### Custom Prefix Support

When installing from a fork, you can still use any prefix:

```bash
# Install with default prefix from config
curl -fsSL https://raw.githubusercontent.com/YourTeam/team-commands/main/install.sh | bash

# Override with custom prefix
curl -fsSL https://raw.githubusercontent.com/YourTeam/team-commands/main/install.sh | bash -s -- custom

# Multiple installations with different prefixes
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/install.sh | bash -s -- global
curl -fsSL https://raw.githubusercontent.com/YourTeam/team-commands/main/install.sh | bash -s -- team
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

Since the installation creates a Git repository, you can easily update your commands:

### Method 1: Using Git (Recommended)

```bash
cd ~/.claude/commands/myprefix
git pull
```

### Method 2: Re-run Installation Script

```bash
# For original repository
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/install.sh | bash -s -- myprefix

# For your fork
curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/install.sh | bash -s -- myprefix
```

Both methods will preserve any local changes you've made to the commands.

### Hook Updates

Git hooks are versioned separately from commands. After a `git pull`, you may see a notification about available hook updates:

```
⚠️  Hook Update Available!
Your git hooks are version 2, but version 3 is available.
```

To update hooks:

```bash
# Method 1: Use the update-hooks slash command
/myprefix:project:update-hooks

# Method 2: Run the update script directly
cd ~/.claude/commands/myprefix
./.git/hooks/post-merge  # This will show the update command

# Method 3: Update all installations at once (original repo)
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/scripts/update-hooks.sh | bash

# Or from your fork
curl -fsSL https://raw.githubusercontent.com/YourUsername/your-fork/main/scripts/update-hooks.sh | bash
```

## Available Commands

<!-- COMMANDS:START - DO NOT EDIT -->

### Ai Commands

| Command              | Description                                                           | Options       |
| -------------------- | --------------------------------------------------------------------- | ------------- |
| `/prefix:ai:handoff` | Documents current problem context for handoff to another AI assistant | `output-file` |

### Analysis Commands

| Command                      | Description                                                             | Options             |
| ---------------------------- | ----------------------------------------------------------------------- | ------------------- |
| `/prefix:analysis:five-whys` | Apply the Five Whys root cause analysis technique to investigate issues | `issue_description` |

### Code Commands

| Command                   | Description                                                     | Options                                      |
| ------------------------- | --------------------------------------------------------------- | -------------------------------------------- |
| `/prefix:code:shellcheck` | Automatically fix shell script issues using shellcheck analysis | `--check-only`, `--strict`, `--summary-only` |

### Git Commands

| Command              | Description                                                               | Options                           |
| -------------------- | ------------------------------------------------------------------------- | --------------------------------- |
| `/prefix:git:commit` | Creates structured Git commits with Conventional Commit format and emojis | `--no-verify`, `--fast`, `--push` |

### Hybrid Commands

| Command                       | Description                                                                                                    | Options                        |
| ----------------------------- | -------------------------------------------------------------------------------------------------------------- | ------------------------------ | ----------- | ------------ | ---- |
| `/prefix:hybrid:analyze-deep` | Deep code analysis combining parallel scanning with specialized sub-agent expertise for comprehensive insights | `directory`, `--focus=security | performance | architecture | all` |

### Orchestration Commands

| Command                                  | Description                                                                             | Options                                  |
| ---------------------------------------- | --------------------------------------------------------------------------------------- | ---------------------------------------- | ------ | --------- | ----------- |
| `/prefix:orchestration:analyze-parallel` | Ultra-fast code analysis with 10 parallel agents for 10x performance                    | `directory`, `--focus=area`              |
| `/prefix:orchestration:performance-scan` | Deep Performance Profiling with 7 Agents for Bottleneck Identification and Optimization | `directory`, `--profile=cpu              | memory | io        | all`        |
| `/prefix:orchestration:refactor-impact`  | Analyzes the impact of refactoring changes using 6 specialized agents                   | `file-or-pattern`, `--change-type=rename | move   | signature | structure`  |
| `/prefix:orchestration:security-audit`   | Comprehensive security audit with 8 specialized agents for critical vulnerabilities     | `directory`, `--severity=critical        | high   | all`      |
| `/prefix:orchestration:test-coverage`    | Comprehensive test coverage analysis with 5 specialized agents for test quality         | `directory`, `--framework=jest           | pytest | go-test   | cargo-test` |

### Project Commands

| Command                          | Description                                                                                 | Options                                                                  |
| -------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| `/prefix:project:changelog`      | AI-powered CHANGELOG.md management that automatically determines version based on changes   | `--analyze`, `--commit`, `--update-version`                              |
| `/prefix:project:create-command` | Create new slash commands from natural language descriptions                                | `description`, `of`, `what`, `you`, `want`, `the`, `command`, `to`, `do` |
| `/prefix:project:update-docs`    | Intelligently updates project documentation based on code changes and implementation status | `--scope=<type>`, `--analyze`, `--commit`                                |
| `/prefix:project:update-hooks`   | Update git hooks to the latest version in Claude command installations                      | `--all`, `--check-only`                                                  |

### Research Commands

| Command                             | Description                                                                      | Options                         |
| ----------------------------------- | -------------------------------------------------------------------------------- | ------------------------------- | ---------------------- | --------------------------- | ------------------------ | -------- | ---- |
| `/prefix:research:codebase-map`     | Creates a comprehensive codebase mapping with 10 agents for different aspects    | `directory`, `--format=markdown | json                   | mermaid`, `--depth=overview | detailed                 | full`    |
| `/prefix:research:deep-dive`        | Multi-Perspective Deep Research with 8 different viewpoints on a topic           | `topic`, `--depth=surface       | medium                 | deep`, `--focus=technical   | business                 | all`     |
| `/prefix:research:dependency-trace` | In-depth dependency analysis with 6 specialized agents for complete transparency | `package-name                   | file`, `--depth=direct | transitive                  | full`, `--check=security | licenses | all` |

### Templates Commands

| Command                                | Description                                                                              | Options                          |
| -------------------------------------- | ---------------------------------------------------------------------------------------- | -------------------------------- | --- | ---- |
| `/prefix:templates:analysis-sub-agent` | Template für Code-Analyse Commands mit mehreren spezialisierten Agents                   | `target`, `--option=value`       |
| `/prefix:templates:basic-sub-agent`    | [Kurze Beschreibung des Commands]                                                        | `expected-arguments`             |
| `/prefix:templates:hybrid-sub-agent`   | [Brief description of the command]                                                       | `expected-arguments`             |
| `/prefix:templates:research-sub-agent` | Template für Research Commands die verschiedene Informationsquellen parallel durchsuchen | `research-topic`, `--scope=local | web | all` |

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

Our sub-agent system includes five core specialists that can be combined in various ways:

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

## Contributing

1. Fork the repository
2. Create a feature branch
3. Add your commands with proper frontmatter
4. Run `./scripts/update-readme.sh` to update documentation
5. Create a pull request

## License

See [LICENSE](LICENSE) file for details.
