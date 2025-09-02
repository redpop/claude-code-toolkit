---
allowed-tools: Write, Read
description: Intelligently create commands, agents, or workflows from your description
argument-hint: "<what you need> [--type=auto|command|agent|workflow]"
mcp-enhanced: mcp__context7__get-library-docs
---

# Create - Universal Intelligent Creator

One command to create anything you need. Just describe it, and I'll figure out the rest.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Usage - Dead Simple

```bash
# Just tell me what you need
/prefix:meta:create "Find all TODO comments"
/prefix:meta:create "Laravel security analyzer"
/prefix:meta:create "Database optimization expert"
/prefix:meta:create "Complete Vue.js workflow"
```

## How It Works

$ARGUMENTS

I'll automatically determine what you need and create it intelligently.

### Intelligent Detection

Based on your description, I automatically detect:

1. **Simple Command** (keywords: find, check, list, validate, fix)
   → Creates a standalone command
2. **Expert/Agent** (keywords: expert, specialist, analyzer, optimizer)
   → Creates an agent with expertise
3. **Workflow** (keywords: workflow, complete, full, pipeline, multi-step)
   → Creates command + agents + orchestration

4. **Technology-Specific** (mentions: Laravel, Vue, TYPO3, React, etc.)
   → Creates category if needed + specialized resources

### Smart Process

```
Your Request
    │
    ├─→ Quick Analysis (< 1 second)
    │   ├─→ What: Command, Agent, or Workflow?
    │   ├─→ Domain: What technology/area?
    │   └─→ Complexity: Simple or Complex?
    │
    ├─→ Resource Check
    │   ├─→ Can existing agents help? → Reuse
    │   ├─→ Similar commands exist? → Extend
    │   └─→ Nothing suitable? → Create new
    │
    └─→ Automatic Creation
        ├─→ Generate files
        ├─→ Update discovery (find-cmd)
        ├─→ Link resources
        └─→ Ready to use!
```

### What Gets Created

#### For Simple Commands

```bash
Input: "Find all console.log statements"
Creates: /commands/scan/console-logs.md
```

#### For Agents

```bash
Input: "Database optimization expert"
Creates: /agents/database-optimizer.md (using standardized template)
         /commands/db/optimize.md (to use the agent)

# Behind the scenes, uses:
# ./scripts/create-agent.sh database-optimizer specialist "Database optimization expert"
# This ensures proper frontmatter with required 'name' field
```

#### For Workflows

```bash
Input: "Complete Laravel security audit"
Creates: /agents/laravel-security.md (if needed)
         /commands/laravel/security-audit.md
         Links to existing security-specialist
```

### Zero Configuration Needed

I handle everything:

- ✓ Naming (follows conventions)
- ✓ Categories (creates if needed)
- ✓ Templates (picks the right one)
- ✓ Integration (updates all meta files)
- ✓ Discovery (adds to find-cmd)
- ✓ Documentation (generates examples)

## Examples

### Example 1: Simple Task

```
You: "Remove trailing whitespace from files"

I create:
→ /commands/fix/trailing-whitespace.md
→ Simple command, no agents needed
```

### Example 2: Expert Needed

```
You: "PostgreSQL query optimization expert"

I create:
→ /agents/postgresql-optimizer.md (expert agent)
→ /commands/db/optimize-postgres.md (command to use it)
→ Links to existing database patterns
```

### Example 3: Complex Workflow

```
You: "Full Vue.js application setup with testing"

I create:
→ /agents/vue-architect.md (if needed)
→ /agents/vue-testing-expert.md (if needed)
→ /commands/vue/setup.md (orchestration)
→ Reuses existing frontend-specialist
→ Creates vue category in find-cmd
```

## Advanced Options (Optional)

Only use these if you need specific control:

```bash
# Force specific type
/prefix:meta:create "..." --type=command  # Only create command
/prefix:meta:create "..." --type=agent    # Only create agent

# Specify category
/prefix:meta:create "..." --category=frontend

# Preview without creating
/prefix:meta:create "..." --dry-run
```

## Behind the Scenes

### Agent Creation Process

When creating an agent, I follow a validated workflow:

1. **Template Selection**: Use `/templates/agent-template.md`
2. **Validation**: Ensure all required fields (especially `name`)
3. **Script Execution**: Run `./scripts/create-agent.sh` with proper parameters
4. **Customization**: Fill in domain-specific expertise and methodologies
5. **Integration**: Link with commands and update discovery

This guarantees:

- ✓ Required `name` field is always present
- ✓ Consistent structure across all agents
- ✓ No parsing errors in Claude Code
- ✓ Proper frontmatter format

### Reusability Check

Before creating any agent, I check:

```bash
# Do we have similar agents?
→ security-specialist (for security tasks)
→ performance-optimizer (for performance)
→ frontend-specialist (for React/Vue/Angular)
→ database experts (for DB tasks)

# Reuse when possible, extend when needed
```

### Auto-Integration

After creation:

1. Updates `/commands/meta/find-cmd.md` with keywords
2. Adds to README if new category
3. Creates usage examples
4. Links related resources

### Quality Assurance

Every creation includes:

- Proper frontmatter (with required `name` field for agents)
- Clear descriptions
- Usage examples
- Error handling
- Best practices

## FAQ

**Q: What if I'm not sure what I need?**
A: Just describe your problem. I'll figure out if you need a command, agent, or both.

**Q: Will it create duplicate agents?**
A: No. I always check for existing agents first and reuse them.

**Q: Can I edit what gets created?**
A: Yes! Everything created is a markdown file you can customize.

**Q: How does it know the category?**
A: I analyze your description for technology/domain keywords and pick the best fit.

## Tips for Best Results

1. **Be specific about the goal**: "Find X" vs "Find and fix X"
2. **Mention technologies**: "Laravel", "React", "PostgreSQL"
3. **Indicate complexity**: "simple check" vs "complete workflow"

But don't worry - even vague descriptions work:

- "Something for testing" → I'll ask what kind
- "Database stuff" → I'll create a general DB helper
- "Make it faster" → I'll create a performance analyzer

## The Magic

This single command replaces:

- `/meta:create-cmd` (merged)
- `/meta:smart-create` (merged)
- Manual agent creation
- Manual category creation
- Manual find-cmd updates
- Manual documentation updates

**One command. Zero complexity. Full intelligence.**

Just tell me what you need, and I'll make it happen. 🚀
