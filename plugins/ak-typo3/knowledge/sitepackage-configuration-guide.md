# TYPO3 v13 Sitepackage Configuration Guide

## Overview

This guide covers all configuration aspects of a TYPO3 v13 sitepackage, including Site Sets, TypoScript, TSconfig, and RTE configuration.

## Site Sets Configuration (TYPO3 v13)

Site Sets are the new way to configure TYPO3 v13 projects, replacing traditional constants and setup.

### Core Configuration Files

#### Configuration/Sets/SitePackage/config.yaml

```yaml
# Package identification
name: vendor/package
label: 'Human Readable Package Name'

# Dependencies - other Site Sets this package depends on
dependencies:
  - typo3/fluid-styled-content      # Content rendering
  - typo3/fluid-styled-content-css  # Default CSS
  # - vendor/other-package          # Custom dependencies

# Optional: Define settings that can be overridden
settings:
  # Custom settings definitions
  customSetting:
    type: string
    default: 'default value'
    label: 'Custom Setting'
    description: 'Description for backend'
```

#### Configuration/Sets/SitePackage/settings.yaml

Complete settings structure with all options:

```yaml
# ===========================
# Template Configuration
# ===========================
styles:
  templates:
    # Paths for Fluid Styled Content templates
    layoutRootPath: 'EXT:sitepackage/Resources/Private/ContentElements/Layouts/'
    partialRootPath: 'EXT:sitepackage/Resources/Private/ContentElements/Partials/'
    templateRootPath: 'EXT:sitepackage/Resources/Private/ContentElements/Templates/'

# ===========================
# Page Configuration
# ===========================
page:
  # PageView configuration (TYPO3 v13)
  pageview:
    paths: 'EXT:sitepackage/Resources/Private/PageView/'
    # Multiple paths supported
    # paths:
    #   10: 'EXT:sitepackage/Resources/Private/PageView/'
    #   20: 'EXT:other_extension/Resources/Private/PageView/'
  
  # Favicon configuration
  favicon:
    file: 'EXT:sitepackage/Resources/Public/Icons/favicon.ico'
  
  # Logo configuration
  logo:
    file: 'EXT:sitepackage/Resources/Public/Images/logo.svg'
    fileInverted: 'EXT:sitepackage/Resources/Public/Images/logo-inverted.svg'
    alt: 'Company Logo'
    height: 50
    width: 200
  
  # Meta tags
  meta:
    viewport: 'width=device-width, initial-scale=1'
    robots: 'index,follow'
    author: 'Company Name'
    keywords: 'keyword1, keyword2'
    description: 'Default meta description'
    revisit-after: '7 days'
    apple-mobile-web-app-capable: 'no'
    compatible: 'IE=edge'
    google-site-verification: ''
    
  # Open Graph configuration
  opengraph:
    title: '{page.title}'
    type: 'website'
    image: 'EXT:sitepackage/Resources/Public/Images/opengraph.jpg'
    site_name: 'Site Name'
    locale: 'en_US'
  
  # Tracking configuration
  tracking:
    google:
      trackingID: 'UA-XXXXXXXX-X'  # or G-XXXXXXXXXX for GA4
      anonymizeIp: '1'
      additionalConfig: |
        gtag('config', 'GA_MEASUREMENT_ID', {
          'custom_dimension_1': 'value'
        });
    
    matomo:
      url: 'https://matomo.example.com/'
      siteId: '1'
      
  # Footer/Header configuration
  footer:
    enable: '1'
    copyright: '© 2024 Company Name. All rights reserved.'
    
  header:
    enable: '1'
    class: 'navbar-light'

# ===========================
# Config (TYPO3 Configuration)
# ===========================
config:
  # Cache settings
  no_cache: '0'
  cache_period: '86400'
  sendCacheHeaders: '1'
  
  # HTML settings
  doctype: 'html5'
  htmlTag: '<html lang="en">'
  removeDefaultJS: '0'
  removeDefaultCss: '0'
  
  # URL handling
  absRefPrefix: 'auto'
  prefixLocalAnchors: 'all'
  
  # Admin panel
  admPanel: '1'
  
  # Compression
  compressJs: '1'
  compressCss: '1'
  concatenateJs: '1'
  concatenateCss: '1'
  
  # Comments
  headerComment: |
    <!--
      Website by Company Name
      Powered by TYPO3 CMS
    -->
  disablePrefixComment: '1'
  
  # Language settings
  linkVars: 'L(int)'
  uniqueLinkVars: '1'
  
  # SEO
  index_enable: '1'
  index_externals: '1'
  
# ===========================
# Custom Variables
# ===========================
custom:
  # Project-specific settings
  project:
    name: 'Project Name'
    email: 'info@example.com'
    phone: '+1234567890'
  
  # API Keys
  api:
    maps: ''
    recaptcha: ''
  
  # Social Media
  social:
    facebook: 'https://facebook.com/company'
    twitter: 'https://twitter.com/company'
    linkedin: 'https://linkedin.com/company/company'
    instagram: 'https://instagram.com/company'
```

## TypoScript Configuration

### Configuration/Sets/SitePackage/setup.typoscript

```typoscript
# ===========================
# Import TypoScript Files
# ===========================
@import './TypoScript/*.typoscript'

# ===========================
# Basic Page Object
# ===========================
page = PAGE
page {
    # Type number
    typeNum = 0
    
    # Favicon
    shortcutIcon = {$page.favicon.file}
    
    # PageView object (TYPO3 v13)
    10 = PAGEVIEW
    10 {
        paths {
            0 = EXT:sitepackage/Resources/Private/PageView/
            1 = {$page.pageview.paths}
        }
        
        # Data processing
        dataProcessing {
            # Menu processor
            10 = menu
            10 {
                levels = 3
                expandAll = 0
                includeSpacer = 1
                as = mainnavigation
            }
            
            # Breadcrumb menu
            20 = menu
            20 {
                special = rootline
                special.range = 0|-1
                includeNotInMenu = 0
                as = breadcrumb
            }
            
            # Language menu
            30 = language-menu
            30 {
                languages = auto
                as = languagenavigation
            }
            
            # Page content
            40 = page-content
            40 {
                as = content
                # Define content areas
                content {
                    main = colPos = 0
                    sidebar = colPos = 1
                    footer = colPos = 10
                }
            }
            
            # Site processor
            50 = site
            50 {
                as = site
            }
        }
    }
}
```

### Configuration/Sets/SitePackage/TypoScript/page.typoscript

```typoscript
# ===========================
# Page Meta & Header Data
# ===========================
page {
    # Meta tags
    meta {
        viewport = {$page.meta.viewport}
        robots = {$page.meta.robots}
        author = {$page.meta.author}
        keywords = {$page.meta.keywords}
        description = {$page.meta.description}
        
        # Open Graph
        og:title = {$page.opengraph.title}
        og:type = {$page.opengraph.type}
        og:image = {$page.opengraph.image}
        
        # Twitter Cards
        twitter:card = summary_large_image
        twitter:title = {$page.opengraph.title}
        twitter:image = {$page.opengraph.image}
        
        # X-UA-Compatible
        X-UA-Compatible = {$page.meta.compatible}
        X-UA-Compatible.attribute = http-equiv
    }
    
    # CSS includes
    includeCSS {
        # Bootstrap from CDN
        bootstrap = https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css
        bootstrap.external = 1
        bootstrap.media = all
        
        # Custom CSS
        layout = EXT:sitepackage/Resources/Public/Css/layout.css
        layout.media = all
        
        # Additional CSS files
        custom = EXT:sitepackage/Resources/Public/Css/custom.css
    }
    
    # JavaScript includes
    includeJS {
        # jQuery (if needed)
        # jquery = https://code.jquery.com/jquery-3.7.0.min.js
        # jquery.external = 1
    }
    
    # Footer JavaScript
    includeJSFooter {
        # Bootstrap JS
        bootstrap = https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js
        bootstrap.external = 1
        bootstrap.defer = 1
        
        # Custom JavaScript
        main = EXT:sitepackage/Resources/Public/JavaScript/main.js
        main.defer = 1
    }
    
    # Inline JavaScript
    jsInline {
        # Google Analytics
        10 = COA
        10 {
            if.isTrue = {$page.tracking.google.trackingID}
            10 = TEXT
            10.value (
                <!-- Google Analytics -->
                <script async src="https://www.googletagmanager.com/gtag/js?id={$page.tracking.google.trackingID}"></script>
                <script>
                    window.dataLayer = window.dataLayer || [];
                    function gtag(){dataLayer.push(arguments);}
                    gtag('js', new Date());
                    gtag('config', '{$page.tracking.google.trackingID}');
                </script>
            )
        }
    }
}
```

## Page TSconfig

### Configuration/Sets/SitePackage/page.tsconfig

```tsconfig
# ===========================
# Import TSconfig Files
# ===========================
@import './PageTsConfig/BackendLayouts/*.tsconfig'
@import './PageTsConfig/TCEFORM.tsconfig'
@import './PageTsConfig/TCEMAIN.tsconfig'
@import './PageTsConfig/RTE.tsconfig'

# ===========================
# RTE Configuration
# ===========================
RTE {
    default {
        preset = sitepackage
    }
}

# ===========================
# Backend Form Configuration
# ===========================
TCEFORM {
    # Page properties
    pages {
        # Hide fields
        rowDescription.disabled = 1
        
        # Limit layouts
        layout {
            removeItems = 1,2,3
            altLabels {
                0 = Standard
            }
        }
        
        # Backend layout
        backend_layout {
            removeItems = -1
        }
        backend_layout_next_level {
            removeItems = -1
        }
    }
    
    # Content elements
    tt_content {
        # Limit content types
        CType {
            removeItems = bullets,table,uploads,menu_abstract
        }
        
        # Header layout
        header_layout {
            altLabels {
                0 = Standard
                1 = H1
                2 = H2
                3 = H3
                4 = H4
                5 = H5
            }
        }
        
        # Frame classes
        frame_class {
            removeItems = ruler-before,ruler-after,indent
            addItems {
                container = Container
                container-fluid = Container Fluid
            }
        }
    }
}

# ===========================
# Page Module Configuration
# ===========================
mod {
    web_layout {
        # Backend layouts
        BackendLayouts {
            default {
                title = Standard
                config {
                    backend_layout {
                        colCount = 2
                        rowCount = 2
                        rows {
                            1 {
                                columns {
                                    1 {
                                        name = Header
                                        colPos = 1
                                        colspan = 2
                                    }
                                }
                            }
                            2 {
                                columns {
                                    1 {
                                        name = Main Content
                                        colPos = 0
                                        identifier = main
                                    }
                                    2 {
                                        name = Sidebar
                                        colPos = 2
                                        identifier = sidebar
                                    }
                                }
                            }
                        }
                    }
                }
                icon = EXT:sitepackage/Resources/Public/Icons/BackendLayouts/default.svg
            }
        }
    }
}

# ===========================
# New Content Element Wizard
# ===========================
mod.wizards.newContentElement.wizardItems {
    # Custom tab
    custom {
        header = Custom Elements
        elements {
            # Custom element example
            customElement {
                iconIdentifier = content-text
                title = Custom Element
                description = Custom content element
                tt_content_defValues {
                    CType = text
                }
            }
        }
        show = *
    }
}
```

## RTE Configuration

> **Note**: For comprehensive CKEditor configuration in TYPO3 v13+, see the dedicated [CKEditor Configuration Guide](./ckeditor-configuration-guide.md) and [CKEditor Examples Reference](./references/ckeditor-examples-reference.md).

### Configuration/RTE/Default.yaml

```yaml
# Import base configuration
imports:
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Processing.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Base.yaml" }
  - { resource: "EXT:rte_ckeditor/Configuration/RTE/Editor/Plugins.yaml" }

# Editor configuration
editor:
  config:
    # Content CSS
    contentsCss: 
      - "EXT:sitepackage/Resources/Public/Css/rte.css"
      - "EXT:sitepackage/Resources/Public/Css/layout.css"
    
    # Style sets
    stylesSet:
      - { name: "Lead", element: "p", attributes: { "class": "lead" } }
      - { name: "Small", element: "small" }
      - { name: "Button Primary", element: "a", attributes: { "class": "btn btn-primary" } }
      - { name: "Button Secondary", element: "a", attributes: { "class": "btn btn-secondary" } }
      - { name: "Alert Info", element: "div", attributes: { "class": "alert alert-info" } }
      - { name: "Alert Warning", element: "div", attributes: { "class": "alert alert-warning" } }
    
    # Format tags
    format_tags: "p;h2;h3;h4;h5;h6;pre"
    
    # Toolbar configuration
    toolbar:
      - { name: styles, groups: [styles, format] }
      - { name: basicstyles, groups: [basicstyles] }
      - { name: paragraph, groups: [list, indent, blocks, align] }
      - "/"
      - { name: links, groups: [links] }
      - { name: clipboard, groups: [clipboard, cleanup, undo] }
      - { name: editing, groups: [spellchecker] }
      - { name: insert, groups: [insert] }
      - { name: tools, groups: [table, specialchar] }
      - { name: document, groups: [mode] }
    
    # Justify classes
    justifyClasses:
      - text-left
      - text-center
      - text-right
      - text-justify
    
    # Extra plugins
    extraPlugins:
      - justify
      - find
      - selectall
      - wordcount
      - showblocks
    
    # Remove plugins
    removePlugins:
      - image
      - elementspath
    
    # Remove buttons
    removeButtons:
      - Underline
      - Strike
      - Subscript
      - Superscript
    
    # Word count configuration
    wordcount:
      showParagraphs: true
      showWordCount: true
      showCharCount: true
      maxWordCount: -1
      maxCharCount: -1

# Processing configuration
processing:
  # Allow additional tags
  allowTags:
    - small
    - mark
    - ins
    - del
    - cite
    - kbd
    - samp
    - var
  
  # Allow classes
  allowedClasses:
    - lead
    - text-left
    - text-center
    - text-right
    - text-justify
    - btn
    - btn-primary
    - btn-secondary
    - alert
    - alert-info
    - alert-warning
```

## Backend Layouts

### Configuration/Sets/SitePackage/PageTsConfig/BackendLayouts/homepage.tsconfig

```tsconfig
mod {
    web_layout {
        BackendLayouts {
            homepage {
                title = Homepage
                config {
                    backend_layout {
                        colCount = 3
                        rowCount = 5
                        rows {
                            1 {
                                columns {
                                    1 {
                                        name = Hero Section
                                        colPos = 10
                                        colspan = 3
                                        identifier = hero
                                    }
                                }
                            }
                            2 {
                                columns {
                                    1 {
                                        name = Feature 1
                                        colPos = 11
                                        identifier = feature1
                                    }
                                    2 {
                                        name = Feature 2
                                        colPos = 12
                                        identifier = feature2
                                    }
                                    3 {
                                        name = Feature 3
                                        colPos = 13
                                        identifier = feature3
                                    }
                                }
                            }
                            3 {
                                columns {
                                    1 {
                                        name = Main Content
                                        colPos = 0
                                        colspan = 2
                                        identifier = main
                                    }
                                    2 {
                                        name = Sidebar
                                        colPos = 2
                                        identifier = sidebar
                                    }
                                }
                            }
                            4 {
                                columns {
                                    1 {
                                        name = Call to Action
                                        colPos = 20
                                        colspan = 3
                                        identifier = cta
                                    }
                                }
                            }
                            5 {
                                columns {
                                    1 {
                                        name = Footer Content
                                        colPos = 30
                                        colspan = 3
                                        identifier = footer
                                    }
                                }
                            }
                        }
                    }
                }
                icon = EXT:sitepackage/Resources/Public/Icons/BackendLayouts/homepage.svg
            }
        }
    }
}
```

## Language Configuration

### Additional language setup in settings.yaml

```yaml
languages:
  # German
  de:
    title: 'Deutsch'
    locale: 'de_DE.UTF-8'
    iso-639-1: 'de'
    hreflang: 'de-DE'
    direction: 'ltr'
    flag: 'de'
    
  # French  
  fr:
    title: 'Français'
    locale: 'fr_FR.UTF-8'
    iso-639-1: 'fr'
    hreflang: 'fr-FR'
    direction: 'ltr'
    flag: 'fr'
```

## Environment-Specific Configuration

### Development vs Production Settings

```yaml
# Development settings (settings.development.yaml)
config:
  no_cache: '1'
  compressJs: '0'
  compressCss: '0'
  concatenateJs: '0'
  concatenateCss: '0'
  admPanel: '1'
  debug: '1'

# Production settings (settings.production.yaml)
config:
  no_cache: '0'
  compressJs: '1'
  compressCss: '1'
  concatenateJs: '1'
  concatenateCss: '1'
  admPanel: '0'
  debug: '0'
```

## Best Practices

1. **Use Site Sets**: Leverage TYPO3 v13's Site Sets for configuration
2. **Organize Files**: Keep configurations logically separated
3. **Use Constants**: Define reusable values in settings.yaml
4. **Document Settings**: Add comments explaining custom configurations
5. **Version Control**: Track all configuration files in Git
6. **Environment Config**: Use different settings for dev/staging/production
7. **Cache Strategy**: Configure appropriate cache settings per environment

## Related Documentation

- [Sitepackage Installation Guide](./sitepackage-installation-guide.md)
- [Sitepackage Structure Reference](./sitepackage-structure-reference.md)
- [Backend Layouts Guide](./sitepackage-backend-layouts.md)
- [Page Templates Guide](./sitepackage-page-templates.md)
