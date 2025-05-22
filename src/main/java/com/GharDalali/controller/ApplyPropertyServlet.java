package com.GharDalali.controller;

import com.GharDalali.model.propertyapplicationmodel;
import com.GharDalali.service.applicationservice;
import com.GharDalali.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/apply-property")
public class ApplyPropertyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private applicationservice applicationService;

    @Override
    public void init() throws ServletException {
        applicationService = new applicationservice(); // initialize your service class
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String propertyIdStr = request.getParameter("propertyId");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String message = request.getParameter("message");

        if (propertyIdStr == null || fullName == null || email == null || phone == null || message == null ||
            fullName.trim().isEmpty() || email.trim().isEmpty() || phone.trim().isEmpty() || message.trim().isEmpty()) {
            response.sendRedirect("view?page=property-detail&id=" + propertyIdStr + "&error=missingData");
            return;
        }

        try {
            int propertyId = Integer.parseInt(propertyIdStr);
            HttpSession session = request.getSession(false);
            Integer userId = null;

            if (session != null && session.getAttribute("loggedInUser") != null) {
                UserModel user = (UserModel) session.getAttribute("loggedInUser");
                userId = user.getUserid();
            }

            propertyapplicationmodel application = new propertyapplicationmodel(
                    propertyId, userId, fullName, email, phone, message
            );

            applicationService.submitApplication(application);

            response.sendRedirect("view?page=property-detail&id=" + propertyId + "&apply=success");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view?page=property-detail&id=" + propertyIdStr + "&error=server");
        }
    }
}