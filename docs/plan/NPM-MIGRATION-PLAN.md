commit 5d63a77cef938d50fd340112cb48430110c0c826
Author: Martin Alker <martin.alker@mailbox.org>
Date:   Sat Sep 13 18:47:21 2025 +0200

    📝 docs: revolutionize documentation structure for 6-command architecture
    
    - 🗑️ Archive 36 legacy documentation files (4,581 lines)
    - ✨ Create streamlined USAGE.md and DEVELOPMENT.md (339 lines)
    - 🔄 Update CLAUDE.md for new architecture navigation
    - 📦 Preserve historical docs in archive/ directories
    - 🎯 Align documentation with Knowledge-Driven Revolution
    
    92% documentation reduction while maintaining essential information

diff --git a/docs/planning/NPM-MIGRATION-PLAN.md b/docs/planning/NPM-MIGRATION-PLAN.md
deleted file mode 100644
index 9af500f..0000000
--- a/docs/planning/NPM-MIGRATION-PLAN.md
+++ /dev/null
@@ -1,833 +0,0 @@
-# NPM-Migration Plan: Claude Code Toolkit
-

-## Überblick
-

-Das bestehende Bash-basierte Installationssystem wird zu einem vollständigen NPM-Paket mit interaktivem Installationswizard umgebaut. Dies ermöglicht sowohl globale (`npm install -g`) als auch lokale Installationen mit einem benutzerfreundlichen Setup-Prozess
-

-## Aktuelle Situation
-

-### Bestehende Installation
-

-- **Bash-Script**: `install.sh` mit umfangreichen Optionen
-- **Manuelle Parameter**: CLI-Argumente für Konfiguration
-- **Komplexe Logik**: Backup-Management, Komponenten-Auswahl, Hook-Profile
-- **Interaktive Abfragen**: Y/N Prompts bei Konflikten
-

-### Herausforderungen
-

-- Benutzer müssen Parameter manuell setzen
-- Keine einfache Update-Mechanismus über NPM
-- Keine Integration in bestehende Node.js Workflows
-- Komplexe Installation für neue Benutzer
-

-## Zielarchitektur
-

-### NPM-Package Struktur
-

-```
-@redpop/claude-code-toolkit/
-├── package.json
-├── bin/
-│   └── claude-code-toolkit           # CLI Executable
-├── lib/
-│   ├── wizard.js                     # Interactive Setup Wizard
-│   ├── installer.js                  # Core Installation Logic
-│   ├── config-manager.js             # Configuration Management
-│   ├── file-operations.js            # File System Operations
-│   └── utils.js                      # Helper Functions
-├── commands/                         # Existing Command Structure
-├── agents/                           # Existing Agents
-├── hooks/                            # Existing Hooks
-├── settings/                         # Hook Profile Configurations
-│   ├── basic-hooks-settings.json
-│   ├── minimal-hooks-settings.json
-│   └── advanced-hooks-settings.json
-└── templates/

- └── package-template.json         # Template for package.json
-```
-

-## Technische Implementierung
-

-### 1. Package.json Konfiguration
-

-```json
-{

- "name": "@redpop/claude-code-toolkit",
- "version": "1.0.0",
- "description": "Comprehensive toolkit for extending Claude Code with commands, agents, and automation",
- "main": "lib/index.js",
- "bin": {
- "claude-code-toolkit": "bin/claude-code-toolkit"
- },
- "scripts": {
- "postinstall": "node lib/postinstall.js",
- "test": "jest",
- "lint": "eslint lib/ bin/",
- "prepare": "npm run lint && npm run test"
- },
- "dependencies": {
- "@inquirer/prompts": "^7.8.4",
- "fs-extra": "^11.2.0",
- "chalk": "^5.3.0",
- "ora": "^8.0.1",
- "semver": "^7.6.0"
- },
- "devDependencies": {
- "jest": "^29.7.0",
- "eslint": "^8.56.0"
- },
- "files": [
- "lib/",
- "bin/",
- "commands/",
- "agents/",
- "hooks/",
- "settings/"
- ],
- "keywords": [
- "claude-code",
- "cli",
- "developer-tools",
- "automation",
- "commands"
- ],
- "engines": {
- "node": ">=16.0.0"
- }
-}
-```
-

-### 2. CLI Bin Script (`bin/claude-code-toolkit`)
-

-```javascript
-#!/usr/bin/env node
-

-const { program } = require('commander');
-const chalk = require('chalk');
-const { runWizard } = require('../lib/wizard');
-const { checkInstallation, updateInstallation } = require('../lib/installer')
-

-program

- .name('claude-code-toolkit')
- .description('Claude Code Toolkit - Interactive Installation and Management')
- .version(require('../package.json').version);
-

-program

- .command('setup')
- .description('Run interactive setup wizard')
- .option('-f, --force', 'Force installation without prompts')
- .option('--prefix <prefix>', 'Set prefix without wizard')
- .action(async (options) => {
- try {
-      await runWizard(options);
- } catch (error) {
-      console.error(chalk.red('Setup failed:'), error.message);
-      process.exit(1);
- }
- });
-

-program

- .command('update')
- .description('Update existing installation')
- .action(async () => {
- try {
-      await updateInstallation();
- } catch (error) {
-      console.error(chalk.red('Update failed:'), error.message);
-      process.exit(1);
- }
- });
-

-program

- .command('status')
- .description('Check installation status')
- .action(async () => {
- try {
-      await checkInstallation();
- } catch (error) {
-      console.error(chalk.red('Status check failed:'), error.message);
-      process.exit(1);
- }
- });
-

-program.parse();
-```
-

-### 3. Interactive Wizard (`lib/wizard.js`)
-

-```javascript
-const { input, select, checkbox, confirm } = require('@inquirer/prompts');
-const chalk = require('chalk');
-const path = require('path');
-const os = require('os')
-

-class InstallationWizard {

- constructor() {
- this.config = {
-      prefix: '',
-      installPath: '',
-      components: [],
-      hooksProfile: 'basic',
-      forceInstall: false,
-      isGlobal: true
- };
- }
-
- async run(options = {}) {
- console.log(chalk.blue.bold('\n🚀 Claude Code Toolkit Setup Wizard\n'));
-
- // Skip wizard if force mode with prefix provided
- if (options.force && options.prefix) {
-      this.config.prefix = options.prefix;
-      this.config.forceInstall = true;
-      return this.config;
- }
-
- await this.collectBasicInfo();
- await this.collectInstallationOptions();
- await this.collectComponents();
- await this.collectHooksConfiguration();
- await this.confirmInstallation();
-
- return this.config;
- }
-
- async collectBasicInfo() {
- // Prefix Selection with validation
- this.config.prefix = await input({
-      message: 'Enter your command prefix:',
-      default: this.suggestPrefix(),
-      validate: (input) => {
-        if (!/^[a-zA-Z][a-zA-Z0-9-_]*$/.test(input)) {
-          return 'Prefix must start with a letter and contain only letters, numbers, hyphens, and underscores';
-        }
-        if (input.length < 2 || input.length > 20) {
-          return 'Prefix must be between 2 and 20 characters';
-        }
-        return true;
-      }
- });
-
- // Installation Type
- const installationType = await select({
-      message: 'Installation type:',
-      choices: [
-        { name: 'Global (~/.claude/) - Available in all projects', value: 'global' },
-        { name: 'Local (./claude/) - Project-specific installation', value: 'local' }
-      ],
-      default: 'global'
- });
-
- this.config.isGlobal = installationType === 'global';
- this.config.installPath = this.config.isGlobal
-      ? path.join(os.homedir(), '.claude')
-      : path.join(process.cwd(), '.claude');
- }
-
- async collectInstallationOptions() {
- // Check for existing installation
- const existingInstallation = await this.checkExistingInstallation();
-
- if (existingInstallation) {
-      console.log(chalk.yellow(`\n⚠️  Found existing installation at ${existingInstallation.path}`));
-      console.log(chalk.gray(`   Installed: ${existingInstallation.date}`));
-      console.log(chalk.gray(`   Version: ${existingInstallation.version}`));
-
-      const updateAction = await select({
-        message: 'How do you want to proceed?',
-        choices: [
-          { name: 'Update (merge with existing)', value: 'update' },
-          { name: 'Replace (backup existing)', value: 'replace' },
-          { name: 'Cancel installation', value: 'cancel' }
-        ],
-        default: 'update'
-      });
-
-      if (updateAction === 'cancel') {
-        process.exit(0);
-      }
-
-      this.config.updateMode = updateAction;
- }
- }
-
- async collectComponents() {
- this.config.components = await checkbox({
-      message: 'Select components to install:',
-      choices: [
-        { name: 'Commands (60+ development commands)', value: 'commands', checked: true },
-        { name: 'AI Agents (16+ specialized agents)', value: 'agents', checked: true },
-        { name: 'Automation Hooks (9 hook scripts)', value: 'hooks', checked: true },
-        { name: 'Knowledge Base (TYPO3, patterns, guides)', value: 'knowledge', checked: true }
-      ],
-      validate: (choices) => {
-        if (choices.length === 0) {
-          return 'Please select at least one component';
-        }
-        return true;
-      }
- });
- }
-
- async collectHooksConfiguration() {
- if (!this.config.components.includes('hooks')) {
-      return;
- }
-
- console.log(chalk.cyan('\n📎 Hook Configuration'));
- console.log('Hooks provide automation like notifications, formatting, and logging.\n');
-
- this.config.hooksProfile = await select({
-      message: 'Choose hooks profile:',
-      choices: [
-        { 
-          name: 'Basic - Stop notification only', 
-          value: 'basic',
-          description: 'Simple completion sound'
-        },
-        { 
-          name: 'Minimal - Basic + critical error detection', 
-          value: 'minimal',
-          description: 'Completion sound + security alerts + markdown formatting'
-        },
-        { 
-          name: 'Advanced - Full automation suite', 
-          value: 'advanced',
-          description: 'All hooks: sounds, notifications, logging, formatting'
-        }
-      ],
-      default: 'basic'
- });
-
- // Show what will be activated
- this.displayHookDetails(this.config.hooksProfile);
- }
-
- async confirmInstallation() {
- console.log(chalk.green('\n📋 Installation Summary'));
- console.log(chalk.gray('━'.repeat(50)));
- console.log(`Prefix: ${chalk.yellow(this.config.prefix)}`);
- console.log(`Location: ${chalk.yellow(this.config.installPath)}`);
- console.log(`Components: ${chalk.yellow(this.config.components.join(', '))}`);
-
- if (this.config.components.includes('hooks')) {
-      console.log(`Hooks Profile: ${chalk.yellow(this.config.hooksProfile)}`);
- }
-
- console.log(chalk.gray('━'.repeat(50)));
-
- const confirmed = await confirm({
-      message: 'Proceed with installation?',
-      default: true
- });
-
- if (!confirmed) {
-      console.log(chalk.yellow('Installation cancelled.'));
-      process.exit(0);
- }
- }
-
- suggestPrefix() {
- // Try to suggest based on current directory or package.json
- const cwd = path.basename(process.cwd()).toLowerCase();
- if (cwd && cwd !== 'home') {
-      return cwd.replace(/[^a-zA-Z0-9-_]/g, '').substring(0, 15) || 'toolkit';
- }
- return 'toolkit';
- }
-
- async checkExistingInstallation() {
- // Implementation to check for existing installations
- // Returns { path, date, version } or null
- }
-
- displayHookDetails(profile) {
- const profiles = {
-      basic: [
-        '• stop-notification.sh - Completion sound',
-        '• markdown-format.sh - Auto-format .md files'
-      ],
-      minimal: [
-        '• stop-notification.sh - Completion sound',
-        '• error-detection.sh - Security/vulnerability alerts',
-        '• markdown-format.sh - Auto-format .md files'
-      ],
-      advanced: [
-        '• All notification hooks (completion, success, errors)',
-        '• Tool-specific sounds and system notifications',
-        '• Command chain progress tracking',
-        '• Session logging and metrics',
-        '• Automatic markdown formatting'
-      ]
- };
-
- console.log(chalk.gray(`\nActivated hooks for ${profile} profile:`));
- profiles[profile].forEach(hook => {
-      console.log(chalk.gray(`  ${hook}`));
- });
- }
-}
-

-module.exports = { InstallationWizard };
-```
-

-### 4. Installation Logic (`lib/installer.js`)
-

-```javascript
-const fs = require('fs-extra');
-const path = require('path');
-const chalk = require('chalk');
-const ora = require('ora')
-

-class Installer {

- constructor(config) {
- this.config = config;
- this.spinner = ora();
- }
-
- async install() {
- try {
-      await this.preparePaths();
-      await this.backupExisting();
-      await this.installComponents();
-      await this.configureHooks();
-      await this.saveInstallationInfo();
-      await this.displayResults();
- } catch (error) {
-      this.spinner.fail('Installation failed');
-      throw error;
- }
- }
-
- async preparePaths() {
- this.spinner.start('Preparing installation paths...');
-
- const paths = {
-      commands: path.join(this.config.installPath, 'commands', this.config.prefix),
-      agents: path.join(this.config.installPath, 'agents'),
-      toolkit: path.join(this.config.installPath, 'claude-code-toolkit')
- };
-
- // Create directories
- for (const [name, dir] of Object.entries(paths)) {
-      await fs.ensureDir(dir);
- }
-
- this.paths = paths;
- this.spinner.succeed('Paths prepared');
- }
-
- async backupExisting() {
- if (this.config.updateMode === 'replace') {
-      this.spinner.start('Creating backup...');
-
-      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
-      const backupPath = `${this.config.installPath}.backup.${timestamp}`;
-
-      if (await fs.pathExists(this.config.installPath)) {
-        await fs.copy(this.config.installPath, backupPath);
-        this.spinner.succeed(`Backup created: ${backupPath}`);
-      }
- }
- }
-
- async installComponents() {
- const packageRoot = path.join(__dirname, '..');
-
- for (const component of this.config.components) {
-      await this.installComponent(component, packageRoot);
- }
- }
-
- async installComponent(component, packageRoot) {
- this.spinner.start(`Installing ${component}...`);
-
- const sourcePath = path.join(packageRoot, component);
- let targetPath;
-
- switch (component) {
-      case 'commands':
-        targetPath = this.paths.commands;
-        await this.copyCommands(sourcePath, targetPath);
-        break;
-      case 'agents':
-        targetPath = this.paths.agents;
-        await this.copyAgents(sourcePath, targetPath);
-        break;
-      case 'hooks':
-        targetPath = path.join(this.paths.toolkit, 'hooks');
-        await this.copyHooks(sourcePath, targetPath);
-        break;
-      case 'knowledge':
-        targetPath = path.join(this.paths.toolkit, 'knowledge-base');
-        await this.copyKnowledgeBase(sourcePath, targetPath);
-        break;
- }
-
- this.spinner.succeed(`${component} installed`);
- }
-
- async copyCommands(source, target) {
- await fs.ensureDir(target);
-
- // Copy all .md files except CLAUDE.md, preserving structure
- const copyFilter = (src) => {
-      const basename = path.basename(src);
-      return basename !== 'CLAUDE.md';
- };
-
- await fs.copy(source, target, { filter: copyFilter });
- }
-
- async copyAgents(source, target) {
- await fs.ensureDir(target);
-
- // Copy all .md files except CLAUDE.md
- const files = await fs.readdir(source);
- const mdFiles = files.filter(file =>
-      file.endsWith('.md') && file !== 'CLAUDE.md'
- );
-
- for (const file of mdFiles) {
-      await fs.copy(
-        path.join(source, file),
-        path.join(target, file)
-      );
- }
- }
-
- async configureHooks() {
- if (!this.config.components.includes('hooks')) {
-      return;
- }
-
- this.spinner.start('Configuring hooks...');
-
- const settingsPath = path.join(this.config.installPath, 'settings.json');
- const profilePath = path.join(
-      __dirname, 
-      '..', 
-      'settings', 
-      `${this.config.hooksProfile}-hooks-settings.json`
- );
-
- if (await fs.pathExists(profilePath)) {
-      const profileSettings = await fs.readJson(profilePath);
-
-      // Merge with existing settings if any
-      let existingSettings = {};
-      if (await fs.pathExists(settingsPath)) {
-        existingSettings = await fs.readJson(settingsPath);
-      }
-
-      const mergedSettings = {
-        ...existingSettings,
-        ...profileSettings,
-        $schema: 'https://json.schemastore.org/claude-code-settings.json'
-      };
-
-      await fs.writeJson(settingsPath, mergedSettings, { spaces: 2 });
- }
-
- this.spinner.succeed('Hooks configured');
- }
-
- async saveInstallationInfo() {
- const versionInfo = {
-      version: require('../package.json').version,
-      installedAt: new Date().toISOString(),
-      prefix: this.config.prefix,
-      components: this.config.components,
-      hooksProfile: this.config.hooksProfile,
-      installPath: this.config.installPath
- };
-
- const versionFile = path.join(this.paths.toolkit, '.installed-version');
- await fs.writeJson(versionFile, versionInfo, { spaces: 2 });
- }
-
- async displayResults() {
- console.log(chalk.green('\n✅ Installation completed successfully!\n'));
-
- if (this.config.components.includes('commands')) {
-      console.log(chalk.cyan('Available Commands:'));
-      await this.displayCommands();
- }
-
- if (this.config.components.includes('agents')) {
-      console.log(chalk.cyan('\nAvailable AI Agents:'));
-      await this.displayAgents();
- }
-
- console.log(chalk.yellow('\n🚀 Getting Started:'));
- console.log(`Type ${chalk.green('/')} in Claude Code to see your commands`);
- console.log(`Example: ${chalk.green(`/${this.config.prefix}:scan:deep .`)}`);
-
- if (this.config.isGlobal) {
-      console.log('\n📍 Global installation - available in all projects');
- } else {
-      console.log('\n📍 Local installation - available in this project only');
- }
- }
-
- async displayCommands() {
- // Scan and display available commands
- const commandsPath = this.paths.commands;
- if (await fs.pathExists(commandsPath)) {
-      const commands = await this.scanCommands(commandsPath);
-      commands.forEach(cmd => {
-        console.log(`  ${chalk.gray('→')} /${this.config.prefix}:${cmd}`);
-      });
- }
- }
-
- async scanCommands(dir, prefix = '') {
- const commands = [];
- const items = await fs.readdir(dir, { withFileTypes: true });
-
- for (const item of items) {
-      if (item.isDirectory()) {
-        const subCommands = await this.scanCommands(
-          path.join(dir, item.name),
-          prefix ? `${prefix}:${item.name}` : item.name
-        );
-        commands.push(...subCommands);
-      } else if (item.name.endsWith('.md')) {
-        const commandName = item.name.replace('.md', '');
-        commands.push(prefix ? `${prefix}:${commandName}` : commandName);
-      }
- }
-
- return commands.sort();
- }
-}
-

-module.exports = { Installer };
-```
-

-### 5. PostInstall Script (`lib/postinstall.js`)
-

-```javascript
-const { InstallationWizard } = require('./wizard');
-const { Installer } = require('./installer');
-const chalk = require('chalk')
-

-async function postInstall() {

- // Skip in non-interactive environments (CI/CD)
- if (!process.stdin.isTTY || process.env.CI) {
- console.log(chalk.yellow('Non-interactive environment detected.'));
- console.log('Run `claude-code-toolkit setup` manually to configure.');
- return;
- }
-
- try {
- console.log(chalk.blue('🎉 Welcome to Claude Code Toolkit!'));
- console.log('Starting interactive setup...\n');
-
- const wizard = new InstallationWizard();
- const config = await wizard.run();
-
- const installer = new Installer(config);
- await installer.install();
-
- } catch (error) {
- if (error.message === 'User force closed the prompt with 0 null') {
-      console.log(chalk.yellow('\nSetup cancelled by user.'));
-      console.log('Run `claude-code-toolkit setup` later to configure.');
-      return;
- }
-
- console.error(chalk.red('Setup failed:'), error.message);
- console.log(chalk.gray('Run `claude-code-toolkit setup` to try again.'));
- process.exit(1);
- }
-}
-

-// Only run if this script is executed directly
-if (require.main === module) {

- postInstall();
-}
-

-module.exports = { postInstall };
-```
-

-## Installation Flows
-

-### 1. Globale Installation
-

-```bash
-# Installation
-npm install -g @redpop/claude-code-toolkit
-

-# Automatischer postinstall wizard läuft
-# → Interactive setup für ~/.claude/
-

-# Spätere Konfiguration
-claude-code-toolkit setup
-

-# Updates
-npm update -g @redpop/claude-code-toolkit
-claude-code-toolkit update
-```
-

-### 2. Lokale Projekt-Installation
-

-```bash
-# In einem Projekt
-npm install @redpop/claude-code-toolkit
-

-# Lokales Setup
-npx claude-code-toolkit setup
-

-# Oder als dev dependency
-npm install --save-dev @redpop/claude-code-toolkit
-```
-

-### 3. Programmatische Installation
-

-```javascript
-const { InstallationWizard, Installer } = require('@redpop/claude-code-toolkit')
-

-const wizard = new InstallationWizard();
-const config = await wizard.run({

- prefix: 'myteam',
- force: true
-});
-

-const installer = new Installer(config);
-await installer.install();
-```
-

-## Migration und Kompatibilität
-

-### Backwards Compatibility
-

-- **Bestehende install.sh bleibt funktional**
-- **Schrittweise Migration möglich**
-- **Dokumentation für beide Wege**
-

-### Migrationspfad
-

-1. NPM-Package als Alternative einführen
-2. Dokumentation für beide Installationsmethoden
-3. Langfristig NPM als Hauptweg etablieren
-4. install.sh als Legacy-Option erhalten
-

-### Update-Strategie
-

-- **Automatische Erkennung** bestehender Installationen
-- **Intelligentes Merging** von Konfigurationen
-- **Backup-Erhaltung** bei Updates
-- **Rollback-Möglichkeiten**
-

-## Vorteile der NPM-Migration
-

-### Für Benutzer
-

-- **Einfache Installation**: `npm install -g @redpop/claude-code-toolkit`
-- **Automatische Updates**: Standard NPM update workflow
-- **Interaktiver Setup**: Benutzerfreundlicher Wizard
-- **Bessere Integration**: In bestehende Node.js Projekte
-- **Versionierung**: Semantic versioning mit NPM
-

-### Für Entwicklung
-

-- **Standard Tooling**: NPM ecosystem
-- **Dependency Management**: Automatische handling von Abhängigkeiten  
-- **Testing Framework**: Jest für automatisierte Tests
-- **CI/CD Integration**: Standard NPM publishing workflow
-- **Distribution**: NPM registry für einfache Verteilung
-

-### Technische Vorteile
-

-- **Cross-Platform**: Node.js läuft überall wo Claude Code läuft
-- **Robuste Fehlerbehandlung**: Moderne async/await patterns
-- **Modulare Architektur**: Klare Trennung von Verantwortlichkeiten
-- **Testbarkeit**: Unit tests für alle Komponenten
-- **Wartbarkeit**: TypeScript support möglich
-

-## Implementierungsschritte
-

-### Phase 1: Grundstruktur (Woche 1-2)
-

-1. ✅ NPM package.json erstellen
-2. ✅ Basis-CLI script implementieren
-3. ✅ Grundlegende Installer-Logik portieren
-4. ✅ File operations aus install.sh übernehmen
-

-### Phase 2: Interactive Wizard (Woche 3)
-

-1. ✅ @inquirer/prompts Integration
-2. ✅ Wizard-Flow implementieren
-3. ✅ Validierung und Fehlerbehandlung
-4. ✅ Benutzerfreundliche Prompts
-

-### Phase 3: Advanced Features (Woche 4)
-

-1. ✅ Update-Mechanismus
-2. ✅ Backup und Recovery
-3. ✅ Hook-Profil Management
-4. ✅ Status und Diagnose Commands
-

-### Phase 4: Testing und Polish (Woche 5)
-

-1. ✅ Umfassende Tests schreiben
-2. ✅ Error handling verbessern
-3. ✅ Dokumentation erstellen
-4. ✅ Beta testing mit ausgewählten Nutzern
-

-### Phase 5: Release und Migration (Woche 6)
-

-1. ✅ NPM package veröffentlichen
-2. ✅ Migrationsdokumentation
-3. ✅ Backwards compatibility testen
-4. ✅ Community feedback sammeln
-

-## Risiken und Mitigation
-

-### Technische Risiken
-

-- **Node.js Dependency**: Alle Claude Code Nutzer müssen Node.js haben

- *Mitigation*: Node.js ist meist bereits installiert für moderne Entwicklung
-- **Platform Compatibility**: Unterschiedliche OS-Verhalten
- *Mitigation*: Extensive cross-platform testing
-- **Permission Issues**: File system access in verschiedenen Umgebungen
- *Mitigation*: Graceful error handling und alternative Pfade
-

-### User Experience Risiken  
-

-- **Migration Friction**: Nutzer müssen sich an neuen Workflow gewöhnen

- *Mitigation*: Klare Dokumentation und schrittweise Migration
-- **Complexity**: NPM ecosystem könnte einschüchtern
- *Mitigation*: Einfache Getting-Started guides
-

-### Organisatorische Risiken
-

-- **Maintenance Overhead**: Zwei Installationswege parallel maintainen

- *Mitigation*: Zeitplan für schrittweisen sunset der install.sh
-- **Breaking Changes**: NPM updates könnten Kompatibilität brechen
- *Mitigation*: Semantic versioning und extensive testing
-

-## Erfolgsmessung
-

-### Quantitative Metriken
-

-- **Adoption Rate**: NPM downloads vs. GitHub clones
-- **User Feedback**: GitHub issues/discussions
-- **Installation Success Rate**: Fehlerrate bei Setup
-- **Update Frequency**: Wie oft nutzen User Updates
-

-### Qualitative Metriken  
-

-- **User Experience**: Feedback zu Setup-Prozess
-- **Developer Experience**: Maintainer feedback
-- **Community Engagement**: Contributions und Forks
-- **Documentation Quality**: Support-Anfragen Reduktion
-

-## Fazit
-

-Die Migration zu einem NPM-Package bietet erhebliche Vorteile für sowohl Nutzer als auch Maintainer. Der interaktive Wizard macht die Installation benutzerfreundlicher, während die NPM-Integration den Standard-Workflow für Node.js Entwickler folgt
-

-Die schrittweise Migrationsstrategie minimiert Risiken und ermöglicht es, Feedback zu sammeln und das System iterativ zu verbessern. Die bestehende install.sh bleibt als Fallback erhalten, bis die NPM-Version vollständig etabliert ist
-

-**Empfehlung**: Proceed with implementation - die Vorteile überwiegen klar die Kosten und Risiken.
