# /prefix:typo3:content-blocks

Generate TYPO3 Content Blocks v1.3 with modern field configurations.

## Purpose

Generates Content Blocks v1.3 compatible configurations for TYPO3 v13.4 with intelligent field management and Fluid v4 component integration.

## Syntax

```bash
/prefix:typo3:content-blocks [name] [--type=element|page] [--fields=...] [--sitepackage=path] [--with-components] [--component-type=inline|external]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `name` | *required* | Content block name |

## Options

| Option | Description |
|--------|-------------|
| `--type=element\|page` | Content Element (default) or Page Type |
| `--fields=...` | Comma-separated list of fields to include |
| `--sitepackage=path` | Target sitepackage path |
| `--with-components` | Generate Fluid v4 Components alongside Content Block |
| `--component-type=inline\|external` | Inline components in template or external component files |

## Examples

### Basic Usage

```bash
# Create simple content element
/prefix:typo3:content-blocks hero-section

# Create with specific fields
/prefix:typo3:content-blocks hero-section --fields="headline,text,image,link"

# Create page type
/prefix:typo3:content-blocks landing-page --type=page
```

### Advanced Usage

```bash
# With Fluid components
/prefix:typo3:content-blocks hero-section --with-components --component-type=external

# Target specific sitepackage
/prefix:typo3:content-blocks hero --sitepackage=packages/mysite
```

## Workflows

### Content Element Creation

```bash
/prefix:typo3:content-blocks hero-section --fields="headline,text,image"
# Review generated configuration
# Customize field settings as needed
```

### Page Type with Components

```bash
/prefix:typo3:content-blocks landing-page --type=page --with-components
# Configure TypoScript mapping
# Test in backend
```

## See Also

- [/prefix:typo3:make-content-block](make-content-block.md) - Individual content block creation
- [TYPO3 Content Blocks Documentation](https://docs.typo3.org/p/content-blocks/content-blocks/main/en-us/)
