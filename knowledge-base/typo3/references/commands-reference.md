# TYPO3 Commands Reference

## Cache Management

### Standard Cache Clear

```bash
ddev exec typo3 cache:flush
```

### Aggressive Cache Clear

```bash
# Remove all cache files
ddev exec rm -rf var/cache/*
ddev exec typo3 cache:flush
```

### Full System Reset

```bash
# Complete cache and temp clear
ddev exec rm -rf var/cache/*
ddev exec rm -rf public/typo3temp/*
ddev exec typo3 cache:flush
ddev exec typo3 database:updateschema
```

### Container Restart (Last Resort)

```bash
ddev stop
ddev start
```

## Database Commands

### Show Tables

```bash
# Show all tables with specific prefix
ddev mysql -e "SHOW TABLES LIKE '%punktde%'"

# Show all tables
ddev mysql -e "SHOW TABLES"
```

### Inspect Table Structure

```bash
# Describe table structure
ddev mysql -e "DESCRIBE punktde_accordion_items"

# Show create statement
ddev mysql -e "SHOW CREATE TABLE punktde_accordion_items"
```

### Database Schema Update

```bash
ddev exec typo3 database:updateschema
```

## System Information

### DDEV Status

```bash
# Check DDEV environment
ddev describe

# View logs
ddev logs -f
```

### TYPO3 Status

```bash
# List all TYPO3 commands
ddev exec typo3 list

# Extension status
ddev exec typo3 extension:list
```

## Development Commands

### Extension Setup

```bash
# Activate extensions
vendor/bin/typo3 extension:setup

# Clear and rebuild
ddev exec typo3 cache:flush
ddev exec typo3 database:updateschema
```

### Composer Operations

```bash
# Require local sitepackage
composer require vendor/package:@dev

# Update autoload
composer dump-autoload
```

## Debugging Commands

### PHP Debugging

```bash
# Check PHP configuration
ddev exec php -i | grep -i xdebug

# Error logs
ddev exec tail -f var/log/typo3_*.log
```

### MySQL Debugging

```bash
# Check running queries
ddev mysql -e "SHOW PROCESSLIST"

# Check table sizes
ddev mysql -e "SELECT table_name, round(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)' FROM information_schema.TABLES WHERE table_schema = 'db' ORDER BY (data_length + index_length) DESC"
```

## Quick Reference Table

| Task | Command | When to Use |
|------|---------|-------------|
| Quick cache clear | `ddev exec typo3 cache:flush` | After template changes |
| Force cache clear | `ddev exec rm -rf var/cache/*` | When normal clear doesn't work |
| Update database | `ddev exec typo3 database:updateschema` | After config.yaml changes |
| Check tables | `ddev mysql -e "SHOW TABLES"` | Verify table creation |
| View logs | `ddev logs -f` | Debug errors |
| Restart environment | `ddev restart` | System issues |
