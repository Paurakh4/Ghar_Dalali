// Ghar Dalali - Admin Dashboard JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // User Management
    const addUserBtn = document.querySelector('#users .btn-primary');
    const editUserBtns = document.querySelectorAll('#users .btn-icon.edit');
    const deleteUserBtns = document.querySelectorAll('#users .btn-icon.delete');
    
    if (addUserBtn) {
        addUserBtn.addEventListener('click', function() {
            // This would typically show a modal with a user form
            alert('Add user functionality would be implemented here.');
        });
    }
    
    editUserBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const userId = row.cells[0].textContent;
            
            // This would typically show a modal with a user form
            alert(`Edit user with ID: ${userId}`);
        });
    });
    
    deleteUserBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const userId = row.cells[0].textContent;
            
            // Simple confirmation
            if (confirm(`Are you sure you want to delete user with ID: ${userId}?`)) {
                // This would typically send an AJAX request to the server
                row.remove();
            }
        });
    });
    
    // Property Management
    const addPropertyBtn = document.querySelector('#properties .btn-primary');
    const viewPropertyBtns = document.querySelectorAll('#properties .btn-icon.view');
    const editPropertyBtns = document.querySelectorAll('#properties .btn-icon.edit');
    const deletePropertyBtns = document.querySelectorAll('#properties .btn-icon.delete');
    
    if (addPropertyBtn) {
        addPropertyBtn.addEventListener('click', function() {
            // This would typically show a modal with a property form
            alert('Add property functionality would be implemented here.');
        });
    }
    
    viewPropertyBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const propertyId = row.cells[0].textContent;
            
            // This would typically navigate to the property detail page
            alert(`View property with ID: ${propertyId}`);
        });
    });
    
    editPropertyBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const propertyId = row.cells[0].textContent;
            
            // This would typically show a modal with a property form
            alert(`Edit property with ID: ${propertyId}`);
        });
    });
    
    deletePropertyBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const propertyId = row.cells[0].textContent;
            
            // Simple confirmation
            if (confirm(`Are you sure you want to delete property with ID: ${propertyId}?`)) {
                // This would typically send an AJAX request to the server
                row.remove();
            }
        });
    });
    
    // Review Management
    const viewReviewBtns = document.querySelectorAll('#reviews .btn-icon.view');
    const editReviewBtns = document.querySelectorAll('#reviews .btn-icon.edit');
    const approveReviewBtns = document.querySelectorAll('#reviews .btn-icon.approve');
    const rejectReviewBtns = document.querySelectorAll('#reviews .btn-icon.reject');
    const deleteReviewBtns = document.querySelectorAll('#reviews .btn-icon.delete');
    
    viewReviewBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const reviewId = row.cells[0].textContent;
            
            // This would typically show a modal with the review details
            alert(`View review with ID: ${reviewId}`);
        });
    });
    
    editReviewBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const reviewId = row.cells[0].textContent;
            
            // This would typically show a modal with a review form
            alert(`Edit review with ID: ${reviewId}`);
        });
    });
    
    approveReviewBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const reviewId = row.cells[0].textContent;
            
            // This would typically send an AJAX request to the server
            alert(`Approve review with ID: ${reviewId}`);
            
            // Update status
            const statusCell = row.cells[4];
            statusCell.innerHTML = '<span class="status approved">Approved</span>';
            
            // Update actions
            const actionsCell = row.cells[5];
            actionsCell.innerHTML = `
                <button class="btn-icon view">View</button>
                <button class="btn-icon edit">Edit</button>
                <button class="btn-icon delete">Delete</button>
            `;
        });
    });
    
    rejectReviewBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const reviewId = row.cells[0].textContent;
            
            // This would typically send an AJAX request to the server
            alert(`Reject review with ID: ${reviewId}`);
            
            // Update status
            const statusCell = row.cells[4];
            statusCell.innerHTML = '<span class="status rejected">Rejected</span>';
            
            // Update actions
            const actionsCell = row.cells[5];
            actionsCell.innerHTML = `
                <button class="btn-icon view">View</button>
                <button class="btn-icon approve">Approve</button>
                <button class="btn-icon delete">Delete</button>
            `;
        });
    });
    
    deleteReviewBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const reviewId = row.cells[0].textContent;
            
            // Simple confirmation
            if (confirm(`Are you sure you want to delete review with ID: ${reviewId}?`)) {
                // This would typically send an AJAX request to the server
                row.remove();
            }
        });
    });
    
    // Transaction Management
    const generateReportBtn = document.querySelector('#transactions .btn-outline');
    const addTransactionBtn = document.querySelector('#transactions .btn-primary');
    const viewTransactionBtns = document.querySelectorAll('#transactions .btn-icon.view');
    const receiptBtns = document.querySelectorAll('#transactions .btn-icon.receipt');
    const processBtns = document.querySelectorAll('#transactions .btn-icon.process');
    const retryBtns = document.querySelectorAll('#transactions .btn-icon.retry');
    
    if (generateReportBtn) {
        generateReportBtn.addEventListener('click', function() {
            // This would typically generate a report
            alert('Generate report functionality would be implemented here.');
        });
    }
    
    if (addTransactionBtn) {
        addTransactionBtn.addEventListener('click', function() {
            // This would typically show a modal with a transaction form
            alert('Add transaction functionality would be implemented here.');
        });
    }
    
    viewTransactionBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const transactionId = row.cells[0].textContent;
            
            // This would typically show a modal with the transaction details
            alert(`View transaction with ID: ${transactionId}`);
        });
    });
    
    receiptBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const transactionId = row.cells[0].textContent;
            
            // This would typically download or show a receipt
            alert(`Download receipt for transaction with ID: ${transactionId}`);
        });
    });
    
    processBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const transactionId = row.cells[0].textContent;
            
            // This would typically send an AJAX request to the server
            alert(`Process transaction with ID: ${transactionId}`);
            
            // Update status
            const statusCell = row.cells[5];
            statusCell.innerHTML = '<span class="status approved">Completed</span>';
            
            // Update actions
            const actionsCell = row.cells[6];
            actionsCell.innerHTML = `
                <button class="btn-icon view">View</button>
                <button class="btn-icon receipt">Receipt</button>
            `;
        });
    });
    
    retryBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const row = this.closest('tr');
            const transactionId = row.cells[0].textContent;
            
            // This would typically send an AJAX request to the server
            alert(`Retry transaction with ID: ${transactionId}`);
            
            // Update status
            const statusCell = row.cells[5];
            statusCell.innerHTML = '<span class="status pending">Processing</span>';
            
            // Update actions
            const actionsCell = row.cells[6];
            actionsCell.innerHTML = `
                <button class="btn-icon view">View</button>
                <button class="btn-icon process">Process</button>
            `;
        });
    });
    
    // Settings Forms
    const settingsForms = document.querySelectorAll('.settings-form');
    
    settingsForms.forEach(form => {
        form.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // This would typically send an AJAX request to the server
            alert('Settings saved successfully!');
        });
    });
});
