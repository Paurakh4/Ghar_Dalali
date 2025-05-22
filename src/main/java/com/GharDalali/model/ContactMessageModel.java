package com.GharDalali.model;

import java.sql.Timestamp;

/**
 * Model class representing a contact message in the system.
 */
public class ContactMessageModel {
    private int messageId;
    private Integer userId; // Can be null for anonymous messages
    private String name;
    private String email;
    private String phone;
    private String subject;
    private String message;
    private Timestamp submittedAt;
    private boolean isRead;

    // Default constructor
    public ContactMessageModel() {
    }

    // Constructor with all fields except messageId (for new messages)
    public ContactMessageModel(Integer userId, String name, String email, String phone, 
                              String subject, String message) {
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
        this.message = message;
        this.isRead = false;
    }

    // Getters and Setters
    public int getMessageId() {
        return messageId;
    }

    public void setMessageId(int messageId) {
        this.messageId = messageId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(Timestamp submittedAt) {
        this.submittedAt = submittedAt;
    }

    public boolean isRead() {
        return isRead;
    }

    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }

    @Override
    public String toString() {
        return "ContactMessageModel{" +
                "messageId=" + messageId +
                ", userId=" + userId +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", subject='" + subject + '\'' +
                ", message='" + message + '\'' +
                ", submittedAt=" + submittedAt +
                ", isRead=" + isRead +
                '}';
    }
}
