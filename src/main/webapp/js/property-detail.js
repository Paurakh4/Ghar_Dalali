// Ghar Dalali - Property Detail JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Image Gallery
    const mainImage = document.querySelector('.main-image img');
    const thumbnails = document.querySelectorAll('.thumbnail-images img');

    if (mainImage && thumbnails.length > 0) {
        // Set the first thumbnail as active by default
        thumbnails[0].classList.add('active');

        thumbnails.forEach(thumbnail => {
            thumbnail.addEventListener('click', function() {
                // Update main image
                mainImage.src = this.src;

                // Update active thumbnail
                thumbnails.forEach(thumb => thumb.classList.remove('active'));
                this.classList.add('active');
            });
        });
    }

    // Rating System
    const ratingStars = document.querySelectorAll('.rating-input .star');

    if (ratingStars.length > 0) {
        let selectedRating = 0;

        ratingStars.forEach((star, index) => {
            // Mouse enter event
            star.addEventListener('mouseenter', function() {
                // Fill stars up to the hovered one
                for (let i = 0; i <= index; i++) {
                    ratingStars[i].classList.add('filled');
                }

                // Clear stars after the hovered one
                for (let i = index + 1; i < ratingStars.length; i++) {
                    ratingStars[i].classList.remove('filled');
                }
            });

            // Mouse leave event
            star.addEventListener('mouseleave', function() {
                // Reset to selected rating
                ratingStars.forEach((s, i) => {
                    if (i < selectedRating) {
                        s.classList.add('filled');
                    } else {
                        s.classList.remove('filled');
                    }
                });
            });

            // Click event
            star.addEventListener('click', function() {
                selectedRating = index + 1;

                // Update visual state
                for (let i = 0; i < ratingStars.length; i++) {
                    if (i < selectedRating) {
                        ratingStars[i].classList.add('filled');
                    } else {
                        ratingStars[i].classList.remove('filled');
                    }
                }
            });
        });
    }
});
