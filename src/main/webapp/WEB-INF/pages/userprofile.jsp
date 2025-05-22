<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Ghar Dalali</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/normalize.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/styles.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/responsive.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/dashboard.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/dashboard-enhanced.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/glassmorphism.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/profile.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/navbar-fix.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body>
<%-- Check if user is logged in --%>

        <%
    if (session.getAttribute("loggedInUser") == null) {
        response.sendRedirect(request.getContextPath() + "/view?page=login&error=session_required");
        return;
    }
%>

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
                    <li><a href="${pageContext.request.contextPath}/view?page=properties">Properties</a></li>
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

    <!-- Profile Section -->
    <section class="profile-section">
        <div class="container">
            <div class="profile-container">
                <!-- Profile Header -->
                <div class="profile-header">
                    <div class="profile-cover">
                        <img src="../images/property-placeholder.jpg" alt="Cover Photo">
                        <div class="cover-overlay"></div>
                    </div>
                    <div class="profile-header-content">
                        <div class="profile-avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInUser.profilePicture}">
                                    <img src="${pageContext.request.contextPath}${sessionScope.loggedInUser.profilePicture}" alt="User Avatar">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/users/default-avatar.jpg" alt="Default User Avatar">
                                </c:otherwise>
                            </c:choose>
                            <button class="change-avatar-btn">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <path
                                        d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z">
                                    </path>
                                    <circle cx="12" cy="13" r="4"></circle>
                                </svg>
                            </button>
                        </div>
                        <div class="profile-info">
                            <h1><c:out value="${sessionScope.loggedInUser.username}"/></h1>
                            <p>Member since January 15, 2025</p>
                        </div>
                        <div class="profile-actions">
                            <button id="edit-profile-btn" class="btn btn-primary">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path>
                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path>
                                </svg>
                                Edit Profile
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Profile Content -->
                <div class="profile-content">
                    <!-- View Profile Section -->
                    <div id="view-profile" class="profile-section-content active">
                        <div class="profile-card">
                            <div class="card-header">
                                <h2>Personal Information</h2>
                            </div>
                            <div class="card-body">
                                <div class="info-grid">
                                    <div class="info-item">
                                        <label>Username</label>
                                        <p><c:out value="${sessionScope.loggedInUser.username}"/></p>
                                    </div>

                                    <div class="info-item">
                                        <label>Email Address</label>
                                        <p><c:out value="${sessionScope.loggedInUser.email}"/></p>
                                    </div>
                                    <div class="info-item">
                                        <label>Phone Number</label>
                                        <p><c:out value="${sessionScope.loggedInUser.contactNumber}"/></p>
                                    </div>
                                    <div class="info-item">
                                        <label>Address</label>
                                        <p><c:out value="${sessionScope.loggedInUser.address}" /></p>
                                    </div>
                                    <div class="info-item">
                                        <label>Bio</label>
                                        <p><c:out value="${sessionScope.loggedInUser.bio}" /></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="profile-card">
                            <div class="card-header">
                                <h2>Account Security</h2>
                            </div>
                            <div class="card-body">
                                <div class="security-options">
                                    <div class="security-item">
                                        <div class="security-info">
                                            <h3>Password</h3>
                                            <p>Last changed 3 months ago</p>
                                        </div>
                                        <button id="change-password-btn" class="btn btn-outline btn-sm">Change
                                            Password</button>
                                    </div>
                                    <div class="security-item">
                                        <div class="security-info">
                                            <h3>Two-Factor Authentication</h3>
                                            <p>Not enabled</p>
                                        </div>
                                        <button class="btn btn-outline btn-sm">Enable</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="profile-card">
                            <div class="card-header">
                                <h2>Preferences</h2>
                            </div>
                            <div class="card-body">
                                <div class="preferences-options">
                                    <div class="preference-item">
                                        <div class="preference-info">
                                            <h3>Email Notifications</h3>
                                            <p>Receive emails about new properties, updates, and promotions</p>
                                        </div>
                                        <label class="toggle-switch">
                                            <input type="checkbox" checked>
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </div>
                                    <div class="preference-item">
                                        <div class="preference-info">
                                            <h3>SMS Notifications</h3>
                                            <p>Receive text messages about property updates and appointments</p>
                                        </div>
                                        <label class="toggle-switch">
                                            <input type="checkbox">
                                            <span class="toggle-slider"></span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Edit Profile Section -->
                    <div id="edit-profile" class="profile-section-content">
                            <div class="profile-card">
                                <div class="card-header">
                                    <h2>Edit Personal Information</h2>
                                </div>
                          <form id="profile-form" class="profile-form" method = "post" action = "${pageContext.request.contextPath}/updateProfile">
                                <div class="card-body">
                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label for="email">Email Address</label>
                                            <input type="email" name = "email" id="email"value="<c:out value="${sessionScope.loggedInUser.email}"/>" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="phone">Phone Number</label>
                                            <input type="tel" name= "contactNumber" id="phone" value="<c:out value="${sessionScope.loggedInUser.contactNumber}"/>" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="address">Address</label>
                                            <input type="text" name = "address" id="address" value="<c:out value="${sessionScope.loggedInUser.address}"/>"
                                                required>
                                        </div>
                                        <div class="form-group">
                                            <label for="city">Bio</label>
                                            <input type="text" name = "bio" id="city" value="<c:out value="${sessionScope.loggedInUser.bio}"/>"required>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="profile-card">
                                <div class="card-header">
                                    <h2>Edit Preferences</h2>
                                </div>
                                <div class="card-body">
                                    <div class="preferences-options">
                                        <div class="preference-item">
                                            <div class="preference-info">
                                                <h3>Email Notifications</h3>
                                                <p>Receive emails about new properties, updates, and promotions</p>
                                            </div>
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="email_notifications" checked>
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                        <div class="preference-item">
                                            <div class="preference-info">
                                                <h3>SMS Notifications</h3>
                                                <p>Receive text messages about property updates and appointments</p>
                                            </div>
                                            <label class="toggle-switch">
                                                <input type="checkbox" name="sms_notifications">
                                                <span class="toggle-slider"></span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="button" id="cancel-edit-btn" class="btn btn-outline">Cancel</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>

                    <!-- Change Password Section -->
                    <div id="change-password" class="profile-section-content">
                        <form id="password-form" class="password-form">
                            <div class="profile-card">
                                <div class="card-header">
                                    <h2>Change Password</h2>
                                </div>
                                <div class="card-body">
                                    <div class="form-group">
                                        <label for="current-password">Current Password</label>
                                        <input type="password" id="current-password" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="new-password">New Password</label>
                                        <input type="password" id="new-password" required>
                                        <div class="password-strength">
                                            <div class="strength-meter">
                                                <div class="strength-segment"></div>
                                                <div class="strength-segment"></div>
                                                <div class="strength-segment"></div>
                                                <div class="strength-segment"></div>
                                            </div>
                                            <p class="strength-text">Password strength: <span>Weak</span></p>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label for="confirm-password">Confirm New Password</label>
                                        <input type="password" id="confirm-password" required>
                                    </div>
                                    <div class="password-requirements">
                                        <p>Password must:</p>
                                        <ul>
                                            <li>Be at least 8 characters long</li>
                                            <li>Include at least one uppercase letter</li>
                                            <li>Include at least one number</li>
                                            <li>Include at least one special character</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>

                            <div class="form-actions">
                                <button type="button" id="cancel-password-btn" class="btn btn-outline">Cancel</button>
                                <button type="submit" class="btn btn-primary">Update Password</button>
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
                        <li><a href="${pageContext.request.contextPath}/view?page=home">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=properties">Properties</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=aboutus">About</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=contact">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=terms">Terms of Service</a></li>
                        <li><a href="${pageContext.request.contextPath}/view?page=policy">Privacy Policy</a></li>
                    </ul>
                </div>
                <div class="footer-contact">
                    <h3>Contact Us</h3>
                    <p><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z">
                            </path>
                            <polyline points="22,6 12,13 2,6"></polyline>
                        </svg>info@ghardalali.com </p>
                    <p><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path
                                d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z">
                            </path>
                        </svg>+977 1234567890 </p>
                    <div class="social-links"><a href="#" class="social-icon"><svg xmlns="http://www.w3.org/2000/svg"
                                width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M18 2h-3a5 5 0 0 0-5 5v3H7v4h3v8h4v-8h3l1-4h-4V7a1 1 0 0 1 1-1h3z">
                                </path>
                            </svg></a><a href="#" class="social-icon"><svg xmlns="http://www.w3.org/2000/svg" width="18"
                                height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round">
                                <path
                                    d="M22 4s-.7 2.1-2 3.4c1.6 10-9.4 17.3-18 11.6 2.2.1 4.4-.6 6-2C3 15.5.5 9.6 3 5c2.2 2.6 5.6 4.1 9 4-.9-4.2 4-6.6 7-3.8 1.1 0 3-1.2 3-1.2z">
                                </path>
                            </svg></a><a href="#" class="social-icon"><svg xmlns="http://www.w3.org/2000/svg" width="18"
                                height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                stroke-linecap="round" stroke-linejoin="round">
                                <rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect>
                                <path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z">
                                </path>
                                <line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line>
                            </svg></a></div>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy;
                    2025 Ghar Dalali. All rights reserved.</p>
            </div>
        </div>
    </footer>
	<script>
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');

    if (status === 'updated') {
        Swal.fire({
            icon: 'success',
            title: 'Profile Updated',
            text: 'Your profile has been successfully updated!',
            confirmButtonColor: '#3085d6',
            confirmButtonText: 'OK'
        }).then(() => {
            // Clean the URL after the alert is dismissed
            window.history.replaceState({}, document.title, window.location.pathname + '?page=userprofile');
        });
    }
</script>
    <script src="<%= request.getContextPath()%>/js/main.js"></script>
    <script src="<%= request.getContextPath()%>/js/glassmorphism.js"></script>
    <script src="<%= request.getContextPath()%>/js/profile.js"></script>
</body>

</html>