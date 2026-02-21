# TYPO3 Content Blocks v13 Developer Reference

## Executive Summary

**Content Blocks** is the modern, declarative way to create content elements and page types in TYPO3 v13. Instead of complex TCA configurations, you define content structure in YAML and create Fluid templates.

**Key Benefits:**

- **YAML Configuration**: Define fields declaratively instead of PHP/TCA
- **Automatic Database**: Tables and TCA generated automatically  
- **Modern Templates**: Full Fluid ViewHelper support
- **Content Blocks v1.3**: Collection restrictions, defaults, enhanced ViewHelpers

**System Requirements:**

- TYPO3 v13.4+
- Content Blocks Extension v1.3+
- Installation: `composer require friendsoftypo3/content-blocks:^1.3`

**Essential Concept:**
`YAML Configuration` + `Fluid Template` = `Functional Content Block`

---

## Quickstart: Hello World Content Block

Create your first Content Block in 5 minutes:

### 1. Create Directory Structure

```bash
ContentBlocks/ContentElements/simple-text/
├── config.yaml
├── templates/
│   ├── frontend.html
│   └── backend-preview.html
└── assets/
    └── icon.svg
```

### 2. Configuration (config.yaml)

```yaml
name: vendor/simple-text
title: Simple Text Block
description: Basic text content block
group: common
prefixFields: true
prefixType: vendor
fields:
  - identifier: headline
    type: Text
    label: Headline
    required: true
    max: 100
  - identifier: text
    type: Textarea
    label: Text Content
    enableRichtext: true
    rows: 5
```

### 3. Frontend Template (templates/frontend.html)

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers">

<div class="simple-text-block">
    <f:if condition="{data.vendor_simple_text_headline}">
        <h2>{data.vendor_simple_text_headline}</h2>
    </f:if>
    
    <f:if condition="{data.vendor_simple_text_text}">
        <div class="text-content">
            <f:format.html>{data.vendor_simple_text_text}</f:format.html>
        </div>
    </f:if>
</div>
</html>
```

### 4. Backend Preview (templates/backend-preview.html)

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:core="http://typo3.org/ns/TYPO3/CMS/Core/ViewHelpers">

<div>
    <p>
        <core:icon identifier="content-text" size="small" />
        <strong>Simple Text Block</strong>
    </p>
    
    <f:if condition="{data.vendor_simple_text_headline}">
        <p><strong>Headline:</strong> {data.vendor_simple_text_headline}</p>
    </f:if>
    
    <f:if condition="{data.vendor_simple_text_text}">
        <p>
            <strong>Text:</strong>
            <f:format.crop maxCharacters="80">
                <f:format.stripTags>{data.vendor_simple_text_text}</f:format.stripTags>
            </f:format.crop>
        </p>
    </f:if>
</div>
</html>
```

### 5. Activation

```bash
# Clear caches
vendor/bin/typo3 cache:flush

# The Content Block is now available in TYPO3 Backend:
# Content → Add Content → Simple Text Block
```

**Key Field Naming Pattern:**

- Configuration: `identifier: headline`
- Database: `vendor_simple_text_headline`
- Template: `{data.vendor_simple_text_headline}`

---

## Essential Patterns

The 5 most important field types you need to know:

### 1. Text Field

```yaml
- identifier: title
  type: Text
  label: Title
  required: true
  max: 100
```

### 2. File/Image Field  

```yaml
- identifier: image
  type: File
  label: Image
  allowed: common-image-types
  maxitems: 1
  cropVariants:
    default:
      title: Default
      allowedAspectRatios:
        16:9:
          value: 1.777777778
```

### 3. Collection Field

```yaml
- identifier: items
  type: Collection
  label: Items
  labelField: title
  fields:
    - identifier: title
      type: Text
    - identifier: description
      type: Textarea
```

### 4. Link Field

```yaml
- identifier: link
  type: Link
  label: Link
  allowedTypes: [page, url, email]
```

### 5. Select Field

```yaml
- identifier: layout
  type: Select
  renderType: selectSingle
  label: Layout
  items:
    - label: Standard
      value: standard
    - label: Compact
      value: compact
```

### Essential Template Patterns

**Field Access:**

```html
<!-- Root field: prefix required -->
{data.vendor_blockname_fieldname}

<!-- Collection field: no prefix -->
<f:for each="{data.vendor_blockname_items}" as="item">
    {item.title}  <!-- Direct access -->
</f:for>
```

**Always use conditions:**

```html
<f:if condition="{data.vendor_blockname_field}">
    <!-- Only render if field has content -->
</f:if>
```

**Image handling:**

```html
<f:image image="{image}" 
         width="800" 
         height="600c" 
         loading="lazy" />
```

---

## Navigation Hub

**For specific topics, see these sections:**

- **Hero Section Example** → [Section 11: Practical Examples](#practical-examples)
- **All Field Types** → [Section 3: Field Types Reference](#field-types-reference)
- **Backend Previews** → [Section 8: Backend Preview Templates](#backend-preview-templates)
- **Debugging Issues** → [Section 12: Troubleshooting Matrix](#troubleshooting-matrix)
- **Field Naming Rules** → [Section 5: Field Naming & Database Generation](#field-naming--database-generation)
- **Fluid Components** → [Section 6: Fluid v4 Components Integration](#fluid-v4-components-integration)
- **Performance Tips** → [Section 10: Best Practices & Patterns](#best-practices--patterns)
- **Cache Commands** → [Section 9: Debugging & Cache Handling](#debugging--cache-handling)

---

## TYPO3 v13 Content Blocks Fundamentals

### What are Content Blocks?

Content Blocks is the modern way to create content elements and page types in TYPO3 v13. It replaces older approaches like Mask, DCE, or custom TCA configurations with a declarative YAML-based approach.

### Key Advantages

- **Declarative Configuration**: Define content structure in YAML
- **Automatic TCA Generation**: No manual TCA configuration
- **Database Schema Management**: Automatic table creation and updates
- **Modern Templates**: Fluid-based with full ViewHelper support
- **Backend Integration**: Automatic backend forms and previews
- **Translation Support**: Built-in multilingual capabilities

### System Requirements

- TYPO3 v13.4+ (recommended)
- Content Blocks Extension v1.3+
- PHP 8.1+

### Installation

```bash
composer require friendsoftypo3/content-blocks:^1.3
```

---

## Content Blocks v1.3 Features

### 1. Collection Child Type Restrictions (NEW)

Limit which content types can be used within collections:

```yaml
- identifier: content_sections
  type: Collection
  restrictedContentTypes:
    - text
    - textpic
    - vendor/hero
    - vendor/card-grid
```

### 2. Default Configurations

Set project-wide defaults in `content-blocks.yaml`:

```yaml
defaults:
  contentElements:
    saveAndClose: true
    group: common
    prefixFields: true
    prefixType: vendor
  pageTypes:
    doktype: 200
```

### 3. Core Page Type Re-definition

Override core page types with additional fields:

```yaml
name: vendor/shortcut-page
typeName: 4  # Redefine core shortcut page
fields:
  - identifier: custom_field
    type: Text
    label: Custom Field
```

### 4. Enhanced ViewHelpers

- `cb:link.editRecord` - Backend edit links
- Enhanced collection item handling
- Improved asset management helpers

---

## Field Types Reference

### Basic Fields

#### Text Field

```yaml
- identifier: headline
  type: Text
  label: Headline
  required: true
  max: 100
  placeholder: Enter headline
```

#### Textarea Field

```yaml
- identifier: description
  type: Textarea
  label: Description
  enableRichtext: true
  richtextConfiguration: default
  rows: 5
```

#### Number Field

```yaml
- identifier: columns
  type: Number
  label: Number of Columns
  format: integer
  default: 3
  range:
    lower: 1
    upper: 6
```

### Advanced Fields

#### File/Image Field

```yaml
- identifier: hero_image
  type: File
  label: Hero Image
  allowed: common-image-types
  maxitems: 1
  minitems: 1
  extendedPalette: true
  cropVariants:
    hero:
      title: Hero Crop
      allowedAspectRatios:
        16:9:
          title: "16:9 Widescreen"
          value: 1.777777778
        4:3:
          title: "4:3 Standard"
          value: 1.333333333
```

#### Link Field

```yaml
- identifier: cta_link
  type: Link
  label: Call to Action Link
  allowedTypes: [page, url, email, telephone]
  required: false
```

#### Select Field

```yaml
- identifier: layout
  type: Select
  renderType: selectSingle
  label: Layout Style
  default: standard
  items:
    - label: Standard Layout
      value: standard
    - label: Compact Layout
      value: compact
    - label: Full Width
      value: fullwidth
```

### Complex Fields

#### Collection Field (v1.3 Enhanced)

```yaml
- identifier: feature_items
  type: Collection
  label: Feature Items
  labelField: title
  minitems: 1
  maxitems: 6
  restrictedContentTypes:  # v1.3 feature
    - text
    - image
    - vendor/feature-card
  appearance:
    collapseAll: true
    useSortable: true
  fields:
    - identifier: title
      type: Text
      label: Feature Title
      required: true
    - identifier: description
      type: Textarea
      label: Feature Description
      rows: 3
    - identifier: icon
      type: Text
      label: Icon Class
      placeholder: fa-star
```

#### Checkbox Toggle

```yaml
- identifier: enable_animation
  type: Checkbox
  renderType: checkboxToggle
  label: Enable Animation
  default: 0
```

#### DateTime Field

```yaml
- identifier: event_date
  type: DateTime
  label: Event Date
  format: datetime
  dbType: datetime
  default: ""
```

---

## Template Development

### Frontend Template Structure

#### Basic Template

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:cb="http://typo3.org/ns/TYPO3/CMS/ContentBlocks/ViewHelpers">

<div class="hero-section">
    <f:if condition="{data.vendor_hero_headline}">
        <h1>{data.vendor_hero_headline}</h1>
    </f:if>
    
    <f:if condition="{data.vendor_hero_description}">
        <div class="description">
            <f:format.html>{data.vendor_hero_description}</f:format.html>
        </div>
    </f:if>
    
    <f:if condition="{data.vendor_hero_image}">
        <f:for each="{data.vendor_hero_image}" as="image">
            <figure>
                <f:image image="{image}" 
                         cropVariant="hero" 
                         width="1200" 
                         height="600c" 
                         loading="lazy" />
                <f:if condition="{image.alternative}">
                    <figcaption>{image.alternative}</figcaption>
                </f:if>
            </figure>
        </f:for>
    </f:if>
    
    <f:if condition="{data.vendor_hero_cta_link}">
        <cb:link data="{data.vendor_hero_cta_link}" class="btn btn-primary">
            {data.vendor_hero_cta_text -> f:or(alternative: 'Learn More')}
        </cb:link>
    </f:if>
</div>
</html>
```

#### Collection Iteration

```html
<f:if condition="{data.vendor_accordion_items}">
    <div class="accordion">
        <f:for each="{data.vendor_accordion_items}" as="item" iteration="iterator">
            <div class="accordion-item">
                <button class="accordion-header" 
                        data-target="item-{iterator.index}">
                    {item.title}
                </button>
                <div class="accordion-content" 
                     id="item-{iterator.index}">
                    <f:format.html>{item.content}</f:format.html>
                </div>
            </div>
        </f:for>
    </div>
</f:if>
```

### Shared Partials Configuration

Enable shared partials across Content Blocks:

**TypoScript Configuration:**

```typoscript
lib.contentElement {
    partialRootPaths {
        100 = EXT:sitepackage/Resources/Private/Partials/
    }
}
```

**Usage in Templates:**

```html
<f:render partial="Components/Card/Card" arguments="{
    title: item.title,
    description: item.description,
    image: item.image,
    link: item.link
}" />
```

---

## Field Naming & Database Generation

### Field Naming Pattern

**Root Level Fields:**

- Configuration: `identifier: title`
- Database: `{vendor}_{blockname}_{fieldname}`
- Template: `{data.vendor_blockname_title}`

**Example:**

```yaml
name: acme/hero-section
fields:
  - identifier: headline  # → acme_hero_section_headline
```

### Collection Special Rules

**Table Creation:**
Collections create separate database tables with pattern: `{vendor}_{collection_identifier}`

**Field Access:**
Within collections, fields are accessed WITHOUT prefix:

```yaml
- identifier: accordion_items  # Creates: vendor_accordion_items table
  type: Collection
  fields:
    - identifier: title    # Stored as: title
    - identifier: content  # Stored as: content
```

**Template Access:**

```html
<f:for each="{data.vendor_accordion_accordion_items}" as="item">
    {item.title}    <!-- Direct access, NO prefix -->
    {item.content}  <!-- Direct access, NO prefix -->
</f:for>
```

### Complete Access Patterns

| Context | Pattern | Example |
|---------|---------|---------|
| Root field config | `identifier: fieldname` | `identifier: title` |
| Root field database | `{vendor}_{block}_{field}` | `acme_hero_title` |
| Root field template | `{data.vendor_block_field}` | `{data.acme_hero_title}` |
| Collection table | `{vendor}_{collection}` | `acme_accordion_items` |
| Collection field | `fieldname` (no prefix) | `title`, `content` |
| Collection template | `{item.fieldname}` | `{item.title}` |

---

## Fluid v4 Components Integration

### Component-Based Content Blocks (TYPO3 v13.3+)

Leverage Fluid v4 Components for reusable UI patterns:

#### Content Block with Components

```html
<html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:cb="http://typo3.org/ns/TYPO3/CMS/ContentBlocks/ViewHelpers"
      xmlns:my="http://typo3.org/ns/Vendor/SitePackage/Components/ComponentCollection"
      data-namespace-typo3-fluid="true">

<f:layout name="Default" />

<f:section name="Main">
    <my:molecule.heroSection 
        headline="{data.vendor_hero_headline}"
        subheadline="{data.vendor_hero_subheadline}"
        variant="primary">
        
        <f:if condition="{data.vendor_hero_cta_link}">
            <f:slot name="actions">
                <my:atom.button 
                    href="{data.vendor_hero_cta_link.url}"
                    variant="primary"
                    size="large">
                    {data.vendor_hero_cta_text}
                </my:atom.button>
            </f:slot>
        </f:if>
        
        <f:if condition="{data.vendor_hero_image}">
            <f:slot name="media">
                <my:atom.responsiveImage 
                    image="{data.vendor_hero_image.0}"
                    cropVariant="hero" />
            </f:slot>
        </f:if>
    </my:molecule.heroSection>
</f:section>
</html>
```

#### Component Structure

```
packages/sitepackage/
├── Classes/
│   └── Components/
│       └── ComponentCollection.php
└── Resources/
    └── Private/
        └── Components/
            ├── Atom/
            │   ├── Button.html
            │   └── ResponsiveImage.html
            └── Molecule/
                └── HeroSection.html
```

#### Component Example (Atom/Button.html)

```html
<f:argument name="href" type="string" optional="{true}" />
<f:argument name="variant" type="string" optional="{true}" default="primary" />
<f:argument name="size" type="string" optional="{true}" default="medium" />

<f:if condition="{href}">
    <f:then>
        <a href="{href}" class="btn btn--{variant} btn--{size}">
            <f:slot />
        </a>
    </f:then>
    <f:else>
        <button class="btn btn--{variant} btn--{size}">
            <f:slot />
        </button>
    </f:else>
</f:if>
```

---

## Configuration Management

### Project Structure

#### Content Element Structure

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

#### Page Type Structure

```
ContentBlocks/PageTypes/{name}/
├── config.yaml
├── assets/
│   ├── icon.svg
│   └── icon-hide-in-menu.svg
├── language/
│   └── labels.xlf
└── templates/
    └── backend-preview.html
```

### Configuration Examples

#### Content Element Configuration

```yaml
name: vendor/hero-section
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
  - identifier: background_image
    type: File
    label: Background Image
    allowed: common-image-types
    maxitems: 1
```

#### Page Type Configuration

```yaml
name: vendor/landing-page
title: Landing Page
description: Modern landing page template
typeName: 200  # Custom doktype
group: default
prefixFields: true
prefixType: full
fields:
  - identifier: hero_title
    type: Text
    label: Hero Title
    required: true
```

### Global Defaults (content-blocks.yaml)

```yaml
defaults:
  contentElements:
    saveAndClose: true
    group: common
    prefixFields: true
    prefixType: vendor
  pageTypes:
    doktype: 200
```

---

## Backend Preview Templates

### CRITICAL: No Styling Rules

Backend preview templates MUST use only semantic HTML without any styling:

**DO:**

- Use semantic HTML (`<div>`, `<p>`, `<ul>`, `<li>`, `<section>`, `<h3>`, `<h4>`)
- Use TYPO3 ViewHelpers for functionality
- Keep markup minimal and meaningful
- Focus on content structure, not presentation

**DON'T:**

- Use inline styles (`style="..."`)
- Use CSS classes for styling (Bootstrap, custom classes)
- Use flexbox/grid layouts
- Add colors, borders, or spacing via CSS

### Basic Backend Preview Template

```html
<html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers" 
      xmlns:core="http://typo3.org/ns/TYPO3/CMS/Core/ViewHelpers"
      data-namespace-typo3-fluid="true">

<div>
    <p>
        <core:icon identifier="content-hero" size="small" /> 
        <strong>Hero Section</strong>
    </p>
    
    <f:if condition="{data.vendor_hero_headline}">
        <p><strong>Headline:</strong> {data.vendor_hero_headline}</p>
    </f:if>

    <f:if condition="{data.vendor_hero_description}">
        <p>
            <strong>Description:</strong>
            <f:format.crop maxCharacters="100">
                <f:format.stripTags>{data.vendor_hero_description}</f:format.stripTags>
            </f:format.crop>
        </p>
    </f:if>

    <f:if condition="{data.vendor_hero_image}">
        <p><strong>Background Image:</strong> Selected</p>
    </f:if>
</div>
</html>
```

### Collection Preview Example

```html
<html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers" 
      xmlns:core="http://typo3.org/ns/TYPO3/CMS/Core/ViewHelpers"
      data-namespace-typo3-fluid="true">

<div>
    <p>
        <core:icon identifier="content-accordion" size="small" /> 
        <strong>Accordion</strong>
    </p>
    
    <f:if condition="{data.vendor_accordion_items}">
        <p><strong>Items:</strong> {data.vendor_accordion_items -> f:count()}</p>
        <ul>
            <f:for each="{data.vendor_accordion_items}" as="item" iteration="iterator">
                <f:if condition="{iterator.index} < 3">
                    <li>
                        <strong>{item.title}</strong>
                        <f:if condition="{item.content}">
                            <br>
                            <f:format.crop maxCharacters="100">
                                <f:format.stripTags>{item.content}</f:format.stripTags>
                            </f:format.crop>
                        </f:if>
                    </li>
                </f:if>
            </f:for>
        </ul>
        <f:if condition="{data.vendor_accordion_items -> f:count()} > 3">
            <p><em>...and {data.vendor_accordion_items -> f:count() - 3} more items</em></p>
        </f:if>
    </f:if>
</div>
</html>
```

---

## Debugging & Cache Handling

### Debug Field Names

#### Show All Available Fields

```html
<f:debug>{data}</f:debug>
```

#### Show Specific Collection

```html
<f:debug title="Accordion Items">{data.vendor_accordion_items}</f:debug>
```

#### Show Field Structure in Collections

```html
<f:for each="{data.vendor_block_items}" as="item" iteration="iterator">
    <f:if condition="{iterator.isFirst}">
        <f:debug title="Item Structure">{item}</f:debug>
    </f:if>
</f:for>
```

### Cache Management

#### TYPO3 Cache Commands (DDEV)

```bash
# Clear all caches
ddev exec typo3 cache:flush

# Clear specific caches
ddev exec typo3 cache:flush --group=system
ddev exec typo3 cache:flush --group=pages

# Update database schema
ddev exec typo3 database:updateschema

# Aggressive cache clearing
ddev exec rm -rf var/cache/*
ddev exec typo3 cache:flush
```

#### Non-DDEV Commands

```bash
# Clear all caches
vendor/bin/typo3 cache:flush

# Update database schema  
vendor/bin/typo3 database:updateschema

# Manual cache clearing
rm -rf var/cache/*
vendor/bin/typo3 cache:flush
```

### Database Verification

```bash
# Check created tables
ddev mysql -e "SHOW TABLES LIKE '%vendor_%'"

# Inspect table structure
ddev mysql -e "DESCRIBE vendor_accordion_items"

# Check content data
ddev mysql -e "SELECT * FROM tt_content WHERE CType = 'vendor_accordion'"
```

---

## Best Practices & Patterns

### Field Configuration

1. **Use Descriptive Identifiers**

   ```yaml
   # Good
   - identifier: accordion_items
   
   # Bad (too generic)
   - identifier: items
   ```

2. **Provide Meaningful Labels**

   ```yaml
   - identifier: cta_button_text
     label: Call to Action Button Text
     description: Text displayed on the main action button
   ```

3. **Set Appropriate Constraints**

   ```yaml
   - identifier: headline
     type: Text
     required: true
     max: 100
   ```

### Template Best Practices

1. **Always Use Conditions**

   ```html
   <f:if condition="{data.vendor_block_field}">
       <!-- Only render if field has content -->
   </f:if>
   ```

2. **Proper Image Handling**

   ```html
   <f:image image="{image}" 
            cropVariant="default"
            width="800" 
            height="600c" 
            loading="lazy" />
   ```

3. **Collection Iteration**

   ```html
   <f:for each="{data.vendor_block_items}" as="item" iteration="iterator">
       <!-- Use iterator for index, cycle, isFirst, isLast -->
   </f:for>
   ```

### Performance Considerations

1. **Collection Performance**
   - Use `restrictedContentTypes` to limit options
   - Implement pagination for large collections
   - Optimize backend previews
   - Use lazy loading for images

2. **Field Performance**
   - Choose appropriate field types
   - Avoid unnecessary FlexForms
   - Use relations instead of inline for large datasets

3. **Template Performance**
   - Minimize ViewHelper nesting
   - Use compiled templates
   - Implement proper caching strategies

---

## Practical Examples

### Hero Section Content Block

#### Configuration (config.yaml)

```yaml
name: vendor/hero-section
title: Hero Section
description: Full-width hero section with background image and call-to-action
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
  - identifier: description
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
    cropVariants:
      hero:
        title: Hero Image
        allowedAspectRatios:
          16:9:
            title: Widescreen
            value: 1.777777778
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

#### Frontend Template (templates/frontend.html)

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:cb="http://typo3.org/ns/TYPO3/CMS/ContentBlocks/ViewHelpers">

<div class="hero-section">
    <f:if condition="{data.vendor_hero_section_background_image}">
        <div class="hero-background">
            <f:image image="{data.vendor_hero_section_background_image.0}" 
                     cropVariant="hero"
                     width="1920" 
                     height="1080c" />
            <div class="hero-overlay" 
                 style="opacity: {data.vendor_hero_section_overlay_opacity}%"></div>
        </div>
    </f:if>
    
    <div class="hero-content">
        <f:if condition="{data.vendor_hero_section_headline}">
            <h1 class="hero-headline">{data.vendor_hero_section_headline}</h1>
        </f:if>
        
        <f:if condition="{data.vendor_hero_section_subheadline}">
            <h2 class="hero-subheadline">{data.vendor_hero_section_subheadline}</h2>
        </f:if>
        
        <f:if condition="{data.vendor_hero_section_description}">
            <div class="hero-description">
                <f:format.html>{data.vendor_hero_section_description}</f:format.html>
            </div>
        </f:if>
        
        <f:if condition="{data.vendor_hero_section_cta_link}">
            <div class="hero-actions">
                <cb:link data="{data.vendor_hero_section_cta_link}" 
                         class="btn btn-primary btn-lg">
                    {data.vendor_hero_section_cta_text}
                </cb:link>
            </div>
        </f:if>
    </div>
</div>
</html>
```

### Accordion Content Block

#### Configuration (config.yaml)

```yaml
name: vendor/accordion
title: Accordion
description: Expandable accordion with multiple panels
group: common
prefixFields: true
prefixType: vendor
fields:
  - identifier: title
    type: Text
    label: Section Title
  - identifier: allow_multiple
    type: Checkbox
    renderType: checkboxToggle
    label: Allow Multiple Panels Open
    default: 0
  - identifier: first_expanded
    type: Checkbox
    renderType: checkboxToggle
    label: First Panel Open by Default
    default: 1
  - identifier: accordion_items
    type: Collection
    label: Accordion Items
    labelField: title
    minitems: 1
    maxitems: 10
    appearance:
      collapseAll: true
      useSortable: true
    fields:
      - identifier: title
        type: Text
        label: Panel Title
        required: true
      - identifier: content
        type: Textarea
        label: Panel Content
        enableRichtext: true
        required: true
      - identifier: icon
        type: Text
        label: Icon Class
        placeholder: 'fa-star'
```

#### Frontend Template (templates/frontend.html)

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers">

<div class="accordion-wrapper">
    <f:if condition="{data.vendor_accordion_title}">
        <h2 class="accordion-title">{data.vendor_accordion_title}</h2>
    </f:if>
    
    <f:if condition="{data.vendor_accordion_accordion_items}">
        <div class="accordion" 
             data-allow-multiple="{f:if(condition: data.vendor_accordion_allow_multiple, then: '1', else: '0')}"
             data-first-expanded="{f:if(condition: data.vendor_accordion_first_expanded, then: '1', else: '0')}">
            
            <f:for each="{data.vendor_accordion_accordion_items}" as="item" iteration="iterator">
                <div class="accordion-item">
                    <button class="accordion-header" 
                            type="button"
                            data-target="accordion-{iterator.index}"
                            aria-expanded="{f:if(condition: '{iterator.isFirst} && {data.vendor_accordion_first_expanded}', then: 'true', else: 'false')}">
                        
                        <f:if condition="{item.icon}">
                            <i class="{item.icon}"></i>
                        </f:if>
                        
                        <span>{item.title}</span>
                        
                        <i class="accordion-toggle-icon"></i>
                    </button>
                    
                    <div class="accordion-content" 
                         id="accordion-{iterator.index}"
                         role="region">
                        <div class="accordion-body">
                            <f:format.html>{item.content}</f:format.html>
                        </div>
                    </div>
                </div>
            </f:for>
        </div>
    </f:if>
</div>
</html>
```

### Card Grid Content Block

#### Configuration (config.yaml)

```yaml
name: vendor/card-grid
title: Card Grid
description: Responsive grid of cards with images and links
group: common
prefixFields: true
prefixType: vendor
fields:
  - identifier: headline
    type: Text
    label: Section Headline
  - identifier: description
    type: Textarea
    label: Section Description
    enableRichtext: true
    rows: 3
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
  - identifier: card_items
    type: Collection
    label: Cards
    labelField: title
    minitems: 1
    maxitems: 12
    appearance:
      collapseAll: false
      useSortable: true
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
        cropVariants:
          card:
            title: Card Image
            allowedAspectRatios:
              1:1:
                title: Square
                value: 1
              4:3:
                title: Landscape
                value: 1.333333333
      - identifier: link
        type: Link
        label: Card Link
        allowedTypes: [page, url]
      - identifier: button_text
        type: Text
        label: Button Text
        default: 'Read More'
```

---

## Troubleshooting Matrix

### Common Issues & Solutions

| Symptom | Likely Cause | Solution |
|---------|--------------|----------|
| Content not showing in frontend | Cache not cleared | `ddev exec typo3 cache:flush` |
| Table doesn't exist error | Generic collection name | Use descriptive names like `accordion_items` |
| Field data not accessible | Wrong field naming | Check prefix pattern: `{vendor}_{block}_{field}` |
| Collection items empty | Wrong access pattern | Use `item.fieldname` not prefixed version |
| Backend preview broken | Missing template | Create `backend-preview.html` |
| Changes not reflecting | Aggressive caching | `rm -rf var/cache/*` + flush |

### Debug Checklist

#### Initial Setup

- [ ] DDEV running: `ddev describe`
- [ ] Database accessible: `ddev mysql -e "SHOW TABLES"`
- [ ] TYPO3 accessible: Check `/typo3` backend
- [ ] Logs checked: `ddev logs -f`

#### Content Block Creation

- [ ] Directory structure correct
- [ ] config.yaml valid YAML
- [ ] Templates in correct locations
- [ ] Language files present
- [ ] Icon file exists

#### After Changes

- [ ] Cache cleared: `ddev exec typo3 cache:flush`
- [ ] Database updated: `ddev exec typo3 database:updateschema`
- [ ] Browser cache cleared
- [ ] Console errors checked

### Performance Issues

#### Slow Backend

- Too many collection items → Use pagination
- Missing indexes → Check database optimization
- Large RTE content → Implement lazy loading

#### Slow Frontend

- Too many DOM manipulations → Optimize JavaScript
- Large assets → Implement proper asset optimization
- Missing caching → Configure proper cache strategies

---

## Migration & Maintenance

### From Mask/DCE

1. **Export existing configuration**
2. **Map field identifiers to Content Blocks naming**
3. **Convert to YAML configuration**
4. **Migrate templates to Fluid**
5. **Test and validate functionality**

### Version Upgrades

1. **Check Content Blocks changelog**
2. **Review TYPO3 core changes**
3. **Test in development environment**
4. **Update configuration if needed**
5. **Clear all caches**

### Best Practices for Maintenance

1. **Document custom configurations**
2. **Use version control for Content Blocks**
3. **Regular testing of all Content Blocks**
4. **Monitor performance impact**
5. **Keep documentation current**

---

## Conclusion

This reference provides complete guidance for developing TYPO3 v13 Content Blocks using modern best practices. Focus on:

- **Declarative YAML configuration** over complex TCA
- **Semantic backend previews** without styling
- **Proper field naming patterns** for maintainability
- **Fluid v4 components** for reusable UI elements
- **Performance optimization** from the start
- **Comprehensive testing** and debugging

For complex implementations, combine these patterns and always test thoroughly in development environments before production deployment.
