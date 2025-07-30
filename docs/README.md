# Claude Code Toolkit Documentation

Welcome to the Claude Code Toolkit documentation. This directory contains comprehensive guides, architectural documentation, and reference materials.

## 🚀 Quick Start: Transform Your Code

Three powerful ways to improve your codebase:

### 1. Smart Problem Solving
```bash
/prefix:flow:smart "My API is slow and tests are failing"
```

### 2. Automated Quality Pipeline
```bash
/prefix:meta:pipelines deep-quality
```

### 3. Custom Command Chains
```bash
/prefix:meta:chain "scan:deep ." -> "fix:quick-wins {output}" -> "scan:quality . --compare"
```

**[→ See Modern Workflow Guide](guides/MODERN-WORKFLOW.md)** 🔥

## 🆕 New in v3.0

- **[MIGRATION-GUIDE.md](MIGRATION-GUIDE.md)** - Migrate from old command structure
- **[INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md)** - Comprehensive installation instructions
- **Smart Workflows** - AI-powered problem routing and multi-agent coordination
- **Command Chaining** - Powerful automation with data flow between commands

## 📚 Documentation Structure

### 🏗️ Architecture (`/architecture/`)
Deep technical documentation about the toolkit's design and implementation:

- **[SYSTEM-ARCHITECTURE-EN.md](architecture/SYSTEM-ARCHITECTURE-EN.md)** 🆕 - Complete technical architecture and workflow documentation
- **[SYSTEM-ARCHITECTURE-DE.md](architecture/SYSTEM-ARCHITECTURE-DE.md)** 🆕 - Technische Architektur auf Deutsch
- **[HYBRID-ARCHITECTURE.md](architecture/HYBRID-ARCHITECTURE.md)** - The innovative hybrid approach combining parallel scanning with expert analysis
- **[SUB-AGENT-ORCHESTRATION.md](architecture/SUB-AGENT-ORCHESTRATION.md)** - How specialized AI agents work together
- **[TECHNICAL-GUIDE.md](architecture/TECHNICAL-GUIDE.md)** - Technical implementation details and patterns

### 📖 Guides (`/guides/`)
Practical guides for using the toolkit effectively:

- **[MODERN-WORKFLOW.md](guides/MODERN-WORKFLOW.md)** 🔥 **Primary Guide** - All workflows from smart AI to manual control
- **[AUTOMATED-WORKFLOW.md](guides/AUTOMATED-WORKFLOW.md)** ⚡ - Quick automation options
- **[MCP-INTEGRATION.md](guides/MCP-INTEGRATION.md)** - Using MCP servers for enhanced functionality
- **[REPORT-EXPORT-SYSTEM.md](guides/REPORT-EXPORT-SYSTEM.md)** - Export formats and templates
- **[TROUBLESHOOTING-FILE-MODIFICATIONS.md](guides/TROUBLESHOOTING-FILE-MODIFICATIONS.md)** - Common issues and solutions

### 🎓 Tutorials (`/tutorials/`)
Step-by-step tutorials for getting started:

- **[quick-start.md](tutorials/quick-start.md)** 🚀 - Get started in 5 minutes with v3.0
- **[building-custom-commands.md](tutorials/building-custom-commands.md)** - Create your own commands
- **[creating-specialized-agents.md](tutorials/creating-specialized-agents.md)** - Build expert AI agents for specific tasks

### 🔧 API Reference (`/api/`)
Technical API documentation:

- **[command-api-reference.md](api/command-api-reference.md)** - Complete command structure and API specification
- **[agent-interface-specification.md](api/agent-interface-specification.md)** - Agent definition and integration patterns
- **[tool-integration-guide.md](api/tool-integration-guide.md)** - MCP and tool integration best practices

### 🗄️ Archive (`/archive/`)
Older documentation kept for reference:

- Historical installation guides
- Legacy architecture documents
- Previous versions of guides

## 🚀 Quick Start

### Option 1: Smart Problem Solving (Easiest) 🤖
```bash
/prefix:flow:smart "describe your problem here"
```
**[→ Modern Workflow Guide](guides/MODERN-WORKFLOW.md)**

### Option 2: Pre-Built Pipelines 🚀
```bash
/prefix:meta:pipelines deep-quality
```
**[→ Quick Automation Guide](guides/AUTOMATED-WORKFLOW.md)**

### Option 3: Learn the Architecture
1. **Understanding the System**: Read [HYBRID-ARCHITECTURE.md](architecture/HYBRID-ARCHITECTURE.md)
2. **Technical Details**: Check [TECHNICAL-GUIDE.md](architecture/TECHNICAL-GUIDE.md)

## 📊 Key Concepts

### The Hybrid Architecture
Our unique approach combines:
- **Phase 1**: Parallel scanning with the Task Tool for speed
- **Phase 2**: Deep analysis with specialized Sub-Agents for expertise  
- **Phase 3**: Intelligent synthesis for actionable insights

### Sub-Agent Specialization
Five expert agents provide focused analysis:
- 🏗️ **Code Architect** - System design and architecture
- ⚡ **Performance Optimizer** - Speed and efficiency
- 🔄 **Refactoring Expert** - Code improvement strategies
- 🔒 **Security Specialist** - Vulnerability detection
- 🧪 **Test Engineer** - Testing strategies and coverage

### Workflow Automation 🚀 NEW!
Complete automated pipeline from analysis to fixes:
1. **Smart Analysis** - AI-powered problem routing (`/flow:smart`)
2. **Quick Pipelines** - Pre-built workflows (`/meta:pipelines`)
3. **Command Chains** - Custom automation (`/meta:chain`)
4. **Direct Control** - Individual commands for specific tasks

**[→ Try the Automated Workflow Now!](guides/AUTOMATED-WORKFLOW.md)**

## 📈 Command Categories

Commands are organized into 8 clear categories:

- **scan** - Analysis & investigation (`deep`, `quality`, `perf`)
- **fix** - Direct corrections (`quick-wins`, `security`, `duplicates`)
- **gen** - Code & doc generation (`docs`, `tests`)
- **flow** - Multi-agent workflows (`smart`, `review`, `incident`)
- **auto** - Automation (`execute`, `monitor`, `sprint`)
- **sec** - Security (`audit`, `baseline`, `comply`)
- **git** - Version control (`commit`)
- **meta** - Project & toolkit (`health`, `chain`, `pipelines`)

## 🔍 Finding Information

### By Task
- **Getting Started**: [quick-start.md](tutorials/quick-start.md)
- **All Workflows**: [MODERN-WORKFLOW.md](guides/MODERN-WORKFLOW.md)
- **Migration from v2**: [MIGRATION-GUIDE.md](MIGRATION-GUIDE.md)
- **Installation Help**: [INSTALLATION-GUIDE.md](INSTALLATION-GUIDE.md)

### By Technical Interest
- **How agents work**: [SUB-AGENT-ORCHESTRATION.md](architecture/SUB-AGENT-ORCHESTRATION.md)
- **Parallel processing**: [HYBRID-ARCHITECTURE.md](architecture/HYBRID-ARCHITECTURE.md)
- **Implementation details**: [TECHNICAL-GUIDE.md](architecture/TECHNICAL-GUIDE.md)

## 🤝 Contributing

When adding new documentation:

1. Place files in the appropriate subdirectory
2. Update this README.md index
3. Follow the existing format and style
4. Include practical examples
5. Cross-reference related documents

## 📞 Getting Help

- **Issues**: Check troubleshooting guides in `/guides/`
- **Examples**: See example sections in each guide
- **Updates**: Watch the repository for new features

## 📋 Quick Reference

### Command Categories

| Category | Purpose | Example Commands |
|----------|---------|-----------------|
| **scan** | Analysis & investigation | `deep`, `quality`, `perf`, `deps` |
| **fix** | Direct corrections | `quick-wins`, `security`, `duplicates` |
| **gen** | Code & doc generation | `docs`, `tests` |
| **flow** | Multi-agent workflows | `smart`, `review`, `incident` |
| **auto** | Automation | `execute`, `monitor`, `sprint` |
| **sec** | Security | `audit`, `baseline`, `comply` |
| **git** | Version control | `commit` |
| **meta** | Project & toolkit | `health`, `chain`, `pipelines` |

### Essential Commands

```bash
# Get started quickly
/prefix:flow:smart "describe your problem"

# Run a quality check
/prefix:meta:pipelines quick-quality

# Deep analysis
/prefix:scan:deep .

# Fix issues automatically
/prefix:fix:quick-wins report.json

# Check project health
/prefix:meta:health
```

---

*Last Updated: January 2025*
*Documentation Version: 3.0*