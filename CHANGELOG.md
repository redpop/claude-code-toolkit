# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- ✨ **Command Finder** - New `/meta:find-cmd` command for discovering the best tool for any task
  - Intelligently searches all available commands (global and local)
  - Analyzes task descriptions with natural language processing
  - Provides ranked recommendations with usage examples
  - Supports filtering by scope: `--local-only`, `--global-only`, or `--all`
  - Suggests command chaining for complex workflows
  - Categories include: analysis, fixing, security, testing, documentation, and more

- ✨ Enhanced `/meta:changelog` command with `--push` option for complete release workflow
  - New `--push` flag automatically pushes commits to remote repository
  - Requires `--commit` flag to be specified
  - Supports full release workflow: `--commit --update-version --push`
  - Includes safety checks for remote branch status before pushing

## [3.4.2] - 2025-08-05

### Changed

- 🔄 Enhanced `/meta:test-guide` command with Jira Wiki Markup format support
  - Added `--format=jira` option for native Jira text formatting
  - Direct copy-paste compatibility with Jira tickets
  - Supports Jira syntax: headings (h1. h2. h3.), tables, panels, code blocks
  - No conversion needed - outputs ready-to-use Jira formatted text

## [3.4.1] - 2025-08-05

### Added

- ✨ **Test Guide Command** - New `/meta:test-guide` command for generating interactive test documentation
  - Creates test guides suitable for both end-users and technical reviewers
  - Supports multiple languages (English, German, Spanish, French, Japanese, Chinese)
  - Flexible output options: display only or save with auto-generated filenames
  - Includes browser DevTools instructions for all testers
  - Adapts content based on project type (Frontend/Backend/CLI)
  - Combines user-friendly steps with embedded technical validation

### Fixed

- 🐛 Fixed semgrep command syntax error in `/sec:audit` - removed invalid comma-separated severity values
  - Changed from `--severity=ERROR,WARNING` to running without severity filter
  - Now includes all severity levels by default for comprehensive security scanning

## [3.4.0] - 2025-08-05

### Added

- ✨ **Chat Summary Command** - New `/meta:summary` command for AI handoff and context preservation
  - Automatically generates meaningful filenames with date, topic, and category
  - Intelligent categorization (security, feature, bugfix, performance, etc.)
  - Creates organized `summaries/` directory structure
  - Captures entire chat history with structured output
  - Self-documenting filenames prevent overwrites
  - Perfect for shift changes between AI assistants

- ✨ **Enhanced Workflow Execution** - Improved ROI-based task filtering and tracking
  - `/auto:execute` now supports ROI-based task filtering
  - Better progress tracking in quality improvement commands
  - Enhanced completion reporting with task metrics

- ✨ **Test Infrastructure** - Added comprehensive testing framework
  - Support for Claude Code programmatic mode (-p)
  - Example tests demonstrating best practices
  - Tests adapted to work outside Claude Code environment
  - Comprehensive testing documentation

### Changed

- 🔄 **Documentation Restructuring** - Major reorganization for better usability
  - New quick start workflows prominently featured
  - Simplified 3-step quality improvement process
  - Better separation of user and developer documentation
  - Updated CLAUDE.md with latest command additions

### Fixed

- 🐛 Test compatibility issues when running outside Claude Code environment
- 🐛 Minor documentation inconsistencies in workflow guides

## [3.3.0] - 2025-07-30

### Added

- ✨ **Major Command Restructuring (Phase 1-6)** - Complete overhaul of command organization and naming
  - New category-based structure: `scan`, `fix`, `gen`, `flow`, `auto`, `sec`, `git`, `meta`
  - Shorter, action-oriented command names (e.g., `/scan:deep` instead of `/analyze-deep`)
  - Maximum 2 words per command for better usability
  
- ✨ **Core Workflow Enhancement Commands (Phase 2)**
  - Smart problem routing with `/flow:smart` - intelligently routes to appropriate specialists
  - Multi-perspective code review with `/flow:review` - 5 parallel reviewers
  - Rapid incident response with `/flow:incident`
  
- ✨ **Enhanced Command Syntax (Phase 3)**
  - Clearer Task tool invocation syntax across all commands
  - Improved error handling and user feedback
  - Better structured command outputs
  
- ✨ **Specialized Development Helper Commands (Phase 4)**
  - `/fix:shell` - Automated shell script fixing with shellcheck
  - `/meta:create-cmd` - AI-powered command creation
  - `/meta:health` - Comprehensive project health assessment
  
- ✨ **Integration & Automation Commands (Phase 5)**
  - `/meta:chain` - Command chaining with data flow (`{output}`, `{outputs}`)
  - `/meta:pipelines` - Pre-defined quality improvement pipelines
  - `/auto:monitor` - Continuous quality monitoring
  - `/auto:sprint` - Quality sprint execution
  
- ✨ **New Specialist Agents**
  - `debugging-specialist` - Expert in systematic debugging and root cause analysis
  - `deployment-specialist` - CI/CD and deployment troubleshooting expert
  - `workflow-optimizer` - Developer productivity and workflow optimization

- ✨ **Documentation Overhaul (Phase 6)**
  - New FAQ document for common questions
  - Comprehensive workflow guide
  - Security guide for defensive programming
  - Contributing guidelines

### Changed

- 🔄 **Command Name Migration** - All commands follow new naming convention
  - Analysis commands moved to `scan` category
  - Workflow commands split between `flow` and `auto`
  - Project commands moved to `meta` category
  - See MIGRATION-GUIDE.md for complete mapping
  
- 🔄 **Enhanced Existing Agents**
  - `refactoring-expert` - Extended with performance and testing capabilities
  - All agents improved with better analysis patterns
  
- 🔄 **Documentation Structure**
  - Consolidated guides in `docs/guides/` directory
  - Updated all command references to new naming schema
  - Improved CLAUDE.md with current patterns

### Removed

- 🗑️ Internal planning documents (INTEGRATION-PLAN.md)
- 🗑️ Accidentally committed review/ directory

## [3.2.0] - 2025-07-29

### Added

- ✨ **Performance Fix Command** - New `/fix:performance` command for automated performance optimization
  - Automatically identifies and fixes O(n²) algorithms with Map/Set-based lookups
  - Memory leak fixes for React components and large object allocations
  - Database operation batching and transaction optimization
  - Dry-run mode and automatic backups for safe operation
  - Integration with action plan workflow execution

### Changed

- 🔄 **Enhanced Analysis Commands** - Improved safety and actionability
  - Added READ-ONLY constraints to all analysis scanners in `/analyze-deep`
  - Enhanced `/analyze-report` with specific issue-to-command mapping
  - Action plans now generate executable Markdown files with checkboxes
  - Added cleanup procedures for temporary analysis files
  - Improved next steps commands after each finding

### Fixed

- 🐛 Prevented creation of temporary files during analysis operations
- 🐛 Enhanced safety measures to avoid file modifications in read-only analysis

## [3.1.0] - 2025-01-29

### Added

- ✨ **Revolutionary Automated Workflow** - Complete zero-friction workflow from analysis to fixes
  - New 3-step process: analyze → generate action plan → execute → view results
  - Action plans contain exact fix commands with time estimates
  - ROI-based prioritization for maximum efficiency
- ✨ **Action Plan Generation** - Enhanced `/analyze-report` command with `--generate-action-plan` flag
  - Generates executable todo lists with exact commands
  - Includes time estimates and impact descriptions
  - Supports team allocation mode
- ✨ **Workflow Automation Commands**
  - `/workflow:execute-action-plan` - Executes action plans systematically
  - `/workflow:completion-report` - Generates comprehensive completion reports
- ✨ **Comprehensive Documentation Updates**
  - New AUTOMATED-WORKFLOW.md guide for the zero-friction workflow
  - Complete system architecture documentation (SYSTEM-ARCHITECTURE-EN.md)
  - German technical documentation (SYSTEM-ARCHITECTURE-DE.md)
  - Updated quick-start tutorial with automated workflow
- ✨ **Action Plan Template** - Example template showing action plan structure

### Changed

- 🔄 Updated documentation to prominently feature the new automated workflow
- 🔄 Enhanced comprehensive workflow guide with action plan execution
- 🔄 Improved quick-start tutorial with automated vs manual options

### Fixed

- 🐛 Documentation inconsistencies and outdated references

## [3.0.0] - 2025-01-29

### Changed

- 🔄 **BREAKING**: Local installation flag now requires explicit path argument
  - Previous: `./install.sh mytools --local` (installed in current directory)
  - New: `./install.sh mytools --local /path/to/project` (installs in specified directory)
  - This provides better control and clarity over installation location
  - Prevents accidental installations in wrong directories

### Added

- ✨ Path validation for local installations - checks if target directory exists
- ✨ Improved error messages for missing path argument

## [2.4.0] - 2025-01-29

### Added

- ✨ Flexible Component Selection - replaced individual installation flags with unified `--install` parameter
  - `--install commands` - Install only commands
  - `--install agents` - Install only agents  
  - `--install commands,agents` - Install specific components
  - Extensible design for future component types
- ✨ Local Project Installation Support - new `--local` flag for project-specific installations
  - Installs to `.claude/` in current directory instead of global `~/.claude/`
  - Enables project-specific commands and agents
  - Supports team collaboration via version control
  - All backup and safety mechanisms work for local installations

### Changed

- 🔄 Template Directory Structure - reorganized templates for better organization
  - Moved all command templates to `templates/commands/`
  - Cleaner separation between command and report templates
- 🔄 Installation Script Architecture - more flexible and extensible approach
  - Component-based installation system
  - Better separation of concerns for commands vs agents
  - Improved error handling and user feedback

## [2.3.0] - 2025-01-29

### Added

- ✨ MCP (Model Context Protocol) Integration System - enhanced command functionality with optional MCP server support
  - MCP-aware command template for creating MCP-enhanced commands
  - Comprehensive MCP integration guide in `docs/guides/MCP-INTEGRATION.md`
  - Support for Semgrep MCP, GitHub MCP, GitLab MCP, and Perplexity MCP
  - Graceful fallback when MCP servers are not available
- ✨ Security Commands Category - new security-focused commands
  - `/security/baseline` - Establish and track security baseline with MCP-enhanced scanning
  - `/security/compliance` - Compliance checking (OWASP Top 10, PCI-DSS, GDPR)
- ✨ MCP Enhancement for Existing Commands
  - Security-related commands now leverage Semgrep MCP when available
  - Commands transparently report which tools were used (MCP or traditional)

### Changed

- 🔄 Updated multiple commands to support MCP enhancement while maintaining backward compatibility
- 🔄 Enhanced security-specialist agent to work with MCP tools
- 🔄 Updated CLAUDE.md with MCP integration documentation

## [2.2.0] - 2025-01-28

### Added

- ✨ Comprehensive Documentation Health System - new agent and commands for documentation quality analysis
  - `documentation-health-specialist` agent for doc quality assessment
  - `/analysis/doc-health` command for documentation validation
  - `/fix/documentation` command for automated doc fixes
- ✨ Report Analysis System - intelligent analysis of code quality reports
  - `report-analyzer` agent for report interpretation
  - `/analysis/analyze-report` command with ROI prioritization
  - Trend analysis script for historical tracking
- ✨ Fix Commands Category - automated remediation commands
  - `/fix/quick-wins` - Apply high-ROI fixes automatically
  - `/fix/security` - Fix security vulnerabilities
  - `/fix/duplicates` - Remove code duplication
- ✨ Generate Commands Category - code and documentation generation
  - `/generate/tests` - Generate comprehensive test suites
  - `/generate/documentation` - Generate API docs and READMEs
- ✨ Workflow Commands Category - complete quality improvement workflows
  - `/workflow/quality-sprint` - Plan and execute quality sprints
  - `/workflow/continuous-quality` - Continuous quality monitoring
- ✨ Report Export System - export analysis results in multiple formats
  - Support for Markdown, JSON, and HTML exports
  - Historical tracking with `.report-history.json`
  - Report templates for consistent formatting
- ✨ Comprehensive Workflow Documentation - end-to-end quality improvement guide

### Changed

- 🔄 Major Directory Reorganization
  - Moved `analyze-deep` from `commands/hybrid/` to `commands/analysis/`
  - Reorganized docs into subdirectories: `architecture/`, `guides/`, `tutorials/`, `api/`, `archive/`
  - Added documentation index at `docs/README.md`
- 🔄 Enhanced `analyze-deep` command with report export functionality
- 🔄 Updated all analysis commands to support multiple export formats
- 🔄 Improved CLAUDE.md to reflect new command structure and categories

### Fixed

- 🐛 Documentation references updated to match new directory structure

## [2.1.1] - 2025-01-28

### Fixed

- 🔒 Security: Add READ-ONLY constraints to all analysis commands - prevents unintended file modifications in analysis, research, and orchestration commands

### Changed

- 📝 Improved user documentation with clearer end-user instructions in CLONE-INSTALL-ARCHITECTURE guides

### Removed

- 🗑️ Obsolete test-install.sh script - no longer needed with the new architecture

## [2.1.0] - 2025-01-27

### Added

- ✨ Backup functionality for existing agents during installation - prevents accidental overwriting of custom agents

## [2.0.1] - 2025-01-27

### Added

- ✨ Help documentation support in install script (--help flag)

### Changed

- 🔄 Simplified installation process to use file copy approach instead of Git
- 🔄 Updated permissions in ***REMOVED*** for git operations

## [2.0.0] - 2025-01-27

### Changed

- 🚀 **BREAKING**: Rebranded to "claude-code-toolkit" - now includes Commands, Agents, and Tools
- 🔄 Updated all documentation and scripts for new repository name
- ✨ This is now a comprehensive toolkit, not just commands
- 📦 New repository location: github.com/redpop/claude-code-toolkit

### Note

This release marks the transition from a commands-only repository to a full toolkit including AI agents and tools. All existing functionality is preserved.

## [1.8.0] - 2025-01-27

### Added

- ✨ Hybrid Sub-Agent Orchestration System - combines Task Tool parallelization with Claude Code Sub-Agents for 5-10x performance improvements
- ✨ 5 specialized Sub-Agents: security-specialist, performance-optimizer, test-engineer, code-architect, refactoring-expert
- ✨ Hybrid commands category - new command type that uses three-phase approach (scan, delegate, synthesize)
- ✨ Orchestration commands - 5 new parallel analysis commands (analyze-parallel, security-audit, refactor-impact, test-coverage, performance-scan)
- ✨ Research commands - 3 new research commands (deep-dive, codebase-map, dependency-trace)
- ✨ Create Sub-Agent helper script - allows easy creation of new specialized agents
- ✨ Agent templates - 3 templates for creating specialized, analyzer, and helper agents
- ✨ Hybrid command templates - templates for creating multi-phase analysis commands
- ✨ Extended documentation in docs/ directory - HYBRID-ARCHITECTURE.md and updated TECHNICAL-GUIDE.md

### Changed

- 🔄 Repository structure reorganized - documentation moved to docs/ directory
- 🔄 .claude-commands.json enhanced with hybrid mode configuration and agent registry
- 🔄 create-sub-agent-command.sh updated to support hybrid command creation
- 🔄 Commands now support both Task-based parallelization and Claude Code Sub-Agent delegation
- 🔄 Installation script updated to handle new agents directory structure

### Security

- 🔒 All commands translated from German to English for international usage
- 🔒 Enhanced configuration with performance modes (conservative, balanced, aggressive) for resource management

## [1.7.0] - 2025-01-26

### Added

- ✨ Comprehensive fork support - installation scripts now automatically detect and use fork URLs
- ✨ Repository configuration file (.claude-commands.json) for fork metadata
- ✨ GitHub Actions workflow for automatic fork setup and configuration
- ✨ Dynamic URL detection for multiple git platforms (GitHub, GitLab, Bitbucket)
- ✨ Fork synchronization workflow with upstream repository

### Changed

- 🔄 Installation script now dynamically detects repository URLs instead of using hardcoded values
- 🔄 Git hooks updated to version 5 with improved fork support
- 🔄 Commands updated to use dynamic URL references instead of hardcoded repository paths
- 🔄 README enhanced with comprehensive forking guide and best practices

### Fixed

- 🐛 Hardcoded repository URLs removed throughout the codebase for better fork flexibility

## [1.6.1] - 2025-01-26

### Fixed

- 🐛 Hook version detection bug - improved version extraction to avoid false matches in code

## [1.6.0] - 2025-01-26

### Added

- ✨ Update hooks command - allows updating git hooks to latest version in Claude command installations
- ✨ Custom repository URL support - installation script now respects CLAUDE_COMMANDS_REPO_URL environment variable

### Changed

- 🔄 Git commit command now uses generic pre-commit checks - removed pnpm-specific commands for broader compatibility

### Fixed

- 🐛 Shell script warning in update-hooks.sh - fixed trap command to use single quotes

## [1.5.0] - 2025-01-26

### Added

- ✨ Five Whys analysis command - implements root cause analysis methodology for systematic problem investigation

## [1.4.0] - 2025-01-26

### Added

- ✨ Create command meta-command - helps create new slash commands with proper structure and documentation

### Changed

- 🔄 Create command now uses AI-powered natural language processing - describe what you want and AI generates the complete command

## [1.3.0] - 2025-01-26

### Added

- ✨ Comprehensive documentation update slash command - intelligently updates project docs based on code changes
- ✨ Shellcheck command for automatic shell script fixing - analyzes and fixes shell script issues

### Fixed

- 🐛 Exclude CHANGELOG.md from command installations - prevents CHANGELOG from appearing in ~/.claude/commands directories

## [1.2.0] - 2025-01-26

### Added

- ✨ Push option for git commit command - allows automatic push after commit with `--push`

## [1.1.0] - 2025-01-26

### Added

- ✨ Git sparse checkout for installations - enables simple updates via 'git pull'

### Changed

- 🔄 Installation script now creates proper Git repositories instead of copying files
- 🔄 Update process simplified to use native Git commands

### Fixed

- 🐛 Update instructions in README now reflect actual Git-based workflow

[3.4.2]: https://github.com/redpop/claude-code-toolkit/compare/v3.4.1...v3.4.2
[3.4.1]: https://github.com/redpop/claude-code-toolkit/compare/v3.4.0...v3.4.1
[3.4.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.3.0...v3.4.0
[3.3.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.2.0...v3.3.0
[3.2.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.1.0...v3.2.0
[3.1.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/redpop/claude-code-toolkit/compare/v2.4.0...v3.0.0
[2.4.0]: https://github.com/redpop/claude-code-toolkit/compare/v2.3.0...v2.4.0
[2.3.0]: https://github.com/redpop/claude-code-toolkit/compare/v2.2.0...v2.3.0
[2.2.0]: https://github.com/redpop/claude-code-toolkit/compare/v2.1.1...v2.2.0
[2.1.1]: https://github.com/redpop/claude-code-toolkit/compare/v2.1.0...v2.1.1
[2.1.0]: https://github.com/redpop/claude-code-toolkit/compare/v2.0.1...v2.1.0
[2.0.1]: https://github.com/redpop/claude-code-toolkit/compare/v2.0.0...v2.0.1
[2.0.0]: https://github.com/redpop/claude-code-toolkit/compare/v1.8.0...v2.0.0
[1.8.0]: https://github.com/redpop/claude-code-toolkit/compare/v1.7.0...v1.8.0
[1.7.0]: https://github.com/redpop/claude-code-toolkit/compare/v1.6.1...v1.7.0
[1.6.1]: https://github.com/redpop/claude-code-toolkit/compare/v1.6.0...v1.6.1
[1.6.0]: https://github.com/redpop/claude-code-toolkit/compare/v1.5.0...v1.6.0
[1.5.0]: https://github.com/redpop/claude-code-toolkit/compare/v1.4.0...v1.5.0
[1.4.0]: https://github.com/redpop/claude-code-toolkit/compare/v1.3.0...v1.4.0
[1.3.0]: https://github.com/redpop/claude-code-toolkit/compare/v1.2.0...v1.3.0
[1.2.0]: https://github.com/redpop/claude-code-toolkit/compare/v1.1.0...v1.2.0
[1.1.0]: https://github.com/redpop/claude-code-toolkit/releases/tag/v1.1.0
