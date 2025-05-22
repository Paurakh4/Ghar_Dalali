package com.GharDalali.service;

import com.GharDalali.config.DbConfig;
import com.GharDalali.model.ContactMessageModel;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Service class for handling contact message operations.
 */
public class ContactMessageService {

    /**
     * Saves a new contact message to the database.
     *
     * @param contactMessage The contact message to save
     * @return true if the message was saved successfully, false otherwise
     * @throws SQLException If a database error occurs
     * @throws ClassNotFoundException If the database driver class is not found
     */
    public boolean saveContactMessage(ContactMessageModel contactMessage) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO contact_messages (user_id, name, email, phone, subject, message) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            // Set parameters
            if (contactMessage.getUserId() != null) {
                stmt.setInt(1, contactMessage.getUserId());
            } else {
                stmt.setNull(1, java.sql.Types.INTEGER);
            }
            stmt.setString(2, contactMessage.getName());
            stmt.setString(3, contactMessage.getEmail());
            stmt.setString(4, contactMessage.getPhone());
            stmt.setString(5, contactMessage.getSubject());
            stmt.setString(6, contactMessage.getMessage());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                // Get the generated message ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        contactMessage.setMessageId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        }
        
        return false;
    }
    
    /**
     * Retrieves all contact messages from the database.
     *
     * @return A list of all contact messages
     * @throws SQLException If a database error occurs
     * @throws ClassNotFoundException If the database driver class is not found
     */
    public List<ContactMessageModel> getAllContactMessages() throws SQLException, ClassNotFoundException {
        List<ContactMessageModel> messages = new ArrayList<>();
        String sql = "SELECT * FROM contact_messages ORDER BY submitted_at DESC";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                ContactMessageModel message = new ContactMessageModel();
                message.setMessageId(rs.getInt("message_id"));
                
                // Handle nullable user_id
                int userId = rs.getInt("user_id");
                if (!rs.wasNull()) {
                    message.setUserId(userId);
                }
                
                message.setName(rs.getString("name"));
                message.setEmail(rs.getString("email"));
                message.setPhone(rs.getString("phone"));
                message.setSubject(rs.getString("subject"));
                message.setMessage(rs.getString("message"));
                message.setSubmittedAt(rs.getTimestamp("submitted_at"));
                message.setRead(rs.getBoolean("is_read"));
                
                messages.add(message);
            }
        }
        
        return messages;
    }
    
    /**
     * Marks a contact message as read.
     *
     * @param messageId The ID of the message to mark as read
     * @return true if the message was updated successfully, false otherwise
     * @throws SQLException If a database error occurs
     * @throws ClassNotFoundException If the database driver class is not found
     */
    public boolean markMessageAsRead(int messageId) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE contact_messages SET is_read = 1 WHERE message_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, messageId);
            int rowsAffected = stmt.executeUpdate();
            
            return rowsAffected > 0;
        }
    }
}
