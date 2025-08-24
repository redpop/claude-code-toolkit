---
description: Automatically detect and fix linting errors across multiple languages with intelligent agent orchestration
argument-hint: "[path or custom instructions]"
---

# Fix Lint - Universal Linting Error Fixer with Agent Orchestration

Automatically detects your project's linters and fixes all linting errors across JavaScript, TypeScript, Python, Go, Rust, Ruby, PHP, and more. Uses specialized agents for complex fixes and can orchestrate multiple agents in parallel for maximum efficiency.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Automatically detect and fix linting errors across multiple languages with intelligent agent orchestration
- **Usage**: [path or custom instructions]
- **Options**: See natural language options section below
- **Examples**: See usage examples section below

Then exit without executing the main command.

---

## Usage

```bash
# Fix all linting errors in current directory
/prefix:fix:lint

# Fix specific file or directory
/prefix:fix:lint src/
/prefix:fix:lint app.js

# With additional instructions
/prefix:fix:lint "focus on TypeScript files and be very strict"
/prefix:fix:lint src/ "only fix security issues, skip formatting"
/prefix:fix:lint "use ESLint but not Prettier for JavaScript files"

# Complex instructions
/prefix:fix:lint "fix all Python files but focus especially on type hints and async/await patterns"
/prefix:fix:lint "only JavaScript, no tests, focus on performance issues"
/prefix:fix:lint "check only, don't fix anything"
/prefix:fix:lint "use strict rules for all linters"
/prefix:fix:lint "use custom config from .eslintrc.custom.json"
```

## What This Command Does

I'll process your input: $ARGUMENTS

### Understanding Your Request

I analyze your arguments for:

- **Specific paths**: Files or directories to focus on
- **Language hints**: "focus on TypeScript", "only Python", etc.
- **Special instructions**: "be strict", "ignore tests", "focus on security"
- **Tool preferences**: "use only ESLint", "skip Prettier"
- **Custom rules**: "enforce semicolons", "max line length 100"
- **Agent preferences**: "use security-specialist", "engage frontend expert"
- **Additional context**: Any other instructions you provide

Examples of what you can tell me:

- "Fix only TypeScript files and be very strict"
- "Focus on security issues in the Python code"
- "Skip formatting, only fix actual errors"
- "Use ESLint but not Prettier"
- "Fix everything but ignore test files"
- "Ensure all async functions have proper error handling"
- "Use security-specialist for vulnerabilities"
- "Engage frontend-specialist for React issues"

### Phase 1: Auto-Detection

I'll automatically detect your project's linters by checking for:

**JavaScript/TypeScript:**

- ESLint (.eslintrc*, eslint.config.*)
- Prettier (.prettierrc*, prettier.config.*)
- Biome (biome.json)
- Standard JS (standard in package.json)
- XO (.xo-config*)

**Python:**

- Black (pyproject.toml, .black)
- Ruff (ruff.toml, pyproject.toml)
- Flake8 (.flake8, setup.cfg)
- Pylint (.pylintrc)
- autopep8 (.pep8, setup.cfg)
- isort (.isort.cfg)

**Go:**

- golangci-lint (.golangci.yml)
- gofmt (standard)
- goimports

**Rust:**

- rustfmt (rustfmt.toml)
- clippy (clippy.toml)

**Ruby:**

- RuboCop (.rubocop.yml)
- StandardRB (.standard.yml)

**PHP:**

- PHP CS Fixer (.php-cs-fixer.php)
- PHPCS (phpcs.xml)
- Psalm (psalm.xml)

**CSS/SCSS:**

- Stylelint (.stylelintrc*)
- Prettier (for CSS/SCSS)

**Markdown:**

- markdownlint (.markdownlint*)
- Prettier (for Markdown)

**YAML/JSON:**

- yamllint (.yamllint)
- Prettier (for YAML/JSON)

**Shell:**

- shellcheck (.shellcheckrc)
- shfmt (.editorconfig)

### Phase 2: Priority Resolution

When multiple linters are detected for the same language:

1. **Check package.json scripts** (for JS/TS projects)
   - Look for `lint`, `format`, `fix` scripts
   - Use project's preferred toolchain

2. **Apply smart defaults**:
   - ESLint + Prettier = Run both (ESLint first, then Prettier)
   - Ruff > Black + Flake8 (if Ruff exists, prefer it)
   - Biome > ESLint + Prettier (if Biome exists, use it alone)

3. **Check for lint-staged** or pre-commit hooks
   - Respect existing workflow configuration

### Phase 3: Intelligent Fixing

**Smart execution order:**

1. Type/syntax errors first (ESLint, TSC, mypy)
2. Code quality issues (ESLint rules, Pylint)
3. Formatting last (Prettier, Black, rustfmt)

**Language-specific intelligence:**

**JavaScript/TypeScript:**

```bash
# Check for TypeScript first
if [ -f "tsconfig.json" ]; then
    npx tsc --noEmit || echo "Type errors found"
fi

# ESLint with auto-fix
if [ -f ".eslintrc.json" ] || [ -f "eslint.config.js" ]; then
    npx eslint . --fix --ext .js,.jsx,.ts,.tsx
fi

# Prettier as final step
if [ -f ".prettierrc" ]; then
    npx prettier --write "**/*.{js,jsx,ts,tsx,json,css,md}"
fi
```

**Python:**

```bash
# Ruff can replace multiple tools
if command -v ruff &> /dev/null; then
    ruff check --fix .
    ruff format .
else
    # Fallback to traditional tools
    black . 2>/dev/null || true
    isort . 2>/dev/null || true
    flake8 . 2>/dev/null || true
fi
```

**Go:**

```bash
# Go has standard tooling
gofmt -w .
goimports -w .
golangci-lint run --fix
```

### Phase 4: Agent Orchestration

For complex issues that can't be auto-fixed, I'll engage specialized agents:

**Available Specialist Agents:**

1. **frontend-specialist** - React, Vue, Angular specific issues
2. **refactoring-expert** - Complex refactoring for code quality
3. **performance-optimizer** - Performance-related linting issues
4. **security-specialist** - Security vulnerabilities and fixes
5. **test-engineer** - Test-related linting and coverage
6. **typo3-architect** - TYPO3-specific issues
7. **code-architect** - Architectural improvements

**Intelligent Parallel Execution:**

I automatically determine when parallel execution makes sense:

```text
Detected Issues Analysis:
├─→ Security warnings (5) → security-specialist
├─→ Performance issues (3) → performance-optimizer  
├─→ Test coverage gaps (8) → test-engineer
└─→ Decision: Run in parallel (independent issue types)
```

**When I use parallel agents:**

- Multiple independent issue categories detected
- Large codebase with 100+ issues
- Different language files that don't interact
- Separate module fixes that won't conflict

**When I run sequentially:**

- Interconnected issues requiring order
- Small number of issues (<10)
- Risk of conflicting fixes
- Single file with multiple issue types

**Agent Invocation Examples:**

For complex TypeScript type issues:

```markdown
Use Task tool with subagent_type="frontend-specialist":
"Fix complex TypeScript type errors in [files]. The linter reports:
- Unsafe any usage in API handlers
- Missing generic constraints
- Incorrect type assertions
Provide fixes that maintain type safety while being practical."
```

For security-related linting:

```markdown
Use Task tool with subagent_type="security-specialist":
"Analyze and fix security linting issues:
[linting report]
Focus on OWASP compliance and secure coding practices."
```

### Phase 5: Validation

After all fixes (automated and agent-based):

1. Re-run linters in check mode
2. Verify all agent fixes compile/run correctly
3. Report remaining issues that need manual intervention
4. Show statistics (files changed, issues fixed, agents used)

## Features

### 🎯 Multi-Language Support

- Handles polyglot projects seamlessly
- Respects language-specific conventions
- Parallel execution where safe

### 🔧 Configuration Respect

- Uses your existing configs
- Never overwrites settings
- Respects .gitignore and lint ignore files

### 📊 Smart Reporting

```text
✅ Fixed 127 issues automatically
⚠️  3 issues require manual review:
  - src/api.ts:45 - Unsafe any type (needs type annotation)
  - lib/helper.py:23 - Complexity too high (consider refactoring)
  - main.go:67 - Deprecated API usage

📁 Files modified: 23
⏱️  Time taken: 4.2s
```

### 🚀 Performance Optimized

- Automatically decides when to run parallel (no manual flag needed)
- Intelligent agent orchestration based on issue analysis
- Caches detection results
- Only processes changed files when possible

## Examples

### Example 1: JavaScript/TypeScript Project

```bash
/prefix:fix:lint
```

Output:

```text
🔍 Detected linters:
  ✓ ESLint (config: .eslintrc.json)
  ✓ Prettier (config: .prettierrc)
  ✓ TypeScript (config: tsconfig.json)

🔧 Running fixes...
  ✓ TypeScript: No type errors
  ✓ ESLint: Fixed 45 issues
  ✓ Prettier: Formatted 12 files

✅ All linting issues fixed!
```

### Example 2: Python Project

```bash
/prefix:fix:lint src/ "use strict mode"
```

Output:

```text
🔍 Detected linters:
  ✓ Ruff (config: pyproject.toml)
  ✓ mypy (config: mypy.ini)

🔧 Running fixes (strict mode)...
  ✓ Ruff: Fixed 23 issues
  ⚠️ mypy: 2 type errors need manual fixes

📋 Manual fixes needed:
  src/database.py:45: Incompatible return type
  src/utils.py:78: Missing type annotation
```

### Example 3: Polyglot Project

```bash
/prefix:fix:lint
```

Output:

```text
🔍 Detected languages and linters:
  JavaScript: ESLint, Prettier
  Python: Black, Flake8
  Go: gofmt, golangci-lint
  Markdown: markdownlint

🔧 Running fixes (parallel execution)...
  [JS] Fixed 34 ESLint issues
  [PY] Formatted 8 files with Black
  [GO] Fixed 5 golangci-lint issues
  [MD] Fixed 12 markdown issues

✅ Fixed 59 total issues across 4 languages
```

### Example 4: With Custom Instructions

```bash
/prefix:fix:lint "focus on security issues and type safety, be very strict"
```

Output:

```text
📋 Custom instructions detected:
  - Focusing on security issues
  - Emphasizing type safety
  - Using strict mode

🔍 Adjusting linter configurations:
  ✓ ESLint: Enabled security plugin, strict TypeScript rules
  ✓ Python: Running mypy in strict mode, bandit for security
  ✓ Go: golangci-lint with security linters enabled

🔧 Running targeted fixes...
  ⚠️ Security: Fixed SQL injection vulnerability in db.js
  ⚠️ Types: Added 23 missing type annotations
  ✓ Fixed unsafe any usage in 5 TypeScript files

✅ Security and type safety improved!
```

### Example 5: Language-Specific Instructions

```bash
/prefix:fix:lint "only Python files, focus on async/await and type hints"
```

Output:

```text
📋 Instructions understood:
  - Only Python files
  - Focus on async/await patterns
  - Emphasize type hints

🔍 Python-specific linters:
  ✓ mypy for type checking
  ✓ Ruff with async rules
  ✓ Black for formatting

🔧 Fixing Python issues...
  ✓ Added type hints to 15 functions
  ✓ Fixed 3 async functions missing await
  ✓ Corrected 2 incorrect async context managers

✅ Python code quality improved!
```

## Natural Language Options

Instead of flags, just tell me what you need in plain language:

- **"check only"** or **"don't fix"**: Run linters without fixing
- **"be strict"** or **"strict mode"**: Use stricter rule sets
- **"use config X"**: Override with custom config file
- **"only JavaScript"** or **"Python only"**: Target specific languages
- **"ignore tests"**: Skip test files
- **"focus on security"**: Prioritize security issues
- **"skip formatting"**: Don't run formatters like Prettier/Black
- **"use agent X"**: Engage specific specialist agent

## Error Handling

**Common issues and solutions:**

1. **Missing linter executable**
   - Auto-installs via npm/pip/go get when possible
   - Provides installation command if manual install needed

2. **Conflicting configurations**
   - Warns about conflicts
   - Suggests resolution
   - Uses safe defaults

3. **Syntax errors blocking fixes**
   - Reports syntax errors first
   - Fixes what's possible
   - Provides clear next steps

## Best Practices

1. **Commit before running** - Large fixes can modify many files
2. **Review changes** - Use "check only" mode first for large codebases
3. **Configure ignore files** - Add .eslintignore, .prettierignore, etc.
4. **CI/CD Integration** - Use "check only, don't fix" in CI to verify

## Integration with Other Commands

Works great with:

- `/prefix:scan:quality` - Run after fixing to verify improvements
- `/prefix:git:commit` - Commit the fixed files
- `/prefix:flow:review` - Get code review after fixes

## Notes

- Respects existing tool configurations
- Never modifies linter configs without permission
- Creates detailed log of all changes
- Supports mono-repos and workspaces
- Handles both global and local tool installations
