package com.GharDalali.controller;

import com.GharDalali.model.UserModel;
import com.GharDalali.service.UserService; // Import UserService
import com.GharDalali.util.CookieUtil;
import com.GharDalali.util.SessionUtil;
import com.GharDalali.util.ValidationUtil; // Import ValidationUtil

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException; // Import for catch block

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String REMEMBER_ME_COOKIE_NAME = "rememberMeUser";
    private UserService userService; 

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String submittedPassword = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");

        if (ValidationUtil.isNullOrEmpty(username) || ValidationUtil.isNullOrEmpty(submittedPassword)) {
            request.setAttribute("loginError", "Username and password are required.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        try {
            UserModel loggedInUser = userService.authenticateUser(username, submittedPassword);

            if (loggedInUser != null) {
                // Fetch full profile with bio, address, etc.
                UserModel fullUser = userService.findUserByUsername(username);
                SessionUtil.setLoggedInUser(request, fullUser);

                // Cookie Logic
                if ("true".equals(rememberMe)) {
                    int maxAgeSeconds = 14 * 24 * 60 * 60; // 14 days
                    CookieUtil.addCookie(response, REMEMBER_ME_COOKIE_NAME, fullUser.getUsername(), maxAgeSeconds);
                } else {
                    CookieUtil.deleteCookie(response, REMEMBER_ME_COOKIE_NAME);
                }

                // Redirect based on role
                if ("Admin".equalsIgnoreCase(fullUser.getRole())) {
                    response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard");
                } else {
                    response.sendRedirect(request.getContextPath() + "/view?page=home");
                }

            } else {
                request.setAttribute("loginError", "Invalid username or password.");
                CookieUtil.deleteCookie(response, REMEMBER_ME_COOKIE_NAME); 
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            }

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("loginError", "Login failed due to a server error.");
            CookieUtil.deleteCookie(response, REMEMBER_ME_COOKIE_NAME);
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("loginError", "An unexpected error occurred during login.");
            CookieUtil.deleteCookie(response, REMEMBER_ME_COOKIE_NAME);
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the login JSP
    	request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    
}
