---
name: extension-kickstarter
description: Create TYPO3 extensions using ext-kickstarter or manual scaffolding
---

# TYPO3 Extension Kickstarter

Creates complete TYPO3 extensions using either stefanfroemken/ext-kickstarter or manual scaffolding with best practices.

## Arguments

Parse arguments from `$ARGUMENTS`:

- **extension-key**: Extension key (lowercase, underscores)
- `--type=basic|plugin|backend-module|service|content` — Extension type
- `--use-kickstarter` — Use ext-kickstarter if available
- `--composer-name=vendor/name` — Composer package name
- `--with-backend-module` — Include backend module
- `--with-plugin` — Include frontend plugin
- `--with-middleware` — Include PSR-15 middleware
- `--with-command` — Include console command
- `--with-event-listener` — Include event listener
- `--with-tests` — Include PHPUnit testing setup

If no arguments, guide interactively through type selection, basic info, feature selection, and dependencies.

## Execution

### 1. Check for ext-kickstarter

```bash
composer global show stefanfroemken/ext-kickstarter
```

If available and `--use-kickstarter` flag set, use it. Otherwise, use manual scaffolding.

### 2. Create Extension Structure

Generate complete structure with:

- `composer.json` — PSR-4 autoloading, TYPO3 13.4 dependencies, dev tools
- `ext_emconf.php` — Extension metadata
- `Configuration/Services.yaml` — DI configuration with autowire/autoconfigure
- `ext_localconf.php` — Plugin registration (if plugin type)
- `Configuration/Backend/Modules.php` — Backend module (if backend-module type)

### 3. Generate Type-Specific Code

**Plugin**: Controller with ActionController, Repository integration, Extbase plugin registration.
**Backend Module**: Module registration, dedicated controller, language files.
**Service**: Service class with ConnectionPool/Cache injection.
**Event Listener**: PHP 8.2 attribute-based listener with `#[AsEventListener]`.
**Console Command**: Symfony Command with SymfonyStyle output.

### 4. Optional: Testing Setup

When `--with-tests`: phpunit.xml, PHPStan config (level 5), Unit/Functional test directories, testing-framework dependency.

## Output Format

```
Extension created successfully!

Location: {path}
Extension Key: {extension_key}
Type: {type}

Next steps:
1. composer require {vendor}/{extension-key}:@dev
2. vendor/bin/typo3 extension:setup
3. vendor/bin/typo3 cache:flush
```
