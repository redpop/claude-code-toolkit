# TYPO3 v13 Sitepackage Installation & Setup Guide

## Overview

This guide provides comprehensive instructions for creating, configuring, and installing a TYPO3 v13 sitepackage extension. A sitepackage is the foundation of any TYPO3 project, containing templates, configurations, and assets.

## Prerequisites

- TYPO3 v13.4+ installation
- Composer-based TYPO3 setup
- DDEV or similar local development environment
- Basic understanding of TYPO3 concepts

## Step 1: Generate Sitepackage Structure

### Option A: Using TYPO3 Sitepackage Builder

1. Visit [https://get.typo3.org/sitepackage/new/](https://get.typo3.org/sitepackage/new/)
2. Fill in the form:
   - **Vendor Name**: Your company/organization (e.g., `punktde`)
   - **Package Name**: Your package identifier (e.g., `sitepackage`)
   - **Extension Title**: Human-readable name
   - **Author Details**: Name, email, company
3. Download the generated ZIP file
4. Extract to `packages/` directory in your TYPO3 project

### Option B: Manual Creation

Create the following directory structure in `packages/{vendor}/{package}/`:

```
packages/
└── punktde/
    └── sitepackage/
        ├── Classes/
        ├── Configuration/
        ├── Resources/
        ├── composer.json
        ├── ext_emconf.php
        ├── ext_localconf.php
        └── ext_tables.php
```

## Step 2: Configure Composer

### 2.1 Create composer.json in Sitepackage

```json
{
    "name": "punktde/sitepackage",
    "type": "typo3-cms-extension",
    "description": "TYPO3 Sitepackage for Project",
    "homepage": "https://punkt.de",
    "license": ["GPL-2.0-or-later"],
    "keywords": ["TYPO3 CMS", "Sitepackage"],
    "authors": [
        {
            "name": "Your Name",
            "email": "email@domain.com",
            "role": "Developer"
        }
    ],
    "require": {
        "typo3/cms-core": "^13.4",
        "typo3/cms-rte-ckeditor": "^13.4",
        "typo3/cms-fluid-styled-content": "^13.4"
    },
    "autoload": {
        "psr-4": {
            "Punktde\\Sitepackage\\": "Classes/"
        }
    },
    "extra": {
        "typo3/cms": {
            "extension-key": "sitepackage"
        }
    }
}
```

### 2.2 Register in Root composer.json

Add to your project's root `composer.json`:

```json
{
    "repositories": [
        {
            "type": "path",
            "url": "packages/punktde/sitepackage"
        }
    ]
}
```

### 2.3 Require the Package

```bash
# Install the sitepackage
ddev composer require punktde/sitepackage:@dev

# Clear composer cache if needed
ddev composer clear-cache
```

## Step 3: Create Extension Configuration

### 3.1 ext_emconf.php

```php
<?php

$EM_CONF[$_EXTKEY] = [
    'title' => 'Project Sitepackage',
    'description' => 'Sitepackage for TYPO3 project',
    'category' => 'templates',
    'version' => '1.0.0',
    'state' => 'stable',
    'clearCacheOnLoad' => true,
    'author' => 'Your Name',
    'author_email' => 'email@domain.com',
    'author_company' => 'Company Name',
    'constraints' => [
        'depends' => [
            'typo3' => '13.4.0-13.4.99',
            'fluid_styled_content' => '13.4.0-13.4.99',
            'rte_ckeditor' => '13.4.0-13.4.99',
        ],
    ],
    'autoload' => [
        'psr-4' => [
            'Punktde\\Sitepackage\\' => 'Classes',
        ],
    ],
];
```

### 3.2 ext_localconf.php

```php
<?php
defined('TYPO3') or die('Access denied.');

// Add default RTE configuration
$GLOBALS['TYPO3_CONF_VARS']['RTE']['Presets']['sitepackage'] = 
    'EXT:sitepackage/Configuration/RTE/Default.yaml';

// Add custom page TSconfig
\TYPO3\CMS\Core\Utility\ExtensionManagementUtility::addPageTSConfig(
    '@import \'EXT:sitepackage/Configuration/Sets/SitePackage/page.tsconfig\''
);
```

### 3.3 ext_tables.php

```php
<?php
defined('TYPO3') or die('Access denied.');

// Usually empty in modern TYPO3 v13 setups
// Configuration is handled via Site Sets
```

## Step 4: Configure Site Sets (TYPO3 v13)

### 4.1 Create Configuration/Sets/SitePackage/config.yaml

```yaml
name: punktde/sitepackage
label: 'Project Sitepackage'
dependencies:
  - typo3/fluid-styled-content
  - typo3/fluid-styled-content-css
```

### 4.2 Create Configuration/Sets/SitePackage/settings.yaml

```yaml
# Template paths for content elements
styles:
  templates:
    layoutRootPath: 'EXT:sitepackage/Resources/Private/ContentElements/Layouts/'
    partialRootPath: 'EXT:sitepackage/Resources/Private/ContentElements/Partials/'
    templateRootPath: 'EXT:sitepackage/Resources/Private/ContentElements/Templates/'

# Page configuration
page:
  pageview:
    paths: 'EXT:sitepackage/Resources/Private/PageView/'
  
  meta:
    viewport: 'width=device-width, initial-scale=1'
    robots: 'index,follow'
    apple-mobile-web-app-capable: 'no'
    compatible: 'IE=edge'
  
  favicon:
    file: 'EXT:sitepackage/Resources/Public/Icons/favicon.ico'
  
  tracking:
    google:
      trackingID: ''
      anonymizeIp: '1'

# General configuration
config:
  no_cache: '0'
  removeDefaultJS: '0'
  admPanel: '1'
  prefixLocalAnchors: 'all'
  headerComment: 'Powered by TYPO3'
  sendCacheHeaders: '1'
  compressJs: '1'
  compressCss: '1'
  concatenateJs: '1'
  concatenateCss: '1'
```

### 4.3 Create Configuration/Sets/SitePackage/setup.typoscript

```typoscript
# Import TypoScript files
@import './TypoScript/'
```

### 4.4 Create Configuration/Sets/SitePackage/page.tsconfig

```tsconfig
# Import backend layouts
@import './PageTsConfig/BackendLayouts/'

# RTE Configuration
RTE {
    default {
        preset = sitepackage
    }
}

# Backend Form adjustments
TCEFORM {
    pages {
        # Customize page properties
    }
    tt_content {
        # Customize content element properties
    }
}
```

## Step 5: Activate the Extension

### 5.1 Via Command Line

```bash
# Activate the extension
ddev exec vendor/bin/typo3 extension:setup

# Or activate specific extension
ddev exec vendor/bin/typo3 extension:activate sitepackage

# Clear all caches
ddev exec vendor/bin/typo3 cache:flush
```

### 5.2 Via Install Tool

1. Login to TYPO3 backend
2. Go to **Admin Tools** → **Extensions**
3. Find your sitepackage in the list
4. Click **Activate**

## Step 6: Configure Site Configuration

### 6.1 Edit Site Configuration

1. Go to **Site Management** → **Sites**
2. Edit your site configuration
3. Under **Site Sets**, add your sitepackage:
   - Select `punktde/sitepackage` from available sets

### 6.2 Via YAML (config/sites/main/config.yaml)

```yaml
base: 'https://example.ddev.site/'
rootPageId: 1
routes:
  -
    route: robots.txt
    type: staticText
    content: |
      User-agent: *
      Allow: /
sets:
  - punktde/sitepackage
  - typo3/fluid-styled-content
  - typo3/fluid-styled-content-css
languages:
  -
    title: English
    enabled: true
    languageId: 0
    base: /
    locale: en_US.UTF-8
    navigationTitle: English
    flag: us
```

## Step 7: Verify Installation

### 7.1 Check Extension Status

```bash
# List all extensions
ddev exec vendor/bin/typo3 extension:list

# Should show:
# sitepackage     1.0.0    active
```

### 7.2 Check Database Schema

```bash
# Update database schema if needed
ddev exec vendor/bin/typo3 database:updateschema
```

### 7.3 Clear Caches

```bash
# Clear all caches
ddev exec vendor/bin/typo3 cache:flush

# Or more aggressive
ddev exec rm -rf var/cache/*
ddev exec vendor/bin/typo3 cache:warmup
```

### 7.4 Test Frontend

1. Open your site in browser
2. Check browser console for errors
3. Verify templates are loading
4. Check if CSS/JS files are included

## Step 8: Directory Permissions

Ensure correct permissions:

```bash
# Set correct permissions
ddev exec chmod -R 755 packages/punktde/sitepackage
ddev exec chmod -R 644 packages/punktde/sitepackage/**/*.{php,yaml,html,css,js}
```

## Common Installation Issues

### Issue: Extension Not Found

**Symptom**: Composer can't find the package

**Solution**:

```bash
# Check if path is correct
ls -la packages/punktde/sitepackage/

# Clear composer cache
ddev composer clear-cache

# Update composer
ddev composer update
```

### Issue: Class Not Found

**Symptom**: PHP class autoloading errors

**Solution**:

```bash
# Regenerate autoload files
ddev composer dump-autoload

# Clear TYPO3 caches
ddev exec vendor/bin/typo3 cache:flush
```

### Issue: Templates Not Loading

**Symptom**: Blank pages or missing templates

**Solution**:

1. Check Site Sets configuration
2. Verify template paths in settings.yaml
3. Clear all caches
4. Check TYPO3 log files

### Issue: Database Schema Errors

**Symptom**: SQL errors or missing tables

**Solution**:

```bash
# Update database schema
ddev exec vendor/bin/typo3 database:updateschema

# Analyze schema
ddev exec vendor/bin/typo3 database:analyze
```

## Best Practices

1. **Version Control**: Always commit your sitepackage to Git
2. **Semantic Versioning**: Use proper version numbers (1.0.0, 1.1.0, etc.)
3. **Documentation**: Keep README.md updated in your sitepackage
4. **Testing**: Test installation on fresh TYPO3 instances
5. **Dependencies**: Keep dependencies minimal and well-defined
6. **Naming**: Use consistent, meaningful names for your vendor/package

## Next Steps

After successful installation:

1. [Configure Backend Layouts](./sitepackage-backend-layouts.md)
2. [Set Up Page Templates](./sitepackage-page-templates.md)
3. [Configure TypoScript](./sitepackage-typoscript.md)
4. [Add Content Elements](./sitepackage-content-elements.md)
5. [Integrate Content Blocks](./content-blocks-integration.md)

## Related Documentation

- [Sitepackage Structure Reference](./sitepackage-structure-reference.md)
- [Sitepackage Configuration Guide](./sitepackage-configuration-guide.md)
- [TYPO3 v13 Template Reference](./sitepackage-v13-template.md)
- [Troubleshooting Matrix](./troubleshooting-matrix.md)
