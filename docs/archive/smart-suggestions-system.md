# Smart Suggestions System - Implementation Plan

**Version:** 1.0.0
**Status:** Planning Phase
**Priority:** Medium
**Estimated Timeline:** 2-3 weeks

## 📋 Executive Summary

Implementation plan for a context-aware suggestion system that provides intelligent recommendations after code modifications. The system extends our existing hook infrastructure to offer proactive workflow guidance without disrupting the established 6-command architecture.

## 🎯 Objectives

### Primary Goals

- **Proactive Guidance**: Automatically suggest relevant toolkit commands based on file modifications
- **Learning Enhancement**: Help users understand when to use specific commands in our 6-command architecture
- **Quality Assurance**: Reduce oversight by suggesting security checks, tests, and documentation updates
- **Non-Invasive Integration**: Extend existing hooks without breaking current functionality

### Success Metrics

- User adopts suggested commands >40% of the time
- Reduction in missed security/test checks
- Positive user feedback on suggestion relevance
- Zero performance impact on existing hook system

## 🏗️ System Architecture

### Core Components

```
hooks/
├── smart-suggestions.sh           # Main suggestion engine
├── config/
│   ├── suggestions-config.json    # User configuration
│   └── file-patterns.json         # Pattern definitions (future)
├── lib/
│   └── suggestion-engine.sh       # Shared functions library
└── [existing hooks extended]      # Integration points
```

### Integration Pattern

Each existing PostToolUse hook will be extended with:

```bash
# Smart suggestions integration (at end of existing logic)
if [ -f "$HOME/.claude/claude-code-toolkit/hooks/smart-suggestions.sh" ]; then
    echo "$INPUT" | "$HOME/.claude/claude-code-toolkit/hooks/smart-suggestions.sh"
fi
```

## 📊 Technical Specifications

### Technology Stack

- **Primary**: Bash scripting (consistency with existing hooks)
- **Configuration**: JSON (simple parsing with grep/sed)
- **Integration**: PostToolUse hook system
- **Future**: Python extension for advanced features

### Input Processing

```bash
# Hook receives JSON input with:
{
  "tool_name": "Edit|Write|MultiEdit|...",
  "file_path": "/path/to/modified/file.py",
  "context": "additional context data",
  "timestamp": "2024-01-01T12:00:00Z"
}
```

### Suggestion Logic Flow

1. **Rate Limiting**: Check cooldown period (default: 30s)
2. **Pattern Matching**: Analyze file path/name against known patterns
3. **Context Analysis**: Consider tool used and modification type
4. **Suggestion Generation**: Output 1-2 relevant command suggestions
5. **Display**: Send to stderr with consistent formatting

## 🎛️ Configuration System

### Default Configuration (`config/suggestions-config.json`)

```json
{
  "enabled": true,
  "verbosity": "normal",
  "cooldown_seconds": 30,
  "max_suggestions": 2,

  "file_patterns": {
    "security": {
      "patterns": ["*auth*", "*login*", "*password*", "*crypto*", "*security*"],
      "suggestions": [
        "💡 Security code modified. Consider: /prefix:secure . --quick",
        "💡 Or run comprehensive audit: /prefix:secure . --audit"
      ]
    },
    "tests": {
      "patterns": ["*test*", "*spec*", "*.test.*", "*__tests__*"],
      "suggestions": [
        "💡 Test modified. Consider: /prefix:understand . --test-coverage"
      ]
    },
    "dependencies": {
      "patterns": ["package.json", "requirements.txt", "composer.json", "pom.xml", "Cargo.toml"],
      "suggestions": [
        "💡 Dependencies updated. Consider: /prefix:secure . --dependencies",
        "💡 Check readiness: /prefix:ship . --readiness-check"
      ]
    },
    "infrastructure": {
      "patterns": ["*.yml", "*.yaml", "Dockerfile", "docker-compose.*", "*.conf"],
      "suggestions": [
        "💡 Config changed. Consider: /prefix:secure . --infrastructure"
      ]
    },
    "documentation": {
      "patterns": ["*.md", "*.rst", "*.txt", "README*", "CHANGELOG*"],
      "suggestions": [
        "💡 Documentation updated. Consider: /prefix:create docs --sync"
      ]
    }
  },

  "contextual_triggers": {
    "error_detected": [
      "💡 Errors found. Consider: /prefix:improve . --fix-issues"
    ],
    "large_change": [
      "💡 Large change detected. Consider: /prefix:understand . --impact-analysis"
    ]
  }
}
```

### User Customization

Users can override defaults by modifying the config file:

```bash
# Disable suggestions
~/.claude/claude-code-toolkit/hooks/config/suggestions-config.json
{"enabled": false}

# Adjust verbosity
{"enabled": true, "verbosity": "quiet", "cooldown_seconds": 60}
```

## 📋 Implementation Phases

### Phase 1: Foundation (Week 1)

**Goal**: Core infrastructure and basic functionality

#### Tasks

- [ ] Create directory structure (`config/`, `lib/`)
- [ ] Implement `lib/suggestion-engine.sh` with core functions:
  - [ ] `suggestions_enabled()` - Check if system is active
  - [ ] `check_cooldown()` - Rate limiting functionality
  - [ ] `extract_context()` - Parse JSON input
  - [ ] `match_file_pattern()` - Pattern matching logic
  - [ ] `suggest_for_file()` - Generate file-based suggestions
- [ ] Create default `suggestions-config.json`
- [ ] Implement main `smart-suggestions.sh` entry point
- [ ] Unit test individual functions

#### Deliverables

- Working suggestion engine (standalone)
- Configuration system
- Basic pattern matching for 5 file types
- Documentation for new components

#### Success Criteria

- [ ] Standalone script correctly identifies file types
- [ ] Configuration loading works
- [ ] Rate limiting prevents spam
- [ ] All functions pass basic tests

### Phase 2: Integration (Week 2)

**Goal**: Integration with existing hooks and real-world testing

#### Tasks

- [ ] Extend 3 key existing hooks:
  - [ ] `tool-specific-notification.sh`
  - [ ] `error-detection.sh`
  - [ ] `success-notification.sh`
- [ ] Update `install.sh` to:
  - [ ] Create suggestion directories
  - [ ] Install default config
  - [ ] Set proper permissions
- [ ] Integration testing with real file modifications
- [ ] Refine pattern matching based on testing
- [ ] Performance impact assessment

#### Deliverables

- Integrated suggestion system
- Updated installation process
- Integration test suite
- Performance benchmarks

#### Success Criteria

- [ ] Suggestions appear after file modifications
- [ ] No performance degradation in existing hooks
- [ ] Pattern matching >90% accuracy for common scenarios
- [ ] Installation process handles updates correctly

### Phase 3: Enhancement & Polish (Week 3)

**Goal**: Advanced features and user experience improvements

#### Tasks

- [ ] Advanced contextual suggestions:
  - [ ] Error state detection
  - [ ] Large change detection (>100 lines)
  - [ ] Multi-file modification patterns
- [ ] User experience improvements:
  - [ ] Better formatting/colors in suggestions
  - [ ] Smart deduplication of suggestions
  - [ ] Context-aware suggestion prioritization
- [ ] Documentation and user guides:
  - [ ] Update hook documentation
  - [ ] Create user configuration guide
  - [ ] Add troubleshooting section
- [ ] Optional telemetry (anonymized usage stats)

#### Deliverables

- Enhanced suggestion intelligence
- Complete documentation
- User configuration tools
- Optional analytics framework

#### Success Criteria

- [ ] Contextual suggestions work correctly
- [ ] User documentation is comprehensive
- [ ] System handles edge cases gracefully
- [ ] Ready for broader user testing

## 🧪 Testing Strategy

### Unit Testing

```bash
# Test individual functions
test_pattern_matching() {
  assert_match "auth.py" "*auth*"
  assert_no_match "readme.md" "*auth*"
}

test_cooldown() {
  touch /tmp/claude-suggestions-cooldown
  assert_false check_cooldown  # Should fail immediately
  sleep 31
  assert_true check_cooldown   # Should pass after cooldown
}
```

### Integration Testing

```bash
# Test with real hook scenarios
echo '{"tool_name":"Edit","file_path":"auth.py"}' | ./smart-suggestions.sh
# Expected: Security suggestion appears

echo '{"tool_name":"Write","file_path":"test_user.py"}' | ./smart-suggestions.sh
# Expected: Test coverage suggestion appears
```

### Performance Testing

- Measure hook execution time before/after integration
- Test with large file paths and complex patterns
- Memory usage assessment
- Concurrent modification handling

### User Acceptance Testing

- Test with real development workflows
- Gather feedback on suggestion relevance
- Test configuration customization
- Assess learning curve impact

## 🚀 Deployment Strategy

### Installation Integration

Update `install.sh` to handle suggestion system:

```bash
# Add to install.sh
install_suggestion_system() {
    local hooks_dir="$CLAUDE_DIR/claude-code-toolkit/hooks"

    # Create directories
    mkdir -p "$hooks_dir/config" "$hooks_dir/lib"

    # Install files
    cp "hooks/smart-suggestions.sh" "$hooks_dir/"
    cp "hooks/lib/suggestion-engine.sh" "$hooks_dir/lib/"
    cp "hooks/config/suggestions-config.json" "$hooks_dir/config/"

    # Set permissions
    chmod +x "$hooks_dir/smart-suggestions.sh"

    # Backup and update existing hooks
    backup_and_update_hooks
}
```

### Rollback Plan

- Keep backup of original hooks during update
- Provide disable flag in configuration
- Document manual removal process
- Test rollback procedure

### Migration Strategy

- Existing users: Seamless update via `install.sh`
- New users: Included by default
- Configuration: Preserve user customizations
- Backwards compatibility: Maintain existing hook behavior

## 📈 Success Metrics & Monitoring

### Quantitative Metrics

- **Suggestion Accuracy**: % of relevant suggestions (target: >80%)
- **User Adoption**: % of suggestions acted upon (target: >40%)
- **Performance Impact**: Hook execution time delta (target: <10ms)
- **Error Rate**: Failed suggestions/total suggestions (target: <1%)

### Qualitative Metrics

- User feedback on suggestion quality
- Reported workflow improvements
- Learning curve acceleration
- Overall satisfaction with toolkit enhancement

### Monitoring Implementation

```bash
# Optional telemetry (with user consent)
log_suggestion_usage() {
    local suggestion="$1"
    local timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    if telemetry_enabled; then
        echo "{\"suggestion\":\"$suggestion\",\"timestamp\":\"$timestamp\"}" >> "$TELEMETRY_LOG"
    fi
}
```

## 🔒 Security & Privacy Considerations

### Data Handling

- **No sensitive data collection**: Only file names/paths for pattern matching
- **Local processing**: All logic runs on user's machine
- **Optional telemetry**: Must be explicitly enabled by user
- **Configuration security**: Validate JSON input to prevent injection

### Privacy Protection

- File paths are processed locally only
- No network transmission of user data
- Telemetry is anonymized and aggregated
- User can disable all data collection

### Security Testing

- Test with malicious file names
- Validate JSON parsing security
- Check for command injection vectors
- Verify file permission handling

## 📚 Documentation Requirements

### Technical Documentation

- [ ] **Architecture Overview**: System design and component interaction
- [ ] **API Documentation**: Function signatures and usage
- [ ] **Configuration Reference**: All options and their effects
- [ ] **Integration Guide**: How to extend or modify the system

### User Documentation

- [ ] **Quick Start Guide**: Basic usage and setup
- [ ] **Customization Guide**: How to modify suggestions
- [ ] **Troubleshooting**: Common issues and solutions
- [ ] **FAQ**: Anticipated user questions

### Developer Documentation

- [ ] **Contributing Guide**: How to add new patterns or features
- [ ] **Testing Guide**: How to run and write tests
- [ ] **Release Process**: How to deploy updates
- [ ] **Code Style Guide**: Bash scripting standards

## 🔧 Maintenance & Support

### Ongoing Maintenance Tasks

- **Pattern Updates**: Add new file type patterns based on user needs
- **Performance Optimization**: Regular performance reviews and improvements
- **Bug Fixes**: Address reported issues and edge cases
- **Configuration Enhancements**: Add new configuration options as needed

### Support Strategy

- **Documentation First**: Comprehensive docs to reduce support burden
- **Community Support**: Enable user community to help each other
- **Issue Tracking**: Clear process for reporting and handling issues
- **Version Management**: Clear versioning for troubleshooting

### Update Process

- **Backward Compatibility**: Maintain compatibility with existing configurations
- **Migration Scripts**: Provide tools for major configuration changes
- **Rollback Capability**: Always provide way to revert changes
- **Testing**: Thorough testing before releasing updates

## 📅 Timeline & Milestones

### Week 1: Foundation

- **Day 1-2**: Directory structure and basic libraries
- **Day 3-4**: Core suggestion engine implementation
- **Day 5-7**: Configuration system and unit testing

### Week 2: Integration

- **Day 8-10**: Hook integration and installation updates
- **Day 11-12**: Integration testing and bug fixes
- **Day 13-14**: Performance optimization and refinement

### Week 3: Enhancement

- **Day 15-17**: Advanced features and contextual suggestions
- **Day 18-19**: Documentation and user guides
- **Day 20-21**: Final testing and deployment preparation

## 🎯 Next Steps

### Immediate Actions (Next 3 Days)

1. **Create directory structure** in hooks/
2. **Implement core library functions** in `lib/suggestion-engine.sh`
3. **Create basic configuration file** with common patterns
4. **Write unit tests** for pattern matching functions

### Short-term Goals (Next Week)

1. **Complete Phase 1** implementation
2. **Begin integration** with 2-3 existing hooks
3. **Test with real scenarios** and refine patterns
4. **Update installation process** to include new components

### Long-term Vision (Next Month)

1. **Deploy to production** with all features
2. **Gather user feedback** and iterate
3. **Plan Python extensions** for advanced features
4. **Explore ML-based suggestions** for power users

---

## 💡 Additional Considerations

### Future Enhancements

- **Machine Learning**: Learn from user patterns to improve suggestions
- **Project Context**: Understand project type (web, mobile, cli) for better suggestions
- **Team Patterns**: Share common patterns across team members
- **IDE Integration**: Extend beyond Claude Code to other development environments

### Potential Challenges

- **Pattern Maintenance**: Keeping file patterns current with evolving ecosystems
- **Performance Scaling**: Handling projects with thousands of files
- **User Customization**: Balancing flexibility with simplicity
- **Cross-Platform**: Ensuring consistent behavior across different systems

### Risk Mitigation

- **Gradual Rollout**: Start with limited patterns and expand based on success
- **Opt-Out Design**: Make it easy for users to disable features they don't want
- **Comprehensive Testing**: Test across different project types and sizes
- **Clear Documentation**: Prevent user confusion with thorough documentation

---

*This plan represents a comprehensive approach to implementing intelligent suggestions while maintaining the toolkit's core principles of simplicity, power, and user control.*
