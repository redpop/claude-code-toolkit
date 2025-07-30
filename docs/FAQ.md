# Frequently Asked Questions

## Installation

### Q: Can I install multiple versions with different prefixes?
Yes! You can install the toolkit multiple times with different prefixes:
```bash
./install.sh myprefix
./install.sh team
./install.sh test
```

### Q: How do I update to the latest version?
Pull the latest changes and re-run the installation:
```bash
git pull origin main
./install.sh myprefix
```

### Q: Where are commands installed?
Commands are installed to `~/.claude/commands/PREFIX/` where PREFIX is your chosen prefix.

## Usage

### Q: How do I know which commands are available?
After installation, all available commands are listed. You can also check:
```bash
ls ~/.claude/commands/myprefix/
```

### Q: Can I modify commands after installation?
Yes, but it's better to modify them in your fork and reinstall. Direct edits will be overwritten on the next installation.

### Q: How do I chain commands together?
Use the chain command:
```bash
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}"
```

## Troubleshooting

### Q: Command not found error
Ensure you're using the correct prefix and category:
```bash
# Correct format
/myprefix:scan:deep .

# Common mistakes
/scan:deep .           # Missing prefix
/myprefix:deep .       # Missing category
/myprefix-scan-deep .  # Wrong separator
```

### Q: Analysis taking too long
For large codebases, use focused analysis:
```bash
# Instead of analyzing everything
/prefix:scan:deep .

# Focus on specific areas
/prefix:scan:deep src/ --focus=security
```

### Q: Fixes not working as expected
Always use dry-run mode first:
```bash
/prefix:fix:security . --dry-run
```

## Sub-Agents

### Q: What are sub-agents?
Sub-agents are specialized AI agents that work in parallel to analyze different aspects of your code. They're defined in the `/agents/` directory.

### Q: Can I create custom sub-agents?
Yes! Create a new `.md` file in the `/agents/` directory following the template structure, then use it in orchestration commands.

### Q: How many agents can run in parallel?
The Task tool supports multiple parallel agents. Commands like `/prefix:flow:parallel` use up to 10 agents simultaneously.

## Contributing

### Q: How do I contribute new commands?
1. Fork the repository
2. Create your command in the appropriate category
3. Test it locally
4. Submit a pull request

### Q: What's the command naming convention?
- Use short, action-oriented names
- Maximum 2 words per command
- Place in appropriate category directory

## Advanced

### Q: Can I use MCP servers?
Yes! Commands can leverage MCP servers when available. See the [MCP Integration Guide](guides/MCP-INTEGRATION.md).

### Q: How do I create pre-defined pipelines?
Use the pipelines command to see available workflows:
```bash
/prefix:meta:pipelines --list
```

### Q: Can I export reports in different formats?
Yes, most analysis commands support multiple export formats:
```bash
/prefix:scan:deep . --export-json --export-md --export-html
```

## Support

### Q: Where can I get help?
- Check the documentation in `/docs/`
- Review the [Modern Workflow Guide](guides/MODERN-WORKFLOW.md)
- Open an issue on GitHub

### Q: How do I report bugs?
Open an issue on the GitHub repository with:
- Command that failed
- Error message
- Expected behavior
- Your environment details