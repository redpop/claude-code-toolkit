---
allowed-tools: Read, Bash(git:*)
description: Creates clean Git commits with optional branch prefix extraction and intelligent grouping
argument-hint: [--no-verify] [--fast] [--push] [--single] [--brief]
---

# Claude Command: Simple Commit

A streamlined Git commit command that extracts ticket prefixes from branch names and intelligently groups related changes into atomic commits.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Creates clean Git commits with optional branch prefix extraction and intelligent grouping
- **Usage**: [--no-verify] [--fast] [--push] [--single] [--brief]
- **Options**:
  - `--no-verify`: Skip pre-commit hooks
  - `--fast`: Fast mode: auto-select first suggestion
  - `--push`: Push to remote after commit
  - `--single`: Single commit for all changes
  - `--brief`: Single-line messages only

Then exit without executing the main command.

---

## Usage

```bash
/commit-simple                    # Standard mode with intelligent grouping
/commit-simple --no-verify        # Skip pre-commit hooks
/commit-simple --fast             # Fast mode: auto-select first suggestion
/commit-simple --push             # Push to remote after commit
/commit-simple --single           # Single commit for all changes
/commit-simple --brief            # Single-line messages only
/commit-simple --fast --push      # Combine fast mode with push
```

## Features

### Branch Prefix Extraction

Automatically detects and extracts ticket/issue prefixes from branch names:

- `feature/TICKET-123-description` → Prefix: `TICKET-123`
- `ABC-456_implement_feature` → Prefix: `ABC-456`
- `bugfix/PROJ-789-fix-issue` → Prefix: `PROJ-789`
- `TEAM-321/new-feature` → Prefix: `TEAM-321`
- `hotfix/XYZ-654` → Prefix: `XYZ-654`

If no prefix is found, the command will ask if you want to add one manually.

### Intelligent Commit Grouping

Unless `--single` is specified, changes are automatically grouped into logical, atomic commits:

1. **By Functionality**: Related features grouped together
2. **By Component**: Frontend, backend, infrastructure separated
3. **By File Type**: Tests, configs, source code, documentation
4. **By Dependencies**: Core changes vs dependent changes

### Commit Message Format

**Standard Format:**

```text
TICKET-123 Implement comprehensive user authentication system

- Add JWT token generation and validation
- Configure refresh token rotation
- Update middleware for protected routes
```

**Brief Format (--brief):**

```text
TICKET-123 Implement user authentication system
```

## Workflow

### Standard Mode (default)

1. Extract ticket prefix from current branch name
2. Check for staged files (`git status`)
3. If no staged files, automatically stage all changes (`git add .`)
4. Analyze all changes to identify logical groupings
5. For each group of related changes:
   - Present the files in this group
   - Generate 3 commit message suggestions
   - Allow user to choose or write custom message
   - Stage only files for this specific commit
   - Create the commit
   - Reset remaining files for next commit
6. If `--push` specified, push all commits to remote

### Fast Mode (--fast)

1. Extract ticket prefix from branch
2. Require files to be already staged
3. Analyze staged changes for logical groupings
4. If multiple distinct logical groups detected:
   - Create multiple commits automatically
   - For each group: generate message suggestion and commit
   - Use first suggestion for each group without user confirmation
5. If changes form single cohesive unit:
   - Generate 3 commit message suggestions
   - Automatically use first suggestion
   - Create single commit immediately
6. If `--push` specified, push all commits to remote

## Examples

### Example: Multi-file Change Grouping

Given these modified files:

```text
modified: src/auth/login.js
modified: src/auth/logout.js
modified: src/auth/session.js
new file: tests/auth/login.test.js
new file: tests/auth/logout.test.js
modified: config/database.yml
modified: package.json
```

The command will suggest grouping into:

**Commit 1: Core Authentication**

```text
TICKET-123 Implement core authentication logic with session management

- Add login/logout functionality
- Implement session handling
- Add token validation
```

Files: `src/auth/login.js`, `src/auth/logout.js`, `src/auth/session.js`

**Commit 2: Authentication Tests**

```text
TICKET-123 Add comprehensive test coverage for authentication
```

Files: `tests/auth/login.test.js`, `tests/auth/logout.test.js`

**Commit 3: Configuration Updates**

```text
TICKET-123 Update configuration and dependencies for authentication
```

Files: `config/database.yml`, `package.json`

### Example: Single Feature Implementation

Modified files:

```text
modified: src/components/UserProfile.jsx
modified: src/styles/profile.css
```

Suggested commit:

```text
TICKET-456 Enhance user profile component with responsive design

- Update layout for mobile devices
- Improve accessibility features
```

## Command Options

### --no-verify

Skip any configured pre-commit hooks or checks. Use when you need to commit quickly or bypass validation temporarily.

### --fast

Fast mode for quick commits:

- Requires files to be pre-staged
- Analyzes changes and intelligently groups into multiple commits if needed
- Auto-selects first message suggestion for each commit
- No interactive prompts or confirmations
- Ideal for complex changes that need automatic logical grouping

### --push

Automatically push to remote after creating commit(s):

- Executes `git push` after all commits
- Shows push progress and status
- Works with both standard and fast modes

### --single

Create a single commit for all changes:

- Skips intelligent grouping
- All staged files in one commit
- Useful for small, cohesive changes

### --brief

Use single-line commit messages only:

- No bullet points or extended descriptions
- Just the main commit message line
- Keeps commit history concise

## Implementation Guidelines

### 1. Branch Analysis

```bash
# Get current branch name
git branch --show-current

# Extract prefix using regex patterns:
# - ([A-Z]+-[0-9]+) for JIRA-style tickets
# - ([A-Z]{2,}-[0-9]+) for custom prefixes
# - Support various separators: /, _, -
```

### 2. File Staging Strategy

```bash
# Check current status
git status --short

# If no files staged and not in fast mode:
git add .

# For grouped commits:
git reset  # Unstage all
git add [specific files for this commit]
```

### 3. Change Analysis

Analyze files to determine logical groupings:

- Check file paths and extensions
- Identify related functionality
- Group by architectural layers
- Consider dependencies between changes

### 4. Message Generation

Generate descriptive messages based on:

- Changed file types and locations
- Detected patterns (new files, deletions, refactoring)
- Common development tasks
- Branch name context

### 5. Validation Rules

Before each commit:

- Ensure message doesn't contain emojis
- No "Generated with Claude Code" footers
- No "Co-Authored-By" lines
- Clean, professional format
- Verify prefix format if present

## Best Practices

### Atomic Commits

- Each commit should represent one logical change
- Related changes should be grouped together
- Unrelated changes should be separate commits

### Message Guidelines

- **First line**: Clear, descriptive summary (50-72 chars ideal)
- **Body** (optional): Brief bullet points for details
- **Present tense**: "Add feature" not "Added feature"
- **Imperative mood**: Write as commands
- **No metadata**: No generation footers or co-author lines

### Grouping Strategy

When in doubt about grouping:

1. Group by feature/functionality first
2. Then by architectural layer
3. Then by file type
4. Keep test files with their implementation when logical

### Examples of Good Messages

**Feature Implementation:**

```text
PROJ-123 Implement real-time notification system with WebSocket support

- Add WebSocket server configuration
- Create notification service layer
- Implement client-side listeners
```

**Bug Fix:**

```text
BUG-456 Fix memory leak in data processing pipeline

- Clear unused references after processing
- Add proper cleanup in error handlers
```

**Refactoring:**

```text
TECH-789 Refactor database connection pool for improved performance

- Implement connection recycling
- Add connection health checks
- Optimize query batching
```

**Configuration Update:**

```text
OPS-321 Update deployment configuration for production environment
```

## Troubleshooting

### No files to commit

- Ensure you have made changes to tracked files
- Check `.gitignore` isn't excluding your changes
- Use `git status` to verify file states

### Prefix not detected

- Check your branch naming convention
- Manually provide prefix when prompted
- Use `--no-prefix` to skip prefix extraction

### Commit rejected by hooks

- Review pre-commit hook output
- Fix identified issues
- Use `--no-verify` only as last resort

## Notes

- This command never adds emojis to commit messages
- No Claude-specific footers or metadata
- Fully generic and project-agnostic
- Supports any ticket/issue tracking system
- Focuses on clean, professional commit history
