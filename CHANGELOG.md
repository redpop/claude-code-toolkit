# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2026-02-21

### Fixed

- 🐛 README.md: Corrected plugin installation instructions (use `/plugin` commands, not CLI)
- 🐛 Stop hook: Fixed JSON validation error by adding required `{"ok": true/false}` response format for prompt-type hooks

## [1.0.0] - 2026-02-21

Initial release as AgentKit — a lean, audited plugin marketplace for Claude Code.

### Added

- ✨ 5 plugins: ak-core, ak-git, ak-meta, ak-review, ak-typo3
- ✨ 10 skills across all plugins
- ✨ 9 specialized agents with active Edit/Write capabilities
- ✨ Markdown formatting hook (markdownlint-cli2)
- ✨ Context-aware skill suggestion hook
- ✨ Quality gate hook for task completeness

### Changed

- 🔄 Rebranded from Claude Code Toolkit to AgentKit
- 🔄 All agents upgraded from read-only to active (Edit/Write tools enabled)
- 🔄 Finalize skill streamlined (removed unused flags and phases)
- 🔄 Skill suggestion prompt generalized (no longer hardcoded skill names)
- 🔄 CKEditor knowledge files referenced in sitepackage skill

### Removed

- 🗑️ ak-security plugin (secure skill, debugging/security agents, Semgrep MCP)
- 🗑️ ak-frontend plugin (frontend/tailwind agents, Alpine.js/Tailwind knowledge)
- 🗑️ ak-core: 4 skills (understand, improve, create, ship)
- 🗑️ ak-core: 10 agents (code-architect, project-planner, documentation-specialist, and others)
- 🗑️ ak-meta: mcp skill and manage-mcp.sh script
- 🗑️ ak-typo3: project-setup-context.md knowledge file
