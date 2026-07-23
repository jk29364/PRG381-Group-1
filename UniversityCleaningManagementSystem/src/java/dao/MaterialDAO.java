
package dao;

import model.Material;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
       
/*
 * ===========================================================
 * MaterialDAO.java
 * -----------------------------------------------------------
 * Data Access Object (DAO) for the Materials table.
 *
 * Responsibilities:
 * - Add Material
 * - View All Materials
 * - Update Material
 * - Delete Material
 * - Search Materials
 * - Filter Materials
 * - View Low Stock Materials
 *
 * This class communicates directly with the database
 * using JDBC.
 * ===========================================================
 */
public class MaterialDAO {
    
    //Database Connection
    private Connection conn;
    
    public MaterialDAO(){
        try{
            conn = DBConnection.getConnection();
        }catch (Exception e){
            e.printStackTrace();
        }
    }
    
    //Add Material
    public boolean addMaterial(Material material){
        String sql = "INSERT INTO Materials"
                   + "(materialName, category, quantity, reorderLevel, supplierId)"
                   + "VALUES (?, ?, ?, ?, ?)" ;
        
        try{
            
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, material.getMaterialName());
            ps.setString(2, material.getCategory());
            ps.setInt(3, material.getQuantity());
            ps.setInt(4, material.getReorderLevel());
            ps.setInt(5, material.getSupplierId());
            
            return ps.executeUpdate() > 0;
           
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }
    
    //View all Materials
    public List<Material> getAllMaterials(){
        
        List<Material> list = new ArrayList<>();
        
        String sql = "SELECT * FROM Materials ORDER BY materialName";
        
        try{
            
            Statement stmt = conn.createStatement();
            
            ResultSet rs = stmt.executeQuery(sql);
           
            while (rs.next()){
                Material material = new Material();
                
                material.setMaterialId(rs.getInt("materialId"));
                material.setMaterialName(rs.getString("materialName"));
                material.setCategory(rs.getString("category"));
                material.setQuantity(rs.getInt("quantity"));
                material.setReorderLevel(rs.getInt("reorderLevel"));
                material.setSupplierId(rs.getInt("supplierID"));
                
                list.add(material);
                
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    //Get Material by ID
    public Material getMaterialById(int id){
  
        String sql = "SELECT * FROM Materials WHERE materialId = ?";
        
        try{
            
            PreparedStatement ps = conn.prepareStatement(sql);            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()){
                Material material = new Material();
                
                material.setMaterialId(rs.getInt("materialId"));
                material.setMaterialName(rs.getString("materialName"));
                material.setCategory(rs.getString("category"));
                material.setQuantity(rs.getInt("quantity"));
                material.setReorderLevel(rs.getInt("reorderLevel"));
                material.setSupplierId(rs.getInt("supplierID"));
                
                return material;
                
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        
        return null;
    }
    
    //Update Material
    public boolean updateMaterial(Material material){
        String sql = "UPDATE Materials SET "
                    + "materialName = ?, "
                    + "category = ?, "
                    + "quantity = ?, "
                    + "reorderLevel = ?, "
                    + "supplierId = ? "
                    + "WHERE materialId = ?";
        
        try{
            
            PreparedStatement ps = conn.prepareStatement(sql);
            
            ps.setString(1, material.getMaterialName());
            ps.setString(2, material.getCategory());
            ps.setInt(3, material.getQuantity());
            ps.setInt(4, material.getReorderLevel());
            ps.setInt(5, material.getSupplierId());
            ps.setInt(6, material.getMaterialId());
            
            return ps.executeUpdate() > 0;
           
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }
    
    //Delete Material
    public boolean deleteMaterial(int id){
        String sql = "DELETE FROM Materials WHERE materialId=?";
        
        try{
            
            PreparedStatement ps = conn.prepareStatement(sql);
 
            ps.setInt(1, id);
            
            return ps.executeUpdate() > 0;
           
        }catch (SQLException e){
            e.printStackTrace();
        }
        return false;
    }
    
    //Search Material
    public List<Material> searchMaterials(String keyword){
        
        List<Material> list = new ArrayList<>();
        
        String sql = "SELECT * FROM Materials WHERE materialName LIKE ?";
        
        try{
            
            PreparedStatement ps = conn.prepareStatement(sql);
 
            ps.setString(1, "%"+ keyword +"%");
            
            ResultSet rs = ps.executeQuery();
           
            while (rs.next()){
                Material material = new Material();
                
                material.setMaterialId(rs.getInt("materialId"));
                material.setMaterialName(rs.getString("materialName"));
                material.setCategory(rs.getString("category"));
                material.setQuantity(rs.getInt("quantity"));
                material.setReorderLevel(rs.getInt("reorderLevel"));
                material.setSupplierId(rs.getInt("supplierID"));
                
                list.add(material);
                
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    //Filter by category
    public List<Material> filterByCategory(String category){
        
        List<Material> list = new ArrayList<>();
        
        String sql = "SELECT * FROM Materials WHERE category = ?";
        
        try{
            
            PreparedStatement ps = conn.prepareStatement(sql);
 
            ps.setString(1, category);
            
            ResultSet rs = ps.executeQuery();
           
            while (rs.next()){
                Material material = new Material();
                
                material.setMaterialId(rs.getInt("materialId"));
                material.setMaterialName(rs.getString("materialName"));
                material.setCategory(rs.getString("category"));
                material.setQuantity(rs.getInt("quantity"));
                material.setReorderLevel(rs.getInt("reorderLevel"));
                material.setSupplierId(rs.getInt("supplierID"));
                
                list.add(material);
                
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    
    //Low Stock report
    public List<Material> getLowStockMaterials(){
        
        List<Material> list = new ArrayList<>();
        
        String sql = "SELECT * FROM Materials WHERE quantity <= reorderLevel";
        
        try{
            
            Statement stmt = conn.createStatement();
            
            ResultSet rs = stmt.executeQuery(sql);
           
            while (rs.next()){
                Material material = new Material();
                
                material.setMaterialId(rs.getInt("materialId"));
                material.setMaterialName(rs.getString("materialName"));
                material.setCategory(rs.getString("category"));
                material.setQuantity(rs.getInt("quantity"));
                material.setReorderLevel(rs.getInt("reorderLevel"));
                material.setSupplierId(rs.getInt("supplierID"));
                
                list.add(material);
                
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
        
        return list;
    }
    
}

