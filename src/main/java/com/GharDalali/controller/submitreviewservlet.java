package com.GharDalali.controller;

import java.io.IOException;

import com.GharDalali.model.UserModel;
import com.GharDalali.model.reviewmodel;
import com.GharDalali.service.reviewservice;
import com.GharDalali.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/submit-review")
public class submitreviewservlet extends HttpServlet {
    /**
	 *
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserModel user = SessionUtil.getLoggedInUser(request);
		if (user == null) {
		    response.sendRedirect(request.getContextPath() + "/view?page=login&message=Please login to submit a review");
		    return;
		}

		try {
            int propertyId = Integer.parseInt(request.getParameter("propertyId"));
            int rating = Integer.parseInt(request.getParameter("rating"));
            String reviewText = request.getParameter("reviewText");


            reviewmodel review = new reviewmodel();
            review.setPropertyId(propertyId);
            review.setUserId(user.getUserid());
            review.setRating(rating);
            review.setReviewText(reviewText);
            review.setStatus("PENDING");

            reviewservice service = new reviewservice();
            boolean isNewReview = service.addReview(review);

            if (isNewReview) {
                request.getSession().setAttribute("reviewSuccess", "Review submitted successfully!");
            } else {
                request.getSession().setAttribute("reviewSuccess", "Your previous review has been updated successfully!");
            }

            response.sendRedirect("view?page=property-detail&id=" + propertyId);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("view?page=property-detail&id=" + request.getParameter("propertyId") + "&review=error");
        }
    }
}