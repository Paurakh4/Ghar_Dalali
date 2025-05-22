package com.GharDalali.controller;

import com.GharDalali.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/deleteuser")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String userIdStr = request.getParameter("id");
            if (userIdStr == null || userIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() +"/view?page=admin-dashboard&error=missing_user_id");
                return;
            }

            int userId = Integer.parseInt(userIdStr);
            boolean deleted = UserService.deleteUser(userId);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard&delete=success");
            } else {
                response.sendRedirect(request.getContextPath() +"/view?page=admin-dashboard&error=delete_failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() +"/view?page=admin-dashboard&error=exception");
        }
    }
}