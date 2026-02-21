# TYPO3 Content Blocks Troubleshooting Matrix

## Quick Diagnosis Table

| Symptom | Likely Cause | Solution | Reference |
|---------|--------------|----------|-----------|
| Content not showing in frontend | Cache not cleared | `ddev exec typo3 cache:flush` | [TYPO3 Commands Reference](./references/typo3-ddev-commands-reference.md#cache-management) |
| Table doesn't exist error | Generic collection name | Use descriptive names like `accordion_items` | [Field Naming Reference](./references/field-naming-reference.md#collection-fields-special-rules) |
| JavaScript syntax errors | Fluid/JS mixing | Use data attributes pattern | [Alpine.js Integration](../frameworks/alpine-js-integration.md#fluidalpine-integration-patterns) |
| Field data not accessible | Wrong field naming | Check prefix pattern: `{vendor}_{block}_{field}` | [Field Naming Reference](./references/field-naming-reference.md) |
| Collection items empty | Wrong access pattern | Use `item.fieldname` not prefixed version | [Field Naming Reference](./references/field-naming-reference.md#field-access-in-collections) |
| Backend preview broken | Missing template | Create `backend-preview.html` | [Backend Preview Reference](./references/backend-preview-reference.md) |
| Assets not loading | Wrong inclusion method | Use `f:asset.script` for JS/CSS CDN | [Alpine.js Integration](../frameworks/alpine-js-integration.md#setup) |
| Changes not reflecting | Aggressive caching | `rm -rf var/cache/*` + flush | [TYPO3 Commands Reference](./references/typo3-ddev-commands-reference.md#cache-management) |

## Detailed Troubleshooting

### Problem: Database Table Creation Issues

#### Symptom

```
Table 'db.punktde_items' doesn't exist
```

#### Diagnosis Steps

1. Check collection field identifier in `config.yaml`
2. Verify table name is descriptive
3. Check database for created tables

#### Solution

```yaml
# ❌ BAD - Too generic
- identifier: items
  type: Collection

# ✅ GOOD - Descriptive
- identifier: accordion_items
  type: Collection
```

#### Verification

See [TYPO3 Commands Reference](./references/typo3-ddev-commands-reference.md#database-commands) for table verification.

---

### Problem: JavaScript/Alpine.js Errors

#### Symptom

```
Alpine Expression Error: Unexpected token 'if'
Uncaught SyntaxError: Unexpected token '<'
```

#### Diagnosis Steps

1. Check for Fluid ViewHelpers in JavaScript
2. Verify data attribute pattern usage
3. Check Alpine.js loading order

#### Solution

```html
<!-- ❌ WRONG -->
<div x-data="{ active: <f:if condition='{data.field}' then='true' else='false' /> }">

<!-- ✅ CORRECT -->
<div x-data="accordionComponent()" 
     data-active="{f:if(condition: data.field, then: '1', else: '0')}">
<script>
function accordionComponent() {
    return {
        init() {
            this.active = this.$el.dataset.active === '1';
        }
    }
}
</script>
```

---

### Problem: Field Data Not Accessible

#### Symptom

- Empty values in template
- `{data.field}` shows nothing
- Debug shows different field names

#### Diagnosis Steps

See [Field Naming Reference](./references/field-naming-reference.md#debug-field-names) for debugging field names.

#### Common Patterns

See [Field Naming Reference](./references/field-naming-reference.md#complete-access-pattern-reference) for field access patterns.

---

### Problem: Cache Not Clearing

#### Symptom

- Changes not visible after clearing cache
- Old content still showing
- Database changes not reflected

#### Progressive Solutions

See [TYPO3 Commands Reference](./references/typo3-ddev-commands-reference.md#cache-management) for all cache clearing levels.

---

### Problem: Backend Preview Issues

#### Symptom

- Raw data shown in backend
- No formatted preview
- Missing icons or styling

#### Solution Structure

See [Backend Preview Reference](./references/backend-preview-reference.md) for complete template examples.

---

## Debug Checklist

### Initial Setup

- [ ] DDEV running: `ddev describe`
- [ ] Database accessible: `ddev mysql -e "SHOW TABLES"`
- [ ] TYPO3 accessible: Check `/typo3` backend
- [ ] Logs checked: `ddev logs -f`

### Content Block Creation

- [ ] Directory structure correct
- [ ] config.yaml valid YAML
- [ ] Templates in correct locations
- [ ] Language files present
- [ ] Icon file exists

### After Changes

- [ ] Cache cleared: `ddev exec typo3 cache:flush`
- [ ] Database updated: `ddev exec typo3 database:updateschema`
- [ ] Browser cache cleared
- [ ] Console errors checked

### Data Flow

- [ ] Database table created
- [ ] Data saved to database
- [ ] Data loaded in template
- [ ] Correct field names used
- [ ] Collections properly iterated

## Framework-Specific Issues

### Alpine.js

See [Alpine.js Integration Guide](../frameworks/alpine-js-integration.md#common-pitfalls--solutions)

### React (Coming Soon)

- Component not rendering
- State management issues
- Props not passing correctly

### Vue (Coming Soon)

- Reactivity issues
- Component registration
- Template compilation errors

## Performance Issues

### Slow Backend

- Too many collection items
- Missing indexes
- Large RTE content
- Solution: Pagination, lazy loading

### Slow Frontend

- Too many DOM manipulations
- Large JavaScript bundles
- Missing asset optimization
- Solution: Code splitting, defer loading

## Migration Issues

### From Mask/DCE

- Field naming differences
- Template structure changes
- TCA configuration conflicts
- Solution: Step-by-step migration guide

### Version Upgrades

- Breaking changes in Content Blocks
- TYPO3 core changes
- Extension conflicts
- Solution: Check changelogs, test thoroughly

## Getting Help

### Information to Provide

1. TYPO3 version
2. Content Blocks version
3. Error messages (exact)
4. config.yaml content
5. Template snippets
6. Debug output

### Debug Commands

See [TYPO3 Commands Reference](./references/typo3-ddev-commands-reference.md) for all debugging commands.
