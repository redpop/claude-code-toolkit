---
name: validate-all
description: Run all project validation checks (markdown, JSON, shell scripts). Use when the user asks to "validate everything", "run all checks", or before committing changes.
disable-model-invocation: true
---

# Project Validation

Run all validation checks for the AgentKit marketplace and report results.

## Current State

- Working directory: !`pwd`
- Modified files: !`git status --short`

## Execution Workflow

Run all three validation steps. Report each result clearly.

### 1. Markdown Formatting

```bash
markdownlint-cli2 "plugins/**/*.md"
```

### 2. JSON Syntax

Validate all JSON files in the project:

```bash
find . -name "*.json" -not -path "*/node_modules/*" | sort | while read -r f; do
  python3 -m json.tool "$f" > /dev/null || echo "Invalid JSON: $f"
done
```

### 3. Shell Script Linting

```bash
shellcheck plugins/ak-core/hooks/markdown-format.sh
shellcheck plugins/ak-core/hooks/json-validate.sh
shellcheck plugins/ak-core/hooks/shellcheck-validate.sh
```

## Output Format

```markdown
## Validation Results

### Markdown: PASS/FAIL
[details if failed]

### JSON: PASS/FAIL
[details if failed]

### Shell Scripts: PASS/FAIL
[details if failed]

**Summary**: X/3 checks passed
```

If all checks pass, suggest committing with `/ak-git:operations`.
If any check fails, list the specific errors and offer to fix them.
