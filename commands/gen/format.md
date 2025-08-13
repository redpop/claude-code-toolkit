---
allowed-tools: Task, Read, Write, WebFetch, Grep
description: Create or convert content into various formats (HTML, Markdown, Confluence, Plain Text)
argument-hint: <request-or-file> [--html|--html-simple|--markdown|--confluence|--text]
---

# Format Command

Creates or converts content into the desired format. Simple, focused, and practical.

## Core Functionality

This command does ONE thing well: **Creates or converts content into your desired format**

Supported formats:

- `--html` - Clean, semantic HTML (no CSS/JS)
- `--html-simple` - Simple HTML fragment (no head/body, no wrapper elements)
- `--markdown` - Standard Markdown
- `--confluence` - Simple Confluence Wiki Markup (basic formatting for easy copy-paste)
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

# Generate Confluence content
/prefix:gen:format "As a user I want to reset my password" --confluence
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

1. Identify the requested output format (--html, --html-simple, --markdown, --confluence, or --text)
2. Parse the input:
   - If it's a request (text in quotes), create new content
   - If it's a file path, read and convert it
   - If multiple sources provided, combine them intelligently
3. For URLs: Fetch and extract relevant content
4. Generate the output in the requested format:
   - HTML: Pure semantic HTML with PROPERLY ESCAPED entities. CRITICAL: In ALL HTML content, especially within <code>, <pre>, and other elements, you MUST escape these characters:
     - & must become &amp; (MUST be done FIRST before other escapes!)
     - < must become &lt;
     - > must become &gt;
     - " must become &quot;
     - ' must become &#39;
       This is MANDATORY for valid HTML. Examples: 
       - "if (x < 5 && y > 3)" must become "if (x &lt; 5 &amp;&amp; y &gt; 3)"
       - "name && age" must become "name &amp;&amp; age"
       No CSS, no JavaScript. Use only semantic elements (header, nav, main, article, section, aside, footer, h1-h6, p, ul, ol, li, dl, dt, dd, blockquote, figure, figcaption, table, thead, tbody, tr, th, td, form, label, fieldset, legend, details, summary, mark, time, code, pre, kbd, samp, var, etc.). NEVER use DIV, SPAN or other non-semantic wrapper elements. For line breaks, always use self-closing `<br />` tags.
   - HTML-SIMPLE: Create a SIMPLE HTML fragment suitable for direct embedding. CRITICAL RULES:
     - NO <!DOCTYPE>, <html>, <head>, or <body> tags
     - NO wrapper elements like <header>, <footer>, <section>, <article>, <aside>, <nav>, <main>
     - Use ONLY basic HTML elements: h1-h6, p, ul, ol, li, table, tr, td, th, code, pre, blockquote, br, strong, em, a
     - Keep structure FLAT and SIMPLE - minimal nesting
     - STILL MUST escape all HTML entities properly (& → &amp; FIRST, then < → &lt;, > → &gt;, etc.)
     - This format is designed for easy copy-paste into existing applications
     - Example: Instead of <section><h2>Title</h2><p>Text</p></section>, just use <h2>Title</h2><p>Text</p>
   - Markdown: CommonMark standard
   - Confluence: Confluence storage format for direct copy-paste. CRITICAL RULES:
     - Use HTML tags for formatting: <h1>-<h6>, <strong>bold</strong>, <em>italic</em>
     - MUST escape HTML entities in text content: & → &amp;, < → &lt;, > → &gt;, " → &quot;
     - For inline code use: <code>inline code here</code> (with escaped entities inside!)
     - For code blocks use the structured macro format with language detection:
       <ac:structured-macro ac:name="code" ac:schema-version="1">
         <ac:parameter ac:name="language">LANGUAGE</ac:parameter>
         <ac:parameter ac:name="title">Optional Title</ac:parameter>
         <ac:plain-text-body><![CDATA[
         // Your code here
         ]]></ac:plain-text-body>
       </ac:structured-macro>
     - Language parameter mapping:
       * JavaScript/TypeScript: language="js"
       * Bash/Shell: language="bash"
       * Python: language="python"
       * Java: language="java"
       * HTML/XML: language="xml"
       * CSS: language="css"
       * SQL: language="sql"
       * JSON: language="json"
       * YAML: language="yaml"
       * Default/Unknown: language="text"
     - Title parameter is OPTIONAL - adds a heading/caption above the code block in Confluence
       * Use for descriptive titles like "Installation Script", "Configuration Example", "API Response"
       * Only include <ac:parameter ac:name="title"> when a title adds value
       * If no title needed, omit the entire title parameter line
     - IMPORTANT: All code content must be wrapped in CDATA tags (no escaping needed inside CDATA)
     - NO complex panels or other macros
     - Keep structure FLAT and SIMPLE - minimal nesting
     - Use HTML lists: <ul><li>item</li></ul> and <ol><li>item</li></ol>
     - Tables with HTML: <table><tr><th>header</th></tr><tr><td>cell</td></tr></table>
     - Links with HTML: <a href="url">text</a>
     - Paragraphs with <p>text</p>
     - This format is designed for direct paste into Confluence editor (source mode)
     - Example: <h2>Title</h2> for headings, structured macro for code blocks
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

### Generating Confluence content

```bash
/prefix:gen:format "Epic: Implement multi-factor authentication" --confluence
```

Creates Confluence storage format with proper code macro syntax, ready for direct paste into Confluence editor (source mode). Code blocks use the structured macro format with CDATA wrapping.

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
