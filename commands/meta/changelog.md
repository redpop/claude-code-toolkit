---
description: AI-powered CHANGELOG.md management that automatically determines version based on changes
argument-hint: [--analyze] [--commit] [--update-version]
---

# Claude Command: Changelog

This command intelligently manages your project's CHANGELOG.md file by analyzing your changes and automatically determining the appropriate version bump following [Keep a Changelog](https://keepachangelog.com/) format and [Semantic Versioning](https://semver.org/) conventions.

## Usage

```
/changelog                              # AI determines version and updates changelog
/changelog --analyze                    # Preview what version would be chosen without making changes
/changelog --commit                     # Update changelog and commit using git commit command
/changelog --update-version             # Also update version in package files
/changelog --commit --update-version    # Full automated workflow
```

### Arguments

- `--analyze`: Preview mode - shows what version would be chosen and what changes would be added
- `--commit`: Automatically commit the changelog update (uses `/git/commit` command if available)
- `--update-version`: Update version in package files (package.json, pyproject.toml, etc.)

## Examples

```
/changelog                                    # Basic usage - AI analyzes and updates changelog
/changelog --analyze                          # See what would happen without changes
/changelog --commit                           # Update and commit with proper message
/changelog --commit --update-version          # Full release workflow
```

## What This Command Does

1. **Analyzes Your Changes**:
   - Reviews git history since last version/tag
   - Examines uncommitted changes and staged files
   - Identifies breaking changes, new features, and bug fixes
   - Categorizes changes by type (added, changed, deprecated, removed, fixed, security)

2. **Determines Version Automatically**:
   - **Major bump (X.0.0)**: Breaking changes, removed features, API changes
   - **Minor bump (0.X.0)**: New features, added functionality
   - **Patch bump (0.0.X)**: Bug fixes, documentation, refactoring
   - Reads current version from existing CHANGELOG.md or package files
   - Calculates next version based on change severity

3. **Manages Changelog**:
   - Creates CHANGELOG.md if it doesn't exist with proper header
   - Adds new version section with today's date
   - Groups changes by type with emoji prefixes
   - Maintains proper Keep a Changelog formatting
   - Preserves existing changelog content

4. **Optional Actions**:
   - **--analyze**: Preview mode to see what would happen
   - **--update-version**: Updates version in all detected package files
   - **--commit**: Integrates with `/git/commit` command for proper commit workflow

## Change Type Emojis

The command automatically prefixes entries with appropriate emojis:

- ✨ **Added**: New features
- 🔄 **Changed**: Changes in existing functionality
- ⚠️ **Deprecated**: Soon-to-be removed features
- 🗑️ **Removed**: Removed features
- 🐛 **Fixed**: Bug fixes
- 🔒 **Security**: Security vulnerability fixes

## Changelog Structure

The command maintains this structure:

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.2.0] - 2024-01-15

### Added
- ✨ New feature description

### Changed
- 🔄 Modified functionality description

### Fixed
- 🐛 Bug fix description

## [1.1.0] - 2024-01-01
...
```

## Workflow Steps

1. **Analyze Repository State**:
   - Get current version from CHANGELOG.md or package files
   - List all commits since last version tag
   - Examine uncommitted and staged changes
   - Parse commit messages for conventional commit types

2. **Determine Version Bump**:
   - Scan for breaking change indicators:
     - Commit messages with "BREAKING:", "BREAKING CHANGE:"
     - Major API changes or removed features
   - Identify new features (feat: commits) → Minor bump
   - Identify fixes (fix: commits) → Patch bump
   - Choose highest severity change for version bump

3. **Generate Changelog Entries**:
   - Group commits and changes by type
   - Extract meaningful descriptions from commit messages
   - Format entries with appropriate emoji prefixes
   - Organize by category (Added, Changed, Fixed, etc.)

4. **Update CHANGELOG.md**:
   - Create file with Keep a Changelog header if missing
   - Add new version section with current date
   - Insert categorized entries
   - Maintain proper formatting and structure

5. **Update Version Files** (if --update-version):
   - Detect all package files in project
   - Update version fields to new version
   - Validate file syntax after updates

6. **Commit Changes** (if --commit):
   - Check if `/commands/git/commit.md` exists
   - If exists: Use git commit command workflow
     - Run pre-commit checks (lint, build, docs)
     - Create conventional commit with emoji
   - If not exists: Simple git commit
   - Commit message: `📝 docs: update changelog for v{version}`

## AI Version Detection

The AI analyzes your codebase to determine the appropriate version bump:

### Breaking Changes (Major Version X.0.0)
- Commits containing "BREAKING:", "BREAKING CHANGE:"
- Removed public APIs or features
- Incompatible changes to existing functionality
- Major architectural changes

### New Features (Minor Version 0.X.0)
- Commits with type `feat:`
- New functionality added
- New public APIs
- Backward-compatible enhancements

### Bug Fixes (Patch Version 0.0.X)
- Commits with type `fix:`
- Documentation updates
- Performance improvements
- Refactoring without API changes

## Best Practices

- **Commit Messages Matter**: Use conventional commits for better AI detection
  - `feat:` for new features
  - `fix:` for bug fixes
  - `BREAKING CHANGE:` for breaking changes
  
- **Review Before Committing**: Use `--analyze` to preview changes first

- **Full Release Workflow**: Use `--commit --update-version` for complete automation

- **Keep Commits Atomic**: Smaller, focused commits help AI categorize changes accurately

## Version Update Support

The command intelligently updates version in:

### Node.js (package.json)
```json
{
  "version": "1.2.0"
}
```

### Python (pyproject.toml)
```toml
[tool.poetry]
version = "1.2.0"

# or

[project]
version = "1.2.0"
```

### Python (setup.py)
```python
setup(
    version="1.2.0",
    ...
)
```

### Python (__init__.py)
```python
__version__ = "1.2.0"
```

### Rust (Cargo.toml)
```toml
[package]
version = "1.2.0"
```

### Java (pom.xml)
```xml
<version>1.2.0</version>
```

## Error Handling

The command handles:
- Missing CHANGELOG.md (creates new with proper format)
- No previous version found (starts from 0.1.0)
- Conflicting changes (prompts for clarification)
- File permission issues
- Malformed existing changelog (attempts repair)
- Git repository not initialized (clear error message)
- No changes detected (informs user)

## Important Notes

- AI intelligently determines version based on change severity
- Always uses today's date for new version sections
- Preserves existing changelog formatting and content
- Creates backup before major modifications
- Validates all changes before writing
- Emoji prefixes are added automatically based on change type
- Integrates seamlessly with git commit command when available
- Supports both new projects and existing ones with version history
- Analyzes both committed and uncommitted changes

## Integration with Git Commit Command

When using `--commit`:
- First checks if `/commands/git/commit.md` exists in the project
- If the git commit command exists:
  - Runs pre-commit checks (lint, build, generate:docs)
  - Uses conventional commit format with emojis
  - Creates descriptive commit message
  - Follows the git commit command workflow
- If git commit command doesn't exist:
  - Falls back to simple git commit
  - Still uses conventional format: `📝 docs: update changelog for v{version}`
- Shows git status after commit
- Only stages CHANGELOG.md and version files (if --update-version used)

## Examples of AI-Generated Changelog

### Example 1: Feature Release
After commits:
- `feat: add user authentication system`
- `feat: implement OAuth2 integration`
- `fix: resolve login timeout issue`

Running `/changelog --commit` generates:
```markdown
## [1.2.0] - 2024-01-26

### Added
- ✨ User authentication system
- ✨ OAuth2 integration

### Fixed
- 🐛 Resolve login timeout issue
```

### Example 2: Breaking Change
After commits:
- `feat!: redesign API endpoints`
- `BREAKING CHANGE: remove deprecated v1 endpoints`
- `fix: update error handling`

Running `/changelog --analyze` shows:
```
Version bump: 1.1.0 → 2.0.0 (MAJOR - breaking changes detected)
Changes to be added:
- Breaking: Redesign API endpoints, remove deprecated v1 endpoints
- Fixed: Update error handling
```

### Example 3: Patch Release
After commits:
- `fix: memory leak in cache layer`
- `docs: update API documentation`
- `chore: update dependencies`

Running `/changelog --commit --update-version`:
- Determines version: 1.1.1 (patch bump)
- Updates CHANGELOG.md
- Updates version in package.json
- Commits with: `📝 docs: update changelog for v1.1.1`

### Example 4: Preview Mode
Running `/changelog --analyze` without making changes:
```
Current version: 1.0.0
Analyzing changes since last release...

Proposed version: 1.1.0 (MINOR)
Detected changes:
- Added: New dashboard feature
- Changed: Improved performance metrics
- Fixed: Navigation bug on mobile

No files will be modified (preview mode)
```