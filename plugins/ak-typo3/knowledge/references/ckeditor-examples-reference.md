# TYPO3 CKEditor Examples Reference

## Quick Start Examples

### Minimal RTE Setup

```yaml
# EXT:my_sitepackage/Configuration/RTE/Minimal.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }

editor:
  config:
    toolbar:
      items: [bold, italic, link]
```

Register in `ext_localconf.php`:

```php
$GLOBALS['TYPO3_CONF_VARS']['RTE']['Presets']['minimal'] 
    = 'EXT:my_sitepackage/Configuration/RTE/Minimal.yaml';
```

Use in Page TSconfig:

```typoscript
RTE.default.preset = minimal
```

## Preset Configuration Examples

### Standard Content Editor

```yaml
# EXT:my_sitepackage/Configuration/RTE/Standard.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }

editor:
  config:
    toolbar:
      items:
        - heading
        - '|'
        - bold
        - italic
        - underline
        - '|'
        - link
        - '|'
        - bulletedList
        - numberedList
        - '|'
        - outdent
        - indent
        - '|'
        - specialCharacters
        - removeFormat
        - '|'
        - undo
        - redo
    
    heading:
      options:
        - { model: 'paragraph', title: 'Paragraph' }
        - { model: 'heading2', view: 'h2', title: 'Heading 2' }
        - { model: 'heading3', view: 'h3', title: 'Heading 3' }
        - { model: 'heading4', view: 'h4', title: 'Heading 4' }
```

### News Article Editor

```yaml
# EXT:my_sitepackage/Configuration/RTE/News.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Plugins.yaml" }

editor:
  config:
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
        - '|'
        - blockQuote
        - insertImage
        - mediaEmbed
        - insertTable
        - '|'
        - sourceEditing
        - removeFormat
    
    heading:
      options:
        - { model: 'paragraph', title: 'Paragraph' }
        - { model: 'heading2', view: 'h2', title: 'Heading 2' }
        - { model: 'heading3', view: 'h3', title: 'Heading 3' }
    
    style:
      definitions:
        - { name: 'Lead', element: 'p', classes: ['lead'] }
        - { name: 'Author', element: 'p', classes: ['author'] }
        - { name: 'Date', element: 'p', classes: ['date'] }
    
    image:
      styles:
        options:
          - 'inline'
          - 'alignLeft'
          - 'alignRight'
          - 'alignCenter'
      resizeOptions:
        - { name: 'resizeImage:original', value: null, label: 'Original' }
        - { name: 'resizeImage:50', value: '50', label: '50%' }
        - { name: 'resizeImage:75', value: '75', label: '75%' }
      toolbar:
        - 'imageStyle:inline'
        - 'imageStyle:alignLeft'
        - 'imageStyle:alignRight'
        - 'imageStyle:alignCenter'
        - '|'
        - 'imageTextAlternative'
        - 'resizeImage'
```

## Toolbar Configuration Examples

### Dropdown Groups

```yaml
editor:
  config:
    toolbar:
      items:
        - heading
        - '|'
        - bold
        - italic
        - {
            label: 'Text formatting',
            icon: 'text',
            items: [underline, strikethrough, subscript, superscript, code]
          }
        - '|'
        - {
            label: 'Insert',
            icon: 'plus',
            items: [link, insertImage, insertTable, horizontalLine, specialCharacters]
          }
```

### Multi-Row Toolbar

```yaml
editor:
  config:
    toolbar:
      items:
        - [heading, style]
        - ['|']
        - [bold, italic, underline, strikethrough]
        - ['|']
        - [link, insertImage, mediaEmbed]
        - ['|']
        - [bulletedList, numberedList, outdent, indent]
        - ['|']
        - [blockQuote, insertTable, horizontalLine]
        - ['|']
        - [undo, redo, removeFormat, sourceEditing]
      shouldNotGroupWhenFull: true
```

## Page TSconfig Examples

### Field-Specific Configuration

```typoscript
# Different presets for different fields
RTE {
  config {
    # Teaser field - minimal editor
    tt_content {
      teaser {
        preset = minimal
      }
    }
    
    # Bodytext field - standard editor
    tt_content {
      bodytext {
        preset = default
        
        # Override specific types
        types {
          text {
            preset = standard
          }
          textmedia {
            preset = full
          }
        }
      }
    }
    
    # News extension
    tx_news_domain_model_news {
      bodytext {
        preset = news
      }
      teaser {
        preset = minimal
      }
    }
  }
}
```

### Override Toolbar Items

```typoscript
# Add/remove toolbar items via TSconfig
RTE.default {
  editor {
    config {
      toolbar {
        # Remove specific items
        removeItems = uploadImage, fontFamily
        
        # Add items
        addItems = fontSize, fontColor
      }
    }
  }
}
```

## HTML Support Examples

### Allow Custom HTML Tags

```yaml
editor:
  config:
    htmlSupport:
      allow:
        # Allow div with all attributes and classes
        - name: 'div'
          attributes: true
          classes: true
          styles: true
        
        # Allow iframe with specific attributes
        - name: 'iframe'
          attributes:
            - src
            - width
            - height
            - frameborder
            - allowfullscreen
        
        # Allow custom web components
        - name: 'my-component'
          attributes: ['data-*', 'id', 'class']
        
        # Allow Font Awesome icons
        - name: 'i'
          classes: ['fa-*', 'fas', 'far', 'fab']
```

### Allow Data Attributes

```yaml
editor:
  config:
    htmlSupport:
      allow:
        - name: 'div'
          attributes:
            - 'data-*'
            - 'id'
          classes: true
        
        - name: 'span'
          attributes:
            - pattern:
                name: 'data-tooltip-*'
            - 'title'
```

## Style Definitions Examples

### Bootstrap Styles

```yaml
editor:
  config:
    style:
      definitions:
        # Text colors
        - { name: 'Primary Text', element: 'span', classes: ['text-primary'] }
        - { name: 'Secondary Text', element: 'span', classes: ['text-secondary'] }
        - { name: 'Success Text', element: 'span', classes: ['text-success'] }
        - { name: 'Danger Text', element: 'span', classes: ['text-danger'] }
        - { name: 'Warning Text', element: 'span', classes: ['text-warning'] }
        - { name: 'Info Text', element: 'span', classes: ['text-info'] }
        
        # Alerts
        - { name: 'Info Alert', element: 'div', classes: ['alert', 'alert-info'] }
        - { name: 'Warning Alert', element: 'div', classes: ['alert', 'alert-warning'] }
        - { name: 'Danger Alert', element: 'div', classes: ['alert', 'alert-danger'] }
        - { name: 'Success Alert', element: 'div', classes: ['alert', 'alert-success'] }
        
        # Buttons
        - { name: 'Primary Button', element: 'a', classes: ['btn', 'btn-primary'] }
        - { name: 'Secondary Button', element: 'a', classes: ['btn', 'btn-secondary'] }
        - { name: 'Success Button', element: 'a', classes: ['btn', 'btn-success'] }
        
        # Typography
        - { name: 'Lead', element: 'p', classes: ['lead'] }
        - { name: 'Small Text', element: 'small', classes: [] }
        - { name: 'Blockquote Footer', element: 'footer', classes: ['blockquote-footer'] }
```

### Custom Corporate Styles

```yaml
editor:
  config:
    style:
      definitions:
        # Company specific styles
        - { name: 'Company Headline', element: 'h2', classes: ['company-headline'] }
        - { name: 'Subtitle', element: 'p', classes: ['subtitle'] }
        - { name: 'Highlight Box', element: 'div', classes: ['highlight-box'] }
        - { name: 'Call to Action', element: 'div', classes: ['cta-box'] }
        - { name: 'Disclaimer', element: 'p', classes: ['disclaimer', 'small'] }
        - { name: 'Product Name', element: 'span', classes: ['product-name'] }
        - { name: 'Price Tag', element: 'span', classes: ['price-tag'] }
```

## Link Configuration Examples

### Link Browser with Custom Classes

```yaml
editor:
  config:
    typo3link:
      options:
        allowedOptions: ['class', 'target', 'title', 'rel']
        classesAnchor:
          page:
            - { name: 'Internal Link', value: 'internal-link' }
            - { name: 'Navigation Link', value: 'nav-link' }
          file:
            - { name: 'Download', value: 'download' }
            - { name: 'PDF Document', value: 'pdf-link' }
          url:
            - { name: 'External Link', value: 'external-link' }
            - { name: 'Partner Link', value: 'partner-link' }
          email:
            - { name: 'Email Contact', value: 'email-link' }
    
    link:
      decorators:
        openInNewTab:
          mode: 'manual'
          label: 'Open in new tab'
          attributes:
            target: '_blank'
            rel: 'noopener noreferrer'
        downloadLink:
          mode: 'manual'
          label: 'Force download'
          attributes:
            download: 'download'
```

### Auto-Link Protocol

```yaml
editor:
  config:
    link:
      defaultProtocol: 'https://'
      addTargetToExternalLinks: true
```

## Table Configuration Examples

### Advanced Table Options

```yaml
editor:
  config:
    table:
      contentToolbar:
        - tableColumn
        - tableRow
        - mergeTableCells
        - tableCellProperties
        - tableProperties
      
      tableProperties:
        borderColors:
          - { color: 'hsl(0, 0%, 0%)', label: 'Black' }
          - { color: 'hsl(0, 0%, 50%)', label: 'Grey' }
          - { color: 'hsl(0, 0%, 100%)', label: 'White' }
        backgroundColors:
          - { color: 'hsl(0, 0%, 90%)', label: 'Light grey' }
          - { color: 'hsl(0, 0%, 100%)', label: 'White' }
      
      tableCellProperties:
        borderColors: [...]
        backgroundColors: [...]
```

## Font Configuration Examples

### Custom Font Families

```yaml
editor:
  config:
    fontFamily:
      options:
        - 'default'
        - 'Arial, Helvetica, sans-serif'
        - '"Courier New", Courier, monospace'
        - 'Georgia, serif'
        - '"Lucida Sans Unicode", "Lucida Grande", sans-serif'
        - 'Tahoma, Geneva, sans-serif'
        - '"Times New Roman", Times, serif'
        - '"Trebuchet MS", Helvetica, sans-serif'
        - 'Verdana, Geneva, sans-serif'
      supportAllValues: true
    
    fontSize:
      options:
        - 'tiny'
        - 'small'
        - 'default'
        - 'big'
        - 'huge'
        - { title: '8pt', model: '8pt' }
        - { title: '10pt', model: '10pt' }
        - { title: '12pt', model: '12pt' }
        - { title: '14pt', model: '14pt' }
        - { title: '18pt', model: '18pt' }
        - { title: '24pt', model: '24pt' }
        - { title: '36pt', model: '36pt' }
```

## Plugin Examples

### Word Count Plugin

```yaml
editor:
  config:
    toolbar:
      items:
        - '|'
        - wordCount
    
    wordCount:
      displayWords: true
      displayCharacters: true
```

### Source Editing Configuration

```yaml
editor:
  config:
    sourceEditing:
      allowCollaborationFeatures: true
    
    htmlSupport:
      allow:
        - name: 'script'
          attributes: false  # Security: Don't allow scripts
        - name: 'style'
          attributes: false  # Security: Don't allow inline styles
```

## Processing Configuration Examples

### Strict HTML Processing

```yaml
processing:
  # Allow only specific tags
  allowTags:
    - p
    - h2
    - h3
    - h4
    - ul
    - ol
    - li
    - a
    - strong
    - em
    - blockquote
  
  # Explicitly deny dangerous tags
  denyTags:
    - script
    - style
    - iframe
    - object
    - embed
    - form
    - input
```

### Liberal HTML Processing

```yaml
processing:
  # Allow most HTML tags
  allowTags: '*'
  
  # But still deny dangerous ones
  denyTags:
    - script
    - style
    - meta
    - link
    
  # Allow attributes
  allowAttributes:
    - class
    - id
    - title
    - data-*
```

## Multi-Language Configuration

### Language-Specific Settings

```yaml
editor:
  config:
    # Auto-detect from TYPO3 backend
    language: auto
    
    # Or set specific language
    language: de
    
    # Content language (for spell checking)
    contentsLanguage: de
    
    # Text direction
    language:
      textPartLanguage:
        - { languageCode: 'ar', textDirection: 'rtl' }
        - { languageCode: 'he', textDirection: 'rtl' }
```

## Complete Example: E-Commerce Product Editor

```yaml
# EXT:my_shop/Configuration/RTE/Product.yaml
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }

editor:
  config:
    contentsCss:
      - "EXT:my_shop/Resources/Public/Css/product-rte.css"
    
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
        - '|'
        - insertTable
        - '|'
        - specialCharacters
        - removeFormat
    
    heading:
      options:
        - { model: 'paragraph', title: 'Paragraph' }
        - { model: 'heading3', view: 'h3', title: 'Section' }
        - { model: 'heading4', view: 'h4', title: 'Subsection' }
    
    style:
      definitions:
        # Product specific styles
        - { name: 'Feature', element: 'li', classes: ['product-feature'] }
        - { name: 'Specification', element: 'div', classes: ['product-spec'] }
        - { name: 'Price', element: 'span', classes: ['product-price'] }
        - { name: 'Discount', element: 'span', classes: ['product-discount'] }
        - { name: 'Stock Status', element: 'span', classes: ['stock-status'] }
        - { name: 'Warranty Info', element: 'div', classes: ['warranty-info'] }
        - { name: 'Shipping Note', element: 'p', classes: ['shipping-note'] }
    
    table:
      defaultHeadings: { rows: 1, columns: 1 }
      contentToolbar: ['tableColumn', 'tableRow']
    
    htmlSupport:
      allow:
        # Allow product-specific attributes
        - name: 'div'
          attributes: ['data-product-*', 'data-sku']
          classes: ['product-*']
        - name: 'span'
          attributes: ['data-price', 'data-currency']
          classes: ['price-*', 'stock-*']
```

## TCA Integration Examples

### Field Configuration

```php
// Basic RTE field
'description' => [
    'label' => 'Description',
    'config' => [
        'type' => 'text',
        'enableRichtext' => true,
        'richtextConfiguration' => 'default',
    ],
],

// Custom preset for field
'product_details' => [
    'label' => 'Product Details',
    'config' => [
        'type' => 'text',
        'enableRichtext' => true,
        'richtextConfiguration' => 'product',
        'rows' => 15,
    ],
],

// Conditional RTE configuration
'content' => [
    'label' => 'Content',
    'config' => [
        'type' => 'text',
        'enableRichtext' => true,
    ],
    'onChange' => [
        'reload' => true,
    ],
],
```

## Debugging Examples

### Enable Debug Mode

```yaml
editor:
  config:
    # Show toolbar item names on hover
    toolbar:
      shouldNotGroupWhenFull: true
      viewportTopOffset: 100
    
    # Enable browser spell checker
    disableNativeSpellChecker: false
    
    # Log configuration to console
    debug: true
```

### Test Configuration

```typoscript
# Test different presets quickly
RTE.default.preset = minimal
#RTE.default.preset = default
#RTE.default.preset = full
#RTE.default.preset = custom

# Debug output
RTE.default.showButtons = *
```

## Related Documentation

- [CKEditor Configuration Guide](../ckeditor-configuration-guide.md)
- [Sitepackage Configuration Guide](../sitepackage-configuration-guide.md)
- [Field Naming Reference](./field-naming-reference.md)
