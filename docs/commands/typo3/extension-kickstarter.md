# /prefix:typo3:extension-kickstarter

Create TYPO3 extensions using ext-kickstarter or manual scaffolding.

## Purpose

Creates complete TYPO3 extensions using either the stefanfroemken/ext-kickstarter package or manual scaffolding with best practices for TYPO3 v13.4.

## Syntax

```bash
/prefix:typo3:extension-kickstarter [extension-key] [--type=...] [--use-kickstarter] [--composer-name=...] [--with-backend-module] [--with-plugin] [--with-middleware] [--with-command] [--with-event-listener] [--with-tests]
```

## Arguments

| Argument | Default | Description |
|----------|---------|-------------|
| `extension-key` | *interactive* | Extension key (lowercase, underscores) |

## Options

| Option | Description |
|--------|-------------|
| `--type=...` | Extension type (basic, plugin, backend, service, content) |
| `--use-kickstarter` | Use stefanfroemken/ext-kickstarter if available |
| `--composer-name=...` | Custom composer package name |
| `--with-backend-module` | Add backend module |
| `--with-plugin` | Add frontend plugin |
| `--with-middleware` | Add PSR-15 middleware |
| `--with-command` | Add console command |
| `--with-event-listener` | Add event listener |
| `--with-tests` | Add testing setup |

## Examples

### Basic Usage

```bash
# Interactive mode
/prefix:typo3:extension-kickstarter

# Create basic extension
/prefix:typo3:extension-kickstarter my_extension

# Create plugin extension
/prefix:typo3:extension-kickstarter my_plugin --with-plugin
```

### Advanced Usage

```bash
# Full-featured extension
/prefix:typo3:extension-kickstarter my_extension \
  --with-backend-module \
  --with-plugin \
  --with-command \
  --with-tests

# Using kickstarter tool
/prefix:typo3:extension-kickstarter my_extension --use-kickstarter
```

## Extension Types

| Type | Purpose |
|------|---------|
| **Basic** | Simple extension structure |
| **Plugin** | Extbase/Fluid plugin extension |
| **Backend** | Backend module extension |
| **Service** | API/Services extension |
| **Content** | Content Elements extension |

## Workflows

### Standard Extension Creation

```bash
/prefix:typo3:extension-kickstarter my_extension --with-plugin --with-tests
# Review generated structure
# Install and activate extension
# Begin development
```

### Backend Module Extension

```bash
/prefix:typo3:extension-kickstarter admin_tools --with-backend-module --with-command
# Configure backend routes
# Implement module functionality
```

## See Also

- [TYPO3 Extension Development](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/) - TYPO3 extension architecture
- [stefanfroemken/ext-kickstarter](https://github.com/froemken/ext-kickstarter) - Extension kickstarter tool
