# Bump Version

Synchronize version numbers across all AgentKit files.

## Arguments

Parse `$ARGUMENTS` for an optional bump type:

- If `$ARGUMENTS` is `patch`, `minor`, or `major` — use that as the bump type
- If `$ARGUMENTS` is empty — auto-detect from commits (see Step 2)
- Any other value — report an error and stop

## Execution

### Step 1: Read current version

Read `.claude-plugin/marketplace.json` and extract the current version from the first plugin entry's `"version"` field.

### Step 2: Determine bump type

If no explicit bump type was given via arguments, analyze commits since the last git tag:

Run `git tag --sort=-v:refname` to find the latest tag, then `git log <tag>..HEAD --oneline` to get commits since that tag.

Determine bump type from commit messages:

- If any commit contains `BREAKING CHANGE` in the body/footer or uses `!:` (e.g., `feat!:`) → **major**
- If any commit starts with `feat:` or `feat(` → **minor**
- Otherwise (`fix:`, `docs:`, `refactor:`, `chore:`, etc.) → **patch**
- If no tags exist at all → **patch** (fallback)

### Step 3: Calculate new version

Apply the semver increment to the current version:

- `patch`: 1.1.2 → 1.1.3
- `minor`: 1.1.2 → 1.2.0
- `major`: 1.1.2 → 2.0.0

### Step 4: Update all 7 files

Use the Edit tool to update the version in each of these files. Update ALL of them — do not skip any:

1. **`.claude-plugin/marketplace.json`** — Update ALL 5 plugin `"version"` entries (ak-core, ak-git, ak-meta, ak-review, ak-typo3)
2. **`plugins/ak-core/.claude-plugin/plugin.json`** — Update `"version"` field
3. **`plugins/ak-git/.claude-plugin/plugin.json`** — Update `"version"` field
4. **`plugins/ak-meta/.claude-plugin/plugin.json`** — Update `"version"` field
5. **`plugins/ak-review/.claude-plugin/plugin.json`** — Update `"version"` field
6. **`plugins/ak-typo3/.claude-plugin/plugin.json`** — Update `"version"` field
7. **`AGENTS.md`** — Update the version reference `(currently X.Y.Z)` in the "Commit and PR guidelines" section

### Step 5: Output summary

Display a summary in this format:

```
Version bump: X.Y.Z → A.B.C (bump-type)
Reason: <why this bump type was chosen>

Updated files:
  - .claude-plugin/marketplace.json (5 entries)
  - plugins/ak-core/.claude-plugin/plugin.json
  - plugins/ak-git/.claude-plugin/plugin.json
  - plugins/ak-meta/.claude-plugin/plugin.json
  - plugins/ak-review/.claude-plugin/plugin.json
  - plugins/ak-typo3/.claude-plugin/plugin.json
  - AGENTS.md
```

### Step 6: Run changelog

After the summary, invoke the `/ak-meta:changelog` skill to update the CHANGELOG.

### Step 7: Run git operations

After the changelog is updated, invoke the `/ak-git:operations` skill to create a smart commit.

### Step 8: Create git tag

After the commit is created, tag it with the new version:

```bash
git tag v<new-version>
```

For example: `git tag v1.1.3`

Confirm the tag was created by showing the output of `git tag --sort=-v:refname | head -3`.
