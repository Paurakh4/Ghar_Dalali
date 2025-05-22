package com.GharDalali.controller;

import com.GharDalali.model.UserModel;
import com.GharDalali.service.UserService;
import com.GharDalali.util.SessionUtil;
import com.GharDalali.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        UserModel currentUser = SessionUtil.getLoggedInUser(request);
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/view?page=login&error=session_required");
            return;
        }

        // Get updated form values
        String email = request.getParameter("email");
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");
        String bio = request.getParameter("bio");
        String profilePicture = request.getParameter("profilePicture"); // Optional

        // Validate inputs (optional)
        if (!ValidationUtil.isValidEmail(email) || !ValidationUtil.isValidContactNumber(contactNumber)) {
            response.sendRedirect(request.getContextPath() + "/view?page=userprofile&update=invalid");
            return;
        }

        // Update current user object
        currentUser.setEmail(email);
        currentUser.setContactNumber(contactNumber);
        currentUser.setAddress(address);
        currentUser.setBio(bio);
        currentUser.setProfilePicture(profilePicture);

        try {
            boolean updated = userService.updateUserProfile(currentUser);
            if (updated) {
                // ✅ Reload the user from DB to reflect fresh data in session
                UserModel refreshedUser = userService.findUserByUsername(currentUser.getUsername());
                SessionUtil.setLoggedInUser(request, refreshedUser);

                response.sendRedirect(request.getContextPath() + "/view?page=userprofile&status=updated");
            } else {
                response.sendRedirect(request.getContextPath() + "/view?page=userprofile&update=fail");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/view?page=userprofile&update=error");
        }
    }
}
