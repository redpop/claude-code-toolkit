---
description: Create TYPO3 extensions using ext-kickstarter or manual scaffolding
argument-hint: "[extension-key] [--type=...] [--use-kickstarter] [--composer-name=...]"
---

# TYPO3 Extension Kickstarter

Creates complete TYPO3 extensions using either the stefanfroemken/ext-kickstarter package or manual scaffolding.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Create TYPO3 extensions using ext-kickstarter or manual scaffolding
- **Usage**: [extension-key] [--type=...] [--use-kickstarter] [--composer-name=...]
- **Options**: --type, --use-kickstarter, --composer-name, --with-backend-module, --with-plugin, etc.
- **Examples**: See the command workflow and skeleton examples below

Then exit without executing the main command.

---

## Usage

```bash
/prefix:typo3:extension-kickstarter [extension-key] [options]
```

## Command Workflow

This command provides two approaches:

1. Using stefanfroemken/ext-kickstarter (if installed)
2. Manual scaffolding with best practices

## Check for ext-kickstarter

```bash
# Check if kickstarter is installed globally
composer global show stefanfroemken/ext-kickstarter

# Or install it
composer global require stefanfroemken/ext-kickstarter
```

## Method 1: Using ext-kickstarter

If ext-kickstarter is available:

```bash
# Run the kickstarter
~/.composer/vendor/bin/ext-kickstarter.php \
    --extension-key="{extension_key}" \
    --vendor="{vendor}" \
    --package-name="{composer_name}" \
    --description="{description}" \
    --author="{author}" \
    --email="{email}" \
    --typo3-versions="13.4" \
    --php-versions="8.2"
```

### Kickstarter Options

```bash
--with-backend-module    # Add backend module
--with-plugin           # Add frontend plugin
--with-middleware       # Add PSR-15 middleware
--with-command          # Add console command
--with-event-listener   # Add event listener
--with-tests           # Add testing setup
```

## Method 2: Manual Scaffolding

For more control or when kickstarter is not available:

### Extension Types

1. **Basic Extension**
2. **Plugin Extension** (with Extbase/Fluid)
3. **Backend Module**
4. **Service Extension** (API/Services)
5. **Content Extension** (Content Elements)

### Basic Extension Structure

```
ext/{extension_key}/
├── Classes/
│   ├── Controller/
│   ├── Domain/
│   │   ├── Model/
│   │   └── Repository/
│   ├── Service/
│   ├── ViewHelpers/
│   └── EventListener/
├── Configuration/
│   ├── Services.yaml
│   ├── TCA/
│   │   └── Overrides/
│   ├── TypoScript/
│   │   ├── constants.typoscript
│   │   └── setup.typoscript
│   ├── TSconfig/
│   │   ├── Page/
│   │   └── User/
│   ├── FlexForms/
│   └── Backend/
│       ├── Routes.php
│       └── Modules.php
├── Resources/
│   ├── Private/
│   │   ├── Language/
│   │   │   ├── locallang.xlf
│   │   │   ├── locallang_db.xlf
│   │   │   └── locallang_mod.xlf
│   │   ├── Templates/
│   │   ├── Partials/
│   │   └── Layouts/
│   └── Public/
│       ├── Icons/
│       │   └── Extension.svg
│       ├── CSS/
│       └── JavaScript/
├── Tests/
│   ├── Unit/
│   └── Functional/
├── Documentation/
│   └── Index.rst
├── composer.json
├── ext_emconf.php
├── ext_localconf.php
├── ext_tables.php
├── ext_tables.sql
└── README.md
```

### Core Files

#### composer.json

```json
{
    "name": "{vendor}/{extension-key}",
    "type": "typo3-cms-extension",
    "description": "{description}",
    "license": "GPL-2.0-or-later",
    "authors": [
        {
            "name": "{author}",
            "email": "{email}"
        }
    ],
    "require": {
        "php": "^8.2",
        "typo3/cms-core": "^13.4",
        "typo3/cms-extbase": "^13.4",
        "typo3/cms-fluid": "^13.4"
    },
    "require-dev": {
        "typo3/testing-framework": "^8.0",
        "phpstan/phpstan": "^1.0",
        "friendsoftypo3/phpstan-typo3": "^0.9"
    },
    "autoload": {
        "psr-4": {
            "{Vendor}\\{ExtensionName}\\": "Classes/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "{Vendor}\\{ExtensionName}\\Tests\\": "Tests/"
        }
    },
    "extra": {
        "typo3/cms": {
            "extension-key": "{extension_key}"
        }
    },
    "scripts": {
        "test": "phpunit -c phpunit.xml",
        "test:unit": "phpunit -c phpunit.xml --testsuite unit",
        "test:functional": "phpunit -c phpunit.xml --testsuite functional",
        "analyse": "phpstan analyse"
    }
}
```

#### ext_emconf.php

```php
<?php
$EM_CONF[$_EXTKEY] = [
    'title' => '{title}',
    'description' => '{description}',
    'category' => '{category}', // be, fe, plugin, misc, services, templates
    'author' => '{author}',
    'author_email' => '{email}',
    'state' => 'stable', // alpha, beta, stable
    'version' => '1.0.0',
    'constraints' => [
        'depends' => [
            'typo3' => '13.4.0-13.4.99',
        ],
        'conflicts' => [],
        'suggests' => [],
    ],
];
```

#### Configuration/Services.yaml

```yaml
services:
  _defaults:
    autowire: true
    autoconfigure: true
    public: false

  {Vendor}\{ExtensionName}\:
    resource: '../Classes/*'
    exclude: '../Classes/Domain/Model/*'

  {Vendor}\{ExtensionName}\Controller\:
    resource: '../Classes/Controller/*'
    public: true
```

### Plugin Extension

#### ext_localconf.php

```php
<?php
defined('TYPO3') || die();

use TYPO3\CMS\Extbase\Utility\ExtensionUtility;
use {Vendor}\{ExtensionName}\Controller\{ControllerName}Controller;

ExtensionUtility::configurePlugin(
    '{ExtensionName}',
    '{PluginName}',
    [
        {ControllerName}Controller::class => 'list, show, new, create, edit, update, delete',
    ],
    // Non-cacheable actions
    [
        {ControllerName}Controller::class => 'create, update, delete',
    ]
);
```

#### Controller Example

```php
<?php
declare(strict_types=1);

namespace {Vendor}\{ExtensionName}\Controller;

use Psr\Http\Message\ResponseInterface;
use TYPO3\CMS\Extbase\Mvc\Controller\ActionController;
use {Vendor}\{ExtensionName}\Domain\Repository\{Model}Repository;

class {ControllerName}Controller extends ActionController
{
    public function __construct(
        private readonly {Model}Repository $repository
    ) {}

    public function listAction(): ResponseInterface
    {
        $this->view->assign('items', $this->repository->findAll());
        return $this->htmlResponse();
    }
}
```

### Backend Module

#### Configuration/Backend/Modules.php

```php
<?php
return [
    '{extension_key}' => [
        'parent' => 'web',
        'position' => ['after' => 'list'],
        'access' => 'user',
        'workspaces' => 'live',
        'iconIdentifier' => 'module-{extension_key}',
        'path' => '/module/{extension_key}',
        'labels' => 'LLL:EXT:{extension_key}/Resources/Private/Language/locallang_mod.xlf',
        'extensionName' => '{ExtensionName}',
        'controllerActions' => [
            {ModuleController}::class => [
                'index', 'list', 'edit'
            ],
        ],
    ],
];
```

### Service Extension

#### Service Class Example

```php
<?php
declare(strict_types=1);

namespace {Vendor}\{ExtensionName}\Service;

use TYPO3\CMS\Core\Cache\Frontend\FrontendInterface;
use TYPO3\CMS\Core\Database\ConnectionPool;
use TYPO3\CMS\Core\SingletonInterface;

class {ServiceName}Service implements SingletonInterface
{
    public function __construct(
        private readonly ConnectionPool $connectionPool,
        private readonly FrontendInterface $cache
    ) {}
    
    public function process(array $data): array
    {
        // Service logic
        return $data;
    }
}
```

### Event Listener

#### Classes/EventListener/{EventName}Listener.php

```php
<?php
declare(strict_types=1);

namespace {Vendor}\{ExtensionName}\EventListener;

use TYPO3\CMS\Core\Attribute\AsEventListener;

#[AsEventListener(
    identifier: '{extension-key}-{event-name}',
    event: \TYPO3\CMS\Core\DataHandling\Event\AppendLinkHandlerElementsEvent::class
)]
final class {EventName}Listener
{
    public function __invoke(AppendLinkHandlerElementsEvent $event): void
    {
        // Event handling logic
    }
}
```

### Console Command

#### Classes/Command/{CommandName}Command.php

```php
<?php
declare(strict_types=1);

namespace {Vendor}\{ExtensionName}\Command;

use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

class {CommandName}Command extends Command
{
    protected function configure(): void
    {
        $this
            ->setName('{extension_key}:{command}')
            ->setDescription('{description}')
            ->setHelp('This command does...');
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        
        $io->title('Command Title');
        
        // Command logic
        
        $io->success('Command completed successfully');
        
        return Command::SUCCESS;
    }
}
```

### Testing Setup

#### phpunit.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<phpunit xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:noNamespaceSchemaLocation="vendor/phpunit/phpunit/phpunit.xsd"
         bootstrap="vendor/typo3/testing-framework/Resources/Core/Build/UnitTestsBootstrap.php"
         colors="true">
    <testsuites>
        <testsuite name="unit">
            <directory>Tests/Unit/</directory>
        </testsuite>
        <testsuite name="functional">
            <directory>Tests/Functional/</directory>
        </testsuite>
    </testsuites>
    <coverage>
        <include>
            <directory suffix=".php">Classes/</directory>
        </include>
    </coverage>
</phpunit>
```

#### PHPStan Configuration

```neon
# phpstan.neon
includes:
    - vendor/friendsoftypo3/phpstan-typo3/extension.neon

parameters:
    level: 5
    paths:
        - Classes
        - Configuration
    excludePaths:
        - Tests
```

## Interactive Mode

If no arguments provided, guide through:

1. **Extension Type**:

```
Select extension type:
1. Basic Extension
2. Plugin (Frontend)
3. Backend Module
4. Service/API
5. Content Elements
Choice [1-5]: 
```

2. **Basic Information**:

- Extension key (lowercase, underscores)
- Vendor name
- Title
- Description
- Author information

3. **Features to Include**:

```
Select features to include:
[ ] Backend Module
[ ] Console Commands
[ ] Event Listeners
[ ] Scheduler Tasks
[ ] Middleware
[ ] ViewHelpers
[ ] Unit Tests
[ ] Functional Tests
```

4. **Dependencies**:

```
Select TYPO3 components:
[x] Core
[x] Extbase
[x] Fluid
[ ] Backend
[ ] Frontend
[ ] Install
[ ] Dashboard
[ ] SEO
[ ] Redirects
```

## Post-Generation

After successful creation:

```
✅ Extension created successfully!

📁 Location: {path}
📦 Extension Key: {extension_key}
🎯 Type: {type}
✅ Composer: Configured
✅ Services: Configured

Next steps:
1. Install the extension:
   composer require {vendor}/{extension-key}:@dev
   
2. Activate in Extension Manager:
   vendor/bin/typo3 extension:setup
   
3. Clear caches:
   vendor/bin/typo3 cache:flush
   
4. {Type-specific instructions}

Development commands:
- Run tests: composer test
- Static analysis: composer analyse
- Clear cache: vendor/bin/typo3 cache:flush

Happy coding! 🚀
```

## Best Practices Applied

1. **PSR-4 Autoloading**
2. **Dependency Injection**
3. **Service Configuration**
4. **Event-Driven Architecture**
5. **Testing Setup**
6. **PHPStan Integration**
7. **Proper Versioning**
8. **Documentation Structure**

## Error Handling

- Validate extension key format
- Check for existing extensions
- Ensure PHP/TYPO3 version compatibility
- Handle file permission issues
- Provide helpful error messages
