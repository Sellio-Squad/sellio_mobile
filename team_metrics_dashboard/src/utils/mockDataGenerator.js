/**
 * Mock data generator for testing and development
 * @module utils/mockDataGenerator
 */

import { MOCK_DATA } from '../config/constants.js';

/**
 * Generate mock PR data for testing
 * @param {number} count - Number of PRs to generate
 * @returns {Array} Array of mock PR objects
 */
export function generateMockPRData(count = MOCK_DATA.DEFAULT_PR_COUNT) {
    const developers = MOCK_DATA.DEVELOPERS;
    const prTitles = MOCK_DATA.PR_TITLES;

    const mockData = [];
    const now = new Date();

    for (let i = 0; i < count; i++) {
        const createdDate = new Date(now);
        createdDate.setDate(now.getDate() - Math.floor(Math.random() * MOCK_DATA.DAYS_LOOKBACK));

        const author = developers[Math.floor(Math.random() * developers.length)];
        const status = i % 5 === 0 ? 'pending' : (i % 15 === 0 ? 'closed' : 'merged');

        const availableReviewers = developers.filter(d => d !== author);
        const numReviewers = Math.floor(Math.random() * 2) + 2;
        const reviewers = [];
        for (let j = 0; j < numReviewers && j < availableReviewers.length; j++) {
            const reviewer = availableReviewers[Math.floor(Math.random() * availableReviewers.length)];
            if (!reviewers.includes(reviewer)) reviewers.push(reviewer);
        }

        const commenters = [];
        const numCommenters = Math.floor(Math.random() * 4) + 1;
        for (let j = 0; j < numCommenters; j++) {
            const commenter = developers[Math.floor(Math.random() * developers.length)];
            if (!commenters.includes(commenter)) commenters.push(commenter);
        }

        const timeToFirstApproval = status !== 'closed' ? Math.floor(Math.random() * 1440) + 30 : null;
        const firstReviewer = reviewers.length > 0 ? reviewers[0] : null;

        let mergedAt = null;
        let approvedAt = null;
        let mergedBy = null;

        if (status === 'merged') {
            approvedAt = new Date(createdDate);
            approvedAt.setMinutes(approvedAt.getMinutes() + timeToFirstApproval);

            mergedAt = new Date(approvedAt);
            mergedAt.setMinutes(mergedAt.getMinutes() + Math.floor(Math.random() * 480) + 60);

            mergedBy = reviewers[Math.floor(Math.random() * reviewers.length)];
        }

        mockData.push({
            number: 1000 + i,
            title: prTitles[Math.floor(Math.random() * prTitles.length)],
            url: `https://github.com/sellio/repo/pull/${1000 + i}`,
            author: author,
            status: status,
            createdAt: createdDate.toISOString(),
            mergedAt: mergedAt ? mergedAt.toISOString() : null,
            approvedAt: approvedAt ? approvedAt.toISOString() : null,
            mergedBy: mergedBy,
            additions: Math.floor(Math.random() * 500) + 50,
            deletions: Math.floor(Math.random() * 300) + 20,
            comments: Math.floor(Math.random() * 15) + 1,
            approvals: status !== 'closed' ? Math.floor(Math.random() * 3) + 1 : 0,
            reviewers: reviewers,
            commenters: commenters,
            timeToFirstApproval: timeToFirstApproval,
            firstReviewer: firstReviewer
        });
    }

    mockData.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
    return mockData;
}
