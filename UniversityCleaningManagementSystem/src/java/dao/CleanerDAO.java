package com.cleaninginventory.dao;

import com.cleaninginventory.model.Cleaner;
import com.cleaninginventory.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * CleanerDAO.java
 * Data Access Object for the Cleaners table.
 * Handles all CRUD operations and search/filter queries for cleaners.
 * Part of: Cleaners Management Module (Team Member 4)
 *
 * NOTE: This assumes a shared DBUtil.getConnection() utility class exists
 * in the project (com.cleaninginventory.util.DBUtil), returning a live
 * java.sql.Connection. Update the package/import to match whatever your
 * team's shared DB connection class is actually called.
 *
 * Expected table structure (adjust column names to match your schema):
 *
 * CREATE TABLE cleaners (
 *     cleaner_id      INT AUTO_INCREMENT PRIMARY KEY,
 *     first_name      VARCHAR(50)  NOT NULL,
 *     last_name       VARCHAR(50)  NOT NULL,
 *     contact_number  VARCHAR(20),
 *     email           VARCHAR(100),
 *     department      VARCHAR(50),
 *     status          VARCHAR(20)  DEFAULT 'Active',
 *     date_added      TIMESTAMP    DEFAULT CURRENT_TIMESTAMP
 * );
 */
public class CleanerDAO {

    // ---------- CREATE ----------

    public boolean addCleaner(Cleaner cleaner) {
        String sql = "INSERT INTO cleaners (first_name, last_name, contact_number, email, department, status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cleaner.getFirstName());
            stmt.setString(2, cleaner.getLastName());
            stmt.setString(3, cleaner.getContactNumber());
            stmt.setString(4, cleaner.getEmail());
            stmt.setString(5, cleaner.getDepartment());
            stmt.setString(6, cleaner.getStatus() != null ? cleaner.getStatus() : "Active");

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------- READ ----------

    public Cleaner getCleanerById(int cleanerId) {
        String sql = "SELECT * FROM cleaners WHERE cleaner_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cleanerId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapRowToCleaner(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Cleaner> getAllCleaners() {
        List<Cleaner> cleaners = new ArrayList<>();
        String sql = "SELECT * FROM cleaners ORDER BY last_name, first_name";

        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                cleaners.add(mapRowToCleaner(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cleaners;
    }

    // Search by name, and/or filter by department and/or status.
    // Pass null (or empty string) for any filter you don't want applied.
    public List<Cleaner> searchCleaners(String keyword, String department, String status) {
        List<Cleaner> cleaners = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT * FROM cleaners WHERE 1=1");

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (first_name LIKE ? OR last_name LIKE ? OR email LIKE ?)");
        }
        if (department != null && !department.trim().isEmpty()) {
            sql.append(" AND department = ?");
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND status = ?");
        }
        sql.append(" ORDER BY last_name, first_name");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (keyword != null && !keyword.trim().isEmpty()) {
                String likeKeyword = "%" + keyword.trim() + "%";
                stmt.setString(paramIndex++, likeKeyword);
                stmt.setString(paramIndex++, likeKeyword);
                stmt.setString(paramIndex++, likeKeyword);
            }
            if (department != null && !department.trim().isEmpty()) {
                stmt.setString(paramIndex++, department);
            }
            if (status != null && !status.trim().isEmpty()) {
                stmt.setString(paramIndex, status);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    cleaners.add(mapRowToCleaner(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cleaners;
    }

    // ---------- UPDATE ----------

    public boolean updateCleaner(Cleaner cleaner) {
        String sql = "UPDATE cleaners SET first_name = ?, last_name = ?, contact_number = ?, "
                + "email = ?, department = ?, status = ? WHERE cleaner_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cleaner.getFirstName());
            stmt.setString(2, cleaner.getLastName());
            stmt.setString(3, cleaner.getContactNumber());
            stmt.setString(4, cleaner.getEmail());
            stmt.setString(5, cleaner.getDepartment());
            stmt.setString(6, cleaner.getStatus());
            stmt.setInt(7, cleaner.getCleanerId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------- DELETE ----------

    public boolean deleteCleaner(int cleanerId) {
        String sql = "DELETE FROM cleaners WHERE cleaner_id = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cleanerId);
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ---------- Helper ----------

    private Cleaner mapRowToCleaner(ResultSet rs) throws SQLException {
        return new Cleaner(
                rs.getInt("cleaner_id"),
                rs.getString("first_name"),
                rs.getString("last_name"),
                rs.getString("contact_number"),
                rs.getString("email"),
                rs.getString("department"),
                rs.getString("status"),
                rs.getTimestamp("date_added")
        );
    }
}

