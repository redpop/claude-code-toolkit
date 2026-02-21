---
name: sitepackage
description: Create a TYPO3 v13.4 SitePackage based on official template with Site Sets
---

# TYPO3 SitePackage Generator

Creates a complete TYPO3 v13.4 SitePackage based on the official template from get.typo3.org with modern Site Sets configuration and Fluid Styled Content integration.

## Arguments

Parse arguments from `$ARGUMENTS`:

- **vendor**: Vendor name (lowercase, e.g., "mycompany")
- **package-name**: Package name (kebab-case, e.g., "corporate-site")
- `--include-ddev` — Include DDEV configuration
- `--include-docker` — Include Docker configuration
- `--author=name` — Author name
- `--email=address` — Author email

If arguments are missing, ask interactively for: vendor, package name, extension title, author name/email/company.

## Knowledge References

- `${CLAUDE_PLUGIN_ROOT}/knowledge/sitepackage-v13-template.md`
- `${CLAUDE_PLUGIN_ROOT}/knowledge/sitepackage-structure-reference.md`
- `${CLAUDE_PLUGIN_ROOT}/knowledge/sitepackage-configuration-guide.md`
- `${CLAUDE_PLUGIN_ROOT}/knowledge/sitepackage-installation-guide.md`
- `${CLAUDE_PLUGIN_ROOT}/knowledge/sitepackage-practical-examples.md`

## Execution

### 1. Create Complete Structure

Generate all files for a TYPO3 v13.4 SitePackage:

- `composer.json` — typo3-cms-extension type, TYPO3 13.4 dependencies
- `ext_emconf.php` — Extension metadata with constraints
- `ext_localconf.php` — RTE preset registration
- `ext_tables.php` — Empty placeholder
- Configuration/Sets/SitePackage/ — Site Set with config.yaml, setup.typoscript, settings.yaml, page.tsconfig
- Configuration/RTE/Default.yaml — CKEditor configuration
- Resources/Private/PageView/ — PAGEVIEW templates (Layouts, Pages, Partials)
- Resources/Private/Language/ — locallang.xlf, locallang_be.xlf, locallang_db.xlf
- Resources/Public/ — CSS (layout, rte), JavaScript, Icons, Fonts

### 2. Configure Site Set

- `config.yaml`: name, label, dependencies (fluid-styled-content)
- `settings.yaml`: template paths, meta tags, tracking, config constants
- `page.tsconfig`: Backend layout imports, RTE preset, TCEFORM/TCEMAIN
- TypoScript: PAGE object with PAGEVIEW, CSS/JS includes, meta tags

### 3. Optional: DDEV Config

When `--include-ddev`: Create `.ddev/config.yaml` with TYPO3 type, PHP 8.2, MariaDB 10.11.

## Output Format

```
TYPO3 v13 SitePackage created successfully!

Location: packages/{vendor}/{package}/
Extension Key: {extension-key}
TYPO3 Version: 13.4 LTS
Features: Site Sets, PAGEVIEW, Fluid Styled Content, RTE, Backend layouts, i18n

Next steps:
1. Add to composer.json repositories
2. composer require {vendor}/{package}:@dev
3. vendor/bin/typo3 extension:setup
4. Configure Site Set in Site Configuration
```
