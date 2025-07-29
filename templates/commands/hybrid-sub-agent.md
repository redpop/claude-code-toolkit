---
description: [Brief description of the command]
argument-hint: [expected-arguments]
---

# /[Command Name] - Hybrid Three-Phase Analysis

This is a hybrid command that uses a three-phase approach:
1. **Parallel Scanning**: Multiple agents scan the codebase in parallel
2. **Expert Delegation**: Based on findings, delegate to specialized experts
3. **Synthesis**: Combine all insights into a comprehensive report

## Phase 1: Parallel Scanning ([N/2] agents)

Deploy scanning agents to quickly survey the codebase:

```python
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path
import json
from typing import Dict, List, Any

# Phase 1: Parallel scanning agents
scanning_agents = [
    # Configure your scanning agents here
    # Each agent should focus on a specific aspect
]

def run_scanning_phase(target: str) -> Dict[str, Any]:
    """Execute parallel scanning phase"""
    findings = {}
    
    with ThreadPoolExecutor(max_workers=len(scanning_agents)) as executor:
        future_to_agent = {
            executor.submit(agent.run, target): agent 
            for agent in scanning_agents
        }
        
        for future in as_completed(future_to_agent):
            agent = future_to_agent[future]
            try:
                result = future.result()
                findings[agent.name] = result
                print(f"✓ {agent.name} completed scanning")
            except Exception as e:
                print(f"✗ {agent.name} failed: {str(e)}")
                findings[agent.name] = {"error": str(e)}
    
    return findings
```

## Phase 2: Expert Delegation (Dynamic)

Based on Phase 1 findings, intelligently delegate to domain experts:

```python
def analyze_findings_and_delegate(findings: Dict[str, Any]) -> List[Task]:
    """Analyze Phase 1 findings and create expert tasks"""
    expert_tasks = []
    
    # Analyze findings to determine which experts are needed
    for agent_name, agent_findings in findings.items():
        if "code_issues" in agent_findings:
            expert_tasks.append(
                Task(
                    description="Analyze code quality issues",
                    prompt=f"Review these code issues: {json.dumps(agent_findings['code_issues'])}",
                    subagent_type="code-expert"
                )
            )
        
        if "architecture_concerns" in agent_findings:
            expert_tasks.append(
                Task(
                    description="Review architecture patterns",
                    prompt=f"Analyze architecture: {json.dumps(agent_findings['architecture_concerns'])}",
                    subagent_type="architecture-expert"
                )
            )
        
        # Add more expert delegation logic based on findings
    
    return expert_tasks

def run_expert_phase(expert_tasks: List[Task]) -> Dict[str, Any]:
    """Execute expert analysis phase"""
    expert_results = {}
    
    with ThreadPoolExecutor(max_workers=min(len(expert_tasks), 10)) as executor:
        future_to_task = {
            executor.submit(task.run): task 
            for task in expert_tasks
        }
        
        for future in as_completed(future_to_task):
            task = future_to_task[future]
            try:
                result = future.result()
                expert_results[task.description] = result
                print(f"✓ Expert completed: {task.description}")
            except Exception as e:
                print(f"✗ Expert failed: {task.description} - {str(e)}")
                expert_results[task.description] = {"error": str(e)}
    
    return expert_results
```

## Phase 3: Synthesis

Combine all findings and expert analyses into a comprehensive report:

```python
def synthesize_results(
    scanning_findings: Dict[str, Any],
    expert_results: Dict[str, Any],
    target: str
) -> str:
    """Synthesize all results into a final report"""
    
    report = f"""# Hybrid Analysis Report: {target}

## Executive Summary
{generate_executive_summary(scanning_findings, expert_results)}

## Phase 1: Scanning Results
{format_scanning_results(scanning_findings)}

## Phase 2: Expert Analysis
{format_expert_analysis(expert_results)}

## Key Findings
{extract_key_findings(scanning_findings, expert_results)}

## Recommendations
{generate_recommendations(scanning_findings, expert_results)}

## Detailed Results
{format_detailed_results(scanning_findings, expert_results)}
"""
    
    return report
```

## Complete Workflow

```python
def hybrid_analysis(target: str = "$ARGUMENTS") -> str:
    """Execute the complete hybrid analysis workflow"""
    
    print(f"🚀 Starting hybrid analysis of: {target}")
    
    # Phase 1: Parallel Scanning
    print("\n📡 Phase 1: Parallel Scanning...")
    scanning_findings = run_scanning_phase(target)
    
    # Phase 2: Expert Delegation
    print("\n🧠 Phase 2: Expert Delegation...")
    expert_tasks = analyze_findings_and_delegate(scanning_findings)
    expert_results = run_expert_phase(expert_tasks)
    
    # Phase 3: Synthesis
    print("\n📊 Phase 3: Synthesis...")
    final_report = synthesize_results(scanning_findings, expert_results, target)
    
    return final_report
```

## Configuration

### Scanning Agents Configuration
```python
# Define your scanning agents for Phase 1
scanning_agents = [
    Task(
        description="File Structure Scanner",
        prompt="Scan $ARGUMENTS for file organization, project structure, and directory patterns. Identify key areas that need expert review.",
        subagent_type="file-scanner"
    ),
    Task(
        description="Pattern Detector",
        prompt="Detect code patterns, architectural styles, and design patterns in $ARGUMENTS. Flag areas requiring specialized analysis.",
        subagent_type="pattern-scanner"
    ),
    # Add more scanning agents as needed
]
```

### Expert Types Available
- `code-expert`: Deep code analysis and quality assessment
- `architecture-expert`: System design and pattern evaluation
- `security-expert`: Security vulnerability assessment
- `performance-expert`: Performance optimization analysis
- `testing-expert`: Test coverage and quality analysis
- `documentation-expert`: Documentation completeness review
- Custom experts based on domain needs

## Usage

```bash
/yourprefix:category:[Command Name] /path/to/analyze
```

## Performance

- **Phase 1**: [N/2] parallel scanning agents (~3-5 seconds)
- **Phase 2**: Dynamic expert delegation (varies by findings, ~5-10 seconds)
- **Phase 3**: Synthesis (~1-2 seconds)
- **Total**: [X-Y seconds for parallel execution, compared to Z seconds sequential]

## Customization Tips

1. **Scanning Agents**: Focus on broad, quick scans that identify areas needing deeper analysis
2. **Expert Delegation Logic**: Make it smart - only call experts for relevant findings
3. **Synthesis**: Create clear, actionable reports that highlight the most important insights
4. **Performance**: Balance between thorough analysis and execution time

## Output Format

The command returns a comprehensive markdown report with:
- Executive summary
- Detailed findings from each phase
- Expert recommendations
- Actionable next steps
- Supporting data and evidence