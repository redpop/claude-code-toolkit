---
name: make-content-block
description: Wrapper for TYPO3 make:content-block command with intelligent defaults
---

# TYPO3 Make Content Block Wrapper

Intelligent wrapper for the native TYPO3 `make:content-block` command with sensible defaults, skeleton management, and interactive guidance.

## Arguments

Parse arguments from `$ARGUMENTS`:

- `--vendor=...` — Vendor prefix
- `--type=content-element|page-type|record-type` — Content type
- `--skeleton-path=...` — Custom skeleton directory
- `--config-path=...` — Path to content-blocks.yaml
- `--create-skeleton` — Create a new reusable skeleton
- `--batch=file.yaml` — Batch creation from definition file
- `--migrate-from=mask|dce` — Migration helper

## Knowledge References

- `${CLAUDE_PLUGIN_ROOT}/knowledge/content-blocks-core-patterns.md`
- `${CLAUDE_PLUGIN_ROOT}/knowledge/content-blocks-v13-complete-reference.md`

## Execution

### 1. Check Prerequisites

```bash
composer show friendsoftypo3/content-blocks
```

If not installed, suggest: `composer require friendsoftypo3/content-blocks:^1.3`

### 2. Find or Create Configuration

Search for `content-blocks.yaml` in: project root, packages/sitepackage/, .claude/typo3/. If none exists, create one with vendor, extension, content-type, skeleton-path.

### 3. Smart Defaults

- **Vendor detection**: From composer.json name, git remote URL, or existing Content Blocks
- **Extension detection**: Search packages/sitepackage, packages/\*/sitepackage, typo3conf/ext/sitepackage
- **Unique typeName**: Generate from timestamp for Page Types

### 4. Show Available Skeletons

Built-in skeletons: hero, card-grid, accordion, landing-page, or custom (from scratch).

### 5. Run Native Command

```bash
vendor/bin/typo3 make:content-block \
    --vendor="{vendor}" \
    --extension="{extension}" \
    --content-type="{type}" \
    --skeleton-path="{path}"
```

### 6. Post-Generation

Clear caches: `vendor/bin/typo3 cache:flush`

### Advanced Features

- **--create-skeleton**: Interactive skeleton creation saved for reuse
- **--batch**: Create multiple blocks from YAML definition file
- **--migrate-from**: Convert Mask/DCE to Content Blocks format

## Output Format

```
Content Block created successfully!

Type: {type}
Name: {vendor}/{name}
Location: {path}

Next steps:
1. Caches cleared
2. Edit config.yaml, frontend.html, backend-preview.html
3. Test in backend
```
