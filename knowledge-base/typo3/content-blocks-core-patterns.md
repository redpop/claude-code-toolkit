# TYPO3 Content Blocks Core Patterns

## Field Naming Conventions

### Database Field Generation
Content Blocks automatically generates database field names based on:
- Vendor prefix (e.g., `punktde`)
- Content Block name (e.g., `accordion`)
- Field identifier (e.g., `title`)

Pattern: `{vendor}_{blockname}_{fieldname}`

### Collection Fields Special Case
Collections create separate database tables:
- Table name: `{vendor}_{collection_field_name}`
- Within collections, fields are accessed directly: `item.header` not `item.{vendor}_{blockname}_{collection}_header`

**Example:**
```yaml
- identifier: accordion_items  # Creates table: punktde_accordion_items
  type: Collection
  fields:
    - identifier: header       # Accessed as: item.header
    - identifier: content      # Accessed as: item.content
```

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

### Root Level Fields
```html
<!-- Access pattern for root fields -->
{data.{vendor}_{blockname}_{fieldname}}

<!-- Example -->
{data.punktde_accordion_title}
{data.punktde_accordion_allow_multiple}
```

### Collection Fields
```html
<!-- Collections are accessed directly -->
<f:for each="{data.{vendor}_{blockname}_{collection}}" as="item">
    {item.fieldname}  <!-- Direct access, no prefix -->
</f:for>

<!-- Example -->
<f:for each="{data.punktde_accordion_accordion_items}" as="item">
    <h3>{item.header}</h3>
    <div>{item.content}</div>
</f:for>
```

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

### Essential Elements
```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:cb="http://typo3.org/ns/TYPO3/CMS/ContentBlocks/ViewHelpers"
      xmlns:core="http://typo3.org/ns/TYPO3/CMS/Core/ViewHelpers">

<div class="content-block-backend-preview">
    <!-- Title with icon -->
    <strong>
        <core:icon identifier="content-{blockname}" size="small" />
        {blocktitle}
    </strong>
    
    <!-- Field summaries -->
    <f:if condition="{data.field}">
        <p><strong>Label:</strong> {data.field}</p>
    </f:if>
    
    <!-- Collection counts -->
    <f:if condition="{data.collection}">
        <p><strong>Items:</strong> {data.collection -> f:count()}</p>
    </f:if>
</div>
</html>
```

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

### Asset Inclusion
```html
<!-- External JavaScript -->
<f:asset.script identifier="script-id" src="https://cdn.example.com/script.js" external="true" defer="true" />

<!-- External CSS as Script (for Tailwind CDN) -->
<f:asset.script identifier="tailwind-css" src="https://cdn.tailwindcss.com" external="true" />
```

## Debugging Strategies

### 1. Field Name Discovery
```html
<!-- Debug output to see all available fields -->
<f:debug>{data}</f:debug>

<!-- Or selective debug -->
<f:debug title="Collection Items">{data.punktde_accordion_accordion_items}</f:debug>
```

### 2. Cache Clearing
```bash
# Always clear caches after Content Block changes
ddev exec typo3 cache:flush

# Or more aggressive
ddev exec rm -rf var/cache/*
```

### 3. Database Verification
```bash
# Check if table was created
ddev mysql -e "SHOW TABLES LIKE '%punktde%'"

# Inspect table structure
ddev mysql -e "DESCRIBE punktde_accordion_items"
```

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
**Solution:** 
```bash
ddev exec typo3 cache:flush
ddev exec rm -rf var/cache/*
```

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