# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.23.0] - 2025-09-02

### Added

- ✨ **TYPO3 Fluid Expert Agent** - New specialized agent for TYPO3 Fluid Template Engine expertise
  - Added typo3-fluid-expert.md with Context7 integration for latest documentation access
  - Specialized in ViewHelper development, template optimization, and performance analysis
  - Supports modern Fluid v13+ features and architectural patterns
  - Enhanced with MCP Context7 integration for up-to-date TYPO3 Fluid documentation

- ✨ **Enhanced Fluid Components Command** - Extended functionality for TYPO3 Fluid template analysis
  - Added --analyze flag to typo3/fluid-components command
  - Enables analysis of existing Fluid templates and components
  - Expanded command description to reflect new analysis capabilities
  - Integrates with typo3-fluid-expert agent for comprehensive template evaluation

### Changed

- 🔄 **Agent Infrastructure Standardization** - Consistent metadata structure across all toolkit agents
  - Added standardized metadata sections to all existing agents (20+ agents updated)
  - Implemented consistent structure: Type, Expertise, Version, Capabilities, MCP Enhanced
  - Improved agent documentation format with clear metadata headers
  - Enhanced agent template with standardized metadata structure and guidance
  - Better agent discoverability and documentation consistency throughout toolkit

- 🔄 **TYPO3 Documentation Enhancement** - Expanded TYPO3 knowledge base and project templates
  - Added TYPO3 project setup context template for Content Blocks development
  - Enhanced TYPO3 Content Blocks v13 complete reference documentation
  - Added comprehensive discovery workflow and development rules for TYPO3 projects
  - Improved project structure guidelines for consistent implementation patterns

### Fixed

- 🔧 **Repository Management** - Clean up tracking and ignore configuration
  - Removed data directory from repository tracking for better repository hygiene
  - Added data directory to gitignore to prevent accidental tracking of temporary files
  - Configured agent models properly in project configuration

## [3.22.1] - 2025-08-28

### Fixed

- 🎨 **Markdown Table Formatting** - Fixed table formatting in command documentation
  - Corrected table separator formatting in README generation
  - Removed unnecessary empty lines between table headers and separators
  - Improved consistency in command documentation tables

## [3.22.0] - 2025-08-24

### Added

- ✨ **Comprehensive Help System** - Added help documentation to all toolkit commands
  - Help check sections in every command file for `--help` or `-h` arguments
  - New `/meta:help-handler` command for centralized help documentation
  - Shell scripts for automated help addition and management
  - Templates for consistent help documentation structure
  - Interactive help support with clear usage examples and options

## [3.21.0] - 2025-08-22

### Added

- ✨ **Universal Linting Command** - New `/fix:lint` command for comprehensive linting across all languages
  - Automatic detection of project linters (ESLint, Prettier, Ruff, Black, etc.)
  - Multi-language support with intelligent orchestration
  - Smart agent routing for complex fixes that can't be auto-fixed
  - Parallel execution for performance optimization
  - Natural language instructions support for focused fixes

## [3.20.0] - 2025-08-22

### Added

- ✨ **Fast Mode for Changelog Command** - New `--fast` option for quick commit-push workflow
  - Single argument combines commit and push operations
  - Streamlines release process with one command
  - Removes need for `--commit --push` combination
  - Automatic analysis without separate `--analyze` flag

- ✨ **Interactive Settings Installation** - Enhanced installer with user-friendly settings management
  - Interactive prompt when settings file exists
  - Automatic timestamped backups before replacement
  - Intelligent Python-based merging preserves non-hook settings
  - Skip option for users who prefer manual configuration

### Changed

- 🔄 **Installation Flow Improvements** - Better handling of existing configurations
  - Skip settings backup when using `--force` flag
  - Graceful fallback to direct copy if Python merge fails
  - Clear user prompts for configuration decisions

## [3.19.1] - 2025-08-22

### Changed

- 🔄 **Figma to Styles Command Enhancement** - Improved command with dual-mode support
  - Add primary Figma MCP integration mode for direct design extraction
  - Implement fallback manual specification mode when Figma unavailable
  - Reorganize workflow to check connection first before processing
  - Clarify documentation for both usage modes with clear prerequisites
  - Simplify core principles to be mode-agnostic

## [3.19.0] - 2025-08-22

### Added

- ✨ **Figma to CSS Conversion** - New `/css:figma-to-styles` command for design-to-code workflow
  - Convert Figma designs to CSS, Tailwind, or SCSS with exact specifications
  - MCP Figma Dev Mode integration for precise value extraction
  - Support for responsive breakpoints and design variants
  - Strict fidelity to Figma values without creative additions

## [3.18.0] - 2025-08-22

### Added

- ✨ **Simplified Commit Command** - New `/git:commit-simple` for clean commits without emojis
  - Intelligent branch prefix extraction for ticket/issue references
  - Smart commit grouping for atomic, logical commits
  - Support for single commits with `--single` flag
  - Brief mode for concise messages with `--brief` flag
  - Fast mode with automatic first suggestion selection

### Changed

- 🔄 **Commit Command Improvements** - Enhanced existing commit command documentation
  - Cleaner example commit messages
  - Silent validation without verbose output
  - Improved formatting and consistency

## [3.17.0] - 2025-08-20

### Added

- ✨ **Help System** - Comprehensive help command with dynamic generation
  - New `/meta:help` command for interactive help and command discovery
  - Generate-help.sh script for automated help documentation
  - Support for multiple help formats: list, search, category, and detail views
  - Help output template for consistent formatting
  - Complete documentation and implementation guide

- ✨ **Tailwind CSS Support** - CSS optimization and analysis tools
  - New tailwind-css-specialist agent for CSS optimization
  - `/css:tailwind-optimize` command for Tailwind analysis
  - Comprehensive Tailwind patterns knowledge base
  - JIT optimization and unused class removal support

- ✨ **Documentation Synchronization** - New `/meta:docs-sync` command for maintaining documentation consistency

### Changed

- 🔄 **Command Documentation** - Enhanced all commands with argument-hint metadata
  - Added argument-hint to all command files for better usage guidance
  - Updated update-readme.sh to support argument-hint display
  - Improved chain command with detailed examples and error handling

- 🔄 **TYPO3 Knowledge Base** - Significant documentation expansion
  - Added comprehensive CKEditor configuration guide with examples
  - Created CKEditor examples reference with toolbar configurations
  - Added TYPO3 DDEV commands reference for local development
  - Updated existing documentation with improved organization

- 🔄 **CLAUDE.md Strategy** - Implemented distributed context approach
  - Updated all CLAUDE.md files with focused, directory-specific context
  - Improved context management and reduced cognitive load
  - Better separation of concerns across different toolkit areas

### Fixed

- 🐛 **Security Audit** - Enhanced sec:audit command with MCP integration support

## [3.16.1] - 2025-08-20

### Changed

- 🔄 **Documentation** - Improved README formatting and structure
  - Added validation warnings for commit command behavior
  - Enhanced command documentation clarity

### Removed

- 🗑️ **Git Conflict Resolver** - Removed experimental conflict resolution feature
  - Removed git-conflict-specialist agent
  - Removed conflict-resolver command
  - Feature needs further refinement before reintroduction

## [3.16.0] - 2025-08-19

### Added

- ✨ **Git Review Command** - New `/git:review` command for comprehensive pre-commit quality checks
  - Analyzes all staged and unstaged changes before committing
  - Checks for code quality issues, redundancies, and potential problems
  - Provides structured report with severity levels (Good/Warning/Issues/Recommendations)
  - Supports `--staged-only` and `--detailed` options for focused reviews
  - Includes commit organization analysis and splitting recommendations
  - Updated README documentation with new command reference

## [3.15.2] - 2025-01-18

### Fixed

- 🐛 **Markdown Format Hook** - Fixed JSON parsing for Claude Code compatibility
  - Updated to use "tool_name" instead of "tool" field in JSON structure
  - Added Python fallback for extracting file_path from tool_input object
  - Made markdownlint-cli2 run synchronously to prevent race conditions
  - Removed background execution to ensure formatting completes before file use

## [3.15.1] - 2025-01-18

### Fixed

- 🐛 **Installation Script** - Fixed duplicate file issue during command installation
  - Corrected file copying logic to preserve directory structure properly
  - Prevented creation of duplicate command files in target directory
  - Commands now correctly install in their hierarchical subdirectories

## [3.15.0] - 2025-01-17

### Added

- ✨ **Agent Metadata Standardization** - YAML frontmatter for Claude Code compatibility
  - Added required `name` and `description` fields to all TYPO3 agents
  - Ensures proper agent parsing and discovery in Claude Code environment
  - Standardized agent metadata structure across toolkit

### Changed

- 🔄 **Major Documentation Restructure** - Streamlined and consolidated documentation
  - Reduced total documentation size by ~8,500 lines while preserving essential information
  - Consolidated overlapping guides into focused, practical documentation
  - Restructured docs/CLAUDE.md for better navigation and AI context management
  - Improved cross-references and eliminated redundant content across multiple files
  - Enhanced FAQ and installation documentation with clearer, more concise information

- 🔄 **Documentation Organization** - Better structure and navigation
  - Created consolidated ADVANCED-WORKFLOWS.md and HOOKS-AND-NOTIFICATIONS.md guides
  - Moved deprecated CONTEXT-ENGINEERING-INTEGRATION.md to planning/ directory
  - Removed outdated workflow guides that overlapped with current documentation
  - Standardized documentation formatting and structure throughout toolkit

### Removed

- 🗑️ **Outdated Documentation** - Cleaned up obsolete and redundant files
  - Removed ADVANCED-HOOKS.md, COMPREHENSIVE-WORKFLOW.md, EXPORT-EXAMPLES.md
  - Removed MODERN-WORKFLOW.md, SOUND-NOTIFICATIONS.md for consolidation
  - Moved CONTEXT-ENGINEERING-INTEGRATION.md to planning/ for future reference

## [3.14.1] - 2025-01-17

### Changed

- 🔄 **Documentation Formatting** - Improved markdown consistency across entire codebase
  - Added proper line breaks after list headers in all documentation files
  - Enhanced readability of agents, commands, and knowledge base documentation
  - Standardized markdown formatting patterns throughout the toolkit

### Fixed

- 🐛 Removed obsolete test-project directory containing example code files

## [3.14.0] - 2025-01-17

### Added

- ✨ **Advanced Hook Scripts** - Comprehensive notification and monitoring system
  - `tool-specific-notification.sh` - Different sounds for different tools (Write→Pop, Bash→Tink, Task→Submarine)
  - `subagent-notification.sh` - Agent-specific completion sounds (Security→Hero, Tests→Ping, Performance→Funk)
  - `error-detection.sh` - Critical error alerts with macOS notifications
  - `success-notification.sh` - Success celebrations for operations and milestones
  - `system-notification.sh` - macOS system notifications for important events
  - `command-chain-notification.sh` - Progress tracking through command chains with ascending tones
  - `session-logger.sh` - Session metrics, JSON summaries, and activity logging

- ✨ **Hook Profile System** - Three configuration profiles for different needs
  - Basic profile: Simple stop notification only
  - Minimal profile: Stop notifications + critical error detection
  - Advanced profile: All hooks active with full notifications and logging
  - New `--hooks-profile` installation flag to choose configuration level

- ✨ **Advanced Hooks Documentation** - Comprehensive guides for hook system
  - `docs/guides/ADVANCED-HOOKS.md` - Complete guide for all advanced hooks
  - Configuration examples for different use cases
  - Platform-specific setup instructions
  - Troubleshooting and best practices

### Changed

- 🔄 **Installation Script Enhancement** - Profile-based hook configuration
  - Added `--hooks-profile` option with basic/minimal/advanced choices
  - Intelligent settings merging preserves existing configurations
  - Automatic backup creation when using --force
  - Profile-specific installation messages showing active features
  - Renamed `global-settings.json` to `basic-hooks-settings.json` for consistency

- 🔄 **Hook System Architecture** - Improved organization and capabilities
  - All hooks use silent-fail design to prevent workflow disruption
  - Background execution for all sound and notification operations
  - Context-aware notifications based on operation type and outcome
  - State tracking for command chains and sessions

### Fixed

- 🐛 Settings merge now preserves non-hook configurations when updating
- 🐛 Hook scripts properly handle JSON input validation
- 🐛 Installation script creates proper backups before overwriting

## [3.13.0] - 2025-01-17

### Added

- ✨ **Distributed Context Management System** - CLAUDE.md files in each directory for focused context
  - Added context files in agents/, commands/, scripts/, docs/, templates/, knowledge-base/, hooks/
  - Each file provides specific guidelines for its area
  - Reduces cognitive load and improves context relevance
  - Better separation of concerns for Claude Code guidance

- ✨ **Hook System Support** - Integration with Claude Code hooks for sound notifications
  - New `hooks/` directory with stop-notification script
  - Global settings.json support with `--with-settings` install flag
  - Hook scripts for user-prompt-submit and tool-submit events
  - Sound notification system for task completion feedback

- ✨ **Settings Management System** - Global settings configuration for Claude Code
  - New `settings/` directory with template settings.json
  - Support for customizing tool permissions and behaviors
  - Integration with hook system for enhanced functionality
  - Automatic settings installation with `--with-settings` flag

### Changed

- 🔄 **CLAUDE.md Restructuring** - Complete rewrite for clarity and efficiency
  - Simplified main CLAUDE.md to focus on quick start and essential workflows
  - Moved detailed instructions to directory-specific context files
  - Improved workflow documentation with clear pipeline examples
  - Better organization of quick start commands and patterns

- 🔄 **Installation Script Enhancement** - Additional installation options
  - Added `--with-settings` flag for global settings.json installation
  - Support for hooks component installation
  - Updated help documentation with new options
  - Better handling of settings and hook configurations

- 🔄 **Documentation Updates** - Comprehensive improvements to command options
  - Updated README with more detailed flag documentation for all commands
  - Added missing short flags and options for multiple commands
  - Improved handoff command documentation with new flag syntax
  - Better organization of command tables with clearer option descriptions

### Removed

- 🗑️ **.claude-commands.json** - No longer needed as repository metadata

## [3.12.0] - 2025-01-17

### Added

- ✨ **Distributed Context Management System** - CLAUDE.md files in each directory for focused context
  - Added context files in agents/, commands/, scripts/, docs/, templates/, knowledge-base/, hooks/
  - Each file provides specific guidelines for its area
  - Reduces cognitive load and improves context relevance
  - Better separation of concerns for Claude Code guidance

- ✨ **Hook System Support** - Integration with Claude Code hooks for sound notifications
  - New `hooks/` directory with stop-notification script
  - Global settings.json support with `--with-settings` install flag
  - Hook scripts for user-prompt-submit and tool-submit events
  - Sound notification system for task completion feedback

### Changed

- 🔄 **CLAUDE.md Restructuring** - Complete rewrite for clarity and efficiency
  - Simplified main CLAUDE.md to focus on quick start and essential workflows
  - Moved detailed instructions to directory-specific context files
  - Improved workflow documentation with clear pipeline examples
  - Better organization of quick start commands and patterns

- 🔄 **Installation Script Enhancement** - Additional installation options
  - Added `--with-settings` flag for global settings.json installation
  - Support for hooks component installation
  - Updated help documentation with new options
  - Better handling of settings and hook configurations

- 🔄 **Documentation Updates** - Comprehensive improvements to command options
  - Updated README with more detailed flag documentation for all commands
  - Added missing short flags and options for multiple commands
  - Improved handoff command documentation with new flag syntax
  - Better organization of command tables with clearer option descriptions

## [3.11.2] - 2025-01-16

### Changed

- 🔄 **Command Argument Hints** - Improved auto-completion support
  - Updated argument-hints in 6 commands to include all available flags
  - Added missing flags for `auto/execute`, `auto/monitor`, `auto/report` commands
  - Added missing flags for `fix/duplicates` and `typo3/sitepackage` commands
  - Ensures all short flags (like `-c`, `-t`) are documented in argument-hints

### Security

- 🔒 **Handoff Command Safety** - Added critical safety guards
  - Added prominent safety notices to prevent unintended code modifications
  - Explicitly documented that handoff is READ-ONLY (analysis only)
  - Added "DOES NOT Do" section listing prohibited actions
  - Added implementation instructions emphasizing safety-first approach
  - Prevents accidental code changes when using any flag combination

## [3.11.1] - 2025-01-16

### Changed

- 🔄 **Handoff Command - Advanced Flag System** - Complete redesign with structured arguments
  - Added `--compact` (`-c`) flag for condensed 10-sentence handoffs
  - Added `--technical` (`-t`) flag to force technical details in compact mode
  - Added `--focus <topic>` flag to emphasize specific areas (repeatable)
  - Added `--skip <topic>` flag to exclude topics (repeatable)
  - Added `--include <topic>` flag to explicitly include topics (repeatable)
  - Supports flag combinations: `/handoff debug.md --compact --technical --focus "performance"`
  - Maintains backward compatibility with original instruction format
  - Adaptive behavior based on project type (code vs non-code)
  - Structured compact format with strict sentence limits per section

## [3.11.0] - 2025-01-16

### Added

- ✨ **Standardized Agent Creation Workflow** - Robust agent creation system with validation
  - New `scripts/create-agent.sh` script for automated agent creation
  - Standardized `templates/agent-template.md` with required fields
  - Comprehensive `docs/guides/AGENT-CREATION-WORKFLOW.md` documentation
  - Validates agent names, types, and required frontmatter fields
  - Ensures all agents have required `name` field for Claude Code compatibility
  - Auto-detects expertise domain based on agent name

- ✨ **Enhanced Handoff Command** - Additional instructions support
  - Now accepts custom instructions after filename parameter
  - Supports focus directives: `"focus on database issues"`
  - Allows exclusion rules: `"skip resolved issues"`
  - Multiple instructions can be combined in one quoted string
  - Intelligent parsing distinguishes filenames from instructions

### Changed

- 🔄 **Meta Create Command** - Integrated with standardized workflow
  - Now uses `scripts/create-agent.sh` for agent creation
  - Ensures proper frontmatter with required fields
  - Links to agent creation workflow documentation
  - Validates all created agents for Claude Code compatibility

- 🔄 **Documentation Updates** - Improved clarity and workflow guidance
  - Updated CLAUDE.md with agent creation best practices
  - Enhanced README with simplified quick start workflows
  - Added agent creation workflow to documentation index
  - Improved tutorials for creating specialized agents

## [3.10.0] - 2025-01-15

### Added

- ✨ **New Debug Mode Command** - Context-aware intensive debugging mode switch
  - New `/prefix:flow:debug-mode` command for instant debugging mode activation
  - Automatically analyzes current chat context - no problem description needed
  - Activates debugging-specialist agent with ultra intensive reasoning
  - Supports `--verbose` and `--trace` options for extra detail
  - Perfect for when standard debugging approaches have failed

- ✨ **Ultra Deep Thinking Integration** - Enhanced reasoning for debugging commands
  - All debugging-related commands now use "ultra deep thinking" patterns
  - Enhanced `/prefix:scan:root-cause` with ultra intensive root cause analysis
  - Updated `/prefix:flow:incident` with ultra deep investigation at every phase
  - Improved `/prefix:flow:smart` with ultra deep problem analysis and routing
  - debugging-specialist and performance-optimizer agents enhanced with maximum reasoning depth
  - Consistent "think ultra deeply" terminology throughout debugging workflows

### Changed

- 🔄 **Root Cause Analysis Command** - Complete overhaul with ultra intensive reasoning
  - Now uses debugging-specialist agent instead of simple Five Whys
  - Implements ultra deep thinking at every analysis level
  - Enhanced with subtle pattern detection and hidden connection discovery
  
- 🔄 **Incident Response Workflow** - Upgraded all analysis phases
  - System diagnostics now use debugging-specialist with ultra deep investigation
  - Code analysis employs ultra intensive reasoning for bug detection
  - Performance investigation uses performance-optimizer agent
  - All phases emphasize thinking ultra deeply about cascading effects

## [3.9.0] - 2025-01-13

### Added

- ✨ **Enhanced Shell Script Fix Command** - Path-specific shellcheck functionality
  - Added optional path/file parameter to check specific files or directories
  - Supports targeted analysis: `/shellcheck docker/helpers/` for specific folders
  - Can analyze individual scripts: `/shellcheck path/to/script.sh`
  - Maintains backward compatibility for full project scans
  - Improved script discovery logic for better shell script detection

## [3.8.0] - 2025-01-13

### Added

- ✨ **Version Tracking System** - Automatic version tracking in installation
  - Saves Git commit hash, date, and branch during installation
  - Shows available updates when re-running installation script
  - New `/prefix:meta:version` command to check installed version
  - Displays commit history since last installation

- ✨ **Enhanced Format Command** - Major improvements to content formatting
  - New `--html-simple` option for flat HTML fragments without wrapper elements
  - Renamed `--jira` to `--confluence` for accurate naming
  - Proper Confluence storage format with HTML tags and structured macros
  - Added language detection for code blocks (bash, js, python, xml, etc.)
  - Optional title parameter for code blocks in Confluence
  - Comprehensive HTML entity escaping rules (& must be escaped first!)
  - Support for Du-Form (informal German) as default language style

### Changed

- 🔄 **Format Command Confluence Support** - Complete rewrite for Confluence compatibility
  - Uses HTML tags: `<strong>`, `<em>`, `<h1>`-`<h6>`, `<p>`, `<ul>`, `<ol>`, `<table>`
  - Inline code with `<code>` tags (with proper entity escaping)
  - Code blocks with `ac:structured-macro` and language parameter
  - CDATA wrapping for code content (no escaping needed inside)

### Fixed

- 🐛 **HTML Entity Escaping** - Critical fixes for valid HTML output
  - Proper escape order: & → &amp; (first), then <, >, ", '
  - Examples: "x < 5 && y > 3" → "x &lt; 5 &amp;&amp; y &gt; 3"
  - Applies to all HTML-based formats (HTML, HTML-Simple, Confluence)

## [3.7.0] - 2025-01-13

### Added

- ✨ **Format Command** - New universal content formatting command `/prefix:gen:format`
  - Converts between HTML, Markdown, Jira markup, and plain text formats
  - Creates clean, semantic HTML without CSS or JavaScript
  - Generates Jira-compatible markup for stories, bugs, tasks, and epics
  - Intelligently names output files based on content analysis
  - Supports multiple input sources including files and URLs
  - Automatically generates timestamped output files
  - Perfect for creating Confluence documentation, Jira tickets, and clean HTML

## [3.6.5] - 2025-01-11

### Fixed

- 🐛 **Command Finder Execution Prevention** - Completely fixed meta:find-cmd to never execute tasks
  - Removed all agent invocations and code analysis from command finder
  - Simplified to pure command discovery and recommendation engine
  - No longer calls refactoring-expert or other agents during discovery
  - Drastically shortened command to focus only on listing available commands
  - Added explicit warnings to prevent any task execution during discovery

## [3.6.4] - 2025-01-11

### Changed

- 🔄 **Command Finder Behavior** - Improved meta:find-cmd to show recommendations instead of executing
  - Now presents clear command recommendations first
  - Removed automatic task execution behavior
  - Shows explicit command options with descriptions and examples
  - Added clear note that commands are recommendations only, not auto-executed
  - Provides workflow suggestions for complex tasks like refactoring

## [3.6.3] - 2025-01-11

### Fixed

- 🐛 **Command Finder Accuracy** - Fixed meta:find-cmd to only suggest actual existing commands
  - Now properly searches through real command files in the toolkit
  - Prevents suggesting non-existent commands like `/task`
  - Correctly identifies commands from both global (`~/.claude/`) and local (`.claude/`) directories
  - Searches for agents in both global and project-local locations
  - Marks commands and agents with [GLOBAL] or [LOCAL] source indicators

## [3.6.2] - 2025-01-11

### Added

- ✨ **Knowledge Base Installation Support** - Knowledge base is now properly installed during toolkit setup
  - Created dedicated `~/.claude/claude-code-toolkit/` directory for toolkit resources
  - Knowledge base is automatically copied to `~/.claude/claude-code-toolkit/knowledge-base/`
  - Supports both global and local project installations
  - Includes automatic backup mechanism for existing knowledge base during updates

### Changed

- 🔄 **Updated Command Path References** - Fixed knowledge base references in commands
  - Updated TYPO3 commands to reference correct knowledge base path
  - Changed from relative paths to absolute paths (`~/.claude/claude-code-toolkit/knowledge-base/`)
  - Ensures commands work correctly after global installation

### Fixed

- 🐛 **Global Installation Knowledge Base Access** - Resolved missing knowledge base issue
  - Commands now correctly reference knowledge base after global installation
  - Fixed path resolution for TYPO3 content-blocks, fluid-components, and sitepackage commands
  - Knowledge base is now accessible from any project when globally installed

## [3.6.1] - 2025-08-11

### Added

- ✨ **Comprehensive TYPO3 Sitepackage Documentation** - Complete guide for sitepackage creation and configuration
  - Added sitepackage installation guide with step-by-step instructions
  - Added sitepackage configuration guide covering Site Sets, TypoScript, TSconfig, and RTE
  - Added sitepackage structure reference with complete directory organization
  - Added practical examples with Bootstrap 5 integration, custom content elements, and ViewHelpers
  - Created centralized TYPO3 knowledge base index (README.md) for better navigation
  
- ✨ **TYPO3 Knowledge Base Reference System** - Centralized references to eliminate redundancy
  - Added commands reference for all TYPO3 CLI commands
  - Added field naming reference for Content Blocks naming patterns
  - Added backend preview reference with template examples

### Changed

- 🔄 **Restructured TYPO3 Knowledge Base** - Eliminated redundancies and improved organization
  - Reduced documentation redundancy from ~25% to <5%
  - Reorganized content into primary documents and reference guides
  - Updated existing documents to use cross-references instead of duplicating content
  - Improved navigation with comprehensive README index

### Fixed

- 🐛 **Documentation Redundancies** - Removed duplicate content across TYPO3 documentation
  - Consolidated cache clearing commands into single reference
  - Unified field naming patterns in dedicated reference
  - Centralized backend preview templates
  - Eliminated duplicate shared partials configuration

## [3.6.0] - 2025-01-10

### Added

- ✨ **Official TYPO3 v13 Sitepackage Template Integration** - Complete reference implementation from get.typo3.org
  - Added comprehensive knowledge base with full sitepackage template (`knowledge-base/typo3/sitepackage-v13-template.md`)
  - Includes all file contents from official TYPO3 v13.4 sitepackage generator
  - Complete Site Sets configuration with config.yaml, settings.yaml, and TypoScript
  - PAGEVIEW content object implementation for modern page rendering
  - Backend layout configuration via TSconfig
  - RTE preset configuration with CKEditor
  - XLF localization files for frontend and backend
  - Full Fluid Styled Content integration

### Changed

- 🔄 **Enhanced TYPO3 Sitepackage Command** - Updated to use official template
  - `/typo3:sitepackage` now creates packages based on official TYPO3 v13 template
  - All file contents embedded inline - no external dependencies required
  - Complete directory structure matching get.typo3.org/sitepackage
  - Modern Site Sets configuration (v13) instead of legacy TypoScript
  - PAGEVIEW content object for page rendering
  - Proper PSR-4 autoloading structure
  - Consolidated functionality - removed duplicate sitepackage-v13 command

- 🔄 **Updated TYPO3 Architect Agent** - Added official template reference
  - Now references official sitepackage template as best practice
  - Documents Site Sets configuration patterns from official template
  - Includes PAGEVIEW content object guidance
  - Enhanced with official directory structure recommendations

## [3.5.3] - 2025-08-08

### Changed

- 🔄 **Standardized Task Tool Invocation Syntax** - Unified Task tool syntax across all commands
  - Converted 38 inline Task invocations to structured format in 7 files
  - Affected commands: `/scan:perf` (7 agents), `/scan:map` (10 agents), `/scan:explore` (8 agents), `/sec:audit` (8 agents)
  - Previously completed: `/scan:deps` (6 agents), `/scan:refactor` (6 agents), `/scan:tests` (5 agents)
  - Improves consistency, readability, and maintainability across the toolkit
  - All commands now use the same `Use Task tool with subagent_type=...` pattern

- 🔄 **Enhanced TYPO3 Content Blocks Specialist** - Improved backend preview best practices
  - Added comprehensive guidelines for semantic HTML-only backend previews
  - Emphasized no styling in backend preview templates (no CSS, no inline styles)
  - Updated with clear DO/DON'T examples for backend preview implementation
  - Better documentation for TYPO3 v13.4 Content Blocks v1.3 compatibility

### Removed

- 🗑️ `/fix:smart` command - Eliminated redundancy with `/flow:smart`
  - All functionality already available in `/flow:smart` command
  - Reduces confusion and maintains single source of truth for intelligent problem routing
  - Users should use `/flow:smart` for all intelligent routing needs

### Fixed

- 🐛 **Toolkit Consistency Issues** - Applied auto-fixes from self-analysis
  - Fixed inconsistent Task tool invocation patterns across 38 agent definitions
  - Resolved command redundancy between `fix:smart` and `flow:smart`
  - Updated README.md to reflect current command structure

## [3.5.2] - 2025-08-08

### Added

- ✨ **Toolkit Self-Analysis Command** - New `/meta:analyze-toolkit` command for comprehensive toolkit analysis
  - Analyzes all commands and agents for redundancies and inconsistencies
  - Detects overlapping functionality and suggests consolidation opportunities
  - Performs quality checks on documentation and naming conventions
  - Tracks evolution trends and technical debt indicators
  - Generates prioritized refactoring plans with risk assessment
  - Optional auto-fix mode for safe, non-breaking improvements
  - Exports analysis results in JSON and Markdown formats

### Changed

- 🔄 **Merged Pipelines into Chain Command** - Consolidated command chaining functionality
  - All pipeline functionality from `/meta:pipelines` now integrated into `/meta:chain`
  - Pre-defined workflows now accessible through chain command templates
  - Simplified command structure by removing redundant pipeline command
  - Enhanced chain command with pipeline examples and templates

- 🔄 **Simplified Command Creation** - Unified intelligent creation process
  - Merged `/meta:create-cmd` functionality into new `/meta:create` command
  - Single command now intelligently determines resource type (command, agent, or workflow)
  - Maintains all previous functionality with improved detection logic
  - Reduces command redundancy while preserving all capabilities

### Removed

- 🗑️ `/meta:pipelines` command - Functionality merged into `/meta:chain`
- 🗑️ `/meta:create-cmd` command - Functionality merged into `/meta:create`

## [3.5.1] - 2025-08-08

### Added

- ✨ **Unified Command Creation** - New `/meta:create` command replaces and enhances previous creation commands
  - Intelligently detects whether you need a command, agent, or complete workflow from description
  - Automatic resource reusability checking - reuses existing agents when possible
  - Smart technology detection (Laravel, Vue, TYPO3, React, etc.) with auto-category creation
  - Zero configuration needed - handles naming, templates, integration, and documentation automatically
  - Replaces and merges functionality from previous `/meta:create-cmd` and smart-create commands

- ✨ **Developer Process Improvements** - New checklist and workflows for adding command categories
  - Created comprehensive checklist at `docs/developer-guide/adding-new-category-checklist.md`
  - Step-by-step guide for adding new technology integrations (TYPO3, Laravel, etc.)
  - Template for updating find-cmd.md with proper keyword discovery
  - Git commit structure recommendations for complete category additions

### Changed

- 🔄 **Enhanced TYPO3 Integration Discovery** - Improved command discoverability and MCP integration
  - Added comprehensive TYPO3 keywords to `/meta:find-cmd` for better command discovery
  - Enhanced TYPO3 commands with MCP (Model Context Protocol) integration documentation
  - Added agent discovery workflow to find-cmd for complete resource mapping
  - Improved TYPO3 Content Blocks specialist agent with additional expertise areas

- 🔄 **Simplified Command Creation Workflow** - Unified intelligent creation process
  - Single `/meta:create` command now handles all creation scenarios
  - Automatic agent reusability checking prevents duplicate agent creation
  - Improved command/agent creation workflow with better integration

### Fixed

- 🐛 **TYPO3 Command Discovery** - Fixed missing TYPO3 category in find-cmd command
  - Added missing TYPO3 section with all relevant keywords and commands
  - Ensures users can discover TYPO3 commands through natural language queries
  - Prevents future oversights when adding new integrations through developer checklist

## [3.5.0] - 2025-08-07

### Added

- ✨ **TYPO3 Integration** - Complete TYPO3 v13.4 development support with Content Blocks v1.3
  - Four new TYPO3-specific commands in `/commands/typo3/`:
    - `/typo3:sitepackage` - Creates complete TYPO3 v13.4 SitePackages with Site Sets
    - `/typo3:content-blocks` - Generates Content Blocks v1.3 configurations with all field types
    - `/typo3:make-content-block` - Intelligent wrapper for native `make:content-block` command
    - `/typo3:extension-kickstarter` - Creates TYPO3 extensions with best practices
  - Four specialized TYPO3 AI agents:
    - `typo3-architect` - TYPO3 architecture and best practices expert
    - `typo3-content-blocks-specialist` - Content Blocks v1.3 master
    - `typo3-extension-developer` - Extbase/Fluid development specialist
    - `typo3-typoscript-expert` - Modern TypoScript and Site Sets expert
  - Full Content Blocks v1.3 feature support:
    - Collection child type restrictions
    - Default configurations (content-blocks.yaml)
    - Core page type re-definition
    - Page type compatibility with FLUIDTEMPLATE (not PAGEVIEW)
  - Skeleton templates for rapid development (hero, card-grid, accordion, landing-page)
  - Integration with stefanfroemken/ext-kickstarter
  - Comprehensive documentation in `docs/archive/TYPO3-INTEGRATION.md`

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
  - See docs/archive/MIGRATION-GUIDE.md for complete mapping
  
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

[3.13.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.12.0...v3.13.0
[3.12.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.11.2...v3.12.0
[3.11.2]: https://github.com/redpop/claude-code-toolkit/compare/v3.11.1...v3.11.2
[3.11.1]: https://github.com/redpop/claude-code-toolkit/compare/v3.11.0...v3.11.1
[3.11.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.10.0...v3.11.0
[3.10.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.9.0...v3.10.0
[3.9.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.8.0...v3.9.0
[3.8.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.7.0...v3.8.0
[3.7.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.6.5...v3.7.0
[3.6.5]: https://github.com/redpop/claude-code-toolkit/compare/v3.6.4...v3.6.5
[3.6.4]: https://github.com/redpop/claude-code-toolkit/compare/v3.6.3...v3.6.4
[3.6.3]: https://github.com/redpop/claude-code-toolkit/compare/v3.6.2...v3.6.3
[3.6.2]: https://github.com/redpop/claude-code-toolkit/compare/v3.6.1...v3.6.2
[3.6.1]: https://github.com/redpop/claude-code-toolkit/compare/v3.6.0...v3.6.1
[3.6.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.5.3...v3.6.0
[3.5.3]: https://github.com/redpop/claude-code-toolkit/compare/v3.5.2...v3.5.3
[3.5.2]: https://github.com/redpop/claude-code-toolkit/compare/v3.5.1...v3.5.2
[3.5.1]: https://github.com/redpop/claude-code-toolkit/compare/v3.5.0...v3.5.1
[3.5.0]: https://github.com/redpop/claude-code-toolkit/compare/v3.4.2...v3.5.0
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
