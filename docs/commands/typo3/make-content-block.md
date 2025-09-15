# /prefix:typo3:make-content-block

Wrapper for TYPO3 make:content-block command with intelligent defaults.

## Purpose

Intelligent wrapper for the native TYPO3 `make:content-block` command with sensible defaults, configuration management, and skeleton templates.

## Syntax

```bash
/prefix:typo3:make-content-block [--vendor=...] [--type=...] [--skeleton-path=...] [--config-path=...] [--create-skeleton] [--batch=...] [--migrate-from=...]
```

## Options

| Option | Description |
|--------|-------------|
| `--vendor=...` | Vendor name for content block |
| `--type=...` | Content type (content-element, page-type, record-type) |
| `--skeleton-path=...` | Path to skeleton templates |
| `--config-path=...` | Path to configuration file |
| `--create-skeleton` | Create custom skeleton template |
| `--batch=...` | Create multiple blocks from definition file |
| `--migrate-from=...` | Migrate from existing solution (mask, dce) |

## Examples

### Basic Usage

```bash
# Interactive mode with auto-detection
/prefix:typo3:make-content-block

# Specify vendor
/prefix:typo3:make-content-block --vendor=mycompany

# Create page type
/prefix:typo3:make-content-block --type=page-type
```

### Advanced Features

```bash
# Create custom skeleton
/prefix:typo3:make-content-block --create-skeleton

# Batch creation
/prefix:typo3:make-content-block --batch=content-blocks-definition.yaml

# Migrate from Mask
/prefix:typo3:make-content-block --migrate-from=mask --mask-key=slider
```

## Configuration Management

The command automatically manages `content-blocks.yaml`:

```yaml
vendor: mycompany
extension: sitepackage
content-type: content-element
skeleton-path: .claude/typo3/skeletons
```

## Available Skeletons

| Skeleton | Purpose |
|----------|---------|
| **hero** | Full-width hero section |
| **card-grid** | Responsive card grid |
| **accordion** | Expandable accordion |
| **landing-page** | Landing page type |
| **custom** | Start from scratch |

## Workflows

### Standard Content Block

```bash
/prefix:typo3:make-content-block --vendor=mycompany
# Select from available skeletons
# Customize field configuration
# Clear caches automatically
```

### Custom Skeleton Creation

```bash
/prefix:typo3:make-content-block --create-skeleton
# Define skeleton structure
# Save for future use
# Apply to new content blocks
```

## Prerequisites

Requires `friendsoftypo3/content-blocks` extension:

```bash
composer require friendsoftypo3/content-blocks:^1.3
```

## See Also

- [/prefix:typo3:content-blocks](content-blocks.md) - Generate Content Blocks v1.3
- [TYPO3 Content Blocks](https://docs.typo3.org/p/content-blocks/content-blocks/main/en-us/) - Official documentation
