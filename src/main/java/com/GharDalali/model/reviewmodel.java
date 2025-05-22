package com.GharDalali.model;

import java.sql.Timestamp;

public class reviewmodel {
    private int reviewId;
    private int userId;
    private int propertyId;
    private int rating;
    private String reviewText;
    private Timestamp reviewedAt;
    private Timestamp updatedAt;
    private String status;

    // Extra fields (optional)
    private String username; // from joined user table if needed
    private String propertyTitle;

    // Getters and setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPropertyId() {
        return propertyId;
    }

    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public Timestamp getReviewedAt() {
        return reviewedAt;
    }

    public void setReviewedAt(Timestamp reviewedAt) {
        this.reviewedAt = reviewedAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
    public String getStatus() {
    	return status;
    }
    public void setStatus(String status) {
    	this.status = status;
    }
    public String getPropertyTitle() {
    	return propertyTitle;
    }
    public void setPropertyTitle(String propertyTitle) {
    	this.propertyTitle = propertyTitle;
    }
}