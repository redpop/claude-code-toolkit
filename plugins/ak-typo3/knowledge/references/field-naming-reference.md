# TYPO3 Content Blocks Field Naming Reference

## Field Naming Pattern

### Basic Pattern

```
{vendor}_{blockname}_{fieldname}
```

### Examples

- `punktde_accordion_title`
- `punktde_textblock_content`
- `vendor_slider_speed`

## Database Field Generation Rules

### Root Level Fields

Fields at the root level of a Content Block are automatically prefixed:

**Configuration:**

```yaml
name: vendor/accordion
fields:
  - identifier: title
    type: Text
```

**Database field:** `vendor_accordion_title`

**Template access:**

```html
{data.vendor_accordion_title}
```

## Collection Fields Special Rules

### Table Creation

Collections create separate database tables:

**Pattern:** `{vendor}_{collection_identifier}`

**Example:**

```yaml
- identifier: accordion_items  # Creates table: vendor_accordion_items
  type: Collection
```

### Field Access in Collections

Within collections, fields are accessed directly WITHOUT prefix:

**Configuration:**

```yaml
- identifier: accordion_items
  type: Collection
  fields:
    - identifier: header    # Stored as: header
    - identifier: content   # Stored as: content
```

**Template access:**

```html
<f:for each="{data.vendor_accordion_accordion_items}" as="item">
    {item.header}   <!-- Direct access, NO prefix -->
    {item.content}  <!-- Direct access, NO prefix -->
</f:for>
```

## Complete Access Pattern Reference

### Single Value Fields

```html
<!-- Root level field -->
{data.{vendor}_{blockname}_{fieldname}}

<!-- Example -->
{data.punktde_accordion_title}
{data.punktde_accordion_allow_multiple}
```

### Collection Fields

```html
<!-- Collection access -->
<f:for each="{data.{vendor}_{blockname}_{collection}}" as="item">
    {item.fieldname}  <!-- No prefix needed -->
</f:for>

<!-- Example -->
<f:for each="{data.punktde_accordion_accordion_items}" as="item">
    <h3>{item.header}</h3>
    <div>{item.content}</div>
</f:for>
```

### Nested Collections (if supported)

```html
<f:for each="{data.vendor_block_items}" as="item">
    {item.title}
    <f:for each="{item.subitems}" as="subitem">
        {subitem.text}
    </f:for>
</f:for>
```

## Debug Field Names

### Show All Available Fields

```html
<f:debug>{data}</f:debug>
```

### Show Specific Collection

```html
<f:debug title="Collection Items">{data.vendor_block_collection}</f:debug>
```

### Show Field Structure

```html
<f:for each="{data.vendor_block_items}" as="item" iteration="iterator">
    <f:if condition="{iterator.isFirst}">
        <f:debug title="Item Structure">{item}</f:debug>
    </f:if>
</f:for>
```

## Common Naming Mistakes

### ❌ Wrong Patterns

```yaml
# Too generic collection name
- identifier: items  # Creates: vendor_items (too generic!)

# Trying to access with prefix in collection
{item.vendor_block_items_header}  # WRONG!
```

### ✅ Correct Patterns

```yaml
# Descriptive collection name
- identifier: accordion_items  # Creates: vendor_accordion_items

# Direct access in collection
{item.header}  # CORRECT!
```

## Quick Reference Table

| Context | Pattern | Example |
|---------|---------|---------|
| Root field config | `identifier: fieldname` | `identifier: title` |
| Root field database | `{vendor}_{block}_{field}` | `punktde_accordion_title` |
| Root field template | `{data.vendor_block_field}` | `{data.punktde_accordion_title}` |
| Collection table | `{vendor}_{collection}` | `punktde_accordion_items` |
| Collection field | `fieldname` (no prefix) | `header`, `content` |
| Collection template | `{item.fieldname}` | `{item.header}` |

## Related Documentation

- [Content Blocks Core Patterns](../content-blocks-core-patterns.md)
- [Troubleshooting Matrix](../troubleshooting-matrix.md)
