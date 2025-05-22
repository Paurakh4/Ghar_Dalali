<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - Ghar Dalali</title>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/normalize.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/variables.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/common.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/styles.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/glassmorphism.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/home-enhanced.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/error.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/responsive.css">
</head>

<body>
    <!-- Header Component Placeholder -->
    <div id="header-placeholder"></div>
    <!-- Navigation Bar -->

    <!-- Error Section -->
    <section class="error-section">
        <div class="container">
            <div class="error-content">
                <div class="error-code">404</div>
                <h1>Page Not Found</h1>
                <p>The page you are looking for might have been removed, had its name changed, or is temporarily
                    unavailable.</p>
                <div class="error-actions">
                    <a href="${pageContext.request.contextPath}/view?page=home" class="btn btn-primary">Go to Homepage</a>
                    <a href="${pageContext.request.contextPath}/view?page=properties" class="btn btn-outline">Browse Properties</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <!-- Footer Component Placeholder -->
    <div id="footer-placeholder"></div>

    <script src="<%= request.getContextPath()%>/js/main.js"></script>
    <script src="<%= request.getContextPath()%>/js/glassmorphism.js"></script>
</body>

</html>