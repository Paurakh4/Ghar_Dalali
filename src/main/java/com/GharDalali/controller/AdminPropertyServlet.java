package com.GharDalali.controller;

import com.GharDalali.model.Property;
import com.GharDalali.model.UserModel;
import com.GharDalali.service.PropertyService;
import com.GharDalali.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/property/*")
public class AdminPropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;

    @Override
    public void init() throws ServletException {
        propertyService = new PropertyService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        UserModel currentUser = SessionUtil.getLoggedInUser(request);
        if (currentUser == null || !"Admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/view?page=login");
            return;
        }

        String pathInfo = request.getPathInfo();
        String contextPath = request.getContextPath();
        
        try {
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all properties
                List<Property> properties = propertyService.getAllProperties();
                request.setAttribute("properties", properties);
                request.getRequestDispatcher("/WEB-INF/pages/admin-dashboard.jsp").forward(request, response);
            } else if (pathInfo.equals("/add")) {
                // Show add property form
                request.getRequestDispatcher("/WEB-INF/pages/admin-property-form.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                // Show edit property form
                int propertyId = Integer.parseInt(pathInfo.substring(6));
                Property property = propertyService.getPropertyById(propertyId);
                
                if (property != null) {
                    request.setAttribute("property", property);
                    request.getRequestDispatcher("/WEB-INF/pages/admin-property-form.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Property not found");
                    response.sendRedirect(contextPath + "/admin/property");
                }
            } else if (pathInfo.startsWith("/view/")) {
                // Show property details
                int propertyId = Integer.parseInt(pathInfo.substring(6));
                Property property = propertyService.getPropertyById(propertyId);
                
                if (property != null) {
                    request.setAttribute("property", property);
                    request.getRequestDispatcher("/WEB-INF/pages/admin-property-view.jsp").forward(request, response);
                } else {
                    request.setAttribute("errorMessage", "Property not found");
                    response.sendRedirect(contextPath + "/admin/property");
                }
            } else if (pathInfo.startsWith("/delete/")) {
                // Delete property
                int propertyId = Integer.parseInt(pathInfo.substring(8));
                boolean deleted = propertyService.deleteProperty(propertyId);
                
                if (deleted) {
                    request.getSession().setAttribute("successMessage", "Property deleted successfully");
                } else {
                    request.getSession().setAttribute("errorMessage", "Failed to delete property");
                }
                response.sendRedirect(contextPath + "/admin/property");
            } else {
                // Invalid path
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/404.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid property ID");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in and is an admin
        UserModel currentUser = SessionUtil.getLoggedInUser(request);
        if (currentUser == null || !"Admin".equalsIgnoreCase(currentUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/view?page=login");
            return;
        }

        String pathInfo = request.getPathInfo();
        String contextPath = request.getContextPath();
        
        try {
            if (pathInfo == null || pathInfo.equals("/") || pathInfo.equals("/add")) {
                // Add new property
                Property property = extractPropertyFromRequest(request);
                boolean added = propertyService.addProperty(property);
                
                if (added) {
                    request.getSession().setAttribute("successMessage", "Property added successfully");
                    response.sendRedirect(contextPath + "/admin/property");
                } else {
                    request.setAttribute("errorMessage", "Failed to add property");
                    request.setAttribute("property", property);
                    request.getRequestDispatcher("/WEB-INF/pages/admin-property-form.jsp").forward(request, response);
                }
            } else if (pathInfo.startsWith("/edit/")) {
                // Update existing property
                int propertyId = Integer.parseInt(pathInfo.substring(6));
                Property property = extractPropertyFromRequest(request);
                property.setPropertyId(propertyId);
                
                boolean updated = propertyService.updateProperty(property);
                
                if (updated) {
                    request.getSession().setAttribute("successMessage", "Property updated successfully");
                    response.sendRedirect(contextPath + "/admin/property");
                } else {
                    request.setAttribute("errorMessage", "Failed to update property");
                    request.setAttribute("property", property);
                    request.getRequestDispatcher("/WEB-INF/pages/admin-property-form.jsp").forward(request, response);
                }
            } else {
                // Invalid path
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid property ID");
        }
    }

    /**
     * Helper method to extract property data from request parameters
     */
    private Property extractPropertyFromRequest(HttpServletRequest request) {
        Property property = new Property();
        
        property.setPropertyName(request.getParameter("propertyName"));
        property.setPropertyType(request.getParameter("propertyType"));
        property.setDescription(request.getParameter("description"));
        property.setLocation(request.getParameter("location"));
        
        String priceStr = request.getParameter("price");
        if (priceStr != null && !priceStr.isEmpty()) {
            property.setPrice(new BigDecimal(priceStr));
        }
        
        String bedroomsStr = request.getParameter("bedrooms");
        if (bedroomsStr != null && !bedroomsStr.isEmpty()) {
            property.setBedrooms(Integer.parseInt(bedroomsStr));
        }
        
        String bathroomsStr = request.getParameter("bathrooms");
        if (bathroomsStr != null && !bathroomsStr.isEmpty()) {
            property.setBathrooms(Integer.parseInt(bathroomsStr));
        }
        
        String sizeStr = request.getParameter("size");
        if (sizeStr != null && !sizeStr.isEmpty()) {
            property.setSize(new BigDecimal(sizeStr));
        }
        
        property.setSizeUnit(request.getParameter("sizeUnit"));
        property.setStatus(request.getParameter("status"));
        
        return property;
    }
}