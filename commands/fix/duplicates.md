---
allowed-tools: Task, Read, Edit, MultiEdit, Write, Grep, Bash(npm:*), Bash(git:*)
description: Remove code duplication by extracting common functions, creating shared utilities, and applying DRY principles
argument-hint: [report.json|directory] [--threshold=80] [--min-lines=5] [--dry-run] [--create-utils] [--group-by] [--preserve-comments]
---

# Fix Duplicates Command

This command identifies and removes code duplication by extracting common patterns into reusable functions, creating shared utilities, and applying the DRY (Don't Repeat Yourself) principle.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Usage Examples

```bash
# Fix duplicates from analysis report
/fix-duplicates report.json

# Find and fix duplicates in directory
/fix-duplicates src/ --threshold=85

# Preview changes without applying
/fix-duplicates report.json --dry-run

# Create utility modules for extracted code
/fix-duplicates src/ --create-utils

# Only fix duplicates with 10+ lines
/fix-duplicates report.json --min-lines=10
```

## Duplication Types

### 1. Exact Duplicates

```javascript
// Before: Same code in multiple files
// file1.js
function calculateTax(amount) {
  const taxRate = 0.08;
  return amount * taxRate;
}

// file2.js
function calculateTax(amount) {
  const taxRate = 0.08;
  return amount * taxRate;
}

// After: Shared utility
// utils/tax.js
export function calculateTax(amount) {
  const taxRate = 0.08;
  return amount * taxRate;
}

// file1.js & file2.js
import { calculateTax } from './utils/tax';
```

### 2. Similar Logic Patterns

```javascript
// Before: Similar validation patterns
function validateEmail(email) {
  if (!email) return false;
  if (typeof email !== 'string') return false;
  if (!email.includes('@')) return false;
  return true;
}

function validatePhone(phone) {
  if (!phone) return false;
  if (typeof phone !== 'string') return false;
  if (phone.length < 10) return false;
  return true;
}

// After: Generic validator
function createValidator(rules) {
  return (value) => {
    for (const rule of rules) {
      if (!rule(value)) return false;
    }
    return true;
  };
}

const validateEmail = createValidator([
  (v) => !!v,
  (v) => typeof v === 'string',
  (v) => v.includes('@')
]);

const validatePhone = createValidator([
  (v) => !!v,
  (v) => typeof v === 'string',
  (v) => v.length >= 10
]);
```

### 3. Repeated Error Handling

```javascript
// Before: Duplicate error handling
async function fetchUser(id) {
  try {
    const response = await api.get(`/users/${id}`);
    return response.data;
  } catch (error) {
    console.error('Error fetching user:', error);
    throw new Error('Failed to fetch user');
  }
}

async function fetchProduct(id) {
  try {
    const response = await api.get(`/products/${id}`);
    return response.data;
  } catch (error) {
    console.error('Error fetching product:', error);
    throw new Error('Failed to fetch product');
  }
}

// After: Generic fetch wrapper
async function fetchResource(resource, id) {
  try {
    const response = await api.get(`/${resource}/${id}`);
    return response.data;
  } catch (error) {
    console.error(`Error fetching ${resource}:`, error);
    throw new Error(`Failed to fetch ${resource}`);
  }
}

const fetchUser = (id) => fetchResource('users', id);
const fetchProduct = (id) => fetchResource('products', id);
```

## Workflow

### Phase 1: Duplication Detection

1. **Analyze Code**:
   - Use AST parsing for accuracy
   - Identify exact matches
   - Find similar patterns
   - Calculate similarity scores

2. **Group Duplicates**:

   ```
   Duplication Groups Found: 8
   
   Group 1: Authentication Logic (4 instances)
   - src/api/auth.js:45-72
   - src/middleware/auth.js:12-39
   - src/services/user.js:88-115
   - src/controllers/admin.js:23-50
   
   Similarity: 92%
   Lines: 28
   Potential Savings: 84 lines
   ```

### Phase 2: Refactoring Strategy

1. **Classify Duplicates**:
   - Utility functions → shared utils
   - Business logic → service layer
   - UI components → component library
   - Config/constants → config files

2. **Plan Extraction**:
   - Determine optimal location
   - Design generic interface
   - Plan migration steps
   - Consider backwards compatibility

### Phase 3: Code Extraction

1. **Create Shared Modules**:

   ```javascript
   // utils/index.js
   export * from './validation';
   export * from './formatting';
   export * from './api-helpers';
   export * from './date-utils';
   ```

2. **Extract Common Code**:
   - Parameterize differences
   - Create flexible interfaces
   - Add documentation
   - Include tests

3. **Update References**:
   - Import from new location
   - Update function calls
   - Fix any type issues
   - Update tests

### Phase 4: Verification

1. **Test Coverage**:

   ```bash
   # Run tests for affected files
   npm test -- --findRelatedTests
   
   # Check coverage didn't drop
   npm run coverage
   ```

2. **Functionality Check**:
   - Ensure behavior unchanged
   - Verify performance
   - Check bundle size

### Phase 5: Report

```markdown
## Duplicate Removal Report

### Summary
- **Duplication Before**: 18.5%
- **Duplication After**: 7.2%
- **Lines Saved**: 486
- **Files Modified**: 23
- **Utilities Created**: 5

### Extracted Modules
1. **utils/validation.js** (156 lines saved)
   - Email validation
   - Phone validation
   - Generic validators
   
2. **utils/api-helpers.js** (98 lines saved)
   - Error handling
   - Response parsing
   - Retry logic

3. **utils/formatting.js** (87 lines saved)
   - Date formatting
   - Currency display
   - Number formatting

### Major Refactorings
1. ✅ Consolidated authentication logic
2. ✅ Unified error handling patterns
3. ✅ Extracted validation utilities
4. ✅ Created shared API wrapper
5. ✅ Centralized date operations

### Code Quality Impact
- Maintainability: +15%
- Test Coverage: +3%
- Bundle Size: -12KB
- Complexity: -8%
```

## Extraction Patterns

### Function Extraction

```javascript
// Pattern: Extract varying parts as parameters
function createFormatter(prefix, suffix, transform) {
  return (value) => {
    const transformed = transform ? transform(value) : value;
    return `${prefix}${transformed}${suffix}`;
  };
}

const formatCurrency = createFormatter('$', '', (n) => n.toFixed(2));
const formatPercent = createFormatter('', '%', (n) => Math.round(n));
```

### Configuration Extraction

```javascript
// Before: Hardcoded values
const API_URL = 'https://api.example.com';
const TIMEOUT = 5000;

// After: Centralized config
// config/api.js
export const apiConfig = {
  baseURL: process.env.API_URL || 'https://api.example.com',
  timeout: process.env.API_TIMEOUT || 5000,
  retries: 3,
};
```

### Component Extraction

```javascript
// Before: Duplicate UI patterns
// After: Reusable component
const FormField = ({ label, error, children, required }) => (
  <div className="form-field">
    <label>
      {label} {required && <span>*</span>}
    </label>
    {children}
    {error && <span className="error">{error}</span>}
  </div>
);
```

## Configuration Options

- **threshold**: Similarity percentage (default: 80%)
- **min-lines**: Minimum duplicate size (default: 5)
- **create-utils**: Auto-create utility modules
- **group-by**: Organization strategy (type/feature/layer)
- **preserve-comments**: Keep original comments

## Best Practices

1. **Gradual Refactoring**:
   - Fix one group at a time
   - Test after each change
   - Commit frequently

2. **Maintain Readability**:
   - Don't over-abstract
   - Keep functions focused
   - Document parameters

3. **Consider Context**:
   - Some duplication is okay
   - Performance matters
   - Team conventions

This command helps maintain a DRY codebase by intelligently removing duplication while preserving functionality and readability.
