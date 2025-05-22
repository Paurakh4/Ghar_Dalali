package com.GharDalali.controller;

import com.GharDalali.model.UserModel;
import com.GharDalali.service.UserService;
import com.GharDalali.service.UserService.DuplicateUserException;
import com.GharDalali.service.UserService.RegistrationException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/registeruser")
public class adminregisterservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");
        String bio = request.getParameter("bio");
        String role = request.getParameter("role");
        String status = request.getParameter("status");

        UserModel user = new UserModel();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setContactNumber(contactNumber);
        user.setAddress(address);
        user.setBio(bio);
        user.setRole(role);
        user.setStatus(status);

        try {
            new UserService().registerUser(user);
            request.setAttribute("successmessage", "User registered successfully!");
        } catch (DuplicateUserException e) {
            request.setAttribute("errormessage", "Username or email already exists.");
        } catch (RegistrationException | SQLException | ClassNotFoundException e) {
            request.setAttribute("errormessage", "Error occurred during registration.");
            e.printStackTrace();
        }

        request.getRequestDispatcher("/WEB-INF/pages/add-user.jsp").forward(request, response);
    }
}