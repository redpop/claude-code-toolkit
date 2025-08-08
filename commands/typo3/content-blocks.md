---
description: Generate TYPO3 Content Blocks v1.3 with modern field configurations
argument-hint: "[name] [--type=element|page] [--fields=...] [--sitepackage=path]"
mcp-enhanced: mcp__context7__get-library-docs
documentation-sources:
  - https://docs.typo3.org/p/content-blocks/content-blocks/main/en-us/
  - https://github.com/TYPO3-Initiatives/content-blocks
---

# TYPO3 Content Blocks Generator

Generates Content Blocks v1.3 compatible configurations for TYPO3 v13.4.

## Usage

```bash
/prefix:typo3:content-blocks [name] [options]
```

## Documentation & Context Enhancement

**CHECK FOR ENHANCED DOCUMENTATION ACCESS:**

1. **If Context7 MCP is available**: 
   - Use `mcp__context7__resolve-library-id "TYPO3 Content Blocks"`
   - Then `mcp__context7__get-library-docs` for latest API documentation
   - This provides up-to-date field types, configurations, and best practices

2. **Reference modular documentation**:
   - Core patterns: `/knowledge-base/typo3/content-blocks-core-patterns.md`
   - UI patterns: `/knowledge-base/ui-patterns/[pattern-name].md`
   - Framework integration: `/knowledge-base/frameworks/[framework]-integration.md`

3. **Fallback to embedded knowledge**:
   - Use the field configurations defined in this command
   - Reference official documentation URLs provided above

## Command Workflow

Parse the arguments from $ARGUMENTS to extract:

- Block name (e.g., "hero-section", "testimonial-slider")
- Type: element (default) or page
- Fields configuration
- SitePackage path (optional, defaults to ./packages/sitepackage)

If arguments are missing, ask the user for:

1. Content Block name (kebab-case)
2. Type (Content Element or Page Type)
3. Vendor prefix
4. Title and description
5. Fields to include

## Content Element Structure

For Content Elements, create:

```
ContentBlocks/ContentElements/{name}/
├── config.yaml
├── assets/
│   └── icon.svg
├── language/
│   └── labels.xlf
└── templates/
    ├── frontend.html
    └── backend-preview.html
```

### config.yaml for Content Element

```yaml
name: {vendor}/{name}
title: '{title}'
description: '{description}'
group: common
prefixFields: true
prefixType: vendor
fields:
  # Dynamic field generation based on user input
```

## Page Type Structure

For Page Types, create:

```
ContentBlocks/PageTypes/{name}/
├── config.yaml
├── assets/
│   ├── icon.svg
│   └── icon-hide-in-menu.svg
├── language/
│   └── labels.xlf
└── templates/
    ├── backend-preview.html
    └── README.md
```

### config.yaml for Page Type

```yaml
name: {vendor}/{name}
title: '{title}'
description: '{description}'
typeName: {generated_doktype}  # Generate unique doktype
group: default
prefixFields: true
prefixType: full
fields:
  # Dynamic field generation based on user input
```

## Field Type Templates

Based on the --fields parameter or interactive input, generate appropriate field configurations:

### Text Field

```yaml
- identifier: { field_name }
  type: Text
  label: "{label}"
  description: "{description}"
  placeholder: "{placeholder}"
  required: { true|false }
  max: { max_length }
```

### Textarea with RTE

```yaml
- identifier: { field_name }
  type: Textarea
  label: "{label}"
  description: "{description}"
  enableRichtext: true
  richtextConfiguration: default
  rows: 5
```

### Image/File Field

```yaml
- identifier: { field_name }
  type: File
  label: "{label}"
  description: "{description}"
  allowed: common-image-types
  maxitems: { number }
  minitems: { number }
  extendedPalette: true
  cropVariants:
    default:
      title: Default
      allowedAspectRatios:
        16:9:
          title: "16:9"
          value: 1.777777778
        4:3:
          title: "4:3"
          value: 1.333333333
        1:1:
          title: "1:1"
          value: 1
```

### Link Field

```yaml
- identifier: { field_name }
  type: Link
  label: "{label}"
  description: "{description}"
  allowedTypes: [page, url, email, telephone, file]
  required: { true|false }
```

### Select Field

```yaml
- identifier: { field_name }
  type: Select
  renderType: selectSingle
  label: "{label}"
  description: "{description}"
  default: "{default_value}"
  items:
    - label: "{option1}"
      value: "{value1}"
    - label: "{option2}"
      value: "{value2}"
```

### Collection Field (v1.3 feature)

```yaml
- identifier: {field_name}
  type: Collection
  label: '{label}'
  description: '{description}'
  labelField: title
  maxitems: {number}
  minitems: {number}
  restrictedContentTypes:  # v1.3: Child type restrictions
    - text
    - images
    - {vendor}/{custom-block}
  appearance:
    collapseAll: true
    useSortable: true
  fields:
    - identifier: title
      type: Text
      label: 'Title'
      required: true
    - identifier: description
      type: Textarea
      label: 'Description'
```

### Checkbox Toggle

```yaml
- identifier: { field_name }
  type: Checkbox
  renderType: checkboxToggle
  label: "{label}"
  default: { 0|1 }
```

### DateTime Field

```yaml
- identifier: { field_name }
  type: DateTime
  label: "{label}"
  description: "{description}"
  format: datetime # or 'date' or 'time'
  dbType: datetime
  default: "{default_value}"
```

### Number Field

```yaml
- identifier: { field_name }
  type: Number
  label: "{label}"
  description: "{description}"
  format: integer # or 'decimal'
  default: { default_value }
  range:
    lower: { min }
    upper: { max }
```

## Template Files

### frontend.html (Content Element)

```html
<html
  data-namespace-typo3-fluid="true"
  xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
  xmlns:cb="http://typo3.org/ns/TYPO3/CMS/ContentBlocks/ViewHelpers"
>
  <div class="{name}-wrapper">
    <f:if condition="{data.{vendor}_{name}_title}">
      <h2>{data.{vendor}_{name}_title}</h2>
    </f:if>

    <f:if condition="{data.{vendor}_{name}_text}">
      <div class="text">
        <f:format.html>{data.{vendor}_{name}_text}</f:format.html>
      </div>
    </f:if>

    <f:if condition="{data.{vendor}_{name}_image}">
      <f:for each="{data.{vendor}_{name}_image}" as="image">
        <figure>
          <f:image image="{image}" width="800" height="600c" loading="lazy" />
          <f:if condition="{image.alternative}">
            <figcaption>{image.alternative}</figcaption>
          </f:if>
        </figure>
      </f:for>
    </f:if>

    <f:if condition="{data.{vendor}_{name}_link}">
      <cb:link data="{data.{vendor}_{name}_link}" class="btn btn-primary">
        {data.{vendor}_{name}_link_title -> f:or(alternative: 'Read more')}
      </cb:link>
    </f:if>
  </div>
</html>
```

### backend-preview.html

```html
<html
  data-namespace-typo3-fluid="true"
  xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
  xmlns:cb="http://typo3.org/ns/TYPO3/CMS/ContentBlocks/ViewHelpers"
  xmlns:core="http://typo3.org/ns/TYPO3/CMS/Core/ViewHelpers"
>
  <div class="content-block-backend-preview">
    <strong>{title}</strong>

    <f:if condition="{data.{vendor}_{name}_title}">
      <p><strong>Title:</strong> {data.{vendor}_{name}_title}</p>
    </f:if>

    <f:if condition="{data.{vendor}_{name}_text}">
      <p>
        <strong>Text:</strong>
        <f:format.crop maxCharacters="100">
          <f:format.stripTags>{data.{vendor}_{name}_text}</f:format.stripTags>
        </f:format.crop>
      </p>
    </f:if>

    <f:if condition="{data.{vendor}_{name}_image}">
      <p>
        <strong>Images:</strong> {data.{vendor}_{name}_image -> f:count()}
        file(s)
      </p>
    </f:if>
  </div>
</html>
```

### labels.xlf

```xml
<?xml version="1.0" encoding="UTF-8"?>
<xliff version="1.2" xmlns="urn:oasis:names:tc:xliff:document:1.2">
    <file source-language="en" datatype="plaintext" original="labels.xlf" date="{date}">
        <header/>
        <body>
            <trans-unit id="title">
                <source>{title}</source>
            </trans-unit>
            <trans-unit id="description">
                <source>{description}</source>
            </trans-unit>
            <!-- Dynamic field labels based on configuration -->
        </body>
    </file>
</xliff>
```

### icon.svg

```svg
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor">
    <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z"/>
</svg>
```

## Page Type Additional Files

### README.md (for Page Types)

```markdown
# Template Information

## Frontend Template Location

The frontend template for this Page Type is **NOT** located in this directory.

Due to FLUIDTEMPLATE usage (Content Blocks Page Types are not compatible with PAGEVIEW),
the frontend template is located at:
```

/packages/sitepackage/Resources/Private/Templates/{TemplateName}.html

````

## TypoScript Configuration

Add to your page.typoscript:

```typoscript
page.10 = FLUIDTEMPLATE
page.10 {
    templateName.cObject = CASE
    templateName.cObject {
        key.field = doktype
        {doktype}.value = {TemplateName}
    }
}
````

````

Also create the corresponding Fluid template in:
`Resources/Private/Templates/{TemplateName}.html`

## Special Field Configurations (v1.3 Features)

### Collection with Child Type Restrictions
```yaml
- identifier: content_elements
  type: Collection
  label: 'Content Elements'
  foreign_table: tt_content
  restrictedContentTypes:  # NEW in v1.3
    - text
    - textpic
    - {vendor}/hero
    - {vendor}/slider
````

### Default Configurations (content-blocks.yaml)

Create a `content-blocks.yaml` in the extension root:

```yaml
defaults:
  contentElements:
    saveAndClose: true
    group: common
    prefixFields: true
    prefixType: vendor
  pageTypes:
    doktype: 200 # Starting doktype for page types
```

### File Type Definitions

For custom file field configurations, use overrideType:

```yaml
- identifier: image
  type: File
  overrideType:
    image:
      - identifier: image_overlay_palette
        type: Palette
        fields:
          - identifier: alternative
            useExistingField: true
          - identifier: custom_field
            type: Text
            label: "Custom metadata"
```

## Success Message

```
✅ Content Block created successfully!

📁 Location: {path}/ContentBlocks/{type}/{name}/
📦 Name: {vendor}/{name}
🎯 Type: {Content Element|Page Type}
📚 Fields: {field_count} fields configured

Next steps:
1. Clear TYPO3 caches:
   vendor/bin/typo3 cache:flush

2. {For Page Types: Update your page.typoscript with the template mapping}

3. Test in TYPO3 Backend:
   - {Content Element: Add via "New Content Element" wizard}
   - {Page Type: Create new page with this type}

4. Customize templates as needed

Happy content building! 🎨
```

## Interactive Mode

If no arguments provided, guide the user through:

1. Choose type: Content Element or Page Type
2. Enter vendor prefix
3. Enter block name
4. Enter title and description
5. Add fields interactively:
   - Field identifier
   - Field type (show available types)
   - Field label and description
   - Required/optional
   - Type-specific options
6. Generate icon (use default or custom)
7. Review and confirm generation

## Error Handling

- Check if ContentBlocks directory exists
- Validate vendor/name format
- Check for duplicate block names
- Ensure valid field identifiers (no spaces, lowercase)
- Generate unique doktypes for page types (based on timestamp)
