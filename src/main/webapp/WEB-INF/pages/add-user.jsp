<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">

<head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Edit-Property - Ghar Dalali</title>
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
                                    <li><a href="#users" class="active">
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
                                    <li><a href="#properties" >
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
    <section class="dashboard-content">
        <div class="dashboard-header">
            <h2>Add User</h2>
            <a href="${pageContext.request.contextPath}/view?page=admin-dashboard" class="btn btn-secondary">Back to Users</a>
         </div>
         <div class="form-container">
                <c:if test="${not empty errormessage}">
                    <div class="alert alert-error">
                        <p>${errormessage}</p>
                    </div>
                </c:if>
                <c:if test="${not empty successmessage}">
                    <div class="alert alert-success">
                        <p>${successmessage}</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/registeruser" method="post" class="property-form">
			    <div class="form-group">
			        <label for="username">Username*</label>
			        <input type="text" id="username" name="username" required>
			    </div>

			    <div class="form-group">
			        <label for="email">Email*</label>
			        <input type="email" id="email" name="email" required>
			    </div>

			    <div class="form-group">
			        <label for="contactNumber">Contact Number</label>
			        <input type="text" id="contactNumber" name="contactNumber">
			    </div>

			    <div class="form-group">
			        <label for="address">Address</label>
			        <input type="text" id="address" name="address">
			    </div>

			    <div class="form-group">
			        <label for="bio">Bio</label>
			        <textarea id="bio" name="bio" rows="4"></textarea>
			    </div>

			    <div class="form-group">
			        <label for="password">Password*</label>
			        <input type="password" id="password" name="password" required>
			    </div>

			    <div class="form-group">
			        <label for="role">Role</label>
			        <select id="role" name="role">
			            <option value="buyer">Buyer</option>
			            <option value="Admin">Admin</option>
			        </select>
			    </div>

			    <div class="form-group">
			        <label for="status">Status</label>
			        <select id="status" name="status">
			            <option value="Active">Active</option>
			            <option value="Inactive">Inactive</option>
			        </select>
			    </div>

			    <div class="form-actions">
			        <button type="submit" class="btn btn-primary">Add User</button>
			        <a href="${pageContext.request.contextPath}/view?page=admin-dashboard" class="btn btn-secondary">Cancel</a>
			    </div>
			</form>
            </div>
        </div>
    </section>
</body>

</html>