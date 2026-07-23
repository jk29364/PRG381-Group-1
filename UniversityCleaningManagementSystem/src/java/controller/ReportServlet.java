package controller;

import dao.MaterialDAO;
import dao.CleanerDAO;
import dao.StockIssuanceDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Cleaner;
import model.Material;
import model.StockIssuance;

import java.io.IOException;
import java.util.*;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        MaterialDAO materialDAO = new MaterialDAO();
        CleanerDAO cleanerDAO = new CleanerDAO();
        StockIssuanceDAO issuanceDAO = new StockIssuanceDAO();

        int totalMaterials = materialDAO.getAllMaterials().size();
        int lowStockCount = (int) materialDAO.getAllMaterials().stream()
                .filter(m -> m.getQuantity() <= m.getReorderLevel())
                .count();
        int totalCleaners = cleanerDAO.getAllCleaners().size();
        int totalIssuances = issuanceDAO.getAllIssuances().size();

        List<Material> lowStockMaterials = materialDAO.getLowStockMaterials();
        List<Cleaner> activeCleaners = cleanerDAO.getAllCleaners();

        List<StockIssuance> allIssuances = issuanceDAO.getAllIssuances();
        List<StockIssuance> recentIssuances = allIssuances.size() > 30
        ? allIssuances.subList(allIssuances.size() - 30, allIssuances.size())
        : allIssuances;

        request.setAttribute("totalMaterials", totalMaterials);
        request.setAttribute("lowStockCount", lowStockCount);
        request.setAttribute("totalCleaners", totalCleaners);
        request.setAttribute("totalIssuances", totalIssuances);

        request.setAttribute("lowStockMaterials", lowStockMaterials);
        request.setAttribute("activeCleaners", activeCleaners);
        request.setAttribute("recentIssuances", recentIssuances);

        request.getRequestDispatcher("reports.jsp").forward(request, response);
    }
}
