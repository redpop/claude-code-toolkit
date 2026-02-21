---
name: fluid-components
description: Generate Fluid v4 Components for TYPO3 v13 with Atomic Design patterns and Fluid analysis
---

# TYPO3 Fluid Components Generator & Analyzer

Generates Fluid v4 Components for TYPO3 v13.3+ using Atomic Design patterns. Also provides Fluid template analysis and optimization.

## Arguments

Parse arguments from `$ARGUMENTS`:

- **component-name**: Component name (kebab-case)
- `--type=atom|molecule|organism` — Atomic Design level (default: atom)
- `--sitepackage=path` — SitePackage path (default: ./packages/sitepackage)
- `--analyze` — Analysis mode: analyze existing Fluid templates instead of generating

If no arguments, guide interactively through type, name, arguments, slots, and accessibility features.

## Knowledge References

- `${CLAUDE_PLUGIN_ROOT}/knowledge/content-blocks-shared-partials.md`
- `${CLAUDE_PLUGIN_ROOT}/knowledge/sitepackage-structure-reference.md`

## Execution

### Analysis Mode (--analyze)

Use Task tool with subagent_type="typo3-fluid-expert" to analyze:

- Template architecture and organization
- ViewHelper usage patterns and quality
- Performance optimization opportunities
- TYPO3 v13+ convention compliance
- Maintainability and code quality

Export results as JSON with scores and prioritized recommendations.

### Generation Mode (default)

#### 1. Component Structure

```
Resources/Private/Components/
├── Atom/       — Buttons, inputs, icons
├── Molecule/   — Cards, forms, media objects
└── Organism/   — Headers, grids, galleries
```

#### 2. Important: Fluid v4.3 Syntax

The `fc:component` syntax is NOT available in Fluid v4.3/TYPO3 13. Use standard partials with `f:render partial=""` or the ComponentCollection approach.

#### 3. Component Template

Generate with `<f:argument>` declarations for type safety:

- **Atom**: Simple elements with variant, size, disabled, ARIA attributes, default slot
- **Molecule**: Composite with title, description, header/body/footer slots
- **Organism**: Complex with items array, columns, gap, named slots for header/item/footer

#### 4. ComponentCollection Class

Create `ComponentCollection.php` extending `AbstractComponentCollection` if not exists.

#### 5. Supplementary Files

- SCSS scaffold with BEM methodology and variant/size modifiers
- PHPUnit test file for component rendering
- Usage examples showing namespace registration and invocation

## Output Format

```
Fluid Component created successfully!

Location: {path}/Resources/Private/Components/{type}/{name}.html
Type: {Atom|Molecule|Organism}
Component: <my:{type}.{name} />

Files created:
- Component template
- ComponentCollection class (if new)
- Test file
- SCSS file
```
