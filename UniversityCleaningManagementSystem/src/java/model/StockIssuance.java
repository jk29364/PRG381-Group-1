package model;

import java.sql.Timestamp;

/**
 * StockIssuance.java
 * Model (POJO) class representing a Stock Issuance record.
 * Part of: Stock Issuance Module
 *
 * A Stock Issuance links a Material to the Cleaner it was issued to,
 * along with how much was issued and when.
 */
public class StockIssuance {

    //Variables
    private int issuanceId;
    private int materialId;
    private int cleanerId;
    private int quantityIssued;
    private Timestamp issueDate;
    private String issuedBy;

    //Display-only fields, populated by the DAO via a JOIN with
    //Materials/cleaners. These are never written back to the database -
    //they just save the JSP from having to look the names up itself.
    private String materialName;
    private String cleanerName;

    //Default constructor
    public StockIssuance() {
    }

    //Constructor for creating a new issuance (no ID/date yet - the
    //database generates issuanceId, and issueDate defaults to "now").
    public StockIssuance(int materialId, int cleanerId, int quantityIssued, String issuedBy) {
        this.materialId = materialId;
        this.cleanerId = cleanerId;
        this.quantityIssued = quantityIssued;
        this.issuedBy = issuedBy;
    }

    //Full constructor (e.g. when reading a row back from the database)
    public StockIssuance(int issuanceId, int materialId, int cleanerId, int quantityIssued,
                          Timestamp issueDate, String issuedBy) {
        this.issuanceId = issuanceId;
        this.materialId = materialId;
        this.cleanerId = cleanerId;
        this.quantityIssued = quantityIssued;
        this.issueDate = issueDate;
        this.issuedBy = issuedBy;
    }

    //Getters
    public int getIssuanceId() {
        return issuanceId;
    }

    public int getMaterialId() {
        return materialId;
    }

    public int getCleanerId() {
        return cleanerId;
    }

    public int getQuantityIssued() {
        return quantityIssued;
    }

    public Timestamp getIssueDate() {
        return issueDate;
    }

    public String getIssuedBy() {
        return issuedBy;
    }

    public String getMaterialName() {
        return materialName;
    }

    public String getCleanerName() {
        return cleanerName;
    }

    //Setters
    public void setIssuanceId(int issuanceId) {
        this.issuanceId = issuanceId;
    }

    public void setMaterialId(int materialId) {
        this.materialId = materialId;
    }

    public void setCleanerId(int cleanerId) {
        this.cleanerId = cleanerId;
    }

    public void setQuantityIssued(int quantityIssued) {
        //Prevents negative/zero issuance quantities
        if (quantityIssued < 0) {
            this.quantityIssued = 0;
        } else {
            this.quantityIssued = quantityIssued;
        }
    }

    public void setIssueDate(Timestamp issueDate) {
        this.issueDate = issueDate;
    }

    public void setIssuedBy(String issuedBy) {
        this.issuedBy = issuedBy;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public void setCleanerName(String cleanerName) {
        this.cleanerName = cleanerName;
    }

    //Helper method - business rule check used before hitting the database
    public boolean isValidQuantity() {
        return quantityIssued > 0;
    }

}
