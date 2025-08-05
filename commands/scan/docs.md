---
allowed-tools: Task, Read, Grep, Bash(find:*), Bash(ls:*), Write
description: Analyze documentation health, validate code-doc synchronization, check cross-references, and identify outdated content
argument-hint: [directory] [--scope=readme|api|all] [--check-links] [--validate-params] [--export-report]
---

# Documentation Health Analysis

This command performs a comprehensive health check of your project's documentation, validating synchronization with code, checking cross-references, identifying outdated content, and providing actionable improvement recommendations.

## Usage Examples

```bash
# Full documentation health check
/doc-health .

# Focus on README and main docs
/doc-health . --scope=readme

# Validate all parameters and links
/doc-health . --validate-params --check-links

# Generate detailed report
/doc-health . --export-report=doc-health-report.md
```

## Analysis Workflow

### Phase 1: Documentation Discovery

1. **Scan for Documentation**:

   ```bash
   # Find all documentation files
   - README.md, CLAUDE.md, CONTRIBUTING.md
   - docs/, documentation/ directories
   - *.md, *.rst, *.txt files
   - Package documentation (package.json, pyproject.toml)
   ```

2. **Categorize Documents**:
   - **User Docs**: README, Getting Started, Tutorials
   - **API Docs**: Reference, Function docs, CLI help
   - **Dev Docs**: Contributing, Architecture, Design
   - **Meta Docs**: Changelog, Security, License

### Phase 2: Code Analysis

1. **Extract Code Elements**:

   - Function signatures and parameters
   - CLI commands and arguments
   - Configuration options
   - API endpoints and methods
   - Class definitions and methods
   - Constants and enums

2. **Identify Features**:
   - Public APIs
   - User-facing commands
   - Configuration systems
   - Integration points

### Phase 3: Validation Checks

Use Task tool with subagent_type="general-purpose":
"You are an expert in documentation quality analysis, technical writing best practices, and maintaining documentation-code synchronization. Your expertise spans across multiple documentation formats, programming languages, and project structures.

Analyze documentation health for this project with the following documentation files found: [list of files found]

Code structure extracted: [extracted elements]

Focus on these areas:

1. Parameter validation (CLI args, function params, config options)
2. Cross-reference and link validation
3. Deprecation tracking and outdated content
4. Code-documentation synchronization
5. Documentation coverage and completeness

Provide a comprehensive health report including:

1. Overall health score (0-100) with breakdown by category:
   - Completeness (40%): Coverage of all features
   - Accuracy (30%): Sync with current code
   - Clarity (20%): Readability and structure
   - Navigation (10%): Cross-references and findability
2. Critical issues that need immediate attention
3. Parameter mismatches between docs and code (with specific examples)
4. Broken cross-references and links (internal and external)
5. Outdated or deprecated content
6. Coverage gaps (undocumented features, missing sections)
7. Prioritized recommendations (High/Medium/Low priority)

Format the output as a structured markdown report with clear sections, tables for mismatches, and actionable next steps."

### Phase 4: Specific Validations

#### Parameter Validation

```javascript
// Check CLI arguments
// Code: command --verbose --output=file
// Docs: command --debug --out=file  ❌ Mismatch

// Check function parameters
// Code: function process(data, options = {})
// Docs: function process(data)  ❌ Missing parameter

// Check configuration
// Code: config.retryLimit
// Docs: config.maxRetries  ❌ Wrong name
```

#### Cross-Reference Validation

```markdown
// Check internal links
[Installation Guide](./docs/install.md) → Verify file exists
[See API Reference](#api) → Verify anchor exists
[Related Command](/commands/analyze.md) → Verify path

// Check external links (if --check-links)
[Documentation](https://example.com/docs) → HTTP check
```

#### Deprecation Detection

```javascript
// Code: @deprecated since 2.0, use newMethod instead
// Docs: Should mention deprecation

// Code: // TODO: Remove in v3.0
// Docs: Should have migration guide
```

### Phase 5: Report Generation

Generate comprehensive health report:

````markdown
# Documentation Health Report

Generated: 2024-01-28
Project: claude-code-toolkit

## Executive Summary

- **Overall Health Score**: 82/100 🟢
- **Critical Issues**: 2 🔴
- **Warnings**: 8 🟡
- **Suggestions**: 15 💡
- **Coverage**: 78% of features documented

## Health Breakdown

| Category     | Score  | Status       |
| ------------ | ------ | ------------ |
| Completeness | 85/100 | 🟢 Good      |
| Accuracy     | 72/100 | 🟡 Fair      |
| Structure    | 90/100 | 🟢 Excellent |
| Navigation   | 81/100 | 🟢 Good      |

## Critical Issues

### 1. Security Documentation Missing

**Severity**: 🔴 Critical
**File**: SECURITY.md (not found)
**Impact**: No clear vulnerability reporting process
**Fix**: Create SECURITY.md with disclosure policy
**Command**: `/generate-documentation . --types=security`

### 2. Major Parameter Mismatch

**Severity**: 🔴 Critical  
**File**: README.md:156
**Issue**: CLI command `/analyze-deep` documented with wrong parameters
**Current**: `--output-format=json|xml`
**Actual**: `--export-json --export-md --export-html`
**Fix**: Update documentation to match implementation

## Parameter Validation Results

### CLI Arguments

| Command         | Documented        | Actual       | Status | File                |
| --------------- | ----------------- | ------------ | ------ | ------------------- |
| `/analyze-deep` | `--output-format` | `--export-*` | ❌     | README.md:156       |
| `/fix-security` | `--level`         | `--severity` | ❌     | docs/security.md:34 |

### Function Parameters

| Function           | Documented | Actual            | Status | Location            |
| ------------------ | ---------- | ----------------- | ------ | ------------------- |
| `analyzeCode()`    | 2 params   | 3 params          | ❌     | api-reference.md:78 |
| `generateReport()` | `(data)`   | `(data, options)` | ❌     | api-reference.md:95 |

## Cross-Reference Validation

### Broken Internal Links

| Source             | Target                 | Issue          |
| ------------------ | ---------------------- | -------------- |
| README.md:45       | `./docs/install.md`    | File not found |
| CONTRIBUTING.md:78 | `#testing-guidelines`  | Anchor missing |
| docs/api.md:123    | `../examples/basic.js` | Path incorrect |

### Invalid Cross-References

| Document  | Reference                 | Issue             |
| --------- | ------------------------- | ----------------- |
| README.md | "See Configuration Guide" | No link provided  |
| API.md    | "As mentioned above"      | Unclear reference |

## Coverage Analysis

### Documented: 45/58 features (78%)

### Missing Documentation

1. **Functions** (5 undocumented):

   - `utils.parseArguments()`
   - `helpers.validateInput()`
   - `core.processResults()`

2. **CLI Options** (4 undocumented):

   - `--experimental-mode`
   - `--skip-validation`
   - `--parallel-workers`

3. **Configuration** (4 undocumented):
   - `config.cacheTimeout`
   - `config.retryStrategy`

## Deprecation Status

### Properly Marked

✅ `oldAnalyze()` - Marked as deprecated with migration guide

### Missing Deprecation Notices

❌ `legacyFormat` option - Used in code with TODO for removal
❌ `/old-command` - Still documented but removed from code

## Quality Recommendations

### 🔴 High Priority (Fix immediately)

1. Create SECURITY.md file
2. Fix CLI parameter documentation for `/analyze-deep`
3. Update function signatures in API reference
4. Fix broken links to installation guide

### 🟡 Medium Priority (Next sprint)

1. Document missing CLI options
2. Add examples for complex functions
3. Create migration guide for deprecated features
4. Improve cross-reference clarity

### 💡 Low Priority (Continuous improvement)

1. Enhance README structure with TOC
2. Add more code examples
3. Create troubleshooting guide
4. Add search keywords/tags

## Actionable Next Steps

1. **Quick Fixes** (< 1 hour):
   ```bash
   /fix-documentation . --fix-params --fix-links
   ```
````

2. **Generate Missing Docs** (2-4 hours):

   ```bash
   /generate-documentation . --types=security,api --missing-only
   ```

3. **Update Existing** (1-2 hours):
   ```bash
   /update-docs . --scope=all --validate
   ```

## Documentation Standards Compliance

### README.md Checklist

- [x] Title and description
- [x] Installation instructions
- [ ] Complete usage examples
- [x] Basic API reference
- [ ] Troubleshooting section
- [x] Contributing guidelines link
- [x] License information

### Best Practices Score: 7/10

- ✅ Clear headings structure
- ✅ Code examples included
- ❌ Examples not tested
- ✅ Consistent formatting
- ❌ Some broken links
- ✅ Version information
- ❌ Search optimization missing

````

## Implementation Details

### Link Checking
```javascript
// Internal links - file system check
if (link.startsWith('./') || link.startsWith('../')) {
  checkFileExists(resolvedPath);
}

// Anchor links - parse and verify
if (link.includes('#')) {
  checkAnchorExists(file, anchor);
}

// External links (optional) - HTTP check
if (options.checkExternalLinks) {
  validateHttpLink(url);
}
````

### Parameter Extraction

```javascript
// CLI argument patterns
--flag, -f
--option=value, -o value
--complex-name

// Function patterns
function name(param1, param2 = default)
const name = (param1: type, param2?: type) =>
def name(param1, param2=None):

// Configuration patterns
config.option
settings['option']
ENV_VARIABLE
```

### Scoring Algorithm

```
Health Score = (
  Completeness * 0.4 +
  Accuracy * 0.3 +
  Structure * 0.2 +
  Navigation * 0.1
) * 100

Where:
- Completeness = documented_features / total_features
- Accuracy = correct_params / total_params
- Structure = sections_present / required_sections
- Navigation = valid_links / total_links
```

## Integration with Other Commands

- **With `/analyze-deep`**: Include doc health in comprehensive analysis
- **With `/fix-documentation`**: Provide fixes for issues found
- **With `/generate-documentation`**: Fill identified gaps
- **With `/continuous-quality`**: Monitor documentation health over time
- **With `/analyze-report`**: Compare documentation health trends

## Configuration Options

```yaml
# .doc-health.yml
validation:
  check_external_links: false
  validate_code_examples: true
  strict_parameter_matching: true

thresholds:
  health_score_minimum: 80
  critical_if_below: 60

ignore:
  - "vendor/**"
  - "node_modules/**"
  - "*.min.js"

custom_checks:
  - pattern: "TODO|FIXME"
    severity: "warning"
    message: "Unresolved TODO in documentation"
```

## Best Practices

1. **Run Regularly**: Include in CI/CD pipeline
2. **Fix Critical First**: Address security and breaking issues
3. **Incremental Improvement**: Fix a few issues each sprint
4. **Automate Fixes**: Use `/fix-documentation` for common issues
5. **Track Progress**: Monitor health score over time

This command helps maintain high-quality, accurate documentation that serves as a reliable source of truth for your project.
