---
name: content-blocks
description: Generate TYPO3 Content Blocks v1.3 with modern field configurations
---

# TYPO3 Content Blocks Generator

Generates Content Blocks v1.3 compatible configurations for TYPO3 v13.4.

## Arguments

Parse arguments from `$ARGUMENTS`:

- **name**: Content Block name (kebab-case, e.g., "hero-section")
- `--type=element|page` — Content Element (default) or Page Type
- `--fields=...` — Comma-separated list of fields
- `--sitepackage=path` — SitePackage path (default: ./packages/sitepackage)
- `--with-components` — Generate Fluid v4 Components alongside
- `--component-type=inline|external` — Component integration style

If arguments are missing, ask the user interactively.

## Knowledge References

Consult these resources for implementation patterns:

- `${CLAUDE_PLUGIN_ROOT}/knowledge/content-blocks-core-patterns.md`
- `${CLAUDE_PLUGIN_ROOT}/knowledge/content-blocks-shared-partials.md`
- `${CLAUDE_PLUGIN_ROOT}/knowledge/content-blocks-v13-complete-reference.md`

## Execution

### 1. Parse & Validate

Extract block name, type, vendor prefix, fields from arguments. Validate kebab-case naming and vendor format.

### 2. Create Directory Structure

**Content Element:**

```
ContentBlocks/ContentElements/{name}/
├── config.yaml
├── assets/icon.svg
├── language/labels.xlf
└── templates/
    ├── frontend.html
    └── backend-preview.html
```

**Page Type:**

```
ContentBlocks/PageTypes/{name}/
├── config.yaml
├── assets/icon.svg, icon-hide-in-menu.svg
├── language/labels.xlf
└── templates/backend-preview.html, README.md
```

### 3. Generate config.yaml

Use field type templates: Text, Textarea (with RTE), File (with cropVariants), Link, Select, Collection (v1.3), Checkbox, DateTime, Number.

Key config properties: `name`, `title`, `description`, `group`, `prefixFields: true`, `prefixType: vendor`.

### 4. Generate Templates

- **frontend.html**: Fluid template with proper namespaces (`xmlns:f`, `xmlns:cb`). Use `{data.{vendor}_{name}_{field}}` access pattern.
- **backend-preview.html**: Informative preview with field counts and content excerpts.
- **labels.xlf**: XLIFF 1.2 format with title and description trans-units.

### 5. Optional: Fluid Components

When `--with-components` is used, generate component-based templates using Atomic Design (Atom/Molecule/Organism) with `<f:argument>` declarations.

## Output Format

```
Content Block created successfully!

Location: {path}/ContentBlocks/{type}/{name}/
Name: {vendor}/{name}
Type: {Content Element|Page Type}
Fields: {count} fields configured

Next steps:
1. Clear caches: vendor/bin/typo3 cache:flush
2. Test in TYPO3 Backend
3. Customize templates as needed
```
