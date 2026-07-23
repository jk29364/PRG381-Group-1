package dao;

import model.StockIssuance;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/*
 * ===========================================================
 * StockIssuanceDAO.java
 * -----------------------------------------------------------
 * Data Access Object (DAO) for the StockIssuance table.
 *
 * Responsibilities:
 * - Issue stock to a cleaner
 * - Reduce inventory automatically when stock is issued
 * - Prevent issuing unavailable stock (business rule validation)
 * - Maintain issuance history
 *
 * Issuing stock touches two tables (Materials and StockIssuance),
 * so issueStock() runs both writes inside a single database
 * transaction: either both succeed, or neither does. This avoids
 * ever recording an issuance without actually deducting the stock
 * (or the reverse).
 * ===========================================================
 */
public class StockIssuanceDAO {

    //Issue Stock
    //Returns true only if the material exists, enough stock is available,
    //and both the inventory update and the history record are written
    //successfully. Returns false (and rolls back) otherwise.
    public boolean issueStock(StockIssuance issuance) {

        //Business rule: can't issue zero or a negative amount
        if (!issuance.isValidQuantity()) {
            return false;
        }

        String checkStockSql = "SELECT quantity FROM Materials WHERE materialId = ? FOR UPDATE";
        String reduceStockSql = "UPDATE Materials SET quantity = quantity - ? WHERE materialId = ?";
        String insertIssuanceSql = "INSERT INTO StockIssuance "
                + "(materialId, cleanerId, quantityIssued, issuedBy) "
                + "VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {

            conn.setAutoCommit(false);

            try {
                int availableQuantity;

                //Lock the material row and read the current quantity so two
                //concurrent issuances can't both pass the stock check.
                try (PreparedStatement checkPs = conn.prepareStatement(checkStockSql)) {
                    checkPs.setInt(1, issuance.getMaterialId());

                    try (ResultSet rs = checkPs.executeQuery()) {
                        if (!rs.next()) {
                            //Material doesn't exist
                            conn.rollback();
                            return false;
                        }
                        availableQuantity = rs.getInt("quantity");
                    }
                }

                //Business rule: prevent issuing more stock than is available
                if (availableQuantity < issuance.getQuantityIssued()) {
                    conn.rollback();
                    return false;
                }

                //Reduce inventory automatically
                try (PreparedStatement reducePs = conn.prepareStatement(reduceStockSql)) {
                    reducePs.setInt(1, issuance.getQuantityIssued());
                    reducePs.setInt(2, issuance.getMaterialId());

                    if (reducePs.executeUpdate() == 0) {
                        conn.rollback();
                        return false;
                    }
                }

                //Record the issuance in the history table
                try (PreparedStatement insertPs = conn.prepareStatement(insertIssuanceSql)) {
                    insertPs.setInt(1, issuance.getMaterialId());
                    insertPs.setInt(2, issuance.getCleanerId());
                    insertPs.setInt(3, issuance.getQuantityIssued());
                    insertPs.setString(4, issuance.getIssuedBy());

                    if (insertPs.executeUpdate() == 0) {
                        conn.rollback();
                        return false;
                    }
                }

                conn.commit();
                return true;

            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    //View all issuance history, most recent first.
    //Joins Materials and cleaners so the JSP can show names instead of
    //having to look up IDs itself.
    public List<StockIssuance> getAllIssuances() {

        List<StockIssuance> list = new ArrayList<>();

        String sql = "SELECT si.issuanceId, si.materialId, si.cleanerId, si.quantityIssued, "
                + "si.issueDate, si.issuedBy, m.materialName, "
                + "c.first_name, c.last_name "
                + "FROM StockIssuance si "
                + "JOIN Materials m ON si.materialId = m.materialId "
                + "JOIN cleaners c ON si.cleanerId = c.cleaner_id "
                + "ORDER BY si.issueDate DESC";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapRowToIssuance(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    //Get a single issuance record by ID
    public StockIssuance getIssuanceById(int id) {

        String sql = "SELECT si.issuanceId, si.materialId, si.cleanerId, si.quantityIssued, "
                + "si.issueDate, si.issuedBy, m.materialName, "
                + "c.first_name, c.last_name "
                + "FROM StockIssuance si "
                + "JOIN Materials m ON si.materialId = m.materialId "
                + "JOIN cleaners c ON si.cleanerId = c.cleaner_id "
                + "WHERE si.issuanceId = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToIssuance(rs);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    //Issuance history for a specific material
    public List<StockIssuance> getIssuancesByMaterial(int materialId) {

        List<StockIssuance> list = new ArrayList<>();

        String sql = "SELECT si.issuanceId, si.materialId, si.cleanerId, si.quantityIssued, "
                + "si.issueDate, si.issuedBy, m.materialName, "
                + "c.first_name, c.last_name "
                + "FROM StockIssuance si "
                + "JOIN Materials m ON si.materialId = m.materialId "
                + "JOIN cleaners c ON si.cleanerId = c.cleaner_id "
                + "WHERE si.materialId = ? "
                + "ORDER BY si.issueDate DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, materialId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToIssuance(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    //Issuance history for a specific cleaner
    public List<StockIssuance> getIssuancesByCleaner(int cleanerId) {

        List<StockIssuance> list = new ArrayList<>();

        String sql = "SELECT si.issuanceId, si.materialId, si.cleanerId, si.quantityIssued, "
                + "si.issueDate, si.issuedBy, m.materialName, "
                + "c.first_name, c.last_name "
                + "FROM StockIssuance si "
                + "JOIN Materials m ON si.materialId = m.materialId "
                + "JOIN cleaners c ON si.cleanerId = c.cleaner_id "
                + "WHERE si.cleanerId = ? "
                + "ORDER BY si.issueDate DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, cleanerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRowToIssuance(rs));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    //Helper - maps one joined result row to a StockIssuance object
    private StockIssuance mapRowToIssuance(ResultSet rs) throws SQLException {

        StockIssuance issuance = new StockIssuance();

        issuance.setIssuanceId(rs.getInt("issuanceId"));
        issuance.setMaterialId(rs.getInt("materialId"));
        issuance.setCleanerId(rs.getInt("cleanerId"));
        issuance.setQuantityIssued(rs.getInt("quantityIssued"));
        issuance.setIssueDate(rs.getTimestamp("issueDate"));
        issuance.setIssuedBy(rs.getString("issuedBy"));
        issuance.setMaterialName(rs.getString("materialName"));
        issuance.setCleanerName(rs.getString("first_name") + " " + rs.getString("last_name"));

        return issuance;
    }

}
