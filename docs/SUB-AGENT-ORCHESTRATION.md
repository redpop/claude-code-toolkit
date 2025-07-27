# Sub-Agent Orchestration für Claude Code

## Übersicht

Dieses System nutzt Claude Code's Task Tool für massive Performance-Steigerungen durch intelligente Parallelisierung. Durch die gleichzeitige Ausführung mehrerer spezialisierter Sub-Agents können komplexe Analysen und Aufgaben 5-10x schneller erledigt werden als bei sequentieller Verarbeitung.

### Kernvorteile

- **5-10x Performance-Steigerung** bei parallelen Aufgaben
- **Token-effiziente Analyse** durch fokussierte Sub-Agents
- **Skalierbare Architektur** für komplexe Codebases
- **Wiederverwendbare Commands** global verfügbar
- **Best Practices** aus Production-Einsatz integriert

## Quick Start

### Installation

```bash
# Standard-Installation mit "global" Prefix
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/install.sh | bash -s -- global

# Custom Prefix
curl -fsSL https://raw.githubusercontent.com/redpop/claude-code-toolkit/main/install.sh | bash -s -- myprefix
```

### Erste Schritte

```bash
# Ultra-schnelle Code-Analyse (10 parallele Agents)
/global:orchestration:analyze-parallel src/

# Security Audit (8 spezialisierte Agents)
/global:orchestration:security-audit

# Test Coverage Analyse (5 Agents)
/global:orchestration:test-coverage
```

### Performance-Vergleich

| Task           | Sequential | Parallel | Speedup |
| -------------- | ---------- | -------- | ------- |
| Code Analysis  | 50-60s     | 5-8s     | ~10x    |
| Security Audit | 40-50s     | 5-7s     | ~8x     |
| Test Coverage  | 30-40s     | 4-6s     | ~7x     |
| Dependency Map | 45-55s     | 6-8s     | ~7x     |

## Architektur

### Task Tool als Orchestrator

Das Task Tool ist Claude Code's primärer Mechanismus für Sub-Agent Management:

```yaml
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(jq:*)
```

### Token-Budget Management

Optimale Token-Verteilung für maximale Effizienz:

- **Pro Agent**: 2000-4000 Tokens
- **Gesamt-Budget**: ~30000 Tokens für 10 Agents
- **Context Sharing**: Minimaler, fokussierter Context pro Agent
- **Output Format**: Strukturiert für einfache Synthesis

### Synthesis-Strategien

Nach Abschluss aller Sub-Agents werden die Ergebnisse intelligent zusammengeführt:

1. **Strukturierte Outputs** - JSON/Markdown für maschinelle Verarbeitung
2. **Deduplication** - Vermeidung redundanter Informationen
3. **Priorisierung** - Wichtigste Findings zuerst
4. **Cross-Reference** - Verbindungen zwischen Agent-Ergebnissen

## Command Reference

### Orchestration Commands

#### `/global:orchestration:analyze-parallel`

Ultra-schnelle Code-Analyse mit 10 spezialisierten Agents:

- Code Complexity Analysis
- Duplicate Code Detection
- Style Violations
- Documentation Coverage
- Dead Code Detection
- Type Safety Analysis
- Security Patterns
- Performance Profiling
- Test Quality
- Dependency Analysis

#### `/global:orchestration:security-audit`

Umfassender Security Scan mit 8 Agents:

- SQL Injection Detection
- XSS Vulnerability Scan
- Authentication Weaknesses
- Secret/Credential Exposure
- CORS Configuration
- Dependency CVEs
- CSRF Protection
- Information Disclosure

#### `/global:orchestration:refactor-impact`

Impact-Analyse für Refactoring mit 6 Agents:

- Breaking Changes Detection
- API Contract Changes
- Test Impact Analysis
- Documentation Updates
- Migration Path Planning
- Risk Assessment

#### `/global:orchestration:test-coverage`

Test-Analyse mit 5 Agents:

- Coverage Metrics
- Test Quality Assessment
- Missing Test Cases
- Test Performance
- Flaky Test Detection

#### `/global:orchestration:performance-scan`

Performance-Profiling mit 7 Agents:

- Algorithm Complexity
- Database Query Analysis
- Memory Usage Patterns
- CPU Hotspots
- I/O Bottlenecks
- Caching Opportunities
- Optimization Suggestions

### Research Commands

#### `/global:research:deep-dive`

Multi-Perspective Research mit 8 verschiedenen Blickwinkeln auf ein Thema.

#### `/global:research:codebase-map`

Vollständige Codebase-Kartierung mit 10 Agents für unterschiedliche Aspekte.

#### `/global:research:dependency-trace`

Tiefgehende Dependency-Analyse mit 6 spezialisierten Agents.

## Best Practices

### Wann Sub-Agents verwenden

**IMMER verwenden für:**

- Multi-File Analysen
- Code Quality Checks
- Security Audits
- Test Coverage Analysis
- Documentation Tasks
- Performance Profiling
- Migration Planning
- Bug Investigation über mehrere Files
- Architecture Reviews
- Refactoring Impact Analysis

**VERMEIDEN für:**

- Single-File Edits
- Kleine, sequentielle Änderungen
- Direkte Code-Modifikationen
- Tasks mit starken Dependencies

### Task Decomposition Patterns

#### Pattern 1: Domain-basierte Aufteilung

```
Agent 1: Frontend Analysis
Agent 2: Backend Analysis
Agent 3: Database Layer
Agent 4: API Contracts
```

#### Pattern 2: Concern-basierte Aufteilung

```
Agent 1: Security Concerns
Agent 2: Performance Issues
Agent 3: Code Quality
Agent 4: Documentation
```

#### Pattern 3: File-basierte Aufteilung

```
Agent 1: Core Module Files
Agent 2: Test Files
Agent 3: Configuration
Agent 4: Documentation
```

### Performance-Optimierung

1. **Batch-Start**: Alle Agents in einem Tool-Call starten
2. **Klare Boundaries**: Keine Task-Überlappungen zwischen Agents
3. **Fokussierte Prompts**: Spezifische, klar abgegrenzte Aufgaben
4. **Strukturierter Output**: Einheitliches Format für Synthesis
5. **Early Termination**: Agents können bei Bedarf früh beenden

### Debugging Multi-Agent Workflows

Bei Problemen mit Sub-Agent Commands:

1. **Einzelne Agent-Outputs prüfen**: Jeder Agent gibt strukturiertes Feedback
2. **Token-Usage monitoren**: Überschreitung des Budgets vermeiden
3. **Task-Overlap identifizieren**: Redundante Arbeit minimieren
4. **Synthesis-Fehler debuggen**: Output-Format-Konsistenz sicherstellen

## Eigene Commands erstellen

### Mit Helper Script

```bash
# Einfaches Command erstellen
./scripts/create-sub-agent-command.sh \
  --name "dependency-audit" \
  --agents 6 \
  --category "orchestration"
```

### Manuell mit Templates

1. Template aus `commands/templates/` wählen
2. Anpassen für spezifischen Use Case
3. Agent-Aufgaben klar definieren
4. Performance-Ziele dokumentieren
5. Testen und iterieren

### Command-Struktur

```yaml
---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*)
description: Kurze Beschreibung für Command-Liste
argument-hint: [expected-arguments]
---

# Command Name

Detaillierte Beschreibung des Commands und seiner Funktion.

## Sub-Agent Strategie

**SOFORT [N] PARALLELE AGENTS STARTEN:**

1. **Agent Name**: Spezifische Aufgabe
2. **Agent Name**: Spezifische Aufgabe
...

**Erwartete Performance**: Xx schneller als sequentiell

## Synthesis

Nach Abschluss aller Agents:
- Wie werden Ergebnisse kombiniert
- Welches Output-Format wird verwendet
- Priorisierung der Findings
```

## Integration mit bestehenden Workflows

### Git Hooks

```bash
# Pre-commit Hook für automatische Code-Analyse
#!/bin/bash
claude-code /global:orchestration:analyze-parallel --quick
```

### CI/CD Pipeline

```yaml
# GitHub Actions Example
- name: Claude Code Analysis
  run: |
    claude-code /global:orchestration:security-audit
    claude-code /global:orchestration:test-coverage
```

### VS Code Tasks

```json
{
  "label": "Claude Code Analysis",
  "type": "shell",
  "command": "claude-code /global:orchestration:analyze-parallel ${workspaceFolder}",
  "problemMatcher": []
}
```

## Erweiterte Konfiguration

Die `.claude-commands.json` ermöglicht project-spezifische Anpassungen:

```json
{
  "subAgentDefaults": {
    "tokenBudget": 3000,
    "timeout": 30000,
    "retryOnFailure": true
  },
  "performanceMode": "aggressive",
  "synthesis": {
    "format": "markdown",
    "deduplication": true,
    "prioritization": "severity"
  }
}
```

## Troubleshooting

### Häufige Probleme

**"Token limit exceeded"**

- Token-Budget pro Agent reduzieren
- Weniger Agents verwenden
- Context-Größe optimieren

**"Agent timeout"**

- Timeout in Konfiguration erhöhen
- Task-Scope verkleinern
- Parallelität reduzieren

**"Synthesis failed"**

- Output-Format der Agents prüfen
- Strukturierte Outputs sicherstellen
- Error Handling verbessern

## Metriken und Monitoring

### Performance-Tracking

Commands loggen automatisch Performance-Metriken:

```
[PERF] analyze-parallel completed:
- Total time: 6.2s
- Agents: 10
- Sequential estimate: 58s
- Speedup: 9.4x
- Tokens used: 28,450
```

### Erfolgsmetriken

- **Ausführungszeit**: Ziel < 10s für die meisten Commands
- **Speedup-Faktor**: Ziel > 5x vs. sequentiell
- **Token-Effizienz**: < 3000 Tokens/Agent
- **Fehlerrate**: < 5% Agent-Failures

## Weiterentwicklung

### Geplante Features

1. **Adaptive Agent-Anzahl** basierend auf Codebase-Größe
2. **Caching** für wiederholte Analysen
3. **Custom Synthesis Strategies** per Command
4. **Real-time Progress Updates** während Ausführung
5. **Integration mit Claude Code Memory**

### Community Contributions

Contributions sind willkommen! Besonders gesucht:

- Neue Command-Ideen
- Performance-Optimierungen
- Integration-Examples
- Dokumentations-Verbesserungen

## Referenzen

- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Task Tool Reference](https://docs.anthropic.com/claude-code/tools)
- [Original dotfiles Implementation](https://github.com/example/dotfiles)
