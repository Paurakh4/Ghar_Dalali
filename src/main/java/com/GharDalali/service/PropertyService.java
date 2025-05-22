package com.GharDalali.service;

import com.GharDalali.config.DbConfig;
import com.GharDalali.model.Property;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.GharDalali.model.PropertyImageModel;
import java.util.Map;
import java.util.LinkedHashMap;

public class PropertyService {

    /**
     * Add a new property to the database
     *
     * @param property The property object to add
     * @return true if successful, false otherwise
     */
    public boolean addProperty(Property property) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO properties (property_name, property_type, description, location, price, bedrooms, bathrooms, size, size_unit, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, property.getPropertyName());
            stmt.setString(2, property.getPropertyType());
            stmt.setString(3, property.getDescription());
            stmt.setString(4, property.getLocation());
            stmt.setBigDecimal(5, property.getPrice());
            stmt.setObject(6, property.getBedrooms());
            stmt.setObject(7, property.getBathrooms());
            stmt.setBigDecimal(8, property.getSize());
            stmt.setString(9, property.getSizeUnit());
            stmt.setString(10, property.getStatus());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        property.setPropertyId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
            return false;
        }
    }

    /**
     * Get all properties from the database
     *
     * @return List of all properties
     */
    public List<Property> getAllProperties() throws SQLException, ClassNotFoundException {
        List<Property> properties = new ArrayList<>();

        String sql = "SELECT p.*, i.image_path AS primaryImagePath " +
                "FROM properties p " +
                "LEFT JOIN property_images i ON p.property_id = i.property_id AND i.is_primary = 1";


        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
            	Property property = mapResultSetToProperty(rs);
                property.setPrimaryImagePath(rs.getString("primaryImagePath"));
                properties.add(property);

            }
        }

        return properties;
    }

    /**
     * Get a property by its ID
     *
     * @param propertyId The ID of the property to retrieve
     * @return The property object, or null if not found
     */
    public Property getPropertyById(int propertyId) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM properties WHERE property_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, propertyId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToProperty(rs);
                }
            }
        }

        return null;
    }

    /**
     * Update an existing property
     *
     * @param property The property object with updated values
     * @return true if successful, false otherwise
     */
    public boolean updateProperty(Property property) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE properties SET property_name = ?, property_type = ?, description = ?, " +
                     "location = ?, price = ?, bedrooms = ?, bathrooms = ?, size = ?, " +
                     "size_unit = ?, status = ? " +
                     "WHERE property_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, property.getPropertyName());
            stmt.setString(2, property.getPropertyType());
            stmt.setString(3, property.getDescription());
            stmt.setString(4, property.getLocation());
            stmt.setBigDecimal(5, property.getPrice());
            stmt.setObject(6, property.getBedrooms());
            stmt.setObject(7, property.getBathrooms());
            stmt.setBigDecimal(8, property.getSize());
            stmt.setString(9, property.getSizeUnit());
            stmt.setString(10, property.getStatus());
            stmt.setInt(11, property.getPropertyId());

            return stmt.executeUpdate() > 0;
        }
    }

    /**
     * Delete a property by its ID
     *
     * @param propertyId The ID of the property to delete
     * @return true if successful, false otherwise
     */
    public boolean deleteProperty(int propertyId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM properties WHERE property_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, propertyId);

            return stmt.executeUpdate() > 0;
        }
    }

    /**
     * Search properties by name, type, or location
     *
     * @param searchTerm The search term to look for
     * @return List of matching properties
     */
    public List<Property> searchProperties(String keyword) {
        List<Property> results = new ArrayList<>();
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "SELECT * FROM properties WHERE property_name LIKE ? OR location LIKE ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Property property = new Property();
                // map result to property fields
                property.setPropertyId(rs.getInt("property_id"));
                property.setPropertyName(rs.getString("property_name"));
                property.setLocation(rs.getString("location"));
                property.setPrice(BigDecimal.valueOf(rs.getDouble("price")));
                property.setStatus(rs.getString("status"));
                // add others as needed

                results.add(property);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return results;
    }

    /**
     * Filter properties by status
     *
     * @param status The status to filter by
     * @return List of properties with the specified status
     */
    public List<Property> filterPropertiesByStatus(String status) throws SQLException, ClassNotFoundException {
        List<Property> properties = new ArrayList<>();

        String sql = "SELECT * FROM properties WHERE status = ? ORDER BY created_at DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    properties.add(mapResultSetToProperty(rs));
                }
            }
        }

        return properties;
    }

    /**
     * Helper method to map a ResultSet row to a Property object
     */
    private Property mapResultSetToProperty(ResultSet rs) throws SQLException {
        Property property = new Property();
        property.setPropertyId(rs.getInt("property_id"));
        property.setPropertyName(rs.getString("property_name"));
        property.setPropertyType(rs.getString("property_type"));
        property.setDescription(rs.getString("description"));
        property.setLocation(rs.getString("location"));
        property.setPrice(rs.getBigDecimal("price"));

        // Handle nullable fields
        Integer bedrooms = rs.getObject("bedrooms") != null ? rs.getInt("bedrooms") : null;
        property.setBedrooms(bedrooms);

        Integer bathrooms = rs.getObject("bathrooms") != null ? rs.getInt("bathrooms") : null;
        property.setBathrooms(bathrooms);

        property.setSize(rs.getBigDecimal("size"));
        property.setSizeUnit(rs.getString("size_unit"));
        property.setStatus(rs.getString("status"));
        property.setCreatedAt(rs.getTimestamp("created_at"));

        // Handle nullable updated_at
        Timestamp updatedAt = rs.getTimestamp("updated_at");
        if (updatedAt != null) {
            property.setUpdatedAt(updatedAt);
        }

        return property;
    }
    public List<PropertyImageModel> getImagesByPropertyId(int propertyId) throws Exception {
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