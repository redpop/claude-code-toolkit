# TYPO3 Content Blocks Core Patterns

## Field Naming Conventions

See [Field Naming Reference](./references/field-naming-reference.md) for complete naming patterns and examples.

## Database Table Generation

### Automatic Table Creation

Content Blocks v1.3 automatically generates:

1. TCA configurations
2. Database tables for collections
3. SQL definitions

### Table Naming Best Practices

- Use descriptive collection field names (e.g., `accordion_items` not just `items`)
- Avoid generic names that could conflict
- Consider prefixing with content block name for clarity

## Field Access Patterns

See [Field Naming Reference](./references/field-naming-reference.md#complete-access-pattern-reference) for detailed field access patterns.

## Common Field Types

### Text Field

```yaml
- identifier: title
  type: Text
  label: 'Title'
  required: true
  max: 100
```

### Textarea with RTE

```yaml
- identifier: content
  type: Textarea
  label: 'Content'
  enableRichtext: true
  richtextConfiguration: default
```

### Collection

```yaml
- identifier: items
  type: Collection
  label: 'Items'
  labelField: title  # Field used for backend labels
  fields:
    - identifier: title
      type: Text
    - identifier: content
      type: Textarea
```

### Checkbox Toggle

```yaml
- identifier: active
  type: Checkbox
  renderType: checkboxToggle
  label: 'Active'
  default: 0
```

### File/Image

```yaml
- identifier: image
  type: File
  allowed: common-image-types
  maxitems: 1
  cropVariants:
    default:
      title: Default
      allowedAspectRatios:
        16:9:
          value: 1.777777778
```

## Backend Preview Structure

See [Backend Preview Reference](./references/backend-preview-reference.md) for complete preview template examples and best practices.

## Frontend Template Structure

### Basic Setup

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:cb="http://typo3.org/ns/TYPO3/CMS/ContentBlocks/ViewHelpers">

<div class="{blockname}-wrapper">
    <!-- Content here -->
</div>
</html>
```

### Using Shared Partials from Sitepackage

Content Blocks can use shared partials to avoid redundancy:

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers">

<f:comment>-- Use shared component from sitepackage --</f:comment>
<f:render partial="Components/Accordion/Accordion" arguments="{
    title: data.punktde_accordion_title,
    items: data.punktde_accordion_items,
    firstExpanded: data.punktde_accordion_first_expanded,
    allowMultiple: data.punktde_accordion_allow_multiple
}" />
</html>
```

**Required TypoScript Configuration:**

```typoscript
# In your sitepackage's TypoScript (e.g., ContentBlocks.typoscript)
lib.contentElement {
    partialRootPaths {
        100 = EXT:sitepackage/Resources/Private/Partials/
    }
}
```

This allows all Content Blocks to use partials from the sitepackage.
See: [Content Blocks Shared Partials Documentation](./content-blocks-shared-partials.md)

### Asset Inclusion

```html
<!-- External JavaScript -->
<f:asset.script identifier="script-id" src="https://cdn.example.com/script.js" external="true" defer="true" />

<!-- External CSS as Script (for Tailwind CDN) -->
<f:asset.script identifier="tailwind-css" src="https://cdn.tailwindcss.com" external="true" />
```

## Debugging Strategies

### 1. Field Name Discovery

See [Field Naming Reference](./references/field-naming-reference.md#debug-field-names) for debugging field names.

### 2. Cache Clearing

See [TYPO3 Commands Reference](./references/typo3-ddev-commands-reference.md#cache-management) for all cache clearing options.

### 3. Database Verification

See [TYPO3 Commands Reference](./references/typo3-ddev-commands-reference.md#database-commands) for database inspection commands.

### 4. TCA Inspection

Check generated TCA in:

- `/var/cache/code/content-blocks/`
- Backend Configuration module

## Common Pitfalls

### 1. Collection Field Naming

**Problem:** Table `punktde_items` too generic
**Solution:** Use descriptive names like `accordion_items`

### 2. Field Access in Collections

**Problem:** Trying to access `item.punktde_accordion_accordion_items_header`
**Solution:** Use direct access: `item.header`

### 3. Cache Not Clearing

**Problem:** Changes not reflecting
**Solution:** See [TYPO3 Commands Reference](./references/typo3-ddev-commands-reference.md#cache-management)

### 4. Missing Backend Preview

**Problem:** Backend shows raw data
**Solution:** Create proper `backend-preview.html` with formatted output

## Migration Considerations

### From Individual Settings to Global

When changing from per-item settings to global:

1. Remove field from collection definition
2. Add field at root level
3. Update templates to use global setting
4. Clear caches and update database schema

### Renaming Collections

1. Change identifier in config.yaml
2. New table will be created
3. Migrate data if needed
4. Remove old table manually

## Version-Specific Features

### Content Blocks v1.3

- Collection child type restrictions
- Default configurations
- Enhanced ViewHelpers
- Improved backend preview capabilities

### TYPO3 v13.4

- Set-based configuration
- Improved Content Blocks integration
- Enhanced caching mechanisms
