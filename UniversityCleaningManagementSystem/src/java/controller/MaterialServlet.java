package controller;

import dao.MaterialDAO;
import jakarta.servlet.ServletException;
import model.Material;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
            case "delete":
                deleteMaterial(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "search":
                searchMaterial(request, response);
                break;
            default:
                listMaterials(request, response);
                break;    
        }
    }
    
    //Handles POST requests
    @Override
    protected void doPost(HttpServletRequest request, 
                         HttpServletResponse response) throws ServletException, IOException{
        
        String action = request.getParameter("action");
        
        if ("add".equals(action){
            addMaterial(request, response);
        } else if {
            updateMaterial(request, response);
        }
    }
    
    //Add Material
    
    
        
        
}
