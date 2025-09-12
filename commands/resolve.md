---
description: Smart conflict resolution and merge analysis with expert guidance
argument-hint: [type] [branches] [--help]
allowed-tools: Task, Read, Write, Bash(git:*)
mcp-enhanced: mcp__github__pull_request, mcp__gitlab__merge_request
---

# Resolve - Smart Conflict Resolution

Intelligent resolution command that automatically handles Git conflicts and merge analysis with expert guidance. Zero configuration, maximum success rate.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Resolution Types

**Automatically detects conflict state and applies optimal resolution strategies with step-by-step guidance.**

### Available Resolution Types

- `conflicts` - Interactive Git conflict resolution (default when conflicts detected)
- `merge` - Merge conflict resolution with strategy selection
- `rebase` - Rebase conflict resolution with guidance
- `review` - Pre-merge analysis and conflict prevention
- `strategy` - Advanced merge strategy consultation
- `test` - Post-resolution testing and validation

## Usage

```bash
# Smart defaults - auto-detect and resolve current conflicts
/prefix:resolve

# Specific resolution types
/prefix:resolve conflicts              # Interactive conflict resolution
/prefix:resolve merge main feature    # Merge branch conflict resolution  
/prefix:resolve rebase                 # Rebase conflict guidance
/prefix:resolve review                 # Pre-merge conflict analysis

# With strategies and options
/prefix:resolve merge --strategy=theirs    # Prefer source branch changes
/prefix:resolve conflicts --test="npm test" # Run tests after resolution
/prefix:resolve rebase --interactive       # Interactive rebase mode
```

## Execution

### Smart Detection Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine resolution context and type**

```bash
# Check current Git state
git_status=$(git status --porcelain)
conflict_files=$(git diff --name-only --diff-filter=U)
merge_state=""

# Detect current state
if [[ -f .git/MERGE_HEAD ]]; then
    merge_state="merge_in_progress"
elif [[ -f .git/REBASE_HEAD ]]; then
    merge_state="rebase_in_progress"  
elif [[ -n "$conflict_files" ]]; then
    merge_state="conflicts_present"
fi

# Parse arguments for resolution type
args=($ARGUMENTS)
resolution_type="auto"    # default to smart detection

# Check for explicit resolution type
resolution_types=("conflicts" "merge" "rebase" "review" "strategy" "test")
if [[ " ${resolution_types[@]} " =~ " ${args[0]} " ]]; then
    resolution_type=${args[0]}
    remaining_args="${args[@]:1}"
else
    remaining_args="${args[*]}"
fi
```

**Step 2: Route to appropriate resolution strategy**

Based on resolution_type and Git state, execute optimal approach:

### Auto-Detection and Resolution (Default)

**Process**: Intelligent conflict detection and resolution
**Export**: Auto-generates `resolve-YYYYMMDD-HHMMSS.md` resolution report

Use Task tool with subagent_type="git-conflict-specialist":
"AUTO-RESOLVE MODE: Analyze current Git state and conflicts. Current state: $merge_state. Conflict files: $conflict_files. Provide step-by-step resolution guidance: 1) Conflict analysis and categorization, 2) Resolution strategy recommendation, 3) Interactive resolution guidance, 4) Post-resolution validation steps, 5) Testing recommendations. Use intelligent conflict detection and provide expert guidance for successful resolution."

### Interactive Conflict Resolution

**Process**: Step-by-step conflict resolution with expert guidance
**Export**: Auto-generates conflict resolution report with decisions made

Use Task tool with subagent_type="git-conflict-specialist":
"INTERACTIVE CONFLICT RESOLUTION: Guide resolution of Git conflicts in '$remaining_args'. Analyze each conflict file: 1) Identify conflict types (content, rename, delete), 2) Understand context and intent, 3) Recommend resolution approach, 4) Provide merge guidance, 5) Validate resolution completeness. Support multiple resolution strategies: manual editing, strategy selection (theirs/ours), three-way merge analysis."

### Merge Conflict Resolution

**Process**: Merge-specific conflict handling with branch analysis
**Export**: Auto-generates merge resolution report

Use Task tool with subagent_type="git-conflict-specialist":
"MERGE CONFLICT RESOLUTION: Handle merge conflicts for '$remaining_args'. Analyze branch histories and changes. Process: 1) Pre-merge analysis (identify potential conflicts), 2) Merge strategy selection (recursive, resolve, octopus), 3) Conflict resolution guidance, 4) Post-merge validation, 5) Merge commit message generation. Consider merge strategies: default recursive, theirs/ours preference, custom strategies."

### Rebase Conflict Resolution

**Process**: Rebase-specific conflict handling with commit analysis
**Export**: Auto-generates rebase resolution report

Use Task tool with subagent_type="git-conflict-specialist":
"REBASE CONFLICT RESOLUTION: Guide rebase conflict resolution for '$remaining_args'. Analyze commit sequence and changes. Process: 1) Rebase plan analysis, 2) Commit-by-commit conflict resolution, 3) Interactive rebase options (pick, edit, squash, drop), 4) History linearization guidance, 5) Final rebase validation. Handle complex scenarios: squashing, rewording, reordering commits."

### Pre-Merge Conflict Analysis

**Process**: Conflict prevention through pre-merge analysis
**Export**: Auto-generates merge feasibility report

Use Task tool with subagent_type="git-conflict-specialist":
"PRE-MERGE ANALYSIS: Analyze merge feasibility for '$remaining_args'. Process: 1) Branch divergence analysis, 2) Potential conflict prediction, 3) Change impact assessment, 4) Merge complexity evaluation, 5) Preparation recommendations. Identify: overlapping changes, file modifications, structural conflicts, dependency impacts. Recommend merge timing and preparation steps."

### Advanced Merge Strategy Consultation

**Process**: Expert consultation on merge strategies and best practices
**Export**: Auto-generates strategy recommendation report

Use Task tool with subagent_type="git-conflict-specialist":
"MERGE STRATEGY CONSULTATION: Provide expert guidance on merge strategies for '$remaining_args'. Analyze: 1) Project workflow requirements, 2) Team collaboration patterns, 3) Branch structure and policies, 4) History preservation needs, 5) CI/CD integration. Recommend: optimal merge strategies, workflow improvements, conflict prevention measures, team practices."

### Post-Resolution Testing and Validation

**Process**: Comprehensive validation after conflict resolution
**Export**: Auto-generates validation report

Use Task tool with subagent_type="general-purpose":
"POST-RESOLUTION VALIDATION: Validate conflict resolution for '$remaining_args'. Execute: 1) Build verification (compile/syntax check), 2) Test suite execution, 3) Integration testing, 4) Code quality checks, 5) Functionality verification. Report: resolution success, any remaining issues, recommendations for follow-up actions."

## Conflict Resolution Strategies

### Merge Strategies

1. **Recursive (Default)**
   - Standard three-way merge
   - Best for most scenarios
   - Handles renames and modifications well

2. **Resolve**
   - Simple three-way merge
   - Fast but less sophisticated
   - Good for simple conflicts

3. **Theirs/Ours**
   - Prefer one side completely
   - Use with caution
   - Good for specific scenarios

4. **Octopus**
   - Multiple branch merges
   - Automatic conflict abort
   - Advanced workflow support

### Resolution Approaches

1. **Manual Resolution**
   - Edit conflicted files directly
   - Full control over resolution
   - Best for complex conflicts

2. **Strategy-Based**
   - Use Git merge strategies
   - Automated when possible
   - Good for predictable conflicts

3. **Three-Way Analysis**
   - Compare all three versions
   - Understand change context
   - Make informed decisions

4. **Interactive Resolution**
   - Step-by-step guidance
   - Expert recommendations
   - Learning-oriented approach

## Git State Detection

### Conflict States

- **Active Conflicts**: Files with conflict markers
- **Merge in Progress**: .git/MERGE_HEAD exists
- **Rebase in Progress**: .git/REBASE_HEAD exists
- **Cherry-pick Conflicts**: .git/CHERRY_PICK_HEAD exists
- **Clean State**: No conflicts detected

### Auto-Detection Logic

```bash
# Comprehensive state detection
if [[ -f .git/MERGE_HEAD ]]; then
    echo "Merge in progress - providing merge conflict guidance"
elif [[ -f .git/REBASE_HEAD ]]; then
    echo "Rebase in progress - providing rebase conflict guidance"
elif [[ -f .git/CHERRY_PICK_HEAD ]]; then
    echo "Cherry-pick in progress - providing cherry-pick guidance"
elif [[ -n "$(git diff --name-only --diff-filter=U)" ]]; then
    echo "Conflicts detected - providing resolution guidance"
else
    echo "No conflicts detected - providing pre-merge analysis"
fi
```

## Next Steps Recommendations

After resolution completion, display context-aware recommendations:

```markdown
✅ [Resolution Type] completed successfully

🔀 **Resolution Status**: [Conflicts resolved/merge completed]
🧪 **Testing**: [Test results and recommendations]
📋 **Next Actions**: [Follow-up steps needed]

💡 **Recommended next steps:**
   /prefix:git commit          # Finalize merge with proper commit
   /prefix:work review         # Get code review after resolution
   /prefix:analyze quality     # Verify code quality after merge

   **Or describe your next goal:** "I need to push the resolved changes"
```

### Smart Next-Step Logic

Based on resolution results:

- **Conflicts resolved** → Suggest `/prefix:git commit` to finalize merge
- **Merge completed** → Suggest `/prefix:work review` or quality check
- **Rebase finished** → Suggest testing and push validation
- **Pre-merge analysis** → Suggest timing and preparation steps
- **Tests passing** → Suggest finalizing and pushing changes

## Advanced Features

### MCP Integration

- **GitHub PRs**: Automatic PR conflict analysis and resolution guidance
- **GitLab MRs**: Merge request conflict detection and resolution
- **Enhanced Context**: Additional repository context for better decisions

### Testing Integration

- **Auto-Testing**: Run specified test commands after resolution
- **Build Verification**: Ensure code compiles after merge
- **Integration Checks**: Validate functionality preservation

### Learning Mode

- **Explanation**: Understand why conflicts occurred
- **Prevention**: Learn to avoid future conflicts
- **Best Practices**: Team workflow recommendations

## Benefits

- **Smart Detection**: Automatically identifies conflict state and type
- **Expert Guidance**: Git conflict specialist provides step-by-step help
- **Strategy Flexibility**: Supports multiple resolution approaches
- **Comprehensive Validation**: Tests and validates resolution completeness
- **Learning Oriented**: Explains conflicts and prevention strategies
- **One Interface**: Replaces multiple Git conflict and review commands

*Consolidates: git:conflict-resolver, git:review (conflict focus)*
