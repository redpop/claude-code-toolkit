# Tailwind CSS Patterns & Best Practices

## Installation Patterns

### Vite Setup

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

```javascript
// tailwind.config.js
/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

```css
/* src/index.css */
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### Next.js Setup

```bash
npm install -D tailwindcss postcss autoprefixer
npx tailwindcss init -p
```

```javascript
// tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{js,ts,jsx,tsx,mdx}",
    "./pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

## Component Patterns

### Button Component

```jsx
// Using clsx for dynamic classes
import clsx from 'clsx'

export function Button({ variant = 'primary', size = 'md', children, ...props }) {
  return (
    <button
      className={clsx(
        'inline-flex items-center justify-center font-medium transition-colors',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-offset-2',
        'disabled:pointer-events-none disabled:opacity-50',
        {
          'bg-blue-600 text-white hover:bg-blue-700 focus-visible:ring-blue-600':
            variant === 'primary',
          'bg-gray-100 text-gray-900 hover:bg-gray-200 focus-visible:ring-gray-500':
            variant === 'secondary',
          'border border-gray-300 bg-transparent hover:bg-gray-50':
            variant === 'outline',
        },
        {
          'h-9 px-3 text-sm': size === 'sm',
          'h-10 px-4 text-sm': size === 'md',
          'h-11 px-8 text-base': size === 'lg',
        }
      )}
      {...props}
    >
      {children}
    </button>
  )
}
```

### Card Component

```jsx
export function Card({ children, className = '' }) {
  return (
    <div className={`rounded-lg border bg-white p-6 shadow-sm ${className}`}>
      {children}
    </div>
  )
}
```

## Design System Patterns

### Color Palette Configuration

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        brand: {
          50: '#eff6ff',
          100: '#dbeafe',
          200: '#bfdbfe',
          300: '#93c5fd',
          400: '#60a5fa',
          500: '#3b82f6',
          600: '#2563eb',
          700: '#1d4ed8',
          800: '#1e40af',
          900: '#1e3a8a',
        },
      },
    },
  },
}
```

### Typography Scale

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      fontSize: {
        'xs': ['0.75rem', { lineHeight: '1rem' }],
        'sm': ['0.875rem', { lineHeight: '1.25rem' }],
        'base': ['1rem', { lineHeight: '1.5rem' }],
        'lg': ['1.125rem', { lineHeight: '1.75rem' }],
        'xl': ['1.25rem', { lineHeight: '1.75rem' }],
        '2xl': ['1.5rem', { lineHeight: '2rem' }],
        '3xl': ['1.875rem', { lineHeight: '2.25rem' }],
        '4xl': ['2.25rem', { lineHeight: '2.5rem' }],
        '5xl': ['3rem', { lineHeight: '1' }],
      },
    },
  },
}
```

## Dark Mode Patterns

### Class-Based Dark Mode

```javascript
// tailwind.config.js
module.exports = {
  darkMode: 'class',
  // ...
}
```

```jsx
// Component with dark mode support
export function Card() {
  return (
    <div className="bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100">
      <h2 className="text-xl font-bold text-gray-900 dark:text-white">
        Title
      </h2>
      <p className="text-gray-600 dark:text-gray-400">
        Description text
      </p>
    </div>
  )
}
```

### Dark Mode Toggle Implementation

```jsx
import { useState, useEffect } from 'react'

export function DarkModeToggle() {
  const [darkMode, setDarkMode] = useState(false)

  useEffect(() => {
    if (darkMode) {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
  }, [darkMode])

  return (
    <button
      onClick={() => setDarkMode(!darkMode)}
      className="p-2 rounded-lg bg-gray-200 dark:bg-gray-700"
    >
      {darkMode ? '🌞' : '🌙'}
    </button>
  )
}
```

## Performance Patterns

### Content Configuration

```javascript
// tailwind.config.js - Optimal content configuration
module.exports = {
  content: [
    './src/**/*.{js,jsx,ts,tsx}',
    './public/index.html',
    // Be specific to avoid scanning unnecessary files
  ],
  // ...
}
```

### Dynamic Class Names

```javascript
// ❌ Avoid - Classes won't be detected
const getButtonClass = (color) => `bg-${color}-500`

// ✅ Correct - Use complete class names
const getButtonClass = (color) => {
  const classes = {
    red: 'bg-red-500',
    blue: 'bg-blue-500',
    green: 'bg-green-500',
  }
  return classes[color]
}
```

## Plugin Patterns

### Typography Plugin

```bash
npm install -D @tailwindcss/typography
```

```javascript
// tailwind.config.js
module.exports = {
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
```

```jsx
// Usage
<article className="prose lg:prose-xl">
  <h1>Article Title</h1>
  <p>Article content with automatic typography styles...</p>
</article>
```

### Forms Plugin

```bash
npm install -D @tailwindcss/forms
```

```javascript
// tailwind.config.js
module.exports = {
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
```

## Tooling Integration

### Prettier Configuration

```bash
npm install -D prettier prettier-plugin-tailwindcss
```

```json
// .prettierrc
{
  "plugins": ["prettier-plugin-tailwindcss"],
  "tailwindConfig": "./tailwind.config.js"
}
```

### ESLint Configuration

```bash
npm install -D eslint-plugin-tailwindcss
```

```javascript
// .eslintrc.js
module.exports = {
  extends: ['plugin:tailwindcss/recommended'],
  rules: {
    'tailwindcss/no-custom-classname': 'warn',
    'tailwindcss/classnames-order': 'warn',
  },
}
```

### VS Code Settings

```json
// .vscode/settings.json
{
  "tailwindCSS.experimental.classRegex": [
    ["clsx\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"],
    ["cn\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"]
  ],
  "tailwindCSS.includeLanguages": {
    "typescript": "javascript",
    "typescriptreact": "javascript"
  },
  "editor.quickSuggestions": {
    "strings": true
  }
}
```

## Responsive Design Patterns

### Mobile-First Approach

```jsx
// Start with mobile styles, add breakpoints for larger screens
<div className="text-sm md:text-base lg:text-lg xl:text-xl">
  <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
    {/* Content */}
  </div>
</div>
```

### Container Queries

```bash
npm install -D @tailwindcss/container-queries
```

```javascript
// tailwind.config.js
module.exports = {
  plugins: [
    require('@tailwindcss/container-queries'),
  ],
}
```

```jsx
// Usage
<div className="@container">
  <div className="@lg:grid-cols-2 @xl:grid-cols-3">
    {/* Responsive based on container size, not viewport */}
  </div>
</div>
```

## Animation Patterns

### Built-in Animations

```jsx
// Spin animation
<div className="animate-spin">Loading...</div>

// Pulse animation
<div className="animate-pulse bg-gray-200 h-4 w-48 rounded"></div>

// Bounce animation
<button className="animate-bounce">Click me!</button>
```

### Custom Animations

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      keyframes: {
        'fade-in': {
          '0%': { opacity: '0' },
          '100%': { opacity: '1' },
        },
        'slide-up': {
          '0%': { transform: 'translateY(100%)' },
          '100%': { transform: 'translateY(0)' },
        },
      },
      animation: {
        'fade-in': 'fade-in 0.5s ease-in-out',
        'slide-up': 'slide-up 0.3s ease-out',
      },
    },
  },
}
```

## Accessibility Patterns

### Focus States

```jsx
// Always include focus-visible states
<button className="focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-blue-500 focus-visible:ring-offset-2">
  Click me
</button>
```

### Screen Reader Utilities

```jsx
// Visually hidden but accessible to screen readers
<span className="sr-only">Loading...</span>

// Not accessible to screen readers
<div aria-hidden="true" className="decorative-element">
  🎨
</div>
```

### ARIA Patterns

```jsx
// Accessible modal
<div role="dialog" aria-modal="true" aria-labelledby="modal-title">
  <h2 id="modal-title" className="text-xl font-bold">
    Modal Title
  </h2>
  {/* Modal content */}
</div>
```

## Common Gotchas & Solutions

### Dynamic Classes Not Working

```javascript
// ❌ This won't work - Tailwind can't detect dynamic classes
const textColor = `text-${color}-500`

// ✅ Use complete class names
const textColors = {
  red: 'text-red-500',
  blue: 'text-blue-500',
}
const textColor = textColors[color]
```

### Arbitrary Values

```jsx
// When you need specific values not in the default scale
<div className="w-[137px] h-[421px] top-[117px]">
  {/* Custom positioned element */}
</div>
```

### Important Modifier

```jsx
// Force a utility to take precedence
<div className="!text-blue-500">
  This text will be blue regardless of other styles
</div>
```

## Migration from v3 to v4

### Key Changes

1. **New Config Format**: Updated configuration structure
2. **JIT by Default**: Just-In-Time compilation is now standard
3. **Improved Performance**: Faster builds and smaller output
4. **New Features**: Container queries, subgrid support

### Migration Steps

```bash
# Update Tailwind CSS
npm install -D tailwindcss@latest postcss@latest autoprefixer@latest

# Update plugins
npm install -D @tailwindcss/typography@latest @tailwindcss/forms@latest

# Review and update config
npx tailwindcss init -p
```

Remember: Always refer to the official Tailwind CSS documentation for the most up-to-date patterns and best practices.
