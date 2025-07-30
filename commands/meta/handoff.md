---
description: Documents current problem context for handoff to another AI assistant
argument-hint: [output-file]
---

# Claude Command: AI Handoff

This command analyzes the current chat history to extract and document the latest unresolved problem, providing comprehensive context for another AI assistant to continue the work.

## Usage

```
/handoff                    # Creates handoff.md in current directory
/handoff problem-context    # Creates problem-context.md
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

- `$ARGUMENTS`: Optional output filename (defaults to "handoff.md")
  - If provided, creates file with specified name
  - Must end with .md extension
  - Overwrites existing file if present
```
