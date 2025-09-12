# Command Consolidation Mapping

## Ziel: 56 Commands → 12-15 Core Commands

### Konsolidierungs-Strategie

**Prinzipien:**

- **Ein Command pro Hauptfunktion** (Analyze, Fix, Make, etc.)
- **Smart Defaults** statt Parameter-Explosion
- **Auto-Export** für alle Commands
- **Next-Step Recommendations** am Command-Ende

## 📊 Command-Mapping Matrix

### 🔍 **ANALYZE** (konsolidiert alle scan:* commands)

| Alt (12 Commands) | Neu (1 Command) | Smart Default |
|-------------------|-----------------|---------------|
| `scan:deep` | `analyze full` | Comprehensive analysis, auto-export |
| `scan:quick` | `analyze quick` | Fast check, basic issues |
| `scan:security` | `analyze security` | Security-focused, OWASP checks |
| `scan:perf` | `analyze performance` | Performance bottlenecks |
| `scan:deps` | `analyze dependencies` | Dependency risks & licenses |
| `scan:tests` | `analyze tests` | Test coverage & quality |
| `scan:docs` | `analyze docs` | Documentation health |
| `scan:quality` | `analyze quality` | Code quality metrics |
| `scan:refactor` | `analyze refactor` | Refactoring opportunities |
| `scan:root-cause` | `analyze problem` | Deep problem analysis |
| `scan:explore` | `analyze codebase` | Structure exploration |
| `scan:map` | `analyze structure` | Codebase mapping |

**Command Signature:**

```bash
/prefix:analyze [type]     # type: full, quick, security, performance, etc.
```

### 🔧 **FIX** (konsolidiert alle fix:* commands)

| Alt (8 Commands) | Neu (1 Command) | Smart Default |
|------------------|-----------------|---------------|
| `fix:quick-wins` | `fix quick` | High-ROI, low-risk fixes |
| `fix:security` | `fix security` | Security vulnerabilities |
| `fix:performance` | `fix performance` | Performance optimizations |
| `fix:duplicates` | `fix duplicates` | Code duplication removal |
| `fix:documentation` | `fix docs` | Documentation fixes |
| `fix:shell` | `fix shell` | Shell script improvements |
| `fix:markdown` | `fix markdown` | Markdown formatting |
| `fix:lint` | `fix lint` | Linting errors |

**Command Signature:**

```bash
/prefix:fix [type]        # type: quick, security, performance, etc.
```

### 🏭 **MAKE** (konsolidiert alle gen:* commands)

| Alt (3 Commands) | Neu (1 Command) | Smart Default |
|------------------|-----------------|---------------|
| `gen:docs` | `make docs` | Generate documentation |
| `gen:tests` | `make tests` | Generate test files |
| `gen:format` | `make format` | Format/convert content |

**Command Signature:**

```bash
/prefix:make [what]       # what: docs, tests, format
```

### 🤖 **AUTO** (bleibt, aber vereinfacht)

| Alt (4 Commands) | Neu (2 Commands) | Smart Default |
|------------------|------------------|---------------|
| `auto:execute` | `auto execute` | Execute action plans |
| `auto:report` | `auto report` | Execution reports |
| `auto:monitor` | `auto monitor` | Continuous monitoring |
| `auto:sprint` | `auto sprint` | Quality improvement sprints |

**Command Signatures:**

```bash
/prefix:auto execute      # Execute plans, auto-track progress
/prefix:auto monitor      # Setup monitoring, smart scheduling
```

### 🌊 **FLOW** (vereinfacht zu WORK)

| Alt (5 Commands) | Neu (1 Command) | Smart Default |
|------------------|-----------------|---------------|
| `flow:smart` | `work smart` | Intelligent problem routing |
| `flow:review` | `work review` | Multi-perspective review |
| `flow:incident` | `work incident` | Incident response |
| `flow:refactor` | `work refactor` | Refactoring guidance |
| `flow:debug-mode` | `work debug` | Debug mode activation |

**Command Signature:**

```bash
/prefix:work [mode]       # mode: smart, review, incident, refactor, debug
```

### 🔒 **SECURE** (konsolidiert sec:* commands)

| Alt (3 Commands) | Neu (1 Command) | Smart Default |
|------------------|-----------------|---------------|
| `sec:audit` | `secure audit` | Security audit with export |
| `sec:baseline` | `secure baseline` | Security baseline setup |
| `sec:comply` | `secure comply` | Compliance checking |

**Command Signature:**

```bash
/prefix:secure [action]   # action: audit, baseline, comply
```

### 📚 **GIT** (bleibt, aber vereinfacht)

| Alt (4 Commands) | Neu (2 Commands) | Smart Default |
|------------------|------------------|---------------|
| `git:commit` | `git commit` | Smart commit with emojis |
| `git:commit-simple` | `git simple` | Simple commit, branch prefix |
| `git:review` | `git review` | Pre-commit review |
| `git:conflict-resolver` | `git conflicts` | Interactive conflict resolution |

**Command Signatures:**

```bash
/prefix:git commit        # Smart conventional commits
/prefix:git conflicts     # Interactive conflict resolver
```

### 🎨 **STYLE** (erweitert CSS commands)

| Alt (2 Commands) | Neu (1 Command) | Smart Default |
|------------------|-----------------|---------------|
| `css:tailwind-optimize` | `style optimize` | CSS/Tailwind optimization |
| `css:figma-to-styles` | `style convert` | Design-to-code conversion |

**Command Signature:**

```bash
/prefix:style [action]    # action: optimize, convert
```

### 🏛️ **TYPO3** (bleibt spezialisiert)

| Alt (5 Commands) | Neu (2 Commands) | Smart Default |
|------------------|------------------|---------------|
| `typo3:content-blocks` | `typo3 blocks` | Content Blocks v1.3 |
| `typo3:make-content-block` | | (merged with blocks) |
| `typo3:extension-kickstarter` | `typo3 extension` | Extension scaffolding |
| `typo3:fluid-components` | `typo3 components` | Fluid v4 components |
| `typo3:sitepackage` | `typo3 sitepackage` | v13.4 SitePackage |

**Command Signatures:**

```bash
/prefix:typo3 blocks      # Content Blocks creation
/prefix:typo3 extension   # Extension kickstarter  
/prefix:typo3 components  # Fluid components
/prefix:typo3 sitepackage # SitePackage setup
```

### 🎯 **TOOLKIT** (stark konsolidierte meta:* commands)

| Alt (16 Commands) | Neu (3 Commands) | Smart Default |
|-------------------|------------------|---------------|
| `meta:help` | `toolkit help` | Interactive help system |
| `meta:help-handler` | | (merged with help) |
| `meta:health` | `toolkit status` | Project health check |
| `meta:version` | | (merged with status) |
| `meta:chain` | `toolkit chain` | Command chaining |
| `meta:find-cmd` | | (merged with help) |
| `meta:export` | | (auto-export in all commands) |
| `meta:changelog` | | (moved to git category) |
| `meta:create` | | (advanced feature, separate tool) |
| `meta:handoff` | | (advanced feature, separate tool) |
| `meta:summary` | | (advanced feature, separate tool) |
| `meta:test-guide` | | (advanced feature, separate tool) |
| `meta:update-docs` | | (automated background task) |
| `meta:docs-sync` | | (automated background task) |
| `meta:analyze-toolkit` | | (developer-only, separate tool) |

**Command Signatures:**

```bash
/prefix:toolkit help      # Interactive help & command discovery
/prefix:toolkit status    # Health check, version info  
/prefix:toolkit chain     # Command chaining (advanced)
```

## 📈 Konsolidierungs-Ergebnisse

**Vor:** 56 Commands in 10 Kategorien  
**Nach:** 15 Commands in 9 Kategorien

| Kategorie | Alt | Neu | Reduktion |
|-----------|-----|-----|-----------|
| scan → analyze | 12 | 1 | -92% |
| fix | 8 | 1 | -88% |
| gen → make | 3 | 1 | -67% |
| auto | 4 | 2 | -50% |
| flow → work | 5 | 1 | -80% |
| sec → secure | 3 | 1 | -67% |
| git | 4 | 2 | -50% |
| css → style | 2 | 1 | -50% |
| typo3 | 5 | 4 | -20% |
| meta → toolkit | 16 | 3 | -81% |

**Gesamt: -73% Commands** (56 → 15)

## 🎯 Next-Step Integration

Jeder Command endet mit intelligenten Empfehlungen:

```bash
✅ Security analysis completed (8 critical, 12 high, 24 medium issues)

💡 Recommended next steps:
   /prefix:fix security     # Fix 8 critical security issues  
   /prefix:fix quick        # Apply 12 quick security wins
   /prefix:secure baseline  # Establish security baseline

   Or describe your goal: "I need to fix authentication issues"
```

## 🚀 Implementation Strategy

### Phase 1a: Quick Wins (heute)

**Aufgaben:**

1. **analyze** command (konsolidiert 12 scan commands)
2. **fix** command (konsolidiert 8 fix commands)
3. Test mit den wichtigsten Use-Cases

**🤖 AI Implementation Note:** Überlege bei dieser Phase, ob parallele Sub-Agents für folgende Tasks sinnvoll wären:

- Parallel: `analyze` und `fix` Command-Erstellung  
- Parallel: Testing verschiedener Use-Cases gleichzeitig

#### 📋 Phase 1a Checklist

- [ ] Command-Struktur für `analyze` definiert
- [ ] Alle 12 scan-Funktionalitäten in `analyze` integriert  
- [ ] Smart-Defaults implementiert (auto-export, intelligent routing)
- [ ] `commands/analyze.md` erstellt und getestet
- [ ] Command-Struktur für `fix` definiert
- [ ] Alle 8 fix-Funktionalitäten in `fix` integriert
- [ ] `commands/fix.md` erstellt und getestet
- [ ] Next-step recommendations in beide Commands eingebaut
- [ ] Core-Workflow getestet: `/prefix:analyze full` → `/prefix:fix quick`
- [ ] Token-Effizienz gemessen (alte vs. neue Commands)

### Phase 1b: Core Commands (morgen)  

**Aufgaben:**
4. **make**, **work**, **secure** commands
5. **git**, **style** command updates
6. **toolkit** command (meta consolidation)

**🤖 AI Implementation Note:** Überlege bei dieser Phase, ob parallele Sub-Agents sinnvoll wären:

- Parallel: `make`, `work`, `secure` Command-Erstellung (3 Agents)
- Parallel: `git` und `style` Updates gleichzeitig  
- Sequential: `toolkit` Command (komplex, braucht Fokus)

#### 📋 Phase 1b Checklist

- [ ] `commands/make.md` erstellt (konsolidiert 3 gen commands)
- [ ] `commands/work.md` erstellt (konsolidiert 5 flow commands)
- [ ] `commands/secure.md` erstellt (konsolidiert 3 sec commands)
- [ ] Git Commands aktualisiert: `commit`, `conflicts` (4→2)
- [ ] `commands/style.md` erstellt (konsolidiert 2 css commands)
- [ ] `commands/toolkit.md` erstellt (konsolidiert 16→3 meta functions)
- [ ] Alle neuen Commands mit Next-step recommendations
- [ ] Integration zwischen Commands getestet

### Phase 1c: Specialized (übermorgen)

**Aufgaben:**
7. **typo3** commands optimization
8. **auto** commands simplification
9. Final integration tests

**🤖 AI Implementation Note:** Für diese finale Phase überlege Sub-Agent Parallelisierung:

- Parallel: TYPO3 Commands Optimization (spezialisierter TYPO3-Agent)
- Parallel: Auto Commands Simplification (workflow-optimizer Agent)  
- Sequential: Integration Tests (erfordert vollständiges System)

#### 📋 Phase 1c Checklist  

- [ ] TYPO3 Commands optimiert (5→4): `blocks`, `extension`, `components`, `sitepackage`
- [ ] Auto Commands vereinfacht (4→2): `execute`, `monitor`
- [ ] Alle alten Command-Dateien als deprecated markiert
- [ ] Full Integration Tests für alle Workflows
- [ ] Performance Benchmarks erstellt  
- [ ] Migration-Dokumentation aktualisiert

## Zugehörige Planungsdokumente

- **[COMMAND-EVALUATION-PLAN.md](COMMAND-EVALUATION-PLAN.md)** - Übergeordneter Plan mit 4 Phasen, AI-Effizienz Optimierung und Review-Checkpoints
- Beide Dokumente bilden zusammen den kompletten Transformation-Plan für das Claude Code Toolkit

---

## Development Information

**Git Branch:** `feature/command-consolidation-2025`  
**Status:** Ready for Implementation  
**Current Phase:** Phase 1a - Quick Wins  
**Next:** Create first consolidated command (analyze)  
**Siehe auch:** COMMAND-EVALUATION-PLAN.md für vollständige Phasen-Übersicht
