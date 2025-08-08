# Content Blocks Shared Partials Configuration

## Overview
Content Blocks can use shared partials from the sitepackage to avoid redundancy and maintain consistency across the project. This is achieved through TypoScript configuration of `partialRootPaths`.

## Problem
By default, Content Blocks look for partials in their own template directories:
- `/vendor/punktde/sitepackage/ContentBlocks/ContentElements/{blockname}/templates/partials/`

This leads to:
- **Redundancy**: Same partials copied multiple times
- **Maintenance issues**: Updates need to be made in multiple places
- **Inconsistency**: Different versions of the same component

## Solution: Shared Partials via TypoScript

### 1. Configure TypoScript
Add to your sitepackage's TypoScript configuration (e.g., `ContentBlocks.typoscript`):

```typoscript
# Configure shared partial paths for ALL Content Blocks
lib.contentElement {
    partialRootPaths {
        # Higher numbers = higher priority (checked first)
        100 = EXT:sitepackage/Resources/Private/Partials/
    }
}

# Or configure for specific Content Blocks
tt_content {
    punktde_accordion {
        partialRootPaths {
            100 = EXT:sitepackage/Resources/Private/Partials/
        }
    }
    punktde_textblock {
        partialRootPaths {
            100 = EXT:sitepackage/Resources/Private/Partials/
        }
    }
}
```

### 2. Directory Structure
Organize shared partials in the sitepackage:

```
packages/sitepackage/
└── Resources/
    └── Private/
        └── Partials/
            └── Components/           # Shared components
                ├── Accordion/
                │   └── Accordion.html
                ├── TextBlock/
                │   └── TextBlock.html
                ├── Button/
                │   └── Button.html
                └── Card/
                    └── Card.html
```

### 3. Usage in Content Blocks
In Content Block templates (`frontend.html`):

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

### 4. Component Definition (Partial)
Create reusable components as standard Fluid partials:

```html
<html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      data-namespace-typo3-fluid="true">

<f:comment>
    Component: Accordion
    Parameters:
    - title (string, optional): Optional title above the accordion
    - items (array): Array of accordion items with header and content
    - firstExpanded (bool, default: false): Whether first panel is expanded by default
    - allowMultiple (bool, default: true): Allow multiple panels open simultaneously
    - class (string, optional): Additional CSS classes for wrapper
</f:comment>

<div class="accordion-wrapper {class}">
    <f:if condition="{title}">
        <h2>{title}</h2>
    </f:if>
    
    <f:for each="{items}" as="item" iteration="iterator">
        <div class="accordion-item">
            <button class="accordion-header">
                {item.header}
            </button>
            <div class="accordion-content">
                <f:format.html>{item.content}</f:format.html>
            </div>
        </div>
    </f:for>
</div>

</html>
```

## Benefits

1. **No Redundancy**: Components exist only once in the sitepackage
2. **Central Management**: Updates affect all Content Blocks using the component
3. **Consistency**: Same component markup across the entire project
4. **Flexibility**: Components can be used in:
   - Content Blocks
   - Page templates
   - Other partials
5. **TYPO3 13 Compatible**: Uses standard Fluid v4.3 partials (no experimental features)

## Path Resolution Order

TYPO3 checks paths in descending numerical order:
```
200 = EXT:my_extension/Resources/Private/Partials/  # Checked first
100 = EXT:sitepackage/Resources/Private/Partials/   # Checked second
10  = EXT:content_blocks/Resources/Private/Partials/ # Checked last
```

## Important Notes

### Fluid v4.3 Compatibility
- The `fc:component` syntax (`TYPO3\CMS\Fluid\ViewHelpers\Component`) does NOT exist in Fluid v4.3
- It's an experimental feature not yet available in TYPO3 13
- Use standard `f:render partial=""` instead

### Cache Clearing
Always clear caches after changing TypoScript configuration:
```bash
ddev exec typo3 cache:flush
```

### Error: "The Fluid template files could not be loaded"
This error indicates the partial path is not configured correctly. Check:
1. TypoScript configuration is loaded
2. Path in `partialRootPaths` is correct
3. Partial file exists at the specified location
4. Cache has been cleared

## Usage in Regular Templates

The same components can be used in page templates:

```html
<!-- In Page Templates -->
<f:render partial="Components/TextBlock/TextBlock" arguments="{
    title: 'My Title',
    text: '<p>My content</p>',
    image: myImage,
    link: myLink
}" />
```

## Migration from Duplicated Partials

1. Move one copy of the partial to `sitepackage/Resources/Private/Partials/Components/`
2. Add TypoScript configuration for `partialRootPaths`
3. Remove duplicated partials from Content Blocks directories
4. Clear caches
5. Test all Content Blocks

## Best Practices

1. **Naming Convention**: Use descriptive component names (e.g., `Accordion`, not `Acc`)
2. **Documentation**: Add component documentation as `f:comment` at the top of each partial
3. **Parameters**: Define clear parameter expectations in comments
4. **Defaults**: Use sensible defaults for optional parameters
5. **Atomic Design**: Consider organizing components by complexity:
   - `Partials/Components/Atoms/` (buttons, inputs)
   - `Partials/Components/Molecules/` (cards, nav items)
   - `Partials/Components/Organisms/` (headers, footers)

## Related Documentation

- [TYPO3 Fluid Structure Documentation](https://docs.typo3.org/other/typo3fluid/fluid/main/en-us/Usage/Structure.html#partials)
- [Content Blocks Core Patterns](./content-blocks-core-patterns.md)
- [TYPO3 Fluid Components](../commands/typo3/fluid-components.md)