package com.cleaninginventory.model;

import java.sql.Timestamp;

/**
 * Cleaner.java
 * Model (POJO) class representing a Cleaner record.
 * Part of: Cleaners Management Module (Team Member 4)
 */
public class Cleaner {

    private int cleanerId;
    private String firstName;
    private String lastName;
    private String contactNumber;
    private String email;
    private String department;   // optional field
    private String status;       // e.g. "Active" / "Inactive"
    private Timestamp dateAdded;

    // ---------- Constructors ----------

    public Cleaner() {
    }

    // Constructor for creating a new cleaner (no ID yet, no dateAdded yet)
    public Cleaner(String firstName, String lastName, String contactNumber,
                    String email, String department, String status) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.department = department;
        this.status = status;
    }

    // Full constructor (e.g. when reading a row back from the database)
    public Cleaner(int cleanerId, String firstName, String lastName, String contactNumber,
                    String email, String department, String status, Timestamp dateAdded) {
        this.cleanerId = cleanerId;
        this.firstName = firstName;
        this.lastName = lastName;
        this.contactNumber = contactNumber;
        this.email = email;
        this.department = department;
        this.status = status;
        this.dateAdded = dateAdded;
    }

    // ---------- Getters & Setters ----------

    public int getCleanerId() {
        return cleanerId;
    }

    public void setCleanerId(int cleanerId) {
        this.cleanerId = cleanerId;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getContactNumber() {
        return contactNumber;
    }

    public void setContactNumber(String contactNumber) {
        this.contactNumber = contactNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Timestamp dateAdded) {
        this.dateAdded = dateAdded;
    }

    // ---------- Convenience method ----------

    public String getFullName() {
        return firstName + " " + lastName;
    }

    @Override
    public String toString() {
        return "Cleaner{" +
                "cleanerId=" + cleanerId +
                ", fullName='" + getFullName() + '\'' +
                ", contactNumber='" + contactNumber + '\'' +
                ", email='" + email + '\'' +
                ", department='" + department + '\'' +
                ", status='" + status + '\'' +
                '}';
    }
}

