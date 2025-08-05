# Documentation Update Plan

## Overview

Most documentation still uses old command names and needs updating for v3.0 structure.

## Documents Requiring Updates

### 1. guides/AUTOMATED-WORKFLOW.md

**Status**: ❌ Outdated
**Issues**:

- Uses old commands: `/analyze-deep`, `/analyze-report`, `/execute-action-plan`
- Should use: `/scan:deep`, `/scan:report`, `/auto:execute`
- Missing new workflow options with `/flow:smart` and `/meta:pipelines`

**Action**: Update all commands and add new workflow options

### 2. guides/COMPREHENSIVE-WORKFLOW.md

**Status**: ❌ Outdated
**Issues**:

- Uses old commands throughout
- Doesn't mention new command chaining with `/meta:chain`
- Missing new flow commands

**Action**: Major rewrite needed

### 3. guides/REPORT-ANALYZER-EXAMPLES.md

**Status**: ⚠️ Partially outdated
**Issues**:

- Uses `/analyze-report` instead of `/scan:report`
- Examples need updating

**Action**: Update command names

### 4. guides/REPORT-EXPORT-SYSTEM.md

**Status**: ⚠️ Check needed
**Issues**:

- May reference old export methods
- Should mention new `/meta:export` command

**Action**: Review and update

### 5. tutorials/quick-start-tutorial.md

**Status**: ❌ Outdated
**Issues**:

- Needs complete rewrite with new commands
- Should showcase `/flow:smart` as primary entry point

**Action**: Complete rewrite

### 6. tutorials/building-custom-commands.md

**Status**: ⚠️ Check needed
**Issues**:

- Should reflect new category structure
- Update examples to use new patterns

**Action**: Update examples and structure

### 7. architecture/SYSTEM-ARCHITECTURE-\*.md

**Status**: ⚠️ May need updates
**Issues**:

- Check if architecture descriptions match new structure
- Update command examples

**Action**: Review and update examples

## Documents to Archive

### Candidates for archive/:

1. **AGENT-INSTALLATION.md** - Already in archive, good
2. **CLONE-INSTALL-ARCHITECTURE-EN.md** - Already in archive, good
3. Consider archiving older workflow guides once updated

## New Documents Needed

1. **guides/SMART-WORKFLOWS.md** - Showcase new `/flow:smart` command
2. **guides/COMMAND-CHAINING.md** - Explain `/meta:chain` patterns
3. **guides/QUICK-WINS.md** - Focus on rapid improvements

## Priority Order

1. **HIGH**: Update AUTOMATED-WORKFLOW.md (most visible)
2. **HIGH**: Update quick-start-tutorial.md
3. **MEDIUM**: Update COMPREHENSIVE-WORKFLOW.md
4. **MEDIUM**: Create new workflow guides
5. **LOW**: Update remaining guides

## Compact Rewrite Opportunities

- Combine AUTOMATED-WORKFLOW.md and COMPREHENSIVE-WORKFLOW.md into one
- Make examples more concise
- Remove redundant explanations
- Focus on new powerful features
