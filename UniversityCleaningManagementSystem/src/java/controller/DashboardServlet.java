package controller;

import dao.MaterialDAO;
import dao.CleanerDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import model.Cleaner;
import model.Material;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        MaterialDAO Mdao = new MaterialDAO();
        CleanerDAO Cdao = new CleanerDAO();
        
        try {
            List<Material> allMaterials = Mdao.getAllMaterials();
            List<Material> lowStockMaterials = Mdao.getLowStockMaterials();
            List<Cleaner> allCleaners = Cdao.getAllCleaners();

            int totalMaterials = allMaterials.size();
            int totalCleaners = allCleaners.size();
            int lowStockCount = lowStockMaterials.size();

            request.setAttribute("totalMaterials", totalMaterials);
            request.setAttribute("totalCleaners", totalCleaners);
            request.setAttribute("lowStockCount", lowStockCount);
            request.setAttribute("lowStockMaterials", lowStockMaterials);
            request.setAttribute("allMaterials", allMaterials);
            request.setAttribute("allCleaners", allCleaners);
            
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            
            throw new ServletException("Error loading dashboard", e);
            
        }
    }
}