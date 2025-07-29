# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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
