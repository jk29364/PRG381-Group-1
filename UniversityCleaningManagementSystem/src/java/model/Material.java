package model;

/**
 * Material.java
 * Model (POJO) class representing a Material record.
 * Part of: Inventory management Module (Team Member 2)
 */
public class Material {
    
    //Variables
    private int materialId;
    private String materialName;
    private String category;
    private int quantity;
    private int reorderLevel;
    private int supplierId;
    
    //Default constructor
    public Material(){}
    
    //Constructor with parameters
    public Material(int materialId, String materialName, String category, int quantity, int reorderLevel, int supplierId) {
        this.materialId = materialId;
        this.materialName = materialName;
        this.category = category;
        this.quantity = quantity;
        this.reorderLevel = reorderLevel;
        this.supplierId = supplierId;
    }
    
    //Getters  
    public int getMaterialId() {
        return materialId;
    }

    public String getMaterialName() {
        return materialName;
    }

    public String getCategory() {
        return category;
    }

    public int getQuantity() {
        return quantity;
    }

    public int getReorderLevel() {
        return reorderLevel;
    }

    public int getSupplierId() {
        return supplierId;
    }
    
    //Setters
    public void setMaterialId(int materialTd) {
        this.materialId = materialTd;
    }

    public void setMaterialName(String materialName) {
        this.materialName = materialName;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setQuantity(int quantity) {
        //Prevents negative stock values
        if (quantity < 0)
        {
            this.quantity = 0;
        }else{      
            this.quantity = quantity;
        }
    }

    public void setReorderLevel(int reorderLevel) {
        //Prevents negative reOrder values
        if (reorderLevel < 0)
        {
            this.reorderLevel = 0;
        }else{      
            this.reorderLevel = reorderLevel;
        }
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }
    
    //Helper method
    public boolean isLowStock(){
       return quantity <= reorderLevel; 
    }
    
}
