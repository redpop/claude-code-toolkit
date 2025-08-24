---
allowed-tools: Task, Read, Grep, Bash, Edit, MultiEdit, Write
description: Automated performance issue fixes including O(n²) algorithms, memory optimization, and database batching
argument-hint: [--target=algorithm|memory|database|all] [--file=path] [--dry-run]
---

# Performance Issue Fix Command

This command automatically identifies and fixes common performance bottlenecks in codebases, with specific focus on algorithmic complexity, memory usage, and database operations.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Usage

```bash
/prefix:fix:performance --target=algorithm --file=src/utils/calculations.ts
/prefix:fix:performance --target=database --dry-run
/prefix:fix:performance --target=all
```

## Supported Fixes

### 1. O(n²) Algorithm Optimization

**Target**: `--target=algorithm`

- Identifies nested loops with O(n²) complexity
- Replaces with Map/Set-based lookups for O(n+m)
- Optimizes array operations and searching

### 2. Memory Optimization

**Target**: `--target=memory`

- Fixes memory leaks in React components
- Optimizes large object allocations
- Implements proper cleanup in useEffect

### 3. Database Batching

**Target**: `--target=database`

- Converts sequential DB operations to batch operations
- Implements transaction wrapping
- Optimizes query patterns

## Implementation

### Step 1: Analysis Phase

Scan the target files/directory for performance anti-patterns:

```javascript
// Common patterns to detect:
// 1. Nested loops: for(...) { for(...) { ... } }
// 2. Sequential async operations: await in loops
// 3. Large object spreads: {...largeObject, newProp}
// 4. Non-batched DB operations
```

### Step 2: Automated Fixes

**Algorithm Optimization Example:**

```javascript
// BEFORE (O(n²)):
function integrateSpecialPayments(schedule, payments) {
  return schedule.map(installment => {
    const matchingPayments = payments.filter(p => 
      p.installmentNumber === installment.number
    );
    // ... process matching payments
  });
}

// AFTER (O(n+m)):
function integrateSpecialPayments(schedule, payments) {
  // Create lookup map once
  const paymentsMap = new Map();
  payments.forEach(p => {
    const key = p.installmentNumber;
    if (!paymentsMap.has(key)) paymentsMap.set(key, []);
    paymentsMap.get(key).push(p);
  });
  
  return schedule.map(installment => {
    const matchingPayments = paymentsMap.get(installment.number) || [];
    // ... process matching payments
  });
}
```

**Database Batching Example:**

```javascript
// BEFORE (Sequential):
async function importPlans(plans) {
  for (const plan of plans) {
    await db.plans.add(plan);
  }
}

// AFTER (Batched):
async function importPlans(plans) {
  await db.transaction('rw', db.plans, async () => {
    await db.plans.bulkAdd(plans);
  });
}
```

### Step 3: Validation

After each fix:

1. Run tests to ensure functionality remains intact
2. Measure performance improvement
3. Update performance metrics

## Execution Logic

1. **Detect Target Files**:
   - If `--file` specified: analyze single file
   - If directory: scan recursively for performance issues
   - Prioritize by complexity score

2. **Apply Fixes**:
   - Create backup of original files
   - Apply transformations using AST parsing
   - Preserve code formatting and comments

3. **Validate Changes**:
   - Run existing tests
   - Perform basic syntax validation
   - Report performance improvements

## Safety Features

- **Dry Run Mode**: `--dry-run` shows what would be changed without applying fixes
- **Automatic Backups**: Creates `.backup` files before modifications
- **Incremental Changes**: Applies one fix at a time for easier debugging
- **Rollback Command**: Provides rollback instructions if issues occur

## Integration with Action Plans

When called from an ACTION-PLAN.md, this command:

1. Reads the specific issue details from the plan
2. Applies the appropriate fix based on issue type
3. Updates the ACTION-PLAN.md checkbox to [x] when complete
4. Reports performance improvement metrics

## Example Action Plan Integration

```markdown
### [ ] **Fix O(n²) Algorithm** (2h) - ROI: 42.5
- **Command**: `/prefix:fix:performance --target=algorithm --file=src/utils/loanCalculations.ts`
- **Auto-Update**: This checkbox will be marked [x] when command completes
```

This command transforms manual performance optimization into a one-click operation, making the analysis → fix workflow seamless.
