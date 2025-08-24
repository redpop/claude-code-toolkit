---
description: Find the best command for your task from all available commands (global and local)
argument-hint: <task-description> [--all] [--local-only] [--global-only]
---

# Command Finder - Discover the Right Tool for Your Task

**PURPOSE**: This command ONLY recommends other commands. It does NOT execute any tasks.

This intelligent command helps you find the most suitable Claude Code command for your specific task by analyzing all available commands (both globally installed and project-local).

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

⚠️ **IMPORTANT INSTRUCTION FOR AI**:

- This is a DISCOVERY command only
- DO NOT execute the user's task
- DO NOT refactor, analyze, or modify any code
- ONLY list available commands that the user can run themselves
- Your job is to be a command recommendation engine, nothing more

## Usage

```bash
/prefix:meta:find-cmd "optimize shell scripts"        # Find commands for shell optimization
/prefix:meta:find-cmd "refactor code" --all          # Show all matching commands
/prefix:meta:find-cmd "test coverage" --local-only   # Only search local commands
/prefix:meta:find-cmd "security audit" --global-only # Only search global commands
```

## How It Works

1. **Command Discovery**
   - Scans `~/.claude/commands/` for globally installed commands
   - Scans `.claude/commands/` in current project for local commands
   - Reads command metadata and descriptions

2. **Intelligent Matching**
   - Analyzes your task description
   - Matches keywords with command capabilities
   - Considers synonyms and related terms
   - Ranks by relevance score

3. **Smart Recommendations**
   - Shows best match with explanation
   - Lists alternative commands
   - Provides usage examples
   - Indicates command source (global/local)

## Task Categories & Keywords

### 🔍 Analysis & Scanning

**Keywords**: analyze, scan, explore, investigate, assess, evaluate, check, review
**Commands**: scan:*, flow:review, meta:health

### 🔧 Fixing & Optimization

**Keywords**: fix, optimize, improve, enhance, correct, repair, performance, speed
**Commands**: fix:*, auto:execute

### 🏗️ Refactoring & Architecture

**Keywords**: refactor, restructure, redesign, architecture, patterns, organize
**Commands**: flow:refactor, scan:refactor

### 🔒 Security

**Keywords**: security, vulnerability, audit, compliance, CVE, pentest, secure
**Commands**: sec:*, fix:security

### 🧪 Testing

**Keywords**: test, coverage, unit, integration, TDD, mock, assert
**Commands**: gen:tests, scan:tests

### 📚 Documentation

**Keywords**: docs, documentation, README, comments, API docs, annotate
**Commands**: gen:docs, fix:documentation, scan:docs

### 🛠️ Creation & Generation

**Keywords**: create, generate, scaffold, new command, new agent, builder, generator, make new
**Commands**: meta:create - Universal intelligent creator for commands, agents, and workflows
**Scripts**: create-sub-agent.sh, create-sub-agent-command.sh (for advanced users)

### 🐚 Shell & Scripts

**Keywords**: shell, bash, script, sh, zsh, shellcheck, terminal
**Commands**: fix:shell

### 📦 Dependencies

**Keywords**: dependencies, packages, npm, pip, gems, modules, libraries
**Commands**: scan:deps

### 🚀 Deployment & CI/CD

**Keywords**: deploy, CI, CD, pipeline, build, release, docker, kubernetes
**Commands**: auto:monitor, git:commit

### 📊 Reporting & Metrics

**Keywords**: report, metrics, statistics, quality, trends, analysis
**Commands**: scan:report, auto:report, meta:export

### 🏗️ TYPO3 & CMS

**Keywords**: typo3, content block, content blocks, contentblock, contentblocks, content element, content-element, sitepackage, typoscript, fluid, extension, extbase, backend module
**Commands**: typo3:content-blocks, typo3:sitepackage, typo3:extension-kickstarter, typo3:make-content-block
**Agents**: typo3-content-blocks-specialist, typo3-architect, typo3-typoscript-expert, typo3-extension-developer

### 🎨 CSS & Styling

**Keywords**: css, styles, styling, postcss, tailwind, responsive, breakpoints, mixins, modular css, figma, design system, design tokens
**Commands**: css:tailwind-optimize, css:figma-to-styles
**Focus**: CSS architecture, responsive design, component styling, design system implementation

## Workflow

**CRITICAL**: This is a DISCOVERY command only. Do NOT analyze code or execute tasks!

User's request: "$ARGUMENTS"

## Quick Analysis (Surface Level Only)

Understanding your request category:

- Request type: Identify if it's about refactoring, analysis, security, etc.
- Technology: Look for keywords like TYPO3, React, Python, etc.
- Goal: What outcome is desired

## Available Commands for Your Task

Based on your request "$ARGUMENTS", here are the commands you can run:

### 🔧 For Refactoring Tasks

```bash
# Most common refactoring commands:
/global:flow:refactor <path>     # Intelligent refactoring workflow
/global:scan:refactor <path>     # Analyze refactoring opportunities
/global:scan:deep <path>         # Deep code analysis first
```

### 📊 For Analysis Tasks

```bash
# Analysis commands:
/global:scan:quality <path>      # Code quality metrics
/global:flow:review <path>       # Multi-perspective review
/global:scan:deps <path>         # Dependency analysis
```

### 🚀 For Smart Routing

```bash
# Let AI choose the best approach:
/global:flow:smart "your specific task description"
```

### 🔍 Check What's Actually Available

```bash
# See all your commands:
find ~/.claude/commands -name "*.md" | sed 's|.*/commands/||; s|/|:|g; s|\.md$||' | sort
find .claude/commands -name "*.md" | sed 's|.*/commands/||; s|/|:|g; s|\.md$||' | sort
```

## 📝 Quick Recommendations

For "$ARGUMENTS":

**Primary suggestion**: `/global:flow:refactor <your-path>`
**If you want analysis first**: `/global:scan:deep <your-path> --export-json`
**For TYPO3 extensions**: Check if you have local TYPO3 commands with `ls .claude/commands/typo3/`

## ✅ Command Discovery Complete

That's it! I've provided command recommendations without doing any actual work.

**Your next step**: Choose one of the commands above and run it yourself.

## Need Different Commands?

If none of these fit your needs:

- Use `/prefix:meta:create` to create a custom command
- Use `/prefix:flow:smart` for intelligent problem routing
- Check local project commands with `ls .claude/commands/`

## 💡 Related Commands You Might Need

Based on your task, you might also want to consider:

- `[RELATED_COMMAND_1]`: [Brief description]
- `[RELATED_COMMAND_2]`: [Brief description]

## 🔄 Command Chaining Suggestion

For comprehensive results, consider chaining commands:

```bash
/prefix:meta:chain "[COMMAND_1]" -> "[COMMAND_2]" -> "[COMMAND_3]"
```

## 📝 Tips for Your Task

- [Specific tip related to the user's request]
- [Another helpful suggestion]
- [Best practice recommendation]

## Command Details

To learn more about any command, you can:

1. Read the command file directly
2. Run the command with `--help` if supported
3. Check the documentation in `/docs/`

## Didn't Find What You Need?

If no existing command matches your needs:

1. Use `/prefix:meta:create` to create any command, agent, or workflow you need
2. Use `/prefix:flow:smart` for intelligent problem routing  
3. Combine multiple commands with `/prefix:meta:chain`

Remember: Commands are constantly being added and improved. Run this finder regularly to discover new tools!
