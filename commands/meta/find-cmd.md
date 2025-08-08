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

# Check available agents
echo "🤖 Scanning agents in ~/.claude/agents/"
find ~/.claude/agents -name "*.md" -type f 2>/dev/null | head -20
```

### Step 2: Analyzing Your Request

Now I'll analyze your task description to understand:
- Primary action needed (analyze, fix, generate, etc.)
- Target area (code, security, performance, etc.)
- Specific requirements or constraints

### Step 3: Matching Commands

Based on your request, I'll search for commands that match your needs by:
1. Parsing command frontmatter for descriptions
2. Analyzing command content for capabilities
3. Matching keywords and synonyms
4. Calculating relevance scores

### Step 4: Recommendations

## 🎯 Best Match

**Command**: `[BEST_MATCH_COMMAND]`
- **Description**: [Command description]
- **Why it's best**: [Explanation of why this matches your needs]
- **Usage**: `[Example usage]`
- **Source**: [Global/Local]

## 📊 Alternative Commands

### Option 2: `[ALTERNATIVE_COMMAND_1]`
- **Description**: [Command description]
- **Best for**: [Specific use case]
- **Usage**: `[Example usage]`

### Option 3: `[ALTERNATIVE_COMMAND_2]`
- **Description**: [Command description]
- **Best for**: [Specific use case]
- **Usage**: `[Example usage]`

## 🤖 Specialized Agents Available

For complex tasks, consider using these specialized agents:
- `[AGENT_NAME]`: [Agent expertise and capabilities]
- Use with: `/prefix:flow:smart "your specific task"`

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