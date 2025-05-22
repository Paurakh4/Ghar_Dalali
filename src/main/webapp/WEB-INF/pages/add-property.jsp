<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard - Ghar Dalali</title>
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet">
            <link rel="stylesheet" href="<%= request.getContextPath()%>/css/normalize.css">
            <link rel="stylesheet" href="<%= request.getContextPath()%>/css/styles.css">
            <link rel="stylesheet" href="<%= request.getContextPath()%>/css/responsive.css">
            <link rel="stylesheet" href="<%= request.getContextPath()%>/css/dashboard.css">
            <link rel="stylesheet" href="<%= request.getContextPath()%>/css/admin.css">
           <%-- <link rel="stylesheet" href="<%= request.getContextPath()%>/css/dashboard-enhanced.css"> --%>
            <link rel="stylesheet" href="<%= request.getContextPath()%>/css/glassmorphism.css">
            <link rel="stylesheet" href="<%= request.getContextPath()%>/css/modern-ui.css">
            <link rel="stylesheet" href="<%= request.getContextPath()%>/css/property-forms.css">
        </head>

        <body>
            <!-- Navigation Bar -->


            <!-- Dashboard Section -->
            <section class="dashboard-section">
                <div class="container">
                    <h1 class="dashboard-title">Admin Dashboard</h1>

                    <div class="dashboard-container">
                        <!-- Sidebar -->
                        <div class="dashboard-sidebar">
                            <div class="user-info">
                                <div class="user-avatar">
                                    <span>A</span>
                                </div>
                                <div class="user-details">
                                    <h3>
                                        <c:out value="${sessionScope.loggedInUser.username}" />
                                    </h3>
                                    <p>
                                        <c:out value="${sessionScope.loggedInUser.email}" />
                                    </p>
                                </div>
                            </div>

                            <nav class="dashboard-nav">
                                <ul>
                                    <li><a href="#dashboard" >
                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <rect x="3" y="3" width="7" height="9"></rect>
                                                <rect x="14" y="3" width="7" height="5"></rect>
                                                <rect x="14" y="12" width="7" height="9"></rect>
                                                <rect x="3" y="16" width="7" height="5"></rect>
                                            </svg>
                                            Dashboard Overview
                                        </a></li>
                                    <li><a href="#users">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                                <circle cx="9" cy="7" r="4"></circle>
                                                <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                                <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                            </svg>
                                            User Management
                                        </a></li>
                                    <li><a href="#properties" class="active">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                                <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                            </svg>
                                            Property Management
                                        </a></li>
                                    <li><a href="#reviews">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <polygon
                                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                                </polygon>
                                            </svg>
                                            Review Management
                                        </a></li>
                                    <li><a href="#transactions">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <line x1="12" y1="1" x2="12" y2="23"></line>
                                                <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                                            </svg>
                                            Application Management
                                        </a></li>
                                    <li><a href="#settings">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                stroke-linecap="round" stroke-linejoin="round">
                                                <circle cx="12" cy="12" r="3"></circle>
                                                <path
                                                    d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z">
                                                </path>
                                            </svg>
                                            System Settings
                                        </a></li>
                                </ul>
                            </nav>
                       </div>
                       <div class="dashboard-content">
                                <div class="dashboard-header">
                                    <h2>Add New Property</h2>
                                    <a href="${pageContext.request.contextPath}/view?page=admin-dashboard" class="btn btn-secondary">Back to Properties</a>
                                </div>

                                <div class="form-container">
                                    <c:if test="${not empty errorMessage}">
                                        <div class="alert alert-error">
                                            <p>${errorMessage}</p>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty successMessage}">
                                        <div class="alert alert-success">
                                            <p>${successMessage}</p>
                                        </div>
                                    </c:if>

                                    <form action="${pageContext.request.contextPath}/addproperties" method="post"
                                        class="property-form" enctype="multipart/form-data">

									<input type="hidden" name="action" value="add">
                                        <div class="form-group">
                                            <label for="propertyName">Property Title*</label>
                                            <input type="text" id="propertyName" name="propertyName" required>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="propertyType">Property Type*</label>
                                                <select id="propertyType" name="propertyType" required>
                                                    <option value="">Select Type</option>
                                                    <option value="APARTMENT">Apartment</option>
                                                    <option value="HOUSE">House</option>
                                                    <option value="VILLA">Villa</option>
                                                    <option value="COMMERCIAL">Commercial</option>
                                                    <option value="LAND">Land</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label for="status">Status*</label>
                                                <select id="status" name="status" required>
                                                    <option value="">Select Status</option>
                                                    <option value="FOR_SALE">For Sale</option>
                                                    <option value="FOR_RENT">For Rent</option>
                                                    <option value="SOLD">Sold</option>
                                                    <option value="RENTED">Rented</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="location">Location*</label>
                                            <input type="text" id="location" name="location" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="description">Description*</label>
                                            <textarea id="description" name="description" rows="5" required></textarea>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="price">Price (NPR)*</label>
                                                <input type="number" id="price" name="price" min="0" step="0.01"
                                                    required>
                                            </div>

                                            <div class="form-group">
                                                <label for="size">Size</label>
                                                <input type="number" id="size" name="size" min="0" step="0.01">
                                            </div>

                                            <div class="form-group">
                                                <label for="sizeUnit">Unit</label>
                                                <select id="sizeUnit" name="sizeUnit">
                                                    <option value="sq.ft">sq.ft</option>
                                                    <option value="sq.m">sq.m</option>
                                                    <option value="acres">acres</option>
                                                    <option value="hectares">hectares</option>
                                                </select>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="bedrooms">Bedrooms</label>
                                                <input type="number" id="bedrooms" name="bedrooms" min="0">
                                            </div>

                                            <div class="form-group">
                                                <label for="bathrooms">Bathrooms</label>
                                                <input type="number" id="bathrooms" name="bathrooms" min="0">
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="propertyImage1">Primary Property Image</label>
                                            <input type="file" id="propertyImage1" name="propertyImage1"
                                                accept="image/*">
                                            <small>Upload the main image for this property (max 5MB)</small>
                                        </div>

                                        <div class="form-group">
                                            <label for="propertyImage2">Additional Image 1</label>
                                            <input type="file" id="propertyImage2" name="propertyImage2"
                                                accept="image/*">
                                            <small>Upload an additional image (max 5MB)</small>
                                        </div>

                                        <div class="form-group">
                                            <label for="propertyImage3">Additional Image 2</label>
                                            <input type="file" id="propertyImage3" name="propertyImage3"
                                                accept="image/*">
                                            <small>Upload an additional image (max 5MB)</small>
                                        </div>

                                        <div class="form-group">
                                            <label for="propertyImage4">Additional Image 3</label>
                                            <input type="file" id="propertyImage4" name="propertyImage4"
                                                accept="image/*">
                                            <small>Upload an additional image (max 5MB)</small>
                                        </div>

                                        <div class="form-group">
                                            <label for="imagePath">Alternative Image URL (Optional)</label>
                                            <input type="text" id="imagePath" name="imagePath"
                                                placeholder="https://example.com/image.jpg">
                                            <small>If you prefer to use an external image URL instead of
                                                uploading</small>
                                        </div>

                                        <div class="form-actions">
                                            <button type="submit" class="btn btn-primary">Add Property</button>
                                            <a href="${pageContext.request.contextPath}/view?page=admin-dashboard"
                                                class="btn btn-secondary">Cancel</a>
                                        </div>
                                    </form>
                                </div>
                            </div>
                     </div>
                  </div>

            </section>

            <!-- Footer -->
            <footer class="footer">
                <div class="container">
                    <div class="footer-content">
                        <div class="footer-logo">
                            <h2>Ghar Dalali</h2>
                            <p>Your trusted partner in finding the perfect home.</p>
                        </div>
                        <div class="footer-links">
                            <h3>Quick Links</h3>
                            <ul>
                                <li><a href="../index.html">Home</a></li>
                                <li><a href="properties.html">Properties</a></li>
                                <li><a href="about.html">About</a></li>
                                <li><a href="contact.html">Contact</a></li>
                                <li><a href="terms.html">Terms of Service</a></li>
                                <li><a href="privacy.html">Privacy Policy</a></li>
                            </ul>
                        </div>
                        <div class="footer-contact">
                            <h3>Contact Us</h3>
                            <p>Email: info@ghardalali.com</p>
                            <p>Phone: +977 1234567890</p>
                            <div class="social-links">
                                <a href="#" class="social-icon">Facebook</a>
                                <a href="#" class="social-icon">Twitter</a>
                                <a href="#" class="social-icon">Instagram</a>
                            </div>
                        </div>
                    </div>
                    <div class="footer-bottom">
                        <p>&copy; 2025 Ghar Dalali. All rights reserved.</p>
                    </div>
                </div>

            </footer>

            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script src="<%= request.getContextPath()%>/js/main.js"></script>
            <script src="<%= request.getContextPath()%>/js/dashboard.js"></script>
            <script src="<%= request.getContextPath()%>/js/admin-charts.js"></script>
            <script src="<%= request.getContextPath()%>/js/glassmorphism.js"></script>
        </body>

        </html>