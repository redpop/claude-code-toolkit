---
description: Switch to intensive debugging mode for current problem
argument-hint: "[--verbose] [--trace]"
---

# Debug Mode Switch

Instantly switch Claude Code into intensive debugging mode for the current problem being worked on. No need to describe the issue - Claude Code will use the current context to understand what needs to be debugged.

## Usage

```bash
/prefix:flow:debug-mode
/prefix:flow:debug-mode --verbose  # Extra detailed analysis
/prefix:flow:debug-mode --trace    # Include full stack traces
```

## Workflow

### Phase 1: Context Analysis

Analyze the current conversation to understand:

- What was being attempted
- Last error encountered
- Current implementation state
- Failed approaches so far

### Phase 2: Intensive Debug Mode

Activate the debugging-specialist agent with enhanced capabilities:

Use Task tool with subagent_type="debugging-specialist":
"INTENSIVE DEBUG MODE ACTIVATED - ULTRA INTENSIVE THINKING/REASONING REQUIRED

Context from current conversation:

- Current task being attempted
- Last known error or failure
- Implementation attempts so far
- Current file modifications

Instructions:

1. **THINK ULTRA INTENSIVELY** - Use maximum reasoning depth for this problem
2. Perform ULTRA DEEP analysis of the current problem with ULTRA INTENSIVE REASONING
3. Use systematic debugging approach:
   - Trace execution flow with extreme attention to detail
   - Analyze ALL error messages in detail - think ultra deeply about each one
   - Check assumptions and edge cases - reason through every possibility
   - Verify dependencies and environment
   - Look for subtle issues (timing, race conditions, type mismatches)
4. Try multiple debugging strategies:
   - Add verbose logging
   - Isolate the problem
   - Binary search for issue location
   - Test minimal reproducible cases
5. Provide:
   - Root cause analysis (with ultra deep reasoning)
   - Step-by-step fix with verification at each step
   - Alternative approaches if main fix doesn't work
   - Preventive measures for future

CRITICAL: Use ULTRA INTENSIVE THINKING AND REASONING throughout. Be extremely thorough. Think ultra deeply about every aspect. Check everything twice. Don't assume anything works - verify each step with careful reasoning."

### Phase 3: Implementation & Verification

After identifying the issue:

1. Implement fix with careful step-by-step verification
2. Add defensive coding measures
3. Test edge cases
4. Confirm resolution

## Key Features

- **Context-Aware**: Automatically understands current problem from conversation
- **No Description Needed**: Just switch modes, no need to re-explain
- **Intensive Analysis**: Much deeper than normal debugging
- **Multi-Strategy**: Tries different debugging approaches
- **Verification Focus**: Tests each assumption and fix

## Examples

```bash
# When normal debugging isn't working
/prefix:flow:debug-mode

# For extra detailed output
/prefix:flow:debug-mode --verbose

# Include full stack traces and system info
/prefix:flow:debug-mode --trace
```

## Best Practices

- Use when standard approaches have failed
- Activates more resource-intensive debugging
- Automatically increases logging and verification
- Switches Claude Code to be more careful and thorough
