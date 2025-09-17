# AI Specialist Agent

## Overview

The AI Specialist is an expert agent specializing in AI integration, prompt engineering, LLM optimization, and AI-powered feature development. This agent masters prompt design patterns, model selection strategies, and helps build reliable AI systems that integrate seamlessly with existing applications.

## Capabilities

- **Prompt Engineering Excellence**: System prompt design, few-shot learning setup, chain-of-thought prompting, output format control, error handling patterns, and context window optimization
- **Model Optimization**: Strategic model selection, token usage efficiency, response time optimization, cost-performance balance, fallback strategies, and cache implementation
- **AI System Design**: Retrieval augmented generation (RAG), agent architectures, tool integration patterns, evaluation frameworks, safety mechanisms, and versioning strategies
- **Production Reliability**: Rate limit handling, response validation, hallucination detection, monitoring and metrics, A/B testing setup, and graceful degradation
- **Cost Management**: Token consumption tracking, model tier optimization, usage quota implementation, and ROI analysis
- **Quality Assurance**: Prompt testing frameworks, output validation, accuracy measurement, and continuous improvement processes

## Usage

### Direct Invocation

Use the Task tool to invoke the AI Specialist directly:

```markdown
Use Task tool with subagent_type="ai-specialist":
"Analyze our AI-powered search feature for prompt optimization opportunities and suggest improvements for accuracy and cost reduction"
```

### Through Core Commands

The AI Specialist integrates with core commands:

- **`/prefix:understand`**: Contributes AI system analysis during codebase understanding
- **`/prefix:improve`**: Provides AI-specific optimization recommendations
- **`/prefix:secure`**: Analyzes AI security patterns and prompt injection vulnerabilities

## Output Format

The AI Specialist provides structured analysis reports including:

```markdown
# AI Implementation Analysis

## System Overview
- Primary Model: [Model Name and Version]
- Use Cases: [Detailed feature list]
- Monthly Token Usage: X million tokens
- Average Response Latency: X ms
- Cost Per Request: $X.XX

## Prompt Optimization

### [Feature Name] Analysis
**Current Prompt Issues**:
- Token inefficiency highlighted
- Ambiguous instructions identified
- Missing error handling patterns

**Optimized Prompt**:
- Improved clarity and specificity
- Token reduction strategies
- Enhanced output formatting

## Architecture Recommendations
- Enhanced system flow diagrams
- Caching and validation layers
- Monitoring and fallback strategies

## Implementation Roadmap
- Quick wins (days): Immediate optimizations
- System enhancements (weeks): Architecture improvements
- Strategic evolution (months): Advanced AI capabilities
```

## Examples

### Example 1: Prompt Optimization Review

```bash
Use Task tool with subagent_type="ai-specialist":
"Review our customer service chatbot prompts for clarity, token efficiency, and response quality. Focus on reducing hallucinations and improving customer satisfaction."
```

**Expected Output**: Detailed prompt analysis with optimized versions, token savings calculations, and implementation steps.

### Example 2: AI System Architecture Analysis

```bash
Use Task tool with subagent_type="ai-specialist":
"Analyze our AI-powered content generation pipeline for scalability issues, cost optimization opportunities, and reliability improvements."
```

**Expected Output**: System architecture review with caching strategies, fallback mechanisms, and cost reduction recommendations.

### Example 3: Model Selection Guidance

```bash
Use Task tool with subagent_type="ai-specialist":
"Evaluate whether we should switch from GPT-4 to Claude-3.5-Sonnet for our code review automation feature, considering accuracy, cost, and response time."
```

**Expected Output**: Comparative analysis with ROI calculations, migration strategy, and performance benchmarks.

## Tools Used

- **Read**: Analyzes existing AI implementation code, configuration files, and prompt templates
- **Grep**: Searches for AI-related patterns, API calls, and prompt definitions across the codebase
- **Task**: Coordinates with other specialists for comprehensive AI system analysis

## See Also

- [Performance Optimizer](performance-optimizer.md) - For AI system performance tuning
- [Security Specialist](../security/security-specialist.md) - For AI security and prompt injection prevention
- [Code Understanding Specialist](code-understanding-specialist.md) - For analyzing AI integration patterns
- [Refactoring Expert](refactoring-expert.md) - For improving AI code organization
- [Architecture Documentation](../../guides/AI-INTEGRATION.md) - AI integration best practices
