---
description: Smart content generation with intelligent routing for docs, tests, and format conversion
argument-hint: [type] [target] [--help]
allowed-tools: Task, Read, Write, MultiEdit, Grep, Bash(npm:*), Bash(typedoc:*), Bash(jest:*), Bash(vitest:*), Bash(pytest:*), WebFetch
---

# Make - Smart Content Generation

Intelligent generation command that automatically creates documentation, tests, or formatted content. Zero configuration, maximum productivity.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Generation Types

**Automatically exports results with timestamped filenames and appropriate formats.**

### Available Generation Types

- `docs` - Comprehensive documentation (API docs, README, comments, diagrams)
- `tests` - Test suites for uncovered code (unit, integration, edge cases)
- `format` - Convert content to various formats (HTML, Markdown, Confluence, Plain Text)
- `api` - API documentation from code analysis
- `readme` - Project README with examples and usage
- `comments` - Inline code comments and JSDoc
- `unit` - Unit test files for functions and classes
- `integration` - Integration tests for services and APIs
- `html` - Clean semantic HTML from content or files
- `markdown` - Standard Markdown from any source
- `confluence` - Confluence-ready content with code macros

## Usage

```bash
# Smart defaults - comprehensive docs for current directory
/prefix:make

# Specific generation types
/prefix:make docs              # Generate all documentation
/prefix:make tests             # Create comprehensive test suites
/prefix:make format content    # Convert content to optimal format

# With specific targets
/prefix:make docs src/         # Documentation for src/ directory
/prefix:make tests report.json # Tests based on coverage report
/prefix:make html README.md    # Convert README to HTML

# Advanced usage
/prefix:make api --coverage-target=90      # API docs with 90% coverage
/prefix:make confluence "Setup Guide"     # Confluence-ready setup guide
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine generation type and target**

```bash
# Parse arguments
args=($ARGUMENTS)
gen_type="docs"      # default to comprehensive docs
target="."           # default to current directory

# Extract type if provided
if [[ ${#args[@]} -gt 0 ]] && [[ ${args[0]} != *"/"* ]] && [[ ${args[0]} != *"."* ]]; then
    gen_type=${args[0]}
    target=${args[1]:-"."}
else
    target=${args[0]:-"."}
fi
```

**Step 2: Route to appropriate generation strategy**

Based on gen_type, execute the optimal approach:

### Documentation Generation (Default)

**Target**: Comprehensive documentation for `$target`
**Export**: Auto-generates `docs-YYYYMMDD-HHMMSS/` directory structure

Use Task tool with subagent_type="documentation-health-specialist":
"Generate comprehensive documentation for '$target' including API docs, README files, inline comments, and architecture diagrams. Analyze code structure, build dependency graph, identify public APIs, and create clear, maintainable documentation. Export as organized directory structure with multiple formats (Markdown, HTML). Focus on completeness and professional presentation."

### Test Generation

**Target**: Test coverage improvement for `$target`
**Export**: Auto-generates test files with `test-YYYYMMDD-HHMMSS.json` report

Use Task tool with subagent_type="test-engineer":
"Generate comprehensive test suites for '$target' analyzing code structure and identifying test scenarios. Create unit tests, integration tests, and edge cases following best practices. Auto-detect testing framework, generate mocks for external dependencies, and aim for high coverage with meaningful tests. Include test report with coverage improvements."

### Format Conversion

**Target**: Content formatting for `$target`
**Export**: Auto-generates `format-YYYYMMDD-HHMMSS.{ext}` files

Use Task tool with subagent_type="general-purpose":
"Process formatting request for '$target'. Support multiple formats: HTML (semantic, no CSS/JS), HTML-simple (minimal fragments), Markdown (CommonMark), Confluence (storage format with code macros), Plain Text (well-formatted ASCII). Handle content creation from text, file conversion, URL fetching, and multi-source combination. Apply proper HTML entity escaping and format-specific best practices."

### API Documentation

**Target**: API documentation for `$target`
**Export**: Auto-generates `api-docs-YYYYMMDD-HHMMSS/` structure

Use Task tool with subagent_type="documentation-health-specialist":
"Generate comprehensive API documentation for '$target' focusing on extracting function signatures, inferring parameter types, generating examples, and adding error documentation. Create structured API reference with endpoints, parameters, responses, and usage examples. Include interactive documentation features where possible."

### README Generation

**Target**: Project README for `$target`
**Export**: Auto-generates `README-YYYYMMDD-HHMMSS.md`

Use Task tool with subagent_type="documentation-health-specialist":
"Generate comprehensive README for '$target' including project overview, installation steps, usage examples, API reference, and contributing guide. Analyze project structure to understand purpose, dependencies, and usage patterns. Create professional, informative README following best practices with clear sections and examples."

### Inline Comments

**Target**: Code commenting for `$target`
**Export**: Updates files with comprehensive comments

Use Task tool with subagent_type="documentation-health-specialist":
"Add comprehensive inline comments and JSDoc to '$target' including function descriptions, parameter documentation, return value explanations, and example usage. Follow language-specific documentation standards (JSDoc for JS/TS, docstrings for Python, etc.). Maintain code functionality while improving documentation quality."

### Unit Tests

**Target**: Unit test generation for `$target`
**Export**: Auto-generates unit test files

Use Task tool with subagent_type="test-engineer":
"Generate comprehensive unit tests for '$target' focusing on pure functions, class methods, utility functions, and isolated components. Create tests with happy path cases, edge cases, error conditions, and boundary values. Auto-detect testing framework and generate appropriate test structure with setup, teardown, and assertions."

### Integration Tests

**Target**: Integration test creation for `$target`
**Export**: Auto-generates integration test files

Use Task tool with subagent_type="test-engineer":
"Generate integration tests for '$target' focusing on API endpoints, database operations, service interactions, and external integrations. Create realistic test scenarios with proper mocking of external dependencies, database setup/teardown, and end-to-end workflow testing."

### HTML Generation

**Target**: HTML creation from `$target`
**Export**: Auto-generates `html-YYYYMMDD-HHMMSS.html`

Use Task tool with subagent_type="general-purpose":
"Convert '$target' to clean, semantic HTML with proper entity escaping. Use only semantic elements (header, nav, main, article, section, etc.) without DIV or SPAN wrappers. No CSS or JavaScript. Focus on accessibility and standards compliance with proper heading hierarchy and markup structure."

### Markdown Generation

**Target**: Markdown creation from `$target`
**Export**: Auto-generates `markdown-YYYYMMDD-HHMMSS.md`

Use Task tool with subagent_type="general-purpose":
"Convert '$target' to CommonMark standard Markdown with proper structure, headers, lists, code blocks, and links. Maintain document hierarchy and formatting while ensuring compatibility across Markdown parsers. Include table of contents and cross-references where appropriate."

### Confluence Generation

**Target**: Confluence content from `$target`
**Export**: Auto-generates `confluence-YYYYMMDD-HHMMSS.html`

Use Task tool with subagent_type="general-purpose":
"Convert '$target' to Confluence storage format ready for direct paste. Use HTML tags for formatting, structured code macros with proper language detection, and CDATA wrapping for code blocks. Escape HTML entities properly and maintain flat structure optimized for Confluence editor compatibility."

## Next Steps Recommendations

After generation completion, display context-aware recommendations:

```markdown
✅ [Generation Type] completed successfully

📁 Generated: [filename/directory]
📊 Content: [summary of what was created]

💡 **Recommended next steps:**
   /prefix:analyze docs          # Verify documentation quality
   /prefix:work review          # Get expert review of generated content
   /prefix:git commit          # Commit new content with smart messages

   **Or describe your goal:** "I need to improve the API examples"
```

### Smart Next-Step Logic

Based on generation results, suggest relevant follow-up actions:

- **Documentation generated** → Suggest `/prefix:analyze docs` for completeness check
- **Tests generated** → Suggest `/prefix:analyze tests` for coverage verification  
- **Format conversion completed** → Suggest `/prefix:work review` for quality check
- **API docs created** → Suggest `/prefix:make tests` for API test generation
- **README generated** → Suggest `/prefix:analyze quality` for content review

## Benefits

- **Intelligent Routing**: Automatically uses the best generation approach for your needs
- **Multiple Formats**: Supports documentation, testing, and format conversion in one interface
- **Smart Defaults**: Works with minimal configuration while supporting advanced options
- **Professional Output**: Follows best practices and standards for each content type
- **Time-Stamped Results**: All generated content includes timestamps for version tracking
- **One Interface**: Replaces 3 specialized generation commands

*Consolidates: gen:docs, gen:tests, gen:format*
