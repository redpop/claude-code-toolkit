---
description: Smart CSS and styling operations with Tailwind optimization and design-to-code conversion
argument-hint: [type] [target] [--help]
allowed-tools: Task, Read, Write, Bash(tailwind:*)
mcp-enhanced: mcp__figma__dev_mode
---

# Style - Smart CSS and Styling Operations

Intelligent styling command that automatically optimizes CSS, converts designs to code, and applies best practices. Zero configuration, maximum design fidelity.

## Help Check

If "$ARGUMENTS" contains "--help" or "-h":
Display command help and exit.

## Smart Styling Types

**Automatically detects project setup and applies optimal styling strategies with responsive design patterns.**

### Available Styling Types

- `optimize` - Tailwind CSS optimization and analysis (default)
- `convert` - Design-to-code conversion from Figma or specifications
- `tailwind` - Tailwind-specific optimization and migration
- `responsive` - Responsive design implementation
- `component` - Component styling generation
- `theme` - Theme and design system implementation
- `audit` - CSS performance and best practices audit

## Usage

```bash
# Smart defaults - optimize existing CSS/Tailwind setup
/prefix:style

# Specific styling operations
/prefix:style optimize                    # Tailwind optimization analysis
/prefix:style convert button-primary     # Convert Figma design to CSS
/prefix:style tailwind --v4-migration    # Tailwind v4 migration guide
/prefix:style responsive mobile-nav      # Responsive component implementation

# With output formats
/prefix:style convert card --tailwind    # Output as Tailwind classes
/prefix:style convert modal --scss       # Output as SCSS
/prefix:style optimize --export-json     # Export optimization report
```

## Execution

### Smart Routing Logic

**Parsing arguments**: "$ARGUMENTS"

**Step 1: Determine styling operation and target**

```bash
# Parse arguments
args=($ARGUMENTS)
style_operation="optimize"    # default to optimization
target_or_component=""
output_format="auto"         # auto-detect from project

# Extract operation type if provided
style_operations=("optimize" "convert" "tailwind" "responsive" "component" "theme" "audit")
if [[ " ${style_operations[@]} " =~ " ${args[0]} " ]]; then
    style_operation=${args[0]}
    target_or_component="${args[1]:-"."}"
    remaining_args="${args[@]:2}"
else
    target_or_component="${args[0]:-"."}"
    remaining_args="${args[@]:1}"
fi

# Detect output format preferences
if [[ "$remaining_args" == *"--tailwind"* ]]; then
    output_format="tailwind"
elif [[ "$remaining_args" == *"--scss"* ]]; then
    output_format="scss"
elif [[ "$remaining_args" == *"--css"* ]]; then
    output_format="css"
fi
```

**Step 2: Route to appropriate styling strategy**

Based on style_operation, execute optimal approach:

### CSS/Tailwind Optimization (Default)

**Target**: Analysis and optimization of `$target_or_component`
**Export**: Auto-generates `style-optimize-YYYYMMDD-HHMMSS.json` + `.md`

Use Task tool with subagent_type="tailwind-css-specialist":
"TAILWIND OPTIMIZATION ANALYSIS: Analyze CSS/Tailwind implementation in '$target_or_component'. Focus on: 1) Current version and configuration assessment, 2) Build tool setup (PostCSS, Vite, Webpack), 3) Content paths and purging configuration, 4) Plugin usage and custom utilities analysis, 5) Performance metrics (bundle size, unused utilities), 6) Tool integration (Prettier, ESLint, IntelliSense), 7) Accessibility compliance, 8) v4 migration opportunities. Provide optimization roadmap with specific actions and performance improvements."

### Design-to-Code Conversion

**Target**: Convert design for `$target_or_component`
**Export**: Auto-generates component files with styling

Use Task tool with subagent_type="frontend-specialist":
"DESIGN-TO-CODE CONVERSION: Convert design specifications for '$target_or_component' to $output_format code. Priority: 1) Check for Figma MCP connection and extract design tokens, 2) If unavailable, work with provided specifications, 3) Generate modular, responsive styling, 4) Apply exact measurements and specifications, 5) Create component architecture with proper CSS organization. Output format: $output_format. CRITICAL: Implement exactly as specified, no creative additions without request. Ask for clarification on unclear requirements."

### Tailwind-Specific Operations

**Target**: Tailwind analysis and migration for `$target_or_component`
**Export**: Auto-generates Tailwind optimization report and migration guide

Use Task tool with subagent_type="tailwind-css-specialist":
"TAILWIND SPECIALIST ANALYSIS: Deep Tailwind analysis for '$target_or_component'. Focus areas: 1) Version assessment and v4 migration readiness, 2) Configuration optimization (content paths, plugins, themes), 3) Build integration improvements, 4) Custom utility patterns and component extraction, 5) Performance optimization (JIT compilation, purging), 6) Design system integration, 7) Tool ecosystem optimization. Generate specific migration steps for v4 if applicable."

### Responsive Design Implementation

**Target**: Responsive styling for `$target_or_component`
**Export**: Auto-generates responsive component implementation

Use Task tool with subagent_type="frontend-specialist":
"RESPONSIVE DESIGN IMPLEMENTATION: Create responsive styling for '$target_or_component'. Process: 1) Analyze component requirements and breakpoint needs, 2) Design mobile-first approach with progressive enhancement, 3) Implement flexible layouts (Grid, Flexbox), 4) Apply responsive typography and spacing, 5) Optimize for touch interfaces and accessibility, 6) Test across common breakpoints. Output format: $output_format with responsive utilities and media queries."

### Component Styling Generation

**Target**: Styled component creation for `$target_or_component`
**Export**: Auto-generates component files with complete styling

Use Task tool with subagent_type="frontend-specialist":
"COMPONENT STYLING GENERATION: Create complete styled component for '$target_or_component'. Include: 1) Base component structure and styling, 2) Variant implementations (primary, secondary, sizes), 3) State management (hover, focus, active, disabled), 4) Accessibility features (ARIA, focus indicators), 5) Theme integration and CSS custom properties, 6) Documentation and usage examples. Output format: $output_format with component architecture."

### Theme and Design System Implementation

**Target**: Design system setup for `$target_or_component`
**Export**: Auto-generates theme configuration and design tokens

Use Task tool with subagent_type="frontend-specialist":
"DESIGN SYSTEM IMPLEMENTATION: Create design system foundation for '$target_or_component'. Build: 1) Design token architecture (colors, typography, spacing, shadows), 2) Component library structure, 3) Theme configuration and CSS custom properties, 4) Utility class generation, 5) Documentation and style guide, 6) Tool integration (Storybook, design tools). Focus on scalability and maintainability."

### CSS Performance and Best Practices Audit

**Target**: CSS audit and optimization for `$target_or_component`
**Export**: Auto-generates performance audit report with recommendations

Use Task tool with subagent_type="performance-optimizer":
"CSS PERFORMANCE AUDIT: Comprehensive CSS analysis for '$target_or_component'. Evaluate: 1) Bundle size and loading performance, 2) Critical CSS and render-blocking resources, 3) Unused CSS detection and removal strategies, 4) CSS architecture and organization, 5) Browser compatibility and fallbacks, 6) Accessibility compliance (color contrast, focus management), 7) Performance metrics and optimization opportunities. Provide actionable optimization roadmap."

## Design System Integration

### Figma Integration (via MCP)

When available, automatically extract:

- **Design Tokens**: Colors, typography, spacing, shadows
- **Component Specifications**: Exact measurements and properties
- **Responsive Breakpoints**: Mobile, tablet, desktop variants
- **Design System Patterns**: Consistent styling approaches

### Manual Specification Support

When Figma MCP unavailable:

- **Specification Parsing**: Extract styling requirements from descriptions
- **Best Practice Application**: Apply responsive design patterns
- **Component Architecture**: Create maintainable styling structure

## Output Formats

### Tailwind CSS

```html
<!-- Component with Tailwind utilities -->
<button class="bg-blue-500 hover:bg-blue-600 text-white font-medium py-2 px-4 rounded-lg transition-colors">
  Primary Button
</button>
```

### SCSS/CSS

```scss
// Component with SCSS modules
.button {
  @include button-base;
  
  &--primary {
    background-color: #007AFF;
    color: white;
    
    &:hover {
      background-color: #0056CC;
    }
  }
}
```

### CSS Custom Properties

```css
/* Design system approach */
.button {
  background: var(--color-primary);
  color: var(--color-on-primary);
  padding: var(--spacing-sm) var(--spacing-md);
  border-radius: var(--radius-md);
}
```

## Next Steps Recommendations

After styling operation completion, display context-aware recommendations:

```markdown
✅ [Styling Operation] completed successfully

🎨 **Components Created**: [List of generated components and files]
⚡ **Performance Impact**: [Bundle size, optimization improvements]
📱 **Responsive Support**: [Breakpoints and device coverage]

💡 **Recommended next steps:**
   /prefix:analyze quality      # Verify CSS quality and standards
   /prefix:make tests          # Generate component tests
   /prefix:work review         # Get design system review

   **Or describe your styling goal:** "I need to add dark mode support"
```

### Smart Next-Step Logic

Based on styling operation results:

- **Optimization completed** → Suggest `/prefix:analyze performance` for validation
- **Components created** → Suggest `/prefix:make tests` for component testing
- **Design system implemented** → Suggest `/prefix:work review` for team review
- **Performance audit done** → Suggest specific optimization implementations
- **Responsive design added** → Suggest cross-device testing

## Best Practices Enforcement

### Design Fidelity

- **Exact Implementation**: Use specified measurements and colors precisely
- **No Creative Additions**: Only implement what's explicitly requested
- **Responsive Considerations**: Mobile-first, progressive enhancement
- **Accessibility**: WCAG compliance, keyboard navigation, focus management

### Performance Optimization

- **Critical CSS**: Above-the-fold styling optimization
- **Unused Code Removal**: Eliminate redundant styles
- **Efficient Bundling**: Optimize build output and loading
- **Caching Strategies**: Leverage browser caching effectively

### Maintainability

- **Component Architecture**: Modular, reusable styling patterns
- **Design System Integration**: Consistent token usage
- **Documentation**: Clear usage examples and guidelines
- **Tool Integration**: Prettier, ESLint, IDE support

## Benefits

- **Design-to-Code Automation**: Automatically converts Figma designs to production CSS
- **Tailwind Specialization**: Expert Tailwind optimization and v4 migration guidance
- **Performance Focus**: Built-in performance auditing and optimization
- **Responsive Excellence**: Mobile-first, accessible responsive implementations
- **Design System Support**: Comprehensive theme and component system creation
- **One Interface**: Replaces multiple specialized CSS and design tools

*Consolidates: css:tailwind-optimize, css:figma-to-styles*
