# AGENTS.md Best Practices

Reference guide for writing effective AGENTS.md files. Based on the official specification at [agents.md](https://agents.md/).

## What is AGENTS.md?

A simple, open Markdown format for guiding AI coding agents. Adopted by 60,000+ open-source projects and supported by 20+ tools including Claude Code, OpenAI Codex, Cursor, Gemini CLI, Aider, Windsurf, GitHub Copilot, and more.

**Core principle**: AGENTS.md provides the context coding agents need (build steps, tests, conventions) while keeping README files concise and human-focused.

Stewarded by the Agentic AI Foundation under the Linux Foundation.

## When to use AGENTS.md vs README

| AGENTS.md | README.md |
|-----------|-----------|
| Build & test commands | Project description |
| Code style rules | Installation for users |
| Commit conventions | Feature overview |
| Security gotchas | Screenshots, badges |
| Dev environment setup | Contributing overview |
| "What you'd tell a new teammate" | "What you'd tell a potential user" |

## Format

- Standard Markdown, no special syntax
- No mandatory fields or required sections
- Any headings you prefer
- Filename: `AGENTS.md` (some tools also read `CLAUDE.md` — use symlinks for compatibility)

## Recommended Sections

### 1. Project overview

Brief context about what the codebase does. Keep it to 2-3 sentences — agents can read the README for more.

### 2. Dev environment / Build & test commands

The most important section. Include every command an agent needs:

```markdown
## Dev environment

- Install dependencies: `pnpm install`
- Run dev server: `pnpm dev`
- Run all tests: `pnpm test`
- Run single test: `pnpm vitest run -t "<test name>"`
- Lint: `pnpm lint`
- Type check: `tsc --noEmit`
```

Agents will execute these commands automatically when listed.

### 3. Code style guidelines

Conventions that aren't enforced by linters:

```markdown
## Code style

- TypeScript strict mode
- Single quotes, no semicolons
- Functional patterns preferred over classes
- Error messages: lowercase, no trailing period
- File naming: kebab-case for files, PascalCase for components
```

### 4. Testing instructions

How to run tests and what to test:

```markdown
## Testing

- Run `pnpm test` before committing
- Add/update tests for all code modifications
- Use `pnpm vitest run -t "<test name>"` for focused testing
- Review CI plan in `.github/workflows/`
```

### 5. Commit and PR guidelines

```markdown
## Commits

- Use conventional commits: feat:, fix:, docs:, refactor:
- PR title format: [component] Description
- Always run lint and tests before committing
```

### 6. Security considerations

Things an agent should never do or always watch for:

```markdown
## Security

- Never commit .env files or API keys
- Sanitize all user input before database queries
- Use parameterized queries, never string concatenation for SQL
```

### 7. Architecture notes

Only what requires reading multiple files to understand — not file listings that can be discovered by browsing.

## Monorepo Pattern

For monorepos, place nested AGENTS.md files in subproject directories. **The closest AGENTS.md to the edited file takes precedence.**

```
repo/
├── AGENTS.md              ← Root-level defaults
├── packages/
│   ├── api/
│   │   └── AGENTS.md      ← API-specific overrides
│   └── frontend/
│       └── AGENTS.md      ← Frontend-specific overrides
```

Example: OpenAI's Codex repository contains 88 AGENTS.md files.

## Anti-patterns to avoid

- **Repeating the README** — agents can already read it
- **Listing every file/directory** — agents can discover structure by browsing
- **Generic advice** ("write clean code", "add tests") — only include project-specific conventions
- **Documenting obvious things** — agents know how to use git, npm, etc.
- **Making it too long** — aim for what a teammate needs in the first week, not an encyclopedia

## Compatibility

### Claude Code

Reads `CLAUDE.md` natively. Use a symlink for dual compatibility:

```bash
# Create AGENTS.md as the source, symlink CLAUDE.md
ln -s AGENTS.md CLAUDE.md
```

### Aider

Add to `.aider.conf.yml`:

```yaml
read: AGENTS.md
```

### Gemini CLI

Add to `.gemini/settings.json`:

```json
{ "contextFileName": "AGENTS.md" }
```

### Other tools

Cursor, Windsurf, Copilot, Codex, and most modern AI coding tools read AGENTS.md automatically.

## Conflict resolution

- **Nested files win** over parent files (closest to edited file takes precedence)
- **Explicit user prompts** override AGENTS.md instructions
- **Tool-specific files** (like `.cursorrules`) may coexist but AGENTS.md is the universal standard

## Real-world examples

| Project | Language | Size |
|---------|----------|------|
| [openai/codex](https://github.com/openai/codex) | Rust | 360+ contributors |
| [apache/airflow](https://github.com/apache/airflow) | Python | 4100+ contributors |
| [temporalio/sdk-java](https://github.com/temporalio/sdk-java) | Java | 120+ contributors |

## Source

Official specification: [https://agents.md](https://agents.md/)
