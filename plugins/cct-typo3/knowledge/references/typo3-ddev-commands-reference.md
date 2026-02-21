# TYPO3 v13 Commands Reference (DDEV & Non-DDEV)

> **Note:** This reference is optimized for TYPO3 v13. Commands are shown for both DDEV and non-DDEV environments.

## Cache Management

### Standard Cache Clear

```bash
# DDEV environment
ddev exec typo3 cache:flush

# Non-DDEV environment
./vendor/bin/typo3 cache:flush
```

### Cache Warmup (TYPO3 v13)

```bash
# DDEV environment
ddev exec typo3 cache:warmup

# Non-DDEV environment
./vendor/bin/typo3 cache:warmup
```

### Aggressive Cache Clear

```bash
# DDEV environment
ddev exec rm -rf var/cache/*
ddev exec typo3 cache:flush

# Non-DDEV environment
rm -rf var/cache/*
./vendor/bin/typo3 cache:flush
```

### Full System Reset

```bash
# DDEV environment
ddev exec rm -rf var/cache/*
ddev exec rm -rf public/typo3temp/*
ddev exec typo3 cache:flush
ddev exec typo3 database:updateschema

# Non-DDEV environment
rm -rf var/cache/*
rm -rf public/typo3temp/*
./vendor/bin/typo3 cache:flush
./vendor/bin/typo3 database:updateschema
```

### Container Restart (DDEV Only)

```bash
ddev stop
ddev start
```

## Database Commands

### Show Tables

```bash
# DDEV environment
ddev mysql -e "SHOW TABLES LIKE '%punktde%'"
ddev mysql -e "SHOW TABLES"

# Non-DDEV environment (requires MySQL CLI access)
mysql -u dbuser -p dbname -e "SHOW TABLES"
```

### Inspect Table Structure

```bash
# DDEV environment
ddev mysql -e "DESCRIBE punktde_accordion_items"
ddev mysql -e "SHOW CREATE TABLE punktde_accordion_items"

# Non-DDEV environment
mysql -u dbuser -p dbname -e "DESCRIBE punktde_accordion_items"
```

### Database Schema Update

```bash
# DDEV environment
ddev exec typo3 database:updateschema

# Non-DDEV environment
./vendor/bin/typo3 database:updateschema
```

### Database Analyze (TYPO3 v13)

```bash
# DDEV environment
ddev exec typo3 database:analyze

# Non-DDEV environment
./vendor/bin/typo3 database:analyze
```

## Site Configuration (TYPO3 v13)

### Site Sets Management

```bash
# DDEV environment
# List available site sets
ddev exec typo3 site:sets:list

# Show site configuration
ddev exec typo3 site:show

# Non-DDEV environment
./vendor/bin/typo3 site:sets:list
./vendor/bin/typo3 site:show
```

## Extension Management

### List Extensions

```bash
# DDEV environment
ddev exec typo3 extension:list

# Non-DDEV environment
./vendor/bin/typo3 extension:list
```

### Setup Extensions

```bash
# DDEV environment
ddev exec typo3 extension:setup

# Non-DDEV environment
./vendor/bin/typo3 extension:setup
```

### Activate/Deactivate Extensions

```bash
# DDEV environment
ddev exec typo3 extension:activate extension_key
ddev exec typo3 extension:deactivate extension_key

# Non-DDEV environment
./vendor/bin/typo3 extension:activate extension_key
./vendor/bin/typo3 extension:deactivate extension_key
```

## Backend User Management (TYPO3 v13)

### Create Backend User

```bash
# DDEV environment
ddev exec typo3 backend:user:create username --password="secure_password" --admin

# Non-DDEV environment
./vendor/bin/typo3 backend:user:create username --password="secure_password" --admin
```

### Reset Backend User Password

```bash
# DDEV environment
ddev exec typo3 backend:user:resetpassword username

# Non-DDEV environment
./vendor/bin/typo3 backend:user:resetpassword username
```

## Language Management (TYPO3 v13)

### Update Language Packs

```bash
# DDEV environment
ddev exec typo3 language:update

# Non-DDEV environment
./vendor/bin/typo3 language:update
```

## System Information

### DDEV Status (DDEV Only)

```bash
# Check DDEV environment
ddev describe

# View logs
ddev logs -f

# PHP version
ddev exec php -v

# MySQL version
ddev mysql --version
```

### TYPO3 Status

```bash
# DDEV environment
# List all TYPO3 commands
ddev exec typo3 list

# Configuration dump
ddev exec typo3 configuration:show

# Non-DDEV environment
./vendor/bin/typo3 list
./vendor/bin/typo3 configuration:show
```

## Development Commands

### Composer Operations

```bash
# DDEV environment
ddev composer require vendor/package:@dev
ddev composer dump-autoload
ddev composer install
ddev composer update

# Non-DDEV environment
composer require vendor/package:@dev
composer dump-autoload
composer install
composer update
```

### Maintenance Mode

```bash
# DDEV environment
# Enable maintenance mode
ddev exec typo3 maintenance:enable

# Disable maintenance mode
ddev exec typo3 maintenance:disable

# Non-DDEV environment
./vendor/bin/typo3 maintenance:enable
./vendor/bin/typo3 maintenance:disable
```

## Debugging Commands

### PHP Debugging

```bash
# DDEV environment
# Check PHP configuration
ddev exec php -i | grep -i xdebug

# Error logs
ddev exec tail -f var/log/typo3_*.log

# Non-DDEV environment
php -i | grep -i xdebug
tail -f var/log/typo3_*.log
```

### MySQL Debugging (DDEV)

```bash
# Check running queries
ddev mysql -e "SHOW PROCESSLIST"

# Check table sizes
ddev mysql -e "SELECT table_name, round(((data_length + index_length) / 1024 / 1024), 2) AS 'Size (MB)' FROM information_schema.TABLES WHERE table_schema = 'db' ORDER BY (data_length + index_length) DESC"
```

## Scheduler Commands (TYPO3 v13)

### Run Scheduler

```bash
# DDEV environment
ddev exec typo3 scheduler:run

# Non-DDEV environment
./vendor/bin/typo3 scheduler:run
```

## Upgrade Commands (TYPO3 v13)

### Run Upgrade Wizards

```bash
# DDEV environment
ddev exec typo3 upgrade:list
ddev exec typo3 upgrade:run all

# Non-DDEV environment
./vendor/bin/typo3 upgrade:list
./vendor/bin/typo3 upgrade:run all
```

## Quick Reference Table

| Task | DDEV Command | Non-DDEV Command | When to Use |
|------|-------------|------------------|-------------|
| Quick cache clear | `ddev exec typo3 cache:flush` | `./vendor/bin/typo3 cache:flush` | After template changes |
| Cache warmup | `ddev exec typo3 cache:warmup` | `./vendor/bin/typo3 cache:warmup` | After major changes |
| Force cache clear | `ddev exec rm -rf var/cache/*` | `rm -rf var/cache/*` | When normal clear doesn't work |
| Update database | `ddev exec typo3 database:updateschema` | `./vendor/bin/typo3 database:updateschema` | After config.yaml changes |
| Extension setup | `ddev exec typo3 extension:setup` | `./vendor/bin/typo3 extension:setup` | After adding extensions |
| Site configuration | `ddev exec typo3 site:show` | `./vendor/bin/typo3 site:show` | Check site setup |
| Backend user | `ddev exec typo3 backend:user:create` | `./vendor/bin/typo3 backend:user:create` | Create admin users |
| View logs | `ddev logs -f` | `tail -f var/log/typo3_*.log` | Debug errors |
| Restart environment | `ddev restart` | Service restart required | System issues |

## Environment-Specific Notes

### DDEV Advantages

- Consistent PHP/MySQL versions
- Built-in mail catching
- Easy SSL certificates
- Xdebug integration
- Multiple project isolation

### Non-DDEV Considerations

- Ensure correct PHP version (8.1+ for TYPO3 v13)
- MySQL 8.0+ or MariaDB 10.4+ required
- Configure web server properly
- Set up CLI PHP path correctly
