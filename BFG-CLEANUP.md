# BFG Cleanup Instructions

## Remove FEATURE-SUMMARY.md from Git History

### Prerequisites
1. Install BFG Repo-Cleaner:
   ```bash
   brew install bfg
   ```
   Or download from: https://rtyley.github.io/bfg-repo-cleaner/

2. Make a backup of your repository:
   ```bash
   cd ..
   cp -r claude-code-toolkit claude-code-toolkit-backup
   ```

### Steps to Remove FEATURE-SUMMARY.md

1. **Switch to main/develop branch** (important!):
   ```bash
   git checkout develop
   ```

2. **Run BFG to delete the file from history**:
   ```bash
   bfg --delete-files FEATURE-SUMMARY.md
   ```

3. **Clean up the repository**:
   ```bash
   git reflog expire --expire=now --all && git gc --prune=now --aggressive
   ```

4. **Force push all branches** (⚠️ Warning: This rewrites history!):
   ```bash
   git push origin --force --all
   git push origin --force --tags
   ```

### Alternative: Using git filter-branch (if BFG is not available)

```bash
git filter-branch --force --index-filter \
  'git rm --cached --ignore-unmatch FEATURE-SUMMARY.md' \
  --prune-empty --tag-name-filter cat -- --all
```

### Important Notes

- **Backup First**: Always create a backup before rewriting history
- **Coordinate with Team**: If others have cloned the repo, they need to re-clone
- **Protected Branches**: You may need to temporarily disable branch protection
- **File is Already Deleted**: The file has been removed from the working tree, this only cleans history

### After Cleanup

All collaborators should:
```bash
# Delete their local repo
cd ..
rm -rf claude-code-toolkit

# Clone fresh
git clone https://github.com/user/claude-code-toolkit.git
cd claude-code-toolkit
```

### Verify Success

Check that the file is gone from history:
```bash
git log --all --full-history -- FEATURE-SUMMARY.md
# Should return nothing
```

---

**Current Status**: 
- File removed from working tree ✓
- Waiting for BFG cleanup to remove from history