# TYPO3 Integration for Claude Code Toolkit

Complete TYPO3 v13.4 development support with Content Blocks v1.3 integration.

## Overview

The TYPO3 integration provides specialized commands and AI agents for accelerating TYPO3 development with modern best practices.

## Features

- **SitePackage Generation**: Complete TYPO3 v13.4 SitePackage with Site Sets
- **Content Blocks v1.3**: Full support for the latest Content Blocks features
- **Extension Development**: Kickstart extensions with best practices
- **Specialized AI Agents**: TYPO3-specific expertise for architecture, development, and optimization
- **TypoScript Intelligence**: Modern TypoScript patterns and Site Sets configuration

## Requirements

- TYPO3 v13.4 LTS
- PHP 8.2+
- Composer 2.x
- Content Blocks v1.3 (for content block features)

## Installation

```bash
# Clone the toolkit
git clone https://github.com/your-repo/claude-code-toolkit.git
cd claude-code-toolkit

# Install with TYPO3 prefix
./install.sh typo3

# Commands will be available as:
# /typo3:sitepackage
# /typo3:content-blocks
# /typo3:make-content-block
# /typo3:extension-kickstarter
```

## Available Commands

### SitePackage Creation

```bash
/typo3:sitepackage [vendor] [package-name]
```

Creates a complete TYPO3 v13.4 SitePackage with:

- Site Sets configuration (new in v13)
- Modern Composer setup
- Content Blocks structure
- **Fluid v4 Components** (new)
- ComponentCollection class
- Starter component library (Atoms/Molecules/Organisms)
- Design tokens system
- FLUIDTEMPLATE configuration
- Responsive templates
- SCSS/CSS structure

### Content Blocks Generator

```bash
/typo3:content-blocks [name] [--type=element|page] [--with-components]
```

Generates Content Blocks v1.3 configurations with:

- All 30+ field types
- Collection with child type restrictions (v1.3)
- Page type support
- Backend previews
- Responsive templates
- **Fluid v4 Components integration** (with --with-components flag)

### Fluid Components Generator (NEW)

```bash
/typo3:fluid-components [component-name] [--type=atom|molecule|organism]
```

Generates Fluid v4 Components for TYPO3 v13.3+:

- Atomic Design structure
- Typed arguments with `<f:argument>`
- Slot-based content handling
- ComponentCollection class
- Test files and SCSS scaffolding
- Accessibility features

### Make Content Block (Native Wrapper)

```bash
/typo3:make-content-block
```

Intelligent wrapper for the native `make:content-block` command:

- Automatic configuration management
- Skeleton templates
- Interactive field builder
- Best practice defaults

### Extension Kickstarter

```bash
/typo3:extension-kickstarter [extension-key]
```

Creates complete TYPO3 extensions:

- Plugin extensions with Extbase/Fluid
- Backend modules
- Service extensions
- Middleware implementation
- Testing setup

## AI Agents

### typo3-architect

Expert in TYPO3 architecture and best practices:

- Project structure analysis
- Performance optimization
- Security auditing
- Migration planning
- Site Sets configuration

### typo3-content-blocks-specialist

Master of Content Blocks v1.3:

- Field type optimization
- Collection management
- Template development
- Migration from Mask/DCE
- Performance tuning

### typo3-extension-developer

Extbase/Fluid development expert:

- Service architecture
- Dependency injection
- Event system
- Middleware development
- Testing strategies

### typo3-typoscript-expert

Modern TypoScript and configuration:

- Site Sets (v13)
- Data processing
- Condition syntax
- Performance optimization
- Cache management

## Quick Start Guide

### 1. Create a New TYPO3 Project

```bash
# Create SitePackage
/typo3:sitepackage mycompany corporate-site

# Install in Composer
composer require mycompany/corporate-site:@dev

# Activate extension
vendor/bin/typo3 extension:setup
```

### 2. Add Content Blocks

```bash
# Create hero section
/typo3:make-content-block
# Select: hero skeleton
# Customize fields as needed

# Create card grid
/typo3:make-content-block
# Select: card-grid skeleton

# Clear caches
vendor/bin/typo3 cache:flush
```

### 3. Create Custom Page Type

```bash
/typo3:content-blocks landing-page --type=page
```

Then add to your page.typoscript:

```typoscript
page.10.templateName.cObject {
    key.field = doktype
    {generated_doktype}.value = LandingPage
}
```

## Fluid v4 Components Integration

### Overview

Fluid v4 Components (available in TYPO3 v13.3+) bring modern component-based development to TYPO3:

- **Server-side Components**: Unlike JavaScript frameworks, Fluid Components are server-rendered
- **Type Safety**: Strictly typed arguments using `<f:argument>` ViewHelper
- **Reusability**: Share components across Content Blocks and templates
- **No PHP Required**: Template-based components accessible to frontend developers

### Component Architecture

```
sitepackage/
├── Classes/
│   └── Components/
│       └── ComponentCollection.php    # Component configuration
├── Configuration/
│   └── DesignTokens.json             # Design system tokens
└── Resources/
    └── Private/
        └── Components/
            ├── Atom/                  # Basic elements
            │   ├── Button.html
            │   ├── Icon.html
            │   └── Input.html
            ├── Molecule/              # Composite components
            │   ├── Card.html
            │   └── Navigation.html
            └── Organism/              # Complex structures
                ├── Header.html
                └── Grid.html
```

### Using Components with Content Blocks

#### 1. Standard Content Block (without components)

```html
<div class="hero">
    <h2>{data.vendor_hero_title}</h2>
    <f:format.html>{data.vendor_hero_text}</f:format.html>
</div>
```

#### 2. Component-Based Content Block

```html
<html xmlns:my="http://typo3.org/ns/Vendor/Package/Components/ComponentCollection">
    
<my:molecule.hero 
    title="{data.vendor_hero_title}"
    variant="primary">
    <f:slot name="content">
        <my:atom.richText>{data.vendor_hero_text}</my:atom.richText>
    </f:slot>
    <f:slot name="actions">
        <my:atom.button href="{data.vendor_hero_link}">
            Learn More
        </my:atom.button>
    </f:slot>
</my:molecule.hero>
</html>
```

### Component Examples

#### Button Component (Atom)

```html
<f:argument name="href" type="string" optional="{true}" />
<f:argument name="variant" type="string" optional="{true}" default="primary" />
<f:argument name="disabled" type="boolean" optional="{true}" default="{false}" />

<f:if condition="{href}">
    <f:then>
        <a href="{href}" class="btn btn--{variant}">
            <f:slot />
        </a>
    </f:then>
    <f:else>
        <button class="btn btn--{variant}" {f:if(condition: disabled, then: 'disabled')}>
            <f:slot />
        </button>
    </f:else>
</f:if>
```

#### Card Component (Molecule)

```html
<f:argument name="title" type="string" />
<f:argument name="image" type="TYPO3\CMS\Core\Resource\FileInterface" optional="{true}" />

<article class="card">
    <f:if condition="{image}">
        <f:image image="{image}" class="card__image" />
    </f:if>
    <h3 class="card__title">{title}</h3>
    <div class="card__content">
        <f:slot />
    </div>
</article>
```

### Benefits

1. **Consistency**: Shared components ensure UI consistency
2. **Maintainability**: Update once, apply everywhere
3. **Performance**: Server-side rendering, optimized compilation
4. **Developer Experience**: Frontend developers can work independently
5. **Type Safety**: Catch errors at template compile time

### Migration from ViewHelpers

**Before (ViewHelper):**

```php
class ButtonViewHelper extends AbstractTagBasedViewHelper {
    public function initializeArguments(): void {
        $this->registerArgument('variant', 'string', 'Button variant', false, 'primary');
    }
}
```

**After (Component):**

```html
<f:argument name="variant" type="string" optional="{true}" default="primary" />
<button class="btn btn--{variant}"><f:slot /></button>
```

## Content Blocks v1.3 Features

### Collection Child Type Restrictions

```yaml
- identifier: items
  type: Collection
  restrictedContentTypes:  # NEW in v1.3
    - text
    - images
    - vendor/custom-block
```

### Default Configurations

Create `content-blocks.yaml` in your extension:

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

### Core Page Type Re-definition

```yaml
name: vendor/shortcut-page
typeName: 4  # Redefine core shortcut page
fields:
  - identifier: additional_field
    type: Text
```

## Skeleton Templates

Pre-configured templates available:

- **hero**: Full-width hero section
- **card-grid**: Responsive card layout
- **accordion**: Expandable content
- **landing-page**: Complete page type
- **testimonials**: Customer quotes
- **gallery**: Image gallery

## Best Practices

### 1. Project Structure

```
project/
├── packages/
│   └── sitepackage/          # Your SitePackage
│       ├── ContentBlocks/    # Content Blocks
│       ├── Configuration/    # Site Sets
│       └── Resources/        # Templates
├── config/                    # TYPO3 configuration
└── composer.json
```

### 2. Naming Conventions

- **Vendor**: lowercase, no spaces (e.g., `mycompany`)
- **Package**: kebab-case (e.g., `corporate-site`)
- **Content Blocks**: vendor/name (e.g., `mycompany/hero`)
- **Extension Keys**: underscores (e.g., `my_extension`)

### 3. Field Configuration

Always specify:

- Meaningful identifiers
- Proper field types
- Translation labels
- Backend previews
- Validation rules

### 4. Performance

- Use Collection restrictions
- Implement caching
- Optimize images
- Lazy load assets
- Minimize ViewHelper nesting

## Troubleshooting

### Content Blocks Not Showing

```bash
# Clear all caches
vendor/bin/typo3 cache:flush

# Check if Content Blocks is installed
composer show friendsoftypo3/content-blocks

# Verify registration
vendor/bin/typo3 content-blocks:list
```

### Page Type Not Available

1. Check doktype is unique
2. Verify TypoScript mapping
3. Clear backend caches
4. Check page TSconfig

### Extension Not Loading

```bash
# Check extension status
vendor/bin/typo3 extension:list

# Setup extension
vendor/bin/typo3 extension:setup

# Check Services.yaml
cat Configuration/Services.yaml
```

## Integration with Existing Projects

### Analyze Current Setup

```bash
# Use TYPO3 Architect agent
Use Task tool with subagent_type="typo3-architect":
"Analyze this TYPO3 project structure and provide recommendations"
```

### Migrate from Mask

```bash
# Use Content Blocks Specialist
Use Task tool with subagent_type="typo3-content-blocks-specialist":
"Convert Mask element 'slider' to Content Blocks v1.3"
```

## Advanced Usage

### Custom Skeleton Creation

```bash
/typo3:make-content-block --create-skeleton
# Follow prompts to create reusable skeleton
```

### Batch Processing

```yaml
# content-blocks-batch.yaml
blocks:
  - name: hero
    type: content-element
    fields: [headline, text, image, link]
  - name: features
    type: content-element
    fields: [items:collection]
```

```bash
/typo3:make-content-block --batch=content-blocks-batch.yaml
```

## Resources

### Official Documentation

- [TYPO3 v13 Documentation](https://docs.typo3.org/m/typo3/reference-coreapi/13.4/en-us/)
- [Content Blocks Documentation](https://docs.typo3.org/p/friendsoftypo3/content-blocks/main/en-us/)
- [Content Blocks Make Command](https://docs.typo3.org/p/friendsoftypo3/content-blocks/main/en-us/Commands/Make/Index.html)
- [Site Sets Documentation](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/SiteSets.html)

### Community Resources

- [TYPO3 Slack](https://typo3.slack.com)
- [Extension Repository](https://extensions.typo3.org)
- [TYPO3 Stack Exchange](https://stackoverflow.com/questions/tagged/typo3)

## Contributing

Contributions are welcome! Please:

1. Follow TYPO3 coding standards
2. Add tests for new features
3. Update documentation
4. Submit pull requests

## License

MIT License - See LICENSE file for details
