# Universal Help Handler Snippet

Add this section immediately after the frontmatter in EVERY command:

```markdown
## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

📚 **Command Help: /PREFIX:CATEGORY:COMMAND**

**Description**: [Auto-extracted from frontmatter description]

**Usage**: 
```bash
/PREFIX:CATEGORY:COMMAND [From argument-hint frontmatter]
```

**Options**:
[Auto-extracted from frontmatter options if present]

**Examples**:
[Auto-extracted from frontmatter examples if present]

**Related Commands**:
[Auto-extracted from frontmatter see-also if present]

Then exit without executing the main command workflow.

---

```

## Implementation Note

This snippet ensures that:
1. Every command responds to --help
2. Help is extracted from frontmatter metadata
3. User gets immediate help without command execution
4. Consistent help format across all commands
