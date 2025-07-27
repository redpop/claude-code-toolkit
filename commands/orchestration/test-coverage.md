---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(coverage:*), Bash(jest:*), Bash(pytest:*)
description: Comprehensive test coverage analysis with 5 specialized agents for test quality
argument-hint: [directory] [--framework=jest|pytest|go-test|cargo-test]
---

# Test Coverage Analysis Command

This command analyzes test coverage and test quality with 5 parallel working agents. Identifies gaps in test coverage and suggests improvements.

## Execution

**IMMEDIATELY START 5 PARALLEL TEST AGENTS:**

1. **Coverage Metrics Agent**: Task(description="Calculate Coverage Metrics", prompt="Calculate test coverage metrics for $ARGUMENTS. Analyze: 1) Line Coverage Percentage, 2) Branch Coverage, 3) Function Coverage, 4) Statement Coverage. Identify files with coverage < 80%. If coverage reports exist, parse them. Otherwise analyze test-to-code ratio. Return coverage matrix as JSON with uncovered code areas.", subagent_type="general-purpose")

2. **Test Quality Agent**: Task(description="Assess Test Quality", prompt="Evaluate test quality in $ARGUMENTS. Check: 1) Test Naming Conventions, 2) Assertion Quality (not just 'truthy' checks), 3) Test Isolation (no dependencies), 4) Setup/Teardown Patterns, 5) Test Documentation. Search for anti-patterns like test.skip, commented tests, or hardcoded values. Return quality score per test file as JSON.", subagent_type="general-purpose")

3. **Missing Tests Agent**: Task(description="Find Missing Test Cases", prompt="Identify missing test cases in $ARGUMENTS. Analyze: 1) Untested Public Functions/Methods, 2) Missing Edge Case Tests (null, empty, boundaries), 3) Error Handling Tests, 4) Integration Points without tests, 5) Complex Logic without tests (Cyclomatic Complexity > 5). Generate list of suggested test cases as JSON.", subagent_type="general-purpose")

4. **Test Performance Agent**: Task(description="Analyze Test Performance", prompt="Analyze test performance in $ARGUMENTS. Identify: 1) Slow Tests (>1s for unit tests), 2) Test suites with long runtime, 3) Unnecessary sleeps/waits, 4) Inefficient test data setup, 5) Missing parallel execution. If test logs available, parse execution times. Return performance bottlenecks as JSON.", subagent_type="general-purpose")

5. **Flaky Test Agent**: Task(description="Detect Flaky Tests", prompt="Find flaky/unstable tests in $ARGUMENTS. Search for: 1) Time-dependent tests (Date.now, timestamps), 2) Order-dependent tests, 3) Random data without seed, 4) External API calls without mocks, 5) Race conditions, 6) Platform-specific tests. Analyze test code for instability patterns. Return flaky test candidates with fix suggestions as JSON.", subagent_type="general-purpose")

## Synthesis

After completion of all test agents:

1. **Create Coverage Dashboard**:
   ```markdown
   # Test Coverage Report
   
   ## Overall Metrics
   - Line Coverage: X%
   - Branch Coverage: X%
   - Function Coverage: X%
   - Test Execution Time: Xs
   
   ## Coverage by Module
   | Module | Coverage | Tests | Quality |
   |--------|----------|-------|---------|
   | Core   | 95%      | 120   | A       |
   | API    | 78%      | 45    | B       |
   | Utils  | 45%      | 12    | D       |
   ```

2. **Identify Critical Gaps**:
   ```markdown
   ## Critical Coverage Gaps
   
   ### Completely Untested Files
   - src/payment/processor.js (0% - CRITICAL)
   - src/auth/validator.js (0% - HIGH)
   
   ### Low Coverage Areas (<50%)
   - src/api/endpoints.js (35% - Complex Logic)
   - src/database/queries.js (42% - Error Paths)
   ```

3. **Generate Test Improvement Plan**:
   ```markdown
   ## Test Improvement Roadmap
   
   ### Immediate Actions (Week 1)
   1. Add tests for payment processor (Est: 20 tests)
   2. Cover error handling in API layer (Est: 15 tests)
   3. Fix 5 identified flaky tests
   
   ### Short-term (Week 2-3)
   1. Increase utils coverage to 80%
   2. Add integration tests for critical paths
   3. Implement test performance optimizations
   
   ### Long-term (Month 2)
   1. Achieve 90% overall coverage
   2. Establish coverage gates in CI/CD
   3. Implement mutation testing
   ```

4. **Create Missing Test Templates**:
   ```javascript
   // Generated test template for uncovered function
   describe('PaymentProcessor', () => {
     describe('processPayment', () => {
       it('should handle successful payment', () => {
         // TODO: Implement
       });
       
       it('should handle insufficient funds', () => {
         // TODO: Implement
       });
       
       it('should handle network errors', () => {
         // TODO: Implement
       });
     });
   });
   ```

5. **Performance Optimization Suggestions**:
   - Parallelize test suites (save ~40% time)
   - Replace sleeps with proper waits
   - Mock heavy external dependencies
   - Use test data factories

**Performance Expectation**: Test analysis in 4-6 seconds, compared to 30-40 seconds sequentially.

**Integration**: Can be integrated into CI/CD pipelines for automatic coverage monitoring.