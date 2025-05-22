package com.GharDalali.controller;

import com.GharDalali.model.UserModel;
import com.GharDalali.service.applicationservice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/delete-application")
public class deleteapplicationservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Validate if user is logged in and is admin
        UserModel loggedInUser = (UserModel) request.getSession().getAttribute("loggedInUser");
        if (loggedInUser == null || !"Admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/view?page=login");
            return;
        }

        try {
            // Parse application ID
            int applicationId = Integer.parseInt(request.getParameter("id"));

            // Delete application
            applicationservice service = new applicationservice();
            service.deleteApplication(applicationId);

            // Redirect to dashboard with success
            response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard&delete=success");
        } catch (Exception e) {
            e.printStackTrace();
            // Redirect to dashboard with error
            response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard&error=delete_failed");
        }
    }
}