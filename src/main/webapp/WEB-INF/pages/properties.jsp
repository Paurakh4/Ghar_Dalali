<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Properties - Ghar Dalali</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/normalize.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/styles.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/responsive.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/properties.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/modern-ui.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/navbar-fix.css">

</head>

<body>
    <!-- Navigation Bar -->
    <header class="navbar">
        <div class="container gd-navbar-container">
            <div class="logo gd-logo">
                <a href="${pageContext.request.contextPath}/view?page=home">
                    <h1>Ghar Dalali</h1>
                </a>
            </div>
            <nav class="nav-menu gd-nav-menu">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/view?page=home">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/view?page=properties" class="active">Properties</a></li>
                    <li><a href="${pageContext.request.contextPath}/view?page=aboutus">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/view?page=blog">Blog</a></li>
                    <li><a href="${pageContext.request.contextPath}/view?page=contact">Contact</a></li>
                </ul>
            </nav>
            <div class="auth-buttons gd-auth-buttons">
                <div class="app-tracking-container gd-app-tracking-container">
                    <div class="app-tracking-icon">
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                            <polyline points="14 2 14 8 20 8"></polyline>
                            <line x1="16" y1="13" x2="8" y2="13"></line>
                            <line x1="16" y1="17" x2="8" y2="17"></line>
                            <polyline points="10 9 9 9 8 9"></polyline>
                        </svg>
                        <span class="notification-badge empty">0</span>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Logout</a>
                <a href="${pageContext.request.contextPath}/view?page=userprofile" class="profile-btn"><svg xmlns="http://www.w3.org/2000/svg" width="24"
                        height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                        stroke-linecap="round" stroke-linejoin="round" class="profile-icon">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg></a>
            </div>
            <div class="mobile-menu-toggle gd-mobile-menu-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </header>

    <!-- Page Header -->
    <section class="page-header">
        <div class="container">
            <h1>Browse <span class="highlight">Properties</span></h1>
            <p>Find your dream home from our extensive collection of premium properties across Nepal</p>
            <div class="search-container">
                <form class="search-form" action = "${pageContext.request.contextPath}/view" method = "get">
               		<input type = "hidden" name="page" value="properties">
                    <input type="text" name = "keyword" placeholder="Search by location, property type, or keyword...">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>
        </div>
    </section>

    <!-- Properties Section -->
    <section class="properties-section">
        <div class="container">
            <div class="properties-container">
                <!-- Filter_Sidebar -->
                <div class="filter-sidebar">
                    <h3>Filter Properties</h3>
                    <form class="filter-form">
                        <div class="filter-group search-filter">
                            <label for="search-keyword">Search</label>
                            <input type="text" id="search-keyword" name="search-keyword"
                                placeholder="Enter keywords...">
                        </div>
                        <div class="filter-group">
                            <label for="property-type">Property Type</label>
                            <select id="property-type" name="property-type">
                                <option value="">All Types</option>
                                <option value="house">House</option>
                                <option value="apartment">Apartment</option>
                                <option value="villa">Villa</option>
                                <option value="land">Land</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="price-range">Price Range</label>
                            <div class="price-inputs">
                                <input type="number" id="min-price" name="min-price" placeholder="Min">
                                <span>to</span>
                                <input type="number" id="max-price" name="max-price" placeholder="Max">
                            </div>
                        </div>

                        <div class="filter-group">
                            <label for="bedrooms">Bedrooms</label>
                            <select id="bedrooms" name="bedrooms">
                                <option value="">Any</option>
                                <option value="1">1+</option>
                                <option value="2">2+</option>
                                <option value="3">3+</option>
                                <option value="4">4+</option>
                                <option value="5">5+</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="bathrooms">Bathrooms</label>
                            <select id="bathrooms" name="bathrooms">
                                <option value="">Any</option>
                                <option value="1">1+</option>
                                <option value="2">2+</option>
                                <option value="3">3+</option>
                                <option value="4">4+</option>
                            </select>
                        </div>

                        <div class="filter-group">
                            <label for="property-status">Status</label>
                            <select id="property-status" name="property-status">
                                <option value="">All</option>
                                <option value="for-sale">For Sale</option>
                                <option value="for-rent">For Rent</option>
                            </select>
                        </div>

                        <div class="filter-buttons">
                            <button type="submit" class="btn btn-primary">Apply Filters</button>
                            <button type="reset" class="btn btn-outline">Reset</button>
                        </div>
                    </form>
                </div>

                <!-- Properties List -->
                <div class="properties-list">
                    <div class="properties-header">
                        <div class="properties-count">
                            <p>Showing <span>12</span> properties</p>
                        </div>
                        <div class="properties-sort">
                            <label for="sort-by">Sort by:</label>
                            <select id="sort-by" name="sort-by">
                                <option value="newest">Newest</option>
                                <option value="price-asc">Price (Low to High)</option>
                                <option value="price-desc">Price (High to Low)</option>
                                <option value="rating">Rating</option>
                            </select>
                        </div>
                        <div class="view-toggle">
                            <button class="grid-view active">Grid</button>
                            <button class="list-view">List</button>
                        </div>
                    </div>

                    <div class="properties-grid">
                    <c:forEach var="property" items="${properties}">
                        <!-- Property Card 1 -->
                        <div class="property-card">
                            <div class="property-image">
                                <a href="${pageContext.request.contextPath}/view?page=property-detail&id=${property.propertyId}">
                                   <img src="${pageContext.request.contextPath}${property.primaryImagePath}"  alt="${property.propertyName}" class="property-image" loading = "lazy">

                                    <span class="property-status">For Sale</span>
                                </a>
                            </div>
                            <div class="property-details">
                                <h3 class="property-title">${property.propertyName}</h3>
                                <p class="property-location">${property.location }</p>
                                <p class="property-price">Rs. ${property.price }</p>
                                <div class="property-specs">
                                    <span>${property.bedrooms} Beds</span>
                                    <span>${property.bathrooms} Baths</span>
                                    <span>${property.size} sq.ft</span>
                                </div>
                                <a href="${pageContext.request.contextPath}/view?page=property-detail&id=${property.propertyId}" class="btn btn-outline">View Details</a>
                            </div>
                        </div>
                        </c:forEach>
                    </div>

                    <!-- Pagination -->
                    <div class="pagination">
                        <a href="#" class="page-link active">1</a>
                        <a href="#" class="page-link">2</a>
                        <a href="#" class="page-link">3</a>
                        <a href="#" class="page-link next">Next &raquo;</a>
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
                       <li><a href="${pageContext.request.contextPath}/view?page=home">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=properties">Properties</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=aboutus">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=blog">Blog</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=contact">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=terms">Terms of Service</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=policy">Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="footer-contact">
                    <h3>Contact Us</h3>
                    <p>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z">
                            </path>
                            <polyline points="22,6 12,13 2,6"></polyline>
                        </svg>
                        info@ghardalali.com
                    </p>
                    <p>
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path
                                d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z">
                            </path>
                        </svg>
                        +977 1234567890
                    </p>
                    <div class="social-links">
                        <a href="#" class="social-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round">
                                <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z"></path>
                            </svg>
                        </a>
                        <a href="#" class="social-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round">
                                <path
                                    d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z">
                                </path>
                            </svg>
                        </a>
                        <a href="#" class="social-icon">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round">
                                <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                                <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path>
                                <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                            </svg>
                        </a>
                    </div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2025 Ghar Dalali. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script src="<%= request.getContextPath()%>/js/main.js"></script>
</body>

</html>