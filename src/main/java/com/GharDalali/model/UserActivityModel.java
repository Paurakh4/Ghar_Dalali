package com.GharDalali.model;

import java.sql.Timestamp;

/**
 * Model class representing a user activity in the system.
 * This tracks various activities performed by users.
 */
public class UserActivityModel {
    private int activityId;
    private int userId;
    private String activityType;
    private String description;
    private String entityType;
    private Integer entityId;
    private String ipAddress;
    private Timestamp createdAt;
    
    // Additional fields for display purposes
    private String username;
    
    // Default constructor
    public UserActivityModel() {
    }
    
    // Constructor with essential fields
    public UserActivityModel(int userId, String activityType, String description) {
        this.userId = userId;
        this.activityType = activityType;
        this.description = description;
    }
    
    // Full constructor
    public UserActivityModel(int activityId, int userId, String activityType, String description, 
                            String entityType, Integer entityId, String ipAddress, Timestamp createdAt) {
        this.activityId = activityId;
        this.userId = userId;
        this.activityType = activityType;
        this.description = description;
        this.entityType = entityType;
        this.entityId = entityId;
        this.ipAddress = ipAddress;
        this.createdAt = createdAt;
    }
    
    // Getters and setters
    public int getActivityId() {
        return activityId;
    }
    
    public void setActivityId(int activityId) {
        this.activityId = activityId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getActivityType() {
        return activityType;
    }
    
    public void setActivityType(String activityType) {
        this.activityType = activityType;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getEntityType() {
        return entityType;
    }
    
    public void setEntityType(String entityType) {
        this.entityType = entityType;
    }
    
    public Integer getEntityId() {
        return entityId;
    }
    
    public void setEntityId(Integer entityId) {
        this.entityId = entityId;
    }
    
    public String getIpAddress() {
        return ipAddress;
    }
    
    public void setIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    // Helper method to get a formatted time ago string (e.g., "2 hours ago")
    public String getTimeAgo() {
        if (createdAt == null) {
            return "Unknown time";
        }
        
        long now = System.currentTimeMillis();
        long time = createdAt.getTime();
        long diff = now - time;
        
        // Convert to seconds
        long seconds = diff / 1000;
        
        if (seconds < 60) {
            return seconds + " seconds ago";
        }
        
        // Convert to minutes
        long minutes = seconds / 60;
        if (minutes < 60) {
            return minutes + " minutes ago";
        }
        
        // Convert to hours
        long hours = minutes / 60;
        if (hours < 24) {
            return hours + " hours ago";
        }
        
        // Convert to days
        long days = hours / 24;
        if (days < 30) {
            return days + " days ago";
        }
        
        // Convert to months
        long months = days / 30;
        if (months < 12) {
            return months + " months ago";
        }
        
        // Convert to years
        long years = months / 12;
        return years + " years ago";
    }
}
