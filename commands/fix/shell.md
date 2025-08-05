---
description: Automatically fix shell script issues using shellcheck analysis
argument-hint: [--check-only] [--strict] [--summary-only]
---

# Claude Command: Shellcheck

This command automatically fixes shell script issues using shellcheck analysis. By default, all safe fixes are applied automatically. Use --check-only to preview issues without making changes.

## Usage

```
/shellcheck                    # Automatically fix all shell script issues
/shellcheck --check-only       # Only check and report issues without fixing
/shellcheck --strict           # Fix issues including optional/style checks
/shellcheck --summary-only     # Fix issues and show only summary
/shellcheck --check-only --strict  # Check with strict mode without fixing
```

### Arguments

- `--check-only`: Only analyze and report issues without applying fixes
- `--strict`: Enable strict mode (includes optional and style checks)
- `--summary-only`: Display only the summary without detailed issue listings

## What This Command Does

1. **Discovers Shell Scripts**:
   - Searches for all shell scripts in the project (*.sh, *.bash, *.zsh, *.ksh)
   - Detects scripts by shebang line (#!/bin/bash, #!/bin/sh, etc.)
   - Excludes common directories (node_modules, .git, vendor, etc.)
   - Identifies executable files that might be shell scripts

2. **Checks Shellcheck Installation**:
   - Verifies if shellcheck is installed on the system
   - Provides platform-specific installation instructions if missing:
     - macOS: `brew install shellcheck`
     - Ubuntu/Debian: `sudo apt-get install shellcheck`
     - Fedora: `sudo dnf install shellcheck`
     - Arch: `sudo pacman -S shellcheck`
   - Offers alternative installation methods (direct download, Docker)

3. **Analyzes Scripts**:
   - Runs shellcheck on each discovered script
   - Categorizes issues by severity (error, warning, info, style)
   - Groups issues by type for better understanding
   - Tracks line numbers and specific problems

4. **Automatic Fixes** (default behavior):
   - Quotes unquoted variables: `$var` → `"$var"`
   - Fixes array expansions: `${array[@]}` → `"${array[@]}"`
   - Corrects test conditions: `[ $var = "value" ]` → `[ "$var" = "value" ]`
   - Updates deprecated syntax: backticks → `$()`
   - Adds proper error handling where missing
   - Preserves file permissions and attributes
   - No backup files created (relies on git for version control)

5. **Generates Report**:
   - Total scripts analyzed
   - Issues found by severity
   - Issues fixed (if --fix used)
   - Remaining issues requiring manual attention
   - Script quality score
   - Specific recommendations for improvement

## Shellcheck Severity Levels

### Error (SC2xxx)
Critical issues that will likely cause script failure:
- Syntax errors
- Undefined variables
- Missing quotes that cause word splitting
- Incorrect test operators

### Warning (SC1xxx)
Issues that may cause unexpected behavior:
- Deprecated syntax
- Portability problems
- Common logic errors
- Security concerns

### Info (SC3xxx)
Suggestions for better practices:
- Performance improvements
- Readability enhancements
- Modern syntax alternatives

### Style (SC4xxx) - Only with --strict
Optional style recommendations:
- Consistent formatting
- Best practice patterns
- Code clarity improvements

## Automatic Fix Examples

### Variable Quoting
```bash
# Before
if [ $1 = "test" ]; then
    echo $HOME/config

# After (automatically fixed)
if [ "$1" = "test" ]; then
    echo "$HOME/config"
```

### Command Substitution
```bash
# Before
result=`ls -la`

# After (automatically fixed)
result=$(ls -la)
```

### Array Handling
```bash
# Before
for item in ${array[@]}; do
    echo $item

# After (automatically fixed)
for item in "${array[@]}"; do
    echo "$item"
```

### Conditional Improvements
```bash
# Before
if [[ $var == "value" && $other == "test" ]]

# After (automatically fixed)
if [[ "$var" == "value" && "$other" == "test" ]]
```

## Workflow Steps

1. **Environment Check**:
   - Verify shellcheck installation
   - Check shellcheck version for feature compatibility
   - Ensure proper permissions for script modification

2. **Script Discovery**:
   - Use find/glob to locate shell scripts
   - Check file headers for shell shebangs
   - Build list of scripts to analyze

3. **Analysis Phase**:
   - Run shellcheck with appropriate flags
   - Parse JSON output for structured results
   - Categorize and group issues

4. **Fix Phase** (default, unless --check-only):
   - Apply safe automatic fixes directly
   - Verify scripts still execute properly
   - Track all modifications made
   - Rely on git for version history

5. **Reporting**:
   - Display detailed issue list (unless --summary-only)
   - Show fix statistics
   - Provide actionable recommendations
   - Suggest next steps for remaining issues

## Best Practices

### Script Quality Guidelines

1. **Always quote variables**: Prevents word splitting and globbing
2. **Use modern syntax**: Prefer `$()` over backticks
3. **Check command success**: Use proper error handling
4. **Declare variables**: Use `local` in functions
5. **Set strict mode**: Add `set -euo pipefail` to scripts
6. **Use version control**: Commit before running shellcheck fixes

### Common Issues to Avoid

- Unquoted variables in conditions
- Missing error checking after commands
- Use of deprecated syntax
- Incorrect array handling
- Missing shebang lines
- Inconsistent indentation

### Version Control Integration

- Always review changes with `git diff` after fixes
- Consider committing before running shellcheck
- Use `git checkout -- <file>` to revert unwanted changes
- The command works seamlessly with git workflows

## Integration with CI/CD

The command can be used in continuous integration:

```yaml
# GitHub Actions example
- name: Check shell scripts
  run: |
    shellcheck **/*.sh

# GitLab CI example
shellcheck:
  script:
    - shellcheck scripts/*.sh
```

## Exclusions and Ignoring

### Default Exclusions
- `node_modules/`
- `.git/`
- `vendor/`
- `venv/`, `.venv/`
- `build/`, `dist/`
- `*.min.sh` (minified scripts)

### Inline Ignoring
Scripts can include directives to ignore specific warnings:

```bash
# shellcheck disable=SC2086
echo $unquoted_var_intentionally

# shellcheck disable=SC2086,SC2181
# Multiple codes can be disabled
```

## Error Handling

The command handles various scenarios:

- **Shellcheck not installed**: Provides installation instructions
- **No shell scripts found**: Informs user and suggests locations
- **Permission denied**: Requests permission or skips files
- **Syntax errors**: Reports but continues with other files
- **Large codebases**: Processes in batches with progress updates
- **No git repository**: Works normally but warns about lack of version control
- **Uncommitted changes**: Notifies user to review changes with `git diff`

## Example Output

### Check-Only Mode (--check-only)
```
🔍 Analyzing shell scripts in project...

Found 12 shell scripts to analyze:
- install.sh
- scripts/update-readme.sh
- scripts/build.sh
- test/run-tests.sh
...

❌ install.sh:
  Line 15 [SC2086]: Double quote to prevent globbing and word splitting
  Line 42 [SC2181]: Check exit code directly with if statement
  Line 78 [SC1090]: Can't follow non-constant source

⚠️ scripts/update-readme.sh:
  Line 23 [SC2034]: Variable appears unused
  Line 45 [SC2162]: read without -r will mangle backslashes

📊 Summary:
- Scripts analyzed: 12
- Total issues: 23 (8 errors, 12 warnings, 3 info)
- Critical issues: 2
- Scripts passing: 7/12 (58%)

💡 Recommendations:
1. Fix critical quoting issues in install.sh
2. Add error handling to build scripts
3. Consider enabling strict mode in CI scripts
```

### Default Fix Mode (Standard Behavior)
```
🔧 Automatically fixing shell script issues...

✅ Fixed install.sh:
  - Added quotes to 8 variables
  - Updated command substitution syntax
  - Fixed array expansion

✅ Fixed scripts/update-readme.sh:
  - Added -r flag to read commands
  - Quoted test conditions
  - Fixed local variable declarations

📊 Fix Summary:
- Scripts processed: 12
- Issues fixed automatically: 18/23 (78%)
- Files modified: 5
- Remaining manual fixes: 5

⚠️ Manual fixes required:
- install.sh:78 - Dynamic source path needs review
- test/integration.sh:45 - Complex regex may need escaping

💡 Run 'git diff' to review changes
💡 Run with --check-only to preview changes without applying fixes
```

## Important Notes

- **Default behavior**: Automatically fixes all safe issues found
- **Check-only mode**: Use `--check-only` to preview without changes
- **No backup files**: Relies on git for version control
- Only applies safe, automated fixes
- Preserves file permissions and attributes
- Respects existing shellcheck disable comments
- Works with all POSIX-compliant shells
- Supports both shellcheck JSON and terminal output
- Can be integrated into git pre-commit hooks
- Provides actionable feedback for manual fixes
- Compatible with shellcheck 0.7.0 and newer
- Files are modified in-place with atomic writes
- Skips files that would have no changes after fixes
- Shows git diff after fixes for easy review

## Platform-Specific Installation

### macOS
```bash
# Homebrew (recommended)
brew install shellcheck

# MacPorts
sudo port install shellcheck
```

### Linux
```bash
# Ubuntu/Debian
sudo apt-get update && sudo apt-get install shellcheck

# Fedora
sudo dnf install shellcheck

# Arch Linux
sudo pacman -S shellcheck

# From snap
sudo snap install shellcheck
```

### Direct Download
```bash
# Latest release from GitHub
wget -qO- "https://github.com/koalaman/shellcheck/releases/download/stable/shellcheck-stable.linux.x86_64.tar.xz" | tar -xJv
sudo cp shellcheck-stable/shellcheck /usr/local/bin/
```

### Docker Alternative
```bash
# If shellcheck cannot be installed
docker run --rm -v "$PWD:/mnt" koalaman/shellcheck:stable scripts/*.sh
```