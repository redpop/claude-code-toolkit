---
description: Interactive Git conflict resolution with step-by-step guidance and recommendations
argument-hint: [source-branch] [target-branch] [--strategy:merge|rebase|theirs|ours] [--rebase-feature] [--test-command="npm test"] [--help]
mcp-enhanced: mcp__github__pull_request, mcp__gitlab__merge_request
options:
  --strategy: "Conflict resolution strategy - merge (default), rebase, theirs (prefer source), ours (prefer target)"
  --test-command: "Command to run tests after resolution (e.g., 'npm test', 'pytest')"
  --rebase-feature: "Rebase current feature branch onto main (team workflow)"
  --help: "Show detailed help message with examples and strategies"
examples:
  - description: "Detect and resolve current conflicts interactively"
    command: "/conflict-resolver"
  - description: "Resolve conflicts when merging feature-branch into main"
    command: "/conflict-resolver feature-branch main"
  - description: "Resolve conflicts preferring source branch changes"
    command: "/conflict-resolver feature-branch main --strategy:theirs"
  - description: "Rebase feature branch with conflict resolution"
    command: "/conflict-resolver --rebase-feature"
  - description: "Resolve conflicts and run tests after"
    command: "/conflict-resolver --test-command='npm test'"
see-also:
  - "/git:review - Review changes before committing merge"
  - "/scan:quick - Verify code quality after resolution"
  - "/git:commit - Create merge commit with proper message"
---

# Help Detection

if [[ "$ARGUMENTS" == *"--help"* ]]; then
    echo "🔧 Git Conflict Resolver - Interactive conflict resolution with expert guidance"
    echo ""
    echo "USAGE:"
    echo "  /conflict-resolver [source-branch] [target-branch] [options]"
    echo ""
    echo "OPTIONS:"
    echo "  --strategy:merge     Standard merge (default) - preserves commit history"
    echo "  --strategy:rebase    Rebase approach - creates linear history"
    echo "  --strategy:theirs    Prefer source branch changes in conflicts"
    echo "  --strategy:ours      Prefer target branch changes in conflicts"
    echo "  --rebase-feature     Rebase current feature branch onto main"
    echo "  --test-command=CMD   Run specified test command after resolution"
    echo "  --help               Show this help message"
    echo ""
    echo "EXAMPLES:"
    echo "  /conflict-resolver                           # Resolve current conflicts"
    echo "  /conflict-resolver feature main              # Merge feature into main"
    echo "  /conflict-resolver --strategy:theirs         # Prefer source changes"
    echo "  /conflict-resolver --rebase-feature          # Team rebase workflow"
    echo "  /conflict-resolver --test-command='npm test' # Run tests after resolution"
    echo ""
    echo "STRATEGIES:"
    echo "  merge    - Standard merge preserving history (default)"
    echo "  rebase   - Linear history by replaying commits"
    echo "  theirs   - Prefer source branch in conflicts"
    echo "  ours     - Prefer target branch in conflicts"
    echo ""
    echo "WORKFLOW:"
    echo "  1. Detect conflicts and analyze context"
    echo "  2. Present conflicts with recommendations"
    echo "  3. Interactive resolution with guided options"
    echo "  4. Verify resolution and run tests"
    echo "  5. Complete merge/rebase process"
    echo ""
    echo "See full documentation below for detailed examples and advanced features."
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
fi

# INTERACTIVE Git Conflict Resolution Command

**CRITICAL INSTRUCTION**: This command MUST be fully interactive. Never resolve conflicts automatically or use AI agents for conflict resolution.

## MANDATORY INTERACTIVE BEHAVIOR

**When conflicts are detected:**

1. **STOP all automatic processing**
2. **Show conflict details to user**
3. **Present clear resolution options**
4. **WAIT for explicit user choice**
5. **Apply ONLY the user's chosen resolution**

**NEVER:**

- ❌ Use Task tool with git-conflict-specialist  
- ❌ Make automatic conflict resolution decisions
- ❌ Apply "recommended" solutions without user approval
- ❌ Resolve multiple conflicts at once

---

## Usage

```
/conflict-resolver                                    # Detect and resolve current conflicts
/conflict-resolver feature-branch main                # Resolve conflicts when merging feature-branch into main
/conflict-resolver feature-branch main --strategy:theirs    # Resolve giving priority to source branch
/conflict-resolver --strategy:rebase                 # Use rebase strategy for conflict resolution
/conflict-resolver --rebase-feature                  # Rebase current feature branch onto main (team workflow)
/conflict-resolver feature-branch --rebase-onto main # Explicit rebase feature onto main
```

## Workflow Phases

### Phase 1: Conflict Detection &amp; Analysis

1. **Identify Conflict Context**:
   - Check current repository status (`git status`)
   - Detect if in merge/rebase conflict state
   - Identify source and target branches
   - List all conflicted files

2. **Gather Conflict Information**:
   - For each conflicted file:
     - Show conflict markers location
     - Analyze code context around conflicts
     - Identify conflict type (content, rename, delete, etc.)
   - Check recent commits on both branches
   - Understand the intent behind conflicting changes

3. **Remote Conflict Detection** (GitLab/GitHub):
   - If branches specified but no local conflicts:
     - Attempt test merge locally
     - Simulate the MR/PR merge to identify conflicts
     - Fetch latest changes from remote if needed

### Phase 2: Interactive Conflict Presentation

For each conflicted file, present:

```
📁 File: src/auth/login.js
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 Conflict Context:
   This file implements user authentication logic.
   
⚔️ Conflict Type: Content conflict (lines 45-67)

📊 Change Analysis:
   SOURCE (feature-branch): Added new OAuth2 authentication
   TARGET (main): Updated password validation rules
   
🎯 Their Changes (feature-branch):
   ┌─────────────────────────────────────────────┐
   │ + async function authenticateOAuth2(token) { │
   │ +   const provider = await getProvider();    │
   │ +   return provider.validate(token);         │
   │ + }                                           │
   └─────────────────────────────────────────────┘
   
🎯 Our Changes (main):
   ┌─────────────────────────────────────────────┐
   │ + function validatePassword(password) {      │
   │ +   if (password.length < 12) return false;  │
   │ +   return /[A-Z].*[0-9]/.test(password);   │
   │ + }                                           │
   └─────────────────────────────────────────────┘

📋 Raw Conflict View (as in file):
   ┌─────────────────────────────────────────────┐
   │ 42:  function authenticate(user) {          │
   │ 43:    validateUser(user);                  │
   │ 44: <<<<<<< HEAD                            │
   │ 45:    // OAuth2 authentication             │
   │ 46:    async function authenticateOAuth2() {│
   │ 47:      const provider = getProvider();    │
   │ 48:      return provider.validate(token);   │
   │ 49:    }                                     │
   │ 50: =======                                  │
   │ 51:    // Enhanced password validation      │
   │ 52:    function validatePassword(password) {│
   │ 53:      if (password.length < 12) return;  │
   │ 54:      return /[A-Z].*[0-9]/.test(pass);  │
   │ 55:    }                                     │
   │ 56: >>>>>>> main                            │
   │ 57:  }                                       │
   └─────────────────────────────────────────────┘

📊 Side-by-Side Comparison:
   ┌──────── THEIRS (feature) ────────┬──────── OURS (main) ──────────┐
   │ async function authenticateOAuth2│ function validatePassword()    │
   │   const provider = getProvider();│   if (password.length < 12)    │
   │   return provider.validate();    │   return /[A-Z].*[0-9]/.test();│
   └───────────────────────────────────┴─────────────────────────────────┘

💡 Recommendation:
   Both changes serve different purposes and can coexist.
   Suggested resolution: KEEP BOTH
   - OAuth2 function adds new capability
   - Password validation enhances security
   
   Proposed merge:
   ┌─────────────────────────────────────────────┐
   │ async function authenticateOAuth2(token) {   │
   │   const provider = await getProvider();      │
   │   return provider.validate(token);           │
   │ }                                             │
   │                                               │
   │ function validatePassword(password) {        │
   │   if (password.length < 12) return false;    │
   │   return /[A-Z].*[0-9]/.test(password);     │
   │ }                                             │
   └─────────────────────────────────────────────┘
```

### Phase 3: User Decision &amp; Application

For each conflict, offer options:

```
How would you like to resolve this conflict?

1. ✅ Accept recommendation (keep both)
2. 🎯 Keep THEIRS only (feature-branch version)
3. 🎯 Keep OURS only (main version)
4. ✏️ Custom merge (I'll help you edit)
5. 💭 Skip for now (resolve later)
6. 🔍 Show more context (surrounding code)
7. 📚 Explain changes in detail
8. 📄 Show full file with conflicts highlighted
9. 🔎 Show 10 lines before/after conflict
10. 📦 Show entire function/class containing conflict
11. 🕐 Show git blame for conflict lines

Choose [1-11]: _
```

### Step 4: Complete Operation

After user has resolved all conflicts (or chosen to skip remaining files):

```bash
# For rebase operations:
git rebase --continue

# For merge operations:
git commit -m "Resolve merge conflicts"
```

### Step 5: Optional Testing

If `--test-command` parameter was provided:

```bash
# Run user's specified test command
{test-command}
```

### Success Summary

```
✅ Conflict Resolution Complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Resolution Summary:
   Files processed: {X}
   User choices applied: {list user's actual choices}
   
📝 Next Steps:
   1. Review changes: git diff --cached
   2. Continue development
   3. Push when ready: git push
```

## Strategy Options

### --strategy:merge (default)

- Standard merge approach
- Preserves commit history from both branches
- Best for feature branch integration

### --strategy:rebase

- Reapplies commits on top of target branch
- Creates linear history
- Useful for cleaning up feature branches

### --rebase-feature (Team Workflow)

Special mode for rebasing feature branches onto main:

```bash
# In your feature branch:
/conflict-resolver --rebase-feature

# Automatically performs:
git fetch origin main
git rebase origin/main
# → Interactive conflict resolution during rebase
# → Feature branch is updated to latest main
```

This is the recommended workflow for teams preferring linear history!

### --strategy:theirs

- In conflicts, prefer source branch changes
- Still requires review for safety
- Useful when source branch is authoritative

### --strategy:ours

- In conflicts, prefer target branch changes
- Maintains stability of target branch
- Useful for selective feature adoption

## Team Rebase Workflow (Best Practice)

For teams preferring linear Git history, this command offers special rebase support:

### Why Rebase Instead of Merge

- **Clean History**: No merge commits, linear development
- **Easy Review**: Commits are chronologically sorted
- **Better Bisect**: Git bisect works better with linear history
- **MR/PR Quality**: GitLab/GitHub shows clean commit list

### Typical Development Workflow

```bash
# 1. START: Work on your feature
git checkout -b feature/integrate-new-styles

# 2. DURING DEVELOPMENT: Main was updated
# Instead of merge, do rebase:
/conflict-resolver --rebase-feature

# The command guides you through:
┌─────────────────────────────────────────────────┐
│ 🔄 REBASE: feature/integrate-new-styles onto origin/main │
│                                                 │
│ Replaying commit 1/3: "Add OAuth setup"        │
│ ⚔️ CONFLICT in: src/auth.js                    │
│                                                 │
│ Context: This commit is being applied on       │
│ top of the new main state.                     │
│                                                 │
│ [Interactive conflict resolution...]           │
│                                                 │
│ After resolution: git rebase --continue        │
└─────────────────────────────────────────────────┘

# 3. AFTER REBASE: Force-push with safety
git push --force-with-lease origin feature/integrate-new-styles
```

### Rebase-Specific Conflict Handling

Conflicts during rebase differ from merge conflicts:

1. **Commit-by-Commit**: Each of your commits is reapplied individually
2. **Multiple Conflicts**: The same conflict may appear in multiple commits
3. **Context Matters**: The command shows which commit is being replayed

### Safety Guidelines

- Use `--force-with-lease` instead of `--force` when pushing
- Only rebase feature branches, never shared branches
- Communicate with your team when rebasing

## Advanced Features

### Git Commands for Code Extraction

The command uses various Git commands to extract and display conflict information:

```bash
# Show conflict markers in file
git diff --check                    # Lists files with conflict markers

# Extract different versions of conflicted file
git show :1:path/to/file           # Common ancestor (base)
git show :2:path/to/file           # Our version (HEAD/main)
git show :3:path/to/file           # Their version (feature branch)

# Show context around conflicts
git diff --no-index --no-prefix \
  <(git show :2:file) <(git show :3:file)  # Direct comparison

# Get detailed conflict information
git ls-files -u                    # List unmerged files with stages
git diff --name-only --diff-filter=U  # List only conflicted files

# Show blame information for conflict context
git blame -L 40,60 path/to/file    # Show who changed lines 40-60
```

## MANDATORY INTERACTIVE WORKFLOW

**CRITICAL**: This command MUST be interactive. Never use automatic resolution.

### Step 1: Conflict Detection

```bash
# Check for existing conflicts
git status --porcelain | grep "^UU\|^AA\|^DD"
```

If `--rebase-feature` and no conflicts exist:

```bash
git fetch origin main  
git rebase origin/main
```

### Step 2: For Each Conflicted File (One at a Time)

**Extract conflict versions:**

```bash
# Their version: git show :3:filename
# Our version: git show :2:filename  
# Conflict markers: grep -n -A5 -B5 "<<<<<<< HEAD" filename
```

**Display to user:**

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 CONFLICT: {filename}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 THEIRS (incoming):
{show their version}

🎯 OURS (current):
{show our version}

📋 Raw conflict:
{show conflict markers with line numbers}

HOW DO YOU WANT TO RESOLVE THIS?

1. ✅ Keep THEIRS (incoming changes)
2. ✅ Keep OURS (current changes)
3. ✅ Keep BOTH (manual merge)
4. ✏️ Edit manually
5. 🔍 Show context 
6. ❌ Skip this file

Your choice [1-6]: 
```

**WAIT FOR USER INPUT - Do not proceed without user response**

### Step 3: Apply User Choice

- **Choice 1**: `git checkout --theirs filename && git add filename`
- **Choice 2**: `git checkout --ours filename && git add filename`
- **Choice 3**: Help user merge both sections manually
- **Choice 4**: Interactive editing session with user
- **Choice 5**: Show context using git-conflict-specialist for analysis only
- **Choice 6**: Skip file (leave conflicted)

### Optional Expert Analysis (Only When User Chooses Option 5)

When user requests context, use git-conflict-specialist for analysis only:

```markdown
Use Task tool with subagent_type="git-conflict-specialist":
"Analyze this specific conflict and explain technical implications:
[conflict details]

Provide context about:
- What each side changes
- Technical impact of each choice
- Potential risks

Do NOT recommend a solution - only provide analysis."
```

## Integration with Other Commands

Works seamlessly with:

- `/git:review` - Review changes before committing merge
- `/scan:quick` - Verify code quality after resolution
- `/git:commit` - Create merge commit with proper message

## Important Notes

- Always creates backup before resolution attempts
- Preserves user's working directory state
- Provides undo instructions if needed
- Never force-pushes without explicit confirmation
- Respects existing Git configuration and aliases
- Works with both local and remote conflict scenarios

## Example Scenarios

### Scenario 1: GitLab MR Conflict

```bash
# User reports MR conflict in GitLab
/conflict-resolver feature/auth-integration main --strategy:theirs

# Command will:
# 1. Fetch both branches
# 2. Attempt local merge
# 3. Show conflicts interactively
# 4. Guide through resolution with source branch priority
# 5. Prepare changes for push
```

### Scenario 2: Rebase Conflict (Team Workflow)

```bash
# Rebase current feature branch onto main
/conflict-resolver --rebase-feature

# Command will:
# 1. Fetch latest main from origin
# 2. Start rebase of current branch onto main
# 3. For each conflict during rebase:
#    - Show conflict in rebase context
#    - Explain which commit is being replayed
#    - Guide through resolution
# 4. Continue rebase after each resolution
# 5. Feature branch has linear history on top of main

# Alternative explicit syntax:
/conflict-resolver feature/auth-integration --rebase-onto main
```

### Scenario 2b: Team Rebase Workflow

```bash
# Typical team workflow:
# 1. You're working on feature/new-integration
# 2. Main has received new commits
# 3. Update your branch via rebase:

git checkout feature/new-integration
/conflict-resolver --rebase-feature

# After conflict resolution:
git push --force-with-lease origin feature/new-integration

# GitLab MR shows: "No conflicts, linear history ✅"
```

### Scenario 3: Complex Merge

```bash
# Multiple files with different conflict types
/conflict-resolver feature/oauth develop

# Command will:
# 1. Categorize conflicts by type
# 2. Group related conflicts
# 3. Suggest batch resolutions where safe
# 4. Handle each conflict interactively
```
