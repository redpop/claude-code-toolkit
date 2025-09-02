---
allowed-tools: Read, Grep
description: Creates a chat summary for another AI with complete context
argument-hint: [summaries/]
---

# Claude Command: Chat Summary

This command analyzes the entire chat history and creates a structured summary with an automatically generated, meaningful filename.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Usage

```
/summary                    # Auto-generates: summaries/2025-01-05_main-topic_category.md
/summary summaries/custom   # Creates summaries/custom.md
```

## What This Command Does

1. **Analyzes Chat History**: Reviews the entire conversation
2. **Extracts Main Topic**: Identifies the central theme of the conversation
3. **Detects Category**: Automatically classifies (Security, Feature, Bugfix, Performance, Refactoring, Documentation, Research, etc.)
4. **Generates Filename**: Creates self-documenting name in format:
   - `YYYY-MM-DD_hauptthema_kategorie.md`
   - Examples:
     - `2025-01-05_session-invalidation_security.md`
     - `2025-01-05_owasp-a04-compliance_implementation.md`
     - `2025-01-05_react-performance_optimization.md`
5. **Creates Directory**: Automatically creates `summaries/` directory if not present
6. **Structures Information**: Generates comprehensive summary with complete context

## Automatic Categorization

The command automatically detects the following categories:

- **security**: Security topics, vulnerabilities, OWASP, authentication
- **feature**: New features, functionality, enhancements
- **bugfix**: Bug fixes, debugging, problem solutions
- **performance**: Performance optimizations, speed, resources
- **refactoring**: Code improvements, structure changes, clean code
- **documentation**: Documentation, README, comments
- **testing**: Tests, test coverage, QA
- **deployment**: CI/CD, deployment, infrastructure
- **research**: Analysis, investigation, exploration
- **configuration**: Configuration, setup, settings

## Output Format

The generated documentation includes:

### 1. Metadata

- **Date**: Automatically added (YYYY-MM-DD)
- **Category**: Automatically detected
- **Main Topic**: Extracted from chat history
- **Duration**: Estimated conversation duration

### 2. Overview

- Main conversation topics
- Timeline
- Key results

### 3. Conversation Context

- Chronological summary of discussed topics
- Transitions between different tasks
- Decisions and their rationale

### 4. Technical Details

- Technologies and tools used
- Files and directories modified
- Implemented solutions
- Code examples and configurations

### 5. Project Context

- Project structure and purpose
- Important files and their functions
- Dependencies and integrations

### 6. Actions Performed

- List of all changes made
- Created or modified files
- Executed commands
- Test results

### 7. Open Items & Next Steps

- Unfinished topics
- Suggestions for continuation
- Potential improvements

## Benefits of Automatic Naming

✅ **Prevents Overwrites**: Each session gets a unique name
✅ **Better Organization**: All summaries in `summaries/` directory
✅ **Self-Documenting**: Filename immediately shows content and context
✅ **Easy Search**: Filterable by date, topic, or category
✅ **Chronological Sorting**: Automatically sorted by date

## Best Practices

- Use this command when you need to pass context to another AI
- Ideal for breaks or shift changes between different AI assistants
- The summary focuses on factual information, not the dialogue itself
- Review the generated summary for completeness

## Example Output

```markdown
# Chat Summary: Claude Code Toolkit Development

## Metadata

- **Date**: 2025-01-05
- **Category**: feature
- **Main Topic**: Development of Claude Code Toolkit with various commands and agents
- **Duration**: ~2h 15min
- **Filename**: `summaries/2025-01-05_claude-code-toolkit-development_feature.md`

## Overview

**Period**: 2025-01-05, 14:30 - 16:45
**Main Topic**: Development of Claude Code Toolkit with various commands and agents
**Status**: Multiple commands implemented, documentation updated

## Conversation Context

### Phase 1: Project Analysis (14:30-15:00)

- Examination of existing project structure
- Identification of improvement opportunities
- Decision for new command categorization

### Phase 2: Implementation (15:00-16:00)

- Creation of new command structures
- Migration of existing commands
- Implementation of chain command system

### Phase 3: Documentation (16:00-16:45)

- Update of README.md
- Creation of migration guides
- Documentation of new features

## Technical Details

### Project Structure
```

claude-code-toolkit/
├── commands/          # All slash commands
│   ├── scan/         # Analysis commands
│   ├── fix/          # Correction commands
│   ├── flow/         # Workflow commands
│   └── meta/         # Meta commands
├── agents/           # Sub-agent definitions
└── docs/            # Extended documentation

````

### Implemented Solutions

1. **Command Migration**:
   - Migrated old commands to new structure
   - Unified naming conventions
   - Logically organized categories

2. **Chain Command System**:
   ```bash
   /prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"
```

3. **New Workflow Commands**:
   - `/prefix:flow:smart` - Intelligent problem routing
   - `/prefix:flow:review` - Multi-perspective code review
   - `/prefix:flow:incident` - Rapid incident response

## Actions Performed

### Created Files

- `/commands/meta/chain.md` - Command chaining system
- `/commands/flow/smart.md` - Smart routing command
- `/commands/flow/review.md` - Review workflow
- `/docs/guides/MODERN-WORKFLOW.md` - Workflow documentation

### Modified Files

- `README.md` - Updated command table
- `CLAUDE.md` - Extended project guidelines
- `install.sh` - Improved installation logic

### Tests Executed

- Installation tested with various prefixes
- Command chaining successfully validated
- README update script works correctly

## Key Insights

1. **Categorization improves clarity**:

   - Clear separation by functional areas
   - Intuitive naming increases discoverability

2. **Hybrid architecture proves effective**:

   - Combination of speed and depth
   - Parallel processing with expert analysis

3. **Automation through chaining**:
   - Complex workflows simplified
   - Reusable pipeline definitions

## Open Items & Next Steps

### To Be Implemented

- [ ] Define more pipeline templates
- [ ] Improve report export system
- [ ] Integration with CI/CD systems

### Improvement Suggestions

1. Dashboard for project metrics
2. Automatic report generation
3. Integration with issue tracking systems

### Recommended Next Actions

- Test new commands in real projects
- Gather user feedback
- Performance optimization of analysis commands

## Additional Context

The project aims to extend Claude Code with powerful, reusable tools. The focus is on developer productivity and code quality through intelligent automation.

All commands follow the prefix pattern `/prefix:category:command` and are structured as Markdown files with YAML frontmatter.

```

## Important Notes

- Captures the ENTIRE chat history, not just problems
- Structures information chronologically and thematically
- Includes all technical details and decisions
- Removes dialogue elements for better clarity
- Focuses on facts and actions performed

## Command Arguments

- `$ARGUMENTS`: Optional output path
  - Without argument: Automatically generated name in `summaries/` directory
  - With argument: Specified filename (must end with .md)
  - Directory is automatically created if not present

## Implementation Details

When executing the command:

1. **Main Topic Extraction**:
   - Analyze most frequent technical terms
   - Identify central discussion themes
   - Convert to kebab-case for filenames

2. **Category Detection**:
   - Search for keywords (security, bug, feature, etc.)
   - Analyze performed actions
   - Select most appropriate category

3. **Filename Generation**:
   - Format: `YYYY-MM-DD_main-topic_category.md`
   - Special characters are removed
   - Maximum 60 characters for readability

4. **Directory Handling**:
   - Create `summaries/` if not present
   - Organize by year/month for many files
   - Prevent overwrites through unique names
```
