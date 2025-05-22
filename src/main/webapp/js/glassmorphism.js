// Ghar Dalali - Glassmorphism Effects

document.addEventListener('DOMContentLoaded', function () {
    // Get the navbar element
    const navbar = document.querySelector('.navbar');

    // Function to add/remove glass effect based on scroll position
    function handleScroll() {
        // Use a smoother transition with requestAnimationFrame
        requestAnimationFrame(() => {
            if (window.scrollY > 30) {
                navbar.classList.add('glass');
            } else {
                navbar.classList.remove('glass');
            }
        });
    }

    // Add scroll event listener with passive option for better performance
    window.addEventListener('scroll', handleScroll, { passive: true });

    // Check initial scroll position
    handleScroll();
});
