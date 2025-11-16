---
allowed-tools: Bash(php:*)
description: Wrapper for TYPO3 make:content-block command with intelligent defaults
argument-hint: "[--vendor=...] [--type=...] [--skeleton-path=...] [--config-path=...] [--create-skeleton] [--batch=...] [--migrate-from=...]"
---

# TYPO3 Make Content Block Command Wrapper

Intelligent wrapper for the native TYPO3 `make:content-block` command with sensible defaults and configuration management.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Wrapper for TYPO3 make:content-block command with intelligent defaults
- **Usage**: [--vendor=...] [--type=...] [--skeleton-path=...] [--config-path=...]
- **Options**: --vendor, --type, --skeleton-path, --config-path, --create-skeleton, --batch, --migrate-from
- **Examples**: See the skeleton examples and command execution flow below

Then exit without executing the main command.

---

## Usage

```bash
/prefix:typo3:make-content-block [options]
```

## Command Workflow

This command wraps the native TYPO3 Content Blocks make command and provides:

1. Automatic content-blocks.yaml configuration
2. Intelligent defaults based on project structure
3. Skeleton management
4. Interactive guidance

## First: Check Prerequisites

```bash
# Check if Content Blocks is installed
composer show friendsoftypo3/content-blocks

# If not installed:
composer require friendsoftypo3/content-blocks:^1.3
```

## Configuration File Setup

First, check for or create `content-blocks.yaml`:

```yaml
# content-blocks.yaml (in project root or extension root)
vendor: {auto-detect from composer.json or ask user}
extension: {auto-detect or suggest sitepackage}
content-type: content-element  # Default
skeleton-path: .claude/typo3/skeletons  # Custom skeleton path
```

## Skeleton Templates

Create custom skeletons in `.claude/typo3/skeletons/`:

### Hero Section Skeleton

`.claude/typo3/skeletons/hero/config.yaml`:

```yaml
name: <vendor>/<name>
title: Hero Section
description: Full-width hero section with background image
group: common
prefixFields: true
prefixType: vendor
fields:
  - identifier: headline
    type: Text
    label: Headline
    required: true
    max: 100
  - identifier: subheadline
    type: Text
    label: Subheadline
    max: 200
  - identifier: text
    type: Textarea
    label: Description
    enableRichtext: true
    rows: 5
  - identifier: background_image
    type: File
    label: Background Image
    allowed: common-image-types
    maxitems: 1
    minitems: 1
  - identifier: cta_link
    type: Link
    label: Call to Action Link
    allowedTypes: [page, url, email]
  - identifier: cta_text
    type: Text
    label: Button Text
    default: 'Learn More'
  - identifier: overlay_opacity
    type: Number
    label: Overlay Opacity (0-100)
    format: integer
    default: 50
    range:
      lower: 0
      upper: 100
```

### Card Grid Skeleton

`.claude/typo3/skeletons/card-grid/config.yaml`:

```yaml
name: <vendor>/<name>
title: Card Grid
description: Responsive grid of cards with images
group: common
prefixFields: true
prefixType: vendor
fields:
  - identifier: headline
    type: Text
    label: Section Headline
  - identifier: cards
    type: Collection
    label: Cards
    labelField: title
    minitems: 1
    maxitems: 12
    fields:
      - identifier: title
        type: Text
        label: Card Title
        required: true
      - identifier: description
        type: Textarea
        label: Card Description
        rows: 3
      - identifier: image
        type: File
        label: Card Image
        allowed: common-image-types
        maxitems: 1
      - identifier: link
        type: Link
        label: Card Link
        allowedTypes: [page, url]
  - identifier: columns
    type: Select
    renderType: selectSingle
    label: Columns per Row
    default: '3'
    items:
      - label: '2 Columns'
        value: '2'
      - label: '3 Columns'
        value: '3'
      - label: '4 Columns'
        value: '4'
```

### Accordion Skeleton

`.claude/typo3/skeletons/accordion/config.yaml`:

```yaml
name: <vendor>/<name>
title: Accordion
description: Expandable accordion items
group: common
prefixFields: true
prefixType: vendor
fields:
  - identifier: items
    type: Collection
    label: Accordion Items
    labelField: title
    minitems: 1
    fields:
      - identifier: title
        type: Text
        label: Item Title
        required: true
      - identifier: content
        type: Textarea
        label: Item Content
        enableRichtext: true
        required: true
      - identifier: default_open
        type: Checkbox
        renderType: checkboxToggle
        label: Open by Default
        default: 0
```

### Page Type Skeleton

`.claude/typo3/skeletons/landing-page/config.yaml`:

```yaml
name: <vendor>/<name>
title: Landing Page
description: Modern landing page with sections
typeName: <typeName>  # Will be generated
group: default
prefixFields: true
prefixType: full
fields:
  - identifier: hero_image
    type: File
    label: Hero Background
    allowed: common-image-types
    maxitems: 1
  - identifier: hero_title
    type: Text
    label: Hero Title
    required: true
  - identifier: hero_subtitle
    type: Text
    label: Hero Subtitle
  - identifier: features
    type: Collection
    label: Features
    maxitems: 6
    fields:
      - identifier: icon
        type: Text
        label: Icon Class
        placeholder: 'fa-star'
      - identifier: title
        type: Text
        label: Feature Title
        required: true
      - identifier: description
        type: Textarea
        label: Feature Description
        rows: 3
```

## Command Execution Flow

1. **Check for content-blocks.yaml**:

```bash
# Look for configuration in these locations (in order):
# 1. ./content-blocks.yaml
# 2. ./packages/sitepackage/content-blocks.yaml
# 3. ./.claude/typo3/content-blocks.yaml
```

1. **If no config exists, create one**:

```yaml
vendor: {ask-user}
extension: {detect-or-ask}
content-type: content-element
skeleton-path: .claude/typo3/skeletons
```

1. **Show available skeletons**:

```
Available skeletons:
1. hero - Full-width hero section
2. card-grid - Responsive card grid
3. accordion - Expandable accordion
4. landing-page - Landing page type
5. custom - Start from scratch

Select skeleton [1-5]: 
```

1. **Run the make command**:

```bash
vendor/bin/typo3 make:content-block \
    --vendor="{vendor}" \
    --extension="{extension}" \
    --content-type="{type}" \
    --skeleton-path="{skeleton-path}/{selected-skeleton}"
```

## Interactive Mode Enhancements

If user wants custom configuration:

1. **Content Type Selection**:

```
Select content type:
1. content-element - Standard content element
2. page-type - Custom page type
3. record-type - Custom record type
Choice [1-3]: 
```

1. **Field Builder**:

```
Add fields to your content block:
1. Text field
2. Textarea (with/without RTE)
3. Image/File
4. Link
5. Select dropdown
6. Collection (repeating items)
7. Number
8. Date/Time
9. Checkbox/Toggle
0. Done adding fields

Choice: 
```

1. **Field Configuration**:
For each field type, ask relevant questions:

- Field identifier (kebab-case)
- Label
- Required? (y/n)
- Type-specific options

## Smart Defaults

### Vendor Detection

```bash
# Try to detect from:
1. composer.json "name" field
2. Git remote URL
3. Existing Content Blocks
4. Ask user
```

### Extension Detection

```bash
# Look for sitepackage in:
1. packages/sitepackage
2. packages/*/sitepackage
3. typo3conf/ext/sitepackage
4. Ask user
```

### Unique TypeName Generation

For page types, generate unique typeName:

```php
$typeName = time(); // Unix timestamp ensures uniqueness
// Or use a more readable format:
$typeName = 200000000 + (date('ymd') * 100); // 2024 = 200241220
```

## Post-Generation Actions

After successful generation:

1. **Clear caches**:

```bash
vendor/bin/typo3 cache:flush
```

1. **Show next steps**:

```
✅ Content Block created successfully!

Type: {content-element|page-type|record-type}
Name: {vendor}/{name}
Location: {path}

Next steps:
1. ✅ Caches have been cleared
2. Edit the generated files:
   - config.yaml - Adjust fields as needed
   - templates/frontend.html - Customize output
   - templates/backend-preview.html - Backend preview
   - language/labels.xlf - Add translations

3. {For page types: Add TypoScript template mapping}

4. Test in backend:
   {Content Element: Content > Add Content > {title}}
   {Page Type: Page > Create new page > {title}}
```

## Error Handling

- Check if vendor/bin/typo3 exists
- Verify Content Blocks extension is installed
- Validate skeleton path exists
- Handle permission errors
- Suggest fixes for common issues

## Advanced Features

### Custom Skeleton Creation

```bash
# Guide user to create custom skeleton:
/prefix:typo3:make-content-block --create-skeleton

# This will:
1. Ask for skeleton name
2. Guide through field creation
3. Save to skeleton directory
4. Make available for future use
```

### Batch Creation

```bash
# Create multiple blocks from definition file:
/prefix:typo3:make-content-block --batch=content-blocks-definition.yaml
```

### Migration Helper

```bash
# Convert Mask/DCE to Content Blocks:
/prefix:typo3:make-content-block --migrate-from=mask --mask-key=slider
```

## Integration with Other Commands

This command integrates with:

- `/prefix:typo3:sitepackage` - Creates extension structure
- `/prefix:typo3:analyze` - Analyzes existing blocks
- `/prefix:typo3:optimize` - Optimizes block configuration

## Best Practices

1. Always use vendor prefixes
2. Keep field identifiers consistent
3. Provide meaningful labels
4. Add backend previews
5. Include proper translations
6. Test in multiple languages
7. Consider performance impact
