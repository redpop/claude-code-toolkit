---
description: Generate Fluid v4 Components for TYPO3 v13 with Atomic Design patterns and Fluid analysis
argument-hint: "[component-name] [--type=atom|molecule|organism] [--sitepackage=path] [--analyze]"
mcp-enhanced: mcp__context7__get-library-docs
documentation-sources:
  - https://docs.typo3.org/p/typo3fluid/fluid/main/en-us/
  - https://github.com/TYPO3/Fluid
---

# TYPO3 Fluid v4 Components Generator & Analyzer

Generates Fluid v4 Components for TYPO3 v13.3+ projects using modern component-based architecture. Also provides comprehensive Fluid template analysis and optimization recommendations.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Generate Fluid v4 Components for TYPO3 v13 with Atomic Design patterns and analyze existing Fluid templates
- **Usage**: [component-name] [--type=atom|molecule|organism] [--sitepackage=path] [--analyze]
- **Options**: --type, --sitepackage, --analyze
- **Examples**: See the component examples, analysis examples, and usage sections below

Then exit without executing the main command.

---

## Usage

```bash
# Generate new Fluid component
/prefix:typo3:fluid-components [component-name] [options]

# Analyze existing Fluid templates
/prefix:typo3:fluid-components --analyze [path]
```

## Documentation & Context Enhancement

**CHECK FOR ENHANCED DOCUMENTATION ACCESS:**

1. **If Context7 MCP is available**:
   - Use `mcp__context7__resolve-library-id "TYPO3 Fluid"`
   - Then `mcp__context7__get-library-docs` with topic="components" for latest documentation
   - This provides up-to-date component patterns and best practices

2. **Reference documentation**:
   - Fluid v4 Components documentation
   - TYPO3 v13 integration guides
   - Atomic Design principles

## Important: Fluid v4.3 Component Syntax

**Note:** The `fc:component` syntax (`TYPO3\CMS\Fluid\ViewHelpers\Component`) is **NOT available in Fluid v4.3/TYPO3 13**.
It's an experimental feature. Use standard partials with `f:render partial=""` instead.

### Correct Approach for TYPO3 13

```html
<!-- Component as Partial -->
<f:render partial="Components/Accordion/Accordion" arguments="{
    title: title,
    items: items,
    allowMultiple: allowMultiple
}" />
```

### Content Blocks Integration

Content Blocks can use shared partials from sitepackage via TypoScript configuration:

```typoscript
lib.contentElement {
    partialRootPaths {
        100 = EXT:sitepackage/Resources/Private/Partials/
    }
}
```

See: Content Blocks Shared Partials Documentation at ~/.claude/claude-code-toolkit/knowledge-base/typo3/content-blocks-shared-partials.md

## Command Workflow

### Analysis Mode (--analyze flag)

If "$ARGUMENTS" contains "--analyze":

1. **Initialize Fluid Analysis**:

Use Task tool with subagent_type="typo3-fluid-expert":
"Perform comprehensive TYPO3 Fluid template analysis on the project. Focus on:

- Template architecture and organization (layouts, templates, partials)
- ViewHelper usage patterns and custom ViewHelper quality
- Performance optimization opportunities (caching, rendering efficiency)
- Modern Fluid v13+ convention compliance
- Template maintainability and code quality
- Integration patterns with TYPO3 ecosystem

Analyze the codebase at {path or current directory} and provide:

1. Executive summary with scores and critical issues
2. Detailed analysis of template structure, ViewHelper implementation, and performance
3. Prioritized recommendations for immediate, short-term, and long-term improvements
4. Context7 documentation status (whether latest conventions were used)

Export results to JSON format with timestamp for action plan generation."

### Component Generation Mode (default)

Parse the arguments from $ARGUMENTS to extract:

- Component name (e.g., "button", "card", "product-grid")  
- Type: atom (default), molecule, or organism
- SitePackage path (optional, defaults to ./packages/sitepackage)
- Additional options (icon support, slots, etc.)

If arguments are missing, ask the user for:

1. Component name (kebab-case)
2. Component type (Atom/Molecule/Organism)
3. Component arguments/properties
4. Whether to include slots
5. Accessibility features needed

## Component Structure

Create the following structure:

```
packages/sitepackage/
├── Classes/
│   └── Components/
│       └── ComponentCollection.php
└── Resources/
    └── Private/
        └── Components/
            ├── Atom/
            ├── Molecule/
            └── Organism/
```

## ComponentCollection Class

If not exists, create ComponentCollection.php:

```php
<?php
declare(strict_types=1);

namespace {Vendor}\{Package}\Components;

use TYPO3Fluid\Fluid\Core\Component\AbstractComponentCollection;

final class ComponentCollection extends AbstractComponentCollection
{
    /**
     * Allow additional HTML attributes (data-*, aria-*)
     */
    protected function additionalArgumentsAllowed(string $viewHelperName): bool
    {
        return true;
    }
    
    /**
     * Provide global design tokens
     */
    public function getDesignTokens(): array
    {
        return json_decode(
            file_get_contents(__DIR__ . '/../../Configuration/DesignTokens.json'),
            true
        );
    }
}
```

## Component Templates

### Atom Component Template

For atomic components (buttons, inputs, icons, etc.):

```html
<!-- Atom/{ComponentName}.html -->
<f:comment>
Component: Atom/{ComponentName}
Purpose: {description}
Author: Generated by Claude Code Toolkit
Date: {date}
</f:comment>

<!-- Define typed arguments -->
<f:argument name="variant" type="string" optional="{true}" default="default" />
<f:argument name="size" type="string" optional="{true}" default="medium" />
<f:argument name="disabled" type="boolean" optional="{true}" default="{false}" />
<f:argument name="ariaLabel" type="string" optional="{true}" />
<f:argument name="ariaDescribedBy" type="string" optional="{true}" />
<f:argument name="id" type="string" optional="{true}" />
<f:argument name="class" type="string" optional="{true}" />

<!-- Component markup -->
<{element} 
    {f:if(condition: id, then: 'id="{id}"')}
    class="{componentName} {componentName}--{variant} {componentName}--{size} {class}"
    {f:if(condition: disabled, then: 'disabled="disabled" aria-disabled="true"')}
    {f:if(condition: ariaLabel, then: 'aria-label="{ariaLabel}"')}
    {f:if(condition: ariaDescribedBy, then: 'aria-describedby="{ariaDescribedBy}"')}>
    
    <f:slot />
    
</{element}>
```

### Molecule Component Template

For composite components (cards, form groups, media objects):

```html
<!-- Molecule/{ComponentName}.html -->
<f:comment>
Component: Molecule/{ComponentName}
Purpose: {description}
</f:comment>

<!-- Define typed arguments -->
<f:argument name="title" type="string" optional="{true}" />
<f:argument name="description" type="string" optional="{true}" />
<f:argument name="variant" type="string" optional="{true}" default="default" />
<f:argument name="layout" type="string" optional="{true}" default="vertical" />

<article class="{componentName} {componentName}--{variant} {componentName}--{layout}">
    <f:if condition="{title || description}">
        <header class="{componentName}__header">
            <f:if condition="{title}">
                <h3 class="{componentName}__title">{title}</h3>
            </f:if>
            <f:if condition="{description}">
                <p class="{componentName}__description">{description}</p>
            </f:if>
        </header>
    </f:if>
    
    <div class="{componentName}__body">
        <f:slot />
    </div>
    
    <f:slot name="footer">
        <!-- Optional footer slot -->
    </f:slot>
</article>
```

### Organism Component Template

For complex structures (headers, footers, product grids):

```html
<!-- Organism/{ComponentName}.html -->
<f:comment>
Component: Organism/{ComponentName}
Purpose: {description}
</f:comment>

<!-- Define typed arguments -->
<f:argument name="items" type="array" optional="{true}" />
<f:argument name="columns" type="integer" optional="{true}" default="3" />
<f:argument name="gap" type="string" optional="{true}" default="medium" />
<f:argument name="variant" type="string" optional="{true}" default="grid" />

<section class="{componentName} {componentName}--{variant}">
    <f:slot name="header">
        <!-- Optional header slot -->
    </f:slot>
    
    <div class="{componentName}__grid {componentName}__grid--cols-{columns} {componentName}__grid--gap-{gap}">
        <f:if condition="{items}">
            <f:then>
                <f:for each="{items}" as="item" iteration="iteration">
                    <div class="{componentName}__item">
                        <f:slot name="item" arguments="{item: item, index: iteration.index}">
                            <!-- Default item rendering -->
                            <my:molecule.card 
                                title="{item.title}" 
                                description="{item.description}" />
                        </f:slot>
                    </div>
                </f:for>
            </f:then>
            <f:else>
                <f:slot />
            </f:else>
        </f:if>
    </div>
    
    <f:slot name="footer">
        <!-- Optional footer slot -->
    </f:slot>
</section>
```

## Fluid Analysis Examples

### Analyze Current Project

```bash
/prefix:typo3:fluid-components --analyze
```

Output example:

```markdown
# TYPO3 Fluid Template Analysis Results

## Executive Summary
- **Fluid Architecture Score**: 7/10
- **Template Performance**: Good
- **ViewHelper Quality**: 8/10
- **Convention Compliance**: 6/10
- **Critical Issues**: 3

## Key Findings
- 15 Fluid templates found
- 3 custom ViewHelpers detected
- 2 performance optimization opportunities
- 4 convention compliance issues

## Recommendations
### Immediate Actions (< 1 day)
1. **Fix deprecated f:cObject usage** - Replace with modern data processing
2. **Add missing f:argument type declarations** - Improve template reliability

### Template Architecture Enhancements (1-5 days) 
1. **Reorganize partial structure** - Better component separation
2. **Implement consistent naming** - Follow TYPO3 v13 conventions
```

### Analyze Specific Directory

```bash
/prefix:typo3:fluid-components --analyze packages/sitepackage/Resources/Private/
```

Focuses analysis on specific template directory.

### Analysis Output Formats

The analysis automatically exports results in JSON format for further processing:

```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "analysis_type": "fluid_templates",
  "summary": {
    "architecture_score": 7,
    "performance_rating": "good",
    "viewhelper_quality": 8,
    "convention_compliance": 6,
    "critical_issues": 3
  },
  "recommendations": {
    "immediate": [...],
    "short_term": [...],
    "long_term": [...]
  }
}
```

## Specific Component Examples

### Button Component (Atom)

```html
<!-- Atom/Button.html -->
<f:argument name="href" type="string" optional="{true}" />
<f:argument name="variant" type="string" optional="{true}" default="primary" />
<f:argument name="size" type="string" optional="{true}" default="medium" />
<f:argument name="disabled" type="boolean" optional="{true}" default="{false}" />
<f:argument name="loading" type="boolean" optional="{true}" default="{false}" />
<f:argument name="icon" type="string" optional="{true}" />
<f:argument name="iconPosition" type="string" optional="{true}" default="left" />
<f:argument name="type" type="string" optional="{true}" default="button" />

<f:if condition="{href}">
    <f:then>
        <a href="{href}" 
           class="btn btn--{variant} btn--{size}"
           {f:if(condition: disabled, then: 'aria-disabled="true" tabindex="-1"')}>
            <f:render section="ButtonContent" arguments="{_all}" />
        </a>
    </f:then>
    <f:else>
        <button type="{type}"
                class="btn btn--{variant} btn--{size}"
                {f:if(condition: disabled, then: 'disabled="disabled"')}
                {f:if(condition: loading, then: 'aria-busy="true"')}>
            <f:render section="ButtonContent" arguments="{_all}" />
        </button>
    </f:else>
</f:if>

<f:section name="ButtonContent">
    <f:if condition="{loading}">
        <span class="btn__spinner" aria-hidden="true"></span>
    </f:if>
    <f:if condition="{icon} && {iconPosition} == 'left'">
        <my:atom.icon name="{icon}" class="btn__icon btn__icon--left" />
    </f:if>
    <span class="btn__label"><f:slot /></span>
    <f:if condition="{icon} && {iconPosition} == 'right'">
        <my:atom.icon name="{icon}" class="btn__icon btn__icon--right" />
    </f:if>
</f:section>
```

### Card Component (Molecule)

```html
<!-- Molecule/Card.html -->
<f:argument name="title" type="string" />
<f:argument name="description" type="string" optional="{true}" />
<f:argument name="image" type="TYPO3\CMS\Core\Resource\FileInterface" optional="{true}" />
<f:argument name="link" type="string" optional="{true}" />
<f:argument name="linkText" type="string" optional="{true}" default="Read more" />
<f:argument name="variant" type="string" optional="{true}" default="default" />
<f:argument name="aspectRatio" type="string" optional="{true}" default="16:9" />

<article class="card card--{variant}">
    <f:if condition="{image}">
        <div class="card__media card__media--{aspectRatio -> f:format.case(mode: 'lower') -> f:replace(search: ':', replace: '-')}">
            <f:if condition="{link}">
                <f:then>
                    <a href="{link}" aria-label="{title}">
                        <my:atom.responsiveImage 
                            image="{image}" 
                            sizes="(max-width: 768px) 100vw, 33vw"
                            loading="lazy" />
                    </a>
                </f:then>
                <f:else>
                    <my:atom.responsiveImage 
                        image="{image}" 
                        sizes="(max-width: 768px) 100vw, 33vw"
                        loading="lazy" />
                </f:else>
            </f:if>
        </div>
    </f:if>
    
    <div class="card__body">
        <h3 class="card__title">
            <f:if condition="{link}">
                <f:then><a href="{link}">{title}</a></f:then>
                <f:else>{title}</f:else>
            </f:if>
        </h3>
        
        <f:if condition="{description}">
            <p class="card__description">{description}</p>
        </f:if>
        
        <f:slot />
        
        <f:slot name="footer">
            <f:if condition="{link}">
                <div class="card__footer">
                    <my:atom.button 
                        href="{link}" 
                        variant="secondary" 
                        size="small"
                        icon="arrow-right"
                        iconPosition="right">
                        {linkText}
                    </my:atom.button>
                </div>
            </f:if>
        </f:slot>
    </div>
</article>
```

### Grid Component (Organism)

```html
<!-- Organism/Grid.html -->
<f:argument name="items" type="array" />
<f:argument name="columns" type="integer" optional="{true}" default="3" />
<f:argument name="gap" type="string" optional="{true}" default="medium" />
<f:argument name="responsive" type="boolean" optional="{true}" default="{true}" />
<f:argument name="component" type="string" optional="{true}" default="card" />

<div class="grid 
            grid--cols-{columns} 
            grid--gap-{gap}
            {f:if(condition: responsive, then: 'grid--responsive')}">
    
    <f:for each="{items}" as="item" iteration="iteration">
        <div class="grid__item" data-index="{iteration.index}">
            <f:switch expression="{component}">
                <f:case value="card">
                    <my:molecule.card 
                        title="{item.title}"
                        description="{item.description}"
                        image="{item.image}"
                        link="{item.link}" />
                </f:case>
                <f:case value="product">
                    <my:molecule.productCard product="{item}" />
                </f:case>
                <f:defaultCase>
                    <f:slot name="item" arguments="{item: item, index: iteration.index}">
                        {item.title}
                    </f:slot>
                </f:defaultCase>
            </f:switch>
        </div>
    </f:for>
</div>
```

## Component Usage

Show how to use the generated component:

```html
<html xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers"
      xmlns:my="http://typo3.org/ns/{Vendor}/{Package}/Components/ComponentCollection"
      data-namespace-typo3-fluid="true">

<!-- Atom usage -->
<my:atom.button variant="primary" size="large">
    Click me
</my:atom.button>

<!-- Molecule usage -->
<my:molecule.card 
    title="Product Title"
    description="Product description"
    link="/products/1">
    <f:slot name="footer">
        <my:atom.button variant="secondary">Buy Now</my:atom.button>
    </f:slot>
</my:molecule.card>

<!-- Organism usage -->
<my:organism.grid items="{products}" columns="4" gap="large">
    <f:slot name="item" arguments="{item: item}">
        <my:molecule.productCard product="{item}" />
    </f:slot>
</my:organism.grid>
</html>
```

## Testing Support

Generate a test file for the component:

```php
<?php
namespace {Vendor}\{Package}\Tests\Unit\Components;

use TYPO3\TestingFramework\Core\Unit\UnitTestCase;
use TYPO3Fluid\Fluid\View\TemplateView;

class {ComponentName}ComponentTest extends UnitTestCase
{
    protected TemplateView $view;
    
    protected function setUp(): void
    {
        parent::setUp();
        $this->view = new TemplateView();
        $this->view->getTemplatePaths()->setTemplateRootPaths([
            'EXT:{extension}/Resources/Private/Components/'
        ]);
    }
    
    /**
     * @test
     */
    public function componentRendersWithDefaultValues(): void
    {
        $template = '<my:{type}.{componentName} />';
        $output = $this->view->renderSection('Main', ['template' => $template]);
        
        self::assertStringContainsString('{componentName}', $output);
        self::assertStringContainsString('{componentName}--default', $output);
    }
}
```

## SCSS Scaffold

Generate corresponding SCSS file:

```scss
// Resources/Private/Scss/Components/{type}/_{componentName}.scss

.{componentName} {
    // Base styles
    display: block;
    
    // Variants
    &--primary {
        // Primary variant styles
    }
    
    &--secondary {
        // Secondary variant styles
    }
    
    // Sizes
    &--small {
        // Small size styles
    }
    
    &--medium {
        // Medium size styles
    }
    
    &--large {
        // Large size styles
    }
    
    // Elements (BEM)
    &__header {
        // Header element styles
    }
    
    &__body {
        // Body element styles
    }
    
    &__footer {
        // Footer element styles
    }
    
    // States
    &:hover {
        // Hover state
    }
    
    &:focus {
        // Focus state
    }
    
    &[disabled],
    &[aria-disabled="true"] {
        // Disabled state
        opacity: 0.5;
        cursor: not-allowed;
    }
}
```

## Success Message

```
✅ Fluid Component created successfully!

📁 Location: {path}/Resources/Private/Components/{type}/{name}.html
🏷️ Type: {type}
📦 Namespace: {vendor}.{package}
🎨 Component: <my:{type}.{name} />

Files created:
✓ Component template: {type}/{name}.html
✓ ComponentCollection class (if new)
✓ Test file: Tests/Unit/Components/{name}ComponentTest.php
✓ SCSS file: Resources/Private/Scss/Components/{type}/_{name}.scss

Next steps:
1. Import SCSS in your main stylesheet:
   @import "Components/{type}/{name}";

2. Use in your templates:
   <my:{type}.{name} variant="primary">Content</my:{type}.{name}>

3. Run tests:
   vendor/bin/phpunit Tests/Unit/Components/{name}ComponentTest.php

4. Customize the component as needed

Happy component building! 🎨
```

## Interactive Mode

If no arguments provided, guide the user through:

1. Choose component type: Atom, Molecule, or Organism
2. Enter component name (kebab-case)
3. Select base element (div, button, a, section, etc.)
4. Add component arguments:
   - Argument name
   - Type (string, boolean, integer, array, object)
   - Optional/required
   - Default value
5. Add slots:
   - Default slot
   - Named slots
6. Include accessibility features:
   - ARIA attributes
   - Keyboard navigation
   - Screen reader support
7. Generate corresponding:
   - Test file
   - SCSS file
   - Documentation
8. Review and confirm generation

## Error Handling

- Check if Components directory exists
- Validate component name format
- Check for duplicate components
- Ensure ComponentCollection class exists
- Verify namespace configuration
- Generate unique component names

## Best Practices Applied

1. **Atomic Design**: Proper categorization (Atom/Molecule/Organism)
2. **Type Safety**: All arguments strictly typed
3. **Accessibility**: ARIA attributes and semantic HTML
4. **Performance**: Lazy loading, efficient rendering
5. **Maintainability**: Clear structure, documentation
6. **Testing**: Unit tests for each component
7. **Styling**: BEM methodology, SCSS organization
8. **Reusability**: Flexible slots and arguments
