# CLAUDE.md - Knowledge Base Directory

This file provides context for Claude Code when working with the knowledge base in this directory.

## Knowledge Base Overview

The knowledge base contains specialized documentation, patterns, and reference materials for specific technologies and frameworks. This supplements the toolkit with domain-specific knowledge.

## Directory Structure

### Main Categories

- **frameworks/** - Framework-specific patterns and integrations
- **typo3/** - TYPO3 CMS development resources
- **ui-patterns/** - Reusable UI component patterns

## TYPO3 Resources

The TYPO3 section is particularly comprehensive:

### Core Documentation

- `README.md` - TYPO3 section overview
- `content-blocks-core-patterns.md` - Content Blocks patterns
- `content-blocks-shared-partials.md` - Shared partial templates
- `sitepackage-configuration-guide.md` - Configuration guide
- `sitepackage-installation-guide.md` - Installation instructions
- `sitepackage-practical-examples.md` - Real-world examples
- `sitepackage-structure-reference.md` - Directory structure
- `sitepackage-v13-template.md` - TYPO3 v13 template
- `troubleshooting-matrix.md` - Common issues and solutions

### Reference Materials (`typo3/references/`)

- `backend-preview-reference.md` - Backend preview configuration
- `commands-reference.md` - TYPO3 CLI commands
- `field-naming-reference.md` - Field naming conventions

### Related TYPO3 Agents

- `typo3-architect` - System architecture specialist
- `typo3-content-blocks-specialist` - Content Blocks expert
- `typo3-extension-developer` - Extension development
- `typo3-typoscript-expert` - TypoScript configuration

### Related TYPO3 Commands

- `/prefix:typo3:content-blocks` - Create Content Blocks
- `/prefix:typo3:extension-kickstarter` - Scaffold extensions
- `/prefix:typo3:fluid-components` - Generate Fluid components
- `/prefix:typo3:make-content-block` - Individual block creation
- `/prefix:typo3:sitepackage` - Sitepackage setup

## Framework Patterns

### Alpine.js Integration

- `frameworks/alpine-js-integration.md` - Alpine.js patterns and best practices

### UI Patterns

- `ui-patterns/accordion.md` - Accordion component implementation

## Using the Knowledge Base

### For Reference

Knowledge base files provide:

- Implementation patterns
- Best practices
- Configuration examples
- Troubleshooting guides
- Architecture decisions

### For Commands and Agents

Commands and agents can reference knowledge base materials:

```markdown
Refer to knowledge-base/typo3/content-blocks-core-patterns.md for Content Blocks implementation patterns.
```

### For Learning

Use knowledge base for:

- Understanding specific technologies
- Learning implementation patterns
- Finding configuration examples
- Solving common problems

## Adding to the Knowledge Base

### When to Add Content

Add to the knowledge base when:

1. Documentation is technology-specific
2. Content is reference material
3. Patterns are reusable across projects
4. Information supplements commands/agents

### Structure Guidelines

1. **Organization**: Group by technology/framework
2. **Naming**: Use descriptive, searchable names
3. **Format**: Consistent markdown structure
4. **Examples**: Include practical code examples
5. **Cross-references**: Link related materials

### Content Types

**Guides** - Step-by-step instructions

- Installation procedures
- Configuration walkthroughs
- Integration guides

**References** - Lookup materials

- API documentation
- Configuration options
- Naming conventions

**Patterns** - Reusable solutions

- Architecture patterns
- Code patterns
- UI components

**Troubleshooting** - Problem-solving

- Error matrices
- Common issues
- Debug procedures

## Best Practices

### Documentation Standards

1. **Accuracy**: Verify all technical information
2. **Versions**: Note compatible versions
3. **Testing**: Test all code examples
4. **Updates**: Keep current with technology changes
5. **Sources**: Credit external sources

### File Organization

- Use subdirectories for logical grouping
- Keep related files together
- Maintain consistent naming
- Include README files for sections
- Cross-reference related content

## Integration with Toolkit

### Command Enhancement

Commands can leverage knowledge base:

```yaml
---
description: TYPO3 Content Blocks creation
knowledge-base: typo3/content-blocks-core-patterns.md
---
```

### Agent Specialization

Agents reference domain knowledge:

```markdown
You are a TYPO3 specialist. Refer to knowledge-base/typo3/ for TYPO3-specific patterns and best practices.
```

## Maintenance

### Keeping Current

1. **Technology Updates**: Track framework/CMS updates
2. **Pattern Evolution**: Update patterns as they evolve
3. **User Feedback**: Incorporate real-world experiences
4. **Deprecation**: Mark outdated content clearly
5. **Migration**: Provide upgrade paths

### Quality Assurance

- Review for technical accuracy
- Test code examples regularly
- Update version compatibility
- Fix broken links
- Clarify ambiguous content

## Quick Reference

### Most Used Resources

**TYPO3 Development**:

- Sitepackage guides
- Content Blocks patterns
- Troubleshooting matrix

**Frontend Patterns**:

- Alpine.js integration
- UI component patterns

### Finding Information

1. Check main README for overview
2. Browse category directories
3. Search for specific terms
4. Follow cross-references
5. Consult troubleshooting guides
