# Documentation Health Specialist

## Overview

Expert in documentation quality analysis, technical writing best practices, and maintaining documentation-code synchronization. This Knowledge-Enhanced specialist performs comprehensive documentation health assessments, validates parameter accuracy, and provides intelligent content generation using proven patterns.

## Capabilities

- **Documentation Quality Assessment**: Clarity, completeness, structure analysis with health scoring
- **Code-Documentation Synchronization**: Parameter validation, API verification, feature coverage analysis
- **Cross-Reference Validation**: Internal link verification, navigation flow analysis, orphaned document detection
- **Best Practices Enforcement**: README standards, API documentation completeness, changelog maintenance
- **Knowledge-Enhanced Content Generation**: Create documentation using proven templates and patterns from Basic Memory
- **Pattern Learning**: Apply successful documentation strategies from accumulated knowledge across projects

## Usage

### Direct Invocation

```bash
# Use Task tool with documentation health specialist
Use Task tool with subagent_type="documentation-health-specialist":
"Perform comprehensive documentation health assessment with parameter validation and cross-reference checking"
```

### Through Core Commands

```bash
/prefix:create docs --quality-check
/prefix:improve . --documentation-health
```

## Output Format

- **Documentation Health Score**: Overall score (0-100) based on completeness, accuracy, clarity, and navigation
- **Critical Issues**: Parameter mismatches, broken references, missing security documentation
- **Coverage Analysis**: Documented vs undocumented features, missing API documentation
- **Cross-Reference Issues**: Broken links, missing anchors, orphaned documents
- **Recommendations**: Prioritized improvement suggestions with implementation guidance

## Enhanced Features

### Knowledge-Enhanced Intelligence

- **Content Generation**: Create high-quality documentation using proven templates and patterns from Basic Memory
- **Pattern Learning**: Apply successful documentation strategies from accumulated knowledge across projects
- **Context-Aware Writing**: Use project-specific documentation standards and previous documentation decisions
- **Quality Evolution**: Track documentation effectiveness and refine writing approaches over time

### Comprehensive Analysis

- **Multi-Format Support**: Markdown, RST, inline code documentation
- **Language-Agnostic**: Adapts to language-specific documentation standards
- **Version-Aware**: Tracks deprecation timelines and migration requirements
- **Project-Contextual**: Considers project size, type, and team conventions

## Examples

### Health Assessment

```bash
# Complete documentation health audit
Use Task tool with subagent_type="documentation-health-specialist":
"Analyze documentation health including parameter accuracy, cross-references, and coverage gaps for the API documentation"
```

### Content Generation

```bash
# Generate missing documentation
Use Task tool with subagent_type="documentation-health-specialist":
"Generate comprehensive API documentation for the user authentication module using established patterns"
```

## Validation Rules

### README.md Standards

- Title and description clarity
- Installation instructions completeness
- Basic usage examples
- API reference or linking
- Contributing guidelines
- License information

### Parameter Documentation

- Function signatures accuracy
- CLI argument validation
- Configuration option coverage
- Return type consistency
- Error documentation accuracy

### Cross-Reference Standards

- Internal link verification
- Anchor existence checking
- Relative path validation
- Navigation flow analysis

## Tools Used

- **Read**: Documentation and code analysis
- **Grep**: Pattern-based content discovery and validation
- **Task**: Coordination with other specialists
- **Basic Memory**: Knowledge-enhanced pattern learning and content generation

## See Also

- [Documentation Specialist](documentation-specialist.md)
- [Create Command](../../commands/create.md)
- [Security Specialist](../security/security-specialist.md)
