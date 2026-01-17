// ===========================
// Mock Data Generator for Testing
// ===========================

/**
 * Generate fake PR data for testing analytics
 * @param {number} count - Number of PRs to generate
 * @returns {Array} Array of fake PR data
 */
export function generateMockPRData(count = 50) {
    const developers = [
        'alice-dev', 'bob-smith', 'charlie-code', 'diana-tech',
        'eve-engineer', 'frank-dev', 'grace-coder', 'henry-tech'
    ];

    const prTitles = [
        'fix: resolve login authentication bug',
        'feat: add user profile dashboard',
        'chore: update dependencies to latest versions',
        'refactor: improve code organization in auth module',
        'docs: update API documentation',
        'fix: correct payment processing error',
        'feat: implement dark mode support',
        'chore: clean up unused imports',
        'refactor: optimize database queries',
        'docs: add contributing guidelines',
        'fix: handle edge case in validation',
        'feat: add export to CSV functionality',
        'fix: resolve memory leak in component',
        'feat: implement real-time notifications',
        'chore: update CI/CD pipeline'
    ];

    const statuses = ['merged', 'merged', 'merged', 'merged', 'pending', 'closed'];
    const mockData = [];
    const now = new Date();

    for (let i = 0; i < count; i++) {
        const createdDate = new Date(now);
        createdDate.setDate(now.getDate() - Math.floor(Math.random() * 30)); // Last 30 days

        const author = developers[Math.floor(Math.random() * developers.length)];
        const status = statuses[Math.floor(Math.random() * statuses.length)];

        // Random reviewers (2-3 people, excluding author)
        const availableReviewers = developers.filter(d => d !== author);
        const numReviewers = Math.floor(Math.random() * 2) + 2;
        const reviewers = [];
        for (let j = 0; j < numReviewers && j < availableReviewers.length; j++) {
            const reviewer = availableReviewers[Math.floor(Math.random() * availableReviewers.length)];
            if (!reviewers.includes(reviewer)) {
                reviewers.push(reviewer);
            }
        }

        // Random commenters (1-4 people)
        const numCommenters = Math.floor(Math.random() * 4) + 1;
        const commenters = [];
        for (let j = 0; j < numCommenters; j++) {
            const commenter = developers[Math.floor(Math.random() * developers.length)];
            if (!commenters.includes(commenter)) {
                commenters.push(commenter);
            }
        }

        const timeToFirstApproval = status !== 'closed'
            ? Math.floor(Math.random() * 1440) + 30  // 30 min to 24 hours
            : null;

        const firstReviewer = reviewers.length > 0 ? reviewers[0] : null;

        let mergedAt = null;
        let approvedAt = null;
        let mergedBy = null;

        if (status === 'merged') {
            approvedAt = new Date(createdDate);
            approvedAt.setMinutes(approvedAt.getMinutes() + timeToFirstApproval);

            mergedAt = new Date(approvedAt);
            mergedAt.setMinutes(mergedAt.getMinutes() + Math.floor(Math.random() * 480) + 60); // 1-8 hours after approval

            mergedBy = reviewers[Math.floor(Math.random() * reviewers.length)];
        }

        const pr = {
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
        };

        mockData.push(pr);
    }

    // Sort by creation date (newest first)
    mockData.sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));

    return mockData;
}

/**
 * Save mock data to localStorage for persistence
 * @param {Array} data - Mock PR data
 */
export function saveMockDataToStorage(data) {
    try {
        localStorage.setItem('mockPRData', JSON.stringify(data));
        console.log('✅ Mock data saved to localStorage');
    } catch (error) {
        console.error('❌ Failed to save mock data:', error);
    }
}

/**
 * Load mock data from localStorage
 * @returns {Array|null} Saved mock data or null
 */
export function loadMockDataFromStorage() {
    try {
        const data = localStorage.getItem('mockPRData');
        if (data) {
            console.log('✅ Mock data loaded from localStorage');
            return JSON.parse(data);
        }
    } catch (error) {
        console.error('❌ Failed to load mock data:', error);
    }
    return null;
}

/**
 * Clear mock data from localStorage
 */
export function clearMockData() {
    localStorage.removeItem('mockPRData');
    console.log('🗑️ Mock data cleared from localStorage');
}

/**
 * Generate and save fresh mock data
 * @param {number} count - Number of PRs to generate
 * @returns {Array} Generated mock data
 */
export function generateAndSaveMockData(count = 50) {
    const data = generateMockPRData(count);
    saveMockDataToStorage(data);
    return data;
}

export default {
    generateMockPRData,
    saveMockDataToStorage,
    loadMockDataFromStorage,
    clearMockData,
    generateAndSaveMockData
};
