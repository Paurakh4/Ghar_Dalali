<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Luxury Villa - Property Details | Ghar Dalali</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/normalize.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/styles.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/responsive.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/property-detail.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/modern-ui.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/property-forms.css">
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

    <!-- Property Detail Section -->
    <section class="property-detail">
        <div class="container">
            <div class="property-header">
                <div class="property-title-section">
                    <h1>${property.propertyName}</h1>
                    <p class="property-location">${property.location }</p>
                    <div class="property-status-price">
                        <span class="property-status">${property.status == 'FOR_SALE' || property.status == 'FOR_RENT' ? 'approved' : property.status == 'SOLD' || property.status == 'RENTED' ? 'rejected' : 'pending'}</span>
                        <span class="property-price">${property.price}</span>
                    </div>
                </div>
                <div class="property-actions">
                    <button class="btn btn-outline">Save Property</button>
                    <button class="btn btn-primary">Schedule Viewing</button>
                </div>
            </div>
            <!-- Property Gallery -->
			<div class="property-gallery">
			    <div class="main-image">
			        <c:if test="${not empty property.primaryImagePath}">
			            <img src="${pageContext.request.contextPath}${property.primaryImagePath}"
			                 alt="${property.propertyName}" loading="lazy" />
			        </c:if>
			        <c:if test="${empty property.primaryImagePath}">
			            <img src="${pageContext.request.contextPath}/images/property-placeholder.jpg"
			                 alt="No Image Available" loading="lazy" />
			        </c:if>
			    </div>

			    <div class="thumbnail-images">
			        <c:forEach var="img" items="${propertyImages}">
			            <img src="${pageContext.request.contextPath}${img.imagePath}"
			                 alt="Thumbnail" class="thumbnail" loading="lazy" />
			        </c:forEach>
			    </div>
			</div>
            <div class="property-content">
                <div class="property-main-content">
                    <!-- Property Overview -->
                    <section class="property-section">
                        <h2 class="section-title">Overview</h2>
                        <div class="property-overview">
                            <div class="overview-item">
                                <span class="item-label">Property Type</span>
                                <span class="item-value">${property.propertyType}</span>
                            </div>
                            <div class="overview-item">
                                <span class="item-label">Bedrooms</span>
                                <span class="item-value">${property.bedrooms }</span>
                            </div>
                            <div class="overview-item">
                                <span class="item-label">Bathrooms</span>
                                <span class="item-value">${property.bathrooms }</span>
                            </div>
                            <div class="overview-item">
                                <span class="item-label">Size</span>
                                <span class="item-value">${property.size} sq.ft</span>
                            </div>
                            <div class="overview-item">
                                <span class="item-label">Year Built</span>
                                <span class="item-value">2020</span>
                            </div>
                            <div class="overview-item">
                                <span class="item-label">Garage</span>
                                <span class="item-value">1</span>
                            </div>
                        </div>
                    </section>

                    <!-- Property Description -->
                    <section class="property-section">
                        <h2 class="section-title">Description</h2>
                        <div class="property-description">
                            <p>${property.description}</p>
                        </div>
                    </section>

                    <!-- Property Features -->
                    <section class="property-section">
                        <h2 class="section-title">Features & Amenities</h2>
                        <div class="property-features">
                            <ul class="features-list">
                                <li>Air Conditioning</li>
                                <li>Central Heating</li>
                                <li>High-Speed Internet</li>
                                <li>Modern Kitchen</li>
                                <li>Garden</li>
                                <li>Balcony</li>
                                <li>Security System</li>
                                <li>Parking Space</li>
                                <li>Swimming Pool</li>
                                <li>Gym</li>
                                <li>Laundry Room</li>
                                <li>Storage Room</li>
                            </ul>
                        </div>
                    </section>

                    <!-- Property Location -->
                    <section class="property-section">
                        <h2 class="section-title">Location</h2>
                        <div class="property-location-map">
                            <div class="map-placeholder">
                                <p>Map will be displayed here</p>
                            </div>
                            <div class="location-details">
                                <p><strong>Address:</strong> ${property.location}</p>
                                <p><strong>Neighborhood:</strong> Baluwatar</p>
                                <div class="nearby-places">
                                    <h3>Nearby Places</h3>
                                    <ul>
                                        <li>International School (0.5 miles)</li>
                                        <li>Shopping Mall (1 mile)</li>
                                        <li>Hospital (1.2 miles)</li>
                                        <li>Park (0.3 miles)</li>
                                        <li>Bus Station (0.2 miles)</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </section>

                    <!-- Property Reviews -->
                    <section class="property-section">
                        <h2 class="section-title">Reviews</h2>
                        <c:if test="${not empty sessionScope.reviewSuccess}">
					    <div class="alert alert-success">
					        ${sessionScope.reviewSuccess}
					    </div>
					    <c:remove var="reviewSuccess" scope="session" />
					</c:if>
                        <div class="property-reviews">
                            <div class="review-summary">
                                <div class="average-rating">
                                    <span class="rating-value">${averageRating != null ? averageRating : 'N/A'}</span>
                                    <div class="rating-stars">
                                        <span class="star filled">★</span>
                                        <span class="star filled">★</span>
                                        <span class="star filled">★</span>
                                        <span class="star filled">★</span>
                                        <span class="star half-filled">★</span>
                                    </div>
                                    <span class="review-count">Based on ${fn:length(reviews)} review(s)</span>
                                </div>
                            </div>

                            <div class="review-list">
                                <c:forEach var="review" items ="${reviews}">
                                <div class="review-item">
                                    <div class="reviewer-info">
                                        <div class="reviewer-avatar">
                                            <img src="../images/users/user1.jpg" alt="${review.username}">
                                        </div>
                                        <div class="reviewer-details">
                                            <div class="reviewer-name">${review.username}</div>
                                            <div class="review-date"><fmt:formatDate value="${review.reviewedAt}" pattern="MMMM dd, yyyy" /> </div>
                                        </div>
                                    </div>
                                    <div class="review-rating">
                                        <c:forEach begin="1" end="5" var="i">
							                <c:choose>
							                    <c:when test="${i <= review.rating}">
							                        <span class="star filled">★</span>
							                    </c:when>
							                    <c:otherwise>
							                        <span class="star">★</span>
							                    </c:otherwise>
							                </c:choose>
							            </c:forEach>
                                    </div>
                                    <div class="review-content">
                                        <p>${review.reviewText}</p>
                                    </div>
                                </div>
								</c:forEach>
								<form class="review-form" method="post" action="${pageContext.request.contextPath}/submit-review">
							    <input type="hidden" name="propertyId" value="${property.propertyId}" />
							    <div class="form-group">
							        <label for="rating">Rating</label>
							        <select name="rating" required>
							            <option value="5">5 Stars</option>
							            <option value="4">4 Stars</option>
							            <option value="3">3 Stars</option>
							            <option value="2">2 Stars</option>
							            <option value="1">1 Star</option>
							        </select>
							    </div>
							    <div class="form-group">
							        <label for="review-text">Your Review</label>
							        <textarea name="reviewText" id="review-text" rows="5" required></textarea>
							    </div>
							    <button type="submit" class="btn btn-primary">Submit Review</button>
							</form>
                            </div>
                        </div>
                    </section>
                </div>

                <div class="property-sidebar">
                    <!-- Contact Agent Form -->
                    <div class="property-section agent-info">
                                <h2 class="section-title">Listed By</h2>
                                <div class="agent-details">

                                            <div class="agent-image">
                                                        <img src="${pageContext.request.contextPath}/images/team/team4.jpg"
                                                            alt="Ghar Dalali Agent">
   				                            </div>
                                            <h3>Ghar Dalali</h3>
                                            <p class="agent-title">Real Estate Agent</p>
                                            <div class="agent-contact">
                                                <p><strong>Phone:</strong> 9827581286</p>
												<p><strong>Email:</strong> GharDalali@outlook.com</p>
                                            </div>
                                            <button onclick="window.location.href='${pageContext.request.contextPath}/view?page=contact'" class="btn btn-primary btn-block" title="View Property">
                                            	Contact Agent
                                            </button>
                                </div>
                            </div>

                    <!-- Apply for Property -->

						<div id="apply-form" class="property-section apply-property">
                                <h2 class="section-title">Apply for this property</h2>
                                <p>Fill out the form below to submit your application for this property.</p>




                      <form id="propertyApplicationForm" class="apply-form"
                                    action="${pageContext.request.contextPath}/apply-property" method="post">
                                    <input type="hidden" name="propertyId" value="${property.propertyId}">
                                    <div class="form-group">
                                        <label for="fullName">Full Name</label>
                                        <input type="text" id="fullName" name="fullName" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="email">Email</label>
                                        <input type="email" id="email" name="email" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="phone">Phone</label>
                                        <input type="tel" id="phone" name="phone" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="message">Message</label>
                                        <textarea id="message" name="message" rows="4" required
                                            placeholder="Tell us why you're interested in this property and any questions you have."></textarea>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-block">Submit Application</button>
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

    <script src="../js/main.js"></script>
    <script src="../js/property-detail.js"></script>
</body>

</html>