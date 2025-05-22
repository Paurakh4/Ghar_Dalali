package com.GharDalali.service;

import com.GharDalali.config.DbConfig;
import com.GharDalali.model.UserActivityModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for handling user activity operations.
 */
public class UserActivityService {

    /**
     * Get recent user activities with a limit
     * 
     * @param limit Maximum number of activities to retrieve
     * @return List of recent user activities
     */
    public List<UserActivityModel> getRecentActivities(int limit) throws SQLException, ClassNotFoundException {
        List<UserActivityModel> activities = new ArrayList<>();
        
        String sql = "SELECT a.*, u.username " +
                     "FROM user_activities a " +
                     "LEFT JOIN users u ON a.user_id = u.userid " +
                     "ORDER BY a.created_at DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    UserActivityModel activity = new UserActivityModel();
                    activity.setActivityId(rs.getInt("activity_id"));
                    activity.setUserId(rs.getInt("user_id"));
                    activity.setActivityType(rs.getString("activity_type"));
                    activity.setDescription(rs.getString("description"));
                    activity.setEntityType(rs.getString("entity_type"));
                    activity.setEntityId(rs.getInt("entity_id"));
                    activity.setIpAddress(rs.getString("ip_address"));
                    activity.setCreatedAt(rs.getTimestamp("created_at"));
                    activity.setUsername(rs.getString("username"));
                    
                    activities.add(activity);
                }
            }
        }
        
        return activities;
    }
    
    /**
     * Get activities for a specific user
     * 
     * @param userId User ID to get activities for
     * @param limit Maximum number of activities to retrieve
     * @return List of user activities
     */
    public List<UserActivityModel> getUserActivities(int userId, int limit) throws SQLException, ClassNotFoundException {
        List<UserActivityModel> activities = new ArrayList<>();
        
        String sql = "SELECT a.*, u.username " +
                     "FROM user_activities a " +
                     "LEFT JOIN users u ON a.user_id = u.userid " +
                     "WHERE a.user_id = ? " +
                     "ORDER BY a.created_at DESC " +
                     "LIMIT ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, limit);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    UserActivityModel activity = new UserActivityModel();
                    activity.setActivityId(rs.getInt("activity_id"));
                    activity.setUserId(rs.getInt("user_id"));
                    activity.setActivityType(rs.getString("activity_type"));
                    activity.setDescription(rs.getString("description"));
                    activity.setEntityType(rs.getString("entity_type"));
                    activity.setEntityId(rs.getInt("entity_id"));
                    activity.setIpAddress(rs.getString("ip_address"));
                    activity.setCreatedAt(rs.getTimestamp("created_at"));
                    activity.setUsername(rs.getString("username"));
                    
                    activities.add(activity);
                }
            }
        }
        
        return activities;
    }
    
    /**
     * Log a new user activity
     * 
     * @param activity The activity to log
     * @return true if successful, false otherwise
     */
    public boolean logActivity(UserActivityModel activity) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO user_activities (user_id, activity_type, description, entity_type, entity_id, ip_address) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, activity.getUserId());
            stmt.setString(2, activity.getActivityType());
            stmt.setString(3, activity.getDescription());
            
            if (activity.getEntityType() != null) {
                stmt.setString(4, activity.getEntityType());
            } else {
                stmt.setNull(4, java.sql.Types.VARCHAR);
            }
            
            if (activity.getEntityId() != null) {
                stmt.setInt(5, activity.getEntityId());
            } else {
                stmt.setNull(5, java.sql.Types.INTEGER);
            }
            
            if (activity.getIpAddress() != null) {
                stmt.setString(6, activity.getIpAddress());
            } else {
                stmt.setNull(6, java.sql.Types.VARCHAR);
            }
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        }
    }
}
