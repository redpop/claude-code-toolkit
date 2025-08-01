# Troubleshooting Guide

This guide helps you resolve common issues with the Claude Code Toolkit.

## 🚨 Common Issues

### Installation Problems

#### "Command not found" after installation
```bash
# Verify installation
ls ~/.claude/commands/

# If missing, reinstall
./install.sh global --force

# Check your prefix
ls ~/.claude/commands/global/
```

#### "Permission denied" during installation
```bash
# Make install script executable
chmod +x install.sh

# Run installation
./install.sh global
```

#### Installation fails silently
```bash
# Enable debug mode
export CLAUDE_DEBUG=true
./install.sh global --verbose

# Check for errors
```

### Command Execution Issues

#### "Token limit exceeded" error
**Problem**: Analysis requires more tokens than allocated

**Solutions**:
```bash
# Option 1: Use conservative mode
/global:scan:deep . --performance-mode=conservative

# Option 2: Focus on specific areas
/global:scan:deep . --focus=security

# Option 3: Scan smaller directories
/global:scan:deep src/components/
```

#### Commands timing out
**Problem**: Execution exceeds timeout limit

**Solutions**:
```bash
# Increase timeout (in project .claude-commands.json)
{
  "defaults": {
    "timeout": 60000
  }
}

# Or use simpler commands
/global:scan:quick . # Instead of scan:deep
```

#### "No results returned" from analysis
**Problem**: Scanners found no issues or failed silently

**Check**:
```bash
# Verify target directory
ls -la .

# Try verbose mode
/global:scan:deep . --verbose

# Check specific scanners
/global:scan:security . --verbose
```

### Performance Issues

#### Analysis taking too long
```bash
# Use quick mode
/global:scan:deep . --quick

# Or quick scan
/global:scan:quick .

# Limit scope
/global:scan:deep src/ --exclude=node_modules
```

#### High memory usage
```bash
# Use conservative mode
export CLAUDE_PERFORMANCE_MODE=conservative

# Disable caching
/global:scan:deep . --no-cache

# Process in chunks
/global:scan:deep src/module1/
/global:scan:deep src/module2/
```

### Export and Report Issues

#### Cannot find exported files
**Default locations**:
```bash
# Check current directory
ls -la *.json *.md

# Check reports directory
ls -la ~/reports/

# Use specific output
/global:scan:deep . --output=./my-report.json
```

#### JSON parsing errors
```bash
# Validate JSON
cat report.json | jq .

# If corrupted, regenerate
/global:scan:deep . --export-json

# Use different format
/global:scan:deep . --export-md
```

### Fix Command Issues

#### "No fixes applied" message
**Possible causes**:
- No issues meet threshold
- Fixes require manual intervention
- Dry-run mode active

**Solutions**:
```bash
# Lower threshold
/global:fix:quick-wins report.json --threshold=5

# Check dry-run mode
/global:fix:security report.json --no-dry-run

# Try specific fixes
/global:fix:security report.json --severity=high
```

#### Fixes breaking code
```bash
# Always use preview mode first
/global:fix:quick-wins report.json --preview

# Create backup
git stash save "Before fixes"

# Use conservative mode
/global:fix:quick-wins report.json --safety=conservative
```

### Multi-Agent Issues

#### Some agents failing
```bash
# Check which agents failed
/global:scan:deep . --verbose

# Reduce agent count
/global:scan:deep . --max-agents=5

# Try sequential mode
export CLAUDE_PARALLEL_EXECUTION=false
```

#### Inconsistent results between runs
**Causes**:
- Non-deterministic analysis
- File changes between runs
- Cache issues

**Solutions**:
```bash
# Clear cache
rm -rf ~/.claude/cache/

# Use deterministic mode
/global:scan:deep . --deterministic

# Create baseline for comparison
/global:scan:deep . --save-baseline
```

## 🔧 Configuration Issues

### Settings not taking effect
```bash
# Check configuration hierarchy
1. Check project config: ./.claude-commands.json
2. Check global config: ~/claude-code-toolkit/.claude-commands.json
3. Check environment: env | grep CLAUDE

# Validate configuration
/global:meta:validate-config
```

### Performance mode not changing
```bash
# Set via environment
export CLAUDE_PERFORMANCE_MODE=aggressive

# Or in config file
{
  "performanceMode": "aggressive"
}

# Verify current mode
/global:meta:config --show
```

## 🐛 Debugging Techniques

### Enable Debug Mode
```bash
# Full debug output
export CLAUDE_DEBUG=true
export CLAUDE_LOG_LEVEL=debug

# Run command
/global:scan:deep . --verbose
```

### Check Logs
```bash
# View recent logs
tail -f ~/.claude/logs/claude-code-toolkit.log

# Search for errors
grep ERROR ~/.claude/logs/*.log
```

### Validate Environment
```bash
# Check Claude Code version
claude --version

# Verify toolkit installation
/global:meta:version

# Test basic command
/global:flow:smart "test"
```

## 📊 Error Messages

### "Insufficient permissions"
```bash
# Check file permissions
ls -la ~/.claude/

# Fix permissions
chmod -R 755 ~/.claude/commands/
```

### "Invalid command syntax"
```bash
# Correct format
/prefix:category:command arguments --options

# Examples
/global:scan:deep .
/global:fix:security report.json --severity=high
```

### "Agent initialization failed"
```bash
# Check agent files
ls ~/.claude/agents/

# Reinstall agents
./install.sh global --force --agents-only
```

## 🔄 Recovery Procedures

### Rollback Changes
```bash
# If fixes caused issues
git checkout .
git clean -fd

# Or use stash
git stash pop
```

### Reset Configuration
```bash
# Backup current config
cp .claude-commands.json .claude-commands.json.bak

# Reset to defaults
rm .claude-commands.json

# Or use default config
/global:meta:reset-config
```

### Clean Installation
```bash
# Remove existing installation
rm -rf ~/.claude/commands/global/
rm -rf ~/.claude/agents/

# Fresh install
./install.sh global
```

## 💡 Prevention Tips

### Before Running Commands
1. **Create backups**: `git stash` or commit changes
2. **Use preview mode**: `--preview` or `--dry-run`
3. **Start small**: Test on single files/directories
4. **Check configuration**: Verify settings are correct

### Best Practices
```bash
# Always export results
/global:scan:deep . --export-all

# Use version control
git commit -m "Before toolkit analysis"

# Test in safe environment
/global:scan:deep ./test-directory/
```

## 🆘 Getting Help

### Self-Help Commands
```bash
# Command help
/global:flow:smart "help with [command]"

# List all commands
/global:meta:list-commands

# Check documentation
/global:meta:docs [topic]
```

### Community Resources
- GitHub Issues: Report bugs and request features
- Discord/Slack: Real-time help from community
- Stack Overflow: Tagged questions
- Documentation: Always check latest docs

### Diagnostic Information
When reporting issues, include:
```bash
# Toolkit version
/global:meta:version

# Configuration
/global:meta:config --export

# Error logs
~/.claude/logs/latest-error.log

# System info
uname -a
claude --version
```

## 🔍 Advanced Troubleshooting

### Network Issues
```bash
# If behind proxy
export HTTP_PROXY=http://proxy:port
export HTTPS_PROXY=http://proxy:port

# Offline mode
/global:scan:deep . --offline
```

### Memory Profiling
```bash
# Enable memory tracking
export CLAUDE_TRACK_MEMORY=true

# Run with profiling
/global:scan:deep . --profile-memory

# Check memory usage
cat ~/.claude/logs/memory-profile.log
```

### Performance Profiling
```bash
# Enable performance metrics
/global:scan:deep . --performance-metrics

# View timing breakdown
cat ~/.claude/logs/performance.log
```

---

**Still having issues?** Try:
```bash
/global:flow:smart "I'm having this specific problem: [describe issue]"
```