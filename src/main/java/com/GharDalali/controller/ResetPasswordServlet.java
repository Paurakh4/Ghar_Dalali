package com.GharDalali.controller;

import com.GharDalali.service.UserService;
import com.GharDalali.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/resetPassword") // Handles submission from resetPassword.jsp
public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Get existing session
        String username = null;
        String contextPath = request.getContextPath();

        // 1. Check if user is authorized to reset (username stored in session)
        if (session != null) {
            username = (String) session.getAttribute("resetUsername");
        }

        if (username == null) {
            // Not authorized or session expired
            request.setAttribute("loginError", "Your password reset session has expired or is invalid. Please start again.");
            response.sendRedirect(contextPath + "/view?page=login");
            return;
        }

        // 2. Get new passwords from the form
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // 3. Validate passwords using ValidationUtil
        String errorMessage = null;
        if (ValidationUtil.isNullOrEmpty(newPassword) || ValidationUtil.isNullOrEmpty(confirmPassword)) {
            errorMessage = "Both password fields are required.";
        } else if (!ValidationUtil.isPasswordLongEnough(newPassword)) {
             errorMessage = "Password must be at least " + ValidationUtil.MIN_PASSWORD_LENGTH + " characters long.";
             // Add complexity check here if needed
        } else if (!ValidationUtil.doPasswordsMatch(newPassword, confirmPassword)) {
            errorMessage = "New passwords do not match.";
        }

        if (errorMessage != null) {
             request.setAttribute("errorMessage", errorMessage);
             request.getRequestDispatcher("/WEB-INF/pages/resetpassword.jsp").forward(request, response);
             return;
        }

        // 4. Attempt to update password via service
        try {
            boolean updated = userService.updatePassword(username, newPassword);

            if (updated) {
                // Password updated successfully
                if(session != null) {
                    session.removeAttribute("resetUsername"); 
                    session.setAttribute("passwordResetStatus", "success"); 
                }
                response.sendRedirect(contextPath + "/view?page=login");
            } else {
                // Update failed (e.g., user might have been deleted)
                request.setAttribute("errorMessage", "Password reset failed. User may not exist anymore.");
                 if(session != null) session.removeAttribute("resetUsername"); // Invalidate permission
                 request.getRequestDispatcher("/WEB-INF/pages/resetpassword.jsp").forward(request, response);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace(); 
            request.setAttribute("errorMessage", "Error updating password due to a server issue.");
            if(session != null) session.removeAttribute("resetUsername"); // Invalidate permission
            request.getRequestDispatcher("/WEB-INF/pages/resetpassword.jsp").forward(request, response);
        } catch (Exception e) {
             e.printStackTrace(); 
             request.setAttribute("errorMessage", "An unexpected error occurred.");
             if(session != null) session.removeAttribute("resetUsername"); // Invalidate permission
             request.getRequestDispatcher("/WEB-INF/pages/resetpassword.jsp").forward(request, response);
        }
    }
     @Override
     protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         HttpSession session = request.getSession(false);
         if (session == null || session.getAttribute("resetUsername") == null) {
            
             request.setAttribute("loginError", "Your password reset session has expired or is invalid. Please start again.");
             response.sendRedirect(request.getContextPath() + "/view?page=login");
         } else {
       
        	 request.getRequestDispatcher("/WEB-INF/pages/resetpassword.jsp").forward(request, response);
         }
     }
}
