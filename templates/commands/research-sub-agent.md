---
allowed-tools: Task, Read, WebSearch, WebFetch, Grep, Bash(fd:*), Bash(rg:*)
description: Template für Research Commands die verschiedene Informationsquellen parallel durchsuchen
argument-hint: [research-topic] [--scope=local|web|all]
---

# [Research Command Name]

Dieses Command führt eine umfassende Recherche zu [Thema] durch, indem [N] spezialisierte Research Agents parallel verschiedene Aspekte untersuchen.

## Research-Strategie

Die Recherche deckt folgende Bereiche ab:
- **Technische Perspektive**: [Beschreibung]
- **Praktische Implementierung**: [Beschreibung]
- **Best Practices & Standards**: [Beschreibung]
- **Probleme & Lösungen**: [Beschreibung]

## Ausführung

**SOFORT [N] PARALLELE RESEARCH AGENTS STARTEN:**

1. **Technical Documentation Agent**: Task(description="Research Technical Docs", prompt="Recherchiere technische Dokumentation zu '$ARGUMENTS'. Untersuche: 1) Offizielle Dokumentation, 2) API References, 3) Architecture Guides, 4) Technical Specifications. Fokussiere auf [Hauptaspekte]. Nutze lokale Docs und Code-Kommentare. Gib strukturierte Technical Insights als Markdown zurück.", subagent_type="general-purpose")

2. **Implementation Examples Agent**: Task(description="Find Implementation Examples", prompt="Finde konkrete Implementierungsbeispiele für '$ARGUMENTS'. Suche: 1) Code Examples in der Codebase, 2) Common Usage Patterns, 3) Real-world Implementations, 4) Test Cases als Beispiele. Nutze grep/rg intensiv. Gib annotierte Code-Beispiele mit Erklärungen als Markdown zurück.", subagent_type="general-purpose")

3. **Problem Analysis Agent**: Task(description="Research Common Problems", prompt="Identifiziere häufige Probleme und Lösungen bei '$ARGUMENTS'. Recherchiere: 1) Known Issues und Bugs, 2) Common Pitfalls, 3) Troubleshooting Patterns, 4) Workarounds. Analysiere Code-Comments, TODOs, und Error-Handling. Gib Problem-Solution Matrix als Markdown zurück.", subagent_type="general-purpose")

4. **Best Practices Agent**: Task(description="Compile Best Practices", prompt="Sammle Best Practices für '$ARGUMENTS'. Analysiere: 1) Coding Standards, 2) Design Patterns, 3) Performance Optimizations, 4) Security Considerations. Suche in Style Guides und etablierten Patterns. Gib Best Practice Guide als Markdown zurück.", subagent_type="general-purpose")

[Weitere Research Agents nach Bedarf...]

## Synthesis

Nach Abschluss aller Research Agents:

1. **Erstelle Comprehensive Knowledge Base**:
   ```markdown
   # [Topic] Research Findings
   
   ## Overview
   [2-3 Paragraphen Zusammenfassung der wichtigsten Erkenntnisse]
   
   ## Key Insights
   
   ### Technical Foundation
   [Konsolidierte technische Erkenntnisse]
   
   ### Implementation Guide
   #### Recommended Approach
   [Step-by-step Anleitung basierend auf Best Practices]
   
   #### Code Examples
   ```[language]
   // Bestes Beispiel aus der Recherche
   ```
   
   ### Common Challenges & Solutions
   | Challenge | Solution | Example |
   |-----------|----------|---------|
   | ...       | ...      | ...     |
   ```

2. **Generiere Decision Matrix**:
   ```markdown
   ## Decision Guide
   
   ### When to Use [Topic]
   ✅ Scenario 1: [Beschreibung]
   ✅ Scenario 2: [Beschreibung]
   
   ### When to Avoid
   ❌ Scenario 1: [Beschreibung]
   ❌ Alternative: [Bessere Option]
   
   ### Comparison with Alternatives
   | Aspect | [Topic] | Alternative 1 | Alternative 2 |
   |--------|---------|---------------|---------------|
   | ...    | ...     | ...           | ...           |
   ```

3. **Erstelle Learning Path**:
   - Beginner: Start hier
   - Intermediate: Diese Konzepte
   - Advanced: Diese Optimierungen

4. **Compile Resource List**:
   - Wichtigste Dokumentationen
   - Hilfreiche Tools
   - Community Resources
   - Weiterführende Literatur

**Performance-Erwartung**: Research in [X-Y] Sekunden abgeschlossen.

**Output**: Vollständiges Markdown-Dokument, bereit für Team-Wiki oder Dokumentation.