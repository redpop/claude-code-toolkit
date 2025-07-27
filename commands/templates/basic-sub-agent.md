---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*)
description: [Kurze Beschreibung des Commands]
argument-hint: [expected-arguments]
---

# [Command Name]

[Detaillierte Beschreibung was dieses Command tut und wann es verwendet werden sollte]

## Ausführung

**SOFORT [N] PARALLELE AGENTS STARTEN:**

1. **[Agent Name]**: Task(description="[Task Description]", prompt="[Detaillierter Prompt für den Agent. Beschreibe genau was analysiert werden soll, welche Tools verwendet werden sollen, und in welchem Format die Ergebnisse zurückgegeben werden sollen. Beende mit: Gib Ergebnisse als JSON zurück.]", subagent_type="general-purpose")

2. **[Agent Name]**: Task(description="[Task Description]", prompt="[Detaillierter Prompt]", subagent_type="general-purpose")

3. **[Agent Name]**: Task(description="[Task Description]", prompt="[Detaillierter Prompt]", subagent_type="general-purpose")

[Weitere Agents nach Bedarf...]

## Synthesis

Nach Abschluss aller Agents:

1. **[Synthesis Step 1]**:
   - [Beschreibung wie die Ergebnisse zusammengeführt werden]
   - [Welche Priorisierung angewendet wird]

2. **[Synthesis Step 2]**:
   ```markdown
   # [Report Title]
   
   ## [Section 1]
   [Beschreibung des Report-Formats]
   
   ## [Section 2]
   [Weitere Sections]
   ```

3. **[Action Items]**:
   - [Wie werden konkrete nächste Schritte generiert]
   - [Welche Empfehlungen gegeben werden]

**Performance-Erwartung**: [X-Y Sekunden für parallele Ausführung, verglichen mit Z Sekunden sequentiell]

**Hinweise**: 
- [Spezielle Hinweise zur Verwendung]
- [Limitationen oder Voraussetzungen]