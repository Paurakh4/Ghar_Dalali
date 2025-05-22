<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Property Images - Ghar Dalali</title>
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/admin.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/glassmorphism.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/modern-ui.css">
    <link rel="stylesheet" href="<%= request.getContextPath()%>/css/property-forms.css">
    <style>
        .image-gallery {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        
        .image-card {
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            position: relative;
        }
        
        .image-card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }
        
        .image-info {
            padding: 10px;
        }
        
        .image-actions {
            display: flex;
            justify-content: space-between;
            padding: 10px;
            background-color: #f5f5f5;
        }
        
        .primary-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            border-radius: 4px;
            font-size: 12px;
        }
        
        .upload-form {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
        }
        
        .upload-form h3 {
            margin-top: 0;
        }
        
        .form-row {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <jsp:include page="admin-navbar.jsp" />

    <!-- Dashboard Section -->
    <section class="dashboard-section">
        <div class="container">
            <h1 class="dashboard-title">Manage Property Images</h1>
            
            <div class="dashboard-content">
                <!-- Alerts for success/error messages -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success">
                        ${sessionScope.successMessage}
                        <% session.removeAttribute("successMessage"); %>
                    </div>
                </c:if>
                
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger">
                        ${sessionScope.errorMessage}
                        <% session.removeAttribute("errorMessage"); %>
                    </div>
                </c:if>
                
                <!-- Upload Form -->
                <div class="upload-form">
                    <h3>Upload New Images</h3>
                    <form action="${pageContext.request.contextPath}/property-images" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="propertyId" value="${propertyId}">
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="propertyImage1">Image 1</label>
                                <input type="file" id="propertyImage1" name="propertyImage1" accept="image/*" required>
                                <div class="form-check">
                                    <input type="checkbox" id="isPrimary" name="isPrimary" value="true" checked>
                                    <label for="isPrimary">Set as primary image</label>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="propertyImage2">Image 2 (Optional)</label>
                                <input type="file" id="propertyImage2" name="propertyImage2" accept="image/*">
                            </div>
                            
                            <div class="form-group">
                                <label for="propertyImage3">Image 3 (Optional)</label>
                                <input type="file" id="propertyImage3" name="propertyImage3" accept="image/*">
                            </div>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Upload Images</button>
                    </form>
                </div>
                
                <!-- Image Gallery -->
                <h3>Current Images</h3>
                <div class="image-gallery">
                    <c:forEach var="image" items="${images}">
                        <div class="image-card">
                            <c:if test="${image.isPrimary()}">
                                <div class="primary-badge">Primary</div>
                            </c:if>
                            <img src="${pageContext.request.contextPath}${image.imagePath}" alt="Property Image">
                            <div class="image-info">
                                <p>Uploaded: ${image.createdAt}</p>
                            </div>
                            <div class="image-actions">
                                <c:if test="${!image.isPrimary()}">
                                    <a href="${pageContext.request.contextPath}/property-images/primary/${image.imageId}?propertyId=${propertyId}" class="btn btn-sm btn-outline">Set as Primary</a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/property-images/delete/${image.imageId}?propertyId=${propertyId}" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to delete this image?')">Delete</a>
                            </div>
                        </div>
                    </c:forEach>
                    
                    <c:if test="${empty images}">
                        <p>No images found for this property.</p>
                    </c:if>
                </div>
                
                <div class="mt-4">
                    <a href="${pageContext.request.contextPath}/view?page=edit-property&id=${propertyId}" class="btn btn-outline">Back to Property</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="footer.jsp" />
</body>
</html>
