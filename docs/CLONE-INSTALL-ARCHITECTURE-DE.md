# Claude Commands: Clone + Install Architektur

## Übersicht

Diese Anleitung beschreibt die neue Architektur für Claude Code Slash Commands, die eine saubere Trennung zwischen Source-Repository und Installation ermöglicht. Sie ist sowohl für Entwickler gedacht, die das Toolkit erweitern möchten, als auch für Endbenutzer, die die Commands einfach nur nutzen wollen.

### Für Endbenutzer
Wenn Sie die Commands nur nutzen möchten, brauchen Sie lediglich:
1. Das Repository klonen
2. `./install.sh [prefix]` ausführen
3. Commands verwenden wie `/prefix:command:name`

### Für Entwickler
Wenn Sie Commands/Agents modifizieren oder neu erstellen möchten, erklärt diese Anleitung:
- Wie die Architektur funktioniert
- Wie Sie Ihre Anpassungen konfigurieren
- Wie das Agent-Orchestrierungs-System funktioniert
- Wie Sie den Hybrid-Ansatz für maximale Performance nutzen

## Kernkonzepte

### 1. **Separation of Concerns**

- **Source Repository**: Wo der Code entwickelt und versioniert wird (beliebiger Ort)
- **Installation**: Wo Claude Code die Commands/Agents erwartet (`~/.claude/`)
- **Manifest System**: Tracking welche Dateien woher kommen

### 2. **Multi-Repository Support**

- Mehrere Command-Sammlungen gleichzeitig installierbar
- Jede mit eigenem Prefix
- Zentrale Agent-Verwaltung mit Konfliktbehandlung

### 3. **User-First Design**

- User-eigene Agents werden niemals überschrieben
- Klare Trennung zwischen Repo-Agents und User-Agents
- Intelligente Konfliktbehandlung

## Verzeichnisstruktur

### Source Repository (beliebiger Ort)

```
~/projects/my-claude-commands/          # Oder jeder andere Ort
├── commands/                           # Command-Definitionen
│   ├── git/
│   │   └── commit.md
│   ├── project/
│   │   └── changelog.md
│   └── ...
├── agents/                            # Agent-Definitionen
│   ├── security-specialist.md
│   ├── performance-optimizer.md
│   └── ...
├── install.sh                         # Installations-Script
├── uninstall.sh                       # Deinstallations-Script
├── scripts/
│   ├── sync-agents.sh                # Agent-Sync-Tool
│   └── manage-commands.sh            # Command-Manager
├── .claude-commands.json              # Repo-Konfiguration
└── README.md
```

### Installation Target (`~/.claude/`)

```
~/.claude/
├── commands/                          # Installierte Commands
│   ├── global/                       # Prefix "global"
│   │   ├── git/
│   │   │   └── commit.md
│   │   └── .update.sh               # Auto-Update-Script
│   ├── team/                        # Prefix "team"
│   │   └── ...
│   └── custom/                      # Prefix "custom"
│       └── ...
├── agents/                          # Alle Agents (gemischt)
│   ├── security-specialist.md       # Repo-Agent
│   ├── my-custom-agent.md          # User-Agent
│   └── .manifest.json              # Agent-Manifest
├── .manifests/                     # Installation-Tracking
│   ├── global.json                 # Manifest für "global"
│   ├── team.json                   # Manifest für "team"
│   └── custom.json                 # Manifest für "custom"
└── bin/                           # Hilfsprogramme
    ├── claude-sync                 # Globales Sync-Tool
    └── claude-agent               # Agent-Manager
```

## Manifest-System

### Command Manifest (`.claude/.manifests/PREFIX.json`)

```json
{
  "version": "1.0.0",
  "prefix": "global",
  "source": {
    "type": "git",
    "url": "https://github.com/redpop/claude-code-toolkit.git",
    "path": "/Users/user/projects/claude-commands",
    "commit": "abc123def456"
  },
  "installed": "2025-01-27T10:00:00Z",
  "lastUpdated": "2025-01-27T15:00:00Z",
  "files": ["git/commit.md", "project/changelog.md", "ai/handoff.md"],
  "config": {
    "autoUpdate": false,
    "updateChannel": "stable"
  }
}
```

### Agent Manifest (`.claude/.manifests/agents.json`)

```json
{
  "version": "1.0.0",
  "agents": {
    "security-specialist.md": {
      "source": "repo",
      "prefix": "global",
      "sourcePath": "/Users/user/projects/claude-commands/agents/security-specialist.md",
      "installedAt": "2025-01-27T10:00:00Z",
      "checksum": "sha256:abc123...",
      "metadata": {
        "name": "Security Specialist",
        "description": "Security analysis expert"
      }
    },
    "my-custom-agent.md": {
      "source": "user",
      "createdAt": "2025-01-26T14:00:00Z",
      "metadata": {
        "name": "My Custom Agent",
        "description": "Personal custom agent"
      }
    },
    "team-analyzer.md": {
      "source": "repo",
      "prefix": "team",
      "sourcePath": "/Users/user/projects/team-commands/agents/team-analyzer.md",
      "installedAt": "2025-01-27T11:00:00Z"
    }
  }
}
```

## Installation Workflow

### 1. Erstinstallation

```bash
# Repository klonen
git clone https://github.com/redpop/claude-code-toolkit.git ~/projects/claude-commands
cd ~/projects/claude-commands

# Installieren mit gewünschtem Prefix
./install.sh global

# Oder mit Optionen
./install.sh --prefix=team --skip-agents --verbose
```

### 2. Installation von Fork

```bash
# Fork klonen
git clone https://github.com/myteam/our-claude-commands.git ~/projects/team-commands
cd ~/projects/team-commands

# Mit anderem Prefix installieren
./install.sh team
```

### 3. Update-Workflow

```bash
# Option 1: Manuelles Update
cd ~/projects/claude-commands
git pull
./install.sh global --update

# Option 2: Auto-Update-Script
~/.claude/commands/global/.update.sh

# Option 3: Globales Update-Tool
claude-sync update global
```

## Konfliktbehandlung

### Agent-Konflikte

Wenn ein Agent bereits existiert:

```
⚠️  Konflikt: security-specialist.md existiert bereits

Aktuell installiert:
  Source: repo (prefix: team)
  Installiert: 2025-01-26

Neue Version:
  Source: repo (prefix: global)

Optionen:
  [s] Skip - Aktuelle Version behalten
  [r] Replace - Mit neuer Version ersetzen
  [b] Backup - Aktuelle sichern, neue installieren
  [m] Merge - Beide behalten (mit Suffix)

Auswahl [s/r/b/m]:
```

### Spezielle Regeln:

1. **User-Agents werden NIE automatisch überschrieben**
2. **Repo-Agents können andere Repo-Agents ersetzen** (mit Warnung)
3. **Backup-Option erstellt**: `agent-name.md.backup-20250127`
4. **Merge-Option erstellt**: `agent-name-global.md`

## Command-Line Interface

### install.sh

```bash
Usage: ./install.sh [PREFIX] [OPTIONS]

PREFIX:
  Der Namespace für diese Installation (default: Verzeichnisname)

OPTIONS:
  --update              Update existing installation
  --skip-agents         Installiere keine Agents
  --skip-commands       Installiere keine Commands
  --force              Überschreibe ohne Nachfrage
  --dry-run            Zeige was passieren würde
  --verbose            Detaillierte Ausgabe
  --config FILE        Nutze alternative Konfiguration

EXAMPLES:
  ./install.sh                    # Install mit auto-detected prefix
  ./install.sh global            # Install mit prefix "global"
  ./install.sh team --update     # Update installation "team"
  ./install.sh --dry-run         # Preview installation
```

### claude-sync (Global Tool)

```bash
Usage: claude-sync [COMMAND] [OPTIONS]

COMMANDS:
  list                  Liste alle Installationen
  update [PREFIX]       Update spezifische Installation
  update-all           Update alle Installationen
  check                Prüfe auf Updates
  clean                Entferne verwaiste Dateien

OPTIONS:
  --verbose            Detaillierte Ausgabe
  --force              Keine Bestätigungen

EXAMPLES:
  claude-sync list
  claude-sync update global
  claude-sync check --verbose
```

## Migrations-Guide

### Von alter zu neuer Struktur

```bash
# 1. Backup erstellen
cp -r ~/.claude/commands ~/.claude/commands.backup

# 2. Altes Git-Repo identifizieren
cd ~/.claude/commands/global
git remote -v
# -> https://github.com/redpop/claude-code-toolkit.git

# 3. Neu klonen
cd ~/projects
git clone https://github.com/redpop/claude-code-toolkit.git

# 4. Branch wechseln wenn nötig
cd claude-code-toolkit
git checkout feature/sub-agent-orchestration

# 5. Alte Installation entfernen
rm -rf ~/.claude/commands/global

# 6. Neu installieren
./install.sh global

# 7. User-Anpassungen wiederherstellen
# (manuell prüfen und kopieren aus backup)
```

## Best Practices

### 1. Für Repository-Maintainer

- **Semantic Versioning** für Releases nutzen
- **Breaking Changes** klar dokumentieren
- **Agent-Namen** sollten eindeutig sein
- **Konflikte minimieren** durch spezifische Namen

### 2. Für End-User

- **Eigene Agents** immer in `~/.claude/agents/` erstellen
- **Prefix wählen** der Konflikte vermeidet
- **Regelmäßige Updates** via `claude-sync check`
- **Backup** vor Major-Updates

### 3. Für Teams

- **Team-Fork** erstellen für gemeinsame Commands
- **Eigener Prefix** (z.B. "acme-team")
- **CI/CD** für automatische Tests
- **Dokumentation** der Team-spezifischen Commands

## Technische Details

### Checksum-Verifikation

```bash
# Agent-Integrität prüfen
sha256sum ~/.claude/agents/security-specialist.md
# Vergleichen mit Manifest-Eintrag
```

### Symlink vs. Copy

```bash
# install.sh kann Symlinks nutzen (development mode)
./install.sh global --use-symlinks

# Vorteile: Änderungen sofort aktiv
# Nachteile: Source muss verfügbar bleiben
```

### Custom Hooks

```bash
# Post-Install Hook
~/.claude/hooks/post-install.sh

# Pre-Update Hook
~/.claude/hooks/pre-update.sh
```

## Fehlerbehebung

### "Command not found"

```bash
# Prüfe Installation
ls ~/.claude/commands/PREFIX/

# Prüfe Manifest
cat ~/.claude/.manifests/PREFIX.json
```

### "Agent wird nicht erkannt"

```bash
# Prüfe Agent-Verzeichnis
ls ~/.claude/agents/

# Prüfe Agent-Manifest
cat ~/.claude/.manifests/agents.json | jq
```

### "Updates funktionieren nicht"

```bash
# Prüfe Source-Pfad
cat ~/.claude/.manifests/PREFIX.json | jq .source.path

# Manuell updaten
cd [source-path]
git pull
./install.sh PREFIX --update
```

## Konfigurationsdatei: .claude-commands.json

Die `.claude-commands.json` Datei ist die zentrale Konfiguration für das gesamte Toolkit. Sie steuert, wie Commands und Agents zusammenarbeiten.

### Wichtige Bereiche erklärt

#### 1. **Repository-Informationen**
```json
{
  "repo_owner": "redpop",
  "repo_name": "claude-code-toolkit",
  "default_branch": "main",
  "description": "The complete toolkit...",
  "version": "2.0.0"
}
```
- Identifiziert das Repository und die Version
- Wird für Updates und Fork-Management verwendet

#### 2. **Fork-Konfiguration**
```json
"fork_config": {
  "auto_update_urls": true,
  "preserve_original_references": false,
  "custom_prefix_support": true
}
```
- `auto_update_urls`: Aktualisiert URLs automatisch beim Forken
- `preserve_original_references`: Ob Original-Repo-Referenzen erhalten bleiben
- `custom_prefix_support`: Erlaubt benutzerdefinierte Präfixe bei der Installation

#### 3. **Sub-Agent Orchestrierung**
```json
"subAgentOrchestration": {
  "enabled": true,
  "defaults": {
    "tokenBudget": 3000,
    "timeout": 30000,
    "parallelExecution": true
  }
}
```
- Steuert, wie mehrere Agents zusammenarbeiten
- `tokenBudget`: Max. Tokens pro Agent (beeinflusst Antwortlänge)
- `timeout`: Max. Ausführungszeit in Millisekunden
- `parallelExecution`: Ob Agents parallel laufen

#### 4. **Performance-Modi**
```json
"performanceModes": {
  "conservative": { "maxConcurrentAgents": 5 },
  "balanced": { "maxConcurrentAgents": 10 },
  "aggressive": { "maxConcurrentAgents": 20 }
}
```
- Wählen Sie basierend auf Ihren Systemkapazitäten
- `conservative`: Sicherer für begrenzte Ressourcen
- `balanced`: Standard, gut für die meisten Systeme
- `aggressive`: Maximale Parallelisierung

#### 5. **Agent-Registry**
```json
"agentRegistry": {
  "security-specialist": {
    "type": "sub-agent",
    "location": "agents/security-specialist.md",
    "autoInvoke": ["security", "vulnerability"],
    "priority": "high"
  }
}
```
- Definiert verfügbare Agents und ihre Trigger
- `autoInvoke`: Schlüsselwörter, die diesen Agent auslösen
- `priority`: Ausführungspriorität bei mehreren passenden Agents

## Wie das Agent/Command-System funktioniert

### Drei Arten der Ausführung

#### 1. **Einfache Commands**
Basis-Commands, die eine einzelne Aufgabe ausführen:
```
/prefix:git:commit
```
- Läuft eigenständig
- Keine Agent-Orchestrierung
- Schnell und einfach

#### 2. **Orchestrierungs-Commands**
Commands, die mehrere spezialisierte Agents koordinieren:
```
/prefix:orchestration:security-audit
```
- Ruft spezifische Sub-Agents auf
- Agents arbeiten in eigenen Kontexten
- Ergebnisse werden aggregiert

#### 3. **Hybrid-Commands**
Der mächtigste Ansatz, kombiniert paralleles Scannen mit Experten-Analyse:
```
/prefix:hybrid:analyze-deep
```

### Die Hybrid-Architektur im Detail

Der Hybrid-Ansatz nutzt ein dreiphasiges System:

#### Phase 1: Paralleles Scannen (5-8 Sekunden)
- 10+ Scanner-Agents laufen gleichzeitig über das Task Tool
- Jeder Scanner hat einen spezifischen Fokus (Security, Performance, etc.)
- Produziert strukturierte JSON-Ausgabe
- Optimiert für Geschwindigkeit und Abdeckung

#### Phase 2: Experten-Analyse (10-20 Sekunden)
- Ergebnisse aus Phase 1 werden analysiert
- Kritische Probleme werden an spezialisierte Sub-Agents delegiert
- Jeder Sub-Agent arbeitet isoliert für tiefe Analyse
- Sub-Agents haben volle Claude Code Fähigkeiten

#### Phase 3: Synthese (2-5 Sekunden)
- Alle Ergebnisse werden kombiniert
- Duplikate werden zusammengeführt
- Priorisierter Aktionsplan wird generiert
- Finaler Bericht mit Metriken

### Beispiel-Workflow

Wenn Sie `/global:hybrid:analyze-deep ./mein-projekt` ausführen:

1. **Phase 1 startet**: 10 Scanner starten parallel
   - Security-Scanner findet hardcodierte Credentials
   - Performance-Scanner findet O(n²) Algorithmus
   - Architektur-Scanner findet zirkuläre Abhängigkeiten
   - Test-Scanner findet 30% Coverage
   - Und 6 weitere Scanner...

2. **Phase 2 Delegation**:
   - Security-Findings → `security-specialist` Agent
   - Performance-Probleme → `performance-optimizer` Agent
   - Architektur-Probleme → `code-architect` Agent

3. **Phase 3 Synthese**:
   - Kombinierter Bericht mit allen Findings
   - Schweregrad-basierte Priorisierung
   - Umsetzbare Empfehlungen
   - Gesamt-Gesundheitsscore

## Für Endbenutzer: Konfigurationsoptionen

### 1. **Performance-Tuning**
Bearbeiten Sie `.claude-commands.json` zum Anpassen:
```json
"performanceMode": "conservative"  // Ändern von "balanced"
```

### 2. **Spezifische Features deaktivieren**
```json
"subAgentOrchestration": {
  "enabled": false  // Agent-Orchestrierung deaktivieren
}
```

### 3. **Angepasstes Command-Verhalten**
```json
"commandOverrides": {
  "orchestration:security-audit": {
    "performanceMode": "conservative",
    "defaults": {
      "tokenBudget": 5000  // Detailliertere Analyse
    }
  }
}
```

## Für Entwickler: Das System erweitern

### 1. **Neue Agents erstellen**
1. Erstellen Sie eine Markdown-Datei in `agents/`
2. Definieren Sie die Expertise und Persona des Agents
3. Registrieren Sie in `.claude-commands.json`:
```json
"agentRegistry": {
  "mein-neuer-agent": {
    "type": "sub-agent",
    "location": "agents/mein-neuer-agent.md",
    "autoInvoke": ["schlüsselwort1", "schlüsselwort2"],
    "priority": "medium"
  }
}
```

### 2. **Hybrid-Commands erstellen**
1. Entwerfen Sie Ihre drei Phasen
2. Erstellen Sie Command in `commands/hybrid/`
3. Konfigurieren Sie in `.claude-commands.json`:
```json
"hybridCommands": {
  "mein-hybrid-command": {
    "phases": ["scan", "analyze", "report"],
    "scannerCount": 12,
    "expertDelegation": true
  }
}
```

### 3. **Performance-Optimierung**
- Passen Sie `tokenBudget` für Qualität vs. Geschwindigkeit an
- Modifizieren Sie `maxConcurrentAgents` basierend auf System
- Nutzen Sie `caching` für wiederholte Analysen
- Aktivieren Sie `experimental` Features für modernste Performance

## Zusammenfassung

Die neue Architektur bietet:

1. **Flexibilität**: Klone und installiere von überall
2. **Sicherheit**: User-Content wird geschützt
3. **Transparenz**: Klares Tracking via Manifests
4. **Skalierbarkeit**: Multi-Repo-Support
5. **Wartbarkeit**: Einfache Updates und Verwaltung
6. **Performance**: Hybrid-Ansatz für maximale Effizienz
7. **Erweiterbarkeit**: Einfaches Hinzufügen neuer Commands und Agents

Die Kombination aus einfacher Installation, mächtiger Orchestrierung und der Hybrid-Architektur macht dies zum fortschrittlichsten Command-System für Claude Code.
