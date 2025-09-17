# TYPO3 Commands

TYPO3-specific development tools for modern TYPO3 v13.4 development.

## Available Commands

| Command | Purpose |
|---------|---------|
| [content-blocks](content-blocks.md) | Generate TYPO3 Content Blocks v1.3 with modern field configurations |
| [extension-kickstarter](extension-kickstarter.md) | Create TYPO3 extensions using ext-kickstarter or manual scaffolding |
| [fluid-components](fluid-components.md) | Generate TYPO3 Fluid v4 Components with modern architecture |
| [make-content-block](make-content-block.md) | Wrapper for TYPO3 make:content-block command with intelligent defaults |
| [sitepackage](sitepackage.md) | Create TYPO3 sitepackage extensions with modern architecture |

## Usage Pattern

TYPO3 commands provide modern development tools for TYPO3 v13.4:

```bash
# Create sitepackage foundation
/prefix:typo3:sitepackage mysite --with-components --with-content-blocks

# Add content blocks
/prefix:typo3:content-blocks hero-section --with-components

# Create Fluid components
/prefix:typo3:fluid-components Card --type=molecule --with-assets

# Extend with custom extension
/prefix:typo3:extension-kickstarter admin_tools --with-backend-module
```

## Development Workflow

### Modern TYPO3 Project Setup

```bash
# 1. Create sitepackage
/prefix:typo3:sitepackage myproject --tailwind --with-content-blocks

# 2. Add content elements
/prefix:typo3:content-blocks hero --fields="headline,text,image"
/prefix:typo3:content-blocks card-grid --fields="cards"

# 3. Create reusable components
/prefix:typo3:fluid-components Button --type=atom
/prefix:typo3:fluid-components Card --type=molecule --with-assets
```

### Extension Development

```bash
# Create extension
/prefix:typo3:extension-kickstarter my_extension --with-backend-module --with-tests

# Add content blocks to extension
/prefix:typo3:make-content-block --vendor=mycompany --extension=my_extension
```

## Integration with Core Commands

TYPO3 commands work with the 6-command architecture:

```bash
# Analyze TYPO3 project
/prefix:understand . --comprehensive

# Improve TYPO3 code quality
/prefix:improve . --apply-insights

# Security audit for TYPO3
/prefix:secure . --audit
```

## See Also

- [Core Commands](../README.md) - Main 6-command architecture
- [Meta Commands](../meta/README.md) - Project and toolkit management
- [TYPO3 Documentation](https://docs.typo3.org/) - Official TYPO3 documentation
