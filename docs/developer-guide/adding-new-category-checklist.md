# Checklist: Adding a New Command Category

When adding a new category of commands (like TYPO3, Laravel, Vue, etc.), ensure you update ALL relevant meta-commands and documentation:

## ✅ Required Updates

### 1. Core Meta Commands

- [ ] **`/commands/meta/find-cmd.md`** - Add keyword section with:
  - Category name and icon
  - All relevant keywords and synonyms
  - List of commands in category
  - List of specialized agents

### 2. Documentation

- [ ] **`README.md`** - Update command categories section
- [ ] **`CLAUDE.md`** - Add to "Current Command Categories" section
- [ ] **`docs/README.md`** - Update documentation index

### 3. Installation & Discovery

- [ ] **`install.sh`** - Ensure new category is properly installed
- [ ] **`scripts/update-readme.sh`** - Verify it captures new commands

### 4. Templates & Examples

- [ ] Create category-specific command template if needed
- [ ] Add example workflows to `docs/guides/`

### 5. Testing

- [ ] Test `find-cmd` with category keywords
- [ ] Verify all commands are discoverable
- [ ] Test installation with fresh prefix

## 📋 Template for find-cmd.md Addition

```markdown
### 🎯 [Category Name]
**Keywords**: keyword1, keyword2, keyword3, synonym1, synonym2
**Commands**: category:command1, category:command2, category:command3
**Agents**: specialist-agent-1, specialist-agent-2
```

## 🤖 AI Instructions for New Categories

When asked to add a new technology/framework integration:

1. **Always update find-cmd.md FIRST** - This ensures discoverability
2. **Use consistent naming** - Follow existing patterns (e.g., `typo3:*`, `laravel:*`)
3. **Add comprehensive keywords** - Include common misspellings and synonyms
4. **Document MCP integrations** - If using Context7 or other MCP servers
5. **Create both commands AND agents** - Commands for tasks, agents for expertise

## Example Git Commit Structure

```bash
# Good practice - update meta commands in same commit
git add commands/[category]/*.md
git add agents/[category]-*.md
git add commands/meta/find-cmd.md  # Don't forget this!
git add CLAUDE.md
git add README.md
git commit -m "✨ feat: add [Category] integration with discovery support"
```

## Common Oversights to Avoid

1. **Forgetting find-cmd.md** - Most common mistake
2. **Missing keywords** - Not including common variations
3. **No agent registration** - Agents need to be listed too
4. **Incomplete documentation** - Update all relevant docs
5. **No example workflows** - Users need guidance

## Testing Discovery

After adding new category:

```bash
# Test that find-cmd discovers your commands
/prefix:meta:find-cmd "your-technology-name"
/prefix:meta:find-cmd "common-task-in-your-technology"

# Should return your new commands and agents
```
