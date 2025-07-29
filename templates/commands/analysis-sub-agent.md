---
allowed-tools: Task, Read, Grep, Bash(fd:*), Bash(rg:*), Bash(ast-grep:*)
description: Template für Code-Analyse Commands mit mehreren spezialisierten Agents
argument-hint: [target] [--option=value]
---

# [Analysis Command Name]

Dieses Command analysiert [Beschreibung] durch [N] parallel arbeitende spezialisierte Agents.

## Analyse-Strategie

Die Analyse ist in folgende Bereiche aufgeteilt:
- **Strukturelle Analyse**: [Beschreibung]
- **Qualitative Analyse**: [Beschreibung]
- **Quantitative Metriken**: [Beschreibung]

## Ausführung

**SOFORT [N] PARALLELE ANALYSE-AGENTS STARTEN:**

1. **Structure Analysis Agent**: Task(description="Analyze Code Structure", prompt="Analysiere die Struktur von $ARGUMENTS. Untersuche: 1) [Aspekt 1], 2) [Aspekt 2], 3) [Aspekt 3]. Nutze ast-grep für präzise AST-Analyse. Fokussiere auf [Hauptfokus]. Gib strukturierte Findings als JSON zurück mit Schema: {findings: [{type, location, severity, description, suggestion}]}.", subagent_type="general-purpose")

2. **Pattern Detection Agent**: Task(description="Detect Code Patterns", prompt="Identifiziere Patterns in $ARGUMENTS. Suche nach: 1) [Pattern 1], 2) [Pattern 2], 3) Anti-Patterns wie [Beispiele]. Nutze rg mit erweiterten Regex-Patterns. Gib gefundene Patterns als JSON zurück mit Schema: {patterns: [{name, occurrences, locations, impact}]}.", subagent_type="general-purpose")

3. **Metrics Calculation Agent**: Task(description="Calculate Metrics", prompt="Berechne Metriken für $ARGUMENTS. Erfasse: 1) [Metrik 1], 2) [Metrik 2], 3) [Metrik 3]. Nutze statistische Analyse für Trends. Gib Metrics Dashboard als JSON zurück mit Schema: {metrics: {metric_name: {value, trend, benchmark}}}.", subagent_type="general-purpose")

[Weitere spezialisierte Agents...]

## Synthesis

Nach Abschluss aller Analyse-Agents:

1. **Konsolidiere Findings**:
   - Dedupliziere überlappende Findings
   - Gruppiere nach Schweregrad
   - Identifiziere Muster über mehrere Agents

2. **Erstelle Analyse-Dashboard**:
   ```markdown
   # [Analysis Type] Report
   
   ## Executive Summary
   - Overall Score: [Score/Grade]
   - Critical Issues: [Count]
   - Improvement Areas: [Top 3]
   
   ## Detailed Findings
   
   ### Critical Issues
   | Issue | Location | Impact | Fix Effort |
   |-------|----------|--------|------------|
   | ...   | ...      | ...    | ...        |
   
   ### Recommendations
   1. **Immediate Actions**
      - [Action 1]
      - [Action 2]
   
   2. **Short-term Improvements**
      - [Improvement 1]
      - [Improvement 2]
   ```

3. **Generiere Visualisierungen**:
   ```mermaid
   pie title Issue Distribution
     "Critical" : [count]
     "High" : [count]
     "Medium" : [count]
     "Low" : [count]
   ```

4. **Erstelle Fix-Prioritäten**:
   - ROI-basierte Priorisierung
   - Abhängigkeiten berücksichtigen
   - Team-Kapazität einplanen

**Performance-Erwartung**: Analyse in [X-Y] Sekunden, [Z]x schneller als sequentiell.

**Output-Formate**: 
- JSON für Tool-Integration
- Markdown für Human-Readable Reports
- CSV für Daten-Export