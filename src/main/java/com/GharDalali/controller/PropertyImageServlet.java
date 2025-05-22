package com.GharDalali.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import com.GharDalali.model.UserModel;
import com.GharDalali.service.PropertyImageService;
import com.GharDalali.util.SessionUtil;
import com.GharDalali.util.imageutil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * Servlet for handling property image uploads and management.
 */
@WebServlet("/property-images/*")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class PropertyImageServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyImageService imageService;
    private imageutil imageUtil;
    
    @Override
    public void init() throws ServletException {
        imageService = new PropertyImageService();
        imageUtil = new imageutil();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is admin
        UserModel currentUser = SessionUtil.getLoggedInUser(request);
        if (currentUser == null || !"Admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return;
        }
        
        String pathInfo = request.getPathInfo();
        
        if (pathInfo == null || pathInfo.equals("/")) {
            // List all images for a property
            String propertyIdStr = request.getParameter("propertyId");
            if (propertyIdStr != null) {
                try {
                    int propertyId = Integer.parseInt(propertyIdStr);
                    request.setAttribute("images", imageService.getImagesByPropertyId(propertyId));
                    request.setAttribute("propertyId", propertyId);
                    request.getRequestDispatcher("/WEB-INF/pages/property-images.jsp").forward(request, response);
                } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid property ID");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Property ID is required");
            }
        } else if (pathInfo.startsWith("/delete/")) {
            // Delete an image
            try {
                int imageId = Integer.parseInt(pathInfo.substring(8));
                boolean deleted = imageService.deletePropertyImage(imageId);
                
                String propertyIdStr = request.getParameter("propertyId");
                if (propertyIdStr != null) {
                    int propertyId = Integer.parseInt(propertyIdStr);
                    if (deleted) {
                        request.getSession().setAttribute("successMessage", "Image deleted successfully");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Failed to delete image");
                    }
                    response.sendRedirect(request.getContextPath() + "/property-images?propertyId=" + propertyId);
                } else {
                    response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard");
                }
            } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image ID");
            }
        } else if (pathInfo.startsWith("/primary/")) {
            // Set an image as primary
            try {
                int imageId = Integer.parseInt(pathInfo.substring(9));
                String propertyIdStr = request.getParameter("propertyId");
                
                if (propertyIdStr != null) {
                    int propertyId = Integer.parseInt(propertyIdStr);
                    boolean updated = imageService.setPrimaryImage(imageId, propertyId);
                    
                    if (updated) {
                        request.getSession().setAttribute("successMessage", "Primary image updated successfully");
                    } else {
                        request.getSession().setAttribute("errorMessage", "Failed to update primary image");
                    }
                    response.sendRedirect(request.getContextPath() + "/property-images?propertyId=" + propertyId);
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Property ID is required");
                }
            } catch (NumberFormatException | SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid image ID or property ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Check if user is admin
        UserModel currentUser = SessionUtil.getLoggedInUser(request);
        if (currentUser == null || !"Admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Admin access required");
            return;
        }
        
        String propertyIdStr = request.getParameter("propertyId");
        if (propertyIdStr == null || propertyIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Property ID is required");
            return;
        }
        
        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            boolean isPrimary = "true".equalsIgnoreCase(request.getParameter("isPrimary"));
            
            // Get all parts from the request
            Collection<Part> parts = request.getParts();
            boolean uploadSuccess = false;
            
            for (Part part : parts) {
                if (part.getName().startsWith("propertyImage") && part.getSize() > 0) {
                    // Upload the image to the server
                    String imagePath = imageUtil.uploadImage(part, getServletContext(), "properties");
                    
                    if (imagePath != null) {
                        // Save the image path to the database
                        boolean added = imageService.addPropertyImage(propertyId, imagePath, isPrimary);
                        
                        if (added) {
                            uploadSuccess = true;
                            // Only the first image should be primary if multiple are uploaded
                            isPrimary = false;
                        }
                    }
                }
            }
            
            if (uploadSuccess) {
                request.getSession().setAttribute("successMessage", "Images uploaded successfully");
            } else {
                request.getSession().setAttribute("errorMessage", "No images were uploaded");
            }
            
            // Redirect back to the property edit page
            String referer = request.getHeader("Referer");
            if (referer != null && !referer.isEmpty()) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(request.getContextPath() + "/view?page=edit-property&id=" + propertyId);
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid property ID");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
