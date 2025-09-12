---
description: Smart automated fixes with intelligent routing and dry-run previews
argument-hint: [type] [input] [--dry-run] [--help]
allowed-tools: Task, Read, Edit, MultiEdit, Grep, Bash(npm:*), Bash(yarn:*), Bash(git:*), Bash(semgrep:*)
mcp-enhanced: mcp__semgrep__security_check, mcp__semgrep__semgrep_scan
---

# Fix - Smart Automated Fixes

Intelligent fix command that automatically detects and applies the most appropriate fixes. Zero configuration, maximum effectiveness.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Fix Types

**Automatically applies fixes with dry-run preview option.**

### Available Fix Types

- `quick` - High-ROI fixes with minimal effort (default)
- `security` - Security vulnerabilities and OWASP issues
- `performance` - Performance optimizations and bottlenecks
- `quality` - Code quality improvements
- `duplicates` - Code duplication removal
- `docs` - Documentation fixes and improvements
- `lint` - Linting errors and style issues
- `shell` - Shell script improvements
- `markdown` - Markdown formatting fixes
- `critical` - Only critical/high-priority issues

## Usage

```bash
# Smart defaults - apply quick wins from latest analysis
/prefix:fix

# Specific fix types  
/prefix:fix security       # Security vulnerability fixes
/prefix:fix performance    # Performance optimizations
/prefix:fix quick          # High-ROI, low-effort fixes
/prefix:fix critical       # Critical issues only

# With specific input
/prefix:fix security report.json    # Fix security issues from specific report
/prefix:fix quick latest-scan.json  # Quick fixes from specific file

# Preview mode (dry-run)
/prefix:fix security --dry-run      # Preview security fixes  
/prefix:fix quick --dry-run         # Preview quick wins
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine fix type and input source**

```bash
# Parse arguments
args=($ARGUMENTS)
fix_type="quick"     # default to quick wins
input_source="latest" # default to latest analysis
dry_run=false

# Check for dry-run flags (--dry-run is standard, --preview is alias)  
if [[ "$ARGUMENTS" == *"--dry-run"* ]] || [[ "$ARGUMENTS" == *"--preview"* ]]; then
    dry_run=true
fi

# Extract type if provided
if [[ ${#args[@]} -gt 0 ]] && [[ ${args[0]} != *.json ]] && [[ ${args[0]} != --* ]]; then
    fix_type=${args[0]}
    input_source=${args[1]:-"latest"}
else
    input_source=${args[0]:-"latest"}
fi
```

**Step 2: Route to appropriate fix strategy**

Based on fix_type, execute the optimal fix approach:

### Quick Fixes (Default)

**Input**: Latest analysis or `$input_source`  
**Focus**: High-ROI, low-effort improvements

Use Task tool with subagent_type="refactoring-expert":
"Apply quick wins from analysis results with maximum ROI and minimal effort. Focus on easy fixes like unused variables, simple optimizations, obvious code smells, and low-risk improvements. ${dry_run && 'PREVIEW ONLY - do not apply changes, just show what would be fixed.'} Prioritize fixes with ROI > 5 and effort < 4 hours."

### Security Fixes

**Input**: Security analysis or `$input_source`
**Focus**: OWASP vulnerabilities, authentication, encryption

Use Task tool with subagent_type="security-specialist":
"Fix security vulnerabilities with MCP-enhanced Semgrep analysis when available, fallback to pattern matching. Address OWASP Top 10 issues, authentication problems, data validation, XSS, SQL injection, and encryption issues. ${dry_run && 'PREVIEW ONLY - show security fixes without applying.'} Prioritize critical and high severity issues."

### Performance Fixes  

**Input**: Performance analysis or `$input_source`
**Focus**: Algorithm optimization, memory usage, caching

Use Task tool with subagent_type="performance-optimizer":
"Apply performance optimizations including algorithm improvements, memory usage reduction, database query optimization, caching implementations, and resource efficiency fixes. ${dry_run && 'PREVIEW ONLY - show performance optimizations without applying.'} Focus on measurable improvements with clear impact estimates."

### Quality Fixes

**Input**: Quality analysis or `$input_source`
**Focus**: Code quality, maintainability, best practices

Use Task tool with subagent_type="code-architect":
"Improve code quality through design pattern application, SOLID principle adherence, maintainability enhancements, and best practice implementations. ${dry_run && 'PREVIEW ONLY - show quality improvements without applying.'} Focus on sustainable, long-term code health improvements."

### Duplicates Fixes

**Input**: Code analysis or `$input_source`
**Focus**: DRY principle, code reuse, refactoring

Use Task tool with subagent_type="refactoring-expert":
"Remove code duplication by extracting common functions, creating shared utilities, and applying DRY principles. ${dry_run && 'PREVIEW ONLY - show duplication fixes without applying.'} Maintain functionality while improving maintainability through intelligent refactoring."

### Documentation Fixes

**Input**: Documentation analysis or `$input_source`
**Focus**: Missing docs, broken links, outdated content

Use Task tool with subagent_type="general-purpose":
"Fix documentation issues including broken links, parameter mismatches, missing cross-references, outdated content, and API documentation gaps. ${dry_run && 'PREVIEW ONLY - show documentation fixes without applying.'} Ensure documentation-code synchronization and completeness."

### Lint Fixes

**Input**: Code files or `$input_source`
**Focus**: Style consistency, linting rules, formatting

Use Task tool with subagent_type="general-purpose":
"Automatically detect and fix linting errors across multiple languages with intelligent agent orchestration. Apply consistent formatting, fix style violations, resolve import issues, and address code style inconsistencies. ${dry_run && 'PREVIEW ONLY - show lint fixes without applying.'}"

### Shell Fixes

**Input**: Shell scripts or `$input_source`
**Focus**: Shell script best practices, security, portability

Use Task tool with subagent_type="general-purpose":
"Fix shell script issues using shellcheck analysis including syntax errors, security vulnerabilities, portability issues, and best practice violations. ${dry_run && 'PREVIEW ONLY - show shell fixes without applying.'} Improve script reliability and maintainability."

### Markdown Fixes

**Input**: Markdown files or `$input_source`
**Focus**: Formatting, consistency, structure

Use Task tool with subagent_type="general-purpose":
"Lint and fix markdown files for consistent formatting, proper structure, link validation, and style compliance. ${dry_run && 'PREVIEW ONLY - show markdown fixes without applying.'} Ensure professional documentation presentation."

### Critical Fixes

**Input**: Any analysis with critical issues or `$input_source`
**Focus**: High-priority, business-critical issues only

Use Task tool with subagent_type="debugging-specialist":
"Apply only critical and high-priority fixes that address business-critical issues, security vulnerabilities, or system-breaking problems. ${dry_run && 'PREVIEW ONLY - show critical fixes without applying.'} Focus on immediate risk mitigation and system stability."

## Smart Input Resolution

**Latest Analysis Detection:**
If input_source is "latest", automatically find the most recent analysis file:

```bash
# Find latest analysis file
latest_file=$(find . -name "*analysis*.json" -o -name "*scan*.json" -o -name "*report*.json" | sort -r | head -n1)
```

**Intelligent Fix Selection:**
Based on analysis results, automatically prioritize fixes:

- Critical security issues → Immediate application
- Performance bottlenecks → Impact-based prioritization  
- Code quality issues → ROI-based selection
- Documentation gaps → Completeness-based fixing

## Next Steps Recommendations

After fix completion, display context-aware recommendations:

```markdown
✅ [Fix Type] fixes applied successfully

🔧 **Changes made:**
   - [Summary of applied fixes]
   - [Number of issues resolved]
   - [Estimated impact/improvement]

💡 **Recommended next steps:**
   /prefix:analyze [related-type]     # Verify fixes with new analysis
   /prefix:work review               # Get expert code review
   /prefix:git commit               # Commit changes with smart messages

   **Or describe your next goal:** "I want to improve test coverage"
```

### Smart Next-Step Logic

Based on fix results, suggest relevant follow-up actions:

- **Security fixes applied** → Suggest `/prefix:secure audit` for verification
- **Performance fixes applied** → Suggest `/prefix:analyze performance` to measure impact
- **Quality fixes applied** → Suggest `/prefix:analyze quality` for new metrics
- **Critical fixes applied** → Suggest `/prefix:work review` for expert validation
- **Documentation fixes applied** → Suggest `/prefix:analyze docs` for completeness check

## Safety Features

- **Dry-Run by Default**: All fixes can be previewed before application
- **Incremental Application**: Fixes applied in safe, reversible stages  
- **Backup Creation**: Automatic backup of files before modifications
- **Git Integration**: Smart commit suggestions after successful fixes
- **Rollback Support**: Easy reversal of applied fixes if needed

## Benefits

- **Intelligent Routing**: Automatically applies the right fixes for detected issues
- **Safety First**: Preview all changes before application
- **Context Aware**: Understands analysis results and prioritizes accordingly
- **Multi-Language**: Supports fixes across different programming languages
- **ROI Optimized**: Focuses on high-impact, low-effort improvements
- **One Interface**: Replaces 8 specialized fix commands

*Consolidates: fix:quick-wins, fix:security, fix:performance, fix:duplicates, fix:documentation, fix:lint, fix:shell, fix:markdown*
