package com.GharDalali.service;

import com.GharDalali.config.DbConfig;
import com.GharDalali.model.reviewmodel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class reviewservice {

    /**
     * Check if a user has already reviewed a property
     * @param userId The user ID
     * @param propertyId The property ID
     * @return The review ID if a review exists, or -1 if no review exists
     */
    public int checkExistingReview(int userId, int propertyId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT review_id FROM reviews WHERE user_id = ? AND property_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, propertyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("review_id");
            }
        }

        return -1; // No review exists
    }

    /**
     * Update an existing review
     * @param reviewId The ID of the review to update
     * @param review The updated review data
     */
    public void updateReview(int reviewId, reviewmodel review) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE reviews SET rating = ?, review_text = ?, status = ? WHERE review_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getReviewText());
            stmt.setString(3, review.getStatus() != null ? review.getStatus() : "PENDING");
            stmt.setInt(4, reviewId);
            stmt.executeUpdate();
        }
    }

    /**
     * Add a new review or update an existing one
     * @param review The review to add or update
     * @return true if a new review was added, false if an existing review was updated
     */
    public boolean addReview(reviewmodel review) throws SQLException, ClassNotFoundException {
        // Check if the user has already reviewed this property
        int existingReviewId = checkExistingReview(review.getUserId(), review.getPropertyId());

        if (existingReviewId != -1) {
            // Update the existing review
            updateReview(existingReviewId, review);
            return false; // Review was updated, not added
        } else {
            // Add a new review
            String sql = "INSERT INTO reviews (user_id, property_id, rating, review_text, status) VALUES (?, ?, ?, ?, ?)";

            try (Connection conn = DbConfig.getDbConnection();
                 PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, review.getUserId());
                stmt.setInt(2, review.getPropertyId());
                stmt.setInt(3, review.getRating());
                stmt.setString(4, review.getReviewText());
                stmt.setString(5, review.getStatus() != null ? review.getStatus() : "PENDING");
                stmt.executeUpdate();
            }
            return true; // New review was added
        }
    }

    // Get reviews for a property
    public List<reviewmodel> getReviewsByPropertyId(int propertyId) throws SQLException, ClassNotFoundException {
        List<reviewmodel> reviews = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM reviews r " +
                "JOIN users u ON r.user_id = u.userid " +
                "WHERE r.property_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                reviewmodel review = new reviewmodel();
                review.setReviewId(rs.getInt("review_id"));
                review.setUserId(rs.getInt("user_id"));
                review.setPropertyId(rs.getInt("property_id"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("review_text"));
                review.setReviewedAt(rs.getTimestamp("reviewed_at"));
                review.setUpdatedAt(rs.getTimestamp("updated_at"));
                review.setUsername(rs.getString("username"));

                // Safely get status with null check
                String status = rs.getString("status");
                review.setStatus(status != null ? status : "PENDING");
                reviews.add(review);
            }
        }

        return reviews;
    }
    public double getAverageRating(int propertyId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT AVG(rating) AS avg_rating FROM reviews WHERE property_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("avg_rating");
            }
        }

        return 0.0;
    }

    public void deleteReviewById(int reviewId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            stmt.executeUpdate();
        }
    }
    public List<reviewmodel> getAllReviews() throws SQLException, ClassNotFoundException {
        List<reviewmodel> reviews = new ArrayList<>();

        String sql = "SELECT r.*, u.username, p.property_name AS propertyTitle " +
                     "FROM reviews r " +
                     "JOIN users u ON r.user_id = u.userid " +
                     "JOIN properties p ON r.property_id = p.property_id " +
                     "ORDER BY r.reviewed_at DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                reviewmodel review = new reviewmodel();
                review.setReviewId(rs.getInt("review_id"));
                review.setUserId(rs.getInt("user_id"));
                review.setPropertyId(rs.getInt("property_id"));
                review.setRating(rs.getInt("rating"));
                review.setReviewText(rs.getString("review_text"));
                review.setReviewedAt(rs.getTimestamp("reviewed_at"));
                review.setUpdatedAt(rs.getTimestamp("updated_at"));
                review.setUsername(rs.getString("username"));
                review.setPropertyTitle(rs.getString("propertyTitle"));

                // Safely get status with null check
                String status = rs.getString("status");
                review.setStatus(status != null ? status : "PENDING");

                reviews.add(review);
            }
        }

        return reviews;
    }
}