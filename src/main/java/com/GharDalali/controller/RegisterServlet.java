package com.GharDalali.controller;

import com.GharDalali.model.UserModel;
import com.GharDalali.service.UserService;
import com.GharDalali.service.UserService.DuplicateUserException;
import com.GharDalali.service.UserService.RegistrationException;
import com.GharDalali.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String contactNumber = request.getParameter("contactNumber");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String contextPath = request.getContextPath();

        String errorMessage = null;
        if (ValidationUtil.isNullOrEmpty(username) || ValidationUtil.isNullOrEmpty(contactNumber) ||
            ValidationUtil.isNullOrEmpty(email) || ValidationUtil.isNullOrEmpty(password) ||
            ValidationUtil.isNullOrEmpty(confirmPassword)) {
            errorMessage = "All fields are required.";
        } else if (!ValidationUtil.isValidUsername(username)) {
            errorMessage = "Invalid username format or length (must start with letter, alphanumeric/underscore, 3+ chars).";
        } else if (!ValidationUtil.isValidEmail(email)) {
            errorMessage = "Invalid email format or length.";
        } else if (!ValidationUtil.isValidContactNumber(contactNumber)) {
            errorMessage = "Invalid contact number format or length.";
        } else if (!ValidationUtil.isPasswordLongEnough(password)) {
            errorMessage = "Password must be at least " + ValidationUtil.MIN_PASSWORD_LENGTH + " characters long.";
        } else if (!ValidationUtil.doPasswordsMatch(password, confirmPassword)) {
            errorMessage = "Passwords do not match.";
        }

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.setAttribute("usernameValue", username);
            request.setAttribute("contactNumberValue", contactNumber);
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        UserModel newUser = new UserModel();
        newUser.setUsername(username);
        newUser.setContactNumber(contactNumber);
        newUser.setEmail(email);
        newUser.setPassword(password);

        try {
            userService.registerUser(newUser);
            request.getSession().setAttribute("registrationStatus", "success");
            response.sendRedirect(contextPath + "/view?page=login");

        } catch (DuplicateUserException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.setAttribute("usernameValue", username);
            request.setAttribute("contactNumberValue", contactNumber);
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        } catch (RegistrationException | SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Registration failed. Please try again later.");
            request.setAttribute("usernameValue", username);
            request.setAttribute("contactNumberValue", contactNumber);
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred. Please try again later.");
            request.setAttribute("usernameValue", username);
            request.setAttribute("contactNumberValue", contactNumber);
            request.setAttribute("emailValue", email);
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }
}
