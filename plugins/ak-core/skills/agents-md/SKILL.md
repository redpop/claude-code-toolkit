---
name: agents-md
description: Convert CLAUDE.md files to AGENTS.md with symlinks. Use when the user asks to "convert claude.md", "create agents.md symlinks", "rename claude.md to agents.md", or wants CLAUDE.md files replaced by AGENTS.md with backward-compatible symlinks.
disable-model-invocation: true
---

# agents-md

Rename all `CLAUDE.md` files to `AGENTS.md` and create `CLAUDE.md` symlinks pointing to them.

## Current State

- Working directory: !`pwd`

## Execution Workflow

### 1. Find CLAUDE.md Files

```bash
find . -name "CLAUDE.md" -not -path "*/node_modules/*" -not -path "*/.git/*" | sort
```

### 2. Process Each File

For each found `CLAUDE.md`, run the following logic:

```bash
FOUND=0
CONVERTED=0
SKIPPED=0

while IFS= read -r file; do
  [ -z "$file" ] && continue
  FOUND=$((FOUND + 1))
  dir=$(dirname "$file")

  if [ -L "$file" ]; then
    echo "[skipped] $file — already a symlink"
    SKIPPED=$((SKIPPED + 1))
  elif [ -f "$dir/AGENTS.md" ]; then
    echo "[skipped] $file — AGENTS.md already exists in $dir"
    SKIPPED=$((SKIPPED + 1))
  else
    mv "$file" "$dir/AGENTS.md" && ln -s AGENTS.md "$file"
    echo "[converted] $file → AGENTS.md + symlink"
    CONVERTED=$((CONVERTED + 1))
  fi
done < <(find . -name "CLAUDE.md" -not -path "*/node_modules/*" -not -path "*/.git/*" | sort)

echo ""
echo "Summary: $CONVERTED converted, $SKIPPED skipped (of $FOUND found)"
```

## Output Format

```markdown
## agents-md Results

- [converted] /path/to/CLAUDE.md → AGENTS.md + symlink
- [skipped]   /sub/CLAUDE.md — already a symlink
- [skipped]   /other/CLAUDE.md — AGENTS.md already exists

**Summary**: X converted, Y skipped
```

If no `CLAUDE.md` files are found, report: "No CLAUDE.md files found in the project."
