---
allowed-tools: Task, Read, Edit, MultiEdit, Write, Grep, Bash(find:*), Bash(git:*)
description: Fix documentation issues including broken links, parameter mismatches, missing cross-references, and outdated content
argument-hint: [report.json|directory] [--fix-links] [--fix-params] [--add-deprecation] [--dry-run] [--interactive]
---

# Fix Documentation Command

This command automatically fixes common documentation issues identified by documentation health analysis, including broken links, parameter mismatches, missing cross-references, and outdated content.

## Usage Examples

```bash
# Fix all issues from doc-health report
/fix-documentation doc-health-report.json

# Fix broken links and parameters
/fix-documentation . --fix-links --fix-params

# Preview fixes without applying
/fix-documentation . --dry-run

# Interactive mode - approve each fix
/fix-documentation . --interactive

# Add deprecation notices
/fix-documentation . --add-deprecation
```

## Fix Categories

### 1. Parameter Synchronization

#### CLI Arguments

```markdown
# Before (README.md)
Usage: analyze-deep --output-format=json|xml

# After (automatically fixed)
Usage: analyze-deep --export-json --export-md --export-html
```

#### Function Parameters

```markdown
# Before (API.md)
### processData(data)
Processes the input data.

# After (detected from code)
### processData(data, options = {})
Processes the input data.

**Parameters:**
- `data` (any): The data to process
- `options` (Object): Processing options (optional)
  - `format` (string): Output format ('json'|'xml'|'csv')
  - `validate` (boolean): Whether to validate input
```

#### Configuration Options

```markdown
# Before (config.md)
- `timeout`: Request timeout in seconds

# After (synced with code)
- `timeoutMs`: Request timeout in milliseconds
- `timeout`: ⚠️ **Deprecated** - Use `timeoutMs` instead
```

### 2. Cross-Reference Fixes

#### Internal Links

```markdown
# Before
See [Installation Guide](./docs/install.md) <!-- File doesn't exist -->

# After
See [Getting Started](./docs/getting-started.md) <!-- Corrected path -->
```

#### Anchor Links

```markdown
# Before  
[Testing](#testing-guidelines) <!-- Anchor missing -->

# After
[Testing](#testing) <!-- Fixed anchor -->
```

#### Smart Reference Addition

```markdown
# Before
For configuration options, check the documentation.

# After
For configuration options, see the [Configuration Guide](./docs/configuration.md).
```

### 3. Deprecation Management

```markdown
# Before
### oldMethod(params)
Processes data with given parameters.

# After (when detected in code as @deprecated)
### oldMethod(params) 
⚠️ **Deprecated since v2.0** - Use [`newMethod()`](#newmethod) instead.

Processes data with given parameters.

**Migration Guide:**
```javascript
// Old way (deprecated)
const result = oldMethod(params);

// New way
const result = newMethod(params);
```

```

### 4. Structure Improvements

#### README.md Enhancement
```markdown
# Before
# My Project
Some description here.

## Install
npm install

## Usage
Run the command.

# After
# My Project

> Brief project description with key features

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
- [API Reference](#api-reference)
- [Contributing](#contributing)
- [License](#license)

## Installation

```bash
npm install my-project
```

## Usage

### Basic Example

```javascript
const myProject = require('my-project');
const result = myProject.process(data);
```

### CLI Usage

```bash
my-project analyze --input=file.json
```

## API Reference

See the [full API documentation](./docs/api.md).

## Contributing

Please read [CONTRIBUTING.md](./CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see [LICENSE](./LICENSE).

```

## Fix Workflow

### Phase 1: Load Issues

1. **From Report**:
   ```javascript
   // Load doc-health-report.json
   const issues = loadReport(reportFile);
   ```

2. **From Fresh Analysis**:

   ```bash
   # Run quick analysis
   /doc-health . --export-json=temp-report.json
   ```

### Phase 2: Categorize Fixes

Group issues by:

1. **Auto-fixable**: Parameter names, broken links, formatting
2. **Semi-automatic**: Need code analysis for context
3. **Manual required**: Complex restructuring, content creation

### Phase 3: Apply Fixes

For each auto-fixable issue:

1. **Parameter Fixes**:

   ```javascript
   // Extract from code
   const actualParams = parseFunction(codeFile);
   
   // Update documentation
   updateDocumentation(docFile, {
     oldSignature,
     newSignature: actualParams
   });
   ```

2. **Link Fixes**:

   ```javascript
   // Find correct target
   const correctPath = findSimilarFile(brokenLink);
   
   // Update link
   replaceLink(docFile, {
     old: brokenLink,
     new: correctPath
   });
   ```

3. **Deprecation Notices**:

   ```javascript
   // Check code annotations
   if (hasDeprecationAnnotation(method)) {
     addDeprecationNotice(docFile, {
       method,
       since: annotation.since,
       alternative: annotation.alternative
     });
   }
   ```

### Phase 4: Validation

After fixes:

```bash
# Re-run health check
/doc-health . --quick

# Verify no regressions
git diff --check
```

### Phase 5: Report

```markdown
## Documentation Fix Report

### Summary
- **Total Issues**: 24
- **Auto-fixed**: 18
- **Manual Required**: 6
- **Success Rate**: 75%

### Fixed Issues

#### Parameter Synchronization (8 fixed)
✅ README.md:45 - Updated CLI arguments for `/analyze-deep`
✅ API.md:78 - Added missing parameter to `processData()`
✅ config.md:23 - Renamed `timeout` to `timeoutMs`
...

#### Cross-References (6 fixed)
✅ README.md:89 - Fixed link to installation guide
✅ CONTRIBUTING.md:34 - Corrected anchor reference
✅ docs/api.md:123 - Updated example file path
...

#### Deprecations Added (4)
✅ API.md:156 - Marked `oldMethod` as deprecated
✅ CLI.md:89 - Added deprecation for `--legacy` flag
...

### Manual Actions Required

1. **Create Missing Files**:
   - SECURITY.md - Security disclosure policy
   - docs/troubleshooting.md - Common issues

2. **Content Updates**:
   - Update examples in quickstart.md
   - Add migration guide for v2.0

3. **Complex Restructuring**:
   - Reorganize API reference by module
   - Split large README into multiple docs

### Next Steps
1. Review changes: `git diff`
2. Run tests to ensure examples work
3. Commit: `git commit -m "docs: fix documentation issues"`
```

## Fix Strategies

### Smart Link Resolution

```javascript
// When link target missing, find best match:
1. Similar filename: install.md → installation.md
2. Content search: Find file containing expected content
3. Common patterns: README → readme, docs/ → documentation/
4. Suggest creation: If truly missing
```

### Parameter Matching

```javascript
// Fuzzy matching for parameters:
- timeout vs timeoutMs (suffix variation)
- output-format vs export-format (prefix variation)
- debug vs verbose (semantic similarity)
```

### Deprecation Detection

```javascript
// Sources for deprecation info:
1. Code annotations (@deprecated, @obsolete)
2. Comments (TODO: Remove in v3.0)
3. Changelog entries
4. Git history (removed features)
```

## Configuration

```yaml
# .doc-fix.yml
fixes:
  auto_fix_links: true
  auto_fix_params: true
  add_deprecation_notices: true
  
link_resolution:
  try_similar_names: true
  search_content: true
  max_suggestions: 3
  
parameter_matching:
  fuzzy_threshold: 0.8
  check_types: true
  
style:
  add_toc: true
  standardize_headers: true
  fix_formatting: true
```

## Safety Features

### Dry Run Mode

```bash
/fix-documentation . --dry-run

Would fix:
- README.md:45 - Update parameter from --output to --export-json
- API.md:78 - Add missing 'options' parameter
- docs/guide.md:23 - Fix broken link to installation
[No changes made]
```

### Interactive Mode

```bash
/fix-documentation . --interactive

Found: Broken link './docs/install.md'
Suggested fix: './docs/installation.md'
Apply this fix? [Y/n/e(dit)/s(kip)]: y
✅ Fixed link in README.md:45
```

### Backup Creation

```bash
# Automatic backup before fixes
Creating backup: .documentation-backup-20240128/
Applying fixes...
✅ Backup available at .documentation-backup-20240128/
```

## Integration

- **After `/doc-health`**: Fix issues found in analysis
- **Before `/git-commit`**: Ensure docs are synchronized
- **With `/update-docs`**: Comprehensive documentation update
- **In `/quality-sprint`**: Include doc fixes in sprint

## Best Practices

1. **Review Changes**: Always review automated fixes
2. **Test Examples**: Ensure code examples still work
3. **Preserve Intent**: Don't change meaning, just fix issues
4. **Incremental Fixes**: Fix category by category
5. **Version Control**: Commit doc fixes separately

This command helps maintain accurate, consistent documentation that stays synchronized with your evolving codebase.
