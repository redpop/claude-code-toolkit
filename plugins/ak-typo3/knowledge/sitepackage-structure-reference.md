# TYPO3 v13 Sitepackage Structure Reference

## Complete Directory Structure

```
sitepackage/
├── Classes/                              # PHP Classes (Controllers, ViewHelpers, etc.)
│   ├── Controller/                      # Custom controllers
│   │   └── ExampleController.php
│   ├── Domain/                          # Domain logic
│   │   ├── Model/                      # Domain models
│   │   │   └── Example.php
│   │   └── Repository/                 # Data repositories
│   │       └── ExampleRepository.php
│   ├── ViewHelpers/                    # Custom Fluid ViewHelpers
│   │   └── ExampleViewHelper.php
│   ├── DataProcessing/                 # Custom data processors
│   │   └── CustomMenuProcessor.php
│   ├── Hooks/                          # Hook implementations
│   │   └── PageLayoutViewHook.php
│   ├── Middleware/                     # PSR-15 middleware
│   │   └── CustomMiddleware.php
│   └── Service/                        # Service classes
│       └── ExampleService.php
│
├── Configuration/                        # All configuration files
│   ├── Backend/                         # Backend module configuration
│   │   ├── AjaxRoutes.php             # AJAX route registration
│   │   └── Routes.php                  # Backend route registration
│   │
│   ├── Extbase/                        # Extbase configuration
│   │   └── Persistence/
│   │       └── Classes.php             # Class mapping
│   │
│   ├── FlexForms/                      # FlexForm definitions
│   │   └── Example.xml
│   │
│   ├── Icons.php                       # Icon registration
│   │
│   ├── RTE/                            # RTE presets
│   │   ├── Default.yaml                # Default RTE configuration
│   │   ├── Simple.yaml                 # Simple RTE configuration
│   │   └── Full.yaml                   # Full-featured RTE
│   │
│   ├── Services.yaml                   # Dependency injection
│   │
│   ├── Sets/                           # Site Sets (TYPO3 v13)
│   │   └── SitePackage/
│   │       ├── PageTsConfig/          # Page TSconfig
│   │       │   ├── BackendLayouts/    # Backend layout definitions
│   │       │   │   ├── default.tsconfig
│   │       │   │   ├── homepage.tsconfig
│   │       │   │   └── twocolumn.tsconfig
│   │       │   ├── TCEFORM.tsconfig   # Form configuration
│   │       │   ├── TCEMAIN.tsconfig   # Data handling
│   │       │   └── RTE.tsconfig       # RTE configuration
│   │       │
│   │       ├── TypoScript/            # TypoScript files
│   │       │   ├── config.typoscript  # Config object
│   │       │   ├── page.typoscript    # Page object
│   │       │   ├── lib.typoscript     # Library objects
│   │       │   └── tt_content.typoscript # Content rendering
│   │       │
│   │       ├── config.yaml            # Site Set definition
│   │       ├── page.tsconfig          # Main Page TSconfig
│   │       ├── settings.yaml          # Site Set settings
│   │       └── setup.typoscript       # Main TypoScript setup
│   │
│   ├── TCA/                            # Table Configuration Array
│   │   ├── Overrides/                 # TCA overrides
│   │   │   ├── pages.php
│   │   │   ├── tt_content.php
│   │   │   └── sys_template.php
│   │   └── tx_sitepackage_domain.php  # Custom table TCA
│   │
│   ├── TsConfig/                       # Legacy TSconfig (if needed)
│   │   ├── Page/                      # Page TSconfig
│   │   └── User/                      # User TSconfig
│   │
│   └── TypoScript/                     # Legacy TypoScript (if needed)
│       ├── constants.typoscript
│       └── setup.typoscript
│
├── Resources/                           # Frontend resources
│   ├── Private/                        # Protected resources
│   │   ├── ContentElements/           # Content element templates
│   │   │   ├── Layouts/              # Fluid layouts
│   │   │   │   └── Default.html
│   │   │   ├── Partials/             # Fluid partials
│   │   │   │   ├── Header.html
│   │   │   │   └── Media.html
│   │   │   └── Templates/            # Fluid templates
│   │   │       ├── Text.html
│   │   │       └── Textmedia.html
│   │   │
│   │   ├── Language/                 # Language files
│   │   │   ├── locallang.xlf        # General translations
│   │   │   ├── locallang_be.xlf     # Backend translations
│   │   │   ├── locallang_db.xlf     # Database labels
│   │   │   ├── locallang_tca.xlf    # TCA labels
│   │   │   └── de.locallang.xlf     # German translations
│   │   │
│   │   ├── PageView/                 # Page templates (TYPO3 v13)
│   │   │   ├── Layouts/              # Page layouts
│   │   │   │   ├── Default.html
│   │   │   │   └── Landing.html
│   │   │   ├── Pages/                # Page templates
│   │   │   │   ├── Default.html
│   │   │   │   ├── Homepage.html
│   │   │   │   └── Landing.html
│   │   │   └── Partials/             # Page partials
│   │   │       ├── Content.html
│   │   │       ├── Footer.html
│   │   │       ├── Header.html
│   │   │       └── Navigation/
│   │   │           ├── Main.html
│   │   │           ├── Breadcrumb.html
│   │   │           └── Language.html
│   │   │
│   │   ├── Templates/                 # Legacy/Extbase templates
│   │   │   └── Email/                # Email templates
│   │   │       └── Notification.html
│   │   │
│   │   └── Sass/                     # SASS sources
│   │       ├── _variables.scss
│   │       ├── _mixins.scss
│   │       └── main.scss
│   │
│   └── Public/                        # Public resources
│       ├── Css/                       # Stylesheets
│       │   ├── layout.css
│       │   ├── layout.min.css
│       │   ├── rte.css
│       │   └── print.css
│       │
│       ├── Fonts/                     # Web fonts
│       │   ├── roboto-regular.woff2
│       │   └── roboto-bold.woff2
│       │
│       ├── Icons/                     # Icons and favicons
│       │   ├── Extension.svg         # Extension icon
│       │   ├── favicon.ico
│       │   ├── apple-touch-icon.png
│       │   └── BackendLayouts/       # Backend layout icons
│       │       ├── default.svg
│       │       └── homepage.svg
│       │
│       ├── Images/                    # Images
│       │   ├── logo.svg
│       │   ├── logo-inverted.svg
│       │   ├── placeholder.jpg
│       │   └── BackendLayouts/       # Backend layout previews
│       │       ├── default.png
│       │       └── homepage.png
│       │
│       └── JavaScript/                # JavaScript files
│           ├── main.js
│           ├── main.min.js
│           └── libs/                 # Third-party libraries
│               └── example.js
│
├── Tests/                              # Test files
│   ├── Unit/                          # Unit tests
│   │   └── ExampleTest.php
│   └── Functional/                    # Functional tests
│       └── ExampleTest.php
│
├── Build/                              # Build tools
│   ├── webpack.config.js
│   ├── package.json
│   ├── package-lock.json
│   ├── .eslintrc.json
│   ├── .stylelintrc.json
│   └── gulpfile.js
│
├── Documentation/                      # Extension documentation
│   ├── Index.rst
│   ├── Configuration/
│   ├── Installation/
│   └── UsersManual/
│
├── .gitignore                         # Git ignore file
├── .editorconfig                      # Editor configuration
├── .php-cs-fixer.dist.php            # PHP CS Fixer config
├── composer.json                      # Composer configuration
├── ext_conf_template.txt              # Extension configuration template
├── ext_emconf.php                     # Extension configuration
├── ext_icon.svg                       # Extension icon
├── ext_localconf.php                  # Local configuration
├── ext_tables.php                     # Database tables
├── ext_tables.sql                     # SQL definitions
├── LICENSE                            # License file
├── phpunit.xml.dist                   # PHPUnit configuration
└── README.md                          # Documentation
```

## File Purposes and Contents

### Root Files

#### composer.json

```json
{
    "name": "vendor/sitepackage",
    "type": "typo3-cms-extension",
    "require": {
        "typo3/cms-core": "^13.4"
    }
}
```

#### ext_emconf.php

```php
<?php
$EM_CONF[$_EXTKEY] = [
    'title' => 'Sitepackage',
    'version' => '1.0.0',
    'constraints' => [
        'depends' => [
            'typo3' => '13.4.0-13.4.99'
        ]
    ]
];
```

#### ext_localconf.php

```php
<?php
defined('TYPO3') or die();

// Register hooks, services, etc.
```

#### ext_tables.php

```php
<?php
defined('TYPO3') or die();

// Register backend modules, tables, etc.
```

### Configuration Files

#### Configuration/Sets/SitePackage/config.yaml

```yaml
name: vendor/sitepackage
label: 'Sitepackage'
dependencies:
  - typo3/fluid-styled-content
```

#### Configuration/Sets/SitePackage/settings.yaml

```yaml
page:
  pageview:
    paths: 'EXT:sitepackage/Resources/Private/PageView/'
```

### Template Files

#### Resources/Private/PageView/Pages/Default.html

```html
<f:layout name="Default" />
<f:section name="Main">
    <f:render partial="Content" arguments="{_all}" />
</f:section>
```

#### Resources/Private/PageView/Layouts/Default.html

```html
<f:render partial="Header" arguments="{_all}" />
<f:render section="Main" />
<f:render partial="Footer" arguments="{_all}" />
```

## Directory Purposes

### Classes/

- **Controller/**: MVC controllers for plugins
- **Domain/**: Business logic and domain models
- **ViewHelpers/**: Custom Fluid ViewHelpers
- **DataProcessing/**: Custom data processors for TypoScript
- **Service/**: Service classes for business logic
- **Middleware/**: PSR-15 middleware components

### Configuration/

- **Sets/**: TYPO3 v13 Site Sets configuration
- **TCA/**: Database table configuration
- **RTE/**: Rich Text Editor presets
- **FlexForms/**: Plugin configuration forms
- **Icons.php**: Icon registration for backend

### Resources/Private/

- **PageView/**: TYPO3 v13 page templates
- **ContentElements/**: Content element templates
- **Language/**: Translation files
- **Sass/**: Source SCSS files

### Resources/Public/

- **Css/**: Compiled stylesheets
- **JavaScript/**: JavaScript files
- **Images/**: Image assets
- **Icons/**: Icons and favicons
- **Fonts/**: Web fonts

## Naming Conventions

### PHP Classes

- PascalCase for class names
- Namespace: `Vendor\Sitepackage\Category\`

### Templates

- PascalCase for template files
- Descriptive names matching backend labels

### Configuration

- lowercase with underscores for TypoScript
- camelCase for Fluid variables
- kebab-case for CSS classes

### Assets

- kebab-case for CSS/JS files
- Descriptive names for images

## Best Practices

1. **Organize by Feature**: Group related files together
2. **Use Site Sets**: Leverage TYPO3 v13's Site Sets
3. **Separate Concerns**: Keep logic, presentation, and configuration separate
4. **Version Assets**: Include versioned and minified assets
5. **Document Everything**: Add README files in complex directories
6. **Follow Standards**: Use TYPO3 coding guidelines
7. **Test Coverage**: Include unit and functional tests

## Development Workflow

1. **Source Files**: Keep source files (SCSS, ES6) in Resources/Private/
2. **Build Process**: Use build tools (webpack, gulp) for compilation
3. **Public Assets**: Output compiled files to Resources/Public/
4. **Version Control**: Track source files, ignore compiled files
5. **Documentation**: Keep documentation up-to-date

## Related Documentation

- [Sitepackage Installation Guide](./sitepackage-installation-guide.md)
- [Sitepackage Configuration Guide](./sitepackage-configuration-guide.md)
- [TYPO3 v13 Template Reference](./sitepackage-v13-template.md)
- [Backend Layouts Guide](./sitepackage-backend-layouts.md)
