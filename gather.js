/*
 * Generate a json list of commits
 */

import { exec } from 'child_process';
import { writeFileSync } from 'fs';

function getCommitDates() {
    return new Promise((resolve, reject) => {
        exec('git log --pretty=format:"%ad" --date=short', (err, stdout) => {
            if (err) return reject(err);
            const dates = stdout.trim().split('\n');
            resolve(dates);
        });
    });
}

function aggregateCommits(dates) {
    const counts = {};
    dates.forEach(date => {
        counts[date] = (counts[date] || 0) + 1;
    });
    return counts;
}


(async () => {
    try {
        const dates = await getCommitDates();
        const aggregates = aggregateCommits(dates);
        writeFileSync('public/commits.json', JSON.stringify(aggregates, null, 2));
        console.log('Commit data written to commits.json');
    } catch (e) {
        console.error('Error fetching git log', e);
    }
})();
