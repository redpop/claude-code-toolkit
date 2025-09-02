# CLAUDE.md - Cipher Memory Integration Template

**Template for enabling Cipher memory integration in Claude Code projects.**

## Cipher Memory Integration - Active Usage Required

### CRITICAL: Memory Functions Must Be Used Actively

**Claude Code MUST actively use Cipher memory for this project**. This is NOT automatic - follow these explicit patterns:

#### 🔍 1. Before Starting Any Task

```
ALWAYS run: cipher_memory_search "search term related to current task"
```

**Purpose:**

- Search for similar problems solved before in this project
- Check for established patterns and conventions
- Review past architectural decisions and their reasoning
- Avoid reinventing solutions that already exist

**Example:**

```
cipher_memory_search "authentication implementation"
cipher_memory_search "API error handling patterns"
cipher_memory_search "database schema design"
```

#### 💾 2. After Completing Any Task

```
ALWAYS run: cipher_extract_and_operate_memory "clear description of what was implemented and the approach used"
```

**Purpose:**

- Store successful implementations for future reference
- Document problem-solving approaches that worked
- Build a knowledge base of project-specific patterns

**Example:**

```
cipher_extract_and_operate_memory "User authentication: Implemented JWT with refresh tokens using secure HTTP-only cookies, includes automatic token refresh in API client middleware"

cipher_extract_and_operate_memory "React form validation: Created reusable useFormValidation hook with Yup schemas, provides real-time validation and error messaging"
```

#### 🐛 3. After Debugging/Problem Solving

```
ALWAYS run: cipher_store_reasoning_memory "detailed debugging approach and final resolution"
```

**Purpose:**

- Store debugging strategies that successfully resolved issues
- Document root causes and their solutions
- Build troubleshooting knowledge for similar future issues

**Example:**

```
cipher_store_reasoning_memory "React hydration mismatch: Root cause was server-side date formatting differing from client. Resolved by using UTC timestamps and formatting on client-side only. Key lesson: always use consistent timezone handling."

cipher_store_reasoning_memory "Database migration failing: Issue was foreign key constraint during column type change. Solution: Drop constraints, modify column, re-add constraints in separate transactions."
```

#### 📈 4. Project Context Updates

```
Run: cipher_extract_and_operate_memory "project context or architectural decision"
```

**When to use:**

- Learning about project architecture decisions
- Discovering coding conventions and style preferences  
- Understanding technology stack choices and reasoning
- Documenting build/deployment patterns
- Recording testing strategies and approaches

## Project-Specific Configuration

### Tech Stack & Context

**[CUSTOMIZE THIS SECTION FOR YOUR PROJECT]**

```yaml
Framework: [React/Vue/Angular/Node.js/Django/etc.]
Language: [TypeScript/JavaScript/Python/Go/Rust/etc.]
Database: [PostgreSQL/MySQL/MongoDB/SQLite/etc.]
Build Tool: [Vite/Webpack/Next.js/Parcel/etc.]
Testing: [Jest/Vitest/Pytest/Cypress/Playwright/etc.]
Deployment: [Vercel/Netlify/Docker/AWS/etc.]
State Management: [Zustand/Redux/Context/Pinia/etc.]
Styling: [Tailwind/CSS Modules/Styled Components/etc.]
```

### Coding Conventions

**[CUSTOMIZE THIS SECTION FOR YOUR PROJECT]**

```yaml
Code Style: [Prettier + ESLint/Black + Ruff/Rustfmt/etc.]
File Structure: [components/, utils/, types/, lib/, etc.]
Naming Convention: [camelCase/kebab-case/snake_case/PascalCase]
Import Order: [External packages → Internal modules → Relative imports]
Component Pattern: [Functional/Class/Composition API/etc.]
Error Handling: [Try-catch/Result types/Error boundaries/etc.]
```

### Important Project Commands

**[CUSTOMIZE THIS SECTION FOR YOUR PROJECT]**

```bash
# Development
npm run dev        # Start development server
npm run build      # Build for production
npm run preview    # Preview production build

# Quality Assurance  
npm run test       # Run test suite
npm run test:watch # Run tests in watch mode
npm run lint       # Run ESLint
npm run typecheck  # TypeScript type checking
npm run format     # Run Prettier

# Database (if applicable)
npm run db:migrate    # Run database migrations
npm run db:seed      # Seed development data
npm run db:reset     # Reset database
```

### Memory Usage Examples for This Project

#### Architecture Decisions

```bash
# Example - customize for your project
cipher_extract_and_operate_memory "State management decision: Chose Zustand over Redux because project needs are simple and Zustand reduces boilerplate significantly. Global state only for user authentication and theme preferences."

cipher_extract_and_operate_memory "Database schema: Normalized design with separate user_profiles table instead of JSON column in users table. Improves query performance and maintains data integrity."
```

#### Code Patterns

```bash  
# Example - customize for your project
cipher_extract_and_operate_memory "API client pattern: All HTTP requests use a centralized apiClient with interceptors for authentication, error handling, and loading states. Includes automatic retry logic for failed requests."

cipher_extract_and_operate_memory "Component structure: Feature-based organization where each feature folder contains components/, hooks/, types/, and utils/ subdirectories. Promotes modularity and code discoverability."
```

#### Debugging Solutions

```bash
# Example - customize for your project  
cipher_store_reasoning_memory "Performance issue debugging: React components re-rendering unnecessarily. Root cause: Missing dependency array in useEffect. Solution: Added proper dependencies and used useCallback for function props. Performance improved by 60%."

cipher_store_reasoning_memory "Build failing on CI but working locally: Missing environment variables in GitHub Actions. Solution: Added all required vars to repository secrets and updated workflow file. Key: Always verify CI environment matches local development."
```

## Session Management for This Project

### Project Session Patterns

```bash
# Start new sessions for different work contexts
cipher session new "PROJECT_NAME-feature-auth"
cipher session new "PROJECT_NAME-bugfix-payment"  
cipher session new "PROJECT_NAME-refactor-api"
cipher session new "PROJECT_NAME-testing-setup"

# Switch between project contexts
cipher session switch "PROJECT_NAME-main"
cipher session list  # View all available sessions
```

### Session Naming Convention

- Format: `PROJECT_NAME-work_type-specific_area`
- Examples: `ecommerce-feature-checkout`, `blog-bugfix-authentication`, `dashboard-refactor-components`

## Expected Memory Behavior

### What Gets Stored Automatically

- ✅ Successful code implementations and their rationale
- ✅ Problem-solving approaches that worked
- ✅ Project-specific patterns and conventions
- ✅ Debugging solutions and root cause analysis
- ✅ Architecture decisions and trade-offs
- ✅ Performance optimization strategies
- ✅ Testing approaches and patterns

### What Gets Retrieved  

- 🔍 Similar problems solved before in this project
- 🔍 Established project patterns and conventions
- 🔍 Past debugging approaches for similar issues
- 🔍 Architecture context for new features
- 🔍 Performance lessons learned
- 🔍 Testing strategies that worked

## Critical Instructions for Claude Code

### Memory Usage Rules (MUST FOLLOW)

1. **🔍 NEVER skip memory searches** before implementing features
   - Search first, implement second
   - Build on existing solutions rather than starting from scratch

2. **💾 ALWAYS store successful solutions** immediately after completion
   - Document the approach, not just the code
   - Include reasoning behind technical decisions

3. **🔄 PROACTIVELY update project context** when learning new patterns
   - Store insights about the project as you discover them
   - Update architectural understanding as it evolves

4. **🎯 USE project-specific sessions** for better context isolation
   - Keep feature work separate from bugfix work
   - Maintain clear session boundaries

5. **🐛 STORE debugging approaches** that work for this specific codebase
   - Include both the problem and the complete solution path
   - Document debugging strategies for future reference

### Integration Verification

#### Test Cipher Integration

```bash
1. Run: cipher_memory_search "project setup"
2. Expected: Returns previously stored project context and patterns
3. If empty: Run /init to analyze codebase and populate initial memory
4. Verify: Memory functions are working correctly
```

#### Memory Bank Synchronization

```bash
# Keep documentation in sync with implementation
/update-memory-bank
# Ensures: CLAUDE.md ↔ Actual codebase consistency
```

## Installation Instructions

**This template is part of the Claude Code Toolkit. To use:**

1. **Install the toolkit** (if not already done):

   ```bash
   git clone <toolkit-repo>
   cd claude-code-toolkit  
   ./install.sh global --with-settings
   ```

2. **Setup Cipher in your project**:

   ```bash
   # Use the toolkit's Cipher setup command
   /global:cipher:setup-project
   
   # Or manually copy this template to your project as CLAUDE.md
   ```

3. **Customize the template**:
   - Replace all `[CUSTOMIZE THIS SECTION]` blocks
   - Update tech stack, conventions, and commands
   - Add project-specific memory examples

4. **Initialize memory**:

   ```bash
   # In your project with Claude Code:
   /init  # Analyze codebase and populate memory
   cipher_memory_search "project overview"  # Test memory
   ```

---

**🧠 This project uses Cipher for persistent memory across coding sessions.**  
**📀 Memory is stored centrally in PostgreSQL - no local database files are created.**  
**🔗 Cipher MCP integration provides intelligent, context-aware coding assistance.**
