// Ghar Dalali - Checkout JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Cart Elements
    const cartItems = document.getElementById('cartItems');
    const cartEmpty = document.getElementById('cartEmpty');
    const cartCount = document.getElementById('cartCount');
    const clearCartBtn = document.getElementById('clearCart');
    const subtotalEl = document.getElementById('subtotal');
    const taxEl = document.getElementById('tax');
    const discountEl = document.getElementById('discount');
    const discountRow = document.querySelector('.summary-row.discount');
    const totalEl = document.getElementById('total');
    const promoCodeInput = document.getElementById('promoCode');
    const applyPromoBtn = document.getElementById('applyPromo');
    const proceedToPaymentBtn = document.getElementById('proceedToPayment');
    
    // Payment Elements
    const paymentSection = document.getElementById('paymentSection');
    const paymentTabs = document.querySelectorAll('.payment-tab');
    const paymentForms = document.querySelectorAll('.payment-form');
    const backToCartBtn = document.getElementById('backToCart');
    const completePaymentBtn = document.getElementById('completePayment');
    
    // Cart Functionality
    
    // Initialize cart
    updateCart();
    
    // Quantity buttons
    cartItems.addEventListener('click', function(e) {
        // Increase quantity
        if (e.target.classList.contains('increase')) {
            const input = e.target.previousElementSibling;
            input.value = parseInt(input.value) + 1;
            updateItemTotal(input);
        }
        
        // Decrease quantity
        if (e.target.classList.contains('decrease')) {
            const input = e.target.nextElementSibling;
            if (parseInt(input.value) > 1) {
                input.value = parseInt(input.value) - 1;
                updateItemTotal(input);
            }
        }
        
        // Remove item
        if (e.target.classList.contains('remove-item')) {
            const item = e.target.closest('.cart-item');
            item.remove();
            updateCart();
        }
    });
    
    // Quantity input change
    cartItems.addEventListener('change', function(e) {
        if (e.target.classList.contains('quantity-input')) {
            // Ensure value is at least 1
            if (parseInt(e.target.value) < 1) {
                e.target.value = 1;
            }
            updateItemTotal(e.target);
        }
    });
    
    // Clear cart
    if (clearCartBtn) {
        clearCartBtn.addEventListener('click', function() {
            if (confirm('Are you sure you want to clear your cart?')) {
                const items = cartItems.querySelectorAll('.cart-item');
                items.forEach(item => item.remove());
                updateCart();
            }
        });
    }
    
    // Apply promo code
    if (applyPromoBtn) {
        applyPromoBtn.addEventListener('click', function() {
            const promoCode = promoCodeInput.value.trim().toUpperCase();
            
            if (promoCode === 'GHAR10') {
                // 10% discount
                const subtotal = parseFloat(subtotalEl.textContent.replace('$', ''));
                const discount = subtotal * 0.1;
                
                discountEl.textContent = `-$${discount.toFixed(2)}`;
                discountRow.style.display = 'flex';
                
                // Update total
                updateTotal();
                
                // Show success message
                alert('Promo code applied successfully!');
            } else if (promoCode === '') {
                alert('Please enter a promo code.');
            } else {
                alert('Invalid promo code. Please try again.');
            }
        });
    }
    
    // Proceed to payment
    if (proceedToPaymentBtn) {
        proceedToPaymentBtn.addEventListener('click', function() {
            const items = cartItems.querySelectorAll('.cart-item');
            if (items.length === 0) {
                alert('Your cart is empty. Please add items before proceeding to payment.');
                return;
            }
            
            document.querySelector('.checkout-section').style.display = 'none';
            paymentSection.style.display = 'block';
            
            // Scroll to top
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
    
    // Payment Functionality
    
    // Payment method tabs
    paymentTabs.forEach(tab => {
        tab.addEventListener('click', function() {
            // Remove active class from all tabs and forms
            paymentTabs.forEach(t => t.classList.remove('active'));
            paymentForms.forEach(f => f.classList.remove('active'));
            
            // Add active class to clicked tab and corresponding form
            this.classList.add('active');
            const method = this.getAttribute('data-method');
            document.getElementById(`${method}Form`).classList.add('active');
        });
    });
    
    // Back to cart
    if (backToCartBtn) {
        backToCartBtn.addEventListener('click', function() {
            paymentSection.style.display = 'none';
            document.querySelector('.checkout-section').style.display = 'block';
            
            // Scroll to top
            window.scrollTo({
                top: 0,
                behavior: 'smooth'
            });
        });
    }
    
    // Complete payment
    if (completePaymentBtn) {
        completePaymentBtn.addEventListener('click', function() {
            // Simple validation
            const activeForm = document.querySelector('.payment-form.active');
            const requiredFields = activeForm.querySelectorAll('input[required]');
            let isValid = true;
            
            requiredFields.forEach(field => {
                if (!field.value.trim()) {
                    isValid = false;
                    field.classList.add('error');
                } else {
                    field.classList.remove('error');
                }
            });
            
            // Billing address validation
            const fullName = document.getElementById('fullName');
            const email = document.getElementById('email');
            const phone = document.getElementById('phone');
            const address = document.getElementById('address');
            
            if (!fullName.value.trim()) {
                isValid = false;
                fullName.classList.add('error');
            } else {
                fullName.classList.remove('error');
            }
            
            if (!email.value.trim() || !isValidEmail(email.value)) {
                isValid = false;
                email.classList.add('error');
            } else {
                email.classList.remove('error');
            }
            
            if (!phone.value.trim()) {
                isValid = false;
                phone.classList.add('error');
            } else {
                phone.classList.remove('error');
            }
            
            if (!address.value.trim()) {
                isValid = false;
                address.classList.add('error');
            } else {
                address.classList.remove('error');
            }
            
            if (!isValid) {
                alert('Please fill in all required fields correctly.');
                return;
            }
            
            // Simulate payment processing
            alert('Payment successful! Thank you for your purchase.');
            
            // Redirect to confirmation page (would be implemented in a real application)
            // window.location.href = 'confirmation.html';
            
            // For demo purposes, clear cart and return to homepage
            setTimeout(() => {
                window.location.href = '../index.html';
            }, 1000);
        });
    }
    
    // Helper Functions
    
    // Update item total
    function updateItemTotal(input) {
        const item = input.closest('.cart-item');
        const price = parseFloat(item.querySelector('.item-price').textContent.replace('$', ''));
        const quantity = parseInt(input.value);
        const total = price * quantity;
        
        item.querySelector('.item-total').textContent = `$${total.toFixed(2)}`;
        
        updateCart();
    }
    
    // Update cart
    function updateCart() {
        const items = cartItems.querySelectorAll('.cart-item');
        
        // Update cart count
        cartCount.textContent = `${items.length} item${items.length !== 1 ? 's' : ''}`;
        
        // Show/hide empty cart message
        if (items.length === 0) {
            cartItems.style.display = 'none';
            cartEmpty.style.display = 'block';
        } else {
            cartItems.style.display = 'block';
            cartEmpty.style.display = 'none';
        }
        
        // Calculate subtotal
        let subtotal = 0;
        items.forEach(item => {
            const itemTotal = parseFloat(item.querySelector('.item-total').textContent.replace('$', ''));
            subtotal += itemTotal;
        });
        
        // Update summary
        subtotalEl.textContent = `$${subtotal.toFixed(2)}`;
        
        // Calculate tax (13%)
        const tax = subtotal * 0.13;
        taxEl.textContent = `$${tax.toFixed(2)}`;
        
        // Update total
        updateTotal();
    }
    
    // Update total
    function updateTotal() {
        const subtotal = parseFloat(subtotalEl.textContent.replace('$', ''));
        const tax = parseFloat(taxEl.textContent.replace('$', ''));
        let discount = 0;
        
        if (discountRow.style.display !== 'none') {
            discount = parseFloat(discountEl.textContent.replace('-$', ''));
        }
        
        const total = subtotal + tax - discount;
        totalEl.textContent = `$${total.toFixed(2)}`;
        
        // Update order reference with a random number
        const orderRef = document.getElementById('orderReference');
        if (orderRef) {
            orderRef.textContent = `GD${Math.floor(10000 + Math.random() * 90000)}`;
        }
    }
    
    // Validate email
    function isValidEmail(email) {
        const re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    }
});
