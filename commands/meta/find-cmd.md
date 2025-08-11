---
description: Find the best command for your task from all available commands (global and local)
argument-hint: <task-description> [--all] [--local-only] [--global-only]
---

# Command Finder - Discover the Right Tool for Your Task

This intelligent command helps you find the most suitable Claude Code command for your specific task by analyzing all available commands (both globally installed and project-local).

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

## Workflow

$ARGUMENTS

Let me analyze your request and find the best commands for this task:

### Step 1: Discovering Available Commands and Agents

First, I'll scan for all available commands and agents in your environment:

```bash
# Check global commands
echo "🌍 Scanning global commands in ~/.claude/commands/"
find ~/.claude/commands -name "*.md" -type f 2>/dev/null | head -20

# Check local project commands  
echo "📁 Scanning local commands in .claude/commands/"
find .claude/commands -name "*.md" -type f 2>/dev/null | head -20

# Check global agents
echo "🤖 Scanning global agents in ~/.claude/agents/"
find ~/.claude/agents -name "*.md" -type f 2>/dev/null | head -20

# Check local project agents
echo "📁 Scanning local agents in .claude/agents/"
find .claude/agents -name "*.md" -type f 2>/dev/null | head -20
```

### Step 2: Analyzing Your Request

Now I'll analyze your task description to understand:
- Primary action needed (analyze, fix, generate, etc.)
- Target area (code, security, performance, etc.)
- Specific requirements or constraints

### Step 3: Matching Commands

Now I'll analyze the actual commands found in your toolkit to match your needs:

Use Task tool with subagent_type="general-purpose":
"Analyze the user's request: '$ARGUMENTS'. Then examine ALL command files found in step 1 from BOTH locations:
- Global commands in ~/.claude/commands/
- Local project commands in .claude/commands/

For each command file found:
1. Read its frontmatter (description, argument-hint)
2. Analyze its content to understand what it does
3. Check if it matches the user's needs
4. Note whether it's a global or local command

Focus on commands that exist in these categories based on keywords in the request:
- For 'refactor/restructure/redesign': Look for flow:refactor, scan:refactor commands
- For 'analyze/scan/explore': Look for scan:* commands
- For 'fix/optimize/improve': Look for fix:* commands  
- For 'security/audit': Look for sec:* commands
- For 'test/coverage': Look for gen:tests, scan:tests
- For 'docs/documentation': Look for gen:docs, scan:docs, fix:documentation
- For 'typo3/extension': Look for typo3:* commands (often in local .claude/commands)
- For framework-specific tasks: Check local commands first

Return ONLY commands that actually exist in the found files. Do not suggest hypothetical commands.
Format as a ranked list with relevance scores and indicate [GLOBAL] or [LOCAL] source."

### Step 4: Recommendations

Based on the analysis of your actual available commands:

## 🎯 Best Matches from Your Toolkit

I'll now present the commands that actually exist in your Claude Code Toolkit and match your request.

Note: I will ONLY recommend commands that were found in the file system scan above. No hypothetical or non-existent commands will be suggested.

## 🤖 Available Specialized Agents

Based on the agents found in your environment, here are relevant specialists for your task:

Use Task tool with subagent_type="general-purpose":
"List ONLY the agents actually found in the directory scans from step 1:
- Global agents in ~/.claude/agents/
- Local project agents in .claude/agents/

For each agent found, provide:
1. Its actual name and location [GLOBAL] or [LOCAL]
2. Its capabilities based on reading its content
3. How it relates to the user's request

Do not invent agents that don't exist. Only list what was actually found in the file system."

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