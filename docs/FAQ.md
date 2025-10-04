# Frequently Asked Questions

## Installation

### Q: How do I install the toolkit?

See the [Installation Guide](INSTALLATION-GUIDE.md) for complete setup instructions.

### Q: Can I use multiple prefixes?

Yes! Install with different prefixes:

```bash
./install.sh global
./install.sh team
```

## Usage

### Q: How do I know which commands are available?

Check the [Usage Guide](USAGE.md) for complete command reference, or:

```bash
ls ~/.claude/commands/global/
```

The 6 core commands are: `understand`, `improve`, `create`, `secure`, `ship`, `git`

### Q: Can I modify commands after installation?

Yes, but it's better to modify them in your fork and reinstall. Direct edits will be overwritten on the next installation.

### Q: How do I use the 6-command architecture?

The recommended workflow is:

```bash
# Analyze your codebase
/global:understand . --comprehensive

# Apply improvements
/global:improve . --apply-insights

# Create or update documentation/features
/global:create . --update-all

# Security audit
/global:secure . --audit

# Deployment readiness
/global:ship . --readiness-check

# Git operations
/global:git --smart-commit
```

### Q: How do I use the research and planning agents?

The toolkit includes specialized agents for research and planning:

- **blueprint-architect** - Create implementation blueprints
- **requirements-analyst** - Validate requirements
- **codebase-research-specialist** - Discover patterns
- **external-research-specialist** - Research best practices

These agents work through the core commands automatically.

## Troubleshooting

### Q: Command not found error

Ensure you're using the correct format with the 6-command architecture:

```bash
# Correct format
/global:understand .
/global:improve . --apply-insights
/global:create docs

# Common mistakes
/understand .              # Missing prefix
/global:scan .            # Non-existent command
/global-understand .      # Wrong separator
```

### Q: Analysis taking too long

For large codebases, use focused analysis:

```bash
# Focus on specific areas
/global:understand src/ --focus=security

# Or use quick mode
/global:understand . --quick --export-json
```

### Q: Improvements not working as expected

Always review recommendations first:

```bash
# Review before applying
/global:improve . --preview

# Then apply specific improvements
/global:improve . --apply-insights --focus=security
```

## Agents

### Q: What are agents?

Agents are specialized AI assistants that work with commands to analyze different aspects of your code. They're defined in the `/agents/` directory.

### Q: Can I create custom agents?

Yes! Create a new `.md` file in the `/agents/` directory following the template structure. See the [Development Guide](DEVELOPMENT.md) for details.

### Q: Which agents are available?

The toolkit includes 22+ specialized agents including:

- Security specialists
- Code quality analysts
- Documentation specialists
- Architecture reviewers
- And more domain-specific experts

## Contributing

### Q: How do I contribute new commands?

1. Fork the repository
2. Create your command following the 6-command architecture
3. Test it locally with `./install.sh test`
4. Submit a pull request

See the [Development Guide](DEVELOPMENT.md) for detailed guidelines.

### Q: What's the command naming convention?

- Core commands: `understand`, `improve`, `create`, `secure`, `ship`, `git`
- Extensions: `meta/*` and `typo3/*` for specialized functionality
- Keep names short and action-oriented

## Advanced Features

### Q: Can I use MCP servers?

Yes! MCP servers provide enhanced functionality. See the [MCP Integration Guide](guides/MCP-INTEGRATION.md) for setup instructions.

### Q: What workflows are available?

The toolkit supports several workflows:

1. **6-Command Architecture** (Recommended):

   ```bash
   /global:understand . --comprehensive
   /global:improve . --apply-insights
   /global:ship . --readiness-check
   ```

2. **Quick Development**:

   ```bash
   /global:understand . --quick
   /global:secure . --audit
   ```

### Q: Can I export reports?

Yes, use export flags with any command:

```bash
/global:understand . --export-json --export-md
/global:secure . --audit --export-json
```

### Q: How do I use specialized commands?

The toolkit includes specialized commands for specific domains:

```bash
# Meta commands for repository management
/global:meta:changelog --generate
/global:meta:handoff --create-documentation

# TYPO3 development commands
/global:typo3:sitepackage --create
/global:typo3:content-blocks --scaffold
```

## Support

### Q: Where can I get help?

- Check this [FAQ](FAQ.md) for common issues
- Review the [Usage Guide](USAGE.md) for comprehensive documentation
- See [Installation Guide](INSTALLATION-GUIDE.md) for setup help
- Use `--help` with any command for specific guidance

### Q: How do I report bugs?

Open an issue on the GitHub repository with:

- Command that failed
- Full error message
- Expected behavior
- Your environment details (OS, Claude Code version)
- Steps to reproduce

### Q: How do I stay updated?

The toolkit is actively developed. To update:

```bash
git pull origin main
./install.sh your-prefix  # Reinstall with your prefix
```

## Performance

### Q: How can I speed up large codebase analysis?

1. Use focused analysis:

   ```bash
   /global:understand src/ --focus=security
   ```

2. Exclude unnecessary files:

   ```bash
   /global:understand . --exclude="node_modules,vendor"
   ```

3. Use quick mode for initial assessment:

   ```bash
   /global:understand . --quick
   ```

### Q: Can I run commands in parallel?

Yes, agents work in parallel automatically. You can also run multiple commands simultaneously in different terminals.
