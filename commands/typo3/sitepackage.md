---
allowed-tools: Write, Bash(mkdir:*), Bash(composer:*)
description: Create a TYPO3 v13.4 SitePackage based on official template with Site Sets
argument-hint: "[vendor] [package-name] [--include-ddev] [--include-docker] [--author=name] [--email=address]"
---

# TYPO3 v13 SitePackage Generator (Official Template)

Creates a complete TYPO3 v13.4 compatible SitePackage based on the official template from <https://get.typo3.org/sitepackage> with modern Site Sets configuration and Fluid Styled Content integration.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Create a TYPO3 v13.4 SitePackage based on official template with Site Sets
- **Usage**: [vendor] [package-name] [--include-ddev] [--include-docker] [--author=name] [--email=address]
- **Options**: --include-ddev, --include-docker, --author, --email
- **Examples**: See the complete file structure and configuration examples below

Then exit without executing the main command.

---

## Usage

```bash
/prefix:typo3:sitepackage [vendor] [package-name] [options]
```

## Command Workflow

Parse the arguments from $ARGUMENTS to extract:

- Vendor name (e.g., "mycompany")
- Package name (e.g., "corporate-site")
- Optional flags like --include-ddev, --include-docker, --author, --email, etc.

If arguments are missing, ask the user for:

1. Vendor name (lowercase, no spaces)
2. Package name (kebab-case)
3. Extension title
4. Author name
5. Author email
6. Author company (optional)

Then create the complete sitepackage structure based on the official TYPO3 v13 template.

## Complete File Structure and Contents

Create the following directory structure:

```
packages/{vendor}/{package}/
├── Classes/
│   ├── Controller/
│   ├── Domain/
│   │   ├── Model/
│   │   └── Repository/
│   └── ViewHelpers/
├── Configuration/
│   ├── RTE/
│   │   └── Default.yaml
│   ├── Sets/
│   │   └── SitePackage/
│   │       ├── PageTsConfig/
│   │       │   └── BackendLayouts/
│   │       │       └── default.tsconfig
│   │       ├── TypoScript/
│   │       │   ├── config.typoscript
│   │       │   └── page.typoscript
│   │       ├── config.yaml
│   │       ├── page.tsconfig
│   │       ├── settings.yaml
│   │       └── setup.typoscript
├── Resources/
│   ├── Private/
│   │   ├── ContentElements/
│   │   │   ├── Layouts/
│   │   │   ├── Partials/
│   │   │   └── Templates/
│   │   ├── Language/
│   │   │   ├── locallang.xlf
│   │   │   ├── locallang_be.xlf
│   │   │   └── locallang_db.xlf
│   │   └── PageView/
│   │       ├── Layouts/
│   │       │   └── Default.html
│   │       ├── Pages/
│   │       │   └── Default.html
│   │       └── Partials/
│   │           └── Content.html
│   └── Public/
│       ├── Css/
│       │   ├── layout.css
│       │   └── rte.css
│       ├── Fonts/
│       ├── Icons/
│       │   ├── Extension.svg
│       │   └── favicon.ico
│       ├── Images/
│       │   └── BackendLayouts/
│       │       └── default.png
│       └── JavaScript/
│           └── main.js
├── composer.json
├── ext_conf_template.txt
├── ext_emconf.php
├── ext_localconf.php
├── ext_tables.php
└── README.md
```

### composer.json

```json
{
    "name": "{vendor}/{package}",
    "type": "typo3-cms-extension",
    "description": "{description}",
    "homepage": "https://{vendor-url}",
    "license": ["GPL-2.0-or-later"],
    "keywords": ["TYPO3 CMS"],
    "require": {
        "typo3/cms-core": "^13.4",
        "typo3/cms-rte-ckeditor": "^13.4",
        "typo3/cms-fluid-styled-content": "^13.4"
    },
    "autoload": {
        "psr-4": {
            "{VendorNamespace}\\{PackageNamespace}\\": "Classes/"
        }
    },
    "extra": {
        "typo3/cms": {
            "extension-key": "{extension-key}"
        }
    }
}
```

### ext_emconf.php

```php
<?php

$EM_CONF[$_EXTKEY] = [
    'title' => '{extension-title}',
    'description' => '{description}',
    'category' => 'templates',
    'constraints' => [
        'depends' => [
            'typo3' => '13.4.0-13.4.99',
            'fluid_styled_content' => '13.4.0-13.4.99',
            'rte_ckeditor' => '13.4.0-13.4.99',
        ],
        'conflicts' => [
        ],
    ],
    'autoload' => [
        'psr-4' => [
            '{VendorNamespace}\\{PackageNamespace}\\' => 'Classes',
        ],
    ],
    'state' => 'stable',
    'uploadfolder' => 0,
    'createDirs' => '',
    'clearCacheOnLoad' => 1,
    'author' => '{author-name}',
    'author_email' => '{author-email}',
    'author_company' => '{author-company}',
    'version' => '1.0.0',
];
```

### ext_localconf.php

```php
<?php

defined('TYPO3') or die('Access denied.');

// Add default RTE configuration
$GLOBALS['TYPO3_CONF_VARS']['RTE']['Presets']['{extension-key}'] = 'EXT:{extension-key}/Configuration/RTE/Default.yaml';
```

### ext_tables.php

```php
<?php

defined('TYPO3') or die('Access denied.');
```

### ext_conf_template.txt

Create an empty file for extension configuration.

### Configuration/Sets/SitePackage/config.yaml

```yaml
name: {vendor}/{package}
label: '{extension-title}'
dependencies:
  - typo3/fluid-styled-content
  - typo3/fluid-styled-content-css
```

### Configuration/Sets/SitePackage/setup.typoscript

```typoscript
@import './TypoScript/'
```

### Configuration/Sets/SitePackage/settings.yaml

```yaml
styles:
  templates:
    layoutRootPath: 'EXT:{extension-key}/Resources/Private/ContentElements/Layouts/'
    partialRootPath: 'EXT:{extension-key}/Resources/Private/ContentElements/Partials/'
    templateRootPath: 'EXT:{extension-key}/Resources/Private/ContentElements/Templates/'

page:
  pageview:
    paths: 'EXT:{extension-key}/Resources/Private/PageView/'

  meta:
    viewport: 'width=device-width, initial-scale=1'
    robots: 'index,follow'
    apple-mobile-web-app-capable: 'no'
    compatible: 'IE=edge'

  tracking:
    google:
      trackingID: ''
      anonymizeIp: '1'

config:
  no_cache: '0'
  removeDefaultJS: '0'
  admPanel: '1'
  prefixLocalAnchors: 'all'
  headerComment: 'build by get.typo3.org/sitepackage'
  sendCacheHeaders: '1'
```

### Configuration/Sets/SitePackage/page.tsconfig

```tsconfig
@import './PageTsConfig/BackendLayouts/'

RTE {
    default {
        preset = {extension-key}
    }
}

TCEFORM {
    pages {

    }
    tt_content {

    }
}

TCEMAIN {

}
```

### Configuration/Sets/SitePackage/PageTsConfig/BackendLayouts/default.tsconfig

```tsconfig
#
# BACKENDLAYOUT: DEFAULT
#
mod {
    web_layout {
        BackendLayouts {
            default {
                title = LLL:EXT:{extension-key}/Resources/Private/Language/locallang_be.xlf:backend_layout.default
                config {
                    backend_layout {
                        colCount = 1
                        rowCount = 1
                        rows {
                            1 {
                                columns {
                                    1 {
                                        name = LLL:EXT:{extension-key}/Resources/Private/Language/locallang_be.xlf:backend_layout.column.normal
                                        colPos = 0
                                        identifier = main
                                    }
                                }
                            }
                        }
                    }
                }
                icon = EXT:{extension-key}/Resources/Public/Icons/BackendLayouts/default.svg
            }
        }
    }
}
```

### Configuration/Sets/SitePackage/TypoScript/config.typoscript

```typoscript
################
#### CONFIG ####
################
config {
    absRefPrefix = auto
    no_cache = {$config.no_cache}
    uniqueLinkVars = 1
    pageTitleFirst = 1
    linkVars = L
    prefixLocalAnchors = {$config.prefixLocalAnchors}
    renderCharset = utf-8
    metaCharset = utf-8
    doctype = html5
    removeDefaultJS = {$config.removeDefaultJS}
    inlineStyle2TempFile = 1
    admPanel = {$config.admPanel}
    debug = 0
    cache_period = 86400
    sendCacheHeaders = {$config.sendCacheHeaders}
    intTarget =
    extTarget =
    disablePrefixComment = 1
    index_enable = 1
    index_externals = 1
    index_metatags = 1
    headerComment = {$config.headerComment}

    // Disable Image Upscaling
    noScaleUp = 1

    // Compression and Concatenation of CSS and JS Files
    compressJs = 0
    compressCss = 0
    concatenateJs = 0
    concatenateCss = 0
}
```

### Configuration/Sets/SitePackage/TypoScript/page.typoscript

```typoscript
##############
#### PAGE ####
##############
page = PAGE
page {
    typeNum = 0
    shortcutIcon = EXT:{extension-key}/Resources/Public/Icons/favicon.ico

    10 = PAGEVIEW
    10 {
        paths {
            0 = EXT:{extension-key}/Resources/Private/PageView/
            1 = {$page.pageview.paths}
        }
        dataProcessing {
            10 = files
            10 {
                references.fieldName = media
            }
            20 = menu
            20 {
                levels = 2
                includeSpacer = 1
                as = mainnavigation
            }
            30 = page-content
        }
    }

    meta {
        viewport = {$page.meta.viewport}
        robots = {$page.meta.robots}
        apple-mobile-web-app-capable = {$page.meta.apple-mobile-web-app-capable}

        X-UA-Compatible = {$page.meta.compatible}
        X-UA-Compatible {
            attribute = http-equiv
        }
    }

    includeCSSLibs {

    }

    includeCSS {
        {extension-key}_layout = EXT:{extension-key}/Resources/Public/Css/layout.css
    }

    includeJSLibs {

    }

    includeJS {

    }

    includeJSFooterlibs {

    }

    includeJSFooter {
        {extension-key}_scripts = EXT:{extension-key}/Resources/Public/JavaScript/main.js
    }
}
```

### Configuration/RTE/Default.yaml

```yaml
imports:
    - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
    - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }
    - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Plugins.yaml" }

editor:
    config:
        contentsCss: "EXT:{extension-key}/Resources/Public/Css/rte.css"

        stylesSet:
            - { name: "Lead", element: "p", attributes: { 'class': 'lead' } }

        toolbarGroups:
            - { name: styles, groups: [ format, styles ] }
            - { name: basicstyles, groups: [ basicstyles ] }
            - { name: paragraph, groups: [ list, indent, blocks, align ] }
            - "/"
            - { name: links, groups: [ links ] }
            - { name: clipboard, groups: [ clipboard, cleanup, undo ] }
            - { name: editing, groups: [ spellchecker ] }
            - { name: insert, groups: [ insert ] }
            - { name: tools, groups: [ table, specialchar ] }
            - { name: document, groups: [ mode ] }

        format_tags: "p;h1;h2;h3;h4;h5;pre"

        justifyClasses:
            - text-left
            - text-center
            - text-right
            - text-justify

        extraPlugins:
            - justify

        removePlugins:
            - image

        removeButtons:
            - Anchor
            - Underline
            - Strike
```

### Resources/Private/PageView/Layouts/Default.html

```html
<ul>
    <f:for each="{mainnavigation}" as="mainnavigationItem">
        <li class="{f:if(condition: mainnavigationItem.active, then:'active')}">
            <a href="{mainnavigationItem.link}" target="{mainnavigationItem.target}" title="{mainnavigationItem.title}">
                {mainnavigationItem.title}
            </a>
            <f:if condition="{mainnavigationItem.children}">
                <ul>
                    <f:for each="{mainnavigationItem.children}" as="child">
                        <li class="{f:if(condition: child.active, then:'active')}">
                            <a href="{child.link}" target="{child.target}" title="{child.title}">
                                {child.title}
                            </a>
                        </li>
                    </f:for>
                </ul>
            </f:if>
        </li>
    </f:for>
</ul>
<f:render section="Main" />
```

### Resources/Private/PageView/Pages/Default.html

```html
<f:layout name="Default" />
<f:section name="Main">

    <div style="background-color: yellow; padding: 0.5em 1em;">
        <dl>
            <dt>Template file</dt>
            <dd>
                <code>packages/{extension-key}/Resources/Private/PageView/Pages/Default.html</code>
            </dd>
            <dt>Backend Configuration</dt>
            <dd>
                <code>packages/{extension-key}/Configuration/Sets/SitePackage/PageTsConfig/BackendLayouts/default.tsconfig</code>
            </dd>
        </dl>
    </div>

    <f:render partial="Content" arguments="{records: content.main.records}"/>

</f:section>
```

### Resources/Private/PageView/Partials/Content.html

```html
<f:for each="{records}" as="record">
    <f:cObject
            typoscriptObjectPath="{record.mainType}"
            data="{record}"
            table="{record.mainType}"
    />
</f:for>
```

### Resources/Private/Language/locallang.xlf

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes" ?>
<xliff version="1.0">
    <file source-language="en" datatype="plaintext" original="messages" date="{date}">
        <header>
            <authorName>{author-name}</authorName>
            <authorEmail>{author-email}</authorEmail>
        </header>
        <body>
        </body>
    </file>
</xliff>
```

### Resources/Private/Language/locallang_be.xlf

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes" ?>
<xliff version="1.0">
    <file source-language="en" datatype="plaintext" original="messages" date="{date}">
        <header>
            <authorName>{author-name}</authorName>
            <authorEmail>{author-email}</authorEmail>
        </header>
        <body>
            <trans-unit id="backend_layout.default">
                <source>Default</source>
            </trans-unit>
            <trans-unit id="backend_layout.column.stage">
                <source>Stage</source>
            </trans-unit>
            <trans-unit id="backend_layout.column.normal">
                <source>Normal</source>
            </trans-unit>
            <trans-unit id="backend_layout.column.right">
                <source>Right</source>
            </trans-unit>
        </body>
    </file>
</xliff>
```

### Resources/Private/Language/locallang_db.xlf

```xml
<?xml version="1.0" encoding="utf-8" standalone="yes" ?>
<xliff version="1.0">
    <file source-language="en" datatype="plaintext" original="messages" date="{date}">
        <header>
            <authorName>{author-name}</authorName>
            <authorEmail>{author-email}</authorEmail>
        </header>
        <body>
        </body>
    </file>
</xliff>
```

### Resources/Public/Css/layout.css

```css
/* Main Layout CSS - Add your styles here */
body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    line-height: 1.6;
    color: #333;
}

/* Navigation */
ul {
    list-style: none;
    padding: 0;
}

ul li {
    display: inline-block;
    margin-right: 1rem;
}

ul li.active a {
    font-weight: bold;
}

/* Responsive */
@media (max-width: 768px) {
    ul li {
        display: block;
        margin-bottom: 0.5rem;
    }
}
```

### Resources/Public/Css/rte.css

```css
/* RTE Editor Styles */
.lead {
    font-size: 1.25rem;
    font-weight: 300;
}

.text-left {
    text-align: left;
}

.text-center {
    text-align: center;
}

.text-right {
    text-align: right;
}

.text-justify {
    text-align: justify;
}
```

### Resources/Public/JavaScript/main.js

```javascript
console.log('WE LOVE TYPO3');

// Add your custom JavaScript here
(function() {
    'use strict';
    
    // Example: Mobile navigation toggle
    document.addEventListener('DOMContentLoaded', function() {
        // Your initialization code here
    });
})();
```

### Resources/Public/Icons/Extension.svg

Create a simple SVG icon or copy from an existing source.

### Resources/Public/Icons/favicon.ico

Create or copy a favicon file.

### README.md

```markdown
# {extension-title}

TYPO3 v13 Sitepackage for {vendor-url}

## Installation

1. Add to composer.json repositories:
```json
{
    "repositories": [
        {
            "type": "path",
            "url": "packages/{vendor}/{package}"
        }
    ]
}
```

1. Install via Composer:

```bash
composer require {vendor}/{package}:@dev
```

1. Activate extension:

```bash
vendor/bin/typo3 extension:setup
```

## Development

This sitepackage uses:

- TYPO3 v13.4 LTS
- Site Sets configuration
- Fluid Styled Content
- PAGEVIEW content object

## Author

{author-name} <{author-email}>

```

## DDEV Configuration (Optional)

If --include-ddev flag is provided, also create:

### .ddev/config.yaml
```yaml
name: {package}
type: typo3
docroot: .Build/public
php_version: "8.2"
webserver_type: nginx-fpm
xdebug_enabled: false
additional_hostnames: []
additional_fqdns: []
database:
  type: mariadb
  version: "10.11"
use_dns_when_possible: true
composer_version: "2"
```

## Success Message

After successful creation:

```
✅ TYPO3 v13 SitePackage created successfully!

📁 Location: packages/{vendor}/{package}/
📦 Extension Key: {extension-key}
🎯 TYPO3 Version: 13.4 LTS
📋 Template: Official TYPO3 Sitepackage Generator

Features included:
✓ Site Sets configuration (v13)
✓ PAGEVIEW content object
✓ Fluid Styled Content integration
✓ RTE configuration
✓ Backend layouts
✓ Multi-language support

Next steps:
1. Add to your composer.json:
   "repositories": [
       {
           "type": "path",
           "url": "packages/{vendor}/{package}"
       }
   ],

2. Install the extension:
   composer require {vendor}/{package}:@dev
   
3. Activate in Extension Manager or via CLI:
   vendor/bin/typo3 extension:setup

4. Configure Site Set in Site Configuration

Happy coding! 🚀
```

## Error Handling

- Check if packages directory exists, create if not
- Validate vendor and package names (lowercase, no spaces)
- Check for existing package directory to avoid overwriting
- Ensure all parent directories are created before writing files
- Convert vendor/package names to proper namespace format (PascalCase)
- Generate extension-key from vendor-package format

## Reference

This command creates a sitepackage based on the official TYPO3 v13 template from <https://get.typo3.org/sitepackage>.
The complete template reference is documented in `~/.claude/claude-code-toolkit/knowledge-base/typo3/sitepackage-v13-template.md`.
