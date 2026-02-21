# TYPO3 Backend Preview Templates Reference

## Basic Structure

### Minimal Template

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers">

<div class="content-block-backend-preview">
    <strong>{data.vendor_block_title}</strong>
</div>
</html>
```

### Full Template with Namespaces

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:cb="http://typo3.org/ns/TYPO3/CMS/ContentBlocks/ViewHelpers"
      xmlns:core="http://typo3.org/ns/TYPO3/CMS/Core/ViewHelpers">

<div class="content-block-backend-preview">
    <!-- Content here -->
</div>
</html>
```

## Common Elements

### Title with Icon

```html
<strong>
    <core:icon identifier="content-{blockname}" size="small" />
    {blocktitle}
</strong>
```

### Field Display with Condition

```html
<f:if condition="{data.vendor_block_field}">
    <p><strong>Label:</strong> {data.vendor_block_field}</p>
</f:if>
```

### Collection Count

```html
<f:if condition="{data.vendor_block_collection}">
    <p><strong>Items:</strong> {data.vendor_block_collection -> f:count()}</p>
</f:if>
```

### Collection Preview (First 3 Items)

```html
<f:if condition="{data.vendor_block_items}">
    <ul>
        <f:for each="{data.vendor_block_items}" as="item" iteration="iterator">
            <f:if condition="{iterator.index} < 3">
                <li>{item.title}</li>
            </f:if>
        </f:for>
    </ul>
    <f:if condition="{data.vendor_block_items -> f:count()} > 3">
        <p><em>...and {data.vendor_block_items -> f:count() - 3} more</em></p>
    </f:if>
</f:if>
```

## Complete Examples

### Accordion Backend Preview

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:core="http://typo3.org/ns/TYPO3/CMS/Core/ViewHelpers">

<div class="content-block-backend-preview">
    <strong>
        <core:icon identifier="content-accordion" size="small" />
        Accordion
    </strong>
    
    <f:if condition="{data.punktde_accordion_title}">
        <h4>{data.punktde_accordion_title}</h4>
    </f:if>
    
    <f:if condition="{data.punktde_accordion_accordion_items}">
        <p><strong>Panels:</strong> {data.punktde_accordion_accordion_items -> f:count()}</p>
        <ul style="margin: 0.5em 0;">
            <f:for each="{data.punktde_accordion_accordion_items}" as="item" iteration="iterator">
                <f:if condition="{iterator.index} < 3">
                    <li>{item.header}</li>
                </f:if>
            </f:for>
        </ul>
    </f:if>
    
    <f:if condition="{data.punktde_accordion_allow_multiple}">
        <p><small>✓ Multiple panels can be open</small></p>
    </f:if>
</div>
</html>
```

### Text Block Backend Preview

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:core="http://typo3.org/ns/TYPO3/CMS/Core/ViewHelpers">

<div class="content-block-backend-preview">
    <strong>
        <core:icon identifier="content-textblock" size="small" />
        Text Block
    </strong>
    
    <f:if condition="{data.vendor_textblock_headline}">
        <h4>{data.vendor_textblock_headline}</h4>
    </f:if>
    
    <f:if condition="{data.vendor_textblock_text}">
        <div style="max-height: 100px; overflow: hidden;">
            <f:format.stripTags>{data.vendor_textblock_text}</f:format.stripTags>
        </div>
    </f:if>
    
    <f:if condition="{data.vendor_textblock_image}">
        <p><small>📷 Image attached</small></p>
    </f:if>
</div>
</html>
```

## Styling Guidelines

### Recommended CSS Classes

```css
.content-block-backend-preview {
    /* Container styling */
}

.content-block-backend-preview h4 {
    margin: 0.5em 0;
    font-size: 1.1em;
}

.content-block-backend-preview ul {
    margin: 0.5em 0;
    padding-left: 1.5em;
}

.content-block-backend-preview small {
    color: #666;
}
```

## ViewHelpers Reference

### Icon ViewHelper

```html
<core:icon identifier="content-{name}" size="small|default|large" />
```

### Format ViewHelpers

```html
<!-- Strip HTML tags -->
<f:format.stripTags>{content}</f:format.stripTags>

<!-- Crop text -->
<f:format.crop maxCharacters="100">{content}</f:format.crop>

<!-- Format as HTML -->
<f:format.html>{content}</f:format.html>

<!-- Format date -->
<f:format.date format="d.m.Y">{date}</f:format.date>
```

### Count ViewHelper

```html
{collection -> f:count()}
```

## Best Practices

1. **Keep it concise** - Show essential information only
2. **Use icons** - Visual indicators for content type
3. **Show counts** - For collections, show number of items
4. **Preview content** - Show first few items or characters
5. **Indicate settings** - Show important configuration states
6. **Handle empty states** - Use conditions to avoid empty displays

## Related Documentation

- [Content Blocks Core Patterns](../content-blocks-core-patterns.md)
- [Field Naming Reference](./field-naming-reference.md)
