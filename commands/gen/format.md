---
allowed-tools: Task, Read, Write, WebFetch, Grep
description: Create or convert content into various formats (HTML, Markdown, Jira, Plain Text)
argument-hint: <request-or-file> [--html|--html-simple|--markdown|--jira|--text]
---

# Format Command

Creates or converts content into the desired format. Simple, focused, and practical.

## Core Functionality

This command does ONE thing well: **Creates or converts content into your desired format**

Supported formats:

- `--html` - Clean, semantic HTML (no CSS/JS)
- `--html-simple` - Simple HTML fragment (no head/body, no wrapper elements)
- `--markdown` - Standard Markdown
- `--jira` - Jira Wiki Markup
- `--text` - Formatted plain text

## Usage Examples

```bash
# Create new content
/prefix:gen:format "I need an accessibility guide for web projects" --html

# Create simple HTML fragment for embedding
/prefix:gen:format README.md --html-simple

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

1. Identify the requested output format (--html, --html-simple, --markdown, --jira, or --text)
2. Parse the input:
   - If it's a request (text in quotes), create new content
   - If it's a file path, read and convert it
   - If multiple sources provided, combine them intelligently
3. For URLs: Fetch and extract relevant content
4. Generate the output in the requested format:
   - HTML: Pure semantic HTML with PROPERLY ESCAPED entities. CRITICAL: In ALL HTML content, especially within <code>, <pre>, and other elements, you MUST escape these characters:
     * < must become &lt;
     * > must become &gt;  
     * & must become &amp;
     * " must become &quot;
     * ' must become &#39;
     This is MANDATORY for valid HTML. Example: "if (x < 5)" must become "if (x &lt; 5)" inside HTML.
     No CSS, no JavaScript. Use only semantic elements (header, nav, main, article, section, aside, footer, h1-h6, p, ul, ol, li, dl, dt, dd, blockquote, figure, figcaption, table, thead, tbody, tr, th, td, form, label, fieldset, legend, details, summary, mark, time, code, pre, kbd, samp, var, etc.). NEVER use DIV, SPAN or other non-semantic wrapper elements. For line breaks, always use self-closing `<br />` tags.
   - HTML-SIMPLE: Create a SIMPLE HTML fragment suitable for direct embedding. CRITICAL RULES:
     * NO <!DOCTYPE>, <html>, <head>, or <body> tags
     * NO wrapper elements like <header>, <footer>, <section>, <article>, <aside>, <nav>, <main>
     * Use ONLY basic HTML elements: h1-h6, p, ul, ol, li, table, tr, td, th, code, pre, blockquote, br, strong, em, a
     * Keep structure FLAT and SIMPLE - minimal nesting
     * STILL MUST escape all HTML entities properly (< → &lt;, > → &gt;, & → &amp;, etc.)
     * This format is designed for easy copy-paste into existing applications
     * Example: Instead of <section><h2>Title</h2><p>Text</p></section>, just use <h2>Title</h2><p>Text</p>
   - Markdown: CommonMark standard
   - Jira: Proper Jira Wiki Markup syntax
   - Text: Well-formatted ASCII text
   
WICHTIG: Verwende beim Erstellen von eigenen Texten IMMER die Du-Form (informelle Anrede), außer im Prompt wird explizit etwas anderes gefordert (z.B. Sie-Form, formelle Anrede, oder Englisch). Beispiele:
   - Richtig: 'Du kannst...', 'Klicke auf...', 'Deine Einstellungen...'
   - Falsch: 'Sie können...', 'Klicken Sie auf...', 'Ihre Einstellungen...'

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

Converts 1:1 maintaining structure, creating pure semantic HTML without DIV elements.

### Creating simple HTML for embedding

```bash
/prefix:gen:format documentation.md --html-simple
```

Creates a simple HTML fragment without head/body tags, perfect for copy-pasting into existing applications or CMS systems.

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
- HTML output uses ONLY semantic elements - no DIV, SPAN or generic wrappers
- HTML-SIMPLE creates flat, minimal HTML fragments perfect for embedding in existing applications
