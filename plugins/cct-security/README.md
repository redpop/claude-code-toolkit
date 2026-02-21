# cct-security

Security analysis and vulnerability detection plugin for Claude Code Toolkit.

## Skills

| Skill | Description |
|-------|-------------|
| `secure` | Security analysis with OWASP Top 10, CWE, and CVSS scoring |

## Agents

- **security-specialist** — Red team analysis, vulnerability detection, threat modeling
- **debugging-specialist** — Systematic debugging, log analysis, root cause identification

## MCP Integration

Optional Semgrep MCP server for enhanced static analysis (configured in `.mcp.json`).

## Usage

```bash
/cct-security:secure . --audit
/cct-security:secure . --dependencies
```
