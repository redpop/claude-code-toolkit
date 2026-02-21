# TYPO3 CKEditor Configuration Guide (v13+)

## Overview

CKEditor 5 is the default Rich Text Editor (RTE) in TYPO3 v13, providing a modern, modular, and highly configurable editing experience. This guide covers configuration strategies, best practices, and common patterns for TYPO3 v13 and later.

## Quick Reference

- **Extension**: `EXT:rte_ckeditor`
- **Version**: CKEditor 5 (TYPO3 v13+)
- **Configuration**: YAML-based with Page TSconfig overrides
- **Processing**: Advanced Content Filter (ACF)

## Configuration Methods

### 1. YAML Configuration (Recommended)

Primary configuration method using YAML files:

```yaml
# EXT:my_sitepackage/Configuration/RTE/Default.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Plugins.yaml" }

editor:
  config:
    language: auto
    contentsLanguage: en
```

### 2. Page TSconfig

Override or extend YAML configurations:

```typoscript
# Select preset
RTE.default.preset = full

# Field-specific configuration
RTE.config.tt_content.bodytext.preset = minimal

# Content type specific
RTE.config.tt_content.bodytext.types.text.preset = custom
```

### 3. TCA Configuration

Direct field-level configuration:

```php
'bodytext' => [
    'config' => [
        'type' => 'text',
        'enableRichtext' => true,
        'richtextConfiguration' => 'default',
    ],
],
```

## Preset System

### Built-in Presets

- **default**: Standard configuration
- **minimal**: Basic formatting only
- **full**: All features enabled

### Creating Custom Presets

1. Create YAML configuration file:

```yaml
# EXT:my_sitepackage/Configuration/RTE/MyPreset.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }

editor:
  config:
    toolbar:
      items:
        - bold
        - italic
        - link
        - bulletedList
        - numberedList
```

1. Register in `ext_localconf.php`:

```php
$GLOBALS['TYPO3_CONF_VARS']['RTE']['Presets']['my_preset']
    = 'EXT:my_sitepackage/Configuration/RTE/MyPreset.yaml';
```

1. Use in Page TSconfig:

```typoscript
RTE.default.preset = my_preset
```

## YAML Configuration Structure

### Main Sections

```yaml
# Processing configuration
processing:
  # HTML parser rules
  allowTags: []
  denyTags: []
  
# Editor configuration  
editor:
  # CKEditor 5 configuration
  config:
    # Editor settings
    
  # External plugins
  externalPlugins: {}
```

### Editor Configuration Properties

```yaml
editor:
  config:
    # Language settings
    language: auto
    contentsLanguage: en
    
    # Styling
    contentsCss:
      - "EXT:my_sitepackage/Resources/Public/Css/rte.css"
    
    # Toolbar configuration
    toolbar:
      items: []
      shouldNotGroupWhenFull: false
    
    # Heading options
    heading:
      options:
        - { model: 'heading2', view: 'h2', title: 'Heading 2' }
        - { model: 'heading3', view: 'h3', title: 'Heading 3' }
    
    # Style definitions
    style:
      definitions:
        - { name: 'Lead', element: 'p', classes: ['lead'] }
    
    # Table configuration
    table:
      defaultHeadings: { rows: 1, columns: 0 }
      contentToolbar: ['tableColumn', 'tableRow']
    
    # Link configuration
    link:
      defaultProtocol: 'https://'
      decorators: []
```

## Toolbar Configuration

### Basic Toolbar

```yaml
editor:
  config:
    toolbar:
      items:
        - heading
        - '|'
        - bold
        - italic
        - link
        - '|'
        - bulletedList
        - numberedList
        - '|'
        - removeFormat
```

### Grouped Toolbar Items

```yaml
editor:
  config:
    toolbar:
      items:
        - bold
        - italic
        - { 
            label: 'More formatting',
            icon: 'threeVerticalDots',
            items: ['subscript', 'superscript', 'code']
          }
```

### Complete Toolbar Example

```yaml
editor:
  config:
    toolbar:
      items:
        # Block formatting
        - heading
        - style
        - '|'
        # Inline formatting
        - bold
        - italic
        - underline
        - strikethrough
        - '|'
        # Links and media
        - link
        - insertImage
        - mediaEmbed
        - '|'
        # Lists
        - bulletedList
        - numberedList
        - outdent
        - indent
        - '|'
        # Tables
        - insertTable
        - '|'
        # Special characters
        - specialCharacters
        - horizontalLine
        - '|'
        # Source and cleanup
        - sourceEditing
        - removeFormat
        - '|'
        # Undo/Redo
        - undo
        - redo
```

## Processing Configuration

### HTML Tag Allowlisting

```yaml
processing:
  allowTags:
    - div
    - span
    - iframe
    
  # Alternative: using htmlSupport
editor:
  config:
    htmlSupport:
      allow:
        - name: 'div'
          attributes: true
          classes: true
          styles: true
        - name: 'iframe'
          attributes: ['src', 'width', 'height', 'allowfullscreen']
```

### Custom Attributes and Classes

```yaml
editor:
  config:
    htmlSupport:
      allow:
        - name: 'p'
          classes: ['lead', 'text-muted', 'text-center']
        - name: 'a'
          attributes: ['target', 'rel', 'download']
          classes: ['btn', 'btn-primary', 'btn-secondary']
```

## Plugin Configuration

### Font Plugin

```yaml
editor:
  config:
    toolbar:
      items:
        - fontFamily
        - fontSize
        - fontColor
        - fontBackgroundColor
    
    fontFamily:
      options:
        - 'default'
        - 'Arial, sans-serif'
        - 'Courier New, monospace'
        - 'Georgia, serif'
    
    fontSize:
      options:
        - 'tiny'
        - 'small'
        - 'default'
        - 'big'
        - 'huge'
```

### Link Browser Integration

```yaml
editor:
  config:
    typo3link:
      options:
        allowedOptions: ['class', 'target', 'title', 'rel']
        allowedTypes: ['page', 'file', 'folder', 'url', 'email', 'telephone']
        
    link:
      decorators:
        openInNewTab:
          mode: 'manual'
          label: 'Open in new tab'
          attributes:
            target: '_blank'
            rel: 'noopener noreferrer'
```

### Custom Plugin Integration

```yaml
editor:
  config:
    importModules:
      - { 
          module: '@my-vendor/my-package/timestamp-plugin.js',
          exports: ['Timestamp']
        }
    
    toolbar:
      items:
        - timestamp
```

## Styles Configuration

### Define Custom Styles

```yaml
editor:
  config:
    style:
      definitions:
        # Paragraph styles
        - { name: 'Lead Text', element: 'p', classes: ['lead'] }
        - { name: 'Small Text', element: 'p', classes: ['small'] }
        
        # Inline styles
        - { name: 'Highlight', element: 'span', classes: ['highlight'] }
        - { name: 'Code', element: 'code' }
        
        # Block styles
        - { name: 'Info Box', element: 'div', classes: ['alert', 'alert-info'] }
        - { name: 'Warning Box', element: 'div', classes: ['alert', 'alert-warning'] }
```

### CSS for RTE Content

```css
/* EXT:my_sitepackage/Resources/Public/Css/rte.css */
.lead {
    font-size: 1.25rem;
    font-weight: 300;
}

.highlight {
    background-color: yellow;
    padding: 0.2em;
}

.alert {
    padding: 1rem;
    margin-bottom: 1rem;
    border: 1px solid transparent;
    border-radius: 0.25rem;
}

.alert-info {
    color: #0c5460;
    background-color: #d1ecf1;
    border-color: #bee5eb;
}
```

## Best Practices

### 1. Configuration Strategy

**Start with Core Configurations**

Always import core YAML files for security and compatibility:

```yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }
```

**Use Sitepackage for Custom Configuration**

Store all custom RTE configurations in your sitepackage:

```
EXT:my_sitepackage/
├── Configuration/
│   └── RTE/
│       ├── Default.yaml
│       ├── Simple.yaml
│       └── Full.yaml
```

### 2. Security Considerations

**Never Remove Processing.yaml**

The Processing.yaml file contains critical security measures:

```yaml
# ALWAYS include this
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
```

**Careful with HTML Tags**

Be selective when allowing HTML tags:

```yaml
# Good: Specific tags with controlled attributes
editor:
  config:
    htmlSupport:
      allow:
        - name: 'iframe'
          attributes: ['src', 'width', 'height']
          # Restrict src with regex if needed

# Avoid: Blanket permissions
# attributes: true  # Dangerous!
```

### 3. Performance Optimization

**Minimize External Resources**

```yaml
editor:
  config:
    # Load only necessary CSS
    contentsCss:
      - "EXT:my_sitepackage/Resources/Public/Css/rte-essentials.css"
    
    # Limit toolbar items
    toolbar:
      items: [essential-items-only]
```

**Use Lazy Loading for Plugins**

```yaml
editor:
  config:
    # Load plugins only when needed
    removePlugins:
      - PowerPaste
      - CloudServices
```

### 4. Testing and Debugging

**Test Configuration**

1. Clear all caches after changes
2. Test in different content elements
3. Verify frontend output
4. Check browser console for errors

**Debug Commands**

```bash
# Clear configuration cache
vendor/bin/typo3 cache:flush

# Check active configuration
vendor/bin/typo3 configuration:show RTE
```

## Common Patterns

### Minimal Editor for Comments

```yaml
# EXT:my_sitepackage/Configuration/RTE/Minimal.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }

editor:
  config:
    toolbar:
      items:
        - bold
        - italic
        - link
    
    removePlugins:
      - Image
      - Table
      - MediaEmbed
```

### Blog Post Editor

```yaml
# EXT:my_sitepackage/Configuration/RTE/Blog.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Plugins.yaml" }

editor:
  config:
    toolbar:
      items:
        - heading
        - '|'
        - bold
        - italic
        - link
        - '|'
        - bulletedList
        - numberedList
        - '|'
        - blockQuote
        - insertImage
        - mediaEmbed
        - '|'
        - insertTable
        - '|'
        - sourceEditing
    
    heading:
      options:
        - { model: 'heading2', view: 'h2' }
        - { model: 'heading3', view: 'h3' }
        - { model: 'heading4', view: 'h4' }
    
    image:
      toolbar: ['imageTextAlternative', 'imageStyle:full', 'imageStyle:side']
```

### Corporate Editor with Styles

```yaml
# EXT:my_sitepackage/Configuration/RTE/Corporate.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }

editor:
  config:
    contentsCss:
      - "EXT:my_sitepackage/Resources/Public/Css/corporate-rte.css"
    
    toolbar:
      items:
        - heading
        - style
        - '|'
        - bold
        - italic
        - '|'
        - link
        - '|'
        - bulletedList
        - numberedList
    
    style:
      definitions:
        - { name: 'Primary Button', element: 'a', classes: ['btn', 'btn-primary'] }
        - { name: 'Secondary Button', element: 'a', classes: ['btn', 'btn-secondary'] }
        - { name: 'Lead Paragraph', element: 'p', classes: ['lead'] }
        - { name: 'Disclaimer', element: 'p', classes: ['text-muted', 'small'] }
```

## Migration from Older Versions

### From TYPO3 v12 to v13

Key changes:

1. CKEditor 5 is now default (was CKEditor 4)
2. Different plugin architecture
3. New configuration syntax

Migration steps:

```yaml
# Old (v12)
YAML:
  editor:
    config:
      extraPlugins: 'wordcount'

# New (v13)
editor:
  config:
    importModules:
      - { module: '@ckeditor/ckeditor5-word-count/dist/index.js', exports: ['WordCount'] }
```

### Converting htmlArea RTE Configurations

Map old htmlArea settings to CKEditor:

```typoscript
# Old htmlArea
RTE.default {
  showButtons = bold, italic, link
  hideButtons = *
}

# New CKEditor (Page TSconfig)
RTE.default.preset = my_custom_preset
```

## Troubleshooting

### Common Issues

**RTE Not Loading**

- Clear all caches
- Check browser console for JavaScript errors
- Verify YAML syntax
- Ensure preset is registered

**Styles Not Showing**

- Verify CSS file path
- Clear browser cache
- Check style definitions syntax
- Ensure classes are allowed in processing

**Content Stripped on Save**

- Check processing configuration
- Verify allowed tags
- Review htmlSupport settings
- Check Page TSconfig overrides

### Debug Checklist

1. ✓ YAML syntax valid
2. ✓ Preset registered in ext_localconf.php
3. ✓ Cache cleared
4. ✓ Browser cache cleared
5. ✓ Console errors checked
6. ✓ Processing configuration reviewed
7. ✓ Field TCA configuration correct

## Resources

- [Official TYPO3 RTE CKEditor Documentation](https://docs.typo3.org/c/typo3/cms-rte-ckeditor/13.4/en-us/)
- [CKEditor 5 Documentation](https://ckeditor.com/docs/ckeditor5/latest/)
- [TYPO3 Core RTE Configurations](https://github.com/TYPO3/typo3/tree/main/typo3/sysext/rte_ckeditor/Configuration/RTE)

## Related Documentation

- [Sitepackage Configuration Guide](./sitepackage-configuration-guide.md)
- [CKEditor Examples Reference](./references/ckeditor-examples-reference.md)
- [Field Naming Reference](./references/field-naming-reference.md)
