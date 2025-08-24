# Help Check Template

Add this to the beginning of each command's execution section:

```markdown
### Help Check

If "$ARGUMENTS" contains "--help":

Display command documentation:

**Command**: /PREFIX:CATEGORY:COMMAND
**Description**: [From frontmatter]
**Arguments**: [From argument-hint]

**Usage Examples**:
[Include all usage examples from command]

**Key Features**:
[List main capabilities]

Then exit without executing the main command.
```

This ensures help is displayed when requested without executing the actual command logic.
