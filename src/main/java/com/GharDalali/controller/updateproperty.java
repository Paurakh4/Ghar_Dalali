package com.GharDalali.controller;

import com.GharDalali.model.Property;
import com.GharDalali.model.PropertyImageModel;
import com.GharDalali.service.PropertyImageService;
import com.GharDalali.service.PropertyService;
import com.GharDalali.util.SessionUtil;
import com.GharDalali.model.UserModel;

import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/updateproperties")
public class updateproperty extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;
    private PropertyImageService imageService;

    @Override
    public void init() throws ServletException {
        propertyService = new PropertyService();
        imageService = new PropertyImageService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Property property = propertyService.getPropertyById(id);
                List<PropertyImageModel> images = imageService.getImagesByPropertyId(id);

                req.setAttribute("property", property);
                req.setAttribute("propertyImages", images);
                req.getRequestDispatcher("/WEB-INF/pages/edit-property.jsp").forward(req, resp);
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/view?page=admin-dashboard");
            }
        }
    }

    // Handle form submission
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            UserModel currentUser = SessionUtil.getLoggedInUser(req);
            if (currentUser == null || !"Admin".equalsIgnoreCase(currentUser.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/view?page=login");
                return;
            }

            int propertyId = Integer.parseInt(req.getParameter("propertyId"));

            Property property = new Property();
            property.setPropertyId(propertyId);
            property.setPropertyName(req.getParameter("propertyName"));
            property.setPropertyType(req.getParameter("propertyType"));
            property.setDescription(req.getParameter("description"));
            property.setLocation(req.getParameter("location"));
            property.setPrice(new BigDecimal(req.getParameter("price")));
            property.setBedrooms(parseIntOrNull(req.getParameter("bedrooms")));
            property.setBathrooms(parseIntOrNull(req.getParameter("bathrooms")));
            property.setSize(new BigDecimal(req.getParameter("size")));
            property.setSizeUnit(req.getParameter("sizeUnit"));
            property.setStatus(req.getParameter("status"));

            boolean updated = propertyService.updateProperty(property);
            if (updated) {
                req.getSession().setAttribute("successmessage", "Property updated successfully.");
                resp.sendRedirect(req.getContextPath() + "/view?page=edit-property&id=" + propertyId + "&updated=true");
            } else {
                req.setAttribute("errormessage", "Failed to edit property.");
                req.setAttribute("property", property);
                req.getRequestDispatcher("/WEB-INF/pages/edit-property.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/pages/edit-property.jsp").forward(req, resp);
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
