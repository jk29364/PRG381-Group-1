package controller;

import dao.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;

@WebServlet("/reports")
public class ReportServlet extends HttpServlet {
    
    // TEST Inventory Report (all materials)
    public List<String> getInventoryReport() {
        List<String> inventory = new ArrayList<>();
        inventory.add("Mop - Qty: 20");
        inventory.add("Detergent - Qty: 15");
        inventory.add("Gloves - Qty: 50");
        return inventory;
    }

    // TEST Low Stock Report
    public List<String> getLowStockItems() {
        List<String> lowStock = new ArrayList<>();
        lowStock.add("Detergent - Qty: 2");
        lowStock.add("Sanitizer - Qty: 1");
        return lowStock;
    }

    // TEST Issuance History
    public List<String> getIssuanceHistory() {
        List<String> history = new ArrayList<>();
        history.add("Mop issued to Cleaner A on 2026-07-20");
        history.add("Gloves issued to Cleaner B on 2026-07-19");
        return history;
    }

    // TEST Material Usage Report
    public Map<String, Integer> getMaterialUsage() {
        Map<String, Integer> usage = new HashMap<>();
        usage.put("Mop", 5);
        usage.put("Detergent", 10);
        usage.put("Gloves", 8);
        return usage;
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //ReportDAO dao = new ReportDAO(); //Required for calling the methods made by the group all based from dao

        try {

        String type = request.getParameter("type");

        if (type == null) {
            request.setAttribute("errorMessage", "No report type specified.");
        } else {
            switch (type) {
                case "inventory" -> request.setAttribute("inventoryReport", getInventoryReport());
                case "lowstock" -> request.setAttribute("lowStockReport", getLowStockItems());
                case "issuance" -> request.setAttribute("issuanceHistory", getIssuanceHistory());
                case "usage" -> request.setAttribute("materialUsage", getMaterialUsage());
                default -> request.setAttribute("errorMessage", "Invalid report type requested.");
            }
        }
            
            request.getRequestDispatcher("reports.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading reports", e);
        }
    }
}
