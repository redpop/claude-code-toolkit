# Accordion UI Pattern

## Overview

An accordion is a vertically stacked list of headers that reveal or hide content sections when clicked.

## Content Block Configuration

### Basic Structure

```yaml
name: vendor/accordion
title: 'Accordion'
fields:
  - identifier: title
    type: Text
    label: 'Title'
    
  - identifier: accordion_items  # Descriptive name for table generation
    type: Collection
    label: 'Accordion Items'
    labelField: header
    fields:
      - identifier: header
        type: Text
        label: 'Panel Header'
        required: true
      - identifier: content
        type: Textarea
        label: 'Panel Content'
        enableRichtext: true
        
  - identifier: first_expanded
    type: Checkbox
    renderType: checkboxToggle
    label: 'First Panel Expanded by Default'
    
  - identifier: allow_multiple
    type: Checkbox
    renderType: checkboxToggle
    label: 'Allow Multiple Panels Open'
```

## Implementation Patterns

### Pattern 1: Global Settings (Recommended)

Settings that affect all panels should be at the root level:

```yaml
# Root level - affects all panels
- identifier: first_expanded
  type: Checkbox
  
- identifier: allow_multiple
  type: Checkbox
```

### Pattern 2: Per-Item Settings (Complex)

Settings per panel add complexity:

```yaml
# Inside collection - per panel
fields:
  - identifier: expanded_by_default
    type: Checkbox  # Requires complex logic to handle
```

## Frontend Templates

### Framework-Agnostic Structure

```html
<div class="accordion-wrapper">
    <f:if condition="{data.vendor_accordion_title}">
        <h2>{data.vendor_accordion_title}</h2>
    </f:if>
    
    <f:if condition="{data.vendor_accordion_accordion_items}">
        <div class="accordion-container">
            <f:for each="{data.vendor_accordion_accordion_items}" as="item" iteration="iter">
                <div class="accordion-item">
                    <button class="accordion-header" data-index="{iter.index}">
                        {item.header}
                        <span class="accordion-icon"></span>
                    </button>
                    <div class="accordion-content" data-index="{iter.index}">
                        <f:format.html>{item.content}</f:format.html>
                    </div>
                </div>
            </f:for>
        </div>
    </f:if>
</div>
```

### Data Attributes for JavaScript

```html
<div class="accordion-container"
     data-allow-multiple="{f:if(condition: data.allow_multiple, then: '1', else: '0')}"
     data-first-expanded="{f:if(condition: data.first_expanded, then: '1', else: '0')}">
```

## Backend Preview Template

### Informative Preview

```html
<div class="content-block-backend-preview">
    <strong>
        <core:icon identifier="content-accordion" size="small" />
        Accordion
    </strong>
    
    <f:if condition="{data.vendor_accordion_accordion_items}">
        <f:then>
            <div>
                <strong>Panels:</strong> {data.vendor_accordion_accordion_items -> f:count()}
            </div>
            
            <div class="accordion-preview">
                <f:for each="{data.vendor_accordion_accordion_items}" as="item" iteration="iter">
                    <div class="preview-item">
                        <span class="icon">
                            {f:if(condition: '{data.first_expanded} && {iter.isFirst}', 
                                  then: '▼', else: '▶')}
                        </span>
                        <strong>{item.header}</strong>
                        <f:if condition="{item.content}">
                            <div class="preview-content">
                                <f:format.crop maxCharacters="100">
                                    <f:format.stripTags>{item.content}</f:format.stripTags>
                                </f:format.crop>
                            </div>
                        </f:if>
                    </div>
                </f:for>
            </div>
        </f:then>
        <f:else>
            <div class="warning">No accordion panels defined</div>
        </f:else>
    </f:if>
    
    <div class="settings">
        <f:if condition="{data.first_expanded}">
            ✓ First panel expanded
        </f:if>
        <f:if condition="{data.allow_multiple}">
            ✓ Multiple panels allowed
        </f:if>
    </div>
</div>
```

## JavaScript Implementation Examples

### Vanilla JavaScript

```javascript
class Accordion {
    constructor(element) {
        this.element = element;
        this.allowMultiple = element.dataset.allowMultiple === '1';
        this.panels = element.querySelectorAll('.accordion-item');
        this.activeIndices = [];
        
        if (element.dataset.firstExpanded === '1') {
            this.activeIndices.push(0);
        }
        
        this.init();
    }
    
    init() {
        this.panels.forEach((panel, index) => {
            const header = panel.querySelector('.accordion-header');
            const content = panel.querySelector('.accordion-content');
            
            header.addEventListener('click', () => this.toggle(index));
            
            if (this.activeIndices.includes(index)) {
                content.style.display = 'block';
            } else {
                content.style.display = 'none';
            }
        });
    }
    
    toggle(index) {
        const content = this.panels[index].querySelector('.accordion-content');
        const isActive = this.activeIndices.includes(index);
        
        if (!this.allowMultiple) {
            this.closeAll();
        }
        
        if (isActive) {
            this.close(index);
        } else {
            this.open(index);
        }
    }
    
    open(index) {
        this.activeIndices.push(index);
        this.panels[index].querySelector('.accordion-content').style.display = 'block';
    }
    
    close(index) {
        this.activeIndices = this.activeIndices.filter(i => i !== index);
        this.panels[index].querySelector('.accordion-content').style.display = 'none';
    }
    
    closeAll() {
        this.activeIndices = [];
        this.panels.forEach(panel => {
            panel.querySelector('.accordion-content').style.display = 'none';
        });
    }
}

// Initialize all accordions
document.querySelectorAll('.accordion-container').forEach(el => {
    new Accordion(el);
});
```

### See Framework-Specific Implementations

- [Alpine.js Integration](../frameworks/alpine-js-integration.md)
- React: Coming soon
- Vue: Coming soon

## Accessibility

### ARIA Attributes

```html
<button class="accordion-header" 
        role="button"
        aria-expanded="false"
        aria-controls="panel-{iter.index}">
    {item.header}
</button>
<div class="accordion-content" 
     id="panel-{iter.index}"
     role="region"
     aria-labelledby="header-{iter.index}">
    {item.content}
</div>
```

### Keyboard Navigation

- Enter/Space: Toggle panel
- Arrow keys: Navigate between headers
- Home/End: Jump to first/last panel

## CSS Styling

### Basic Styles

```css
.accordion-item {
    border: 1px solid #e5e7eb;
    border-radius: 0.5rem;
    margin-bottom: 0.5rem;
    overflow: hidden;
}

.accordion-header {
    width: 100%;
    padding: 1rem;
    text-align: left;
    background: white;
    border: none;
    cursor: pointer;
    display: flex;
    justify-content: space-between;
    align-items: center;
    transition: background-color 0.2s;
}

.accordion-header:hover {
    background-color: #f9fafb;
}

.accordion-content {
    padding: 1rem;
    background-color: #f9fafb;
    border-top: 1px solid #e5e7eb;
}

.accordion-icon {
    transition: transform 0.2s;
}

.accordion-item.active .accordion-icon {
    transform: rotate(180deg);
}
```

## Testing Checklist

### Functionality

- [ ] Panels open and close correctly
- [ ] First panel opens if configured
- [ ] Multiple panels work if enabled
- [ ] Single panel mode closes others

### Accessibility

- [ ] Keyboard navigation works
- [ ] ARIA attributes update correctly
- [ ] Screen reader announces state changes

### Performance

- [ ] Smooth animations
- [ ] No layout shift
- [ ] Fast interaction response

### Edge Cases

- [ ] Empty accordion handled
- [ ] Single panel accordion works
- [ ] Long content doesn't break layout
- [ ] HTML content renders correctly
