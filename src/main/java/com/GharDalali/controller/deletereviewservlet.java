package com.GharDalali.controller;

import java.io.IOException;

import com.GharDalali.service.reviewservice;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/delete-review")
public class deletereviewservlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private reviewservice reviewService = new reviewservice();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int reviewId = Integer.parseInt(idStr);
                reviewService.deleteReviewById(reviewId);
                response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard&deleted=true");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/view?page=admin-dashboard&error=delete_failed");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/view?page=admin-reviews");
        }
    }
}