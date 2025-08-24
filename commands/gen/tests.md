---
allowed-tools: Task, Read, Write, MultiEdit, Grep, Bash(npm:*), Bash(jest:*), Bash(vitest:*), Bash(pytest:*)
description: Generate comprehensive test suites for uncovered code, including unit tests, integration tests, and edge cases
argument-hint: [report.json|file|directory] [--coverage-target=80] [--framework=auto] [--types=unit,integration] [--mock-externals]
---

# Generate Tests Command

This command automatically generates comprehensive test suites for code lacking test coverage. It analyzes code structure, identifies test scenarios, and creates tests following best practices for your testing framework.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: Generate comprehensive test suites for uncovered code, including unit tests, integration tests, and edge cases
- **Usage**: [report.json|file|directory] [--coverage-target=80] [--framework=auto] [--types=unit,integration] [--mock-externals]
- **Options**:
  - `--coverage-target`: Target coverage percentage (default: 80)
  - `--framework`: Testing framework to use (auto-detected if not specified)
  - `--types`: Types of tests to generate (unit, integration)
  - `--mock-externals`: Mock external dependencies in tests

Then exit without executing the main command.

---

## Usage Examples

```bash
# Generate tests based on coverage report
/generate-tests report.json --coverage-target=90

# Generate tests for specific file
/generate-tests src/utils/validation.js

# Generate tests for directory
/generate-tests src/services/ --types=unit,integration

# Auto-detect framework and generate
/generate-tests src/ --framework=auto --mock-externals
```

## Test Generation Patterns

### 1. Unit Tests for Functions

```javascript
// Source: utils/math.js
export function calculateDiscount(price, percentage) {
  if (percentage < 0 || percentage > 100) {
    throw new Error("Invalid percentage");
  }
  return price * (1 - percentage / 100);
}

// Generated: utils/math.test.js
describe("calculateDiscount", () => {
  it("should calculate discount correctly", () => {
    expect(calculateDiscount(100, 20)).toBe(80);
    expect(calculateDiscount(50, 10)).toBe(45);
  });

  it("should handle zero discount", () => {
    expect(calculateDiscount(100, 0)).toBe(100);
  });

  it("should handle 100% discount", () => {
    expect(calculateDiscount(100, 100)).toBe(0);
  });

  it("should throw error for negative percentage", () => {
    expect(() => calculateDiscount(100, -10)).toThrow("Invalid percentage");
  });

  it("should throw error for percentage over 100", () => {
    expect(() => calculateDiscount(100, 150)).toThrow("Invalid percentage");
  });

  it("should handle decimal prices", () => {
    expect(calculateDiscount(99.99, 15)).toBeCloseTo(84.99, 2);
  });
});
```

### 2. Component Tests (React Example)

```javascript
// Source: components/UserCard.jsx
export function UserCard({ user, onEdit, onDelete }) {
  return (
    <div className="user-card">
      <h3>{user.name}</h3>
      <p>{user.email}</p>
      <button onClick={() => onEdit(user.id)}>Edit</button>
      <button onClick={() => onDelete(user.id)}>Delete</button>
    </div>
  );
}

// Generated: components/UserCard.test.jsx
describe("UserCard", () => {
  const mockUser = {
    id: 1,
    name: "John Doe",
    email: "john@example.com",
  };

  it("should render user information", () => {
    render(<UserCard user={mockUser} />);

    expect(screen.getByText("John Doe")).toBeInTheDocument();
    expect(screen.getByText("john@example.com")).toBeInTheDocument();
  });

  it("should call onEdit with user id", () => {
    const onEdit = jest.fn();
    render(<UserCard user={mockUser} onEdit={onEdit} />);

    fireEvent.click(screen.getByText("Edit"));
    expect(onEdit).toHaveBeenCalledWith(1);
  });

  it("should call onDelete with user id", () => {
    const onDelete = jest.fn();
    render(<UserCard user={mockUser} onDelete={onDelete} />);

    fireEvent.click(screen.getByText("Delete"));
    expect(onDelete).toHaveBeenCalledWith(1);
  });
});
```

### 3. API Integration Tests

```javascript
// Source: services/userService.js
export class UserService {
  async getUser(id) {
    const response = await fetch(`/api/users/${id}`);
    if (!response.ok) throw new Error("User not found");
    return response.json();
  }

  async updateUser(id, data) {
    const response = await fetch(`/api/users/${id}`, {
      method: "PUT",
      body: JSON.stringify(data),
      headers: { "Content-Type": "application/json" },
    });
    return response.json();
  }
}

// Generated: services/userService.test.js
describe("UserService", () => {
  let service;

  beforeEach(() => {
    service = new UserService();
    global.fetch = jest.fn();
  });

  afterEach(() => {
    jest.restoreAllMocks();
  });

  describe("getUser", () => {
    it("should fetch user successfully", async () => {
      const mockUser = { id: 1, name: "John" };
      fetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockUser,
      });

      const user = await service.getUser(1);

      expect(fetch).toHaveBeenCalledWith("/api/users/1");
      expect(user).toEqual(mockUser);
    });

    it("should throw error when user not found", async () => {
      fetch.mockResolvedValueOnce({
        ok: false,
        status: 404,
      });

      await expect(service.getUser(999)).rejects.toThrow("User not found");
    });

    it("should handle network errors", async () => {
      fetch.mockRejectedValueOnce(new Error("Network error"));

      await expect(service.getUser(1)).rejects.toThrow("Network error");
    });
  });

  describe("updateUser", () => {
    it("should update user successfully", async () => {
      const updateData = { name: "Jane" };
      const mockResponse = { id: 1, ...updateData };

      fetch.mockResolvedValueOnce({
        ok: true,
        json: async () => mockResponse,
      });

      const result = await service.updateUser(1, updateData);

      expect(fetch).toHaveBeenCalledWith("/api/users/1", {
        method: "PUT",
        body: JSON.stringify(updateData),
        headers: { "Content-Type": "application/json" },
      });
      expect(result).toEqual(mockResponse);
    });
  });
});
```

## Workflow

### Phase 1: Analysis

1. **Code Analysis**:

   - Parse source files
   - Identify testable units
   - Extract function signatures
   - Detect dependencies

2. **Coverage Analysis**:
   - Load existing coverage data
   - Identify uncovered code
   - Prioritize by complexity
   - Calculate coverage gaps

### Phase 2: Test Planning

1. **Test Scenarios**:

   - Happy path cases
   - Edge cases
   - Error conditions
   - Boundary values
   - Null/undefined handling

2. **Mock Strategy**:
   - External dependencies
   - Database calls
   - API requests
   - File system operations

### Phase 3: Test Generation

1. **Framework Detection**:

   ```javascript
   // Auto-detect from package.json
   if (dependencies.jest) framework = "jest";
   else if (dependencies.vitest) framework = "vitest";
   else if (dependencies.mocha) framework = "mocha";
   else if (dependencies.pytest) framework = "pytest";
   ```

2. **Test Structure**:

   - Setup and teardown
   - Describe blocks
   - Test cases
   - Assertions
   - Cleanup

3. **Mock Generation**:

   ```javascript
   // Auto-generate mocks for imports
   jest.mock("./database", () => ({
     query: jest.fn(),
     connect: jest.fn(),
     disconnect: jest.fn(),
   }));
   ```

### Phase 4: Test Optimization

1. **Remove Redundancy**:

   - Combine similar tests
   - Extract common setup
   - Create test utilities

2. **Improve Readability**:
   - Clear test names
   - Arrange-Act-Assert pattern
   - Meaningful assertions

### Phase 5: Verification

```bash
# Run generated tests
npm test -- --coverage

# Check coverage improvement
# Before: 45%
# After: 87%
```

## Test Types

### Unit Tests

- Pure functions
- Class methods
- Utility functions
- Validators
- Formatters

### Integration Tests

- API endpoints
- Database operations
- Service interactions
- External integrations

### Component Tests

- React/Vue/Angular components
- Event handlers
- Props validation
- State management

### E2E Test Stubs

```javascript
// Generated E2E test outline
describe("User Registration Flow", () => {
  it("should complete registration successfully", () => {
    // TODO: Implement E2E test
    // 1. Navigate to registration page
    // 2. Fill in user details
    // 3. Submit form
    // 4. Verify success message
    // 5. Check user can login
  });
});
```

## Coverage Report Integration

```markdown
## Test Generation Report

### Coverage Improvement

- **Before**: 45.2%
- **After**: 87.6%
- **Target**: 90%

### Tests Generated

- **Unit Tests**: 45 files, 312 tests
- **Integration Tests**: 12 files, 78 tests
- **Component Tests**: 23 files, 156 tests

### Uncovered Code Remaining

1. `src/legacy/parser.js` - Complex parsing logic
2. `src/experimental/feature.js` - Experimental code
3. `src/vendor/third-party.js` - Vendor code

### Suggested Manual Tests

- Complex business logic in OrderProcessor
- Error handling in PaymentGateway
- Edge cases in DateCalculator
```

## Framework-Specific Features

### Jest

- Snapshot testing for components
- Mock functions and modules
- Coverage thresholds
- Test.each for parameterized tests

### Vitest

- ESM support
- Concurrent test execution
- In-source testing
- UI mode integration

### Pytest

- Fixtures for setup
- Parametrized tests
- Marks for categorization
- Assert rewriting

## Configuration

Default settings:

- Coverage target: 80%
- Test types: unit, integration
- Mock externals: true
- Framework: auto-detect
- Test location: adjacent to source

## Best Practices

1. **Meaningful Tests**:

   - Test behavior, not implementation
   - Use descriptive names
   - One assertion per test (when possible)

2. **Maintainable Tests**:

   - Keep tests simple
   - Avoid over-mocking
   - Update tests with code

3. **Fast Tests**:
   - Mock external dependencies
   - Use test databases
   - Parallel execution

This command accelerates test coverage improvement by generating comprehensive, maintainable test suites that follow best practices.
