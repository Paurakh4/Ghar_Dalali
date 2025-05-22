// Ghar Dalali - Application Tracking JavaScript

document.addEventListener('DOMContentLoaded', function () {
    // Initialize application tracking if the user is logged in
    initApplicationTracking();
});

/**
 * Initializes the application tracking functionality
 */
function initApplicationTracking() {
    // Check if the application tracking container exists
    const appTrackingContainer = document.querySelector('.app-tracking-container');
    if (!appTrackingContainer) return;

    // Get the application tracking icon and dropdown
    const appTrackingIcon = appTrackingContainer.querySelector('.app-tracking-icon');
    const appTrackingDropdown = appTrackingContainer.querySelector('.app-tracking-dropdown');
    const notificationBadge = appTrackingContainer.querySelector('.notification-badge');
    const appTrackingBody = appTrackingContainer.querySelector('.app-tracking-body');
    const appTrackingClose = appTrackingContainer.querySelector('.app-tracking-close');

    // Load the application count
    loadApplicationCount(notificationBadge);

    // Toggle dropdown when clicking the icon
    if (appTrackingIcon && appTrackingDropdown) {
        appTrackingIcon.addEventListener('click', function (e) {
            e.stopPropagation();
            appTrackingDropdown.classList.toggle('active');

            // Load application list when opening the dropdown
            if (appTrackingDropdown.classList.contains('active')) {
                loadApplicationList(appTrackingBody);
            }
        });
    }

    // Close dropdown when clicking the close button
    if (appTrackingClose && appTrackingDropdown) {
        appTrackingClose.addEventListener('click', function (e) {
            e.stopPropagation();
            appTrackingDropdown.classList.remove('active');
        });
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function (e) {
        if (appTrackingDropdown && !appTrackingContainer.contains(e.target)) {
            appTrackingDropdown.classList.remove('active');
        }
    });
}

/**
 * Loads the application count for the current user
 * @param {HTMLElement} badgeElement - The notification badge element
 */
function loadApplicationCount(badgeElement) {
    if (!badgeElement) return;

    console.log('Loading application count...');

    // Make AJAX request to get application count
    fetch(getContextPath() + '/application-tracking/count')
        .then(response => {
            console.log('Application count response status:', response.status);
            if (!response.ok) {
                return response.text().then(text => {
                    console.error('Error response text:', text);
                    throw new Error('Failed to load application count: ' + response.status);
                });
            }
            return response.json();
        })
        .then(data => {
            console.log('Application count data:', data);

            // Update the badge with the count
            const count = data.count || 0;
            badgeElement.textContent = count;

            // Show/hide badge based on count
            if (count > 0) {
                badgeElement.classList.remove('empty');
            } else {
                badgeElement.classList.add('empty');
            }
        })
        .catch(error => {
            console.error('Error loading application count:', error);
            badgeElement.classList.add('empty');
        });
}

/**
 * Loads the application list for the current user
 * @param {HTMLElement} bodyElement - The dropdown body element
 */
function loadApplicationList(bodyElement) {
    if (!bodyElement) return;

    console.log('Loading application list...');

    // Show loading state
    bodyElement.innerHTML = '<div class="app-tracking-empty">Loading applications...</div>';

    // Make AJAX request to get application list
    fetch(getContextPath() + '/application-tracking/list')
        .then(response => {
            console.log('Application list response status:', response.status);
            if (!response.ok) {
                return response.text().then(text => {
                    console.error('Error response text:', text);
                    throw new Error('Failed to load applications: ' + response.status);
                });
            }
            return response.json();
        })
        .then(applications => {
            console.log('Application list data:', applications);

            // Check if there are any applications
            if (!applications || applications.length === 0) {
                bodyElement.innerHTML = '<div class="app-tracking-empty">No applications found</div>';
                return;
            }

            // Create HTML for the application list
            let html = '<ul class="app-tracking-list">';

            applications.forEach(app => {
                console.log('Processing application:', app);

                // Format date
                let formattedDate = 'Unknown date';
                try {
                    if (app.createdAt) {
                        const createdDate = new Date(app.createdAt);
                        formattedDate = createdDate.toLocaleDateString('en-US', {
                            year: 'numeric',
                            month: 'short',
                            day: 'numeric'
                        });
                    }
                } catch (e) {
                    console.error('Error formatting date:', e);
                }

                // Determine status class
                let statusClass = 'pending';
                let status = app.status || 'PENDING';
                if (status === 'APPROVED') {
                    statusClass = 'approved';
                } else if (status === 'REJECTED') {
                    statusClass = 'rejected';
                }

                html += `
                <li class="app-tracking-item">
                    <div class="app-tracking-property">${app.propertyTitle || 'Property'}</div>
                    <div class="app-tracking-meta">
                        <span>${formattedDate}</span>
                        <span class="app-tracking-status ${statusClass}">${status}</span>
                    </div>
                    <div class="app-tracking-location">${app.propertyLocation || 'Location not available'}</div>
                </li>`;
            });

            html += '</ul>';

            // Update the dropdown body
            bodyElement.innerHTML = html;
        })
        .catch(error => {
            console.error('Error loading applications:', error);
            bodyElement.innerHTML = '<div class="app-tracking-empty">Error loading applications. Please try again later.</div>';
        });
}

/**
 * Gets the context path of the application
 * @returns {string} The context path
 */
function getContextPath() {
    return window.contextPath || '';
}
