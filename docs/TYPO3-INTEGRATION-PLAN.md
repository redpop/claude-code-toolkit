# TYPO3 Integration Plan für Claude Code Toolkit

## Übersicht

Dieses Dokument beschreibt die geplante Integration von TYPO3-spezifischen Commands und AI-Agents in das Claude Code Toolkit. Die Integration zielt darauf ab, TYPO3 v13 Entwicklung zu beschleunigen und Best Practices automatisch anzuwenden.

## Zielversionen

- **TYPO3**: Version 13.4 LTS
- **Content Blocks**: Version 1.3
- **PHP**: 8.2+
- **Composer**: 2.x

## Projektstruktur

### 1. Command-Struktur

```
commands/
└── typo3/
    ├── sitepackage.md          # SitePackage Extension Kickstarter
    ├── content-blocks.md        # Content Blocks Generator
    ├── extension.md            # Extension Development Helper
    ├── typoscript.md           # TypoScript Analyzer & Generator
    ├── tca.md                  # TCA Configuration Helper
    ├── fluid.md                # Fluid Template Generator
    ├── migration.md            # Version Migration Assistant
    ├── security.md             # TYPO3 Security Scanner
    └── performance.md          # Performance Optimizer
```

### 2. Agent-Struktur

```
agents/
└── typo3/
    ├── typo3-architect.md           # TYPO3 Architecture Specialist
    ├── extension-developer.md       # Extension Development Expert
    ├── content-blocks-specialist.md # Content Blocks v1.3 Expert
    ├── typoscript-expert.md         # TypoScript & TSconfig Specialist
    ├── fluid-specialist.md          # Fluid Template Expert
    ├── tca-specialist.md            # TCA Configuration Expert
    └── upgrade-specialist.md        # TYPO3 Upgrade & Migration Expert
```

## Detaillierte Command-Spezifikationen

### 1. SitePackage Kickstarter (`/prefix:typo3:sitepackage`)

#### Funktionalität

- Erstellt vollständige TYPO3 v13.4 kompatible SitePackage-Struktur
- Nutzt Site Sets (neu in v13) statt klassischer sys_template Records
- Generiert moderne Composer-basierte Extension

#### Generierte Struktur

```
packages/{vendor_name}/{package_name}/
├── composer.json                    # Composer Konfiguration
├── Configuration/
│   ├── Sets/
│   │   └── {PackageName}/
│   │       ├── config.yaml         # Site Set Konfiguration
│   │       ├── constants.typoscript
│   │       ├── setup.typoscript
│   │       └── TypoScript/
│   │           ├── page.typoscript
│   │           └── config.typoscript
│   ├── TCA/
│   │   └── Overrides/
│   │       └── pages.php           # Page TCA Overrides
│   └── Icons/                      # Extension Icons
├── Resources/
│   ├── Private/
│   │   ├── PageView/               # PAGEVIEW Templates (neu in v13)
│   │   │   ├── Layouts/
│   │   │   ├── Pages/
│   │   │   └── Partials/
│   │   ├── Templates/              # Content Element Templates
│   │   ├── Language/               # Übersetzungen
│   │   └── Sass/                   # SCSS Sources
│   └── Public/
│       ├── Css/
│       ├── JavaScript/
│       └── Icons/
└── ext_emconf.php                  # Extension Manager Konfiguration
```

#### Parameter

- `--vendor`: Vendor Name (z.B. "MyCompany")
- `--name`: Package Name (z.B. "corporate-site")
- `--title`: Extension Title
- `--description`: Extension Description
- `--author`: Author Name
- `--email`: Author Email
- `--typo3-version`: Target TYPO3 Version (default: "^13.4")
- `--include-ddev`: DDEV Konfiguration hinzufügen
- `--include-docker`: Docker Setup hinzufügen

### 2. Content Blocks Generator (`/prefix:typo3:content-blocks`)

#### Funktionalität

- Generiert Content Blocks v1.3 kompatible Konfigurationen
- Unterstützt alle neuen v1.3 Features:
  - Collection Child Type Restrictions
  - Default Configurations
  - Core Page Type Re-definitions
  - Assets Publishing

#### Generierte Struktur

```
packages/{sitepackage}/ContentBlocks/{content_block_name}/
├── config.yaml                     # Content Block Konfiguration
├── Assets/
│   ├── Icon.svg                   # Content Block Icon
│   └── PreviewImage.png           # Backend Preview
├── Templates/
│   ├── Frontend.html              # Frontend Ausgabe
│   └── EditorPreview.html         # Backend Preview
├── Language/
│   └── Labels.xlf                 # Übersetzungen
└── Source/                        # Optional: TypeScript/Sass
```

#### Content Block YAML Schema (v1.3)

```yaml
name: vendor/content-block-name
title: "Content Block Title"
icon:
  - src: Icon.svg
    alt: "Icon description"
fields:
  - identifier: headline
    type: Text
    label: "Headline"
    required: true
    maxCharacters: 100
  - identifier: content
    type: Textarea
    label: "Content"
    enableRichText: true
  - identifier: items
    type: Collection
    label: "Items"
    minItems: 1
    maxItems: 10
    restrictedContentTypes: # NEU in v1.3
      - text
      - images
  - identifier: link
    type: Link
    label: "Link"
    linkTypes:
      - page
      - external
      - file
```

#### Unterstützte Field Types (v1.3)

- **Basic**: Text, Textarea, Number, Email, Color
- **Selection**: Select, Radio, Checkbox
- **Date/Time**: DateTime, Date, Time
- **Relations**: Relation, File, Folder, Category
- **Advanced**: Link, Slug, Json, FlexForm
- **Collections**: Collection (mit v1.3 Child Type Restrictions)
- **Special**: Linebreak, Tab, Palette

### 3. Extension Development Helper (`/prefix:typo3:extension`)

#### Funktionalität

- Scaffolding für verschiedene Extension-Typen
- TCA Generation
- Service Class Templates
- Middleware Templates
- Command Controller Templates

#### Unterstützte Extension-Typen

1. **Plugin Extension**

   - Frontend Plugin mit Extbase/Fluid
   - Controller, Models, Repositories
   - FlexForm Konfiguration

2. **Backend Module**

   - Backend Modul Struktur
   - Controller mit Backend Context
   - Module Registration

3. **Service Extension**

   - Service Classes
   - Dependency Injection
   - Event Listeners

4. **Middleware Extension**
   - PSR-15 Middleware
   - Request/Response Handling

### 4. TypoScript Analyzer & Generator (`/prefix:typo3:typoscript`)

#### Funktionalität

- Analysiert bestehende TypoScript Dateien
- Identifiziert veraltete Syntax
- Generiert moderne TypoScript Patterns
- Konvertiert alte zu neuer Syntax

#### Features

- Site Set kompatible Struktur
- Constants zu Site Settings Migration
- PAGEVIEW Integration
- Data Processor Konfiguration

### 5. TCA Configuration Helper (`/prefix:typo3:tca`)

#### Funktionalität

- Generiert TCA Konfigurationen
- Validiert bestehende TCA
- Migration von alten TCA Patterns
- Field Wizard Integration

#### Unterstützte TCA Types

- input, text, select, group
- inline (IRRE)
- slug
- category
- file
- imageManipulation
- json

## Detaillierte Agent-Spezifikationen

### 1. TYPO3 Architect Agent

#### Expertise

- TYPO3 Core Architecture
- Extension Architecture Patterns
- Performance Best Practices
- Security Guidelines
- Site Configuration

#### Capabilities

- Projekt-Struktur Analyse
- Architecture Review
- Performance Bottleneck Identifikation
- Security Audit
- Upgrade Path Beratung

### 2. Extension Developer Agent

#### Expertise

- Extbase/Fluid Development
- Service Architecture
- Dependency Injection
- Event System
- Middleware Development

#### Capabilities

- Code Generation
- Refactoring Vorschläge
- Testing Strategien
- Performance Optimierung
- Best Practice Enforcement

### 3. Content Blocks Specialist Agent

#### Expertise

- Content Blocks v1.3 Spezifikation
- YAML Schema
- Field Type Configuration
- Collection Management
- Asset Publishing

#### v1.3 Spezifische Features

- **Collection Child Type Restrictions**

  ```yaml
  - identifier: items
    type: Collection
    restrictedContentTypes:
      - vendor/text-block
      - vendor/image-block
  ```

- **Default Configurations** (content-blocks.yaml)

  ```yaml
  defaults:
    contentElements:
      saveAndClose: true
    pageTypes:
      doktype: 200
  ```

- **Core Page Type Re-definition**

  - Anpassung von Standard-Seitentypen
  - Erweiterte Felder für Shortcut, External URL

- **New ViewHelpers**
  - `cb:link.editRecord` für Backend Edit Links
  - Verbesserte Collection Item Bearbeitung

### 4. TypoScript Expert Agent

#### Expertise

- Modern TypoScript Syntax
- Site Sets Configuration
- Data Processing
- Condition Syntax
- Performance Optimization

#### Capabilities

- TypoScript Generation
- Legacy Code Migration
- Performance Analyse
- Best Practice Patterns

### 5. Fluid Specialist Agent

#### Expertise

- Fluid Template Syntax
- ViewHelper Development
- Template Optimization
- PAGEVIEW Templates (v13)
- Asset Handling

#### Capabilities

- Template Generation
- ViewHelper Creation
- Performance Optimization
- Accessibility Compliance

## Implementierungs-Roadmap

### Phase 1: Foundation (Woche 1-2)

1. ✅ Feature Branch erstellen
2. Command-Struktur aufbauen
3. Basic SitePackage Command
4. Basic Content Blocks Command
5. Erste Tests

### Phase 2: Core Commands (Woche 3-4)

1. Extension Development Helper
2. TypoScript Analyzer
3. TCA Helper
4. Fluid Template Generator
5. Integration Tests

### Phase 3: AI Agents (Woche 5-6)

1. TYPO3 Architect Agent
2. Extension Developer Agent
3. Content Blocks Specialist
4. TypoScript Expert
5. Fluid Specialist

### Phase 4: Advanced Features (Woche 7-8)

1. Migration Assistant
2. Security Scanner
3. Performance Optimizer
4. Multi-Agent Workflows
5. Hybrid Commands

### Phase 5: Testing & Documentation (Woche 9-10)

1. Comprehensive Testing
2. Documentation
3. Example Projects
4. Video Tutorials
5. Community Feedback

## Technische Anforderungen

### Dependencies

```json
{
  "require": {
    "typo3/cms-core": "^13.4",
    "typo3/cms-fluid": "^13.4",
    "typo3/cms-fluid-styled-content": "^13.4",
    "typo3/cms-rte-ckeditor": "^13.4",
    "friendsoftypo3/content-blocks": "^1.3"
  },
  "require-dev": {
    "typo3/testing-framework": "^8.0",
    "phpstan/phpstan": "^1.0",
    "friendsoftypo3/phpstan-typo3": "^0.9"
  }
}
```

### System Requirements

- PHP 8.2+
- Composer 2.x
- Node.js 18+ (für Build-Prozesse)
- Docker/DDEV (optional)

## Integration mit Claude Code Toolkit

### Installation

```bash
# Clone Repository
git clone https://github.com/your-repo/claude-code-toolkit.git

# Checkout Feature Branch
git checkout feature/typo3-integration

# Install with TYPO3 prefix
./install.sh typo3

# Commands verfügbar als:
/typo3:sitepackage
/typo3:content-blocks
# etc.
```

### Workflow Integration

#### 1. Neues TYPO3 Projekt

```bash
# 1. SitePackage erstellen
/typo3:sitepackage my-project --vendor="MyCompany"

# 2. Content Blocks hinzufügen
/typo3:content-blocks "Hero Section" --fields="headline,text,image,cta"

# 3. Projekt analysieren
/typo3:flow:analyze . --security --performance
```

#### 2. Bestehendes Projekt optimieren

```bash
# 1. Deep Analysis
/typo3:scan:deep .

# 2. Apply Fixes
/typo3:fix:security
/typo3:fix:performance

# 3. Generate Report
/typo3:meta:report --export-pdf
```

## Testing Strategy

### Unit Tests

- Command Validation
- Parameter Parsing
- File Generation

### Integration Tests

- TYPO3 Installation
- Extension Registration
- Content Block Creation

### E2E Tests

- Complete Workflow
- Multi-Command Chains
- Agent Interactions

## Dokumentation

### User Documentation

1. Getting Started Guide
2. Command Reference
3. Agent Capabilities
4. Best Practices
5. Troubleshooting

### Developer Documentation

1. Architecture Overview
2. Extension Points
3. Custom Commands
4. Custom Agents
5. Contributing Guide

## Beispiel-Workflows

### 1. Complete SitePackage Setup

```bash
# Create SitePackage
/typo3:sitepackage corporate --vendor="ACME"

# Add Content Blocks
/typo3:meta:chain \
  "typo3:content-blocks 'Hero' --template='hero-fullwidth'" -> \
  "typo3:content-blocks 'Features' --template='three-columns'" -> \
  "typo3:content-blocks 'CTA' --template='centered-cta'"

# Setup Templates
/typo3:fluid generate-layouts --responsive

# Configure TypoScript
/typo3:typoscript setup-pageview --template="corporate"
```

### 2. Content Blocks Development

```bash
# Analyze Requirements
/typo3:flow:smart "Create testimonial slider with author images and quotes"

# Generate with AI assistance
/typo3:content-blocks generate \
  --ai-enhanced \
  --name="testimonial-slider" \
  --analyze-requirements
```

### 3. Extension Migration

```bash
# Analyze old extension
/typo3:migration analyze EXT:old_extension

# Generate migration plan
/typo3:migration plan --from="11.5" --to="13.4"

# Execute migration
/typo3:migration execute --backup --test
```

## Metriken & Erfolg

### KPIs

- Reduzierung der Entwicklungszeit um 40%
- Konsistente Code-Qualität (PSR-12, TYPO3 Coding Standards)
- 0 Security Issues in generierten Extensions
- 100% TYPO3 v13 Kompatibilität

### Feedback-Kanäle

- GitHub Issues
- TYPO3 Slack
- Extension Repository Reviews
- Community Workshops

## Risiken & Mitigationen

### Risiko 1: TYPO3 Version Updates

**Mitigation**: Versionsspezifische Commands, Continuous Testing

### Risiko 2: Breaking Changes in Content Blocks

**Mitigation**: Version Pinning, Compatibility Layer

### Risiko 3: Komplexität der Integration

**Mitigation**: Phasenweise Entwicklung, Community Feedback

## Nächste Schritte

1. **Immediate Actions**

   - [ ] Review und Approval des Plans
   - [ ] Setup Development Environment
   - [ ] Create Initial Command Structure

2. **Week 1**

   - [ ] Implement SitePackage Command
   - [ ] Basic Testing Framework
   - [ ] Initial Documentation

3. **Week 2**
   - [ ] Content Blocks Command
   - [ ] First AI Agent
   - [ ] Integration Tests

## Anhang

### A. TYPO3 v13 Neue Features

- Site Sets
- PAGEVIEW Content Object
- Improved Backend UX
- Native Dark Mode
- Enhanced Security

### B. Content Blocks v1.3 Changelog

- Collection Child Type Restrictions
- New ViewHelpers (cb:link.editRecord)
- Core Page Type Re-definition
- Default Configuration Support
- Assets Publishing Command

### C. Referenzen

- [TYPO3 v13 Documentation](https://docs.typo3.org/m/typo3/reference-coreapi/13.4/en-us/)
- [Content Blocks Documentation](https://docs.typo3.org/p/friendsoftypo3/content-blocks/main/en-us/)
- [Content Blocks Complete Reference (Single HTML)](https://docs.typo3.org/p/friendsoftypo3/content-blocks/main/en-us/singlehtml/Index.html)
- [Site Package Tutorial](https://docs.typo3.org/m/typo3/tutorial-sitepackage/13.4/en-us/)
- [Site Sets Documentation](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ApiOverview/SiteHandling/SiteSets.html#site-sets-1)
- [Extension Kickstarter Package](https://packagist.org/packages/stefanfroemken/ext-kickstarter)
- [Extension Kickstarter Documentation](https://docs.typo3.org/m/typo3/reference-coreapi/main/en-us/ExtensionArchitecture/Kickstarter/Index.html)
- [TYPO3 Coding Standards](https://docs.typo3.org/m/typo3/reference-coreapi/13.4/en-us/CodingGuidelines/)

---

_Dokument Version: 1.0.0_  
_Erstellt: $(date +"%Y-%m-%d")_  
_Author: Claude Code Toolkit Team_
