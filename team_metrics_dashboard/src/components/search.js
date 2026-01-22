/**
 * Search Component
 * @module components/search
 * 
 * Provides search and filter functionality for the dashboard
 */

import { STRINGS } from '../resources/strings.js';

/**
 * Render search bar with filters
 * @param {Function} onSearch - Callback function when search/filter changes
 */
export function renderSearchBar(onSearch) {
    const searchContainer = document.getElementById('search-container');
    if (!searchContainer) {
        console.error('Search container not found');
        return;
    }

    searchContainer.innerHTML = `
        <div class="panel">
            <div class="flex flex-wrap gap-4 items-center">
                <!-- Search input -->
                <div class="flex-1 min-w-[200px]">
                    <input 
                        type="text" 
                        id="search-input" 
                        class="control-input w-full" 
                        placeholder="Search by PR#, title, or author..."
                    />
                </div>
                
                <!-- Status filter -->
                <div class="min-w-[150px]">
                    <select id="status-filter" class="control-input w-full">
                        <option value="all">All Status</option>
                        <option value="open">Open</option>
                        <option value="pending">Pending Approval</option>
                        <option value="approved">Approved</option>
                        <option value="merged">Merged</option>
                        <option value="closed">Closed</option>
                    </select>
                </div>
                
                <!-- Label filter -->
                <div class="min-w-[150px]">
                    <select id="label-filter" class="control-input w-full">
                        <option value="all">All Labels</option>
                        <!-- Labels will be populated dynamically -->
                    </select>
                </div>
                
                <!-- Clear button -->
                <button id="clear-search-btn" class="btn-secondary">
                    Clear Filters
                </button>
            </div>
        </div>
    `;

    // Add event listeners
    const searchInput = document.getElementById('search-input');
    const statusFilter = document.getElementById('status-filter');
    const labelFilter = document.getElementById('label-filter');
    const clearBtn = document.getElementById('clear-search-btn');

    const performSearch = () => {
        const searchTerm = searchInput.value.toLowerCase();
        const status = statusFilter.value;
        const label = labelFilter.value;

        onSearch({ searchTerm, status, label });
    };

    searchInput.addEventListener('input', performSearch);
    statusFilter.addEventListener('change', performSearch);
    labelFilter.addEventListener('change', performSearch);

    clearBtn.addEventListener('click', () => {
        searchInput.value = '';
        statusFilter.value = 'all';
        labelFilter.value = 'all';
        performSearch();
    });
}

/**
 * Update label filter options based on available labels in data
 * @param {Array} prData - Array of PR data
 */
export function updateLabelOptions(prData) {
    const labelFilter = document.getElementById('label-filter');
    if (!labelFilter) return;

    // Collect all unique labels
    const allLabels = new Set();
    prData.forEach(pr => {
        if (pr.labels && Array.isArray(pr.labels)) {
            pr.labels.forEach(label => allLabels.add(label));
        }
    });

    // Populate label filter
    const sortedLabels = Array.from(allLabels).sort();
    const options = '<option value="all">All Labels</option>' +
        sortedLabels.map(label => `<option value="${label}">${label}</option>`).join('');

    labelFilter.innerHTML = options;
}

/**
 * Filter PRs based on search criteria
 * @param {Array} prData - Array of PR data
 * @param {Object} filters - Search filters
 * @returns {Array} Filtered PR data
 */
export function filterPRs(prData, filters) {
    const { searchTerm, status, label } = filters;

    return prData.filter(pr => {
        // Search term filter (PR number, title, or author)
        if (searchTerm) {
            const matchesPRNumber = pr.number.toString().includes(searchTerm);
            const matchesTitle = pr.title.toLowerCase().includes(searchTerm);
            const matchesAuthor = pr.author.toLowerCase().includes(searchTerm);

            if (!matchesPRNumber && !matchesTitle && !matchesAuthor) {
                return false;
            }
        }

        // Status filter
        if (status && status !== 'all') {
            if (status === 'open' && pr.status !== 'pending' && pr.status !== 'approved') {
                return false;
            } else if (status !== 'open' && pr.status !== status) {
                return false;
            }
        }

        // Label filter
        if (label && label !== 'all') {
            if (!pr.labels || !pr.labels.includes(label)) {
                return false;
            }
        }

        return true;
    });
}
