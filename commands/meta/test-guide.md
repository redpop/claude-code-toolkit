---
description: Generates interactive test guides for recent changes, suitable for both end-users and technical reviewers
argument-hint: [--type=all|user|technical] [--format=md|checklist] [--lang=en|de|es|fr] [--output[=file.md]]
---

# Claude Command: Test Guide

This command analyzes recent implementations and generates comprehensive test guides that help both end-users and technical reviewers validate changes effectively.

## Usage

```bash
/test-guide                           # Display test guide in chat only
/test-guide --output                  # Save with auto-generated filename
/test-guide --output=my-tests.md      # Save to specific file
/test-guide --type=user               # User-focused testing only
/test-guide --type=technical          # Developer-focused testing only
/test-guide --format=checklist        # Simple checklist format
/test-guide --lang=de                 # Generate guide in German
/test-guide --output --lang=de        # Save German guide with auto filename
```

## Output Location

The test guide output behavior:

1. **Default (no `--output`)**: Display only in Claude Code interface
2. **With `--output`**: Save to auto-generated filename: `test-guides/YYYY-MM-DD_HH-MM-SS_test-guide.md`
3. **With `--output=filename.md`**: Save to your specified file
4. **Format**: Always saves as .md file, `--format` only affects content style

### Auto-generated Filename Convention

When using `--output` without a filename:
- Pattern: `test-guides/YYYY-MM-DD_HH-MM-SS_test-guide[_lang].md`
- Directory `test-guides/` is created if needed
- Language suffix added if not English (e.g., `_de` for German)

Examples:

```bash
# Display only (default)
/test-guide

# Save with auto-generated name
/test-guide --output
# Creates: test-guides/2025-01-05_14-30-45_test-guide.md

# Save with auto name in German
/test-guide --output --lang=de
# Creates: test-guides/2025-01-05_14-30-45_test-guide_de.md

# Save to specific file
/test-guide --output=my-custom-tests.md

# Checklist format with auto-save
/test-guide --format=checklist --output
# Creates: test-guides/2025-01-05_14-30-45_test-guide.md (with checklist content)
```

## What This Command Does

1. **Analyzes Recent Changes**: Reviews chat history, commits, or modified files
2. **Identifies Test Points**: Extracts what needs testing and potential edge cases
3. **Generates Adaptive Guides**: Creates instructions based on project type (Frontend/Backend/CLI)
4. **Combines Perspectives**: Integrates user-friendly steps with technical validation
5. **Includes DevTools Instructions**: Explains browser developer tools for all testers

## Output Format

The generated test guide includes:

### 1. Change Summary

- What was implemented/changed
- Why it matters
- Impact on users/system

### 2. Test Steps for Everyone

- Clear, numbered instructions
- Expected results at each step
- Visual indicators where applicable
- Browser DevTools tips (explained simply)

### 3. Technical Validation (Embedded)

- Console checks
- Network monitoring
- Performance considerations
- Log verification

### 4. Edge Cases & Scenarios

- Common failure points
- Boundary conditions
- Error handling tests

### 5. Bug Reporting Template

- What information to collect
- How to document issues
- Where to report

## Language Support

The command supports multiple languages for international teams:

```bash
/test-guide --lang=en    # English (default)
/test-guide --lang=de    # German / Deutsch
/test-guide --lang=es    # Spanish / Español
/test-guide --lang=fr    # French / Français
/test-guide --lang=ja    # Japanese / 日本語
/test-guide --lang=zh    # Chinese / 中文
```

## Example Output (English)

```markdown
# Test Guide: User Authentication Update

## What Changed?

Enhanced login system with 2FA support and improved error messages.

## Test Instructions

### 1. Basic Login Flow

**For All Testers:**

1. Navigate to login page
2. Enter username: `testuser`
3. Enter password: `testpass123`
4. Click "Login"

**Expected Result:**

- Redirected to dashboard
- Welcome message shows username

**Technical Check (Press F12):**

- Console tab: No red errors
- Network tab: `/api/login` returns 200 status
- Application tab → Cookies: `auth-token` is set
```

## Example Output (German / Deutsch)

```markdown
# Testanleitung: Benutzer-Authentifizierung Update

## Was wurde geändert?

Verbessertes Login-System mit 2FA-Unterstützung und besseren Fehlermeldungen.

## Testanweisungen

### 1. Basis Login-Ablauf

**Für alle Tester:**

1. Navigieren Sie zur Login-Seite
2. Benutzername eingeben: `testuser`
3. Passwort eingeben: `testpass123`
4. Auf "Anmelden" klicken

**Erwartetes Ergebnis:**

- Weiterleitung zum Dashboard
- Willkommensnachricht zeigt Benutzernamen

**Technische Prüfung (Drücken Sie F12):**

- Konsole-Tab: Keine roten Fehler
- Netzwerk-Tab: `/api/login` gibt Status 200 zurück
- Anwendung-Tab → Cookies: `auth-token` ist gesetzt

### 2. Zwei-Faktor-Authentifizierung

**Testkonto einrichten:**

1. Mit Testdaten anmelden
2. Zu Einstellungen → Sicherheit navigieren
3. "2FA aktivieren" anklicken

**Browser-Tipp:**
Öffnen Sie die Konsole (F12) und geben Sie ein: `localStorage.getItem('2fa-setup')`
Sollte zurückgeben: `"pending"`

## Schnelle Checkliste

- [ ] Anmeldung mit gültigen Daten funktioniert
- [ ] Ungültige Anmeldung zeigt Fehlermeldung
- [ ] 2FA-Einrichtung erfolgreich abgeschlossen
- [ ] Sitzung bleibt nach Browser-Aktualisierung bestehen
- [ ] Abmeldung löscht alle Token (prüfen in DevTools → Anwendung)
```

## Adaptations by Project Type

### Frontend Projects

- Focus on UI interactions and visual feedback
- Browser DevTools prominently featured
- Screenshots/visual markers encouraged
- Accessibility checks included

### Backend/API Projects

- Terminal commands for testing endpoints
- Log file locations and grep commands
- Response validation with curl examples
- Database state verification

### CLI Tools

- Command syntax examples
- Output format validation
- Error message testing
- Pipeline integration checks

## Intelligence Features

1. **Auto-Detection**:

   - Identifies project type from file changes
   - Detects complexity level of changes
   - Determines appropriate test depth

2. **Contextual Guidance**:

   - Adjusts language based on technical indicators
   - Includes relevant tools (browser, terminal, etc.)
   - Suggests appropriate test data

3. **Progressive Disclosure**:
   - Basic steps for all users
   - Technical details in collapsible sections
   - Advanced scenarios clearly marked

## Browser DevTools Education

The command includes gentle introduction to browser tools:

```markdown
### Using Browser Developer Tools (For Everyone!)

**Opening DevTools:**

- Chrome/Edge: Press F12 or right-click → "Inspect"
- Firefox: Press F12 or right-click → "Inspect Element"
- Safari: Enable in Preferences → Advanced → Show Develop menu

**Useful Tabs for Testing:**

1. **Console**: Shows errors (red text = problem)
2. **Network**: Shows all requests (red = failed)
3. **Application/Storage**: Shows saved data

Don't worry if it looks complex - focus on red text (errors)!
```

## Best Practices

1. **Clear Language**: Technical terms explained when first used
2. **Visual Guides**: Use emoji indicators (✓ ✗ ⚠️) for clarity
3. **Realistic Scenarios**: Test with actual use cases
4. **Incremental Complexity**: Start simple, build up
5. **Actionable Results**: Clear pass/fail criteria

## Integration with Other Commands

Works well with:

- `/meta:summary` - Reference recent implementations
- `/scan:quality` - Identify areas needing testing
- `/flow:review` - Generate test guides for review process

## Command Arguments

- `$ARGUMENTS`: Optional parameters
  - `--feature`: Target specific feature for testing
  - `--type`: Focus on user, technical, or all (default: all)
  - `--format`: Output style - markdown or checklist (default: markdown)
  - `--lang`: Language for output (en, de, es, fr, ja, zh) - default: en
  - `--output`: Save to file. Without value: auto-generated name. With value: specific file

## Implementation Notes

- Analyzes last significant changes in project
- Generates appropriate test scenarios
- Balances thoroughness with practicality
- Educates while guiding
- Makes technical testing accessible
