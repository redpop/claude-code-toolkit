# Extending the Claude Code Toolkit

This guide shows you how to create new commands, agents, and extend the toolkit's functionality.

## 🎯 Quick Start

### Create a New Command (Automated)
```bash
./scripts/create-sub-agent-command.sh \
  --name "my-analyzer" \
  --agents 6 \
  --category scan \
  --description "Analyzes specific patterns"
```

### Create a New Agent
Copy a template and modify:
```bash
cp agents/security-specialist.md agents/my-specialist.md
# Edit the new agent file
```

## 📝 Creating Commands

### Command Structure

Every command is a Markdown file with this structure:

```markdown
---
allowed-tools: Task, Read, Grep, Bash, Write
description: Brief description for command listing
argument-hint: <directory> [--options]
---

# Command Name

Description of what the command does.

## Implementation

[Command logic here]
```

### Step-by-Step Guide

#### 1. Choose the Right Category

```
commands/
├── scan/      # Analysis and investigation
├── fix/       # Direct corrections
├── gen/       # Code generation
├── flow/      # Multi-agent workflows
├── auto/      # Automation
├── sec/       # Security operations
├── meta/      # Toolkit management
└── custom/    # Your custom category
```

#### 2. Create the Command File

```bash
# Create new command
touch commands/scan/my-analyzer.md
```

#### 3. Define Frontmatter

```yaml
---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*)
description: Analyzes code for specific patterns
argument-hint: <directory> [--pattern=regex] [--export]
---
```

**Frontmatter Fields**:
- `allowed-tools`: Tools available to agents
- `description`: Shows in command lists
- `argument-hint`: Usage hint for users
- `mcp-enhanced`: Optional MCP tools

#### 4. Write Command Logic

```markdown
# Pattern Analyzer

Analyzes codebase for specific patterns using parallel agents.

## Execution

Target: $ARGUMENTS

### Phase 1: Pattern Detection

Use Task tool with subagent_type="general-purpose":
"Search for pattern X in $ARGUMENTS using ripgrep.
Focus on: [specific files/patterns].
Return: JSON with findings."

### Phase 2: Analysis

[Process results]

### Phase 3: Report

## Analysis Results

[Format output]

## Next Steps

Recommend:
1. `/global:fix:pattern-issues findings.json`
2. `/global:scan:deep . --focus=patterns`
```

### Command Best Practices

#### 1. Clear Phases
```markdown
### Phase 1: Discovery
[What to find]

### Phase 2: Analysis
[How to analyze]

### Phase 3: Synthesis
[How to report]
```

#### 2. Structured Output
```markdown
## Results
- **Found**: X issues
- **Critical**: Y items
- **Suggestions**: Z improvements

### Details
[Structured findings]
```

#### 3. Next Steps
```markdown
## 🎯 Next Steps
Based on findings:

1. **Quick Fix** (5 min):
   `/global:fix:quick-wins report.json`

2. **Deep Dive** (30 min):
   `/global:flow:smart "investigate pattern X"`
```

#### 4. Export Capability
```markdown
## Export
Results saved to: pattern-analysis-{timestamp}.json

Use in next commands:
`/global:fix:patterns pattern-analysis-*.json`
```

## 🤖 Creating Agents

### Agent Structure

```markdown
---
name: my-specialist
description: Domain expertise description
---

You are an expert in [specific domain].

## Core Expertise Areas
1. **Area 1**: Detailed knowledge
2. **Area 2**: Specific skills
3. **Area 3**: Deep understanding

## Analysis Approach
[How you analyze problems]

## Output Format
[Expected structure]
```

### Agent Types

#### 1. Analysis Agent
```markdown
---
name: pattern-analyzer
description: Analyzes code patterns and architecture
---

You are an expert in code pattern analysis.

## Expertise
- Design patterns detection
- Anti-pattern identification
- Architecture assessment

## Analysis Method
1. Scan for common patterns
2. Identify violations
3. Suggest improvements

## Output
```json
{
  "patterns": [...],
  "antiPatterns": [...],
  "suggestions": [...]
}
```
```

#### 2. Fix Agent
```markdown
---
name: pattern-fixer
description: Fixes pattern-related issues
---

You are an expert in refactoring code patterns.

## Capabilities
- Safe refactoring
- Pattern implementation
- Code transformation

## Fix Approach
1. Validate the issue
2. Plan the fix
3. Apply safely
4. Verify results
```

#### 3. Generation Agent
```markdown
---
name: pattern-generator
description: Generates code following patterns
---

You are an expert in code generation.

## Skills
- Pattern-based generation
- Framework compliance
- Best practices

## Generation Process
1. Understand requirements
2. Select patterns
3. Generate code
4. Add tests
```

### Agent Best Practices

#### 1. Single Responsibility
Each agent should focus on one domain:
- ❌ "Security and performance expert"
- ✅ "Security vulnerability expert"

#### 2. Clear Output Format
Always specify expected output:
```markdown
## Output Format
Return JSON with:
- findings: array of issues
- severity: critical|high|medium|low
- suggestions: actionable fixes
```

#### 3. Actionable Results
Provide specific, actionable advice:
- ❌ "Improve security"
- ✅ "Add input validation to UserController.login() method"

## 🔗 Creating Workflows

### Simple Workflow
Chain existing commands:
```bash
/global:meta:chain \
  "scan:pattern ." -> \
  "fix:patterns {output}" -> \
  "scan:pattern . --verify"
```

### Complex Workflow
Create a flow command:

```markdown
---
description: Complete pattern improvement workflow
---

# Pattern Improvement Flow

## Step 1: Analyze
Use Task tool: "Analyze patterns in $ARGUMENTS"

## Step 2: Prioritize
[Logic to prioritize fixes]

## Step 3: Fix
[Apply fixes systematically]

## Step 4: Verify
[Ensure improvements]
```

## 🧩 Integration Points

### 1. Command Registry
Commands are auto-discovered from the file system:
```
~/.claude/commands/prefix/category/command.md
→ /prefix:category:command
```

### 2. Agent Registry
Agents are loaded from:
```
~/.claude/agents/agent-name.md
```

### 3. Configuration Hooks
Add to `.claude-commands.json`:
```json
{
  "commandOverrides": {
    "scan:my-analyzer": {
      "performanceMode": "aggressive",
      "customSettings": {
        "patterns": ["pattern1", "pattern2"]
      }
    }
  }
}
```

## 📚 Templates

### Basic Command Template
```bash
cp templates/commands/basic-sub-agent.md \
   commands/scan/my-command.md
```

### Analysis Command Template
```bash
cp templates/commands/analysis-sub-agent.md \
   commands/scan/my-analyzer.md
```

### Multi-Agent Command Template
```bash
cp templates/commands/orchestration-template.md \
   commands/flow/my-flow.md
```

## 🧪 Testing Your Extensions

### 1. Install Locally
```bash
./install.sh global --force
```

### 2. Test Command
```bash
/global:scan:my-analyzer ./test-project
```

### 3. Verify Output
```bash
# Check exports
ls -la my-analyzer-*.json

# Validate JSON
cat my-analyzer-*.json | jq .
```

### 4. Test Error Cases
```bash
# Empty directory
/global:scan:my-analyzer /tmp/empty

# Invalid arguments
/global:scan:my-analyzer --invalid-flag

# Large codebase
/global:scan:my-analyzer /large/project
```

## 🚀 Advanced Extensions

### Custom Tool Integration
```markdown
---
allowed-tools: Task, Read, CustomTool
mcp-enhanced: mcp__custom__tool
---

# Uses custom MCP tool when available
```

### Dynamic Agent Selection
```markdown
## Select Agents Based on Findings

If security issues found:
  Use Task tool with subagent_type="security-specialist"
  
If performance issues found:
  Use Task tool with subagent_type="performance-optimizer"
```

### Conditional Execution
```markdown
## Conditional Logic

If $ARGUMENTS contains "--deep":
  Run comprehensive analysis
Else:
  Run quick scan
```

## 📋 Extension Checklist

Before releasing your extension:

- [ ] **Naming**: Clear, descriptive command name
- [ ] **Documentation**: Updated README with new command
- [ ] **Examples**: Usage examples in command file
- [ ] **Testing**: Tested on various projects
- [ ] **Error Handling**: Graceful failure modes
- [ ] **Performance**: Reasonable execution time
- [ ] **Output**: Structured, parseable results
- [ ] **Next Steps**: Clear recommendations

## 🤝 Contributing Back

### 1. Fork the Repository
```bash
git fork https://github.com/original/claude-code-toolkit
```

### 2. Create Feature Branch
```bash
git checkout -b feature/add-pattern-analyzer
```

### 3. Add Your Extension
```bash
# Add files
git add commands/scan/pattern-analyzer.md
git add agents/pattern-specialist.md
```

### 4. Update Documentation
- Add to README.md command list
- Update relevant guides
- Add usage examples

### 5. Submit Pull Request
- Clear description
- Usage examples
- Test results

## 💡 Ideas for Extensions

### Commands
- Database schema analyzer
- API endpoint scanner
- Localization checker
- Accessibility auditor
- Performance profiler

### Agents
- Database optimization expert
- API design specialist
- i18n/l10n expert
- DevOps specialist
- Mobile app expert

### Workflows
- Full-stack analysis
- Microservice health check
- CI/CD pipeline optimizer
- Migration assistant

---

Ready to extend? Start with:
```bash
./scripts/create-sub-agent-command.sh --name "your-idea"
```