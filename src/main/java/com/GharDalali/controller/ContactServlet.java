package com.GharDalali.controller;

import com.GharDalali.model.ContactMessageModel;
import com.GharDalali.model.UserModel;
import com.GharDalali.service.ContactMessageService;
import com.GharDalali.util.SessionUtil;
import com.GharDalali.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

/**
 * Servlet to handle contact form submissions.
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ContactMessageService contactMessageService;

    @Override
    public void init() throws ServletException {
        contactMessageService = new ContactMessageService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Validate form data
        StringBuilder errorMessage = new StringBuilder();

        if (ValidationUtil.isNullOrEmpty(name)) {
            errorMessage.append("Name is required. ");
        }

        if (ValidationUtil.isNullOrEmpty(email)) {
            errorMessage.append("Email is required. ");
        } else if (!ValidationUtil.isValidEmail(email)) {
            errorMessage.append("Invalid email format. ");
        }

        if (!ValidationUtil.isNullOrEmpty(phone) && !ValidationUtil.isValidContactNumber(phone)) {
            errorMessage.append("Invalid phone number format. ");
        }

        if (ValidationUtil.isNullOrEmpty(subject)) {
            errorMessage.append("Subject is required. ");
        }

        if (ValidationUtil.isNullOrEmpty(message)) {
            errorMessage.append("Message is required. ");
        }

        // If there are validation errors, redirect back to the contact page with error message
        if (errorMessage.length() > 0) {
            request.getSession().setAttribute("contactError", errorMessage.toString().trim());
            response.sendRedirect(request.getContextPath() + "/view?page=contact");
            return;
        }

        // Create a new contact message
        ContactMessageModel contactMessage = new ContactMessageModel();
        contactMessage.setName(name);
        contactMessage.setEmail(email);
        contactMessage.setPhone(phone);
        contactMessage.setSubject(subject);
        contactMessage.setMessage(message);

        // If user is logged in, associate the message with their user ID
        UserModel currentUser = SessionUtil.getLoggedInUser(request);
        if (currentUser != null) {
            contactMessage.setUserId(currentUser.getUserid());
        }

        try {
            // Save the contact message
            boolean success = contactMessageService.saveContactMessage(contactMessage);

            if (success) {
                // Set success message and redirect
                request.getSession().setAttribute("contactSuccess", "Your message has been sent successfully. We will get back to you soon!");
            } else {
                // Set error message and redirect
                request.getSession().setAttribute("contactError", "Failed to send your message. Please try again later.");
            }
        } catch (SQLException | ClassNotFoundException e) {
            // Log the error
            System.err.println("Error saving contact message: " + e.getMessage());
            e.printStackTrace();

            // Set error message and redirect
            request.getSession().setAttribute("contactError", "An error occurred while processing your request. Please try again later.");
        }

        // Redirect back to the contact page
        response.sendRedirect(request.getContextPath() + "/view?page=contact");
    }
}
