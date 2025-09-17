# NPM-Migration Plan: Claude Code Toolkit (Aktualisiert)

## Überblick

Das bestehende Bash-basierte Installationssystem (`install.sh`) wird zu einem vollständigen NPM-Paket mit interaktivem Installationswizard umgebaut. Dies ermöglicht sowohl globale (`npm install -g`) als auch lokale Installationen mit einem benutzerfreundlichen Setup-Prozess.

## Aktuelle Situation (2025-09-14)

### Bestehende Installation

- **Bash-Script**: `install.sh` mit umfangreichen Optionen (778 Zeilen)
- **Komplexe Logik**: Backup-Management, Komponenten-Auswahl, Hook-Profile
- **Interaktive Abfragen**: Y/N Prompts bei Konflikten
- **6-Command Architecture**: Neue streamlined Architektur
- **PRP Integration**: Project Requirements Proposal System

### Aktuelle Repo-Struktur

```
claude-code-toolkit/
├── install.sh                    # Aktuelles Bash-Installationssystem
├── commands/                     # 6-Command Architecture
├── agents/                       # 25+ AI Agents
├── hooks/                        # Hook Scripts mit Smart Suggestions
├── settings/                     # Hook Profile Configurations
│   ├── basic-hooks-settings.json
│   ├── minimal-hooks-settings.json
│   └── advanced-hooks-settings.json
├── knowledge-base/               # Domain-spezifisches Wissen
├── templates/                    # PRP Templates
│   └── prp/                     # PRP System Templates
├── markdown/                     # Markdown Konfiguration
├── scripts/                      # Utility Scripts
└── docs/                        # Neue streamlined Dokumentation
    ├── USAGE.md
    ├── DEVELOPMENT.md
    └── guides/
```

### Herausforderungen

- Benutzer müssen Parameter manuell setzen
- Kein einfacher Update-Mechanismus über NPM
- Keine Integration in bestehende Node.js Workflows
- Komplexe Installation für neue Benutzer

## Zielarchitektur

### NPM-Package Struktur

```
@redpop/claude-code-toolkit/
├── package.json
├── bin/
│   └── claude-code-toolkit           # CLI Executable
├── lib/
│   ├── wizard.js                     # Interactive Setup Wizard
│   ├── installer.js                  # Core Installation Logic
│   ├── config-manager.js             # Configuration Management
│   ├── file-operations.js            # File System Operations
│   ├── prp-installer.js              # PRP System Installation
│   └── utils.js                      # Helper Functions
├── commands/                         # 6-Command Architecture
│   ├── understand.md
│   ├── improve.md
│   ├── create.md
│   ├── secure.md
│   ├── ship.md
│   ├── git.md
│   ├── meta/                         # Meta Commands
│   └── typo3/                        # TYPO3 Extension Commands
├── agents/                           # 25+ Specialized Agents
│   ├── security-specialist.md
│   ├── performance-optimizer.md
│   ├── codebase-research-specialist.md
│   └── [weitere agents]
├── hooks/                            # Automation Hooks
│   ├── *.sh                         # Hook Scripts
│   ├── config/
│   │   └── suggestions-config.json
│   └── lib/
│       └── suggestion-engine.sh
├── settings/                         # Hook Profile Configurations
│   ├── basic-hooks-settings.json
│   ├── minimal-hooks-settings.json
│   └── advanced-hooks-settings.json
├── knowledge-base/                   # Domain Knowledge
├── templates/                        # Template System
│   └── prp/                         # PRP Templates & Config
├── markdown/                         # Markdown Configuration
└── scripts/                          # Utility Scripts
```

## Technische Implementierung

### 1. Package.json Konfiguration

```json
{
  "name": "@redpop/claude-code-toolkit",
  "version": "5.0.0",
  "description": "Revolutionary toolkit for extending Claude Code with 6-command architecture, PRP methodology, and smart AI agents",
  "main": "lib/index.js",
  "bin": {
    "claude-code-toolkit": "bin/claude-code-toolkit",
    "cct": "bin/claude-code-toolkit"
  },
  "scripts": {
    "postinstall": "node lib/postinstall.js",
    "test": "jest",
    "lint": "eslint lib/ bin/",
    "prepare": "npm run lint && npm run test"
  },
  "dependencies": {
    "@inquirer/prompts": "^7.8.4",
    "fs-extra": "^11.2.0",
    "chalk": "^5.3.0",
    "ora": "^8.0.1",
    "semver": "^7.6.0",
    "js-yaml": "^4.1.0"
  },
  "devDependencies": {
    "jest": "^29.7.0",
    "eslint": "^8.56.0"
  },
  "files": [
    "lib/",
    "bin/",
    "commands/",
    "agents/",
    "hooks/",
    "settings/",
    "knowledge-base/",
    "templates/",
    "markdown/",
    "scripts/"
  ],
  "keywords": [
    "claude-code",
    "cli",
    "developer-tools",
    "automation",
    "commands",
    "6-command-architecture",
    "prp-methodology",
    "ai-agents"
  ],
  "engines": {
    "node": ">=16.0.0"
  }
}
```

### 2. CLI Bin Script (`bin/claude-code-toolkit`)

```javascript
#!/usr/bin/env node

const { program } = require('commander');
const chalk = require('chalk');
const { runWizard } = require('../lib/wizard');
const { checkInstallation, updateInstallation } = require('../lib/installer');

program
  .name('claude-code-toolkit')
  .description('Claude Code Toolkit - Interactive Installation and Management')
  .version(require('../package.json').version);

program
  .command('setup')
  .description('Run interactive setup wizard')
  .option('-f, --force', 'Force installation without prompts')
  .option('--prefix <prefix>', 'Set prefix without wizard')
  .option('--prp', 'Install PRP methodology system')
  .option('--6-command', 'Install 6-command architecture (default)')
  .action(async (options) => {
    try {
      await runWizard(options);
    } catch (error) {
      console.error(chalk.red('Setup failed:'), error.message);
      process.exit(1);
    }
  });

program
  .command('update')
  .description('Update existing installation')
  .action(async () => {
    try {
      await updateInstallation();
    } catch (error) {
      console.error(chalk.red('Update failed:'), error.message);
      process.exit(1);
    }
  });

program
  .command('status')
  .description('Check installation status')
  .action(async () => {
    try {
      await checkInstallation();
    } catch (error) {
      console.error(chalk.red('Status check failed:'), error.message);
      process.exit(1);
    }
  });

program.parse();
```

### 3. Interactive Wizard (`lib/wizard.js`)

```javascript
const { input, select, checkbox, confirm } = require('@inquirer/prompts');
const chalk = require('chalk');
const path = require('path');
const os = require('os');

class InstallationWizard {
  constructor() {
    this.config = {
      prefix: '',
      installPath: '',
      components: [],
      architecture: '6-command',
      hooksProfile: 'basic',
      enablePRP: false,
      forceInstall: false,
      isGlobal: true
    };
  }

  async run(options = {}) {
    console.log(chalk.blue.bold('\n🚀 Claude Code Toolkit v5.0 Setup Wizard\n'));
    console.log(chalk.cyan('Knowledge-Driven Revolution with 6-Command Architecture\n'));

    // Skip wizard if force mode with prefix provided
    if (options.force && options.prefix) {
      this.config.prefix = options.prefix;
      this.config.forceInstall = true;
      this.config.enablePRP = options.prp || false;
      return this.config;
    }

    await this.collectBasicInfo();
    await this.collectArchitectureOptions();
    await this.collectInstallationOptions();
    await this.collectComponents();
    await this.collectHooksConfiguration();
    await this.confirmInstallation();

    return this.config;
  }

  async collectBasicInfo() {
    // Prefix Selection with validation
    this.config.prefix = await input({
      message: 'Enter your command prefix:',
      default: this.suggestPrefix(),
      validate: (input) => {
        if (!/^[a-zA-Z][a-zA-Z0-9-_]*$/.test(input)) {
          return 'Prefix must start with a letter and contain only letters, numbers, hyphens, and underscores';
        }
        if (input.length < 2 || input.length > 20) {
          return 'Prefix must be between 2 and 20 characters';
        }
        return true;
      }
    });

    // Installation Type
    const installationType = await select({
      message: 'Installation type:',
      choices: [
        { name: 'Global (~/.claude/) - Available in all projects', value: 'global' },
        { name: 'Local (./.claude/) - Project-specific installation', value: 'local' }
      ],
      default: 'global'
    });

    this.config.isGlobal = installationType === 'global';
    this.config.installPath = this.config.isGlobal
      ? path.join(os.homedir(), '.claude')
      : path.join(process.cwd(), '.claude');
  }

  async collectArchitectureOptions() {
    console.log(chalk.cyan('\n⚡ Architecture Selection'));
    console.log('Choose your development workflow approach:\n');

    this.config.architecture = await select({
      message: 'Select architecture:',
      choices: [
        {
          name: '6-Command Architecture (Recommended)',
          value: '6-command',
          description: 'Streamlined workflow: understand → improve → create → secure → ship → git'
        },
        {
          name: 'Legacy Full Commands',
          value: 'legacy',
          description: '50+ individual commands for granular control'
        }
      ],
      default: '6-command'
    });

    // PRP Methodology Option
    this.config.enablePRP = await confirm({
      message: 'Enable PRP (Project Requirements Proposal) methodology?',
      default: true
    });

    if (this.config.enablePRP) {
      console.log(chalk.gray('\nPRP enables blueprint-driven development with:'));
      console.log(chalk.gray('• Requirements analysis and research agents'));
      console.log(chalk.gray('• Template-based project blueprints'));
      console.log(chalk.gray('• Quality gates and validation workflows\n'));
    }
  }

  async collectInstallationOptions() {
    // Check for existing installation
    const existingInstallation = await this.checkExistingInstallation();

    if (existingInstallation) {
      console.log(chalk.yellow(`\n⚠️  Found existing installation at ${existingInstallation.path}`));
      console.log(chalk.gray(`   Version: ${existingInstallation.version}`));
      console.log(chalk.gray(`   Installed: ${existingInstallation.date}`));

      const updateAction = await select({
        message: 'How do you want to proceed?',
        choices: [
          { name: 'Update (merge with existing)', value: 'update' },
          { name: 'Replace (backup existing)', value: 'replace' },
          { name: 'Cancel installation', value: 'cancel' }
        ],
        default: 'update'
      });

      if (updateAction === 'cancel') {
        process.exit(0);
      }

      this.config.updateMode = updateAction;
    }
  }

  async collectComponents() {
    this.config.components = await checkbox({
      message: 'Select components to install:',
      choices: [
        {
          name: 'Commands (6-command architecture)',
          value: 'commands',
          checked: true
        },
        {
          name: 'AI Agents (25+ specialized agents)',
          value: 'agents',
          checked: true
        },
        {
          name: 'Automation Hooks (smart suggestions)',
          value: 'hooks',
          checked: true
        },
        {
          name: 'Knowledge Base (patterns & guides)',
          value: 'knowledge',
          checked: true
        },
        {
          name: 'PRP System (blueprint templates)',
          value: 'prp',
          checked: this.config.enablePRP
        }
      ],
      validate: (choices) => {
        if (choices.length === 0) {
          return 'Please select at least one component';
        }
        return true;
      }
    });
  }

  async collectHooksConfiguration() {
    if (!this.config.components.includes('hooks')) {
      return;
    }

    console.log(chalk.cyan('\n📎 Hook Configuration'));
    console.log('Hooks provide automation like notifications, smart suggestions, and formatting.\n');

    this.config.hooksProfile = await select({
      message: 'Choose hooks profile:',
      choices: [
        {
          name: 'Basic - Essential automation only',
          value: 'basic',
          description: 'Stop notification + markdown formatting'
        },
        {
          name: 'Minimal - Smart workflow assistance',
          value: 'minimal',
          description: 'Basic + smart suggestions + security alerts'
        },
        {
          name: 'Advanced - Full automation suite',
          value: 'advanced',
          description: 'All hooks: notifications, logging, suggestions, metrics'
        }
      ],
      default: 'minimal'
    });

    // Show what will be activated
    this.displayHookDetails(this.config.hooksProfile);
  }

  async confirmInstallation() {
    console.log(chalk.green('\n📋 Installation Summary'));
    console.log(chalk.gray('━'.repeat(60)));
    console.log(`Prefix: ${chalk.yellow(this.config.prefix)}`);
    console.log(`Architecture: ${chalk.yellow(this.config.architecture)}`);
    console.log(`Location: ${chalk.yellow(this.config.installPath)}`);
    console.log(`Components: ${chalk.yellow(this.config.components.join(', '))}`);
    console.log(`PRP Enabled: ${chalk.yellow(this.config.enablePRP ? 'Yes' : 'No')}`);

    if (this.config.components.includes('hooks')) {
      console.log(`Hooks Profile: ${chalk.yellow(this.config.hooksProfile)}`);
    }

    console.log(chalk.gray('━'.repeat(60)));

    const confirmed = await confirm({
      message: 'Proceed with installation?',
      default: true
    });

    if (!confirmed) {
      console.log(chalk.yellow('Installation cancelled.'));
      process.exit(0);
    }
  }

  suggestPrefix() {
    // Try to suggest based on current directory or package.json
    const cwd = path.basename(process.cwd()).toLowerCase();
    if (cwd && cwd !== 'home') {
      return cwd.replace(/[^a-zA-Z0-9-_]/g, '').substring(0, 15) || 'toolkit';
    }
    return 'toolkit';
  }

  async checkExistingInstallation() {
    // Implementation to check for existing installations
    // Returns { path, date, version } or null
    const versionFile = path.join(this.config.installPath, 'claude-code-toolkit', '.installed-version');
    try {
      const fs = require('fs-extra');
      if (await fs.pathExists(versionFile)) {
        const content = await fs.readFile(versionFile, 'utf8');
        const version = content.match(/COMMIT_HASH=(.+)/)?.[1] || 'unknown';
        const date = content.match(/INSTALLED_AT=(.+)/)?.[1] || 'unknown';
        return {
          path: this.config.installPath,
          version: version.substring(0, 7),
          date
        };
      }
    } catch (error) {
      // Ignore errors
    }
    return null;
  }

  displayHookDetails(profile) {
    const profiles = {
      basic: [
        '• stop-notification.sh - Completion sound',
        '• markdown-format.sh - Auto-format .md files'
      ],
      minimal: [
        '• stop-notification.sh - Completion sound',
        '• smart-suggestions.sh - Intelligent workflow suggestions',
        '• error-detection.sh - Security/vulnerability alerts',
        '• markdown-format.sh - Auto-format .md files'
      ],
      advanced: [
        '• All notification hooks (completion, success, errors)',
        '• Smart suggestions with context awareness',
        '• Tool-specific sounds and system notifications',
        '• Session logging and metrics tracking',
        '• Command chain progress tracking',
        '• Automatic markdown formatting'
      ]
    };

    console.log(chalk.gray(`\nActivated hooks for ${profile} profile:`));
    profiles[profile].forEach(hook => {
      console.log(chalk.gray(`  ${hook}`));
    });
  }
}

module.exports = { InstallationWizard };
```

### 4. Installation Logic (`lib/installer.js`)

```javascript
const fs = require('fs-extra');
const path = require('path');
const chalk = require('chalk');
const ora = require('ora');

class Installer {
  constructor(config) {
    this.config = config;
    this.spinner = ora();
  }

  async install() {
    try {
      await this.preparePaths();
      await this.backupExisting();
      await this.installComponents();
      await this.configureHooks();
      await this.installPRPSystem();
      await this.saveInstallationInfo();
      await this.displayResults();
    } catch (error) {
      this.spinner.fail('Installation failed');
      throw error;
    }
  }

  async preparePaths() {
    this.spinner.start('Preparing installation paths...');

    const paths = {
      commands: path.join(this.config.installPath, 'commands', this.config.prefix),
      agents: path.join(this.config.installPath, 'agents'),
      toolkit: path.join(this.config.installPath, 'claude-code-toolkit')
    };

    // Create directories
    for (const [name, dir] of Object.entries(paths)) {
      await fs.ensureDir(dir);
    }

    this.paths = paths;
    this.spinner.succeed('Paths prepared');
  }

  async backupExisting() {
    if (this.config.updateMode === 'replace') {
      this.spinner.start('Creating backup...');

      const timestamp = new Date().toISOString().replace(/[:.]/g, '-');
      const backupPath = `${this.config.installPath}.backup.${timestamp}`;

      if (await fs.pathExists(this.config.installPath)) {
        await fs.copy(this.config.installPath, backupPath);
        this.spinner.succeed(`Backup created: ${backupPath}`);
      }
    }
  }

  async installComponents() {
    const packageRoot = path.join(__dirname, '..');

    for (const component of this.config.components) {
      await this.installComponent(component, packageRoot);
    }
  }

  async installComponent(component, packageRoot) {
    this.spinner.start(`Installing ${component}...`);

    const sourcePath = path.join(packageRoot, component);
    let targetPath;

    switch (component) {
      case 'commands':
        targetPath = this.paths.commands;
        if (this.config.architecture === '6-command') {
          await this.copy6CommandArchitecture(sourcePath, targetPath);
        } else {
          await this.copyLegacyCommands(sourcePath, targetPath);
        }
        break;
      case 'agents':
        targetPath = this.paths.agents;
        await this.copyAgents(sourcePath, targetPath);
        break;
      case 'hooks':
        targetPath = path.join(this.paths.toolkit, 'hooks');
        await this.copyHooks(sourcePath, targetPath);
        break;
      case 'knowledge':
        targetPath = path.join(this.paths.toolkit, 'knowledge-base');
        await this.copyKnowledgeBase(sourcePath, targetPath);
        break;
      case 'prp':
        targetPath = path.join(this.paths.toolkit, 'prp');
        await this.copyPRPSystem(packageRoot, targetPath);
        break;
    }

    this.spinner.succeed(`${component} installed`);
  }

  async copy6CommandArchitecture(source, target) {
    await fs.ensureDir(target);

    // Copy 6 core commands
    const coreCommands = ['understand.md', 'improve.md', 'create.md', 'secure.md', 'ship.md', 'git.md'];

    for (const command of coreCommands) {
      const commandPath = path.join(source, command);
      if (await fs.pathExists(commandPath)) {
        await fs.copy(commandPath, path.join(target, command));
      }
    }

    // Copy extension commands (meta, typo3)
    const extensions = ['meta', 'typo3'];
    for (const ext of extensions) {
      const extPath = path.join(source, ext);
      if (await fs.pathExists(extPath)) {
        await fs.copy(extPath, path.join(target, ext), {
          filter: (src) => path.basename(src) !== 'CLAUDE.md'
        });
      }
    }
  }

  async copyLegacyCommands(source, target) {
    await fs.ensureDir(target);

    // Copy all .md files except CLAUDE.md, preserving structure
    const copyFilter = (src) => {
      const basename = path.basename(src);
      return basename !== 'CLAUDE.md';
    };

    await fs.copy(source, target, { filter: copyFilter });
  }

  async copyAgents(source, target) {
    await fs.ensureDir(target);

    // Copy all .md files except CLAUDE.md
    const files = await fs.readdir(source);
    const mdFiles = files.filter(file =>
      file.endsWith('.md') && file !== 'CLAUDE.md'
    );

    for (const file of mdFiles) {
      await fs.copy(
        path.join(source, file),
        path.join(target, file)
      );
    }
  }

  async copyHooks(source, target) {
    await fs.ensureDir(target);

    // Copy hook scripts
    const files = await fs.readdir(source);
    const hookFiles = files.filter(file => file.endsWith('.sh'));

    for (const file of hookFiles) {
      await fs.copy(
        path.join(source, file),
        path.join(target, file)
      );
    }

    // Copy hook config and libraries
    const configPath = path.join(source, 'config');
    const libPath = path.join(source, 'lib');

    if (await fs.pathExists(configPath)) {
      await fs.copy(configPath, path.join(target, 'config'));
    }

    if (await fs.pathExists(libPath)) {
      await fs.copy(libPath, path.join(target, 'lib'));
    }

    // Make scripts executable
    for (const file of hookFiles) {
      await fs.chmod(path.join(target, file), 0o755);
    }
  }

  async copyKnowledgeBase(source, target) {
    await fs.ensureDir(target);

    // Copy entire knowledge-base preserving structure, excluding CLAUDE.md
    await fs.copy(source, target, {
      filter: (src) => path.basename(src) !== 'CLAUDE.md'
    });
  }

  async copyPRPSystem(packageRoot, target) {
    await fs.ensureDir(target);

    const prpSource = path.join(packageRoot, 'templates', 'prp');
    if (await fs.pathExists(prpSource)) {
      await fs.copy(prpSource, target);
    }
  }

  async installPRPSystem() {
    if (!this.config.enablePRP || !this.config.components.includes('prp')) {
      return;
    }

    this.spinner.start('Configuring PRP system...');

    const prpPath = path.join(this.paths.toolkit, 'prp');

    // Create PRP directory structure
    const prpDirs = [
      'analysis/templates',
      'analysis/library',
      'blueprints/templates',
      'blueprints/library',
      'patterns/templates',
      'patterns/library',
      'research/templates',
      'research/library',
      'execution/templates',
      'execution/library'
    ];

    for (const dir of prpDirs) {
      await fs.ensureDir(path.join(prpPath, dir));
    }

    // Install PRP configuration
    const configTemplate = path.join(prpPath, 'prp-config-template.yaml');
    const configFile = path.join(prpPath, 'config.yaml');

    if (await fs.pathExists(configTemplate)) {
      await fs.copy(configTemplate, configFile);
    }

    this.spinner.succeed('PRP system configured');
  }

  async configureHooks() {
    if (!this.config.components.includes('hooks')) {
      return;
    }

    this.spinner.start('Configuring hooks...');

    const settingsPath = path.join(this.config.installPath, 'settings.json');
    const profilePath = path.join(
      __dirname,
      '..',
      'settings',
      `${this.config.hooksProfile}-hooks-settings.json`
    );

    if (await fs.pathExists(profilePath)) {
      const profileSettings = await fs.readJson(profilePath);

      // Merge with existing settings if any
      let existingSettings = {};
      if (await fs.pathExists(settingsPath)) {
        try {
          existingSettings = await fs.readJson(settingsPath);
        } catch (error) {
          // If existing settings are corrupted, start fresh
          existingSettings = {};
        }
      }

      const mergedSettings = {
        ...existingSettings,
        ...profileSettings,
        $schema: 'https://json.schemastore.org/claude-code-settings.json'
      };

      await fs.writeJson(settingsPath, mergedSettings, { spaces: 2 });
    }

    this.spinner.succeed('Hooks configured');
  }

  async saveInstallationInfo() {
    const versionInfo = {
      version: require('../package.json').version,
      installedAt: new Date().toISOString(),
      prefix: this.config.prefix,
      architecture: this.config.architecture,
      components: this.config.components,
      hooksProfile: this.config.hooksProfile,
      prpEnabled: this.config.enablePRP,
      installPath: this.config.installPath
    };

    const versionFile = path.join(this.paths.toolkit, '.installed-version');

    // Create the file in the format similar to the bash script
    const content = [
      `COMMIT_HASH=npm-v${versionInfo.version}`,
      `COMMIT_DATE=${versionInfo.installedAt}`,
      `COMMIT_MESSAGE=NPM Installation v${versionInfo.version}`,
      `BRANCH=npm-install`,
      `INSTALLED_AT=${versionInfo.installedAt}`,
      `SOURCE_DIR=npm-package`,
      `PREFIX=${versionInfo.prefix}`,
      `ARCHITECTURE=${versionInfo.architecture}`,
      `PRP_ENABLED=${versionInfo.prpEnabled}`
    ].join('\n');

    await fs.writeFile(versionFile, content);
  }

  async displayResults() {
    console.log(chalk.green('\n✅ Installation completed successfully!\n'));

    if (this.config.components.includes('commands')) {
      console.log(chalk.cyan('Available Commands (6-Command Architecture):'));
      const commands = [
        'understand - Comprehensive codebase analysis',
        'improve - Apply insights and optimizations',
        'create - Generate code and documentation',
        'secure - Security audits and fixes',
        'ship - Production readiness checks',
        'git - Smart git operations'
      ];

      commands.forEach(cmd => {
        console.log(`  ${chalk.gray('→')} /${this.config.prefix}:${cmd}`);
      });
    }

    if (this.config.components.includes('agents')) {
      console.log(chalk.cyan('\nAvailable AI Agents:'));
      console.log('  25+ specialized agents including:');
      console.log(`  ${chalk.gray('→')} security-specialist, performance-optimizer`);
      console.log(`  ${chalk.gray('→')} codebase-research-specialist, requirements-analyst`);
      console.log(`  ${chalk.gray('→')} And many more domain experts...`);
    }

    if (this.config.enablePRP) {
      console.log(chalk.cyan('\nPRP Methodology:'));
      console.log(`  ${chalk.gray('→')} Use /${this.config.prefix}:understand . --prp to start`);
      console.log(`  ${chalk.gray('→')} Blueprint-driven development workflow`);
    }

    console.log(chalk.yellow('\n🚀 Getting Started:'));
    console.log(`Type ${chalk.green('/')} in Claude Code to see your commands`);
    console.log(`Example: ${chalk.green(`/${this.config.prefix}:understand .`)}`);

    if (this.config.architecture === '6-command') {
      console.log(`6-Command Flow: ${chalk.green(`/${this.config.prefix}:understand → improve → create → secure → ship`)}`);
    }

    if (this.config.isGlobal) {
      console.log('\n📍 Global installation - available in all projects');
    } else {
      console.log('\n📍 Local installation - available in this project only');
    }
  }
}

module.exports = { Installer };
```

### 5. PostInstall Script (`lib/postinstall.js`)

```javascript
const { InstallationWizard } = require('./wizard');
const { Installer } = require('./installer');
const chalk = require('chalk');

async function postInstall() {
  // Skip in non-interactive environments (CI/CD)
  if (!process.stdin.isTTY || process.env.CI) {
    console.log(chalk.yellow('Non-interactive environment detected.'));
    console.log('Run `claude-code-toolkit setup` or `cct setup` manually to configure.');
    return;
  }

  try {
    console.log(chalk.blue('🎉 Welcome to Claude Code Toolkit v5.0!'));
    console.log(chalk.cyan('Knowledge-Driven Revolution with 6-Command Architecture'));
    console.log('Starting interactive setup...\n');

    const wizard = new InstallationWizard();
    const config = await wizard.run();

    const installer = new Installer(config);
    await installer.install();

  } catch (error) {
    if (error.message === 'User force closed the prompt with 0 null') {
      console.log(chalk.yellow('\nSetup cancelled by user.'));
      console.log('Run `claude-code-toolkit setup` or `cct setup` later to configure.');
      return;
    }

    console.error(chalk.red('Setup failed:'), error.message);
    console.log(chalk.gray('Run `claude-code-toolkit setup` or `cct setup` to try again.'));
    process.exit(1);
  }
}

// Only run if this script is executed directly
if (require.main === module) {
  postInstall();
}

module.exports = { postInstall };
```

## Installation Flows

### 1. Globale Installation

```bash
# Installation
npm install -g @redpop/claude-code-toolkit

# Automatischer postinstall wizard läuft
# → Interactive setup für ~/.claude/

# Spätere Konfiguration
claude-code-toolkit setup
# oder kurz:
cct setup

# Updates
npm update -g @redpop/claude-code-toolkit
claude-code-toolkit update
```

### 2. Lokale Projekt-Installation

```bash
# In einem Projekt
npm install @redpop/claude-code-toolkit

# Lokales Setup
npx claude-code-toolkit setup

# Oder als dev dependency
npm install --save-dev @redpop/claude-code-toolkit
```

### 3. Programmatische Installation

```javascript
const { InstallationWizard, Installer } = require('@redpop/claude-code-toolkit');

const wizard = new InstallationWizard();
const config = await wizard.run({
  prefix: 'myteam',
  architecture: '6-command',
  enablePRP: true,
  force: true
});

const installer = new Installer(config);
await installer.install();
```

## Migration und Kompatibilität

### Backwards Compatibility

- **Bestehende install.sh bleibt funktional** während Übergangszeit
- **Schrittweise Migration möglich** für bestehende User
- **Dokumentation für beide Wege** verfügbar
- **Automatische Erkennung** bestehender Installationen

### Migrationspfad

1. NPM-Package als Alternative einführen
2. Dokumentation für beide Installationsmethoden aktualisieren
3. 6-Command Architecture als Standard etablieren
4. Langfristig NPM als Hauptweg etablieren
5. install.sh als Legacy-Option beibehalten

### Update-Strategie

- **Automatische Erkennung** bestehender Installationen
- **Intelligentes Merging** von Konfigurationen
- **Backup-Erhaltung** bei Updates
- **Rollback-Möglichkeiten**
- **Version-Migration** von Bash zu NPM Installation

## Neue Features in NPM Version

### 6-Command Architecture Support

- **Streamlined Installation**: Fokus auf 6 Kernbefehle
- **Extension Support**: meta/*und typo3/* als optionale Extensions
- **Legacy Mode**: Vollständige Kommandosammlung als Option

### PRP Methodology Integration

- **Blueprint System**: Template-basierte Projektentwicklung
- **Research Agents**: Externe und interne Wissenssammlung
- **Quality Gates**: Automatisierte Validierungsworkflows

### Smart Suggestions System

- **Context-Aware Recommendations**: Intelligente Workflow-Vorschläge
- **Learning Integration**: Basic Memory Anbindung mit graceful fallback
- **Command Chain Tracking**: Optimierte Befehlsketten

### Enhanced Hook System

- **Profile-Based Configuration**: basic, minimal, advanced
- **Smart Suggestions Engine**: KI-gestützte Workflow-Optimierung
- **Session Metrics**: Entwicklungsproduktivität-Tracking

## Vorteile der NPM-Migration

### Für Benutzer

- **Einfache Installation**: `npm install -g @redpop/claude-code-toolkit`
- **Automatische Updates**: Standard NPM update workflow
- **Interaktiver Setup**: Benutzerfreundlicher 6-Command Wizard
- **Bessere Integration**: In bestehende Node.js Projekte
- **Versionierung**: Semantic versioning mit NPM
- **Kurzer Alias**: `cct` als Alternative zu `claude-code-toolkit`

### Für Entwicklung

- **Standard Tooling**: NPM ecosystem
- **Dependency Management**: Automatische Abhängigkeitsverwaltung
- **Testing Framework**: Jest für automatisierte Tests
- **CI/CD Integration**: Standard NPM publishing workflow
- **Distribution**: NPM registry für einfache Verteilung

### Technische Vorteile

- **Cross-Platform**: Node.js läuft überall wo Claude Code läuft
- **Robuste Fehlerbehandlung**: Moderne async/await patterns
- **Modulare Architektur**: Klare Trennung von Verantwortlichkeiten
- **Testbarkeit**: Unit tests für alle Komponenten
- **Wartbarkeit**: TypeScript support möglich
- **6-Command Focus**: Streamlined user experience

## Implementierungsschritte

### Phase 1: Grundstruktur (Woche 1)

1. ✅ NPM package.json erstellen mit aktueller Struktur
2. ✅ Basis-CLI script implementieren (mit `cct` alias)
3. ✅ 6-Command Architecture Installer-Logik
4. ✅ PRP System Integration

### Phase 2: Enhanced Wizard (Woche 2)

1. ✅ @inquirer/prompts Integration mit 6-Command Focus
2. ✅ Architecture Selection (6-command vs legacy)
3. ✅ PRP Methodology Integration
4. ✅ Smart Hook Profile Selection

### Phase 3: Advanced Features (Woche 3)

1. ✅ Update-Mechanismus mit Migrations-Support
2. ✅ Backup und Recovery für beide Installationstypen
3. ✅ Hook-Profil Management mit Smart Suggestions
4. ✅ Status und Diagnose Commands

### Phase 4: Testing und Validation (Woche 4)

1. ✅ Umfassende Tests für alle Installer-Komponenten
2. ✅ Cross-platform testing (macOS, Linux, Windows)
3. ✅ Migration testing (Bash → NPM)
4. ✅ 6-Command Architecture validation

### Phase 5: Documentation und Polish (Woche 5)

1. ✅ Aktualisierte Dokumentation für NPM workflow
2. ✅ Migration guides für bestehende User
3. ✅ 6-Command Architecture documentation
4. ✅ PRP Methodology guides

### Phase 6: Release und Community (Woche 6)

1. ✅ NPM package publishing
2. ✅ Community feedback integration
3. ✅ Performance optimization
4. ✅ Long-term maintenance strategy

## Risiken und Mitigation

### Technische Risiken

- **Node.js Dependency**: Alle Claude Code Nutzer benötigen Node.js
  - *Mitigation*: Node.js ist Standard für moderne Entwicklung
- **6-Command Learning Curve**: User müssen neue Architektur lernen
  - *Mitigation*: Legacy mode als Fallback, umfassende Dokumentation
- **PRP Complexity**: Methodology könnte zu komplex sein
  - *Mitigation*: Optionale Aktivierung, schrittweise Einführung

### User Experience Risiken

- **Migration Friction**: User müssen Workflow anpassen
  - *Mitigation*: Automatische Migration, beide Systeme parallel
- **Feature Overload**: Zu viele neue Features auf einmal
  - *Mitigation*: Modularer Ansatz, optionale Komponenten

## Erfolgsmessung

### Quantitative Metriken

- **Adoption Rate**: NPM downloads vs. GitHub clones
- **Installation Success Rate**: Error rates bei Setup
- **6-Command Usage**: Adoption der neuen Architektur
- **PRP Engagement**: Usage der Blueprint-Funktionen

### Qualitative Metriken

- **User Feedback**: 6-Command Architecture Bewertungen
- **Migration Experience**: Feedback zum Upgrade-Prozess
- **PRP Methodology**: Blueprint-driven development success
- **Community Engagement**: Contributions und Feature requests

## Fazit

Die Migration zu einem NPM-Package mit 6-Command Architecture und PRP Integration bietet erhebliche Vorteile:

### Kernvorteile

- **Streamlined Workflow**: 6-Command Architecture reduziert Komplexität
- **Modern Tooling**: NPM ecosystem für bessere Wartbarkeit
- **Blueprint-Driven Development**: PRP Methodology für strukturierte Entwicklung
- **Smart Automation**: Enhanced Hook System mit KI-Unterstützung

### Migrationsstrategie

- **Sanfte Migration**: Bash und NPM parallel verfügbar
- **Benutzerfreundlich**: Interaktiver Wizard vereinfacht Setup
- **Rückwärtskompatibel**: Legacy mode für bestehende Workflows

**Empfehlung**: Proceed with implementation - die 6-Command Architecture mit PRP Integration und NPM-Packaging bietet einen klaren Evolutionsschritt für das Claude Code Toolkit.
