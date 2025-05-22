package com.GharDalali.controller;

import com.GharDalali.service.applicationservice;
import com.GharDalali.model.UserModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/update-application-status")
public class updateapplicationstatus extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        UserModel user = (UserModel) request.getSession().getAttribute("loggedInUser");
        if (user == null || !"Admin".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/view?page=login");
            return;
        }

        try {
            int applicationId = Integer.parseInt(request.getParameter("id"));
            String newStatus = request.getParameter("status");

            applicationservice service = new applicationservice();
            service.updateApplicationStatus(applicationId, newStatus);

            response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard&statusUpdate=success");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard&statusUpdate=failed");
        }
    }
}