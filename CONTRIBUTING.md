# Contributing to Claude Code Toolkit

Thank you for your interest in contributing to the Claude Code Toolkit! This document provides guidelines and instructions for contributing to this repository.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Contributing Process](#contributing-process)
- [Creating New Commands](#creating-new-commands)
- [Creating New Sub-Agents](#creating-new-sub-agents)
- [Testing](#testing)
- [Documentation](#documentation)
- [Style Guidelines](#style-guidelines)
- [Pull Request Process](#pull-request-process)

## Code of Conduct

By participating in this project, you agree to abide by our code of conduct:

- Be respectful and inclusive
- Welcome newcomers and help them get started
- Focus on constructive criticism
- Respect differing viewpoints and experiences
- Show empathy towards other community members

## Getting Started

1. **Fork the repository** on GitHub
2. **Clone your fork** locally:

   ```bash
   git clone https://github.com/YOUR-USERNAME/claude-code-toolkit.git
   cd claude-code-toolkit
   ```

3. **Add upstream remote**:

   ```bash
   git remote add upstream https://github.com/anthropics/claude-code-toolkit.git
   ```

4. **Create a feature branch**:

   ```bash
   git checkout -b feature/your-feature-name
   ```

## Development Setup

1. **Install the toolkit locally** for testing:

   ```bash
   ./install.sh test
   ```

   This installs commands with the `test:` prefix for local testing.

2. **Verify installation**:

   ```bash
   # List your test commands
   ls ~/.claude/commands/test/
   ```

3. **Test your changes** in Claude Code using the test prefix:

   ```bash
   /test:your-command arguments
   ```

## Contributing Process

### For Bug Fixes

1. Check existing issues to avoid duplicates
2. Create an issue describing the bug if none exists
3. Reference the issue in your PR

### For New Features

1. Open an issue to discuss the feature first
2. Wait for maintainer feedback before implementing
3. Follow the implementation guidelines below

### For Documentation

1. Documentation improvements are always welcome
2. Ensure accuracy and clarity
3. Update relevant sections in CLAUDE.md

## Creating New Commands

### 1. Choose the Right Category

Place your command in the appropriate category:

- `scan/` - Analysis and investigation
- `fix/` - Direct corrections
- `gen/` - Generation commands
- `flow/` - Multi-agent workflows
- `auto/` - Automation & orchestration
- `sec/` - Security operations
- `git/` - Git operations
- `meta/` - Project & toolkit management

### 2. Use the Command Template

```bash
# Use the appropriate template for your command type
cp templates/commands/basic-sub-agent.md commands/category/your-command.md
```

### 3. Command Structure

Every command must include:

```markdown
---
description: Brief description (max 100 chars)
argument-hint: [expected arguments] [--flags]
---

# Command Name

Detailed description of what the command does.

## Usage Examples

[Provide 2-3 practical examples]

## Implementation

[Detailed workflow steps]
```

### 4. Follow Naming Conventions

- Use short, action-oriented names
- Maximum 2 words per command
- Use verbs for clarity
- Examples: `deep`, `quick-wins`, `smart`

### 5. Test Your Command

```bash
# Install locally with test prefix
./install.sh test

# Test in Claude Code
/test:category:your-command arguments
```

## Creating New Sub-Agents

### 1. Define Agent Purpose

Create agents with specific expertise:

- Architecture analysis
- Security auditing
- Performance optimization
- Testing strategies

### 2. Use Agent Template

```bash
cp templates/commands/specialist-agent.md agents/your-agent.md
```

### 3. Agent Structure

```markdown
# Agent Name

You are a specialized AI agent focused on [specific domain].

## Expertise Areas
- [Area 1]
- [Area 2]

## Analysis Approach
[Describe methodology]

## Output Format
[Define expected output structure]
```

### 4. Integration

Create orchestration commands that use your agent:

```bash
./scripts/create-sub-agent-command.sh your-agent
```

## Testing

### Command Testing Checklist

- [ ] Command executes without errors
- [ ] Handles missing arguments gracefully
- [ ] Produces expected output format
- [ ] Works with various project types
- [ ] Respects file permissions
- [ ] Doesn't break existing functionality

### Documentation Testing

- [ ] All examples are valid
- [ ] Links point to correct locations
- [ ] Code blocks are properly formatted
- [ ] Frontmatter is complete

## Documentation

### When Adding Commands

1. Update command documentation in the `.md` file
2. Run the update script:

   ```bash
   ./scripts/update-readme.sh
   ```

3. Verify README.md was updated correctly

### When Modifying Core Features

Update relevant sections in:

- `CLAUDE.md` - Implementation details
- `README.md` - User-facing documentation
- `docs/` - Extended documentation

## Style Guidelines

### Markdown Files

- Use clear, concise language
- Include practical examples
- Follow existing formatting patterns
- Use code blocks with language hints

### Shell Scripts

- Validate with shellcheck:

  ```bash
  shellcheck scripts/*.sh install.sh
  ```

- Use proper quoting: `"$variable"`
- Handle errors appropriately
- Add comments for complex logic

### Command Patterns

- Keep commands focused (single responsibility)
- Provide clear progress indicators
- Handle edge cases gracefully
- Return structured output when possible

## Pull Request Process

### Before Submitting

1. **Update your branch**:

   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run quality checks**:

   ```bash
   # Update documentation
   ./scripts/update-readme.sh
   
   # Validate shell scripts
   shellcheck scripts/*.sh install.sh
   
   # Test your changes
   ./install.sh test
   ```

3. **Commit with clear messages**:

   ```bash
   git commit -m "feat: add performance analysis command
   
   - Adds /scan:perf command for performance profiling
   - Integrates with performance-optimizer agent
   - Includes CPU, memory, and I/O analysis"
   ```

### PR Guidelines

1. **Title**: Use conventional commits format
   - `feat:` New features
   - `fix:` Bug fixes
   - `docs:` Documentation changes
   - `refactor:` Code refactoring
   - `test:` Test additions/changes

2. **Description**: Include:
   - What changes were made
   - Why the changes are needed
   - How to test the changes
   - Related issues

3. **Review Process**:
   - PRs require maintainer approval
   - Address review feedback promptly
   - Keep PRs focused and small

### After Merge

1. Delete your feature branch
2. Update your local main branch
3. Celebrate your contribution! 🎉

## Questions?

- Open an issue for questions
- Check existing documentation
- Review closed issues and PRs

Thank you for contributing to Claude Code Toolkit!
