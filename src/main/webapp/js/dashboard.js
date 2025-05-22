// Ghar Dalali - Dashboard JavaScript

document.addEventListener('DOMContentLoaded', function () {
    // Dashboard Navigation
    const navLinks = document.querySelectorAll('.dashboard-nav a');
    const dashboardPanels = document.querySelectorAll('.dashboard-panel');

    navLinks.forEach(link => {
        link.addEventListener('click', function (e) {
            e.preventDefault();

            // Get the target panel ID from the href attribute
            const targetPanelId = this.getAttribute('href').substring(1);

            // Remove active class from all links and panels
            navLinks.forEach(link => link.classList.remove('active'));
            dashboardPanels.forEach(panel => panel.classList.remove('active'));

            // Add active class to clicked link and corresponding panel
            this.classList.add('active');
            document.getElementById(targetPanelId).classList.add('active');
        });
    });

    // View Full Profile Button is now a direct link to profile.html
    // No JavaScript needed for this as it's a standard anchor tag

    // Remove Saved Property Buttons
    const removePropertyBtns = document.querySelectorAll('.saved-property-item .btn-danger');
    removePropertyBtns.forEach(btn => {
        btn.addEventListener('click', function () {
            const propertyItem = this.closest('.saved-property-item');

            // Simple confirmation
            if (confirm('Are you sure you want to remove this property from your saved list?')) {
                // This would typically send an AJAX request to the server
                propertyItem.remove();
            }
        });
    });

    // Review Actions
    const editReviewBtns = document.querySelectorAll('.review-actions .btn-outline');
    const deleteReviewBtns = document.querySelectorAll('.review-actions .btn-danger');

    editReviewBtns.forEach(btn => {
        btn.addEventListener('click', function () {
            // This would typically show a modal with the review form
            alert('Edit review functionality would be implemented here.');
        });
    });

    deleteReviewBtns.forEach(btn => {
        btn.addEventListener('click', function () {
            const reviewItem = this.closest('.review-item');

            // Simple confirmation
            if (confirm('Are you sure you want to delete this review?')) {
                // This would typically send an AJAX request to the server
                reviewItem.remove();
            }
        });
    });

    // Property Modal
    const addBtn = document.querySelector('[data-action="add-property"]');
    const modal = document.getElementById('addPropertyModal');

    if (addBtn && modal) {
        addBtn.addEventListener('click', togglePropertyModal);
    }
});

// Toggle property modal function
function togglePropertyModal() {
    const modal = document.getElementById("addPropertyModal");
    if (!modal) return;

    modal.classList.toggle("active");

    // Reset form when closing
    if (!modal.classList.contains("active")) {
        const form = document.getElementById("addPropertyForm");
        if (form) form.reset();
    }
}

// Tab functionality
function showTab(tabId) {
    // Hide all tab contents
    const tabs = document.querySelectorAll('.tab-content');
    tabs.forEach(tab => tab.classList.remove('active'));

    // Remove active class from all tab links
    const tabLinks = document.querySelectorAll('.tab-link');
    tabLinks.forEach(link => link.classList.remove('active'));

    // Show the selected tab content and activate the tab link
    document.getElementById(tabId).classList.add('active');
    document.querySelector(`.tab-link[onclick="showTab('${tabId}')"]`).classList.add('active');
}