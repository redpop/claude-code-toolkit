# Alpine.js Integration with TYPO3 Content Blocks

## Overview

Alpine.js is a lightweight JavaScript framework ideal for adding interactivity to server-rendered HTML. This guide covers integration patterns specific to Alpine.js with TYPO3 Content Blocks.

## Setup

### CDN Inclusion

```html
<!-- In your Fluid template -->
<f:asset.script identifier="alpine-js" 
                src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js" 
                defer="true" 
                external="true" />
```

### With Tailwind CSS v4

```html
<!-- Note: Tailwind v4 CDN must be included as script, not CSS -->
<f:asset.script identifier="tailwind-css" 
                src="https://cdn.jsdelivr.net/npm/@tailwindcss/cdn@4.0.0-alpha.37" 
                external="true" />
```

## Fluid/Alpine Integration Patterns

### Critical: Separation of Concerns

Alpine.js and Fluid operate at different times:

- Fluid: Server-side, during template rendering
- Alpine.js: Client-side, in the browser

**Never mix Fluid ViewHelpers inside Alpine.js expressions!**

### Data Transfer Pattern

Use data attributes to pass Fluid data to Alpine.js:

```html
<!-- ✅ CORRECT: Use data attributes -->
<div x-data="componentName()"
     data-setting="{f:if(condition: data.field, then: '1', else: '0')}">
     
<script>
function componentName() {
    return {
        init() {
            this.setting = this.$el.dataset.setting === '1';
        }
    }
}
</script>

<!-- ❌ WRONG: Mixing Fluid in Alpine expression -->
<div x-data="{ active: {f:if(condition: data.field, then: true, else: false)} }">
```

## Component Patterns

### Basic Interactive Component

```html
<div x-data="{ open: false }">
    <button @click="open = !open">Toggle</button>
    <div x-show="open">Content</div>
</div>
```

### Component with Fluid Data

```html
<div x-data="accordionComponent()"
     data-allow-multiple="{f:if(condition: data.allow_multiple, then: '1', else: '0')}"
     data-default-open="{f:if(condition: data.first_expanded, then: '1', else: '0')}">
    
    <f:for each="{data.items}" as="item" iteration="iter">
        <button @click="toggle({iter.index})">
            {item.title}
        </button>
        <div x-show="isOpen({iter.index})">
            {item.content}
        </div>
    </f:for>
</div>

<script>
function accordionComponent() {
    return {
        activeItems: [],
        allowMultiple: false,
        
        init() {
            this.allowMultiple = this.$el.dataset.allowMultiple === '1';
            if (this.$el.dataset.defaultOpen === '1') {
                this.activeItems.push(0);
            }
        },
        
        toggle(index) {
            if (!this.allowMultiple) {
                this.activeItems = this.activeItems.includes(index) ? [] : [index];
            } else {
                const pos = this.activeItems.indexOf(index);
                if (pos > -1) {
                    this.activeItems.splice(pos, 1);
                } else {
                    this.activeItems.push(index);
                }
            }
        },
        
        isOpen(index) {
            return this.activeItems.includes(index);
        }
    }
}
</script>
```

## Alpine.js Directives Reference

### Core Directives

- `x-data`: Initialize component state
- `x-show`: Toggle visibility (display: none)
- `x-if`: Conditional rendering (adds/removes from DOM)
- `x-for`: Loop through arrays
- `@click`: Click event handler
- `x-model`: Two-way data binding
- `x-text`: Set text content
- `x-html`: Set HTML content
- `:class`: Dynamic classes
- `x-transition`: Animations

### Transition Effects

```html
<div x-show="open"
     x-transition:enter="transition ease-out duration-200"
     x-transition:enter-start="opacity-0 transform -translate-y-2"
     x-transition:enter-end="opacity-100 transform translate-y-0"
     x-transition:leave="transition ease-in duration-150"
     x-transition:leave-start="opacity-100 transform translate-y-0"
     x-transition:leave-end="opacity-0 transform -translate-y-2">
    Content with smooth transitions
</div>
```

## Common Pitfalls & Solutions

### 1. Fluid Expression in JavaScript

**Problem:**

```javascript
// ❌ Causes syntax error
x-data="{ active: <f:if condition='{data.active}' then='true' else='false' /> }"
```

**Solution:**

```javascript
// ✅ Use data attributes
data-active="{f:if(condition: data.active, then: '1', else: '0')}"
x-data="{ active: $el.dataset.active === '1' }"
```

### 2. String vs Boolean Confusion

**Problem:**

```javascript
// ❌ String '0' is truthy in JavaScript
if (this.$el.dataset.setting) { /* Always true */ }
```

**Solution:**

```javascript
// ✅ Explicit comparison
if (this.$el.dataset.setting === '1') { /* Works correctly */ }
```

### 3. Iterating with Indices

**Problem:**

```html
<!-- ❌ No index available -->
<f:for each="{items}" as="item">
    <button @click="toggle(???)">
```

**Solution:**

```html
<!-- ✅ Use iteration helper -->
<f:for each="{items}" as="item" iteration="iter">
    <button @click="toggle({iter.index})">
```

### 4. Alpine Not Initializing

**Problem:** Alpine code runs before Alpine.js loads

**Solution:** Use defer attribute

```html
<f:asset.script identifier="alpine-js" 
                src="..." 
                defer="true"  <!-- Important! -->
                external="true" />
```

## Testing & Debugging

### Browser Console Commands

```javascript
// Get Alpine component data
document.querySelector('[x-data]')._x_dataStack

// Trigger Alpine updates
$dispatch('update')

// Check Alpine version
Alpine.version
```

### Debug Output

```html
<!-- Show component state -->
<div x-data="{ items: [1,2,3] }">
    <pre x-text="JSON.stringify($data, null, 2)"></pre>
</div>
```

## Performance Considerations

### 1. Use x-show vs x-if

- `x-show`: Faster toggling, keeps in DOM
- `x-if`: Removes from DOM, better for large content

### 2. Defer Complex Initialization

```javascript
init() {
    // Defer heavy operations
    this.$nextTick(() => {
        this.initializeComplexStuff();
    });
}
```

### 3. Avoid Deep Reactivity

```javascript
// Prefer flat state structure
x-data="{
    item1Active: false,
    item2Active: false
}"

// Over nested structures
x-data="{
    items: { 1: { active: false }, 2: { active: false } }
}"
```

## Migration Guide

### To React/Vue

When migrating from Alpine.js:

1. Data attributes remain the same
2. Replace Alpine directives with framework equivalents
3. Move inline functions to component methods
4. Convert x-data to component state

### Example Migration Map

| Alpine.js | React | Vue |
|-----------|-------|-----|
| x-data | useState | data() |
| x-show | conditional rendering | v-show |
| x-if | conditional rendering | v-if |
| @click | onClick | @click |
| x-model | controlled components | v-model |
| x-for | map() | v-for |
