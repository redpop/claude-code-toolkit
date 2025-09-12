---
description: Smart export management with format conversion, documentation sync, and handoff preparation
argument-hint: [type] [source] [--help]
allowed-tools: Task, Read, Write, Grep
---

# Export - Smart Export Management

Intelligent export command that automatically handles report conversion, documentation synchronization, and team handoff preparation. Zero configuration, maximum format flexibility.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Export Types

**Automatically detects content types and applies optimal export strategies with comprehensive format support.**

### Available Export Types

- `convert` - Multi-format conversion and report consolidation (default)
- `docs` - Documentation synchronization and updates
- `summary` - Content summarization and chat summaries
- `handoff` - Team handoff and knowledge transfer preparation
- `changelog` - Changelog generation and version updates
- `merge` - Multi-report merging and consolidation
- `template` - Template-based export with custom formatting

## Usage

```bash
# Smart defaults - convert latest reports to multiple formats
/prefix:export

# Specific export operations
/prefix:export convert report.json --format=md    # Convert JSON to Markdown
/prefix:export docs --sync                        # Sync all documentation
/prefix:export summary chat-history.md            # Summarize chat sessions
/prefix:export handoff --complete                 # Full handoff package

# Advanced operations
/prefix:export merge *.json --format=html         # Merge multiple reports
/prefix:export changelog --from=v1.0.0           # Generate changelog
/prefix:export template report.json --exec-summary # Executive summary template
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine export operation and source**

```bash
# Parse arguments
args=($ARGUMENTS)
export_operation="convert"    # default to format conversion
source_files=""
output_format="auto"         # auto-detect optimal format

# Check for operation type
export_operations=("convert" "docs" "summary" "handoff" "changelog" "merge" "template")
if [[ " ${export_operations[@]} " =~ " ${args[0]} " ]]; then
    export_operation=${args[0]}
    source_files="${args[@]:1}"
else
    source_files="${args[*]}"
fi

# Detect format preferences
if [[ "$source_files" == *"--format="* ]]; then
    output_format=$(echo "$source_files" | grep -o -- '--format=[^[:space:]]*' | cut -d= -f2)
fi
```

**Step 2: Route to appropriate export strategy**

Based on export_operation, execute optimal approach:

### Multi-Format Conversion and Report Consolidation (Default)

**Process**: Intelligent format conversion with content optimization
**Export**: Auto-generates files in requested formats with timestamps

Use Task tool with subagent_type="general-purpose":
"MULTI-FORMAT EXPORT: Convert '$source_files' to optimal formats. Process: 1) Analyze source content type and structure, 2) Determine optimal output formats (JSON for automation, Markdown for humans, HTML for sharing, PDF for formal reports), 3) Apply format-specific optimizations and styling, 4) Ensure content fidelity and readability across formats, 5) Generate timestamped files with consistent naming. Support formats: Markdown, JSON, HTML, PDF with intelligent content adaptation."

### Documentation Synchronization and Updates

**Process**: Comprehensive documentation sync and maintenance
**Output**: Updated documentation with consistency verification

Use Task tool with subagent_type="documentation-health-specialist":
"DOCUMENTATION SYNC: Synchronize and update project documentation for '$source_files'. Process: 1) Verify documentation-code synchronization, 2) Update API documentation and references, 3) Check cross-references and link validity, 4) Update README and setup instructions, 5) Ensure consistency across documentation formats, 6) Generate documentation health report. Maintain accuracy, completeness, and accessibility of all project documentation."

### Content Summarization and Chat Summaries

**Process**: Intelligent content summarization with key insights
**Export**: Auto-generates summary reports with action items

Use Task tool with subagent_type="general-purpose":
"CONTENT SUMMARIZATION: Create intelligent summary of '$source_files'. Process: 1) Extract key points and main themes, 2) Identify decisions made and action items, 3) Summarize technical discussions and solutions, 4) Highlight important insights and learnings, 5) Create actionable summary with next steps, 6) Format for easy consumption and sharing. Focus on clarity, completeness, and actionable outcomes."

### Team Handoff and Knowledge Transfer

**Process**: Comprehensive handoff package preparation
**Export**: Auto-generates complete handoff documentation package

Use Task tool with subagent_type="general-purpose":
"TEAM HANDOFF PREPARATION: Create comprehensive handoff package for '$source_files'. Include: 1) Project overview and context, 2) Architecture and design decisions, 3) Setup and deployment instructions, 4) Key technical knowledge and gotchas, 5) Contact information and resources, 6) Transition timeline and responsibilities. Generate complete knowledge transfer package for smooth team transitions."

### Changelog Generation and Version Updates

**Process**: Automated changelog creation from project history
**Export**: Auto-generates changelog with version information

Use Task tool with subagent_type="general-purpose":
"CHANGELOG GENERATION: Generate changelog from project history for '$source_files'. Process: 1) Analyze commit history and version tags, 2) Categorize changes (features, fixes, breaking changes), 3) Extract meaningful change descriptions, 4) Format according to Keep a Changelog standards, 5) Include migration notes and upgrade instructions, 6) Generate version-specific and cumulative changelog. Follow semantic versioning and conventional commit patterns."

### Multi-Report Merging and Consolidation

**Process**: Intelligent merging of multiple reports with deduplication
**Export**: Auto-generates consolidated report with comprehensive insights

Use Task tool with subagent_type="general-purpose":
"MULTI-REPORT MERGING: Consolidate multiple reports '$source_files' into unified output. Process: 1) Parse and normalize different report formats, 2) Identify overlapping and complementary information, 3) Merge insights while avoiding duplication, 4) Create comprehensive combined analysis, 5) Maintain traceability to source reports, 6) Generate executive summary and detailed findings. Output format: $output_format with cross-referenced insights."

### Template-Based Export with Custom Formatting

**Process**: Template-driven export with professional formatting
**Export**: Auto-generates formatted reports using predefined templates

Use Task tool with subagent_type="general-purpose":
"TEMPLATE-BASED EXPORT: Generate formatted export using templates for '$source_files'. Process: 1) Identify appropriate template based on content type, 2) Extract key data points and metrics, 3) Apply professional formatting and styling, 4) Include executive summary and recommendations, 5) Add charts, graphs, and visual elements where appropriate, 6) Generate print-ready and digital-friendly versions. Focus on professional presentation and stakeholder communication."

## Export Formats

### Supported Input Formats

- **JSON**: Analysis reports, structured data
- **Markdown**: Documentation, notes, summaries  
- **CSV**: Metrics, data exports, spreadsheets
- **XML**: Configuration, structured documents
- **YAML**: Configuration, metadata
- **Text**: Logs, raw content, transcripts

### Supported Output Formats

- **Markdown** (.md): Human-readable, version-controllable
- **JSON** (.json): Machine-readable, API-friendly
- **HTML** (.html): Web-viewable, shareable
- **PDF** (.pdf): Professional, print-ready
- **Word** (.docx): Business-friendly, editable
- **PowerPoint** (.pptx): Presentation-ready
- **CSV** (.csv): Spreadsheet-compatible, data analysis

### Format-Specific Optimizations

#### Markdown Export

- Clean formatting with proper headers
- Code blocks with syntax highlighting
- Tables and lists for structured data
- Cross-references and internal links

#### HTML Export  

- Responsive design for all devices
- Interactive elements and navigation
- Charts and graphs for data visualization
- Professional styling and branding

#### PDF Export

- Print-optimized layout and formatting
- Table of contents and navigation
- High-quality graphics and charts
- Professional document structure

#### JSON Export

- Structured data with clear schema
- Nested objects for complex relationships
- Metadata and versioning information
- API-compatible format standards

## Template Library

### Executive Summary Template

- High-level overview and key findings
- Strategic recommendations
- Risk assessment and priorities
- Action plan with timelines

### Technical Report Template

- Detailed technical analysis
- Code examples and implementations
- Performance metrics and benchmarks
- Technical recommendations

### Handoff Documentation Template

- Project context and background
- Architecture and design decisions
- Setup and deployment procedures
- Knowledge transfer checklist

### Changelog Template

- Version-based change tracking
- Feature, fix, and breaking change categories
- Migration notes and upgrade paths
- Contributor acknowledgments

## Next Steps Recommendations

After export operation completion, display context-aware recommendations:

```markdown
✅ [Export Operation] completed successfully

📁 **Files Generated**: [List of exported files with formats and sizes]
🎯 **Primary Uses**: [Recommended use cases for each export format]
🔗 **Share Links**: [If applicable, sharing URLs or locations]

💡 **Recommended next steps:**
   /prefix:work review          # Get team review of exported content
   /prefix:toolkit health       # Check project health after updates
   /prefix:git commit          # Commit documentation updates

   **Or describe your sharing goal:** "I need to present this to stakeholders"
```

### Smart Next-Step Logic

Based on export operation results:

- **Documentation exported** → Suggest `/prefix:work review` for team validation
- **Summary created** → Suggest sharing with relevant stakeholders
- **Handoff package generated** → Suggest team transition meeting
- **Changelog created** → Suggest version tagging and release preparation
- **Reports merged** → Suggest analysis and action planning

## Integration Features

### Automated Content Detection

- **Smart Format Recognition**: Automatically identifies content types
- **Optimal Format Selection**: Chooses best output format for content
- **Quality Preservation**: Maintains content fidelity across conversions

### Template System Integration

- **Dynamic Template Selection**: Chooses appropriate templates
- **Content Adaptation**: Adapts content to template structure
- **Professional Formatting**: Applies consistent styling and branding

### Documentation Sync Integration

- **Cross-Reference Validation**: Ensures all links work correctly
- **Version Consistency**: Maintains version alignment across docs
- **Automated Updates**: Keeps documentation current with code changes

## Benefits

- **Universal Format Support**: Converts between all major document and data formats
- **Intelligent Content Adaptation**: Optimizes content for each output format
- **Professional Templates**: Generates business-ready reports and presentations
- **Documentation Synchronization**: Keeps all project documentation current and accurate
- **Team Handoff Support**: Facilitates smooth knowledge transfer and transitions
- **One Interface**: Replaces multiple specialized export and documentation tools

*Consolidates: meta:export, meta:docs-sync, meta:update-docs, meta:summary, meta:handoff, meta:changelog*
