# Project Context für TYPO3 Content Blocks

## Project Specifics (Cannot be discovered by AI)

```yaml
# Copy this template to your project and customize:

vendor: "mycompany"              # Your vendor prefix for Content Blocks
extension_path: "packages/sitepackage"  # Path to your main extension
extension_key: "sitepackage"     # Extension key used in composer.json
css_framework: "tailwind"       # tailwind|bootstrap|none|custom
code_style: "minimal"           # minimal|feature-rich
naming_pattern: "bem"           # bem|utility-first|custom
```

---

## AI Discovery Workflow

**BEFORE creating any Content Block, AI must:**

### 1. Scan Existing Structure

```bash
# Check for existing Content Blocks
find packages/sitepackage/ContentBlocks -name "*.yaml" -type f

# List current Content Blocks
ls packages/sitepackage/ContentBlocks/ContentElements/
```

### 2. Analyze Existing Patterns

```bash
# Check for shared components
ls packages/sitepackage/Resources/Private/Partials/Components/

# Look at existing templates
find packages/sitepackage/Resources/Private/Templates -name "*.html"

# Check CSS classes usage
grep -r "class=" packages/sitepackage/Resources/Private/Templates/ | head -10
```

### 3. Discovery Questions for User

If project context is unclear, ask:

- "Which CSS framework should I use?"
- "Should I reuse existing component X?"
- "Do you prefer minimal or feature-rich Content Blocks?"
- "What naming convention should I follow?"

---

## Development Rules

### ✅ DO

- **Reuse first**: Check existing components before creating new
- **Follow naming**: Use project's vendor prefix and naming pattern
- **Minimal approach**: Only essential fields, no unnecessary boilerplate
- **Consistent structure**: Follow existing Content Block patterns
- **Ask questions**: When project requirements unclear

### ❌ DON'T

- Create Content Blocks without scanning existing structure
- Duplicate functionality that already exists
- Add complex boilerplate without user request
- Use different naming conventions than project
- Make assumptions about CSS framework or styling

---

## Quick Reference Paths

```bash
# Content Blocks location
ContentBlocks/ContentElements/{block-name}/
├── config.yaml
├── templates/frontend.html
├── templates/backend-preview.html
└── assets/icon.svg

# Extension structure
packages/sitepackage/
├── ContentBlocks/          # Content Blocks definition
├── Resources/Private/
│   ├── Templates/          # Page templates
│   ├── Partials/Components/ # Shared components
│   └── Layouts/            # Base layouts
└── composer.json           # Extension metadata
```

### Essential Commands

```bash
# Clear caches after changes
vendor/bin/typo3 cache:flush

# Update database schema
vendor/bin/typo3 database:updateschema

# Check TYPO3 version
vendor/bin/typo3 --version
```

---

## Usage Instructions

### For Developers

1. Copy this template to your project root
2. Customize the "Project Specifics" section
3. Share with AI assistants working on the project

### For AI Assistants

1. **Always read this file first** before creating Content Blocks
2. **Execute discovery commands** to understand project structure
3. **Follow development rules** strictly
4. **Ask questions** when context is unclear
5. **Reference existing patterns** in your implementations

### Example AI Instruction

```
"I need a hero section Content Block. Use the project-setup-context.md to understand our project structure, scan for existing components, and create a minimal implementation following our conventions."
```
