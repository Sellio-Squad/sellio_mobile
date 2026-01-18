/**
 * GitHub API Configuration Template
 * @module config/github-config.example
 * 
 * INSTRUCTIONS:
 * 1. Copy this file to 'github-config.js' in the same directory
 * 2. Replace the placeholder values with your actual GitHub credentials
 * 3. Never commit github-config.js to version control (it's gitignored)
 * 
 * To create a Personal Access Token (PAT):
 * 1. Go to GitHub → Settings → Developer settings → Personal access tokens → Tokens (classic)
 * 2. Click "Generate new token (classic)"
 * 3. Give it a descriptive name (e.g., "Sellio Dashboard")
 * 4. Select scopes: 'repo' (full control of private repositories)
 * 5. Generate and copy the token (it will only be shown once)
 * 
 * For GitHub Apps (like Sellio Bot):
 * - You can use the bot's token instead of a personal PAT
 * - Make sure the bot has 'Pull requests' read permission
 */

export const GITHUB_CONFIG = {
    /**
     * GitHub repository owner (organization or user)
     * Example: 'Sellio-Squad'
     */
    REPO_OWNER: 'your-github-org',

    /**
     * GitHub repository name
     * Example: 'sellio_mobile'
     */
    REPO_NAME: 'your-repo-name',

    /**
     * Personal Access Token or Bot Token
     * Example: 'ghp_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' or 'github_pat_...'
     */
    ACCESS_TOKEN: 'your-github-token-here',

    /**
     * Optional: GitHub API base URL (usually don't need to change)
     */
    API_BASE_URL: 'https://api.github.com'
};
