package com.GharDalali.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.Collection;

import com.GharDalali.model.Property;
import com.GharDalali.model.UserModel;
import com.GharDalali.service.PropertyImageService;
import com.GharDalali.service.PropertyService;
import com.GharDalali.util.SessionUtil;
import com.GharDalali.util.imageutil;

@WebServlet("/addproperties")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,   // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class AddPropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;
    private PropertyImageService imageService;
    private imageutil imageUtil;

    @Override
    public void init() {
        propertyService = new PropertyService();
        imageService = new PropertyImageService();
        imageUtil = new imageutil();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Check admin session
        UserModel currentUser = SessionUtil.getLoggedInUser(req);
        if (currentUser == null || !"Admin".equalsIgnoreCase(currentUser.getRole())) {
            resp.sendRedirect(req.getContextPath() + "/view?page=login");
            return;
        }

        String action = req.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            try {
                Property property = new Property();
                property.setPropertyName(req.getParameter("propertyName"));
                property.setPropertyType(req.getParameter("propertyType"));
                property.setStatus(req.getParameter("status"));
                property.setLocation(req.getParameter("location"));
                property.setDescription(req.getParameter("description"));
                property.setPrice(new BigDecimal(req.getParameter("price")));

                // Optional values
                String sizeStr = req.getParameter("size");
                if (sizeStr != null && !sizeStr.isBlank()) {
                    property.setSize(new BigDecimal(sizeStr));
                }

                property.setSizeUnit(req.getParameter("sizeUnit"));
                property.setBedrooms(parseIntOrNull(req.getParameter("bedrooms")));
                property.setBathrooms(parseIntOrNull(req.getParameter("bathrooms")));
                property.setPrimaryImagePath(req.getParameter("imagePath"));

                boolean success = propertyService.addProperty(property);

                if (success) {
                    // Handle image uploads
                    int propertyId = property.getPropertyId();
                    boolean isPrimary = true; // First image is primary
                    boolean imageUploaded = false;

                    // Process file uploads
                    Collection<Part> parts = req.getParts();
                    for (Part part : parts) {
                        if (part.getName().startsWith("propertyImage") && part.getSize() > 0) {
                            // Upload the image to the server
                            String imagePath = imageUtil.uploadImage(part, getServletContext(), "properties");

                            if (imagePath != null) {
                                // Save the image path to the database
                                boolean added = imageService.addPropertyImage(propertyId, imagePath, isPrimary);

                                if (added) {
                                    imageUploaded = true;
                                    // Only the first image should be primary
                                    isPrimary = false;
                                }
                            }
                        }
                    }

                    // If no images were uploaded but an image URL was provided
                    String imageUrl = req.getParameter("imagePath");
                    if (!imageUploaded && imageUrl != null && !imageUrl.trim().isEmpty()) {
                        imageService.addPropertyImage(propertyId, imageUrl, true);
                    }

                    req.getSession().setAttribute("successMessage", "Property added successfully.");
                    resp.sendRedirect(req.getContextPath() + "/view?page=add-property&success=true");
                } else {
                    req.setAttribute("errorMessage", "Failed to add property.");
                    req.getRequestDispatcher("/WEB-INF/pages/add-property.jsp").forward(req, resp);
                }

            } catch (Exception e) {
                e.printStackTrace();
                req.setAttribute("errorMessage", "Error: " + e.getMessage());
                req.getRequestDispatcher("/WEB-INF/pages/add-property.jsp").forward(req, resp);
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/view?page=add-property&success=False");
        }
    }

    private Integer parseIntOrNull(String val) {
        try {
            return (val == null || val.isBlank()) ? null : Integer.parseInt(val);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
