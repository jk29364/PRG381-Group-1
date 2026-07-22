package controller;

import dao.MaterialDAO;
import model.Material;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

/*
 * ==========================================================
 * MaterialServlet.java
 * ----------------------------------------------------------
 * Handles all requests relating to Materials.
 *
 * Functions:
 * - List Materials
 * - Add Material
 * - Edit Material
 * - Update Material
 * - Delete Material
 * - Search Material
 * ==========================================================
 */

@WebServlet("/MaterialServlet")
public class MaterialServlet extends HttpServlet {
    private MaterialDAO materialDAO;
    
    //Initialise DAO when servlet starts.
    @Override
    public void init(){
        materialDAO = new MaterialDAO();
    }
    
    //Handles GET requests
    @Override
    protected void doGet(HttpServletRequest request, 
                         HttpServletResponse response) throws ServletException, IOException{
        
        String action = request.getParameter("action");
        
        if (action == null){
            action = "list";
        }
        
        switch (action){
            case "delete" -> deleteMaterial(request, response);
            case "edit" -> showEditForm(request, response);
            case "search" -> searchMaterial(request, response);
            default -> listMaterials(request, response);    
        }
    }
    
    //Handles POST requests
    @Override
    protected void doPost(HttpServletRequest request, 
                         HttpServletResponse response) throws ServletException, IOException{
        
        String action = request.getParameter("action");
        
        if ("add".equals(action)){
            addMaterial(request, response);
        } else if ("update".equals(action)){
            updateMaterial(request, response);
        }
    }
    
    //Add Material
    private void addMaterial(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        String name = request.getParameter("materialName");
        String category = request.getParameter("category");
        
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int reorderLevel = Integer.parseInt(request.getParameter("reorderLevel"));
        int supplierId = Integer.parseInt(request.getParameter("supplierId"));
        
        //Prevents negative stock values
        if (quantity < 0) {
            quantity = 0;
        }
        
        Material material = new Material();
        
        material.setMaterialName(name);
        material.setCategory(category);
        material.setQuantity(quantity);
        material.setReorderLevel(reorderLevel);
        material.setSupplierId(supplierId);
        
        materialDAO.addMaterial(material);
        
        response.sendRedirect("MaterialServlet");
    }  
    
    //Update Material
    private void updateMaterial(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        Material material = new Material();
        
        material.setMaterialId(Integer.parseInt(request.getParameter("materialId")));
        material.setMaterialName(request.getParameter("materialName"));
        material.setCategory(request.getParameter("category"));
        material.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        material.setReorderLevel(Integer.parseInt(request.getParameter("reorderLevel")));
        material.setSupplierId(Integer.parseInt(request.getParameter("supplierId")));
        
        materialDAO.updateMaterial(material);
        
        response.sendRedirect("MaterialServlet");
    } 
    
    //showEditForm
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        Material material = materialDAO.getMaterialById(id);
        
        request.setAttribute("material", material);
        
        request.getRequestDispatcher("editMaterial.jsp").forward(request, response);
        
    } 
    
    //Delete Material
    private void deleteMaterial(HttpServletRequest request, HttpServletResponse response) throws IOException {
        
        int id = Integer.parseInt(request.getParameter("id"));
        
        materialDAO.deleteMaterial(id);
        
        response.sendRedirect("MaterialServlet");
        
    } 
    
    //Search Material
    private void searchMaterial(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
    
        String keyword = request.getParameter("keyword");
        
        List<Material> materials = materialDAO.searchMaterials(keyword);
        
        request.setAttribute("materials", materials);
        
        request.getRequestDispatcher("materials.jsp").forward(request, response);
        
    } 
    
    //List Materials
    private void listMaterials(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        
        List<Material> materials = materialDAO.getAllMaterials();
        
        request.setAttribute("materials", materials);
        
        request.getRequestDispatcher("materials.jsp").forward(request, response);
        
    } 
        
}
