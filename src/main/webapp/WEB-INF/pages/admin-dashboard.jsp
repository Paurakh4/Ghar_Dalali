<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Ghar Dalali</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/normalize.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/variables.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/common.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/styles.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/dashboard.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/admin.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/dashboard-enhanced.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/glassmorphism.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/property-forms.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/responsive.css">
</head>

<body>
    <!-- Navigation Bar -->
    <header class="navbar">
        <div class="container">
            <div class="logo">
                <a href="${pageContext.request.contextPath}/view?page=admin-dashboard">
                    <h1>Ghar Dalali</h1>
                </a>
            </div>

            <div class="auth-buttons">

                <a href="${pageContext.request.contextPath}/logout" class="btn btn-primary">Logout</a>

            </div>
            <div class="mobile-menu-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </header>

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
                            <h3><c:out value="${sessionScope.loggedInUser.username}"/></h3>
                            <p><c:out value="${sessionScope.loggedInUser.email}"/></p>
                        </div>
                    </div>

                    <nav class="dashboard-nav">
                        <ul>
                            <li><a href="#dashboard" class="active">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round">
                                        <rect x="3" y="3" width="7" height="9"></rect>
                                        <rect x="14" y="3" width="7" height="5"></rect>
                                        <rect x="14" y="12" width="7" height="9"></rect>
                                        <rect x="3" y="16" width="7" height="5"></rect>
                                    </svg>
                                    Dashboard Overview
                                </a></li>
                            <li><a href="#users">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round">
                                        <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                        <circle cx="9" cy="7" r="4"></circle>
                                        <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                        <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                    </svg>
                                    User Management
                                </a></li>
                            <li><a href="#properties">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round">
                                        <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                        <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                    </svg>
                                    Property Management
                                </a></li>
                            <li><a href="#reviews">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round">
                                        <polygon
                                            points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                        </polygon>
                                    </svg>
                                    Review Management
                                </a></li>
                            <li><a href="#transactions">
                                    <svg  xmlns="http://www.w3.org/2000/svg" width="24" height="24"
									fill="currentColor" viewBox="0 0 24 24"
									transform="scale(-1,1) ">
									<!--Boxicons v3.0 https://boxicons.com | License  https://docs.boxicons.com/free-->
									<path d="m19,3H5c-1.1,0-2,.9-2,2v14c0,1.1.9,2,2,2h14c1.1,0,2-.9,2-2V5c0-1.1-.9-2-2-2ZM5,19V5h14v14s-14,0-14,0Z"></path><path d="M8.5 10.5A1.5 1.5 0 1 0 8.5 13.5 1.5 1.5 0 1 0 8.5 10.5z"></path><path d="M11 11H17V13H11z"></path><path d="M7 7H17V9H7z"></path><path d="M7 15H17V17H7z"></path>
									</svg>
                                    Applications Management
                                </a></li>
                            <li><a href="#settings">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round">
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

                <!-- Main Content -->
                <div class="dashboard-content">
                    <!-- Dashboard Overview Panel -->
                    <div class="dashboard-panel active" id="dashboard">
                        <div class="panel-header">
                            <h2>Dashboard Overview</h2>
                        </div>

                        <div class="stats-grid">
                            <div class="stat-card">
                                <div class="stat-info">
                                    <h3>Total Users</h3>
                                    <div class="stat-icon">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                            <circle cx="9" cy="7" r="4"></circle>
                                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                        </svg>
                                    </div>
                                    <p class="stat-value">${totalUsers != null ? totalUsers: '0'}</p>
                                    <p class="stat-change positive">${userGrowth != null ? userGrowth : '+0%'} this month</p>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-info">
                                    <h3>Properties Listed</h3>
                                    <div class="stat-icon">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                            <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                        </svg>
                                    </div>
                                    <p class="stat-value">${totalProperties != null ? totalProperties : '0'}</p>
                                    <p class="stat-change positive">${propertyGrowth != null ? propertyGrowth : '+0%'} this month</p>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-info">
                                    <h3>Total Revenue</h3>
                                    <div class="stat-icon">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <line x1="12" y1="1" x2="12" y2="23"></line>
                                            <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                                        </svg>
                                    </div>
                                    <p class="stat-value">$125,450</p>
                                    <p class="stat-change positive">+12% this month</p>
                                </div>
                            </div>

                            <div class="stat-card">
                                <div class="stat-info">
                                    <h3>Applications</h3>
                                    <div class="stat-icon">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path>
                                            <polyline points="14 2 14 8 20 8"></polyline>
                                            <line x1="16" y1="13" x2="8" y2="13"></line>
                                            <line x1="16" y1="17" x2="8" y2="17"></line>
                                            <polyline points="10 9 9 9 8 9"></polyline>
                                        </svg>
                                    </div>
                                    <p class="stat-value">${totalApplications != null ? totalApplications : '0'}</p>
                                    <p class="stat-change ${applicationGrowth != null && applicationGrowth.startsWith('-') ? 'negative' : 'positive'}">
						                ${applicationGrowth != null ? applicationGrowth : '+0%'} this month
						            </p>

                                </div>
                            </div>
                        </div>

                        <div class="recent-activity">
                            <h3>Recent Activity</h3>
                            <ul class="activity-list">
                                <c:choose>
                                    <c:when test="${empty recentActivities}">
                                        <li class="activity-item">
                                            <div class="activity-details">
                                                <p class="activity-text">No recent activities found</p>
                                            </div>
                                        </li>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="activity" items="${recentActivities}">
                                            <li class="activity-item">
                                                <div class="activity-icon">
                                                    <c:choose>
                                                        <c:when test="${activity.activityType == 'LOGIN' || activity.entityType == 'USER'}">
                                                            <!-- User icon -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                                                <circle cx="12" cy="7" r="4"></circle>
                                                            </svg>
                                                        </c:when>
                                                        <c:when test="${activity.activityType == 'PROPERTY_ADD' || activity.activityType == 'PROPERTY_UPDATE' || activity.activityType == 'PROPERTY_VIEW' || activity.entityType == 'PROPERTY'}">
                                                            <!-- Property icon -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
                                                                <polyline points="9 22 9 12 15 12 15 22"></polyline>
                                                            </svg>
                                                        </c:when>
                                                        <c:when test="${activity.activityType == 'PAYMENT' || activity.entityType == 'PAYMENT'}">
                                                            <!-- Payment icon -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <line x1="12" y1="1" x2="12" y2="23"></line>
                                                                <path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"></path>
                                                            </svg>
                                                        </c:when>
                                                        <c:when test="${activity.activityType == 'REVIEW' || activity.entityType == 'REVIEW'}">
                                                            <!-- Review icon -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <polygon
                                                                    points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2">
                                                                </polygon>
                                                            </svg>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <!-- Default icon -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18"
                                                                viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                                                stroke-linecap="round" stroke-linejoin="round">
                                                                <circle cx="12" cy="12" r="10"></circle>
                                                                <line x1="12" y1="8" x2="12" y2="12"></line>
                                                                <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                                            </svg>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="activity-details">
                                                    <p class="activity-text">
                                                        <c:if test="${not empty activity.username}">
                                                            <strong>${activity.username}</strong>:
                                                        </c:if>
                                                        ${activity.description}
                                                    </p>
                                                    <p class="activity-time">${activity.timeAgo}</p>
                                                </div>
                                            </li>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </ul>
                        </div>
                    </div>
                    <!-- User Management Panel -->

                    <div class="dashboard-panel" id="users">
                    <c:if test="${param.delete == 'success'}">
					    <div class="alert alert-success">User deleted successfully.</div>
					</c:if>
                        <div class="panel-header">
                            <h2>User Management</h2>
                           <button onclick="window.location.href='${pageContext.request.contextPath}/view?page=add-user'" class="btn btn-primary btn-sm">
                           		Add New User
                           </button>
                        </div>

                        <div class="admin-table-container">
                            <div class="table-actions">
                                <div class="search-box">
                                    <input type="text" placeholder="Search users...">
                                    <button class="btn btn-outline btn-sm">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                            viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"
                                            stroke-linecap="round" stroke-linejoin="round">
                                            <circle cx="11" cy="11" r="8"></circle>
                                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                        </svg>
                                        Search
                                    </button>
                                </div>
                                <div class="filter-box">
                                    <select>
                                        <option value="">All Users</option>
                                        <option value="active">Active Users</option>
                                        <option value="inactive">Inactive Users</option>
                                        <option value="admin">Admins</option>
                                    </select>
                                </div>
                            </div>

                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td>${user.userid}</td>
                                        <td>${user.username }</td>
                                        <td>${user.email }</td>
                                        <td>${user.role}</td>
	                                        <td><span class="status ${user.status == 'Active' ? 'approved' : 'rejected'}">
											     ${user.status}
											    </span>
											</td>
                                        <td class="actions">
                                             <button onclick="window.location.href='${pageContext.request.contextPath}/edituser?id=${user.userid}'" class="btn-icon edit" title="Edit User">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path
                                                        d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7">
                                                    </path>
                                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z">
                                                    </path>
                                                </svg>
                                            </button>
                                            <button onclick="if(confirm('Delete user?')) window.location.href='${pageContext.request.contextPath}/deleteuser?id=${user.userid}'" class="btn-icon delete" title="Delete User">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <polyline points="3 6 5 6 21 6"></polyline>
                                                    <path
                                                        d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2">
                                                    </path>
                                                </svg>
                                            </button>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                    <c:if test="${empty users}">
									    <tr>
									        <td colspan="6" class="text-center">No users found</td>
										</tr>
									</c:if>
                                </tbody>
                            </table>

                            <div class="pagination">
                                <a href="#" class="page-link" title="Previous Page">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round">
                                        <polyline points="15 18 9 12 15 6"></polyline>
                                    </svg>
                                </a>
                                <a href="#" class="page-link active">1</a>
                                <a href="#" class="page-link">2</a>
                                <a href="#" class="page-link">3</a>
                                <a href="#" class="page-link" title="Next Page">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                        fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                        stroke-linejoin="round">
                                        <polyline points="9 18 15 12 9 6"></polyline>
                                    </svg>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Property Management Panel -->
                    <div class="dashboard-panel" id="properties">
                    <c:if test="${param.deleted == 'true'}">
					    <div class="alert alert-success">Property deleted successfully.</div>
					</c:if>
					<c:if test="${param.error == 'delete_failed'}">
					    <div class="alert alert-error">Failed to delete property.</div>
					</c:if>
                        <div class="panel-header">
                            <h2>Property Management</h2>
                        </div>

                        <div class="admin-table-container">
                            <div class="table-actions">
                                <div class="search-box">
                                    <input type="text" placeholder="Search properties...">
                                    <button class="btn btn-outline btn-sm">Search</button>
                                </div>
                                <div class="filter-box">
                                    <select>
                                        <option value="">All Properties</option>
                                        <option value="for-sale">For Sale</option>
                                        <option value="for-rent">For Rent</option>
                                        <option value="sold">Sold</option>
                                    </select>
                                </div>
                            </div>

                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Property Name</th>
                                        <th>Price</th>
                                        <th>Location</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="property" items="${properties}">
                                    <tr>
                                        <td>${property.propertyId}</td>
                                        <td>${property.propertyName}</td>
                                        <td>${property.price}</td>
                                        <td>${property.location}</td>
                                        <td>
                                        <span class="status ${property.status == 'FOR_SALE' || property.status == 'FOR_RENT' ? 'approved' : property.status == 'SOLD' || property.status == 'RENTED' ? 'rejected' : 'pending'}">
                                        ${property.status.replace('_', ' ')}
	                                    </span>
	                                    </td>
                                        <td class="actions">
                                             <button onclick="window.location.href='${pageContext.request.contextPath}/view?page=property-detail&id=${property.propertyId}'" class="btn-icon view" title="View Property">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                                                    <circle cx="12" cy="12" r="3"></circle>
                                                </svg>
                                            </button>
                                            <button onclick="window.location.href='${pageContext.request.contextPath}/updateproperties?id=${property.propertyId}'" class="btn-icon edit" title="Edit Property">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path
                                                        d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7">
                                                    </path>
                                                    <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z">
                                                    </path>
                                                </svg>
                                            </a>
                                            <button type="button" onclick="if(confirm('Are you sure you want to delete this property?')) { window.location.href='${pageContext.request.contextPath}/deleteproperties?id=${property.propertyId}'; }" class="btn-icon delete" title="Delete Property">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <polyline points="3 6 5 6 21 6"></polyline>
                                                    <path
                                                        d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2">
                                                    </path>
                                                </svg>
                                            </button>
                                        </td>
                                    </tr>
                                    </c:forEach>
			                        <c:if test="${empty properties}">
			                            <tr>
			                                <td colspan="7" class="text-center">No properties found</td>
			                            </tr>
			                        </c:if>
                                </tbody>
                            </table>

                            <div class="pagination">
                                <a href="#" class="page-link">Previous</a>
                                <a href="#" class="page-link active">1</a>
                                <a href="#" class="page-link">2</a>
                                <a href="#" class="page-link">3</a>
                                <a href="#" class="page-link">Next</a>
                            </div>
                        </div>
                        <div class="dashboard-tabs">
                            <button class="tab-link active" onclick="showTab('properties')">Cancel</button>
                            <a href="${pageContext.request.contextPath}/view?page=add-property" class="btn btn-primary">Add Property</a>
                            <!--  <button class="tab-link" onclick="showTab('add-property')">Add Property</button> -->
                        </div>
                    </div>

                    <!-- Review Management Panel -->
                    <div class="dashboard-panel" id="reviews">
                        <div class="panel-header">
                            <h2>Review Management</h2>
                        </div>

                        <div class="admin-table-container">
                            <div class="table-actions">
                                <div class="search-box">
                                    <input type="text" placeholder="Search reviews...">
                                    <button class="btn btn-outline btn-sm">Search</button>
                                </div>
                                <div class="filter-box">
                                    <select>
                                        <option value="">All Reviews</option>
                                        <option value="approved">Approved</option>
                                        <option value="pending">Pending</option>
                                        <option value="rejected">Rejected</option>
                                    </select>
                                </div>
                            </div>
							<c:if test="${param.deleted == 'true'}">
							    <div class="alert alert-success">Review deleted successfully.</div>
							</c:if>
							<c:if test="${param.error == 'delete_failed'}">
							    <div class="alert alert-error">Failed to delete review.</div>
							</c:if>
                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Property</th>
                                        <th>User</th>
                                        <th>Rating</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="review" items="${reviews}">
                                    <tr>
                                        <td>${review.reviewId}</td>
                                        <td>${review.propertyTitle }</td>
                                        <td>${review.username}</td>
                                        <td>${review.rating} ★</td>
                                        <td class="actions">
                                            <button class="btn-icon delete"
											    onclick="if(confirm('Are you sure you want to delete this review?'))
											    window.location.href='${pageContext.request.contextPath}/delete-review?id=${review.reviewId}'">
											    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
											        viewBox="0 0 24 24" fill="none" stroke="currentColor"
											        stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
											        <polyline points="3 6 5 6 21 6"></polyline>
											        <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4
											            a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
											    </svg>
											</button>
                                        </td>
                                    </tr>
                                   </c:forEach>
                                   <c:if test="${empty reviews}">
                                       <tr>
                                           <td colspan="5" class="text-center">No reviews found</td>
                                       </tr>
                                   </c:if>
                                </tbody>
                            </table>

                            <div class="pagination">
                                <a href="#" class="page-link">Previous</a>
                                <a href="#" class="page-link active">1</a>
                                <a href="#" class="page-link">2</a>
                                <a href="#" class="page-link">3</a>
                                <a href="#" class="page-link">Next</a>
                            </div>
                        </div>
                    </div>

                    <!-- Transaction Management Panel -->
                    <div class="dashboard-panel" id="transactions">
                        <div class="panel-header">
                            <h2>Applications Management</h2>
                            <div class="header-actions">
                                <button class="btn btn-outline btn-sm"
                                                    onclick="exportApplicationsToCSV()">Export to CSV</button>
                            </div>
                        </div>

                        <div class="admin-table-container">
                            <c:if test="${param.statusUpdate == 'success'}">
                                <div class="alert alert-success">Application status updated successfully.</div>
                            </c:if>
                            <c:if test="${param.statusUpdate == 'failed'}">
                                <div class="alert alert-error">Failed to update application status.</div>
                            </c:if>
                            <c:if test="${param.delete == 'success'}">
                                <div class="alert alert-success">Application deleted successfully.</div>
                            </c:if>
                            <c:if test="${param.error == 'delete_failed'}">
                                <div class="alert alert-error">Failed to delete application.</div>
                            </c:if>

                            <div class="table-actions">
                                <div class="search-box">
                                    <input type="text" id="applicationSearchInput" placeholder="Search applications...">
                                    <button class="btn btn-outline btn-sm"
                                                        onclick="searchApplications()">
                                                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                            viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                            stroke-width="2" stroke-linecap="round"
                                                            stroke-linejoin="round">
                                                            <circle cx="11" cy="11" r="8"></circle>
                                                            <line x1="21" y1="21" x2="16.65" y2="16.65"></line>
                                                        </svg>
                                                        Search
                                     </button>
                                </div>
                                <div class="filter-box">
                                    <select id="statusFilter"
                                                        onchange="filterApplicationsByStatus(this.value)">
                                                        <option value="all" ${empty selectedStatus || selectedStatus
                                                            eq 'all' ? 'selected' : '' }>All Applications</option>
                                                        <option value="PENDING" ${selectedStatus eq 'PENDING'
                                                            ? 'selected' : '' }>Pending</option>
                                                        <option value="APPROVED" ${selectedStatus eq 'APPROVED'
                                                            ? 'selected' : '' }>Approved</option>
                                                        <option value="REJECTED" ${selectedStatus eq 'REJECTED'
                                                            ? 'selected' : '' }>Rejected</option>
                                    </select>
                                </div>
                            </div>

                            <table class="admin-table">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Property</th>
                                        <th>Applicant</th>
                                        <th>Email</th>
                                        <th>Date</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                	<c:choose>
                                		<c:when test="${empty applications}">
                                		<tr>
                                			<td colspan="7" class="text-center">No applications found</td>
                                         </tr>
                                         </c:when>
                                     <c:otherwise>
                                     	<c:forEach var="application" items="${applications}">
                                    		<tr>
		                                        <td>${application.applicationId}</td>
		                                        <td>${application.propertyTitle}</td>
		                                        <td>${application.fullName}</td>
		                                        <td>${application.email}</td>
		                                        <td>
                                                     <fmt:formatDate value="${application.createdAt}"
                                                                            pattern="MMM dd, yyyy" />
                                                </td>
		                                        <td>
                                                    <span class="status ${application.status eq 'APPROVED' ? 'approved' :
                                                      application.status eq 'REJECTED' ? 'rejected' : 'pending'}">
                                                      ${application.status}
                                                    </span>
                                                </td>
                                                    <td class="actions">
													    <c:if test="${application.status eq 'PENDING'}">
													        <!-- Approve Button -->
													        <form method="post" action="${pageContext.request.contextPath}/update-application-status" style="display:inline;">
													            <input type="hidden" name="id" value="${application.applicationId}" />
													            <input type="hidden" name="status" value="APPROVED" />
													            <button class="btn-icon approve" type="submit" title="Approve Application">
													                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
													                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
													                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
													                    <polyline points="20 6 9 17 4 12"></polyline>
													                </svg>
													            </button>
													        </form>

													        <!-- Reject Button -->
													        <form method="post" action="${pageContext.request.contextPath}/update-application-status" style="display:inline;">
													            <input type="hidden" name="id" value="${application.applicationId}" />
													            <input type="hidden" name="status" value="REJECTED" />
													            <button class="btn-icon reject" type="submit" title="Reject Application" style="background: #FF2A1F">
													                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
													                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
													                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
													                    <line x1="18" y1="6" x2="6" y2="18"></line>
													                    <line x1="6" y1="6" x2="18" y2="18"></line>
													                </svg>
													            </button>
													        </form>

													        <!-- Delete Button -->
													        <form method="post" action="${pageContext.request.contextPath}/delete-application" style="display:inline;"
													            onsubmit="return confirm('Are you sure you want to delete this application?');">
													            <input type="hidden" name="id" value="${application.applicationId}" />
													            <button class="btn-icon delete" type="submit" title="Delete Application">
													                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
													                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
													                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
													                    <polyline points="3 6 5 6 21 6"></polyline>
													                    <path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4
													                        a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path>
													                </svg>
													            </button>
													        </form>
													    </c:if>

													    <c:if test="${application.status eq 'APPROVED' || application.status eq 'REJECTED'}">
													        <!-- Reset to Pending Button -->
													        <form method="post" action="${pageContext.request.contextPath}/update-application-status" style="display:inline;">
													            <input type="hidden" name="id" value="${application.applicationId}" />
													            <input type="hidden" name="status" value="PENDING" />
													            <button class="btn-icon reset" type="submit" title="Reset to Pending" style = "background: #FF2A1F">
													                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
													                    viewBox="0 0 24 24" fill="none" stroke="currentColor"
													                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
													                    <path d="M3 2v6h6"></path>
													                    <path d="M21 12A9 9 0 0 0 6 5.3L3 8"></path>
													                    <path d="M21 22v-6h-6"></path>
													                    <path d="M3 12a9 9 0 0 0 15 6.7l3-2.7"></path>
													                </svg>
													            </button>
													        </form>
													    </c:if>
													</td>
		                                    </tr>
		                                    </c:forEach>
		                                    </c:otherwise>
		                                    </c:choose>


                                </tbody>
                            </table>

                            <div class="pagination">
                                <a href="#" class="page-link">Previous</a>
                                <a href="#" class="page-link active">1</a>
                                <a href="#" class="page-link">2</a>
                                <a href="#" class="page-link">3</a>
                                <a href="#" class="page-link">Next</a>
                            </div>
                        </div>
                    </div>

                    <!-- System Settings Panel -->
                    <div class="dashboard-panel" id="settings">
                        <div class="panel-header">
                            <h2>System Settings</h2>
                        </div>

                        <div class="settings-container">
                            <div class="settings-group">
                                <h3>General Settings</h3>
                                <form class="settings-form">
                                    <div class="form-group">
                                        <label for="site-name">Site Name</label>
                                        <input type="text" id="site-name" value="Ghar Dalali">
                                    </div>

                                    <div class="form-group">
                                        <label for="site-description">Site Description</label>
                                        <textarea id="site-description"
                                            rows="3">Your trusted partner in finding the perfect home.</textarea>
                                    </div>

                                    <div class="form-group">
                                        <label for="contact-email">Contact Email</label>
                                        <input type="email" id="contact-email" value="info@ghardalali.com">
                                    </div>

                                    <div class="form-group">
                                        <label for="contact-phone">Contact Phone</label>
                                        <input type="tel" id="contact-phone" value="+977 1234567890">
                                    </div>

                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>

                            <div class="settings-group">
                                <h3>Email Settings</h3>
                                <form class="settings-form">
                                    <div class="form-group">
                                        <label for="smtp-host">SMTP Host</label>
                                        <input type="text" id="smtp-host" value="smtp.example.com">
                                    </div>

                                    <div class="form-group">
                                        <label for="smtp-port">SMTP Port</label>
                                        <input type="number" id="smtp-port" value="587">
                                    </div>

                                    <div class="form-group">
                                        <label for="smtp-username">SMTP Username</label>
                                        <input type="text" id="smtp-username" value="info@ghardalali.com">
                                    </div>

                                    <div class="form-group">
                                        <label for="smtp-password">SMTP Password</label>
                                        <input type="password" id="smtp-password" value="********">
                                    </div>

                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>

                            <div class="settings-group">
                                <h3>Security Settings</h3>
                                <form class="settings-form">
                                    <div class="form-group checkbox-group">
                                        <input type="checkbox" id="enable-2fa" checked>
                                        <label for="enable-2fa">Enable Two-Factor Authentication for Admins</label>
                                    </div>

                                    <div class="form-group checkbox-group">
                                        <input type="checkbox" id="enable-captcha" checked>
                                        <label for="enable-captcha">Enable CAPTCHA on Forms</label>
                                    </div>

                                    <div class="form-group">
                                        <label for="session-timeout">Session Timeout (minutes)</label>
                                        <input type="number" id="session-timeout" value="30">
                                    </div>

                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>



    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="../js/main.js"></script>
    <script src="<%= request.getContextPath()%>/js/dashboard.js"></script>
    <script src="../js/admin-charts.js"></script>
    <script src="../js/glassmorphism.js"></script>
</body>

</html>