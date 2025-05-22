// Ghar Dalali - Modals JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Create modal container if it doesn't exist
    let modalContainer = document.querySelector('.modal-container');
    if (!modalContainer) {
        modalContainer = document.createElement('div');
        modalContainer.className = 'modal-container';
        document.body.appendChild(modalContainer);
    }

    // Add CSS for modals
    const style = document.createElement('style');
    style.textContent = `
        .modal-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 9999;
            opacity: 0;
            visibility: hidden;
            transition: opacity 0.3s ease, visibility 0.3s ease;
        }

        .modal-container.active {
            opacity: 1;
            visibility: visible;
        }

        .modal {
            background-color: white;
            border-radius: 5px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 500px;
            max-height: 90vh;
            overflow-y: auto;
            transform: translateY(-20px);
            transition: transform 0.3s ease;
        }

        .modal-container.active .modal {
            transform: translateY(0);
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            border-bottom: 1px solid #ddd;
        }

        .modal-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin: 0;
        }

        .modal-close {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: #777;
        }

        .modal-body {
            padding: 20px;
        }

        .modal-footer {
            padding: 15px 20px;
            border-top: 1px solid #ddd;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }
    `;
    document.head.appendChild(style);

    // Modal Functions
    window.Modal = {
        // Show a modal with the given content
        show: function(options) {
            const { title, content, footer } = options;

            // Create modal element
            const modal = document.createElement('div');
            modal.className = 'modal';

            // Create modal header
            const modalHeader = document.createElement('div');
            modalHeader.className = 'modal-header';

            const modalTitle = document.createElement('h3');
            modalTitle.className = 'modal-title';
            modalTitle.textContent = title || 'Modal Title';

            const closeButton = document.createElement('button');
            closeButton.className = 'modal-close';
            closeButton.innerHTML = '&times;';
            closeButton.addEventListener('click', function() {
                Modal.hide();
            });

            modalHeader.appendChild(modalTitle);
            modalHeader.appendChild(closeButton);

            // Create modal body
            const modalBody = document.createElement('div');
            modalBody.className = 'modal-body';

            if (typeof content === 'string') {
                modalBody.innerHTML = content;
            } else if (content instanceof HTMLElement) {
                modalBody.appendChild(content);
            }

            // Create modal footer
            const modalFooter = document.createElement('div');
            modalFooter.className = 'modal-footer';

            if (footer) {
                if (typeof footer === 'string') {
                    modalFooter.innerHTML = footer;
                } else if (footer instanceof HTMLElement) {
                    modalFooter.appendChild(footer);
                }
            } else {
                // Default footer with close button
                const closeBtn = document.createElement('button');
                closeBtn.className = 'btn btn-outline';
                closeBtn.textContent = 'Close';
                closeBtn.addEventListener('click', function() {
                    Modal.hide();
                });
                modalFooter.appendChild(closeBtn);
            }

            // Assemble modal
            modal.appendChild(modalHeader);
            modal.appendChild(modalBody);
            modal.appendChild(modalFooter);

            // Clear existing modals
            modalContainer.innerHTML = '';

            // Add modal to container
            modalContainer.appendChild(modal);

            // Show modal
            setTimeout(function() {
                modalContainer.classList.add('active');
            }, 10);

            // Close modal when clicking outside
            modalContainer.addEventListener('click', function(e) {
                if (e.target === modalContainer) {
                    Modal.hide();
                }
            });

            // Close modal with Escape key
            document.addEventListener('keydown', function(e) {
                if (e.key === 'Escape') {
                    Modal.hide();
                }
            });
        },

        // Hide the modal
        hide: function() {
            modalContainer.classList.remove('active');
        },

        // Show a confirmation modal
        confirm: function(options) {
            const { title, message, onConfirm, onCancel } = options;

            // Create content
            const content = document.createElement('div');
            content.innerHTML = `<p>${message || 'Are you sure?'}</p>`;

            // Create footer
            const footer = document.createElement('div');

            const cancelBtn = document.createElement('button');
            cancelBtn.className = 'btn btn-outline';
            cancelBtn.textContent = 'Cancel';
            cancelBtn.addEventListener('click', function() {
                Modal.hide();
                if (onCancel) onCancel();
            });

            const confirmBtn = document.createElement('button');
            confirmBtn.className = 'btn btn-primary';
            confirmBtn.textContent = 'Confirm';
            confirmBtn.addEventListener('click', function() {
                Modal.hide();
                if (onConfirm) onConfirm();
            });

            footer.appendChild(cancelBtn);
            footer.appendChild(confirmBtn);

            // Show modal
            Modal.show({
                title: title || 'Confirmation',
                content: content,
                footer: footer
            });
        },

        // Show an alert modal
        alert: function(options) {
            const { title, message, onClose } = options;

            // Create content
            const content = document.createElement('div');
            content.innerHTML = `<p>${message || 'Alert message'}</p>`;

            // Create footer
            const footer = document.createElement('div');

            const okBtn = document.createElement('button');
            okBtn.className = 'btn btn-primary';
            okBtn.textContent = 'OK';
            okBtn.addEventListener('click', function() {
                Modal.hide();
                if (onClose) onClose();
            });

            footer.appendChild(okBtn);

            // Show modal
            Modal.show({
                title: title || 'Alert',
                content: content,
                footer: footer
            });
        }
    };

});
