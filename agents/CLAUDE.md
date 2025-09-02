# CLAUDE.md - Agents Directory

This file provides context for Claude Code when working with agents in this directory.

## Sub-Agents Overview

Sub-Agents are specialized AI agents that provide domain-specific expertise for various development tasks. Each agent is defined as a markdown file with YAML frontmatter.

## Available Sub-Agents

### Core Analysis Agents

- **ai-specialist**: AI integration expert specializing in prompt engineering and LLM optimization
- **code-architect**: Analyzes system architecture and design patterns  
- **performance-optimizer**: Identifies performance bottlenecks and optimizations
- **refactoring-expert**: Suggests code improvements and refactoring strategies
- **report-analyzer**: Analyzes code quality reports and provides prioritized insights
- **security-specialist**: Performs security audits and vulnerability detection
- **test-engineer**: Analyzes test coverage and testing strategies

### Specialized Agents

- **debugging-specialist**: Expert in systematic debugging, log analysis, and root cause identification
- **deployment-specialist**: CI/CD and deployment expert for automated pipelines and production troubleshooting
- **documentation-health-specialist**: Analyzes documentation quality and code-doc synchronization
- **frontend-specialist**: Frontend development expert specializing in modern JavaScript frameworks
- **git-conflict-specialist**: Git merge conflict resolution expert specializing in conflict analysis and resolution strategies
- **tailwind-css-specialist**: Tailwind CSS optimization expert for utility-first CSS framework optimization
- **workflow-optimizer**: Developer workflow expert focused on productivity and reducing friction

### TYPO3 Specific Agents

- **typo3-architect**: TYPO3 system architecture specialist
- **typo3-content-blocks-specialist**: Content Blocks implementation expert
- **typo3-extension-developer**: Extension development specialist
- **typo3-fluid-expert**: Fluid Template Engine expert with Context7 integration
- **typo3-typoscript-expert**: TypoScript and configuration expert

## Sub-Agent Structure

Each agent file must include:

1. **Required Frontmatter Fields**:

   ```yaml
   ---
   name: agent-name  # REQUIRED by Claude Code
   description: Brief description of agent capabilities
   ---
   ```

2. **Agent Content Structure**:
   - Identity and role definition
   - Specialized knowledge areas
   - Analysis approach
   - Output format specifications
   - Best practices and guidelines

## Adding New Sub-Agents

### Recommended Method: Automated Creation

Use the standardized workflow for consistent agent creation:

```bash
# Quick agent creation with validation
./scripts/create-agent.sh <agent-name> <type> "<description>"

# Example
./scripts/create-agent.sh database-optimizer specialist "Database performance expert"
```

This ensures:

1. Required frontmatter fields (`name`, `description`) are always present
2. Consistent structure using `/templates/agent-template.md`
3. Proper validation of agent names and types
4. No Claude Code parsing errors
5. Ready for testing through orchestration commands

### Manual Creation Steps

If creating manually:

1. Copy an existing agent or use template from `/templates/agent-template.md`
2. Ensure `name` field is present in frontmatter (CRITICAL)
3. Define clear expertise domain
4. Specify analysis methodology
5. Include output format examples
6. Test through an orchestration command

### Agent Types

- **specialist**: Deep expertise in specific domain
- **analyzer**: Analysis and reporting focused
- **helper**: Support and utility functions
- **research**: Investigation and discovery

## Invocation Patterns

Sub-agents are invoked through:

1. Orchestration commands (`/flow:*`, `/scan:*`)
2. Direct Task Tool invocation
3. Hybrid architecture commands

Example Task Tool invocation:

```markdown
Use Task tool with subagent_type="security-specialist":
"Perform a comprehensive security audit of the codebase focusing on OWASP Top 10 vulnerabilities."
```

## Best Practices

1. **Focused Expertise**: Each agent should have a clear, narrow focus
2. **Structured Output**: Define consistent output formats
3. **Context Isolation**: Agents work in isolated contexts
4. **Error Handling**: Include graceful failure modes
5. **Documentation**: Keep agent descriptions current

## Testing Agents

After creating an agent:

1. Install locally: `./install.sh <prefix>`
2. Test via orchestration command
3. Verify output format
4. Check error handling
5. Document in relevant guides

For detailed agent creation workflow, see: `docs/guides/AGENT-CREATION-WORKFLOW.md`
