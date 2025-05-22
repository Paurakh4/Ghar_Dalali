package com.GharDalali.service;

import com.GharDalali.config.DbConfig;
import com.GharDalali.model.UserModel;
import com.GharDalali.util.PasswordUtil;

import java.util.ArrayList;
import java.util.List;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


public class UserService {


    public void registerUser(UserModel user) throws SQLException, ClassNotFoundException, DuplicateUserException, RegistrationException {
        // Check for duplicates first
        if (doesUserExist(user.getUsername(), user.getEmail())) {
            throw new DuplicateUserException("Username or Email already registered.");
        }

        String hashedPassword = PasswordUtil.hashPassword(user.getPassword());

        String insertUserSql = "INSERT INTO users (username, contactNumber, email, password) VALUES (?, ?, ?, ?)";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement insertUserStmt = conn.prepareStatement(insertUserSql)) {

            insertUserStmt.setString(1, user.getUsername());
            insertUserStmt.setString(2, user.getContactNumber());
            insertUserStmt.setString(3, user.getEmail());
            insertUserStmt.setString(4, hashedPassword); // Store the hashed password

            int rowsAffected = insertUserStmt.executeUpdate();

            if (rowsAffected == 0) {
                throw new RegistrationException("User registration failed, no rows affected.");
            }
             System.out.println("UserService: User registered successfully: " + user.getUsername());

        } catch (SQLException e) {
            System.err.println("SQL Error during registration: " + e.getMessage());
            e.printStackTrace();
            throw new RegistrationException("Database error during registration.", e);
        }
    }


    public UserModel authenticateUser(String username, String submittedPassword) throws SQLException, ClassNotFoundException {
        UserModel user = null;
        String sql = "SELECT userid, password, role, email, contactNumber FROM users WHERE username = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, username);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    String storedHashedPassword = rs.getString("password");
                    String hashedSubmittedPassword = PasswordUtil.hashPassword(submittedPassword);

                    if (hashedSubmittedPassword.equals(storedHashedPassword)) {
                        // Passwords match! Populate the user model (without password)
                        user = new UserModel();
                        user.setUserid(rs.getInt("userid"));
                        user.setUsername(username);
                        user.setRole(rs.getString("role"));
                        user.setEmail(rs.getString("email"));
                        user.setContactNumber(rs.getString("contactNumber"));

                        System.out.println("UserService: User authenticated successfully: " + username);
                    } else {
                         System.out.println("UserService: Password mismatch for user: " + username);
                    }
                } else {
                     System.out.println("UserService: User not found: " + username);
                }
            }
        } catch (SQLException e) {
             System.err.println("SQL Error during authentication: " + e.getMessage());
             e.printStackTrace();
             throw e;
        }
        return user;
    }
    public UserModel getUserById(int userId) throws SQLException, ClassNotFoundException {
        UserModel user = null;
        String sql = "SELECT userid, username, email, contactNumber, role, status FROM users WHERE userid = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new UserModel();
                    user.setUserid(rs.getInt("userid"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setContactNumber(rs.getString("contactNumber"));
                    user.setRole(rs.getString("role"));
                    user.setStatus(rs.getString("status"));

                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching user by ID: " + e.getMessage());
            throw e;
        }

        return user;
    }

    /**
     * Finds a user by their username. Used for checks and potentially for auto-login via cookie.
     */
    public UserModel findUserByUsername(String username) throws SQLException, ClassNotFoundException {
         UserModel user = null;
         String sql = "SELECT userid, role, email, contactNumber, address, bio FROM users WHERE username = ?";

         try (Connection conn = DbConfig.getDbConnection();
              PreparedStatement pstmt = conn.prepareStatement(sql)) {

             pstmt.setString(1, username);
             try (ResultSet rs = pstmt.executeQuery()) {
                 if (rs.next()) {
                     user = new UserModel();
                     user.setUserid(rs.getInt("userid"));
                     user.setUsername(username);
                     user.setRole(rs.getString("role"));
                     user.setEmail(rs.getString("email"));
                     user.setContactNumber(rs.getString("contactNumber"));
                     user.setAddress(rs.getString("address"));
                     user.setBio(rs.getString("bio"));
                 }
             }
         } catch (SQLException e) {
             System.err.println("SQL Error finding user by username: " + e.getMessage());
             e.printStackTrace();
             throw e; // Re-throw SQL exception
         }
         // ClassNotFoundException from DbConfig is propagated

         return user;
    }


    /**
     * Checks if a user exists based on username or email.
     * Used internally by registerUser to check for duplicates.
     */
    private boolean doesUserExist(String username, String email) throws SQLException, ClassNotFoundException {
        String checkUserSql = "SELECT userid FROM users WHERE username = ? OR email = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement checkUserStmt = conn.prepareStatement(checkUserSql)) {

            checkUserStmt.setString(1, username);
            checkUserStmt.setString(2, email);
            try (ResultSet rs = checkUserStmt.executeQuery()) {
                return rs.next(); // Returns true if a row is found
            }
        }
    }

    /**
     * Updates the password for a given username.
     * Hashes the new password before storing.
     */
    public boolean updatePassword(String username, String newPassword) throws SQLException, ClassNotFoundException {
        // Hash the new password
        String hashedNewPassword = PasswordUtil.hashPassword(newPassword);

        String updateUserSql = "UPDATE users SET password = ? WHERE username = ?";
        int rowsAffected = 0;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement updateUserStmt = conn.prepareStatement(updateUserSql)) {

            updateUserStmt.setString(1, hashedNewPassword);
            updateUserStmt.setString(2, username);

            rowsAffected = updateUserStmt.executeUpdate();

            if (rowsAffected > 0) {
                 System.out.println("Password updated successfully for user: " + username);
            } else {
                 System.out.println("User not found during password update attempt: " + username);
            }

        } catch (SQLException e) {
            System.err.println("SQL Error during password update: " + e.getMessage());
            e.printStackTrace();
            throw e;
        }

        return rowsAffected > 0;
    }
    public boolean updateUserProfile(UserModel user) throws SQLException, ClassNotFoundException {
        // Ensure we have a user ID to update the correct record
        if (user == null || user.getUserid() <= 0) {
            System.err.println("UserService: Attempted to update profile with invalid user object or ID.");
            return false;
        }

        // Select columns available in 'users' table (based on image_db136d.png)
        String updateUserSql = "UPDATE users SET contactNumber = ?, email = ?, address = ?, bio = ?, profilePicture = ? WHERE userid = ?";
        int rowsAffected = 0;

        //System.out.println("UserService: Attempting to update profile for userid: " + user.getUserid()); // Debug

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement updateUserStmt = conn.prepareStatement(updateUserSql)) {


            updateUserStmt.setString(1, user.getContactNumber());
            updateUserStmt.setString(2, user.getEmail());
            updateUserStmt.setString(3, user.getAddress());
            updateUserStmt.setString(4, user.getBio());
            updateUserStmt.setString(5, user.getProfilePicture());
            updateUserStmt.setInt(6, user.getUserid());

            rowsAffected = updateUserStmt.executeUpdate();

            if (rowsAffected > 0) {
                 System.out.println(" Profile updated successfully for userid: " + user.getUserid());
            } else {
                 System.out.println(" User not found during profile update attempt for userid: " + user.getUserid());
            }

        } catch (SQLException e) {
            System.err.println("SQL Error during profile update for userid " + user.getUserid() + ": " + e.getMessage());
            e.printStackTrace();
            throw e;
        }
        return rowsAffected > 0;
    }
    public static class DuplicateUserException extends Exception {
        private static final long serialVersionUID = 1L;
        public DuplicateUserException(String message) {
            super(message);
        }
    }

    public static class RegistrationException extends Exception {
         private static final long serialVersionUID = 1L;
        public RegistrationException(String message) {
            super(message);
        }
        public RegistrationException(String message, Throwable cause) {
            super(message, cause);
        }
    }
    public List<UserModel> getAllUsers() throws SQLException, ClassNotFoundException {
        List<UserModel> users = new ArrayList<>();
        String sql = "SELECT userid, username, email, role, status FROM users";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                UserModel user = new UserModel();
                user.setUserid(rs.getInt("userid"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getString("status"));
                users.add(user);
            }
        }
        return users;
    }
    public boolean updateUserAdmin(UserModel user) throws SQLException, ClassNotFoundException {
        if (user == null || user.getUserid() <= 0) {
            System.err.println("Invalid user data for update.");
            return false;
        }

        String updateSql = "UPDATE users SET username = ?, email = ?, contactNumber = ?, role = ?, status = ? WHERE userid = ?";
        int rowsAffected = 0;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(updateSql)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getContactNumber());
            stmt.setString(4, user.getRole());
            stmt.setString(5, user.getStatus());
            stmt.setInt(6, user.getUserid());

            rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Admin updated user successfully: " + user.getUsername());
            } else {
                System.out.println("No user found with ID: " + user.getUserid());
            }

        } catch (SQLException e) {
            System.err.println("SQL Error while updating user: " + e.getMessage());
            throw e;
        }

        return rowsAffected > 0;
    }
    public static boolean deleteUser(int userId) {
        boolean success = false;
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement("DELETE FROM users WHERE userid = ?")) {
            stmt.setInt(1, userId);
            int affectedRows = stmt.executeUpdate();
            success = affectedRows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
    public boolean applyForProperty(int userId, int propertyId) throws SQLException, ClassNotFoundException {
        try (Connection conn = DbConfig.getDbConnection()) {
            // Get user details to populate the property_applications table
            UserModel user = getUserById(userId);
            if (user == null) {
                System.err.println("User not found with ID: " + userId);
                return false;
            }

            String sql = "INSERT INTO property_applications (property_id, userid, full_name, email, phone, message, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, 'PENDING')";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, propertyId);
            stmt.setInt(2, userId);
            stmt.setString(3, user.getUsername()); // Using username as full name
            stmt.setString(4, user.getEmail());
            stmt.setString(5, user.getContactNumber());
            stmt.setString(6, "Application submitted via user profile"); // Default message

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error applying for property: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
