package com.GharDalali.model;

import java.sql.Timestamp;

/**
 * Model class representing a property application in the system.
 * This tracks applications submitted by users for properties.
 */
public class propertyapplicationmodel {
    private int applicationId;
    private int propertyId;
    private Integer userId;  // Can be null for non-registered users
    private String fullName;
    private String email;
    private String phone;
    private String message;
    private String status;  // PENDING, APPROVED, REJECTED
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Property details (for convenience)
    private String propertyTitle;
    private String propertyLocation;
    
    // Default constructor
    public propertyapplicationmodel() {
    }
    
    // Constructor with essential fields
    public propertyapplicationmodel(int propertyId, Integer userId, String fullName, String email, 
                                   String phone, String message) {
        this.propertyId = propertyId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.message = message;
        this.status = "PENDING";
    }
    
    // Full constructor
    public propertyapplicationmodel(int applicationId, int propertyId, Integer userId, String fullName, 
                                   String email, String phone, String message, String status, 
                                   Timestamp createdAt, Timestamp updatedAt) {
        this.applicationId = applicationId;
        this.propertyId = propertyId;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.message = message;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    // Getters and setters
    public int getApplicationId() {
        return applicationId;
    }
    
    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }
    
    public int getPropertyId() {
        return propertyId;
    }
    
    public void setPropertyId(int propertyId) {
        this.propertyId = propertyId;
    }
    
    public Integer getUserId() {
        return userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public String getPhone() {
        return phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }
    
    public String getMessage() {
        return message;
    }
    
    public void setMessage(String message) {
        this.message = message;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    public String getPropertyTitle() {
        return propertyTitle;
    }
    
    public void setPropertyTitle(String propertyTitle) {
        this.propertyTitle = propertyTitle;
    }
    
    public String getPropertyLocation() {
        return propertyLocation;
    }
    
    public void setPropertyLocation(String propertyLocation) {
        this.propertyLocation = propertyLocation;
    }
    
    
    
}
