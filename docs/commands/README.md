# Command Documentation

Comprehensive documentation for the Claude Code Toolkit's 5-Command Architecture.

## Core Commands

The toolkit's primary workflow is built around 5 core commands that work together:

| Command | Purpose | Key Features |
|---------|---------|--------------|
| **[understand](understand.md)** | Code analysis and comprehension | Comprehensive analysis, export capabilities, intelligent routing |
| **[improve](improve.md)** | Code quality improvements | Intelligent routing, severity filtering, learning persistence |
| **[create](create.md)** | Content and code generation | Template-driven, multiple formats, pattern-based |
| **[secure](secure.md)** | Security analysis | OWASP compliance, threat intelligence, standards support |
| **[ship](ship.md)** | Deployment readiness | Quality gates, deployment validation, monitoring |

## Specialized Commands

Additional command categories for specific domains:

| Category | Purpose | Examples |
|----------|---------|----------|
| **[Git Commands](git/README.md)** | Version control operations | Smart commits, conflict resolution, pattern learning |
| **[Meta Commands](meta/README.md)** | Project management | Changelog generation, AI handoffs |
| **[TYPO3 Commands](typo3/README.md)** | TYPO3 development | Content blocks, extensions, sitepackages |

## Workflow Integration

These commands are designed to work together in development workflows:

### Quick Development Cycle

```bash
/prefix:understand . --quick           # Analyze
/prefix:improve . --apply-insights     # Fix
/prefix:ship . --readiness-check       # Validate
```

### Comprehensive Quality Workflow

```bash
/prefix:understand . --comprehensive --export-json
/prefix:improve . --from-analysis --severity=high
/prefix:secure . --audit --standard=OWASP
/prefix:ship . --quality-gates
/prefix:git:operations commit --smart --pattern-learn
```

## Command Patterns

### Common Options

- `--help` - Available on all commands for detailed help
- `--dry-run` - Preview mode (where applicable)
- `--export-json/md` - Export analysis results
- `--from-analysis` - Use previous analysis results
- `--apply-insights` - Apply discovered insights

### Target Specification

- `.` - Current directory (default for most commands)
- `src/` - Specific directory
- `components/Button.tsx` - Specific file

## Getting Started

1. **Start with understand**: Analyze your codebase

   ```bash
   /prefix:understand . --comprehensive
   ```

2. **Apply improvements**: Fix discovered issues

   ```bash
   /prefix:improve . --apply-insights
   ```

3. **Validate security**: Ensure security compliance

   ```bash
   /prefix:secure . --audit
   ```

4. **Ship confidently**: Validate deployment readiness

   ```bash
   /prefix:ship . --readiness-check
   ```

## Documentation Structure

Each command documentation includes:

- **Syntax**: Complete command syntax
- **Arguments**: Positional arguments with defaults
- **Options**: All available flags and options
- **Examples**: Practical usage examples
- **Workflows**: Integration with other commands
- **See Also**: Related commands and cross-references

## See Also

- [Installation Guide](../INSTALLATION-GUIDE.md)
- [Usage Guide](../USAGE.md)
- [Command Development](../../commands/CLAUDE.md)
