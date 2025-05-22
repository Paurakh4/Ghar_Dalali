package com.GharDalali.controller;

import com.GharDalali.config.DbConfig;
import com.GharDalali.model.UserModel;
import com.GharDalali.model.propertyapplicationmodel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;

/**
 * Servlet that handles application tracking functionality.
 * Provides endpoints for getting application counts and lists for the current user.
 */
@WebServlet(urlPatterns = {"/application-tracking/count", "/application-tracking/list"})
public class ApplicationTrackingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"User not logged in\"}");
            return;
        }

        UserModel user = (UserModel) session.getAttribute("loggedInUser");
        int userId = user.getUserid();

        // Determine which endpoint was requested
        String pathInfo = request.getServletPath();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            if (pathInfo.endsWith("/count")) {
                // Handle count request
                int count = getApplicationCount(userId);
                String jsonResponse = "{\"count\": " + count + "}";
                response.getWriter().write(jsonResponse);
            } else if (pathInfo.endsWith("/list")) {
                // Handle list request
                List<propertyapplicationmodel> applications = getApplicationList(userId);
                StringBuilder jsonBuilder = new StringBuilder("[");
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                for (int i = 0; i < applications.size(); i++) {
                    propertyapplicationmodel app = applications.get(i);
                    if (i > 0) {
                        jsonBuilder.append(",");
                    }

                    jsonBuilder.append("{");
                    jsonBuilder.append("\"applicationId\":").append(app.getApplicationId()).append(",");
                    jsonBuilder.append("\"propertyId\":").append(app.getPropertyId()).append(",");
                    jsonBuilder.append("\"propertyTitle\":\"").append(escapeJson(app.getPropertyTitle())).append("\",");
                    jsonBuilder.append("\"propertyLocation\":\"").append(escapeJson(app.getPropertyLocation())).append("\",");
                    jsonBuilder.append("\"status\":\"").append(escapeJson(app.getStatus())).append("\",");
                    jsonBuilder.append("\"createdAt\":\"").append(app.getCreatedAt() != null ? dateFormat.format(app.getCreatedAt()) : "").append("\",");
                    jsonBuilder.append("\"updatedAt\":\"").append(app.getUpdatedAt() != null ? dateFormat.format(app.getUpdatedAt()) : "").append("\"");
                    jsonBuilder.append("}");
                }

                jsonBuilder.append("]");
                response.getWriter().write(jsonBuilder.toString());
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Endpoint not found\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    /**
     * Gets the count of applications for a specific user
     *
     * @param userId The user ID to get the count for
     * @return The count of applications
     */
    private int getApplicationCount(int userId) throws SQLException, ClassNotFoundException {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM property_applications WHERE userid = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        }

        return count;
    }

    /**
     * Gets the list of applications for a specific user
     *
     * @param userId The user ID to get applications for
     * @return List of application models
     */
    private List<propertyapplicationmodel> getApplicationList(int userId) throws SQLException, ClassNotFoundException {
        List<propertyapplicationmodel> applications = new ArrayList<>();

        String sql = "SELECT a.*, p.property_name AS propertyTitle, p.location AS propertyLocation " +
                     "FROM property_applications a " +
                     "JOIN properties p ON a.property_id = p.property_id " +
                     "WHERE a.userid = ? " +
                     "ORDER BY a.created_at DESC";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    propertyapplicationmodel app = new propertyapplicationmodel();
                    app.setApplicationId(rs.getInt("application_id"));
                    app.setPropertyId(rs.getInt("property_id"));
                    app.setUserId(rs.getInt("userid"));
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
        }

        return applications;
    }

    /**
     * Escapes special characters in a string for JSON output
     *
     * @param input The string to escape
     * @return The escaped string
     */
    private String escapeJson(String input) {
        if (input == null) {
            return "";
        }

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < input.length(); i++) {
            char ch = input.charAt(i);
            switch (ch) {
                case '\"':
                    result.append("\\\"");
                    break;
                case '\\':
                    result.append("\\\\");
                    break;
                case '\b':
                    result.append("\\b");
                    break;
                case '\f':
                    result.append("\\f");
                    break;
                case '\n':
                    result.append("\\n");
                    break;
                case '\r':
                    result.append("\\r");
                    break;
                case '\t':
                    result.append("\\t");
                    break;
                default:
                    // Check for other control characters
                    if (ch < ' ') {
                        String hex = Integer.toHexString(ch);
                        result.append("\\u");
                        for (int j = 0; j < 4 - hex.length(); j++) {
                            result.append('0');
                        }
                        result.append(hex);
                    } else {
                        result.append(ch);
                    }
            }
        }
        return result.toString();
    }
}
