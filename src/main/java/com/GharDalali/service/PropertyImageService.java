package com.GharDalali.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.GharDalali.config.DbConfig;
import com.GharDalali.model.PropertyImageModel;

/**
 * Service class for managing property images in the database.
 */
public class PropertyImageService {

    /**
     * Adds a new image to a property.
     * 
     * @param propertyId The ID of the property
     * @param imagePath The path to the image file
     * @param isPrimary Whether this is the primary image for the property
     * @return true if successful, false otherwise
     */
    public boolean addPropertyImage(int propertyId, String imagePath, boolean isPrimary) throws SQLException, ClassNotFoundException {
        // If this is the primary image, update any existing primary images to non-primary
        if (isPrimary) {
            resetPrimaryImages(propertyId);
        }
        
        String sql = "INSERT INTO property_images (property_id, image_path, is_primary) VALUES (?, ?, ?)";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setInt(1, propertyId);
            stmt.setString(2, imagePath);
            stmt.setBoolean(3, isPrimary);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    /**
     * Resets all images for a property to non-primary.
     * 
     * @param propertyId The ID of the property
     * @return true if successful, false otherwise
     */
    private boolean resetPrimaryImages(int propertyId) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE property_images SET is_primary = 0 WHERE property_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, propertyId);
            stmt.executeUpdate();
            return true;
        }
    }
    
    /**
     * Sets an image as the primary image for a property.
     * 
     * @param imageId The ID of the image to set as primary
     * @param propertyId The ID of the property
     * @return true if successful, false otherwise
     */
    public boolean setPrimaryImage(int imageId, int propertyId) throws SQLException, ClassNotFoundException {
        // First, reset all images for this property to non-primary
        resetPrimaryImages(propertyId);
        
        // Then, set the specified image as primary
        String sql = "UPDATE property_images SET is_primary = 1 WHERE image_id = ? AND property_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, imageId);
            stmt.setInt(2, propertyId);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    /**
     * Deletes an image from a property.
     * 
     * @param imageId The ID of the image to delete
     * @return true if successful, false otherwise
     */
    public boolean deletePropertyImage(int imageId) throws SQLException, ClassNotFoundException {
        // First, check if this is a primary image
        boolean isPrimary = false;
        int propertyId = 0;
        
        String checkSql = "SELECT property_id, is_primary FROM property_images WHERE image_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
            
            checkStmt.setInt(1, imageId);
            ResultSet rs = checkStmt.executeQuery();
            
            if (rs.next()) {
                propertyId = rs.getInt("property_id");
                isPrimary = rs.getBoolean("is_primary");
            } else {
                return false; // Image not found
            }
        }
        
        // Delete the image
        String deleteSql = "DELETE FROM property_images WHERE image_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
            
            deleteStmt.setInt(1, imageId);
            int affectedRows = deleteStmt.executeUpdate();
            
            // If this was a primary image and was successfully deleted, set a new primary image
            if (affectedRows > 0 && isPrimary) {
                setNewPrimaryImage(propertyId);
            }
            
            return affectedRows > 0;
        }
    }
    
    /**
     * Sets a new primary image for a property after the current primary image is deleted.
     * 
     * @param propertyId The ID of the property
     * @return true if successful, false otherwise
     */
    private boolean setNewPrimaryImage(int propertyId) throws SQLException, ClassNotFoundException {
        // Find the oldest image for this property
        String sql = "SELECT image_id FROM property_images WHERE property_id = ? ORDER BY created_at ASC LIMIT 1";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                int imageId = rs.getInt("image_id");
                return setPrimaryImage(imageId, propertyId);
            }
            
            return false; // No images left
        }
    }
    
    /**
     * Gets all images for a property.
     * 
     * @param propertyId The ID of the property
     * @return List of PropertyImageModel objects
     */
    public List<PropertyImageModel> getImagesByPropertyId(int propertyId) throws SQLException, ClassNotFoundException {
        List<PropertyImageModel> images = new ArrayList<>();
        String sql = "SELECT * FROM property_images WHERE property_id = ? ORDER BY is_primary DESC, created_at ASC";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                PropertyImageModel img = new PropertyImageModel();
                img.setImageId(rs.getInt("image_id"));
                img.setPropertyId(rs.getInt("property_id"));
                img.setImagePath(rs.getString("image_path"));
                img.setIsPrimary(rs.getBoolean("is_primary"));
                img.setCreatedAt(rs.getTimestamp("created_at"));
                images.add(img);
            }
        }
        
        return images;
    }
    
    /**
     * Gets the primary image path for a property.
     * 
     * @param propertyId The ID of the property
     * @return The path to the primary image, or a default image path if none exists
     */
    public String getPrimaryImagePath(int propertyId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT image_path FROM property_images WHERE property_id = ? AND is_primary = 1 LIMIT 1";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, propertyId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getString("image_path");
            }
        }
        
        return "/images/property-placeholder.jpg"; // fallback image
    }
}
