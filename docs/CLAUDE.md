# CLAUDE.md - Documentation Directory

This file provides context for Claude Code when working with documentation in this directory.

## Documentation Structure

The documentation is organized to serve different audiences and purposes:

### Directory Organization

- **architecture/** - Technical architecture and design documentation
- **guides/** - Practical how-to guides and workflows
- **tutorials/** - Step-by-step learning materials
- **user-guide/** - End-user documentation
- **developer-guide/** - Developer and contributor documentation
- **api/** - API references and specifications
- **archive/** - Historical and deprecated documentation

## Key Documentation Files

### Architecture Documentation

- `HYBRID-ARCHITECTURE.md` - Hybrid command architecture guide
- `SUB-AGENT-ORCHESTRATION.md` - Agent orchestration patterns
- `SYSTEM-ARCHITECTURE.md` - Overall system design
- `TECHNICAL-GUIDE.md` - Technical implementation details

### Essential Guides

- `guides/QUICK-START.md` - Getting started quickly
- `guides/MODERN-WORKFLOW.md` - Modern development workflows
- `guides/AGENT-CREATION-WORKFLOW.md` - Standardized agent creation
- `guides/MCP-INTEGRATION.md` - MCP server integration
- `guides/REPORT-EXPORT-SYSTEM.md` - Report and export system

### User Documentation

- `user-guide/README.md` - User guide index
- `user-guide/workflow-guide.md` - Common workflows
- `user-guide/command-reference.md` - Complete command reference
- `user-guide/troubleshooting.md` - Problem solving

### Developer Documentation

- `developer-guide/README.md` - Developer guide index
- `developer-guide/architecture.md` - System architecture
- `developer-guide/extending.md` - Creating commands and agents
- `developer-guide/testing.md` - Testing infrastructure

## Documentation Guidelines

### Writing Style

1. **Clarity**: Use clear, concise language
2. **Examples**: Include practical examples
3. **Structure**: Use consistent heading hierarchy
4. **Cross-references**: Link related topics
5. **Code blocks**: Use syntax highlighting

### Documentation Types

**Guides** - How to accomplish specific tasks

- Task-oriented
- Practical examples
- Step-by-step instructions

**Tutorials** - Learning-oriented content

- Progressive complexity
- Explanations of concepts
- Exercises and examples

**Reference** - Information-oriented content

- Complete details
- Structured format
- Quick lookup

**Architecture** - Understanding-oriented content

- System design
- Decision rationale
- Technical deep-dives

## Important Notes

- All documentation should be written in English
- Keep documentation close to the code it describes
- Update documentation when changing functionality
- Test all code examples before documenting
- Use semantic versioning in documentation

## Quick References

### For New Users

Start with:

1. `guides/QUICK-START.md`
2. `user-guide/README.md`
3. `user-guide/workflow-guide.md`

### For Developers

Start with:

1. `developer-guide/README.md`
2. `developer-guide/architecture.md`
3. `guides/AGENT-CREATION-WORKFLOW.md`

### For Contributors

Start with:

1. `../CONTRIBUTING.md`
2. `developer-guide/extending.md`
3. `developer-guide/testing.md`

## Documentation Maintenance

### Keeping Documentation Current

1. **Update with code**: Documentation updates should accompany code changes
2. **Review regularly**: Periodic reviews for accuracy
3. **User feedback**: Incorporate user questions and issues
4. **Version tracking**: Note documentation version compatibility

### Documentation Standards

- Use Markdown for all documentation
- Follow CommonMark specification
- Include table of contents for long documents
- Add metadata headers where appropriate
- Keep line length reasonable (80-120 characters)

## Extended Resources

### External References

- Claude Code official documentation
- MCP protocol specification
- Related tool documentation

### Internal Cross-References

- Commands: See `/commands/CLAUDE.md`
- Agents: See `/agents/CLAUDE.md`
- Scripts: See `/scripts/CLAUDE.md`
- Templates: See `/templates/CLAUDE.md`

## Contributing to Documentation

When contributing documentation:

1. Follow the existing structure
2. Use clear, accessible language
3. Include examples and use cases
4. Test all code snippets
5. Update the index if adding new files
6. Check for broken links
7. Ensure consistency with existing docs

## Documentation Tools

### Viewing Documentation

- Markdown preview in IDE
- GitHub/GitLab rendering
- Local markdown viewers

### Generating Documentation

- `update-readme.sh` - Updates command tables
- Manual editing for guides
- Template-based generation for consistency
