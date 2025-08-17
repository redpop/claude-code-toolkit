# Claude Code Toolkit Knowledge Base

## Overview

This knowledge base contains modular documentation for various technologies and patterns, designed to be framework-agnostic and maintainable.

## Structure

### TYPO3

Core TYPO3 and Content Blocks documentation:

- [Content Blocks Core Patterns](./typo3/content-blocks-core-patterns.md) - Framework-agnostic patterns
- [Troubleshooting Matrix](./typo3/troubleshooting-matrix.md) - Quick problem resolution

### Frameworks

Framework-specific integration guides:

- [Alpine.js Integration](./frameworks/alpine-js-integration.md) - Alpine.js with TYPO3 Content Blocks
- React Integration (Coming Soon)
- Vue Integration (Coming Soon)

### UI Patterns

Reusable UI component patterns:

- [Accordion Pattern](./ui-patterns/accordion.md) - Expandable content panels

## Usage

### For Commands

Commands should reference:

1. Core patterns for framework-agnostic information
2. Specific framework guides when using a particular framework
3. UI patterns for component implementation

### For Agents

Agents should:

1. Check modular documentation first
2. Use Context7 MCP for latest updates
3. Reference specific patterns rather than embedding knowledge

## Benefits

### Maintainability

- Framework changes don't affect core patterns
- Easy to add new frameworks
- Clear separation of concerns

### Scalability

- Add new UI patterns without modifying commands
- Framework guides can evolve independently
- Troubleshooting matrix grows with experience

### Reusability

- Patterns work across projects
- Framework guides apply to multiple components
- Knowledge is centralized and consistent

## Contributing

When adding new documentation:

1. Keep framework-specific details in `/frameworks/`
2. Keep UI patterns in `/ui-patterns/`
3. Keep core system knowledge in technology folders (e.g., `/typo3/`)
4. Update this README with new additions

## Quick Links

### Most Used

- [Content Blocks Field Naming](./typo3/content-blocks-core-patterns.md#field-naming-conventions)
- [Alpine.js Data Transfer Pattern](./frameworks/alpine-js-integration.md#data-transfer-pattern)
- [Troubleshooting Quick Table](./typo3/troubleshooting-matrix.md#quick-diagnosis-table)

### Common Issues

- [Database table doesn't exist](./typo3/troubleshooting-matrix.md#problem-database-table-creation-issues)
- [JavaScript syntax errors](./typo3/troubleshooting-matrix.md#problem-javascriptalpinejs-errors)
- [Cache not clearing](./typo3/troubleshooting-matrix.md#problem-cache-not-clearing)
