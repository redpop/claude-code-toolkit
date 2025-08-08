---
description: Create a complete TYPO3 v13.4 SitePackage structure with Site Sets
argument-hint: "[vendor] [package-name] [--options]"
---

# TYPO3 SitePackage Kickstarter

Creates a complete TYPO3 v13.4 compatible SitePackage structure with modern Site Sets configuration.

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

Then create the following structure:

```
packages/{vendor}/{package}/
├── composer.json
├── ext_emconf.php
├── Classes/
│   └── Components/                   # Fluid v4 Components
│       └── ComponentCollection.php
├── Configuration/
│   ├── Sets/
│   │   └── {PackageName}/
│   │       ├── config.yaml           # Site Set configuration
│   │       ├── constants.typoscript
│   │       ├── setup.typoscript
│   │       └── TypoScript/
│   │           ├── page.typoscript
│   │           ├── config.typoscript
│   │           └── lib.typoscript
│   ├── TCA/
│   │   └── Overrides/
│   │       ├── pages.php
│   │       └── tt_content.php
│   ├── Icons/
│   │   └── Extension.svg
│   └── DesignTokens.json            # Design system tokens
├── ContentBlocks/                    # For Content Blocks v1.3
│   ├── ContentElements/
│   └── PageTypes/
├── Resources/
│   ├── Private/
│   │   ├── Components/               # Fluid v4 Component templates
│   │   │   ├── Atom/
│   │   │   │   ├── Button.html
│   │   │   │   ├── Icon.html
│   │   │   │   └── Input.html
│   │   │   ├── Molecule/
│   │   │   │   ├── Card.html
│   │   │   │   └── Navigation.html
│   │   │   └── Organism/
│   │   │       ├── Header.html
│   │   │       └── Footer.html
│   │   ├── Language/
│   │   │   └── locallang.xlf
│   │   ├── Layouts/
│   │   │   └── Default.html
│   │   ├── Templates/
│   │   │   ├── Default.html         # For FLUIDTEMPLATE (Page Types)
│   │   │   └── Page/
│   │   │       └── Default.html
│   │   ├── Partials/
│   │   │   ├── Navigation/
│   │   │   │   └── Main.html
│   │   │   └── Footer.html
│   │   └── Scss/
│   │       ├── main.scss
│   │       ├── _variables.scss
│   │       └── components/           # Component styles
│   │           ├── _atoms.scss
│   │           ├── _molecules.scss
│   │           └── _organisms.scss
│   └── Public/
│       ├── Css/
│       │   └── main.css
│       ├── JavaScript/
│       │   └── main.js
│       └── Icons/
└── .gitignore
```

## File Contents

### composer.json
```json
{
    "name": "{vendor}/{package}",
    "type": "typo3-cms-extension",
    "description": "{description}",
    "authors": [
        {
            "name": "{author}",
            "email": "{email}"
        }
    ],
    "require": {
        "typo3/cms-core": "^13.4",
        "typo3/cms-fluid": "^13.4",
        "typo3/cms-fluid-styled-content": "^13.4",
        "typo3/cms-rte-ckeditor": "^13.4",
        "friendsoftypo3/content-blocks": "^1.3"
    },
    "autoload": {
        "psr-4": {
            "{VendorNamespace}\\{PackageNamespace}\\": "Classes/"
        }
    },
    "extra": {
        "typo3/cms": {
            "extension-key": "{extension_key}"
        }
    }
}
```

### ext_emconf.php
```php
<?php
$EM_CONF[$_EXTKEY] = [
    'title' => '{title}',
    'description' => '{description}',
    'category' => 'templates',
    'author' => '{author}',
    'author_email' => '{email}',
    'state' => 'stable',
    'version' => '1.0.0',
    'constraints' => [
        'depends' => [
            'typo3' => '13.4.0-13.4.99',
            'fluid_styled_content' => '13.4.0-13.4.99',
            'rte_ckeditor' => '13.4.0-13.4.99',
            'content_blocks' => '1.3.0-1.3.99',
        ],
    ],
];
```

### Configuration/Sets/{PackageName}/config.yaml
```yaml
name: {vendor}/{package}
label: '{title}'
dependencies:
  - typo3/fluid-styled-content
  - typo3/content-blocks
imports:
  - resource: 'EXT:{extension_key}/Configuration/Sets/{PackageName}/constants.typoscript'
  - resource: 'EXT:{extension_key}/Configuration/Sets/{PackageName}/setup.typoscript'
settings:
  scss:
    includePaths:
      - 'EXT:{extension_key}/Resources/Private/Scss/'
```

### Configuration/Sets/{PackageName}/setup.typoscript
```typoscript
@import 'EXT:{extension_key}/Configuration/Sets/{PackageName}/TypoScript/*.typoscript'
```

### Configuration/Sets/{PackageName}/TypoScript/page.typoscript
```typoscript
page = PAGE
page {
    includeCSS {
        main = EXT:{extension_key}/Resources/Public/Css/main.css
    }
    
    includeJSFooter {
        main = EXT:{extension_key}/Resources/Public/JavaScript/main.js
    }
    
    10 = FLUIDTEMPLATE
    10 {
        templateName = Default
        
        # For Content Blocks Page Types compatibility
        templateName.cObject = CASE
        templateName.cObject {
            key.field = doktype
            # Default page type
            default.value = Default
            # Add custom page types here
            # 1754487155.value = Landingpage
        }
        
        templateRootPaths {
            10 = EXT:{extension_key}/Resources/Private/Templates/
        }
        
        partialRootPaths {
            10 = EXT:{extension_key}/Resources/Private/Partials/
        }
        
        layoutRootPaths {
            10 = EXT:{extension_key}/Resources/Private/Layouts/
        }
        
        dataProcessing {
            10 = menu
            10 {
                as = mainMenu
                levels = 2
                expandAll = 1
                includeSpacer = 0
            }
            
            # Content Blocks data processor
            20 = content-blocks
        }
        
        variables {
            content < styles.content.get
        }
    }
}
```

### Configuration/Sets/{PackageName}/TypoScript/config.typoscript
```typoscript
config {
    absRefPrefix = /
    no_cache = 0
    debug = 0
    cache_period = 86400
    sendCacheHeaders = 1
    
    # Language configuration
    linkVars = L(0-5)
    prefixLocalAnchors = all
    
    # HTML5
    doctype = html5
    
    # Compression
    compressJs = 1
    compressCss = 1
    concatenateJs = 1
    concatenateCss = 1
    
    # Remove default CSS
    removeDefaultCss = 0
    
    # Admin panel
    admPanel = 0
}
```

### Configuration/TCA/Overrides/pages.php
```php
<?php
defined('TYPO3') or die();

// Register page TSconfig
\TYPO3\CMS\Core\Utility\ExtensionManagementUtility::registerPageTSConfigFile(
    '{extension_key}',
    'Configuration/TsConfig/Page/All.tsconfig',
    '{title} - Page TSconfig'
);
```

### Resources/Private/Templates/Default.html
```html
<f:layout name="Default" />

<f:section name="Main">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <f:format.html>{content}</f:format.html>
            </div>
        </div>
    </div>
</f:section>
```

### Classes/Components/ComponentCollection.php

```php
<?php
declare(strict_types=1);

namespace {Vendor}\{Package}\Components;

use TYPO3Fluid\Fluid\Core\Component\AbstractComponentCollection;

final class ComponentCollection extends AbstractComponentCollection
{
    /**
     * Allow additional HTML attributes (data-*, aria-*)
     */
    protected function additionalArgumentsAllowed(string $viewHelperName): bool
    {
        return true;
    }
    
    /**
     * Provide global design tokens to all components
     */
    public function getDesignTokens(): array
    {
        $tokensFile = __DIR__ . '/../../Configuration/DesignTokens.json';
        if (file_exists($tokensFile)) {
            return json_decode(file_get_contents($tokensFile), true);
        }
        
        return [
            'colors' => [
                'primary' => '#007bff',
                'secondary' => '#6c757d',
                'success' => '#28a745',
                'danger' => '#dc3545',
                'warning' => '#ffc107',
                'info' => '#17a2b8',
            ],
            'spacing' => [
                'xs' => '0.25rem',
                'sm' => '0.5rem',
                'md' => '1rem',
                'lg' => '1.5rem',
                'xl' => '2rem',
            ],
            'breakpoints' => [
                'sm' => '576px',
                'md' => '768px',
                'lg' => '992px',
                'xl' => '1200px',
            ],
        ];
    }
}
```

### Configuration/DesignTokens.json

```json
{
    "colors": {
        "primary": "#007bff",
        "secondary": "#6c757d",
        "success": "#28a745",
        "danger": "#dc3545",
        "warning": "#ffc107",
        "info": "#17a2b8",
        "light": "#f8f9fa",
        "dark": "#343a40"
    },
    "spacing": {
        "xs": "0.25rem",
        "sm": "0.5rem",
        "md": "1rem",
        "lg": "1.5rem",
        "xl": "2rem",
        "xxl": "3rem"
    },
    "typography": {
        "fontFamily": "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif",
        "fontSize": {
            "xs": "0.75rem",
            "sm": "0.875rem",
            "base": "1rem",
            "lg": "1.125rem",
            "xl": "1.25rem",
            "2xl": "1.5rem",
            "3xl": "1.875rem",
            "4xl": "2.25rem"
        }
    },
    "breakpoints": {
        "sm": "576px",
        "md": "768px",
        "lg": "992px",
        "xl": "1200px",
        "xxl": "1400px"
    }
}
```

### Resources/Private/Components/Atom/Button.html

```html
<f:comment>
Component: Atom/Button
Purpose: Reusable button component with variants and states
</f:comment>

<f:argument name="href" type="string" optional="{true}" />
<f:argument name="variant" type="string" optional="{true}" default="primary" />
<f:argument name="size" type="string" optional="{true}" default="md" />
<f:argument name="disabled" type="boolean" optional="{true}" default="{false}" />
<f:argument name="icon" type="string" optional="{true}" />
<f:argument name="iconPosition" type="string" optional="{true}" default="left" />
<f:argument name="type" type="string" optional="{true}" default="button" />
<f:argument name="ariaLabel" type="string" optional="{true}" />

<f:if condition="{href}">
    <f:then>
        <a href="{href}" 
           class="btn btn--{variant} btn--{size}"
           {f:if(condition: disabled, then: 'aria-disabled="true" tabindex="-1"')}
           {f:if(condition: ariaLabel, then: 'aria-label="{ariaLabel}"')}>
            <f:render section="ButtonContent" arguments="{_all}" />
        </a>
    </f:then>
    <f:else>
        <button type="{type}"
                class="btn btn--{variant} btn--{size}"
                {f:if(condition: disabled, then: 'disabled="disabled"')}
                {f:if(condition: ariaLabel, then: 'aria-label="{ariaLabel}"')}>
            <f:render section="ButtonContent" arguments="{_all}" />
        </button>
    </f:else>
</f:if>

<f:section name="ButtonContent">
    <f:if condition="{icon} && {iconPosition} == 'left'">
        <my:atom.icon name="{icon}" class="btn__icon btn__icon--left" />
    </f:if>
    <span class="btn__label"><f:slot /></span>
    <f:if condition="{icon} && {iconPosition} == 'right'">
        <my:atom.icon name="{icon}" class="btn__icon btn__icon--right" />
    </f:if>
</f:section>
```

### Resources/Private/Components/Molecule/Card.html

```html
<f:comment>
Component: Molecule/Card
Purpose: Card component for content display
</f:comment>

<f:argument name="title" type="string" />
<f:argument name="description" type="string" optional="{true}" />
<f:argument name="image" type="TYPO3\CMS\Core\Resource\FileInterface" optional="{true}" />
<f:argument name="link" type="string" optional="{true}" />
<f:argument name="variant" type="string" optional="{true}" default="default" />

<article class="card card--{variant}">
    <f:if condition="{image}">
        <div class="card__media">
            <f:image image="{image}" 
                     class="card__image" 
                     width="400" 
                     height="300c" 
                     loading="lazy" />
        </div>
    </f:if>
    
    <div class="card__body">
        <h3 class="card__title">
            <f:if condition="{link}">
                <f:then><a href="{link}">{title}</a></f:then>
                <f:else>{title}</f:else>
            </f:if>
        </h3>
        
        <f:if condition="{description}">
            <p class="card__description">{description}</p>
        </f:if>
        
        <f:slot />
    </div>
    
    <f:slot name="footer">
        <!-- Optional footer content -->
    </f:slot>
</article>
```

### Resources/Private/Components/Organism/Header.html

```html
<f:comment>
Component: Organism/Header
Purpose: Site header with navigation
</f:comment>

<f:argument name="logo" type="string" optional="{true}" />
<f:argument name="siteName" type="string" optional="{true}" />
<f:argument name="variant" type="string" optional="{true}" default="default" />

<header class="site-header site-header--{variant}">
    <div class="site-header__container">
        <div class="site-header__brand">
            <f:if condition="{logo}">
                <f:then>
                    <a href="/" class="site-header__logo">
                        <img src="{logo}" alt="{siteName}" />
                    </a>
                </f:then>
                <f:else>
                    <a href="/" class="site-header__name">{siteName}</a>
                </f:else>
            </f:if>
        </div>
        
        <nav class="site-header__nav" aria-label="Main navigation">
            <f:slot name="navigation">
                <!-- Navigation content -->
            </f:slot>
        </nav>
        
        <div class="site-header__actions">
            <f:slot name="actions">
                <!-- Action buttons -->
            </f:slot>
        </div>
    </div>
</header>
```

### Resources/Private/Layouts/Default.html
```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{data.title}</title>
</head>
<body>
    <header>
        <f:render partial="Navigation/Main" arguments="{_all}" />
    </header>
    
    <main>
        <f:render section="Main" />
    </main>
    
    <footer>
        <f:render partial="Footer" arguments="{_all}" />
    </footer>
</body>
</html>
```

### Resources/Private/Partials/Navigation/Main.html
```html
<nav class="main-navigation">
    <ul>
        <f:for each="{mainMenu}" as="menuItem">
            <li class="{f:if(condition: menuItem.active, then: 'active')}">
                <a href="{menuItem.link}" {f:if(condition: menuItem.target, then: 'target="{menuItem.target}"')}>
                    {menuItem.title}
                </a>
                <f:if condition="{menuItem.children}">
                    <ul>
                        <f:for each="{menuItem.children}" as="subMenuItem">
                            <li class="{f:if(condition: subMenuItem.active, then: 'active')}">
                                <a href="{subMenuItem.link}">
                                    {subMenuItem.title}
                                </a>
                            </li>
                        </f:for>
                    </ul>
                </f:if>
            </li>
        </f:for>
    </ul>
</nav>
```

### .gitignore
```
# TYPO3 specific
/Resources/Public/Css/*.map
/Resources/Public/JavaScript/*.map
/.sass-cache/
/node_modules/
/vendor/
/.Build/
/var/

# IDE
.idea/
.vscode/
*.sublime-*

# OS
.DS_Store
Thumbs.db
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
✅ TYPO3 SitePackage created successfully!

📁 Location: packages/{vendor}/{package}/
📦 Extension Key: {extension_key}
🎯 TYPO3 Version: 13.4
📚 Content Blocks: 1.3

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

4. Create your first Content Block:
   /prefix:typo3:content-blocks

Happy coding! 🚀
```

## Error Handling

- Check if packages directory exists, create if not
- Validate vendor and package names (lowercase, no spaces)
- Check for existing package directory to avoid overwriting
- Ensure all parent directories are created before writing files