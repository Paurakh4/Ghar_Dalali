package com.GharDalali.controller;

import com.GharDalali.model.UserModel;
import com.GharDalali.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/edituser")
public class EditUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int userId = Integer.parseInt(idParam);
                UserService userService = new UserService();
                UserModel user = userService.getUserById(userId);
                if (user != null) {
                    request.setAttribute("user", user);
                    request.getRequestDispatcher("/WEB-INF/pages/edit-user.jsp").forward(request, response);
                } else {
                    response.sendRedirect("/view?page=admin-dashboard&error=user_not_found");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("/view?page=admin-dashboard&error=invalid_user");
            }
        } else {
            response.sendRedirect("/view?page=admin-dashboard&error=missing_id");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
        	String userIdStr = request.getParameter("userId");
        	if (userIdStr == null || userIdStr.trim().isEmpty()) {
        	    throw new IllegalArgumentException("User ID is missing in request.");
        	}
        	int userId = Integer.parseInt(userIdStr);
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String contact = request.getParameter("contactNumber");
            String address = request.getParameter("address");
            String bio = request.getParameter("bio");
            String role = request.getParameter("role");
            String status = request.getParameter("status");

            UserModel user = new UserModel();
            user.setUserid(userId);
            user.setUsername(username);
            user.setEmail(email);
            user.setContactNumber(contact);
            user.setAddress(address);
            user.setBio(bio);
            user.setRole(role);
            user.setStatus(status);

            UserService userService = new UserService();
            boolean updated = userService.updateUserAdmin(user);

            if (updated) {
            	response.sendRedirect(request.getContextPath() + "/view?page=edit-user&updated=true");
            	request.getSession().setAttribute("successmessage", "User updated successfully.");
            } else {
                request.setAttribute("errormessage", "Failed to update user.");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/pages/edit-user.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errormessage", "Error occurred while updating user.");
            request.getRequestDispatcher("/WEB-INF/pages/edit-user.jsp").forward(request, response);
        }
    }
}