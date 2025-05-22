package com.GharDalali.view;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Set;
import java.util.HashSet;
import java.util.List;


import com.GharDalali.model.Property;
import com.GharDalali.model.PropertyImageModel;
import com.GharDalali.model.UserModel;
import com.GharDalali.model.UserActivityModel;
import com.GharDalali.model.propertyapplicationmodel;
import com.GharDalali.model.reviewmodel;
import com.GharDalali.service.PropertyService;
import com.GharDalali.service.PropertyImageService;
import com.GharDalali.service.UserService;
import com.GharDalali.service.UserActivityService;
import com.GharDalali.service.applicationservice;
import com.GharDalali.service.dashboardstatsservice;
import com.GharDalali.service.reviewservice;

/**
 * Handles requests for displaying various JSP views based on the 'page' parameter.*/
@WebServlet("/view") // Mapped to /view
public class ViewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final Set<String> VALID_PAGES = new HashSet<>();
    static {
        VALID_PAGES.add("login");
        VALID_PAGES.add("register");
        VALID_PAGES.add("home");
        VALID_PAGES.add("admin-dashboard");
        VALID_PAGES.add("forgotpassword");
        VALID_PAGES.add("resetpassword");
        VALID_PAGES.add("userprofile");
        VALID_PAGES.add("properties");
        VALID_PAGES.add("aboutus");
        VALID_PAGES.add("terms");
        VALID_PAGES.add("policy");
        VALID_PAGES.add("contact");
        VALID_PAGES.add("add-property");
        VALID_PAGES.add("404");
        VALID_PAGES.add("edit-property");
        VALID_PAGES.add("property-detail");
        VALID_PAGES.add("edit-user");
        VALID_PAGES.add("add-user");
        VALID_PAGES.add("blog");
        // Other valid pages can be added later
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String page = request.getParameter("page");

        // Basic validation: check if page parameter exists and is in our allowed list
        if (page != null && VALID_PAGES.contains(page.toLowerCase())) {
            String jspPath = "/WEB-INF/pages/" + page.toLowerCase() + ".jsp";
            try {
            	if ("admin-dashboard".equals(page)) {
            	    List<Property> properties = new PropertyService().getAllProperties();
            	    List<UserModel> users = new UserService().getAllUsers();
            	    List<propertyapplicationmodel> applications = new applicationservice().getAllApplications();
            	    List<reviewmodel> reviews = new reviewservice().getAllReviews();

            	    // Fetch recent activities
            	    List<UserActivityModel> recentActivities = new UserActivityService().getRecentActivities(10);

            	    dashboardstatsservice statsService = new dashboardstatsservice();

            	    int totalUsers = statsService.calculateTotalUsers(users);
            	    String userGrowth = statsService.calculateUserGrowth(users);

            	    int totalProperties = statsService.calculateTotalProperties(properties);
            	    String propertyGrowth = statsService.calculatePropertyGrowth(properties);

            	    BigDecimal totalRevenue = statsService.calculateTotalRevenue(properties);

            	    int totalApplications = statsService.calculateTotalApplications(applications);
            	    String applicationGrowth = statsService.calculateApplicationGrowth(applications);

            	    int totalReviews = statsService.calculateTotalReviews(reviews);
            	    double averageSiteRating = statsService.calculateAverageRating(reviews);

            	    request.setAttribute("properties", properties);
            	    request.setAttribute("users", users);
            	    request.setAttribute("applications", applications);
            	    request.setAttribute("reviews", reviews);
            	    request.setAttribute("recentActivities", recentActivities);

            	    request.setAttribute("totalUsers", totalUsers);
            	    request.setAttribute("userGrowth", userGrowth);
            	    request.setAttribute("totalProperties", totalProperties);
            	    request.setAttribute("propertyGrowth", propertyGrowth);
            	    request.setAttribute("totalRevenue", totalRevenue);
            	    request.setAttribute("totalApplications", totalApplications);
            	    request.setAttribute("applicationGrowth", applicationGrowth);
            	    request.setAttribute("totalReviews", totalReviews);
            	    request.setAttribute("averageSiteRating", averageSiteRating);
            	}
            	else if ("property-detail".equals(page)) {
            	    String idStr = request.getParameter("id");

            	    if (idStr != null) {
            	        try {
            	            int propertyId = Integer.parseInt(idStr);
            	            PropertyService propertyService = new PropertyService();
            	            PropertyImageService imageService = new PropertyImageService();
            	            reviewservice reviewService = new reviewservice();

            	            Property property = propertyService.getPropertyById(propertyId);
            	            List<PropertyImageModel> images = imageService.getImagesByPropertyId(propertyId);
            	            List<reviewmodel> reviews = reviewService.getReviewsByPropertyId(propertyId);
            	            double averageRating = reviewService.getAverageRating(propertyId);

            	            if (property != null) {
            	                // Set the primary image path on the property object
            	                try {
            	                    String primaryImagePath = imageService.getPrimaryImagePath(propertyId);
            	                    System.out.println("DEBUG: Primary image path for property " + propertyId + ": " + primaryImagePath);
            	                    property.setPrimaryImagePath(primaryImagePath);

            	                    // Print all images for debugging
            	                    System.out.println("DEBUG: All images for property " + propertyId + ":");
            	                    for (PropertyImageModel img : images) {
            	                        System.out.println("  - Image ID: " + img.getImageId() +
            	                                         ", Path: " + img.getImagePath() +
            	                                         ", Is Primary: " + img.isPrimary());
            	                    }
            	                } catch (Exception e) {
            	                    System.out.println("DEBUG: Error getting primary image path: " + e.getMessage());
            	                    property.setPrimaryImagePath("/images/property-placeholder.jpg"); // fallback image
            	                    e.printStackTrace();
            	                }

            	                request.setAttribute("property", property);
            	                request.setAttribute("propertyImages", images);
            	                request.setAttribute("reviews", reviews);
            	                request.setAttribute("averageRating", averageRating);
            	                request.getRequestDispatcher("/WEB-INF/pages/property-detail.jsp").forward(request, response);
            	                return;
            	            } else {
            	                System.err.println("Property not found for ID: " + propertyId);
            	            }
            	        } catch (NumberFormatException e) {
            	            System.err.println("Invalid property ID format: " + idStr);
            	        } catch (Exception e) {
            	            e.printStackTrace();
            	        }
            	    } else {
            	        System.err.println("Missing property ID parameter.");
            	    }

            	    // Fallback to properties listing
            	    response.sendRedirect(request.getContextPath() + "/view?page=properties");
            	} else if ("properties".equals(page)) {
                    String keyword = request.getParameter("keyword");
                    List<Property> properties;
                    PropertyService propertyService = new PropertyService();

                    if (keyword != null && !keyword.trim().isEmpty()) {
                        properties = propertyService.searchProperties(keyword.trim());
                    } else {
                        properties = propertyService.getAllProperties();
                    }
                    PropertyImageService imageService = new PropertyImageService();
                    for (Property property : properties) {
                        try {
                            String imagePath = imageService.getPrimaryImagePath(property.getPropertyId());
                            property.setPrimaryImagePath(imagePath);
                        } catch (Exception e) {
                            property.setPrimaryImagePath("/images/property-placeholder.jpg"); // fallback image
                            e.printStackTrace();
                        }
                    }

                    request.setAttribute("properties", properties);
                    request.getRequestDispatcher("/WEB-INF/pages/properties.jsp").forward(request, response);
                    return;
                } else if ("edit-property".equals(page)) {
                    // Only keep the success message if this is a redirect after an update
                    String updated = request.getParameter("updated");
                    if (updated == null || !updated.equals("true")) {
                        // Clear any existing success message if not coming from an update operation
                        request.getSession().removeAttribute("successmessage");
                    }

                    // Load property data if ID is provided
                    String idStr = request.getParameter("id");
                    if (idStr != null) {
                        try {
                            int propertyId = Integer.parseInt(idStr);
                            PropertyService propertyService = new PropertyService();
                            PropertyImageService imageService = new PropertyImageService();

                            Property property = propertyService.getPropertyById(propertyId);
                            List<PropertyImageModel> images = imageService.getImagesByPropertyId(propertyId);

                            if (property != null) {
                                request.setAttribute("property", property);
                                request.setAttribute("propertyImages", images);
                            } else {
                                response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard");
                                return;
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard");
                            return;
                        }
                    }
                }

                request.getRequestDispatcher(jspPath).forward(request, response);

            } catch (Exception e) {
                System.err.println("Error forwarding to " + jspPath + ": " + e.getMessage());
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "The requested page could not be displayed.");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/view?page=404&invalidPage=true");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}