---
description: Verify and synchronize all documentation files with actual codebase structure
argument-hint: "[--fix] [--export-json] [--export-md]"
---

# Docs Sync Command

Analyzes and synchronizes all documentation files (especially CLAUDE.md files) with the actual codebase structure, identifying outdated references, missing items, and inconsistencies.

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

```bash
/prefix:meta:docs-sync [options]
```

## Workflow

Use Task tool with subagent_type="documentation-health-specialist":
"Please perform a comprehensive documentation synchronization analysis for the current repository. Focus on:

1. **CLAUDE.md Files Verification**:
   - Check all CLAUDE.md files against actual codebase structure
   - Verify that all listed commands in CLAUDE.md files actually exist
   - Verify that all listed agents in CLAUDE.md files actually exist
   - Identify any commands or agents that exist but are not documented
   - Check for renamed, refactored or deleted items still being referenced

2. **README.md Synchronization**:
   - Verify command categories match actual directory structure
   - Check if all commands are properly listed
   - Verify agent and command counts are accurate
   - Identify outdated examples or workflows

3. **Knowledge Base Verification**:
   - Check if all knowledge-base directories are documented
   - Verify references to knowledge-base materials are valid

4. **Cross-Reference Check**:
   - Verify all internal links between documentation files
   - Check for broken references to commands, agents, or guides
   - Validate example commands and workflows

5. **Version-Specific Issues**:
   - Identify deprecated features still being referenced
   - Check changelog references for accuracy

Report your findings in a structured format with:

- List of discrepancies found
- Specific files and line numbers that need updating
- Missing documentation for new features
- Recommendations for fixes

If '--fix' option is provided in $ARGUMENTS, also provide the exact edits needed to fix each issue.

$ARGUMENTS"

After the analysis completes:

1. If `--fix` option was provided:
   - Apply the recommended fixes automatically
   - Run `./scripts/update-readme.sh` to sync README

2. If `--export-json` option was provided:
   - Export findings to timestamped JSON file

3. If `--export-md` option was provided:
   - Export findings to timestamped Markdown report

## Options

- `--fix` - Automatically apply recommended fixes
- `--export-json` - Export findings to JSON file
- `--export-md` - Export findings to Markdown report
- `--focus=<area>` - Focus on specific documentation area (claude-md, readme, knowledge-base)

## Examples

### Basic documentation check

```bash
/prefix:meta:docs-sync
```

### Check and auto-fix issues

```bash
/prefix:meta:docs-sync --fix
```

### Generate report for review

```bash
/prefix:meta:docs-sync --export-md
```

### Focus on specific area

```bash
/prefix:meta:docs-sync --focus=claude-md --fix
```

## Related Commands

- `/prefix:meta:update-docs` - Update project documentation based on code changes
- `/prefix:meta:health` - General project health check
- `/prefix:meta:analyze-toolkit` - Analyze toolkit structure
- `/prefix:scan:docs` - Analyze documentation quality

## Best Practices

1. Run this command after:
   - Adding new commands or agents
   - Renaming or refactoring existing items
   - Major version updates
   - Merging feature branches

2. Use `--export-md` first to review changes before applying `--fix`

3. Combine with other meta commands:

   ```bash
   /prefix:meta:chain "meta:docs-sync --export-md" -> "meta:update-docs --analyze" -> "meta:docs-sync --fix"
   ```

## Notes

This command ensures all documentation stays synchronized with the actual codebase structure, preventing documentation drift and maintaining accuracy for users.
