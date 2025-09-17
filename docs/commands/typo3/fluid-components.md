# /prefix:typo3:fluid-components

Generate TYPO3 Fluid v4 Components with modern architecture patterns.

## Purpose

Creates Fluid v4 Components following TYPO3 v13.4 best practices with proper component architecture, ViewHelper integration, and asset management.

## Syntax

```bash
/prefix:typo3:fluid-components [component-name] [--type=...] [--namespace=...] [--with-assets] [--with-viewhelper] [--atomic]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `component-name` | *interactive* | Component name (PascalCase) |

## Options

| Option | Description |
|--------|-------------|
| `--type=atom\|molecule\|organism\|template` | Component type following Atomic Design |
| `--namespace=...` | Custom component namespace |
| `--with-assets` | Generate CSS/JS assets for component |
| `--with-viewhelper` | Create accompanying ViewHelper |
| `--atomic` | Use Atomic Design methodology |

## Examples

### Basic Usage

```bash
# Create simple component
/prefix:typo3:fluid-components Button

# Create with assets
/prefix:typo3:fluid-components Card --with-assets

# Create with ViewHelper
/prefix:typo3:fluid-components Gallery --with-viewhelper
```

### Atomic Design

```bash
# Atom component
/prefix:typo3:fluid-components Button --type=atom --atomic

# Molecule component
/prefix:typo3:fluid-components Card --type=molecule --with-assets

# Organism component
/prefix:typo3:fluid-components Header --type=organism --with-viewhelper
```

## Component Types

| Type | Purpose | Examples |
|------|---------|----------|
| **Atom** | Basic building blocks | Button, Input, Icon |
| **Molecule** | Simple component groups | Card, Form Field, Menu Item |
| **Organism** | Complex UI sections | Header, Footer, Product List |
| **Template** | Page layout templates | Two Column, Landing Page |

## Generated Structure

```
Components/
├── Atoms/
│   └── Button/
│       ├── Button.html
│       ├── Button.css
│       └── Button.js
├── Molecules/
├── Organisms/
└── Templates/
```

## Workflows

### Component Development

```bash
/prefix:typo3:fluid-components Card --type=molecule --with-assets
# Implement component logic
# Style with CSS
# Add JavaScript behavior
# Test in Fluid templates
```

### ViewHelper Integration

```bash
/prefix:typo3:fluid-components Gallery --with-viewhelper
# Implement ViewHelper logic
# Add component template
# Register in Services.yaml
```

## See Also

- [Atomic Design Methodology](https://atomicdesign.bradfrost.com/) - Component design principles
- [TYPO3 Fluid Documentation](https://docs.typo3.org/other/typo3/view-helper-reference/main/en-us/) - Fluid ViewHelper reference
