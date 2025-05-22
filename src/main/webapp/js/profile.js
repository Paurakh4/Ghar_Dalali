// Ghar Dalali - Profile Page JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Get DOM elements
    const editProfileBtn = document.getElementById('edit-profile-btn');
    const cancelEditBtn = document.getElementById('cancel-edit-btn');
    const changePasswordBtn = document.getElementById('change-password-btn');
    const cancelPasswordBtn = document.getElementById('cancel-password-btn');
   
    const viewProfileSection = document.getElementById('view-profile');
    const editProfileSection = document.getElementById('edit-profile');
    const changePasswordSection = document.getElementById('change-password');
    
    // Toggle between view and edit profile
    if (editProfileBtn) {
        editProfileBtn.addEventListener('click', function() {
            viewProfileSection.classList.remove('active');
            changePasswordSection.classList.remove('active');
            editProfileSection.classList.add('active');
        });
    }
    
    if (cancelEditBtn) {
        cancelEditBtn.addEventListener('click', function() {
            editProfileSection.classList.remove('active');
            viewProfileSection.classList.add('active');
        });
    }
    
    // Toggle password change section
    if (changePasswordBtn) {
        changePasswordBtn.addEventListener('click', function() {
            viewProfileSection.classList.remove('active');
            editProfileSection.classList.remove('active');
            changePasswordSection.classList.add('active');
        });
    }
    
    if (cancelPasswordBtn) {
        cancelPasswordBtn.addEventListener('click', function() {
            changePasswordSection.classList.remove('active');
            viewProfileSection.classList.add('active');
        });
    }
    
    
    
    // Change avatar button
    const changeAvatarBtn = document.querySelector('.change-avatar-btn');
    if (changeAvatarBtn) {
        changeAvatarBtn.addEventListener('click', function() {
            // This would typically open a file picker
            alert('Avatar change functionality would be implemented here.');
        });
    }
    
    // Toggle switches for preferences
    const toggleSwitches = document.querySelectorAll('.toggle-switch input');
    toggleSwitches.forEach(toggle => {
        toggle.addEventListener('change', function() {
            const preferenceName = this.name || this.closest('.preference-item').querySelector('h3').textContent;
            const isEnabled = this.checked;
            
            // This would typically send an AJAX request to update the preference
            console.log(`Preference "${preferenceName}" is now ${isEnabled ? 'enabled' : 'disabled'}`);
        });
    });
});

