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

Check the [Command Reference](user-guide/command-reference.md) or:

```bash
ls ~/.claude/commands/global/
```

### Q: Can I modify commands after installation?

Yes, but it's better to modify them in your fork and reinstall. Direct edits will be overwritten on the next installation.

### Q: How do I chain commands together?

Use the chain command:

```bash
/global:meta:chain "scan:deep ." -> "fix:quick-wins {output}"
```

## Troubleshooting

### Q: Command not found error

Ensure you're using the correct format:

```bash
# Correct format
/global:scan:deep .

# Common mistakes
/scan:deep .           # Missing prefix
/global:deep .         # Missing category
/global-scan-deep .    # Wrong separator
```

### Q: Analysis taking too long

For large codebases, use focused analysis:

```bash
# Focus on specific areas
/global:scan:deep src/ --focus=security

# Or use quick scan
/global:scan:quick . --export-json
```

### Q: Fixes not working as expected

Always use dry-run mode first:

```bash
/global:fix:quick-wins report.json --preview
```

## Sub-Agents

### Q: What are sub-agents?

Sub-agents are specialized AI agents that work in parallel to analyze different aspects of your code. They're defined in the `/agents/` directory.

### Q: Can I create custom sub-agents?

Yes! Create a new `.md` file in the `/agents/` directory following the template structure, then use it in orchestration commands.

### Q: How many agents can run in parallel?

Commands like `/global:scan:quick` use up to 10 agents simultaneously.

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

Yes! See the [MCP Integration Guide](guides/MCP-INTEGRATION.md) for setup.

### Q: What workflows are available?

See the [Workflow Guide](user-guide/workflow-guide.md) or try:

```bash
/global:flow:smart "help me get started"
```

### Q: Can I export reports?

Yes, use export flags:

```bash
/global:scan:deep . --export-json --export-md
```

## Support

### Q: Where can I get help?

- Try: `/global:flow:smart "help with [your question]"`
- Check the [Quick Start Guide](guides/QUICK-START.md)
- Review [Troubleshooting](user-guide/troubleshooting.md)

### Q: How do I report bugs?

Open an issue on the GitHub repository with:

- Command that failed
- Error message
- Expected behavior
- Your environment details
