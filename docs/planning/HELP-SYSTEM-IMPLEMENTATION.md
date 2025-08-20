# Help System Implementation Plan

## 🤖 AI/Agent Execution Instructions

**IMPORTANT**: When AI assistants or agents work on this plan, they MUST:

1. Update checkboxes `[ ]` to `[x]` when tasks are completed
2. Add completion timestamp and agent/AI name after each completed task
3. Update status indicators in tables from ⏳ to ✅
4. Add notes about any issues or deviations from the plan
5. Keep running totals of completed vs. pending tasks

**Example of proper task completion marking:**

```markdown
- [x] Create batch update script ✅ 2024-01-20 14:30 (Claude)
- [ ] Test batch script on 5 commands ⏳ Pending
```

## 📊 Project Overview

### Current Status

- **Total Commands**: 57
- **Commands with Help Support**: 5 (9%)
- **Commands without Help Support**: 52 (91%)
- **Core Infrastructure**: ✅ Complete
  - Help Generator Script: ✅ Created
  - Help Template: ✅ Created
  - Meta Help Command: ✅ Created
  - Documentation: ✅ Created
  - README Integration: ✅ Updated

### Goal

Implement comprehensive help support for all 56 commands in the Claude Code Toolkit, enabling users to access detailed help information via `--help` flag for every command.

## 🎯 Implementation Phases

### Phase 1: Automation Infrastructure (Day 1)

**Objective**: Create tools to automate help integration across all commands

#### 1.1 Batch Update Script

**File**: `scripts/add-help-to-commands.sh`

**Requirements**:

- Parse existing `argument-hint` from each command
- Convert argument hints to structured `options` field
- Add `examples` field with 2-3 practical examples
- Add `see-also` field with related commands
- Insert help detection logic at beginning of command content
- Preserve all existing content
- Handle edge cases (missing frontmatter, malformed YAML)

**Script Logic**:

```bash
#!/bin/bash
# For each command file:
# 1. Extract current frontmatter
# 2. Parse argument-hint into options
# 3. Generate examples based on command type
# 4. Add see-also based on category
# 5. Insert help detection block
# 6. Save updated file with backup
```

#### 1.2 Help Validation Script

**File**: `scripts/validate-help.sh`

**Features**:

- Check all commands for help support presence
- Validate frontmatter structure
- Test help generation for each command
- Report missing or malformed help data
- Generate compliance report

### Phase 2: Command Updates (Day 1-2)

**Objective**: Apply help support to all 51 remaining commands

#### 2.1 Command Categories & Priority

**Completion Tracking by Category:**

- scan/: [ ] 0/12 completed
- fix/: [ ] 2/7 completed (quick-wins ✅, security partial)
- flow/: [ ] 0/5 completed
- auto/: [ ] 0/4 completed
- gen/: [ ] 0/3 completed
- git/: [ ] 1/3 completed (conflict-resolver ✅)
- meta/: [ ] 2/14 completed (chain ✅, help ✅)
- sec/: [ ] 1/3 completed (audit ✅)
- typo3/: [ ] 0/5 completed
- css/: [ ] 0/1 completed

**High Priority** (Core Workflows):

1. **scan/** (12 commands) - Analysis foundation
   - [ ] deps
   - [ ] docs
   - [ ] explore
   - [ ] map
   - [ ] perf
   - [ ] quality
   - [ ] quick
   - [ ] refactor
   - [ ] report
   - [ ] root-cause
   - [ ] tests
   - [x] deep ✅ (already completed)

2. **fix/** (7 commands) - Direct fixes
   - [ ] documentation
   - [ ] duplicates
   - [ ] markdown
   - [ ] performance
   - [x] quick-wins ✅ (already completed)
   - [ ] security
   - [ ] shell

3. **flow/** (5 commands) - Multi-agent workflows  
   - [ ] debug-mode
   - [ ] incident
   - [ ] refactor
   - [ ] review
   - [ ] smart

**Medium Priority** (Supporting Tools):
4. **auto/** (4 commands) - Automation

- [ ] execute
- [ ] monitor
- [ ] report
- [ ] sprint

5. **gen/** (3 commands) - Generation
   - [ ] docs
   - [ ] format
   - [ ] tests

6. **git/** (3 commands) - Version control
   - [ ] commit
   - [x] conflict-resolver ✅ (already completed)
   - [ ] review

**Lower Priority** (Meta & Specialized):
7. **meta/** (14 commands) - Toolkit management

- [ ] analyze-toolkit
- [ ] changelog
- [ ] create
- [ ] docs-sync
- [ ] export
- [ ] find-cmd
- [ ] handoff
- [ ] health
- [x] help ✅ (already completed)
- [x] chain ✅ (already completed)
- [ ] summary
- [ ] test-guide
- [ ] update-docs
- [ ] version

8. **sec/** (3 commands) - Security
   - [x] audit ✅ (already completed)
   - [ ] baseline
   - [ ] comply

9. **typo3/** (5 commands) - TYPO3 specific
   - [ ] content-blocks
   - [ ] extension-kickstarter
   - [ ] fluid-components
   - [ ] make-content-block
   - [ ] sitepackage

10. **css/** (1 command) - CSS & styling

- [ ] tailwind-optimize

#### 2.2 Help Content Structure per Command

Each command needs:

```yaml
---
description: [existing]
argument-hint: [existing, enhanced]
options:
  - name: --help
    description: Show this help message
  - name: --[option1]
    description: [Description]
    values: [if applicable]
  - name: --[option2]
    description: [Description]
examples:
  - command: /prefix:category:command [basic usage]
    description: [What this does]
  - command: /prefix:category:command --option [advanced]
    description: [What this does]
see-also:
  - /prefix:related:command1
  - /prefix:related:command2
---
```

#### 2.3 Help Detection Block Template

```markdown
## Help Check
If "$ARGUMENTS" contains "--help" or "-h":
Display comprehensive help using the generate-help.sh script:
```bash
# Generate and display help
SCRIPT_DIR="$HOME/.claude/claude-code-toolkit/scripts"
if [ -f "$SCRIPT_DIR/generate-help.sh" ]; then
    "$SCRIPT_DIR/generate-help.sh" "category/command.md"
else
    # Fallback to basic help
    cat << 'EOF'
Command: /prefix:category:command
Description: [description]
Usage: [argument-hint]
For detailed help, ensure the toolkit is properly installed.
EOF
fi
```

Exit without executing the command.

```

### Phase 3: Testing & Validation (Day 2)
**Objective**: Ensure all commands work correctly with help

#### 3.1 Automated Testing
- Run `generate-help.sh` for all 56 commands
- Verify output format consistency
- Check for missing fields
- Validate examples syntax
- Test help detection logic

#### 3.2 Manual Testing
- Test 5 commands from each category
- Verify help content accuracy
- Check related command links
- Validate option descriptions

#### 3.3 Error Handling
- Commands without proper frontmatter
- Malformed YAML
- Missing required fields
- Circular see-also references

### Phase 4: Installation Integration (Day 2)
**Objective**: Update installation process to support help system

#### 4.1 Update install.sh
```bash
# New installation steps:
1. Copy generate-help.sh to toolkit directory
2. Set executable permissions
3. Copy help template
4. Verify help system components
5. Create help index cache
```

#### 4.2 Installation Locations

```
~/.claude/
├── claude-code-toolkit/
│   ├── scripts/
│   │   ├── generate-help.sh (executable)
│   │   └── validate-help.sh (executable)
│   ├── templates/
│   │   └── help-output.md
│   └── cache/
│       └── help-index.json (generated)
├── commands/
│   └── [prefix]/
│       └── [all command files with help]
```

### Phase 5: Documentation & Rollout (Day 3)

**Objective**: Complete documentation and user communication

#### 5.1 Documentation Updates

- Update main README with help system overview
- Add help usage to Quick Start guide
- Update command reference with help indicators
- Create troubleshooting guide for help issues

#### 5.2 User Communication

- Changelog entry for help system
- Migration guide for existing users
- Best practices for using help
- Video/GIF demonstration

#### 5.3 Integration with Command Creation Tools

**IMPORTANT**: Ensure help system is integrated into new command creation workflow

- [ ] Create `templates/command-template.md` with help system structure
- [ ] Update `scripts/create-command.sh` (if exists) or create it
- [ ] Update `meta:create` command to include help system
- [ ] Ensure all new commands automatically include:
  - `options` field with `--help` option
  - `examples` field with 2-3 examples
  - `see-also` field with related commands
  - Help detection block at start of command content

**Template Structure for New Commands**:

```yaml
---
description: [Command description]
argument-hint: "[required] [--optional]"
options:
  - name: --help
    description: Show detailed help information
    type: boolean
  # Additional options based on argument-hint
examples:
  - description: Basic usage
    command: /prefix:category:command target
  - description: With options
    command: /prefix:category:command target --option
see-also:
  - category:related-command
---

# Command Name

$HELP_DETECTION_BLOCK

## Workflow

[Command implementation]
```

## 📋 Detailed Task Breakdown

### Task List with Time Estimates

**Progress Tracking**: 0/18 tasks completed (0%)

| Task | Priority | Effort | Dependencies | Status | Completed By |
|------|----------|--------|--------------|--------|--------------|
| Create batch update script | P0 | 2h | None | ⏳ Pending | - |
| Test batch script on 5 commands | P0 | 1h | Batch script | ⏳ Pending | - |
| Run batch update on scan/ commands | P0 | 1h | Tested script | ⏳ Pending | - |
| Run batch update on fix/ commands | P0 | 30m | Tested script | ⏳ Pending | - |
| Run batch update on flow/ commands | P0 | 30m | Tested script | ⏳ Pending | - |
| Run batch update on auto/ commands | P1 | 30m | Tested script | ⏳ Pending | - |
| Run batch update on gen/ commands | P1 | 30m | Tested script | ⏳ Pending | - |
| Run batch update on git/ commands | P1 | 30m | Tested script | ⏳ Pending | - |
| Run batch update on meta/ commands | P2 | 1h | Tested script | ⏳ Pending | - |
| Run batch update on sec/ commands | P2 | 30m | Tested script | ⏳ Pending | - |
| Run batch update on typo3/ commands | P2 | 30m | Tested script | ⏳ Pending | - |
| Create validation script | P0 | 1h | None | ⏳ Pending | - |
| Run validation on all commands | P0 | 1h | All updates | ⏳ Pending | - |
| Update install.sh | P1 | 1h | Validation | ⏳ Pending | - |
| Test installation process | P1 | 30m | Updated install | ⏳ Pending | - |
| Update documentation | P1 | 1h | All complete | ⏳ Pending | - |
| Create changelog entry | P2 | 30m | All complete | ⏳ Pending | - |
| Final testing | P0 | 2h | Everything | ⏳ Pending | - |

**Total Estimated Time**: ~15 hours

## 🔧 Technical Implementation Details

### Batch Update Script Algorithm

```python
# Pseudo-code for batch update logic
for command_file in all_command_files:
    1. Read file content
    2. Extract frontmatter using regex
    3. Parse YAML frontmatter
    
    4. If 'options' field exists:
        - Skip (already has help)
    
    5. Parse argument-hint:
        - Extract positional arguments
        - Extract optional flags
        - Identify flag values/types
    
    6. Generate options structure:
        - Always add --help option
        - Convert each flag to option entry
        - Add descriptions based on patterns
    
    7. Generate examples:
        - Basic usage (no flags)
        - Common flag usage
        - Advanced usage (multiple flags)
    
    8. Determine see-also:
        - Same category commands
        - Workflow-related commands
        - Commonly used together
    
    9. Insert help detection block:
        - After frontmatter
        - Before main content
        - Use command-specific path
    
    10. Write updated file:
        - Create backup first
        - Validate YAML syntax
        - Preserve formatting
```

### Option Generation Rules

| Argument Pattern | Generated Option | Description Template |
|-----------------|------------------|---------------------|
| `--flag` | `name: --flag` | "Enable [flag functionality]" |
| `--param=value` | `name: --param, values: [...]` | "Set [param description]" |
| `--option=a\|b\|c` | `name: --option, values: [a,b,c]` | "Choose [option type]" |
| `[--optional]` | `name: --optional` | "Optionally [action]" |
| `<required>` | In argument section | "Required [description]" |

### Example Generation Patterns

Based on command category:

**scan/** commands:

1. Basic: `/prefix:scan:X target/`
2. With export: `/prefix:scan:X . --export-json`
3. Focused: `/prefix:scan:X src/ --focus=specific`

**fix/** commands:

1. Dry run: `/prefix:fix:X --dry-run`
2. Targeted: `/prefix:fix:X --category=type`
3. With limits: `/prefix:fix:X --max-effort=2h`

**flow/** commands:

1. Basic: `/prefix:flow:X target/`
2. With config: `/prefix:flow:X . --config=custom`
3. Interactive: `/prefix:flow:X --interactive`

### See-Also Relationship Matrix

| Category | Related Categories | Common Relations |
|----------|-------------------|------------------|
| scan | fix, report, flow | Deep → quick-wins → report |
| fix | scan, verify, git | Quick-wins → verify → commit |
| flow | scan, fix, auto | Smart → execute → monitor |
| auto | scan, flow, meta | Execute → monitor → report |
| gen | scan, fix, meta | Docs → tests → format |
| git | flow, fix, meta | Review → commit → push |
| meta | all | Chain, export, help |
| sec | scan, fix, comply | Audit → fix → baseline |
| typo3 | gen, scan, fix | Content-blocks → sitepackage |

## 🎯 Success Criteria

### Functional Requirements

*AI/Agents: Mark with [x] and add timestamp when verified*

- [ ] All 57 commands respond to `--help` flag
- [ ] Help output follows consistent format
- [ ] Examples are accurate and runnable
- [ ] Related commands are properly linked
- [ ] Help generator works for all commands

### Quality Requirements

*AI/Agents: Mark with [x] and add timestamp when verified*

- [ ] Help content is clear and concise
- [ ] Options are accurately documented
- [ ] Examples cover common use cases
- [ ] No broken see-also references
- [ ] Shellcheck compliance maintained

### Performance Requirements

*AI/Agents: Mark with [x] and add timestamp when verified*

- [ ] Help generation < 100ms per command
- [ ] Batch update completes < 5 minutes
- [ ] Validation runs < 2 minutes
- [ ] No impact on command execution time

## 🚨 Risk Mitigation

### Identified Risks

1. **Malformed YAML in existing commands**
   - Mitigation: Validation before update, manual fixes

2. **Breaking existing command functionality**
   - Mitigation: Comprehensive backups, testing

3. **Inconsistent help content quality**
   - Mitigation: Templates, validation, review

4. **Installation compatibility issues**
   - Mitigation: Version checks, fallback options

5. **Performance impact**
   - Mitigation: Lazy loading, caching

## 📅 Timeline

### Day 1 (8 hours)

- Morning: Create batch update script (2h)
- Morning: Test and refine script (1h)
- Afternoon: Apply to high-priority categories (3h)
- Afternoon: Create validation script (1h)
- Late: Initial validation run (1h)

### Day 2 (5 hours)

- Morning: Apply to remaining categories (2h)
- Morning: Complete validation (1h)
- Afternoon: Update installation (1h)
- Afternoon: Testing (1h)

### Day 3 (2 hours)

- Morning: Documentation updates (1h)
- Morning: Final testing and rollout (1h)

## 📝 Notes & Considerations

1. **Backward Compatibility**: Ensure commands work without help system installed
2. **Localization**: Consider future multi-language support
3. **Accessibility**: Ensure help output is screen-reader friendly
4. **Versioning**: Track help content versions for updates
5. **Analytics**: Consider tracking help usage for improvements

## 📈 Progress Dashboard

### Overall Completion Status

**Last Updated**: [AI/Agent to update timestamp]
**Updated By**: [AI/Agent name]

```
Total Progress: 5/56 commands with help (9%)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
█████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
```

### Phase Completion

- [ ] Phase 1: Automation Infrastructure (0%)
- [ ] Phase 2: Command Updates (9%)
- [ ] Phase 3: Testing & Validation (0%)
- [ ] Phase 4: Installation Integration (0%)
- [ ] Phase 5: Documentation & Rollout (0%)

### Notes from AI/Agents

*Add notes here about issues, deviations, or important observations:*

- [Timestamp] [Agent]: Note...

## 🎉 Expected Outcome

Upon completion:

- 100% of commands will have comprehensive help support
- Users can discover command functionality without documentation
- Consistent, professional help experience across toolkit
- Reduced support questions and improved user adoption
- Foundation for future enhancements (interactive help, tutorials)

---

*This plan is designed to be executed systematically with clear checkpoints and validation at each phase.*
*AI/Agents working on this plan MUST update checkboxes, timestamps, and progress indicators as tasks are completed.*
