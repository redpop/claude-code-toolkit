---
description: Intelligently updates project documentation based on code changes and implementation status
argument-hint: [--scope=<type>] [--analyze] [--commit]
---

# Claude Command: Update Documentation

This command analyzes your project and intelligently updates documentation to reflect the current state of your codebase, ensuring documentation stays synchronized with implementation.

## Usage

```
/update-docs                              # Update all documentation
/update-docs --analyze                    # Preview what would be updated
/update-docs --scope=readme               # Update only README.md
/update-docs --scope=changelog --commit   # Update changelog and commit
```

### Arguments

- `--scope`: Limit updates to specific documentation types
  - `readme`: Only update README.md
  - `changelog`: Delegates to `/project:changelog` command if available
  - `all`: Update all documentation (default)
- `--analyze`: Preview mode - shows what would be updated without making changes
- `--commit`: Automatically commit changes using conventional commit format

## What This Command Does

1. **Discovers Documentation**:

   - Scans project for documentation files (README.md, docs/, etc.)
   - Identifies documentation patterns and structure
   - Detects documentation generation tools (JSDoc, Sphinx, etc.)

2. **Analyzes Current State**:

   - Reviews recent code changes and commits
   - Examines function signatures, classes, and modules
   - Checks implementation status against documentation
   - Identifies outdated or missing documentation

3. **Updates Documentation**:

   - Synchronizes docs with actual implementation
   - Refreshes examples to match current usage
   - Maintains existing formatting and style
   - Preserves manual content while updating automated sections
   - For CHANGELOG.md: Delegates to `/project:changelog` if available

4. **Maintains Quality**:
   - Validates markdown syntax
   - Checks for broken internal links
   - Ensures consistent terminology
   - Updates version references

## Documentation Types Handled

### README.md

- Installation instructions based on package files
- Usage examples from actual code
- Feature list from implemented functionality
- Configuration options from code analysis
- Badge updates (version, build status, etc.)

### Implementation Docs

- Progress tracking against specifications
- Task completion status
- Architecture decisions
- Component relationships
- Performance considerations

### Other Documentation

- CONTRIBUTING.md - development setup
- SECURITY.md - security policies
- Wiki pages - detailed guides
- Code comments - inline documentation

### Changelog (Special Handling)

CHANGELOG.md always uses specialized handling:

- Automatically checks if `/project:changelog` command is available
- If available: Delegates to the specialized changelog command
- Applies when `--scope=changelog` OR `--scope=all` (default)
- Passes through additional arguments (--analyze, --commit, etc.)
- If `/project:changelog` not available: Updates as regular documentation

## Workflow Steps

1. **Discovery Phase**:

   ```
   - Locate all documentation files
   - Identify documentation tools/generators
   - Detect existing documentation patterns
   - Find related configuration files
   ```

2. **Analysis Phase**:

   ```
   - Parse source code for structure
   - Extract comments and docstrings
   - Review recent git changes
   - Compare docs with implementation
   ```

3. **Update Phase**:

   ```
   - Update outdated information
   - Add missing documentation
   - Sync examples with current code
   - Maintain consistent formatting
   ```

4. **Validation Phase**:

   ```
   - Check markdown syntax
   - Verify internal links
   - Ensure examples compile/run
   - Validate against style guide
   ```

5. **Commit Phase** (if --commit):
   ```
   - Stage documentation changes
   - Create descriptive commit message
   - Use format: "📝 docs: update [scope] documentation"
   ```

## Smart Features

### Auto-Detection

The command automatically detects:

- Programming language and frameworks
- Documentation standards (JSDoc, Sphinx, etc.)
- Project structure and conventions
- Existing documentation style

### Incremental Updates

- Only modifies sections that need updates
- Preserves manually written content
- Maintains custom formatting
- Respects documentation markers

### Context Awareness

- Understands different project types
- Adapts to various documentation styles
- Recognizes common patterns
- Preserves project-specific conventions

## Examples

### Example 1: Full Documentation Update

```
/update-docs

Analyzing project documentation...
Found: README.md, docs/architecture.md, CHANGELOG.md
Detected changes in 5 source files

Updated:
- README.md: Updated installation steps, added new CLI options
- docs/architecture.md: Updated component diagram
- CHANGELOG.md: Delegated to /project:changelog command

All documentation successfully updated.
```

### Example 2: Preview Mode

```
/update-docs --analyze

Documentation Analysis:
- README.md: 2 sections outdated (Installation, Usage)
- docs/guides.md: Examples need updating
- CHANGELOG.md: Up to date

No changes made (preview mode)
```

### Example 3: Scoped Update with Commit

```
/update-docs --scope=readme --commit

Updating README.md...
- Updated installation instructions
- Added new configuration options
- Refreshed usage examples

Committed: 📝 docs: update readme documentation
```

### Example 4: Changelog Delegation

```
/update-docs --scope=changelog --commit

Detected /project:changelog command available.
Delegating to specialized changelog command...

[Executes: /project:changelog --commit]
```

## Best Practices

1. **Regular Updates**: Run after significant code changes
2. **Preview First**: Use `--analyze` to review changes
3. **Scoped Updates**: Use `--scope` for targeted updates
4. **Review Changes**: Always review auto-generated updates
5. **Maintain Markers**: Use documentation markers for auto-generated sections

## Documentation Markers

The command respects these markers in your documentation:

```markdown
<!-- AUTO-GENERATED-START -->

Content here will be updated automatically

<!-- AUTO-GENERATED-END -->

<!-- MANUAL-CONTENT -->

Content here will never be modified

<!-- END-MANUAL-CONTENT -->
```

## Integration with Other Commands

### Changelog Integration

For CHANGELOG.md updates (both `--scope=all` and `--scope=changelog`):

- Automatically detects if `/project:changelog` command exists
- Delegates to the specialized command with all arguments
- Example: `/update-docs --commit` → includes `/project:changelog --commit`
- Example: `/update-docs --scope=changelog --analyze` → `/project:changelog --analyze`
- Ensures changelog updates use the proper versioning logic
- If `/project:changelog` not found, treats as regular documentation

### Other Integrations

- Can use `/git:commit` workflow when committing
- Complements code generation commands
- Coordinates with testing commands for examples

## Error Handling

The command handles:

- Missing documentation files (offers to create)
- Malformed markdown (attempts to fix)
- Conflicting information (prompts for clarification)
- Large files (processes incrementally)
- Binary files (skips appropriately)

## Configuration Support

Respects project configuration files:

- `.docsrc` or `docs.config.json`
- `package.json` documentation scripts
- `.gitignore` for documentation paths
- EditorConfig for formatting rules

## Language-Specific Features

### JavaScript/TypeScript

- Parses JSDoc comments
- Extracts TypeScript types
- Updates from documentation patterns
- Analyzes module structure

### Python

- Processes docstrings
- Extracts type hints
- Updates from **all**
- Generates from module structure

### Other Languages

- Adapts to language conventions
- Uses appropriate doc tools
- Maintains idiomatic style
- Respects community standards

## Important Notes

- Always preserves manual content outside marked sections
- Maintains existing documentation structure
- Uses project's preferred markdown style
- Creates backups before major updates
- Validates all changes before writing
- Respects version control ignored files
- Works with monorepo structures
- Handles multiple documentation formats
- CHANGELOG.md always uses `/project:changelog` when available (for both `--all` and `--changelog` scopes)

This command ensures your documentation remains accurate, up-to-date, and synchronized with your codebase, reducing documentation debt and improving project maintainability.
