---
allowed-tools: Read, Write, Task
description: Intelligent refactoring suggestions with impact analysis and step-by-step guidance
argument-hint: <file-or-pattern> [--type=extract|rename|restructure] [--safety=conservative|balanced|aggressive]
---

# Intelligent Refactoring Workflow

This command provides intelligent refactoring suggestions with impact analysis, helping you improve code structure safely and systematically.

## Refactoring Process

### Phase 1: Code Analysis

Understand current structure and identify refactoring opportunities.

### Phase 2: Impact Assessment

Analyze dependencies and potential risks of proposed changes.

### Phase 3: Step-by-Step Plan

Generate detailed refactoring steps with safety checks.

## Execution

**Target**: $ARGUMENTS

### Check for Help Request

If "$ARGUMENTS" contains "--help":

- Display this command's full documentation
- Show usage examples
- Exit without executing analysis

### Step 1: Initial Analysis

Use Task tool with subagent_type="general-purpose":
"Analyze code structure in $ARGUMENTS. Identify: 1) Code smells (long methods, god classes, feature envy), 2) Duplication patterns, 3) Coupling issues, 4) Naming inconsistencies. Return findings with specific locations."

### Step 2: Refactoring Opportunities

Use Task tool with subagent_type="general-purpose":
"Based on code analysis, suggest refactoring opportunities for $ARGUMENTS. For each: 1) Type of refactoring (extract method/class, rename, move, inline), 2) Complexity (simple/medium/complex), 3) Expected benefits, 4) Risk level. Prioritize by ROI."

### Step 3: Dependency Analysis

Use Task tool with subagent_type="general-purpose":
"Analyze dependencies for $ARGUMENTS. Find: 1) All files importing this code, 2) Test files covering this code, 3) External API contracts, 4) Database schema dependencies. Map full impact radius."

### Step 4: Generate Refactoring Plan

Based on analysis, create step-by-step plan:

## Refactoring Plan

### 🎯 Recommended Refactorings

#### 1. Extract Method: [Method Name]

**Current**: Lines X-Y in [file]
**Reason**: Method too long (N lines), does multiple things
**New Structure**:

```
- extractCalculation() - Lines X1-X2
- validateInput() - Lines X3-X4
- formatOutput() - Lines X5-X6
```

**Impact**: Used in N places, all tests pass
**Effort**: 30 minutes

#### 2. Rename Variable: [Current → Better]

**Locations**: [List of files:lines]
**Reason**: Unclear naming, doesn't express intent
**Safe Rename**: No external API impact
**Effort**: 10 minutes

#### 3. Extract Class: [New Class Name]

**From**: [Current large class]
**Responsibilities to Extract**:

- [Responsibility 1]
- [Responsibility 2]
  **Benefits**: Better SRP, easier testing
  **Risk**: Medium - requires test updates
  **Effort**: 2 hours

### 📋 Execution Steps

1. **Create Safety Net**

   ```bash
   # Ensure all tests pass
   /prefix:test:run

   # Create refactoring branch
   git checkout -b refactor/[description]
   ```

2. **Apply Refactorings** (in order)

   - Step 1: [Specific action]
   - Step 2: [Specific action]
   - Verify: Run tests after each step

3. **Update Tests**

   - Modify test [X] for new structure
   - Add test for extracted [component]

4. **Verify Integration**

   ```bash
   # Run full test suite
   /prefix:test:run --all

   # Check dependent services
   /prefix:scan:deps [refactored-file]
   ```

### ⚠️ Risks & Mitigations

- **Risk**: Breaking API contract
  **Mitigation**: Keep public interface unchanged

- **Risk**: Performance regression  
  **Mitigation**: Benchmark before/after

- **Risk**: Missing edge cases
  **Mitigation**: Add tests for edge cases first

## Refactoring Types

- **Extract Method/Class**: Split large code units
- **Rename**: Improve naming clarity
- **Move**: Relocate to proper module
- **Inline**: Remove unnecessary abstraction
- **Restructure**: Reorganize for better patterns

## Safety Levels

- **Conservative**: Only safe, automated refactorings
- **Balanced**: Include medium-risk with good ROI
- **Aggressive**: All beneficial refactorings

## Usage Examples

```bash
# Analyze specific file
/prefix:flow:refactor src/UserService.js

# Extract methods from long class
/prefix:flow:refactor src/OrderProcessor.js --type=extract

# Safe refactoring only
/prefix:flow:refactor . --safety=conservative

# Rename across codebase
/prefix:flow:refactor "oldFunction" --type=rename
```

## Integration Commands

After refactoring:

```bash
# Verify no regressions
/prefix:test:run --coverage

# Check performance impact
/prefix:scan:perf --compare=before

# Update documentation
/prefix:gen:docs --update
```
