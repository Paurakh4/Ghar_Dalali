<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<nav class="main-navbar">
    <div class="container">
        <div class="navbar-content">
            <div class="navbar-logo">
                <a href="${pageContext.request.contextPath}/view?page=home">
                    <h1>Ghar Dalali</h1>
                </a>
            </div>

            <div class="navbar-menu">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/view?page=admin-dashboard" class="nav-link">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/view?page=properties" class="nav-link">Properties</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/view?page=add-property" class="nav-link">Add Property</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/view?page=add-user" class="nav-link">Add User</a>
                    </li>
                </ul>
            </div>

            <div class="navbar-actions">
                <div class="dropdown">
                    <button class="dropdown-toggle">
                        <span class="user-avatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.loggedInUser.profilePicture}">
                                    <img src="${pageContext.request.contextPath}${sessionScope.loggedInUser.profilePicture}" alt="Profile">
                                </c:when>
                                <c:otherwise>
                                    <img src="${pageContext.request.contextPath}/images/users/default-avatar.jpg" alt="Default Profile">
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <span class="user-name">${sessionScope.loggedInUser.username}</span>
                    </button>
                    <div class="dropdown-menu">
                        <a href="${pageContext.request.contextPath}/view?page=userprofile" class="dropdown-item">Profile</a>
                        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Logout</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</nav>
