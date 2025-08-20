---
description: Interactive Git conflict resolution with step-by-step guidance and recommendations
argument-hint: [source-branch] [target-branch] [--strategy:merge|rebase|theirs|ours]
mcp-enhanced: mcp__github__pull_request, mcp__gitlab__merge_request
---

# Claude Command: Interactive Git Conflict Resolver

This command provides interactive, step-by-step guidance for resolving Git conflicts, especially useful for merge requests with conflicts in GitLab or GitHub.

## Usage

```
/conflict-resolver                                    # Detect and resolve current conflicts
/conflict-resolver feature-branch main                # Resolve conflicts when merging feature-branch into main
/conflict-resolver PHK-466 main --strategy:theirs    # Resolve giving priority to source branch
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

Choose [1-7]: _
```

### Phase 4: Conflict Resolution Execution

Based on user choices:

1. **Apply Resolution**:
   - Edit the file to implement chosen resolution
   - Remove conflict markers
   - Preserve intended functionality
   - Maintain code style consistency

2. **Verify Resolution**:
   - Show the resolved code
   - Check for syntax errors
   - Identify potential logic issues
   - Suggest testing commands if applicable

3. **Stage Resolved Files**:
   - After user confirmation, stage the resolved file
   - Update conflict status

### Phase 5: Completion &amp; Next Steps

After all conflicts resolved:

```
✅ Conflict Resolution Complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Resolution Summary:
   Files resolved: 5
   - Kept both: 3 files
   - Used theirs: 1 file
   - Custom merge: 1 file
   
🔍 Recommended Quality Checks:
   1. Run tests: npm test
   2. Check linting: npm run lint
   3. Build project: npm run build
   
📝 Next Steps:
   1. Review all changes: git diff --cached
   2. Complete the merge: git commit
   3. Push to remote: git push
   
💡 For GitLab MR:
   After pushing, the MR should update automatically.
   Conflicts will be marked as resolved.
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
git checkout -b PHK-466_IntegrateBasisStyles

# 2. DURING DEVELOPMENT: Main was updated
# Instead of merge, do rebase:
/conflict-resolver --rebase-feature

# The command guides you through:
┌─────────────────────────────────────────────────┐
│ 🔄 REBASE: PHK-466 onto origin/main            │
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
git push --force-with-lease origin PHK-466_IntegrateBasisStyles
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

### Intelligent Conflict Analysis

The command uses Task Tool to invoke specialized analysis:

```markdown
Use Task tool with subagent_type="git-conflict-specialist":
"Analyze this Git conflict and provide resolution recommendations:
[conflict details]
Consider code semantics, test coverage, and architectural impact."
```

### Pattern Recognition

Identifies common conflict patterns:

- **Import conflicts**: Merges import statements intelligently
- **Version bumps**: Suggests using higher version number
- **Formatting conflicts**: Applies consistent formatting
- **Feature flags**: Preserves both flags when possible
- **Configuration merges**: Combines configuration entries

### Safety Checks

Before applying any resolution:

- Backs up current state
- Validates syntax for file type
- Checks for potential runtime errors
- Warns about semantic conflicts

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
/conflict-resolver PHK-466_IntegrateBasisStyles main --strategy:theirs

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
/conflict-resolver PHK-466_IntegrateBasisStyles --rebase-onto main
```

### Scenario 2b: Team Rebase Workflow

```bash
# Typical team workflow:
# 1. You're working on PHK-466_IntegrateBasisStyles
# 2. Main has received new commits
# 3. Update your branch via rebase:

git checkout PHK-466_IntegrateBasisStyles
/conflict-resolver --rebase-feature

# After conflict resolution:
git push --force-with-lease origin PHK-466_IntegrateBasisStyles

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
