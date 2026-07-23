package controller;

import dao.StockIssuanceDAO;
import dao.MaterialDAO;
import dao.CleanerDAO;
import model.StockIssuance;
import model.Material;
import model.Cleaner;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

/*
 * ==========================================================
 * StockIssuanceServlet.java
 * ----------------------------------------------------------
 * Handles all requests relating to Stock Issuance.
 *
 * Functions:
 * - Show the "Issue Stock" form (materials + cleaners dropdowns)
 * - Process a new stock issuance
 * - Show issuance history
 * ==========================================================
 */

@WebServlet("/StockIssuanceServlet")
public class StockIssuanceServlet extends HttpServlet {

    private StockIssuanceDAO stockIssuanceDAO;
    private MaterialDAO materialDAO;
    private CleanerDAO cleanerDAO;

    //Initialise DAOs when servlet starts.
    @Override
    public void init() {
        stockIssuanceDAO = new StockIssuanceDAO();
        materialDAO = new MaterialDAO();
        cleanerDAO = new CleanerDAO();
    }

    //Handles GET requests
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "issue" -> showIssueForm(request, response);
            default -> listIssuanceHistory(request, response);
        }
    }

    //Handles POST requests
    @Override
    protected void doPost(HttpServletRequest request,
                         HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("issue".equals(action)) {
            issueStock(request, response);
        }
    }

    //Show the Issue Stock form
    private void showIssueForm(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        List<Material> materials = materialDAO.getAllMaterials();
        List<Cleaner> cleaners = cleanerDAO.getAllCleaners();

        request.setAttribute("materials", materials);
        request.setAttribute("cleaners", cleaners);

        request.getRequestDispatcher("issueStock.jsp").forward(request, response);
    }

    //Issue Stock
    private void issueStock(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        String errorMessage = null;

        int materialId = 0;
        int cleanerId = 0;
        int quantity = 0;

        try {
            materialId = Integer.parseInt(request.getParameter("materialId"));
            cleanerId = Integer.parseInt(request.getParameter("cleanerId"));
            quantity = Integer.parseInt(request.getParameter("quantity"));
        } catch (NumberFormatException e) {
            errorMessage = "Please provide a valid material, cleaner, and quantity.";
        }

        String issuedBy = request.getParameter("issuedBy");

        //Business rule validation before touching the database
        if (errorMessage == null && quantity <= 0) {
            errorMessage = "Quantity issued must be greater than zero.";
        }

        //Prevent issuing unavailable stock - check up front so we can show
        //a helpful message (StockIssuanceDAO re-checks this itself too,
        //so stock can never go negative even under concurrent requests).
        if (errorMessage == null) {
            Material material = materialDAO.getMaterialById(materialId);

            if (material == null) {
                errorMessage = "Selected material could not be found.";
            } else if (material.getQuantity() < quantity) {
                errorMessage = "Only " + material.getQuantity() + " unit(s) of "
                        + material.getMaterialName() + " are available.";
            }
        }

        if (errorMessage == null) {
            StockIssuance issuance = new StockIssuance();

            issuance.setMaterialId(materialId);
            issuance.setCleanerId(cleanerId);
            issuance.setQuantityIssued(quantity);
            issuance.setIssuedBy(issuedBy);

            boolean success = stockIssuanceDAO.issueStock(issuance);

            if (success) {
                response.sendRedirect("StockIssuanceServlet");
                return;
            } else {
                errorMessage = "Unable to issue stock. The requested quantity may no "
                        + "longer be available.";
            }
        }

        //Something went wrong - reload the form with the dropdowns and the error
        request.setAttribute("errorMessage", errorMessage);
        request.setAttribute("materials", materialDAO.getAllMaterials());
        request.setAttribute("cleaners", cleanerDAO.getAllCleaners());

        request.getRequestDispatcher("issueStock.jsp").forward(request, response);
    }

    //List Issuance History
    private void listIssuanceHistory(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {

        List<StockIssuance> issuances = stockIssuanceDAO.getAllIssuances();

        request.setAttribute("issuances", issuances);

        request.getRequestDispatcher("issuanceHistory.jsp").forward(request, response);
    }

}
