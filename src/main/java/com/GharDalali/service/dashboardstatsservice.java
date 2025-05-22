package com.GharDalali.service;

import com.GharDalali.model.Property;
import com.GharDalali.model.UserModel;
import com.GharDalali.model.propertyapplicationmodel;
import com.GharDalali.model.reviewmodel;

import java.math.BigDecimal;
import java.util.List;

public class dashboardstatsservice {

    public int calculateTotalUsers(List<UserModel> users) {
        return users != null ? users.size() : 0;
    }

    public String calculateUserGrowth(List<UserModel> users) {
        // Example: just return "+15%" as placeholder
        return "+15%";
    }

    public int calculateTotalProperties(List<Property> properties) {
        return properties != null ? properties.size() : 0;
    }

    public String calculatePropertyGrowth(List<Property> properties) {
        return "+8%";
    }

    public BigDecimal calculateTotalRevenue(List<Property> properties) {
        BigDecimal total = BigDecimal.ZERO;
        if (properties != null) {
            for (Property p : properties) {
                if (p.getPrice() != null) {
                    total = total.add(p.getPrice());
                }
            }
        }
        return total;
    }

    public int calculateTotalApplications(List<propertyapplicationmodel> applications) {
        return applications != null ? applications.size() : 0;
    }

    public String calculateApplicationGrowth(List<propertyapplicationmodel> applications) {
        return "-3%";
    }
    public int calculateTotalReviews(List<reviewmodel> reviews) {
        return reviews != null ? reviews.size() : 0;
    }

    public double calculateAverageRating(List<reviewmodel> reviews) {
        if (reviews == null || reviews.isEmpty()) return 0.0;
        double sum = 0;
        for (reviewmodel r : reviews) {
            sum += r.getRating();
        }
        return sum / reviews.size();
    }
}