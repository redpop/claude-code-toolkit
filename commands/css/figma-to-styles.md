---
description: Convert Figma designs to modular CSS architecture with responsive breakpoints
argument-hint: "component-name [--css|--tailwind|--scss]"
---

# Figma to Styles Command

Analyzes Figma designs and generates precise CSS/Tailwind/SCSS implementations based on exact design specifications.

## Core Principles

**CRITICAL**:

- **Only implement what is visible in Figma** - Do NOT add extra styles, effects, or enhancements
- **Ask before assuming** - Always ask about responsive variants if not specified
- **Exact values only** - Use precise values from Figma, never approximate or "improve"
- **No creative additions** - Strictly follow the design without adding hover states, transitions, or other effects unless explicitly shown in Figma

## Workflow

### Step 1: Determine Output Format

First, determine the styling approach:

1. **Check project for existing patterns**:
   - Look for Tailwind configuration files
   - Check for SCSS/Sass usage
   - Identify CSS methodology (vanilla CSS, CSS Modules, CSS-in-JS)

2. **Ask user if unclear**:

   ```
   "I found [evidence of framework]. Should I generate:
   - Tailwind CSS classes
   - SCSS/Sass
   - Vanilla CSS
   - CSS Modules
   - Other?"
   ```

### Step 2: Analyze Figma Design

1. Check if user has selected a Figma element
2. Use MCP Figma tools to extract design information:
   - `mcp__figma-dev-mode-mcp-server__get_code` for component structure
   - `mcp__figma-dev-mode-mcp-server__get_image` for visual reference
   - `mcp__figma-dev-mode-mcp-server__get_variable_defs` for design tokens

3. **Ask about variants**:

   ```
   "I see the [component] design. Are there:
   - Responsive variants (mobile, tablet, desktop)?
   - State variants (hover, active, disabled)?
   - Theme variants (light/dark)?
   Please select them in Figma if you want them included."
   ```

### Step 3: Extract EXACT Design Values

Extract ONLY what is defined in Figma:

- Typography (exact font-size, line-height, font-weight, font-family)
- Spacing (exact padding, margin, gap values)
- Colors (exact hex/rgb values)
- Layout (exact dimensions, flex/grid properties)
- Borders (exact width, style, color)
- Shadows (exact values if present)

**DO NOT ADD**:

- Hover effects not in Figma
- Transitions/animations not specified
- Focus states not designed
- Additional spacing for "better UX"
- Color variations not in the design

### Step 4: Generate Implementation

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

### Step 5: Handle Responsive Design

If responsive variants are provided:

1. **Request each breakpoint design**:

   ```
   "Please select the tablet version in Figma"
   "Please select the mobile version in Figma"
   ```

2. **Extract exact differences** per breakpoint
3. **Generate only the changes** that differ from base

### Step 6: Verification

Present the implementation and ask:

```
"This implementation includes ONLY what I found in the Figma design:
[list of implemented properties]

Not included (not found in design):
- Hover states
- Focus styles
- Transitions
- [other common properties]

Is this correct, or did I miss something in the Figma design?"
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
# Basic conversion with auto-detection
/prefix:css:figma-to-styles button

# Specify Tailwind output
/prefix:css:figma-to-styles card --tailwind

# Specify SCSS output
/prefix:css:figma-to-styles navigation --scss

# Vanilla CSS output
/prefix:css:figma-to-styles header --css
```

## Prerequisites

1. MCP Figma Dev Mode server must be configured
2. Figma element should be selected in Figma desktop app
3. Clear on output format (CSS/Tailwind/SCSS)

## Output

The command will:

1. Generate styles using ONLY Figma values
2. Ask about missing variants/states
3. Produce clean, maintainable code
4. Never add unrequested enhancements

## Best Practices

1. **Exact fidelity** - Never deviate from Figma values
2. **Ask, don't assume** - Query about responsive/state variants
3. **Document what's missing** - List what wasn't implemented
4. **Use design tokens** - When available in Figma
5. **Maintain simplicity** - Don't over-engineer

## Error Handling

- If no Figma element selected: "Please select an element in Figma first"
- If MCP tools unavailable: Provide manual extraction guidance
- If output format unclear: Ask user to specify
- If design values ambiguous: Ask for clarification
- If variants might exist: Prompt to check for them
