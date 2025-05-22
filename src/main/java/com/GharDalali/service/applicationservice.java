package com.GharDalali.service;

import com.GharDalali.config.DbConfig;
import com.GharDalali.model.propertyapplicationmodel;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class applicationservice{

    public void submitApplication(propertyapplicationmodel application) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO property_applications (property_id, userid, full_name, email, phone, message, status) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, application.getPropertyId());
            
            if (application.getUserId() != null) {
                stmt.setInt(2, application.getUserId());
            } else {
                stmt.setNull(2, java.sql.Types.INTEGER);
            }

            stmt.setString(3, application.getFullName());
            stmt.setString(4, application.getEmail());
            stmt.setString(5, application.getPhone());
            stmt.setString(6, application.getMessage());
            stmt.setString(7, application.getStatus());

            stmt.executeUpdate();
        }
    }
    public List<propertyapplicationmodel> getAllApplications() throws SQLException, ClassNotFoundException {
        List<propertyapplicationmodel> applications = new ArrayList<>();

        String sql = "SELECT a.*, p.property_name AS propertyTitle, p.location AS propertyLocation " +
                     "FROM property_applications a " +
                     "JOIN properties p ON a.property_id = p.property_id";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                propertyapplicationmodel app = new propertyapplicationmodel();
                app.setApplicationId(rs.getInt("application_id"));
                app.setPropertyId(rs.getInt("property_id"));
                app.setUserId((Integer) rs.getObject("userid")); // Use getObject for nullable fields
                app.setFullName(rs.getString("full_name"));
                app.setEmail(rs.getString("email"));
                app.setPhone(rs.getString("phone"));
                app.setMessage(rs.getString("message"));
                app.setStatus(rs.getString("status"));
                app.setCreatedAt(rs.getTimestamp("created_at"));
                app.setUpdatedAt(rs.getTimestamp("updated_at"));
                app.setPropertyTitle(rs.getString("propertyTitle"));
                app.setPropertyLocation(rs.getString("propertyLocation"));

                applications.add(app);
            }
        }

        return applications;
    }
    public void deleteApplication(int applicationId) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM property_applications WHERE application_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, applicationId);
            stmt.executeUpdate();
        }
    }
    public void updateApplicationStatus(int applicationId, String newStatus) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE property_applications SET status = ?, updated_at = NOW() WHERE application_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newStatus);
            stmt.setInt(2, applicationId);
            stmt.executeUpdate();
        }
    }
}