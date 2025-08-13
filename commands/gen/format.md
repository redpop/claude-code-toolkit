---
allowed-tools: Task, Read, Write, WebFetch, Grep
description: Create or convert content into various formats (HTML, Markdown, Jira, Plain Text)
argument-hint: "request or file" --format [--html|--markdown|--jira|--text]
---

# Format Command

Creates or converts content into the desired format. Simple, focused, and practical.

## Core Functionality

This command does ONE thing well: **Creates or converts content into your desired format**

Supported formats:

- `--html` - Clean, semantic HTML (no CSS/JS)
- `--markdown` - Standard Markdown
- `--jira` - Jira Wiki Markup
- `--text` - Formatted plain text

## Usage Examples

```bash
# Create new content
/prefix:gen:format "I need an accessibility guide for web projects" --html

# Convert existing file
/prefix:gen:format README.md --html

# Create from multiple sources
/prefix:gen:format "Create API docs from:" api.yaml https://api-reference.com --html

# Generate Jira story
/prefix:gen:format "As a user I want to reset my password" --jira
```

## Execution

Parse the arguments to understand:

1. What content to create/convert
2. What format to output
3. What sources to reference (if any)

Use Task tool with subagent_type="general-purpose":
"Process the following formatting request:

Input: $ARGUMENTS

Instructions:

1. Identify the requested output format (--html, --markdown, --jira, or --text)
2. Parse the input:
   - If it's a request (text in quotes), create new content
   - If it's a file path, read and convert it
   - If multiple sources provided, combine them intelligently
3. For URLs: Fetch and extract relevant content
4. Generate the output in the requested format:
   - HTML: Clean, semantic HTML with proper entities (&amp;, &lt;, &gt;, &quot;). No CSS, no JavaScript. Use structural elements only.
   - Markdown: CommonMark standard
   - Jira: Proper Jira Wiki Markup syntax
   - Text: Well-formatted ASCII text
5. Choose an intelligent filename based on content (e.g., 'accessibility-guide', 'api-documentation', 'user-story-login')
6. Save with format: {smart-name}-YYYYMMDD-HHMMSS.{extension}

Return a JSON with:

- filename: The generated filename
- content: The formatted content
- summary: Brief description of what was created"

After receiving the result:

1. Write the content to the generated filename
2. Report success with file details

## Output

```markdown
✅ Format successful!

📄 Created: {filename}
📏 Size: {size}
🔤 Format: {format_name}

💡 Ready for: {use_cases}
```

## Examples

### Creating new documentation

```bash
/prefix:gen:format "I need a troubleshooting guide for database connections" --html
```

Creates a complete HTML guide with proper structure, ready for Confluence or any CMS.

### Converting Markdown to HTML

```bash
/prefix:gen:format architecture.md --html
```

Converts 1:1 maintaining structure, creating clean semantic HTML.

### Generating Jira content

```bash
/prefix:gen:format "Epic: Implement multi-factor authentication" --jira
```

Creates properly formatted Jira epic with all necessary sections.

### Using multiple sources

```bash
/prefix:gen:format "Create installation guide from:" README.md https://docs.example.com/setup --html
```

Combines information from multiple sources into cohesive documentation.

## Notes

- Always generates a file with timestamp
- Intelligent naming based on content analysis
- Clean, valid output in every format
- Handles special characters correctly (especially for HTML)
- Can reference both local files and web resources
