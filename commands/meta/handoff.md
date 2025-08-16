---
description: Documents current problem context for handoff to another AI assistant
argument-hint: [output-file] [--compact] [--focus topic] ["instructions"]
---

# Claude Command: AI Handoff

This command analyzes the current chat history to extract and document the latest unresolved problem, providing comprehensive context for another AI assistant to continue the work.

## Usage

```bash
# Standard handoff
/handoff                                    # Creates handoff.md
/handoff problem-context.md                 # Custom filename

# Compact mode
/handoff --compact                          # Compact handoff.md 
/handoff brief.md --compact                 # Compact with custom name
/handoff -c                                 # Short flag for compact

# With focus flags
/handoff --focus "database errors"          # Focus on specific topic
/handoff --skip "UI issues"                 # Skip certain topics
/handoff --include "error logs"             # Explicitly include

# Combinations
/handoff debug.md --compact --technical     # Compact with tech details
/handoff --compact --focus "blockers" "emphasize workarounds"
/handoff migration.md -c --skip "resolved" --include "SQL errors"
```

## What This Command Does

1. **Analyzes Chat History**: Reviews the entire conversation to understand the context
2. **Identifies Current Problem**: Focuses on the most recent unresolved issue, ignoring previously solved problems
3. **Extracts Key Information**:
   - Problem statement/requirements
   - Technical context (tech stack, constraints)
   - Attempted solutions and their outcomes
   - Current blockers or challenges
   - Relevant code snippets or error messages
4. **Creates Structured Documentation**: Generates a markdown file with all context needed for another AI

## Output Format

The generated documentation includes:

### 1. Executive Summary

- Brief problem description
- Current status
- Immediate next steps needed

### 2. Problem Context

- Original requirement/goal
- Why this is important
- Success criteria

### 3. Technical Environment

- Programming languages/frameworks
- File structure
- Dependencies
- Constraints or limitations

### 4. Progress So Far

- What has been attempted
- What worked/didn't work
- Current implementation state

### 5. Current Blockers

- Specific errors or issues
- What's preventing progress
- Hypotheses about the cause

### 6. Relevant Code & Files

- Key file paths
- Important code snippets
- Error messages or logs

### 7. Suggested Next Steps

- Potential approaches to try
- Areas to investigate
- Questions to answer

## Best Practices

- Use this command when you need to switch AI assistants or get a fresh perspective
- Provide any additional context as arguments if the default extraction misses something
- Review the generated document before sharing to ensure accuracy
- The command focuses on actionable information rather than conversation history

## Example Output

````markdown
# AI Handoff Document

## Executive Summary

**Problem**: Integration test failing due to WebSocket connection timeout
**Status**: Partially resolved - connection established but times out after 30s
**Next Steps**: Investigate keepalive mechanism and review nginx proxy settings

## Problem Context

The user is trying to implement real-time notifications using WebSockets in a React/Node.js application. The feature works locally but fails in the staging environment.

### Original Requirement

- Implement real-time notifications for user actions
- Support 1000+ concurrent connections
- Sub-second latency requirement

### Success Criteria

- WebSocket connections remain stable for extended periods
- Notifications delivered within 500ms
- Graceful reconnection on network issues

## Technical Environment

- **Frontend**: React 18.2, Socket.io-client 4.5
- **Backend**: Node.js 18, Express, Socket.io 4.5
- **Infrastructure**: AWS ECS, Application Load Balancer, nginx proxy
- **Key Files**:
  - `/src/services/websocket.js` - Client connection logic
  - `/server/sockets/index.js` - Server socket handler
  - `/nginx/default.conf` - Proxy configuration

## Progress So Far

### Attempted Solutions

1. **Increased timeout values** (Result: No improvement)
   - Set client timeout to 60s
   - Set server pingTimeout to 60s
2. **Added connection debugging** (Result: Found disconnects at exactly 30s)
   ```javascript
   socket.on("disconnect", (reason) => {
     console.log("Disconnect reason:", reason);
     // Always shows "transport close" after 30s
   });
   ```
````

3. **Verified local environment** (Result: Works perfectly)
   - No disconnections even after hours
   - Problem only occurs in staging/production

### Current Implementation State

- Basic WebSocket connection established
- Authentication working correctly
- Messages delivered successfully before timeout
- Reconnection logic implemented but triggered too frequently

## Current Blockers

### Primary Issue

WebSocket connections drop after exactly 30 seconds in staging environment, suggesting infrastructure-level timeout.

### Error Details

```
Client: "transport close" disconnect reason
Server: No error logged, connection simply disappears
nginx logs: "upstream prematurely closed connection"
```

### Investigation Results

- ALB idle timeout is set to 60s (not the issue)
- nginx keepalive_timeout is 65s (not the issue)
- Suspicion: nginx proxy_read_timeout might be set to 30s

## Relevant Code & Files

### Client WebSocket Service

**File**: `/src/services/websocket.js:45-62`

```javascript
const socket = io(SOCKET_URL, {
  transports: ["websocket"],
  reconnection: true,
  reconnectionDelay: 1000,
  reconnectionAttempts: 5,
  timeout: 60000,
  auth: { token: getAuthToken() },
});
```

### Server Configuration

**File**: `/server/sockets/index.js:12-18`

```javascript
const io = new Server(server, {
  cors: { origin: process.env.CLIENT_URL },
  pingTimeout: 60000,
  pingInterval: 25000,
});
```

### Nginx Configuration Location

**File**: `/nginx/default.conf` (not accessible in current session)

## Suggested Next Steps

1. **Check nginx proxy timeout settings**:

   - Look for `proxy_read_timeout` and `proxy_send_timeout`
   - These might be set to 30s by default

2. **Add WebSocket-specific nginx configuration**:

   ```nginx
   location /socket.io/ {
     proxy_http_version 1.1;
     proxy_set_header Upgrade $http_upgrade;
     proxy_set_header Connection "upgrade";
     proxy_read_timeout 86400;
   }
   ```

3. **Implement heartbeat mechanism**:

   - Send periodic ping/pong messages
   - Keep connection active to prevent timeout

4. **Review AWS ALB configuration**:

   - Check for any WebSocket-specific settings
   - Verify sticky sessions are enabled

5. **Add comprehensive logging**:
   - Log all socket events on both client and server
   - Monitor infrastructure metrics during disconnection

## Additional Context

The user mentioned this is blocking a production release scheduled for next week. The feature works perfectly in development, indicating this is purely an infrastructure/configuration issue rather than a code problem.

```

## Important Notes

- Only extracts information about the CURRENT problem, not historical issues
- Focuses on technical details and actionable information
- Removes conversational elements to keep the document concise
- Includes file paths and code snippets for quick reference
- If multiple problems exist, prioritizes the most recent unresolved one
- The command should analyze the conversation context to distinguish between:
  - Problems that have been resolved (ignore these)
  - The current active problem (document this)
  - Multiple concurrent problems (focus on the most recent/urgent)

## Command Arguments

The command accepts arguments in the following format:
```
/handoff [filename] [flags] ["additional instructions"]
```

### Positional Arguments

- **filename** (optional): Output filename
  - Must end with `.md` extension if provided
  - Defaults to "handoff.md" if not specified
  - Overwrites existing file if present

### Flag Arguments

- `--compact`, `-c`: Generate compact handoff (max 10 sentences total)
- `--brief`: Alias for --compact
- `--technical`, `-t`: Force technical details even in compact mode
- `--focus <topic>`: Focus on specific area (can be used multiple times)
- `--skip <topic>`: Exclude specific topics (can be used multiple times)  
- `--include <topic>`: Explicitly include topics (can be used multiple times)

### Free-form Instructions

- Any non-flag text after flags is treated as additional instructions
- Use quotes for multi-word instructions: `"focus on error handling"`
- Multiple instruction strings can be provided

### Parsing Logic

The command intelligently parses `$ARGUMENTS`:

1. **Extract filename**: If first argument ends with `.md` → use as filename
2. **Parse flags**: Identify all arguments starting with `--` or `-`
   - Extract flag values where applicable (e.g., `--focus database`)
   - Handle both long (`--compact`) and short (`-c`) forms
3. **Remaining text**: Everything else → additional instructions
4. **Default behavior**: No filename → use "handoff.md"

### Examples

```bash
# Standard mode
/handoff                                    # Default handoff.md
/handoff websocket-issue.md                 # Custom filename

# Compact mode examples
/handoff --compact                          # Compact handoff.md
/handoff -c                                 # Using short flag
/handoff brief.md --compact                 # Compact with filename

# Using focus flags
/handoff --focus "database"                 # Focus on database issues
/handoff --skip "UI" --skip "styling"       # Skip multiple topics
/handoff --include "errors" --include "logs" # Include specific items

# Complex combinations
/handoff debug.md --compact --technical --focus "performance"
/handoff --compact --skip "resolved" "emphasize untested solutions"
/handoff migration.md -c --focus "SQL" --include "error traces"

# Backward compatible (still works)
/handoff "focus on database migration errors"
/handoff debug.md "include profiling data"
```

## Processing Instructions & Flags

### Standard Mode (default)

Generates comprehensive handoff with all sections:
- Executive Summary
- Problem Context
- Technical Environment  
- Progress So Far
- Current Blockers
- Relevant Code & Files
- Suggested Next Steps

### Compact Mode (`--compact` or `-c`)

Generates condensed handoff with strict limits:

```markdown
# Compact Handoff

## Requirement (2 sentences max)
Core need and business value.

## Current State (2 sentences max)
What's working and progress percentage.

## Main Blocker (2 sentences max)
Primary issue and what specifically failed.

## Failed Attempts (1 sentence each, max 3)
- Attempt 1: approach and failure reason
- Attempt 2: approach and failure reason

## Solution Paths (2 sentences max)
Untested approaches and most promising direction.

## Technical Context (only with --technical or code projects)
Files: [file1:line, file2:line]
Error: [type and location]
Stack: [key technologies]
```

### Flag Behaviors

- **`--focus`**: Emphasizes specified topics with more detail
- **`--skip`**: Reduces or omits specified topics
- **`--include`**: Ensures topics are included even if normally filtered
- **`--technical`**: Forces inclusion of technical details in compact mode

### Adaptive Behavior

The command automatically adapts based on project type:
- **Code projects**: Includes file references, error types, tech stack
- **Non-code projects**: Uses general language, focuses on concepts
- **Compact + Technical**: Maintains precision despite brevity

```

```
