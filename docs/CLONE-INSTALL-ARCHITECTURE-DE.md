# Claude Commands: Clone + Install Architektur

## Übersicht

Diese Anleitung beschreibt die neue Architektur für Claude Code Slash Commands, die eine saubere Trennung zwischen Source-Repository und Installation ermöglicht.

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
    "url": "https://github.com/redpop/claude-code-slash-commands.git",
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
git clone https://github.com/redpop/claude-code-slash-commands.git ~/projects/claude-commands
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
# -> https://github.com/redpop/claude-code-slash-commands.git

# 3. Neu klonen
cd ~/projects
git clone https://github.com/redpop/claude-code-slash-commands.git

# 4. Branch wechseln wenn nötig
cd claude-code-slash-commands
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

## Zusammenfassung

Die neue Architektur bietet:

1. **Flexibilität**: Klone und installiere von überall
2. **Sicherheit**: User-Content wird geschützt
3. **Transparenz**: Klares Tracking via Manifests
4. **Skalierbarkeit**: Multi-Repo-Support
5. **Wartbarkeit**: Einfache Updates und Verwaltung

Der Wechsel von "Git-in-place" zu "Clone+Install" macht das System robuster, verständlicher und zukunftssicher.
