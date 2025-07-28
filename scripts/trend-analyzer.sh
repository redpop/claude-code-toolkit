#!/bin/bash

# Trend Analyzer - Analyzes trends across multiple report files
# Usage: ./trend-analyzer.sh reports/*.json

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is required but not installed. Install it with: brew install jq"
    exit 1
fi

# Check arguments
if [ $# -eq 0 ]; then
    echo "Usage: $0 <report-files...>"
    echo "Example: $0 reports/*.json"
    exit 1
fi

echo -e "${BLUE}📊 Code Quality Trend Analysis${NC}"
echo "================================"

# Initialize variables
declare -a health_scores=()
declare -a security_scores=()
declare -a performance_scores=()
declare -a test_coverages=()
declare -a issue_counts=()
declare -a dates=()

# Process each report
for report in "$@"; do
    if [ -f "$report" ]; then
        # Extract metrics
        health=$(jq -r '.summary.health_score // 0' "$report")
        security=$(jq -r '.metrics.security_score // 0' "$report")
        performance=$(jq -r '.metrics.performance_score // 0' "$report")
        coverage=$(jq -r '.metrics.test_coverage // 0' "$report")
        issues=$(jq -r '.summary.total_issues // 0' "$report")
        date=$(jq -r '.metadata.timestamp // "unknown"' "$report" | cut -d'T' -f1)
        
        # Store in arrays
        health_scores+=("$health")
        security_scores+=("$security")
        performance_scores+=("$performance")
        test_coverages+=("$coverage")
        issue_counts+=("$issues")
        dates+=("$date")
    fi
done

# Calculate trends
calc_trend() {
    local -a values=("$@")
    local len=${#values[@]}
    
    if [ "$len" -lt 2 ]; then
        echo "N/A"
        return
    fi
    
    local first=${values[0]}
    local last=${values[$((len-1))]}
    local diff=$((last - first))
    
    if [ "$diff" -gt 0 ]; then
        echo -e "${GREEN}+$diff ↑${NC}"
    elif [ "$diff" -lt 0 ]; then
        echo -e "${RED}$diff ↓${NC}"
    else
        echo -e "${YELLOW}±0 →${NC}"
    fi
}

# Display summary
echo -e "\n${BLUE}📈 Trend Summary (${#health_scores[@]} reports analyzed)${NC}"
echo "------------------------------------------------"

# Health Score Trend
echo -n "Health Score:     "
echo -n "${health_scores[0]} → ${health_scores[-1]} "
calc_trend "${health_scores[@]}"

# Security Score Trend
echo -n "Security Score:   "
echo -n "${security_scores[0]} → ${security_scores[-1]} "
calc_trend "${security_scores[@]}"

# Performance Score Trend
echo -n "Performance:      "
echo -n "${performance_scores[0]} → ${performance_scores[-1]} "
calc_trend "${performance_scores[@]}"

# Test Coverage Trend
echo -n "Test Coverage:    "
echo -n "${test_coverages[0]}% → ${test_coverages[-1]}% "
calc_trend "${test_coverages[@]}"

# Issue Count Trend
echo -n "Total Issues:     "
echo -n "${issue_counts[0]} → ${issue_counts[-1]} "
# Reverse color logic for issues (less is better)
diff=$((${issue_counts[-1]} - ${issue_counts[0]}))
if [ "$diff" -gt 0 ]; then
    echo -e "${RED}+$diff ↑${NC}"
elif [ "$diff" -lt 0 ]; then
    echo -e "${GREEN}$diff ↓${NC}"
else
    echo -e "${YELLOW}±0 →${NC}"
fi

# Quick Wins Detection
echo -e "\n${BLUE}⚡ Quick Wins Analysis${NC}"
echo "------------------------"

# Analyze latest report for quick wins
latest_report="${@: -1}"
if [ -f "$latest_report" ]; then
    quick_wins=$(jq -r '
        .findings[] | 
        select(.estimated_effort | 
            test("hour|minutes|Hours|Minutes")) | 
        "\(.severity): \(.title) (\(.estimated_effort))"
    ' "$latest_report" 2>/dev/null | head -5)
    
    if [ -n "$quick_wins" ]; then
        echo "$quick_wins"
    else
        echo "No quick wins identified in latest report"
    fi
fi

# Progress Velocity
echo -e "\n${BLUE}🚀 Progress Velocity${NC}"
echo "--------------------"

if [ "${#health_scores[@]}" -ge 2 ]; then
    # Calculate average improvement per report
    total_improvement=$((${health_scores[-1]} - ${health_scores[0]}))
    reports_count=$((${#health_scores[@]} - 1))
    
    if [ "$reports_count" -gt 0 ]; then
        avg_improvement=$(echo "scale=2; $total_improvement / $reports_count" | bc)
        echo "Average improvement per analysis: ${avg_improvement} points"
        
        # Estimate time to reach target
        current=${health_scores[-1]}
        target=80
        
        if [ "$current" -lt "$target" ] && [ "${avg_improvement%.*}" -gt 0 ]; then
            remaining=$((target - current))
            analyses_needed=$(echo "scale=0; $remaining / $avg_improvement" | bc)
            echo "Estimated analyses to reach 80/100: ${analyses_needed}"
        fi
    fi
fi

# ASCII Chart (simple sparkline)
echo -e "\n${BLUE}📊 Health Score Sparkline${NC}"
echo -n "["
for score in "${health_scores[@]}"; do
    # Simple ASCII representation
    if [ "$score" -ge 80 ]; then
        echo -n "█"
    elif [ "$score" -ge 60 ]; then
        echo -n "▓"
    elif [ "$score" -ge 40 ]; then
        echo -n "▒"
    else
        echo -n "░"
    fi
done
echo "]"

# Recommendations
echo -e "\n${BLUE}💡 Recommendations${NC}"
echo "------------------"

latest_health=${health_scores[-1]}
if [ "$latest_health" -lt 50 ]; then
    echo -e "${RED}⚠️  Critical: Health score below 50. Focus on high-impact fixes.${NC}"
elif [ "$latest_health" -lt 70 ]; then
    echo -e "${YELLOW}📍 Priority: Target quick wins to reach 70+ health score.${NC}"
else
    echo -e "${GREEN}✅ Good progress! Focus on maintaining momentum.${NC}"
fi

# Export summary
echo -e "\n${BLUE}💾 Export Options${NC}"
echo "-----------------"
echo "To analyze in detail, run:"
echo "  /analyze-report $latest_report --quick-wins"
echo "  /analyze-report ${@: -2:1} --compare=$latest_report"
echo "  /analyze-report $* --trends --export-md=trend-analysis.md"