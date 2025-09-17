# /prefix:typo3:sitepackage

Create TYPO3 sitepackage extensions with modern architecture and best practices.

## Purpose

Creates complete TYPO3 sitepackage extensions following current best practices for TYPO3 v13.4 with TypoScript, templates, assets, and configuration.

## Syntax

```bash
/prefix:typo3:sitepackage [package-name] [--template=...] [--with-components] [--with-content-blocks] [--bootstrap] [--tailwind]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `package-name` | *interactive* | Sitepackage name |

## Options

| Option | Description |
|--------|-------------|
| `--template=...` | Base template (default, bootstrap, tailwind, custom) |
| `--with-components` | Include Fluid v4 Components |
| `--with-content-blocks` | Include Content Blocks setup |
| `--bootstrap` | Include Bootstrap CSS framework |
| `--tailwind` | Include Tailwind CSS setup |

## Examples

### Basic Usage

```bash
# Interactive mode
/prefix:typo3:sitepackage

# Create with package name
/prefix:typo3:sitepackage mysite

# Bootstrap-based sitepackage
/prefix:typo3:sitepackage mysite --bootstrap
```

### Modern Features

```bash
# With Fluid Components and Content Blocks
/prefix:typo3:sitepackage mysite --with-components --with-content-blocks

# Tailwind CSS setup
/prefix:typo3:sitepackage mysite --tailwind --with-components
```

## See Also

- [TYPO3 Sitepackage Tutorial](https://docs.typo3.org/m/typo3/tutorial-sitepackage/main/en-us/) - Official sitepackage guide
- [/prefix:typo3:content-blocks](content-blocks.md) - Content Blocks integration
- [/prefix:typo3:fluid-components](fluid-components.md) - Fluid Components integration
