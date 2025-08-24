---
description: Convert Figma designs to modular CSS architecture with responsive breakpoints
argument-hint: "component-name [--css|--tailwind|--scss]"
---

# Figma to Styles Command

Generates precise CSS/Tailwind/SCSS implementations from Figma designs using MCP integration.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":

Display this command's documentation:

- **Description**: [Show frontmatter description field]
- **Usage**: [Show frontmatter argument-hint field]
- **Options**: [Show frontmatter options if present]
- **Examples**: [Show frontmatter examples if present]

Then exit without executing the main command.

---

## Primary Usage - Figma Integration

```bash
# Select element in Figma, then run:
/prefix:css:figma-to-styles button-primary --tailwind
/prefix:css:figma-to-styles navigation-header --scss
/prefix:css:figma-to-styles product-card --css
```

**Requires**:

- Figma Desktop App with element selected
- MCP Figma Dev Mode server configured

## Alternative Mode - Manual Specs

If Figma MCP is not available, you can provide specifications manually:

```bash
/prefix:css:figma-to-styles button "primary button with blue background #007AFF, white text, 16px padding, 8px border-radius"
```

## Core Principles

**CRITICAL**:

- **Implement exactly what is specified** - Do NOT add extra styles, effects, or enhancements
- **Ask before assuming** - Always ask about unclear requirements or responsive variants
- **Use exact values** - When specific values are given, use them precisely
- **No creative additions** - Don't add hover states, transitions, or other effects unless explicitly requested

## Workflow

### Step 1: Check Figma Connection

1. **Try to connect to Figma MCP server**
2. **Check if element is selected in Figma**
3. **If no connection**: Fall back to manual mode (ask for specs)

### Step 2: Determine Output Format

If no format flag provided:

1. **Check project for existing patterns**:
   - Look for Tailwind configuration files
   - Check for SCSS/Sass usage
   - Identify CSS methodology (vanilla CSS, CSS Modules, CSS-in-JS)

2. **Ask user if unclear**:

   ```text
   "I found [evidence of framework]. Should I generate:
   - Tailwind CSS classes
   - SCSS/Sass
   - Vanilla CSS
   - CSS Modules
   - Other?"
   ```

### Step 3: Extract Design Information

#### Primary: From Figma (if connected)

Use MCP Figma tools to extract:

- `mcp__figma-dev-mode-mcp-server__get_code` for component structure
- `mcp__figma-dev-mode-mcp-server__get_image` for visual reference
- `mcp__figma-dev-mode-mcp-server__get_variable_defs` for design tokens

Ask about variants:

```text
"I see the [component] design. Are there:
- Responsive variants (mobile, tablet, desktop)?
- State variants (hover, active, disabled)?
- Theme variants (light/dark)?
Please select them in Figma if you want them included."
```

#### Fallback: Manual specification

If Figma not available, ask for specifications:

```text
"Figma connection not available. Please provide design specs:
- Colors (background, text, borders)
- Spacing (padding, margin)
- Typography (font-size, weight)
- Dimensions (width, height)
- Other properties?"
```

### Step 4: Extract Design Values

Extract design values based on input:

- Typography (font-size, line-height, font-weight, font-family)
- Spacing (padding, margin, gap values)
- Colors (hex/rgb values)
- Layout (dimensions, flex/grid properties)
- Borders (width, style, color)
- Shadows (if specified)

**DO NOT ADD unless requested**:

- Hover effects not specified
- Transitions/animations
- Focus states
- Additional spacing
- Color variations

### Step 5: Generate Implementation

Based on the chosen format:

#### For Tailwind CSS

```html
<!-- ONLY classes that match Figma values -->
<div class="text-[14px] leading-[20px] text-[#333333] p-[16px]">
  <!-- Use exact arbitrary values when needed -->
</div>
```

#### For SCSS/Sass

```scss
.component {
  // Only properties from Figma
  font-size: 14px;  // Exact from Figma
  line-height: 20px; // Exact from Figma
  color: #333333;    // Exact from Figma
  padding: 16px;     // Exact from Figma
}
```

#### For Vanilla CSS

```css
.component {
  /* Only properties visible in Figma */
  font-size: 14px;
  line-height: 20px;
  color: #333333;
  padding: 16px;
}
```

### Step 6: Handle Responsive Design

If responsive variants are mentioned or needed:

1. **Ask about breakpoints**:

   ```text
   "Should I include responsive styles for:
   - Mobile (< 768px)
   - Tablet (768px - 1024px)
   - Desktop (> 1024px)
   - Custom breakpoints?"
   ```

2. **Get specifications per breakpoint**
3. **Generate responsive code** with appropriate media queries

### Step 7: Final Review

Present the implementation:

```text
"Generated [component-name] styles with:
[list of implemented properties]

Ready to create the file or would you like adjustments?"
```

## Agent Integration

This command would utilize these agents through Task Tool:

1. **frontend-specialist**: For understanding CSS/Tailwind/SCSS best practices and generating clean code
2. **code-architect**: For analyzing existing project CSS architecture and determining integration approach
3. **general-purpose**: For file operations and project structure analysis

Example agent invocation:

```markdown
Use Task tool with subagent_type="frontend-specialist":
"Extract exact Figma design values and generate [Tailwind/CSS/SCSS] implementation. 
CRITICAL: Only implement what is visible in Figma. Do not add any extra styles, effects, or enhancements.
Design values: [extracted values]
Target format: [CSS/Tailwind/SCSS]"
```

## Usage Examples

```bash
# Primary usage - from Figma
/prefix:css:figma-to-styles button-primary
/prefix:css:figma-to-styles navigation-header --tailwind
/prefix:css:figma-to-styles product-card --scss

# Fallback - manual specs (when Figma not available)
/prefix:css:figma-to-styles button "blue button with white text, 12px padding, 6px rounded corners"
/prefix:css:figma-to-styles card "product card with shadow, 16px padding, white background" --tailwind
```

## Prerequisites

**Primary (Figma mode)**:

- Figma Desktop App running
- Element selected in Figma
- MCP Figma Dev Mode server configured

**Fallback (manual mode)**:

- Design specifications ready
- Clear understanding of required styles

## Output

The command will:

1. Connect to Figma and extract exact design values
2. Or ask for manual specs if Figma unavailable
3. Generate clean, maintainable CSS/Tailwind/SCSS
4. Create component files in appropriate location
5. Only implement what's in the design - no extras

## Best Practices

1. **Be specific** - Provide clear values when possible (e.g., "16px padding" not "some padding")
2. **Ask for clarification** - Command will ask about ambiguous requirements
3. **Specify format** - Use --css, --tailwind, or --scss flags to avoid prompts
4. **Include states** - Mention hover/focus states if needed
5. **Think responsive** - Specify mobile/tablet differences upfront

## Error Handling

- If description unclear: Ask for specific values
- If no format specified: Check project and ask
- If Figma not configured: Suggest using description mode
- If image unreadable: Ask for manual specs
- If conflicting requirements: Request clarification
