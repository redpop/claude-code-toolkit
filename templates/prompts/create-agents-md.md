# Prompt: AGENTS.md für ein Projekt erstellen

> Wiederverwendbarer Prompt, um eine KI anzuweisen, eine AGENTS.md-Datei für ein beliebiges Projekt zu erstellen.
> Kopiere den Prompt-Block unten und passe die Platzhalter `[...]` an dein Projekt an.

---

## Prompt

```
Erstelle eine AGENTS.md-Datei für dieses Projekt. Die AGENTS.md ist eine standardisierte Konfigurationsdatei, die KI-Coding-Agenten (Claude Code, Cursor, GitHub Copilot, Windsurf, Codex, etc.) projektspezifische Anweisungen gibt — vergleichbar mit einer "README für KI-Agenten".

## Schritt 0: Projektkontext sammeln (CLAUDE.md als Vorlage)

Bevor du die AGENTS.md erstellst, brauchst du eine fundierte Analyse des Projekts.

**Falls KEINE CLAUDE.md (oder AGENTS.md) existiert:**
1. Führe den Claude Code `/init`-Befehl aus — dieser analysiert das gesamte Projekt automatisch und generiert eine CLAUDE.md mit den wichtigsten Projektinformationen (Tech Stack, Architektur, Commands, Conventions)
2. Falls du NICHT in Claude Code arbeitest: Analysiere das Projekt manuell — lies README.md, package.json, Dockerfile, Konfigurationsdateien, Verzeichnisstruktur und die wichtigsten Quelldateien, um ein gleichwertiges Verständnis aufzubauen
3. Verwende die erzeugte CLAUDE.md (bzw. deine manuelle Analyse) als Basis und Kontext für die AGENTS.md-Erstellung

**Falls bereits eine CLAUDE.md, .cursorrules oder ähnliche tool-spezifische Datei existiert:**
1. Verwende deren Inhalt als Basis — diese enthält bereits validierten Projektkontext
2. Überprüfe die Informationen auf Aktualität (veraltete Commands, umbenannte Verzeichnisse, etc.)

**In beiden Fällen — nach Erstellung der AGENTS.md:**
1. Benenne die CLAUDE.md in AGENTS.md um (bzw. erstelle AGENTS.md als kanonische Datei)
2. Erstelle einen Symlink: `ln -s AGENTS.md CLAUDE.md`
3. Füge den Symlink NICHT in .gitignore ein — er soll mitversioniert werden
4. Stelle sicher, dass CLAUDE.md NICHT mehr in .gitignore steht (falls sie dort war)
5. Prüfe, ob `.gitignore` einen Eintrag wie `CLAUDE.md` enthält, und entferne ihn

## Zielformat und Struktur

Die AGENTS.md soll folgende Abschnitte in dieser Reihenfolge enthalten:

### 1. Project Overview (3-5 Sätze)
- Was macht das Projekt?
- Welche Technologien werden verwendet? (als "Key Technologies:"-Zeile)
- Keine Marketing-Sprache, keine Historie — nur Fakten

### 2. Build / Lint / Test Commands
- Exakte, copy-paste-fähige Befehle für: Development, Build, Code Quality, Testing, Package Management
- Gruppiert nach Kategorie in einem einzigen Code-Block
- Falls Docker-Helper existieren: Diese bevorzugt auflisten
- Hinweis wenn spezielle Tools statt Standard-Tools verwendet werden (z.B. `dnpm` statt `npm`)

### 3. Architecture
**Directory Structure:**
- Bullet-Liste der Top-Level-Verzeichnisse mit 1-Zeilen-Beschreibungen
- Wichtige Unterverzeichnisse eingerückt auflisten

**Key Architectural Patterns:**
- State Management, Authentication Flow, Data Flow, API-Integration
- Jedes Pattern: 3-5 Bullet Points, keine Prosa-Absätze
- Verweise auf Dateipfade wo relevant

### 4. Important Conventions
Unterteilt in:
- **Code Style** — Sprache für Comments, Formatierung, HTML-Encoding
- **Server-Side** — Framework-Patterns, Module-System
- **Client-Side** — TypeScript-Strenge, State-Management, UI-Library
- **Docker / Workflow** — Spezielle Workflows, Helper-Scripts

### 5. Important Constraints (KRITISCHSTER Abschnitt)
Zwei explizite Listen:

**MUST:**
- Harte Anforderungen, die NIEMALS verletzt werden dürfen
- Plattform-Constraints, Security-Anforderungen
- Jeder Punkt: Eine Zeile mit Kontext warum ("— OS+ bricht ab bei 4xx/5xx")

**MUST NOT:**
- Explizit verbotene Aktionen
- Anti-Patterns die vermieden werden müssen
- Jeder Punkt: Eine Zeile mit Konsequenz

### 6. Development Modes (falls zutreffend)
- Als kompakte Tabelle: Mode | Command | Use Case | HMR | Weitere Spalten
- Verweis auf ausführliche Dokumentation

### 7. Testing
- Test-Struktur (Dateipfade, Naming-Conventions, Environments)
- Integrations-Test-Workflow als Code-Block

### 8. Environment
- URLs (Dev, Staging, Production)
- Environment Variables (wie werden sie verwaltet, KEINE Secrets!)

### 9. Common Tasks
- 2-4 häufige Entwicklungsaufgaben als nummerierte Schritt-für-Schritt-Anleitungen
- Jeder Schritt mit Dateipfad und konkreter Aktion

### 10. Common Pitfalls
- Nummerierte Liste bekannter Stolperfallen
- Format: **Fettgedruckter Name:** Erklärung — Lösung
- Nur Dinge auflisten, die eine KI nicht aus dem Code selbst ableiten kann

### 11. Task Completion Workflow
Standardisierte Post-Implementation-Checkliste:

1. **Validate** — Exakte Build-, Test- und Typecheck-Befehle des Projekts
2. **Format** — Exakte Lint/Format-Befehle des Projekts
3. **Simplify** — Code-Vereinfachung (Claude Code: `code-simplifier:code-simplifier` Agent; andere: manuell)
4. **Review** — CodeRabbit Review auf uncommitted changes, dann Issues fixen
   - Claude Code: `/global:review:coderabbit`
   - Andere: `coderabbit review --prompt-only --type uncommitted`
   - Hinweis: CodeRabbit-Ergebnisse kritisch bewerten — nicht alle Vorschläge sind korrekt
5. **Re-validate** — Alle Befehle aus Schritt 1 + 2 erneut ausführen

Hinweis: Schritte 3 und 5 für triviale Änderungen überspringen.

### 12. References
- Links zu tieferer Dokumentation als Markdown-Links mit Kurzbeschreibung
- Nur Dateien referenzieren, die tatsächlich existieren

## Stilrichtlinien

- **Zielgruppe: KI-Agenten, nicht Menschen** — Imperativ, direkt, keine Erklärungen
- **Englisch** — Die gesamte AGENTS.md in Englisch verfassen
- **Maximal 300 Zeilen** — Kürzer ist besser, Tiefe über Referenzen abbilden
- **Formatierung:** Bullet-Listen, Tabellen und Code-Blöcke statt Fließtext
- **Keine Duplikation mit README.md** — README ist für Menschen, AGENTS.md für Agenten
- **Keine Secrets** — Niemals Passwörter, API-Keys oder Tokens in der Datei
- **Tool-agnostisch** — "AI agents" statt "Claude" oder "Cursor" im Text
- **MUST/MUST NOT** statt "sollte" oder "empfohlen" für harte Regeln
- **Dateipfade immer relativ** zum Projekt-Root angeben

## Was NICHT in die AGENTS.md gehört

- Setup-Anleitung für neue Entwickler (→ README.md)
- Screenshots, Badges, Lizenz-Informationen (→ README.md)
- Historische Entscheidungen oder Architektur-Begründungen
- Vollständige API-Dokumentation (→ separate Docs, nur verlinken)
- Tool-spezifische Anweisungen (→ tool-spezifische Dateien)
- Code-Beispiele für Standard-Patterns (React, TypeScript, etc.)

## Hierarchische Platzierung (Monorepos)

Falls das Projekt ein Monorepo ist:
- Root-AGENTS.md: Projektweite Regeln, Build-Commands, Architektur-Übersicht
- Unterverzeichnis-AGENTS.md: Verzeichnis-spezifische Guidelines
- Nächste Datei hat Vorrang (nearest-file-wins)
- Unterverzeichnis-Dateien ergänzen die Root-Datei, wiederholen sie nicht

## Kompatibilität

AGENTS.md wird unterstützt von: OpenAI Codex, Google Jules, GitHub Copilot, Cursor, Windsurf, Warp, Zed, Aider, VS Code, Devin, Gemini CLI und 50+ weiteren Tools. Die Datei steht unter der Agentic AI Foundation (Linux Foundation).

Erstelle Symlinks für Abwärtskompatibilität:
- `CLAUDE.md → AGENTS.md` (Claude Code)
- `WARP.md → AGENTS.md` (Warp AI)
- `.cursorrules` bleibt separat (anderes Format)
```
