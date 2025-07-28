---
allowed-tools: Task, Read, Edit, MultiEdit, Grep, Bash(npm:*), Bash(yarn:*), Bash(git:*)
description: Fix security vulnerabilities identified in analysis reports with automated patches and safety checks
argument-hint: [report.json] [--severity=critical,high,medium] [--dry-run] [--interactive] [--owasp-top10]
---

# Fix Security Command

This command automatically fixes security vulnerabilities identified in code analysis reports. It applies secure coding patterns, adds validation, and implements security best practices.

## Usage Examples

```bash
# Fix all critical and high severity issues
/fix-security report.json --severity=critical,high

# Preview security fixes without applying
/fix-security report.json --dry-run

# Interactive mode - approve each fix
/fix-security report.json --interactive

# Focus on OWASP Top 10 vulnerabilities
/fix-security report.json --owasp-top10
```

## Security Fix Categories

### 1. Input Validation (A03:2021)
```javascript
// Before
app.post('/user', (req, res) => {
  const user = db.create(req.body);
});

// After
app.post('/user', (req, res) => {
  const { name, email } = req.body;
  
  // Add validation
  if (!name || typeof name !== 'string' || name.length > 100) {
    return res.status(400).json({ error: 'Invalid name' });
  }
  
  if (!email || !isValidEmail(email)) {
    return res.status(400).json({ error: 'Invalid email' });
  }
  
  const user = db.create({ name, email });
});
```

### 2. SQL Injection Prevention (A03:2021)
```javascript
// Before
db.query(`SELECT * FROM users WHERE id = ${userId}`);

// After
db.query('SELECT * FROM users WHERE id = ?', [userId]);
```

### 3. XSS Protection (A03:2021)
```javascript
// Before
element.innerHTML = userInput;

// After
element.textContent = userInput;
// OR
element.innerHTML = sanitizeHtml(userInput);
```

### 4. Authentication Checks (A01:2021)
```javascript
// Before
app.get('/admin', (req, res) => {
  res.render('admin');
});

// After
app.get('/admin', requireAuth, requireRole('admin'), (req, res) => {
  res.render('admin');
});
```

### 5. Secure Headers (A05:2021)
```javascript
// Add security headers
app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      scriptSrc: ["'self'", "'unsafe-inline'"],
    },
  },
  hsts: {
    maxAge: 31536000,
    includeSubDomains: true,
    preload: true,
  },
}));
```

## Workflow

### Phase 1: Security Analysis

1. **Load Security Findings**:
   - Parse report for security issues
   - Map to OWASP categories
   - Prioritize by severity

2. **Risk Assessment**:
   - Calculate exploitation probability
   - Assess business impact
   - Determine fix complexity

### Phase 2: Fix Generation

For each security issue:

1. **Identify Fix Pattern**:
   - Match vulnerability type
   - Select appropriate fix
   - Customize for context

2. **Generate Secure Code**:
   - Apply security patterns
   - Add necessary imports
   - Maintain functionality

3. **Add Security Tests**:
   ```javascript
   test('prevents SQL injection', () => {
     const maliciousInput = "'; DROP TABLE users; --";
     expect(() => queryUser(maliciousInput)).not.toThrow();
     expect(mockDb.query).toHaveBeenCalledWith(
       'SELECT * FROM users WHERE id = ?',
       [maliciousInput]
     );
   });
   ```

### Phase 3: Implementation

1. **Critical Fixes First**:
   - Remote code execution
   - SQL injection
   - Authentication bypass
   - Data exposure

2. **High Priority**:
   - XSS vulnerabilities
   - CSRF protection
   - Insecure deserialization
   - Missing authorization

3. **Medium Priority**:
   - Weak encryption
   - Information disclosure
   - Security misconfigurations
   - Outdated dependencies

### Phase 4: Verification

1. **Security Testing**:
   ```bash
   # Run security tests
   npm run test:security
   
   # Static analysis
   npm audit
   
   # Dependency check
   npm run check-vulnerabilities
   ```

2. **Manual Review**:
   - Verify fix effectiveness
   - Check for side effects
   - Ensure no functionality break

### Phase 5: Report

```markdown
## Security Fix Report

### Summary
- **Total Vulnerabilities**: 15
- **Fixed**: 12
- **Requires Manual Review**: 3

### Fixed Vulnerabilities
#### Critical (3)
1. ✅ SQL Injection in user search
2. ✅ Remote Code Execution in file upload
3. ✅ Authentication Bypass in admin panel

#### High (5)
1. ✅ XSS in comment system
2. ✅ CSRF token missing
3. ✅ Insecure Direct Object Reference
4. ✅ XML External Entity (XXE)
5. ✅ Server-Side Request Forgery

#### Medium (4)
1. ✅ Weak password requirements
2. ✅ Missing rate limiting
3. ✅ Insecure session management
4. ✅ Unvalidated redirects

### Manual Review Required
1. ⚠️ Complex authentication flow - needs architectural change
2. ⚠️ Legacy encryption - requires data migration
3. ⚠️ Third-party integration - needs vendor update

### Security Improvements
- OWASP Compliance: 65% → 92%
- Security Score: 72 → 95
- Critical Issues: 3 → 0
```

## Security Patterns Library

### Input Validation
```javascript
// Email validation
const isValidEmail = (email) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);

// Sanitize HTML
const sanitizeHtml = (input) => DOMPurify.sanitize(input);

// Validate numeric input
const isValidNumber = (num, min, max) => {
  const n = Number(num);
  return !isNaN(n) && n >= min && n <= max;
};
```

### Authentication Helpers
```javascript
// Middleware for auth check
const requireAuth = (req, res, next) => {
  if (!req.session?.userId) {
    return res.status(401).json({ error: 'Unauthorized' });
  }
  next();
};

// Role-based access
const requireRole = (role) => (req, res, next) => {
  if (!req.user?.roles?.includes(role)) {
    return res.status(403).json({ error: 'Forbidden' });
  }
  next();
};
```

### Secure Defaults
```javascript
// Secure cookie settings
app.use(session({
  secret: process.env.SESSION_SECRET,
  resave: false,
  saveUninitialized: false,
  cookie: {
    secure: true, // HTTPS only
    httpOnly: true, // No JS access
    sameSite: 'strict', // CSRF protection
    maxAge: 1000 * 60 * 60 * 24 // 24 hours
  }
}));
```

## Configuration

Default settings:
- Severity levels: critical, high
- OWASP Top 10: enabled
- Auto-fix confidence: 90%
- Test generation: enabled
- Backup before fix: enabled

## Best Practices

1. **Always Review Fixes**:
   - Security is critical
   - Context matters
   - Test thoroughly

2. **Defense in Depth**:
   - Multiple layers of security
   - Don't rely on single fix
   - Monitor after deployment

3. **Keep Updated**:
   - Update dependencies
   - Follow security advisories
   - Regular security scans

This command helps maintain a secure codebase by automatically applying security best practices and fixing common vulnerabilities.