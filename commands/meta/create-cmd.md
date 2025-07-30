---
description: Create new slash commands from natural language descriptions
argument-hint: [description of what you want the command to do]
---

# Claude Command: Create Command

This meta-command creates new slash commands based on your natural language description. Simply describe what you want the command to do, and I'll handle the rest - suggesting a name, choosing the right category, and generating the complete command file.

## Usage

```
/create-command I need a command that finds all TODO comments in my code
/create-command Create something that validates JSON files and fixes formatting
/create-command A tool to analyze Python imports and find unused ones
```

## What This Command Does

1. **Natural Language Understanding**:
   - You describe what you want in plain language
   - I analyze your description to understand the purpose
   - Extract key functionality and requirements
   - Identify the type of command needed

2. **Intelligent Command Design**:
   - Suggest an appropriate command name
   - Determine the best category (git, code, project, ai, etc.)
   - Identify necessary arguments and options
   - Choose the right template structure

3. **Automatic File Generation**:
   - Create the complete command file
   - Include all necessary sections
   - Add relevant examples and documentation
   - Follow repository conventions

4. **Interactive Refinement** (only when needed):
   - Ask for clarification if description is ambiguous
   - Confirm command name if multiple options exist
   - Verify category choice for edge cases

## Workflow Examples

### Example 1: Finding TODOs
```
You: "I need a command that finds all TODO comments in my code"

Claude: Based on your description, I'll create:
- Command name: `find-todos`
- Category: `code` (code analysis)
- Arguments: `[--format=<format>] [--include-fixme] [path]`

Creating `commands/code/find-todos.md`...
✓ Command created successfully!
```

### Example 2: Git Workflow
```
You: "Create a command that stashes changes, pulls latest, and reapplies the stash"

Claude: I'll create:
- Command name: `sync-with-stash`
- Category: `git` (version control)
- Arguments: `[--branch=<branch>] [--force]`

Creating `commands/git/sync-with-stash.md`...
✓ Command created successfully!
```

### Example 3: Project Setup
```
You: "I want something that sets up a new TypeScript project with all my usual configs"

Claude: I'll create:
- Command name: `setup-typescript`
- Category: `project` (project management)
- Arguments: `[project-name] [--strict] [--with-tests]`

Creating `commands/project/setup-typescript.md`...
✓ Command created successfully!
```

## How It Works

### 1. Description Analysis
When you provide a description, I analyze it for:
- **Action verbs**: find, create, analyze, setup, validate
- **Target objects**: TODOs, imports, dependencies, files
- **Context clues**: git, project, code quality, automation
- **Requirements**: specific tools, frameworks, or patterns

### 2. Command Naming
I generate names that are:
- Clear and descriptive
- Action-oriented (verb-noun format)
- Consistent with existing commands
- Easy to remember and type

### 3. Category Selection
Categories are chosen based on:
- Primary function of the command
- Similar existing commands
- Common usage patterns
- Repository organization

### 4. Template Selection
Different templates for different purposes:
- **Analysis commands**: Include reporting sections
- **Modification commands**: Include safety checks
- **Workflow commands**: Include step tracking
- **Tool commands**: Include configuration options

## Template Structure

### Basic Template
```markdown
---
description: {description}
argument-hint: {argument_hint}
---

# Claude Command: {command_title}

{detailed_description}

## Usage

```
/{prefix}:{category}:{command}
```

## What This Command Does

1. **Step 1**: Description
2. **Step 2**: Description
3. **Step 3**: Description

## Workflow Steps

### 1. Initialization
- Verify prerequisites
- Gather parameters
- Validate environment

### 2. Execution
- Main command logic
- Process results
- Handle errors

### 3. Reporting
- Generate output
- Provide recommendations
- Suggest next steps

## Best Practices

- Practice 1
- Practice 2
- Practice 3

## Error Handling

The command handles:
- Common error scenario 1
- Common error scenario 2
- Edge cases

## Important Notes

- Note about behavior
- Integration details
- Limitations
```

### Analysis Command Template
Includes additional sections:
- Data Collection Methods
- Report Format
- Visualization Options
- Export Capabilities

### Modification Command Template
Includes additional sections:
- File Discovery
- Backup Strategy
- Validation Steps
- Rollback Procedures

### Workflow Command Template
Includes additional sections:
- Phase Descriptions
- Dependency Management
- Progress Tracking
- Integration Points

## AI-Powered Workflow

### Natural Language Processing
I understand various ways to describe commands:
- "Find all X in Y"
- "Create a tool that..."
- "I need something to..."
- "Automate the process of..."
- "Check if..." / "Validate..."
- "Generate..." / "Build..."

### Smart Suggestions
Based on your description, I'll:
1. Propose the most fitting command name
2. Explain why I chose that name
3. Show the category and structure
4. Create the file immediately if you agree
5. Offer alternatives if you want changes

### Minimal Interaction
The goal is to minimize back-and-forth:
- Clear descriptions = immediate creation
- Ambiguous requests = focused clarification
- Complex workflows = step-by-step confirmation

## Post-Creation Steps

After creating a command:

1. **Review Generated File**:
   - Check `commands/{category}/{command}.md`
   - Verify frontmatter is correct
   - Ensure description is clear

2. **Customize Template**:
   - Add specific implementation details
   - Include relevant examples
   - Document edge cases

3. **Update Documentation**:
   - Run `./scripts/update-readme.sh` (or use --update-readme)
   - Verify command appears in README
   - Check formatting is correct

4. **Test Command**:
   - Install locally for testing
   - Verify command executes properly
   - Test with various arguments

## Integration with Repository

### File Structure
```
commands/
├── {category}/
│   └── {command}.md
```

### Naming Conventions
- Commands: `lowercase-with-hyphens`
- Categories: `lowercase` (single word preferred)
- No prefixes in filenames (added during installation)

### Documentation Standards
- Clear, actionable descriptions
- Comprehensive usage examples
- Detailed workflow steps
- Error handling documentation
- Best practices section

## Advanced Features

### Context-Aware Generation
I analyze your description to determine:
- **Command Type**: Analysis, modification, automation, or utility
- **Scope**: File-level, project-level, or system-level
- **Dependencies**: Required tools or frameworks
- **Safety Requirements**: Backup needs, validation steps

### Intelligent Defaults
Based on patterns in the repository:
- Common argument patterns for similar commands
- Standard error handling approaches
- Typical workflow structures
- Documentation style and depth

### Learning from Examples
I reference existing commands to ensure consistency:
- Naming conventions in the category
- Argument styles and formats
- Documentation patterns
- Implementation approaches

## Error Handling

The command handles:
- **Duplicate commands**: Warns if command already exists
- **Invalid names**: Ensures lowercase-with-hyphens format
- **Missing directories**: Creates category directory if needed
- **Update script failures**: Reports issues with update-readme.sh
- **Invalid frontmatter**: Validates YAML syntax
- **File permissions**: Handles write permission issues

## Best Practices

### For Users
1. **Be Specific**: The more details you provide, the better the command
2. **Include Context**: Mention tools, languages, or frameworks involved
3. **Describe the Goal**: What problem are you trying to solve?
4. **Mention Edge Cases**: Any special scenarios to handle?

### Examples of Good Descriptions
✅ "Find all console.log statements in JavaScript files and offer to remove them"
✅ "Validate Docker Compose files and check if all referenced images exist"
✅ "Generate a weekly report of git commits grouped by author"

### Examples of Descriptions That Need Clarification
❓ "Make a cleanup tool" → What should it clean up?
❓ "Something for testing" → What kind of testing? Unit? Integration?
❓ "Fix formatting" → Which files? What formatting rules?

## Important Notes

- This command uses AI to understand your intent - be clear and specific
- The generated command will follow all repository conventions
- You can always edit the generated file if you need customizations
- Test the command after creation to ensure it works as expected
- Run `./scripts/update-readme.sh` to update documentation
- Each command should solve a real problem you face repeatedly

## Quick Start Examples

```bash
# Simple analysis command
/create-command Find all hardcoded API keys in the codebase

# Complex workflow
/create-command Automate the release process including version bump, changelog, and git tag

# Development tool
/create-command Set up pre-commit hooks for Python with black, isort, and mypy

# Utility command
/create-command Convert all PNG images to WebP format with optimization
```
