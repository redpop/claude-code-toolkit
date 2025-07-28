#!/usr/bin/env node

/**
 * Report History Utility
 * Manages historical tracking of analysis reports
 */

const fs = require('fs');
const path = require('path');

const HISTORY_FILE = '.report-history.json';

class ReportHistory {
    constructor(projectPath = '.') {
        this.projectPath = projectPath;
        this.historyFile = path.join(projectPath, HISTORY_FILE);
    }

    /**
     * Load existing history or create new one
     */
    loadHistory() {
        if (fs.existsSync(this.historyFile)) {
            try {
                return JSON.parse(fs.readFileSync(this.historyFile, 'utf8'));
            } catch (error) {
                console.warn(`Warning: Could not parse ${HISTORY_FILE}. Creating new history.`);
            }
        }

        return {
            project: path.basename(path.resolve(this.projectPath)),
            created: new Date().toISOString(),
            reports: []
        };
    }

    /**
     * Add new report to history
     */
    addReport(reportData) {
        const history = this.loadHistory();
        
        const newReport = {
            timestamp: reportData.timestamp || new Date().toISOString(),
            command: reportData.command,
            health_score: reportData.health_score,
            total_issues: reportData.total_issues,
            severity_breakdown: reportData.severity_breakdown,
            file: reportData.file,
            duration_seconds: reportData.duration_seconds,
            toolkit_version: reportData.toolkit_version
        };

        history.reports.unshift(newReport); // Add to beginning

        // Keep only last 50 reports
        if (history.reports.length > 50) {
            history.reports = history.reports.slice(0, 50);
        }

        this.saveHistory(history);
        return history;
    }

    /**
     * Save history to file
     */
    saveHistory(history) {
        fs.writeFileSync(this.historyFile, JSON.stringify(history, null, 2));
    }

    /**
     * Get trend analysis
     */
    getTrends() {
        const history = this.loadHistory();
        const reports = history.reports;

        if (reports.length < 2) {
            return { health_score_trend: 'stable', issues_trend: 'stable' };
        }

        const latest = reports[0];
        const previous = reports[1];

        const healthTrend = latest.health_score > previous.health_score + 5 ? 'improving' :
                          latest.health_score < previous.health_score - 5 ? 'declining' : 'stable';

        const issuesTrend = latest.total_issues < previous.total_issues - 5 ? 'decreasing' :
                           latest.total_issues > previous.total_issues + 5 ? 'increasing' : 'stable';

        return {
            health_score_trend: healthTrend,
            issues_trend: issuesTrend,
            previous_health_score: previous.health_score,
            health_score_change: latest.health_score - previous.health_score,
            issues_change: latest.total_issues - previous.total_issues,
            last_analysis: previous.timestamp
        };
    }

    /**
     * Generate historical comparison markdown
     */
    generateComparisonMarkdown() {
        const trends = this.getTrends();
        const history = this.loadHistory();

        if (history.reports.length < 2) {
            return "No previous analysis available for comparison.";
        }

        const trendEmoji = {
            improving: "📈",
            declining: "📉", 
            stable: "➡️",
            decreasing: "📉",
            increasing: "📈"
        };

        return `### Historical Comparison

**Previous Analysis**: ${new Date(trends.last_analysis).toLocaleString()}

| Metric | Change | Trend |
|--------|--------|-------|
| Health Score | ${trends.health_score_change > 0 ? '+' : ''}${trends.health_score_change} | ${trendEmoji[trends.health_score_trend]} ${trends.health_score_trend} |
| Total Issues | ${trends.issues_change > 0 ? '+' : ''}${trends.issues_change} | ${trendEmoji[trends.issues_trend]} ${trends.issues_trend} |

**Analysis Count**: ${history.reports.length} total analyses in history`;
    }
}

module.exports = ReportHistory;

// CLI usage
if (require.main === module) {
    const command = process.argv[2];
    const history = new ReportHistory();

    switch (command) {
        case 'add':
            const reportData = JSON.parse(process.argv[3]);
            history.addReport(reportData);
            console.log('Report added to history');
            break;
        
        case 'trends':
            console.log(JSON.stringify(history.getTrends(), null, 2));
            break;
        
        case 'comparison':
            console.log(history.generateComparisonMarkdown());
            break;
        
        case 'show':
            console.log(JSON.stringify(history.loadHistory(), null, 2));
            break;
        
        default:
            console.log('Usage: report-history.js [add|trends|comparison|show] [data]');
    }
}