package com.GharDalali.controller;

import com.GharDalali.service.PropertyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteproperties")
public class deleteproperty extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PropertyService propertyService;

    @Override
    public void init() throws ServletException {
        propertyService = new PropertyService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                boolean deleted = propertyService.deleteProperty(id);
                if (deleted) {
                	req.getSession().setAttribute("SuccessMessage", "Property deleted successfully.");
                    resp.sendRedirect(req.getContextPath() + "/view?page=admin-dashboard&deleted=true");
                } else {
                	req.setAttribute("ErrorMessage", " Property failed to delete");
                    resp.sendRedirect(req.getContextPath() + "/view?page=admin-dashboard&error=delete-failed");
                }
            } catch (Exception e) {
                e.printStackTrace();
                resp.sendRedirect(req.getContextPath() + "/view?page=admin-dashboard&error=exception");
            }
        } else {
            resp.sendRedirect(req.getContextPath() + "/view?page=admin-dashboard&error=invalid_id");
        }
    }
}
