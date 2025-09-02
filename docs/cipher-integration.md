# Cipher Memory Integration Guide

Complete guide for integrating Cipher memory layer with Claude Code projects using the Claude Code Toolkit.

## 🎯 What This Provides

**Transform any project into a Cipher-enabled development environment** where Claude Code intelligently uses persistent memory for context-aware coding assistance.

### Key Benefits

- ✅ **Persistent memory** across coding sessions
- ✅ **Automatic context retrieval** from previous work
- ✅ **Intelligent pattern recognition** and solution reuse
- ✅ **Project-specific knowledge** accumulation over time
- ✅ **Debugging solution** storage and retrieval
- ✅ **Architecture decision** tracking and reasoning

## 📋 Prerequisites

### Required Setup

1. **Cipher MCP Server** must be connected to Claude Code:

   ```bash
   claude mcp list | grep cipher
   # Should show: cipher: ✓ Connected
   ```

2. **Claude Code Toolkit** installed:

   ```bash
   # Install this toolkit globally
   git clone <toolkit-repo>
   cd claude-code-toolkit
   ./install.sh global --with-settings
   ```

### Cipher Storage Options

**Option A: SQLite (Default)**

- Local `data/` directories in each project
- Simple setup, works out of the box
- May conflict with existing `data/` directories

**Option B: PostgreSQL (Recommended)**  

- Centralized storage, no local files
- Production-ready architecture
- Requires Docker/PostgreSQL setup

## 🚀 Quick Setup

### Step 1: Setup Cipher in Your Project

```bash
# Navigate to your project
cd /path/to/your/project

# Setup Cipher integration (requires toolkit installed)
/global:cipher:setup-project

# Or with options:
/global:cipher:setup-project --force     # Overwrite existing CLAUDE.md
/global:cipher:setup-project --minimal   # Basic integration only
```

### Step 2: Initialize Memory

```bash
# Open Claude Code in your project
claude code

# Initialize project memory (in Claude Code)
/init

# Test memory integration
cipher_memory_search "project overview"
```

### Step 3: Verify Integration

**Expected behavior:**

- CLAUDE.md file created with Cipher instructions
- Claude Code actively uses memory functions
- Project context is stored and retrieved automatically
- No prompting needed for memory usage

## 📝 How It Works

### Automatic Memory Integration

**When you work with Claude Code in a Cipher-enabled project:**

1. **Before any task**: Claude automatically searches memory for relevant context
2. **After successful implementations**: Solutions are stored for future reference  
3. **During debugging**: Approaches are saved for similar future issues
4. **Continuous learning**: Project knowledge accumulates over time

### Project-Specific Context

**Each project maintains:**

- ✅ **Architecture decisions** and reasoning
- ✅ **Coding patterns** and conventions
- ✅ **Debugging solutions** that worked
- ✅ **Technology choices** and trade-offs
- ✅ **Performance optimizations** discovered
- ✅ **Testing strategies** that proved effective

### Memory Functions Used

**Core memory operations triggered automatically:**

```bash
cipher_memory_search "task context"                    # Before implementing
cipher_extract_and_operate_memory "solution pattern"   # After success
cipher_store_reasoning_memory "debugging approach"     # After troubleshooting
```

## 🧠 Memory Architecture

### Session-Based Organization

```bash
# Cipher automatically manages project sessions:
project-name-feature-auth      # Feature development
project-name-bugfix-payment    # Bug fixing  
project-name-refactor-api      # Refactoring work
project-name-testing-setup     # Test implementation
```

### Knowledge Categories

**System 1 Memory (Facts & Patterns):**

- API integration patterns
- Database schema decisions  
- UI component structures
- Build and deployment configs

**System 2 Memory (Reasoning & Process):**

- Problem-solving approaches
- Debugging methodologies
- Architecture decision processes
- Code review insights

## 🎛️ Management Commands

### Project Setup

```bash
/global:cipher:setup-project [directory] [options]
```

### Memory Operations (Available in Cipher-enabled projects)

```bash
/init                                    # Initialize project memory
cipher_memory_search "search term"      # Search project memory
/update-memory-bank                     # Sync documentation with code
```

### Session Management

```bash
cipher session new "project-feature"    # Start new session
cipher session switch "project-main"    # Switch context
cipher session list                     # View all sessions
```

## 🔧 Customization

### Template Customization

The generated CLAUDE.md includes customizable sections:

```markdown
### Tech Stack & Context
**[CUSTOMIZE THIS SECTION]** <!-- Auto-detected when possible -->

### Coding Conventions  
**[CUSTOMIZE THIS SECTION]** <!-- Project-specific guidelines -->

### Important Project Commands
**[CUSTOMIZE THIS SECTION]** <!-- Auto-populated from package.json -->
```

### Advanced Configuration

**Minimal Integration** (`--minimal` flag):

- Basic memory instructions only
- No extensive examples or customization sections
- Suitable for simple projects or proof-of-concept work

**Full Integration** (default):

- Comprehensive memory instructions
- Project-specific customization sections
- Detailed examples and patterns
- Session management guidelines

## 🚨 Troubleshooting

### Common Issues

**Memory functions not working:**

1. Check: `claude mcp list | grep cipher`
2. Verify: CLAUDE.md exists in project root
3. Restart: Claude Code completely
4. Test: `cipher_memory_search "test"`

**No project context stored:**

1. Run: `/init` to analyze codebase
2. Manually store: `cipher_extract_and_operate_memory "project setup complete"`
3. Verify: `cipher_memory_search "project"`

**Template not found:**

1. Ensure: Claude Code Toolkit is installed globally
2. Check: Template exists in `~/.claude/templates/`
3. Fallback: Manually copy template from toolkit repository

### Reset Project Memory

```bash
# Clear project-specific memory (careful!)
cipher session new "project-name-reset" 
# Previous sessions remain but start fresh context
```

## 🎉 Success Indicators

**When properly configured:**

- ✅ Claude Code automatically searches memory before tasks
- ✅ Solutions are stored without prompting
- ✅ Debugging approaches are saved automatically  
- ✅ Project context improves over time
- ✅ Reduced repetitive explanations needed
- ✅ Faster development with accumulated knowledge

## 📚 Additional Resources

- **Cipher Documentation**: <https://docs.byterover.dev/cipher/>
- **Claude Code Best Practices**: Focus on CLAUDE.md configuration
- **MCP Integration**: Ensure proper Cipher MCP server setup
- **Toolkit Commands**: Use `/help cipher` for all available Cipher commands

---

**This integration makes Claude Code significantly more intelligent by providing persistent, project-specific memory that accumulates knowledge and improves assistance quality over time.**
