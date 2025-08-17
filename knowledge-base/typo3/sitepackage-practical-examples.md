# TYPO3 v13 Sitepackage Practical Examples

## Real-World Implementation Examples

This guide provides practical, copy-paste ready examples for common sitepackage implementations.

## Example 1: Complete Bootstrap 5 Integration

### Page Template with Bootstrap

**Resources/Private/PageView/Layouts/Bootstrap.html**

```html
<!DOCTYPE html>
<html lang="{site.language.locale}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <f:render partial="Meta" arguments="{_all}" />
    <f:render partial="Assets/Css" arguments="{_all}" />
</head>
<body>
    <f:render partial="Navigation/Main" arguments="{_all}" />
    
    <main class="flex-shrink-0">
        <f:render section="Main" />
    </main>
    
    <f:render partial="Footer" arguments="{_all}" />
    <f:render partial="Assets/JavaScript" arguments="{_all}" />
</body>
</html>
```

**Resources/Private/PageView/Partials/Navigation/Main.html**

```html
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container">
        <a class="navbar-brand" href="/">
            <f:image src="{settings.logo.file}" alt="{settings.logo.alt}" height="40" />
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <f:for each="{mainnavigation}" as="item">
                    <li class="nav-item {f:if(condition: item.children, then: 'dropdown')}">
                        <f:if condition="{item.children}">
                            <f:then>
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    {item.title}
                                </a>
                                <ul class="dropdown-menu">
                                    <f:for each="{item.children}" as="child">
                                        <li>
                                            <a class="dropdown-item {f:if(condition: child.active, then: 'active')}" 
                                               href="{child.link}">
                                                {child.title}
                                            </a>
                                        </li>
                                    </f:for>
                                </ul>
                            </f:then>
                            <f:else>
                                <a class="nav-link {f:if(condition: item.active, then: 'active')}" 
                                   href="{item.link}">
                                    {item.title}
                                </a>
                            </f:else>
                        </f:if>
                    </li>
                </f:for>
            </ul>
        </div>
    </div>
</nav>
```

## Example 2: Custom Content Element

### Hero Banner Element

**Configuration/TCA/Overrides/tt_content.php**

```php
<?php
defined('TYPO3') or die();

// Register hero banner content element
\TYPO3\CMS\Core\Utility\ExtensionManagementUtility::addTcaSelectItem(
    'tt_content',
    'CType',
    [
        'LLL:EXT:sitepackage/Resources/Private/Language/locallang_db.xlf:tt_content.CType.hero_banner',
        'hero_banner',
        'content-special-hero'
    ],
    'header',
    'after'
);

// Configure hero banner fields
$GLOBALS['TCA']['tt_content']['types']['hero_banner'] = [
    'showitem' => '
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:general,
            --palette--;;general,
            --palette--;;headers,
            bodytext;LLL:EXT:frontend/Resources/Private/Language/locallang_ttc.xlf:bodytext_formlabel,
            image,
            --palette--;;imagelinks,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:appearance,
            --palette--;;frames,
            --palette--;;appearanceLinks,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:access,
            --palette--;;hidden,
            --palette--;;access,
    ',
    'columnsOverrides' => [
        'bodytext' => [
            'config' => [
                'enableRichtext' => true,
                'richtextConfiguration' => 'default'
            ]
        ],
        'image' => [
            'config' => [
                'maxitems' => 1
            ]
        ]
    ]
];
```

**Resources/Private/ContentElements/Templates/HeroBanner.html**

```html
<html data-namespace-typo3-fluid="true"
      xmlns:f="http://typo3.org/ns/TYPO3/CMS/Fluid/ViewHelpers">

<section class="hero-banner position-relative">
    <f:if condition="{images.0}">
        <div class="hero-image">
            <f:image image="{images.0}" 
                     class="img-fluid w-100" 
                     width="1920" 
                     height="600" 
                     cropVariant="hero" />
        </div>
    </f:if>
    
    <div class="hero-content position-absolute top-50 start-50 translate-middle text-center text-white">
        <f:if condition="{data.header}">
            <h1 class="display-4 fw-bold mb-4">{data.header}</h1>
        </f:if>
        
        <f:if condition="{data.subheader}">
            <p class="lead mb-4">{data.subheader}</p>
        </f:if>
        
        <f:if condition="{data.bodytext}">
            <div class="hero-text mb-4">
                <f:format.html>{data.bodytext}</f:format.html>
            </div>
        </f:if>
        
        <f:if condition="{data.header_link}">
            <a href="{data.header_link}" class="btn btn-primary btn-lg">
                Learn More
            </a>
        </f:if>
    </div>
</section>

<style>
.hero-banner {
    min-height: 600px;
    overflow: hidden;
}
.hero-image img {
    object-fit: cover;
    min-height: 600px;
}
.hero-content {
    z-index: 2;
    max-width: 800px;
    padding: 2rem;
    background: rgba(0,0,0,0.5);
    border-radius: 10px;
}
</style>
</html>
```

## Example 3: Custom ViewHelper

### Responsive Image ViewHelper

**Classes/ViewHelpers/ResponsiveImageViewHelper.php**

```php
<?php
declare(strict_types=1);

namespace Vendor\Sitepackage\ViewHelpers;

use TYPO3\CMS\Core\Resource\FileInterface;
use TYPO3\CMS\Fluid\ViewHelpers\ImageViewHelper;

class ResponsiveImageViewHelper extends ImageViewHelper
{
    public function initializeArguments(): void
    {
        parent::initializeArguments();
        $this->registerArgument('breakpoints', 'array', 'Responsive breakpoints', false, []);
    }

    public function render(): string
    {
        $image = $this->arguments['image'] ?? $this->arguments['src'];
        $breakpoints = $this->arguments['breakpoints'];
        
        if (empty($breakpoints)) {
            return parent::render();
        }
        
        $sources = [];
        foreach ($breakpoints as $breakpoint => $width) {
            $sources[] = sprintf(
                '<source media="(min-width: %spx)" srcset="%s">',
                $breakpoint,
                $this->imageService->getImageUri(
                    $this->imageService->applyProcessingInstructions($image, ['width' => $width])
                )
            );
        }
        
        $fallback = parent::render();
        
        return sprintf(
            '<picture>%s%s</picture>',
            implode('', $sources),
            $fallback
        );
    }
}
```

**Usage in template:**

```html
<sitepackage:responsiveImage 
    image="{image}" 
    breakpoints="{sm: 576, md: 768, lg: 992, xl: 1200}" 
    alt="Responsive image" />
```

## Example 4: Custom Data Processor

### Social Media Links Processor

**Classes/DataProcessing/SocialMediaProcessor.php**

```php
<?php
declare(strict_types=1);

namespace Vendor\Sitepackage\DataProcessing;

use TYPO3\CMS\Frontend\ContentObject\ContentObjectRenderer;
use TYPO3\CMS\Frontend\ContentObject\DataProcessorInterface;

class SocialMediaProcessor implements DataProcessorInterface
{
    public function process(
        ContentObjectRenderer $cObj,
        array $contentObjectConfiguration,
        array $processorConfiguration,
        array $processedData
    ): array {
        $socialMedia = [
            'facebook' => $processorConfiguration['facebook'] ?? '',
            'twitter' => $processorConfiguration['twitter'] ?? '',
            'instagram' => $processorConfiguration['instagram'] ?? '',
            'linkedin' => $processorConfiguration['linkedin'] ?? '',
            'youtube' => $processorConfiguration['youtube'] ?? '',
        ];
        
        // Filter out empty values
        $socialMedia = array_filter($socialMedia);
        
        // Add icons
        foreach ($socialMedia as $platform => &$url) {
            $url = [
                'url' => $url,
                'platform' => $platform,
                'icon' => 'bi-' . $platform,
                'title' => ucfirst($platform)
            ];
        }
        
        $targetVariableName = $cObj->stdWrapValue(
            'as',
            $processorConfiguration,
            'socialMedia'
        );
        
        $processedData[$targetVariableName] = $socialMedia;
        
        return $processedData;
    }
}
```

**Configuration in TypoScript:**

```typoscript
page.10.dataProcessing {
    100 = Vendor\Sitepackage\DataProcessing\SocialMediaProcessor
    100 {
        facebook = https://facebook.com/company
        twitter = https://twitter.com/company
        instagram = https://instagram.com/company
        linkedin = https://linkedin.com/company/company
        as = socialMedia
    }
}
```

## Example 5: Multi-Language Setup

### Language Menu Implementation

**Resources/Private/PageView/Partials/Navigation/Language.html**

```html
<f:if condition="{languagenavigation}">
    <div class="language-menu dropdown">
        <button class="btn btn-sm btn-outline-secondary dropdown-toggle" 
                type="button" 
                data-bs-toggle="dropdown">
            <i class="bi bi-globe"></i>
            <span>{languagenavigation.0.title}</span>
        </button>
        <ul class="dropdown-menu">
            <f:for each="{languagenavigation}" as="language">
                <li>
                    <a class="dropdown-item {f:if(condition: language.active, then: 'active')}" 
                       href="{language.link}"
                       hreflang="{language.hreflang}">
                        <span class="flag-icon flag-icon-{language.flag}"></span>
                        {language.title}
                    </a>
                </li>
            </f:for>
        </ul>
    </div>
</f:if>
```

## Example 6: Cookie Consent Banner

**Resources/Private/PageView/Partials/CookieConsent.html**

```html
<div id="cookieConsent" class="cookie-consent" style="display: none;">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <p class="mb-0">
                    <f:translate key="cookie.message" />
                </p>
            </div>
            <div class="col-md-4 text-end">
                <button class="btn btn-sm btn-outline-light me-2" onclick="declineCookies()">
                    <f:translate key="cookie.decline" />
                </button>
                <button class="btn btn-sm btn-primary" onclick="acceptCookies()">
                    <f:translate key="cookie.accept" />
                </button>
            </div>
        </div>
    </div>
</div>

<script>
// Check if consent was already given
if (!localStorage.getItem('cookieConsent')) {
    document.getElementById('cookieConsent').style.display = 'block';
}

function acceptCookies() {
    localStorage.setItem('cookieConsent', 'accepted');
    document.getElementById('cookieConsent').style.display = 'none';
    // Enable tracking scripts
    if (typeof gtag !== 'undefined') {
        gtag('consent', 'update', {
            'analytics_storage': 'granted'
        });
    }
}

function declineCookies() {
    localStorage.setItem('cookieConsent', 'declined');
    document.getElementById('cookieConsent').style.display = 'none';
}
</script>

<style>
.cookie-consent {
    position: fixed;
    bottom: 0;
    left: 0;
    right: 0;
    background: rgba(0,0,0,0.9);
    color: white;
    padding: 1rem 0;
    z-index: 9999;
}
</style>
```

## Example 7: Backend Layout with Content Areas

**Configuration/Sets/SitePackage/PageTsConfig/BackendLayouts/landingpage.tsconfig**

```tsconfig
mod {
    web_layout {
        BackendLayouts {
            landingpage {
                title = Landing Page
                config {
                    backend_layout {
                        colCount = 4
                        rowCount = 6
                        rows {
                            1 {
                                columns {
                                    1 {
                                        name = Hero Section
                                        colPos = 10
                                        colspan = 4
                                    }
                                }
                            }
                            2 {
                                columns {
                                    1 {
                                        name = Highlight 1
                                        colPos = 11
                                    }
                                    2 {
                                        name = Highlight 2
                                        colPos = 12
                                    }
                                    3 {
                                        name = Highlight 3
                                        colPos = 13
                                    }
                                    4 {
                                        name = Highlight 4
                                        colPos = 14
                                    }
                                }
                            }
                            3 {
                                columns {
                                    1 {
                                        name = Content Left
                                        colPos = 20
                                        colspan = 2
                                    }
                                    2 {
                                        name = Content Right
                                        colPos = 21
                                        colspan = 2
                                    }
                                }
                            }
                            4 {
                                columns {
                                    1 {
                                        name = Feature Section
                                        colPos = 30
                                        colspan = 4
                                    }
                                }
                            }
                            5 {
                                columns {
                                    1 {
                                        name = Testimonial 1
                                        colPos = 40
                                    }
                                    2 {
                                        name = Testimonial 2
                                        colPos = 41
                                    }
                                    3 {
                                        name = Testimonial 3
                                        colPos = 42
                                    }
                                    4 {
                                        name = Testimonial 4
                                        colPos = 43
                                    }
                                }
                            }
                            6 {
                                columns {
                                    1 {
                                        name = Call to Action
                                        colPos = 50
                                        colspan = 4
                                    }
                                }
                            }
                        }
                    }
                }
                icon = EXT:sitepackage/Resources/Public/Icons/BackendLayouts/landingpage.svg
            }
        }
    }
}
```

**Resources/Private/PageView/Pages/Landingpage.html**

```html
<f:layout name="Default" />

<f:section name="Main">
    <!-- Hero Section -->
    <f:if condition="{content.hero.records}">
        <section class="hero-section">
            <div class="container-fluid p-0">
                <f:render partial="Content" arguments="{records: content.hero.records}" />
            </div>
        </section>
    </f:if>
    
    <!-- Highlights -->
    <f:if condition="{content.highlight1.records} || {content.highlight2.records} || {content.highlight3.records} || {content.highlight4.records}">
        <section class="highlights py-5">
            <div class="container">
                <div class="row">
                    <div class="col-md-3">
                        <f:render partial="Content" arguments="{records: content.highlight1.records}" />
                    </div>
                    <div class="col-md-3">
                        <f:render partial="Content" arguments="{records: content.highlight2.records}" />
                    </div>
                    <div class="col-md-3">
                        <f:render partial="Content" arguments="{records: content.highlight3.records}" />
                    </div>
                    <div class="col-md-3">
                        <f:render partial="Content" arguments="{records: content.highlight4.records}" />
                    </div>
                </div>
            </div>
        </section>
    </f:if>
    
    <!-- Main Content -->
    <section class="main-content py-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <f:render partial="Content" arguments="{records: content.contentLeft.records}" />
                </div>
                <div class="col-md-6">
                    <f:render partial="Content" arguments="{records: content.contentRight.records}" />
                </div>
            </div>
        </div>
    </section>
</f:section>
```

## Example 8: Form Framework Integration

### Contact Form Configuration

**Configuration/Forms/contact.form.yaml**

```yaml
renderingOptions:
  submitButtonLabel: Send Message
type: Form
identifier: contact
label: 'Contact Form'
prototypeName: standard

finishers:
  - identifier: EmailToReceiver
    options:
      subject: 'Contact form submission'
      recipientAddress: 'info@example.com'
      recipientName: 'Company Name'
      senderAddress: '{email}'
      senderName: '{name}'
      replyToAddress: '{email}'
      
  - identifier: EmailToSender
    options:
      subject: 'Thank you for your message'
      recipientAddress: '{email}'
      recipientName: '{name}'
      senderAddress: 'noreply@example.com'
      senderName: 'Company Name'
      
  - identifier: Redirect
    options:
      pageUid: 10
      additionalParameters: 'tx_form_success=1'

renderables:
  - type: Page
    identifier: page-1
    label: ''
    renderables:
      - type: Text
        identifier: name
        label: 'Your Name'
        properties:
          fluidAdditionalAttributes:
            required: required
            placeholder: 'John Doe'
        validators:
          - identifier: NotEmpty
          - identifier: StringLength
            options:
              minimum: 2
              maximum: 100
              
      - type: Email
        identifier: email
        label: 'Email Address'
        properties:
          fluidAdditionalAttributes:
            required: required
            placeholder: 'john@example.com'
        validators:
          - identifier: NotEmpty
          - identifier: EmailAddress
          
      - type: Telephone
        identifier: phone
        label: 'Phone Number'
        properties:
          fluidAdditionalAttributes:
            placeholder: '+1234567890'
            
      - type: Textarea
        identifier: message
        label: 'Your Message'
        properties:
          fluidAdditionalAttributes:
            required: required
            rows: 5
            placeholder: 'Your message here...'
        validators:
          - identifier: NotEmpty
          - identifier: StringLength
            options:
              minimum: 10
              maximum: 1000
              
      - type: Checkbox
        identifier: privacy
        label: 'I agree to the privacy policy'
        validators:
          - identifier: NotEmpty
            errorMessage: 'You must agree to the privacy policy'
```

## Common Patterns Summary

### 1. Asset Loading Pattern

```typoscript
page.includeCSS {
    main = EXT:sitepackage/Resources/Public/Css/main.min.css
    main.media = all
    main.forceOnTop = 1
}

page.includeJSFooter {
    main = EXT:sitepackage/Resources/Public/JavaScript/main.min.js
    main.async = 1
    main.defer = 1
}
```

### 2. Responsive Images Pattern

```html
<picture>
    <source media="(min-width: 1200px)" 
            srcset="{f:uri.image(image: image, width: '1200')}">
    <source media="(min-width: 768px)" 
            srcset="{f:uri.image(image: image, width: '768')}">
    <img src="{f:uri.image(image: image, width: '320')}" 
         alt="{image.alternative}" 
         class="img-fluid">
</picture>
```

### 3. Conditional Content Pattern

```html
<f:if condition="{data.field}">
    <f:then>
        <!-- Content when true -->
    </f:then>
    <f:else if="{data.otherField}">
        <!-- Alternative content -->
    </f:else>
    <f:else>
        <!-- Default content -->
    </f:else>
</f:if>
```

## Best Practices Applied

1. **Separation of Concerns**: Templates, partials, and layouts are clearly separated
2. **Reusability**: Components are built as partials for reuse
3. **Performance**: Assets are optimized and loaded efficiently
4. **Accessibility**: Semantic HTML and ARIA attributes where needed
5. **Responsiveness**: Mobile-first approach with Bootstrap
6. **Maintainability**: Clear structure and documentation

## Related Documentation

- [Sitepackage Installation Guide](./sitepackage-installation-guide.md)
- [Sitepackage Configuration Guide](./sitepackage-configuration-guide.md)
- [Sitepackage Structure Reference](./sitepackage-structure-reference.md)
- [Content Blocks Integration](./content-blocks-core-patterns.md)
