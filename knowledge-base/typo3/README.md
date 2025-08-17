# TYPO3 Knowledge Base

## Overview

This knowledge base contains comprehensive documentation for TYPO3 v13 development, with a focus on Content Blocks and modern development patterns.

## Quick Navigation

### 📦 Sitepackage Documentation

- **[Sitepackage Installation Guide](./sitepackage-installation-guide.md)** - Step-by-step installation and setup
- **[Sitepackage Configuration Guide](./sitepackage-configuration-guide.md)** - Complete configuration reference
- **[Sitepackage Structure Reference](./sitepackage-structure-reference.md)** - Detailed directory and file structure
- **[Sitepackage Practical Examples](./sitepackage-practical-examples.md)** - Real-world implementation examples
- **[Sitepackage v13 Template](./sitepackage-v13-template.md)** - Complete reference template

### 📚 Content Blocks Documentation

- **[Content Blocks Core Patterns](./content-blocks-core-patterns.md)** - Essential patterns and best practices
- **[Shared Partials Configuration](./content-blocks-shared-partials.md)** - Component sharing strategies
- **[Troubleshooting Matrix](./troubleshooting-matrix.md)** - Quick diagnosis and solutions

### 📖 Reference Guides

Quick lookup references for common tasks:

- **[Commands Reference](./references/commands-reference.md)** - All TYPO3 CLI commands in one place
- **[Field Naming Reference](./references/field-naming-reference.md)** - Complete guide to field naming patterns
- **[Backend Preview Reference](./references/backend-preview-reference.md)** - Backend preview template examples

## Document Organization

### Sitepackage Documentation (Complete Guide)

1. **Installation Guide** - Getting started with sitepackages:
   - Composer setup and configuration
   - Extension activation
   - Site configuration
   - Common installation issues

2. **Configuration Guide** - All configuration aspects:
   - Site Sets (TYPO3 v13)
   - TypoScript setup
   - Page TSconfig
   - RTE configuration
   - Backend layouts

3. **Structure Reference** - Complete file organization:
   - Directory structure
   - File purposes
   - Naming conventions
   - Best practices

4. **Practical Examples** - Real-world implementations:
   - Bootstrap integration
   - Custom content elements
   - ViewHelpers and data processors
   - Multi-language setup

### Content Blocks Documentation

1. **Core Patterns** - Foundation concepts:
   - Database table generation
   - Common field types
   - Frontend template structure
   - Version-specific features

2. **Shared Partials** - Component reusability:
   - TypoScript configuration
   - Component organization
   - Path resolution

3. **Troubleshooting** - Problem solving:
   - Quick diagnosis table
   - Common issues
   - Debug checklist

### Reference Documents

Centralized references to eliminate redundancy:

- **Commands** - All CLI commands for cache, database, debugging
- **Field Naming** - Patterns, examples, debugging field names
- **Backend Preview** - Templates, ViewHelpers, best practices

## Quick Start Guides

### New to TYPO3 v13?

1. Start with [Sitepackage v13 Template](./sitepackage-v13-template.md)
2. Review [Content Blocks Core Patterns](./content-blocks-core-patterns.md)
3. Keep [Commands Reference](./references/commands-reference.md) handy

### Debugging Issues?

1. Check [Troubleshooting Matrix](./troubleshooting-matrix.md) first
2. Use [Commands Reference](./references/commands-reference.md#debugging-commands)
3. Review [Field Naming Reference](./references/field-naming-reference.md#debug-field-names)

### Building Content Blocks?

1. Follow [Content Blocks Core Patterns](./content-blocks-core-patterns.md)
2. Use [Shared Partials](./content-blocks-shared-partials.md) for components
3. Reference [Backend Preview Templates](./references/backend-preview-reference.md)

## Key Concepts

### Content Blocks

- Modular content elements for TYPO3
- Automatic database table generation
- YAML-based configuration
- Integrated with TYPO3 v13's Site Sets

### Site Sets (TYPO3 v13)

- New configuration system
- Replaces site packages constants
- Dependencies management
- Structured settings

### PAGEVIEW Content Object

- New in TYPO3 v13
- Replaces FLUIDTEMPLATE
- Better data processing
- Cleaner structure

## Version Information

- **TYPO3 Version**: v13.4
- **Content Blocks**: v1.3
- **Fluid**: v4.3
- **Last Updated**: 2024

## Contributing

When adding new documentation:

1. Check for existing content to avoid redundancy
2. Use references for shared content
3. Follow the established structure
4. Update this index when adding new files

## Related Resources

- [Official TYPO3 Documentation](https://docs.typo3.org)
- [Content Blocks Documentation](https://github.com/TYPO3-Initiatives/content-blocks)
- [TYPO3 Sitepackage Builder](https://get.typo3.org/sitepackage)
