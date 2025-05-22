// Ghar Dalali - Main JavaScript File

document.addEventListener('DOMContentLoaded', function () {
    // Mobile Menu Toggle
    const mobileMenuToggle = document.querySelector('.mobile-menu-toggle, .gd-mobile-menu-toggle');
    const navMenu = document.querySelector('.nav-menu, .gd-nav-menu');
    const authButtons = document.querySelector('.auth-buttons, .gd-auth-buttons');

    if (mobileMenuToggle) {
        mobileMenuToggle.addEventListener('click', function () {
            // Toggle classes for both original and new class names
            document.querySelector('.nav-menu')?.classList.toggle('active');
            document.querySelector('.gd-nav-menu')?.classList.toggle('active');
            document.querySelector('.auth-buttons')?.classList.toggle('active');
            document.querySelector('.gd-auth-buttons')?.classList.toggle('active');
            document.querySelector('.mobile-menu-toggle')?.classList.toggle('active');
            document.querySelector('.gd-mobile-menu-toggle')?.classList.toggle('active');
        });
    }

    // Close menu when clicking outside
    document.addEventListener('click', function(event) {
        const navbar = document.querySelector('.navbar');
        const navMenuActive = document.querySelector('.nav-menu.active, .gd-nav-menu.active');

        if (navbar && navMenuActive && !navbar.contains(event.target)) {
            document.querySelector('.nav-menu')?.classList.remove('active');
            document.querySelector('.gd-nav-menu')?.classList.remove('active');
            document.querySelector('.auth-buttons')?.classList.remove('active');
            document.querySelector('.gd-auth-buttons')?.classList.remove('active');
            document.querySelector('.mobile-menu-toggle')?.classList.remove('active');
            document.querySelector('.gd-mobile-menu-toggle')?.classList.remove('active');
        }
    });

    // Property Carousel
    const carousel = document.querySelector('.property-carousel');
    const prevButton = document.querySelector('.carousel-prev');
    const nextButton = document.querySelector('.carousel-next');

    if (carousel && prevButton && nextButton) {
        const cardWidth = carousel.querySelector('.property-card').offsetWidth;
        const gap = 16; // This should match the gap in CSS
        const scrollAmount = cardWidth + gap;

        prevButton.addEventListener('click', function () {
            carousel.scrollBy({
                left: -scrollAmount,
                behavior: 'smooth'
            });
        });

        nextButton.addEventListener('click', function () {
            carousel.scrollBy({
                left: scrollAmount,
                behavior: 'smooth'
            });
        });
    }
});
