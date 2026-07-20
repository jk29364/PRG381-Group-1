package controller;

import dao.CleanerDAO;
import model.Cleaner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * CleanerServlet.java
 * Handles all HTTP requests related to Cleaners Management:
 * list, search/filter, add, edit, update, delete.
 * Part of: Cleaners Management Module (Team Member 4)
 *
 * URL mapping: /CleanerServlet
 * Expects an "action" request parameter to route requests, e.g.
 * /CleanerServlet?action=list
 * /CleanerServlet?action=add
 * /CleanerServlet?action=edit&id=5
 */
@WebServlet("/CleanerServlet")
public class CleanerServlet extends HttpServlet {

    private final CleanerDAO cleanerDAO = new CleanerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                // Just forward to the empty add form
                request.getRequestDispatcher("addCleaner.jsp").forward(request, response);
                break;

            case "edit":
                showEditForm(request, response);
                break;

            case "delete":
                deleteCleaner(request, response);
                break;

            case "search":
                searchCleaners(request, response);
                break;

            case "list":
            default:
                listCleaners(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        switch (action) {
            case "insert":
                insertCleaner(request, response);
                break;

            case "update":
                updateCleaner(request, response);
                break;

            default:
                response.sendRedirect("CleanerServlet?action=list");
                break;
        }
    }

    // ---------- Action handlers ----------

    private void listCleaners(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Cleaner> cleaners = cleanerDAO.getAllCleaners();
        request.setAttribute("cleaners", cleaners);
        request.getRequestDispatcher("cleaners.jsp").forward(request, response);
    }

    private void searchCleaners(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("keyword");
        String department = request.getParameter("department");
        String status = request.getParameter("status");

        List<Cleaner> cleaners = cleanerDAO.searchCleaners(keyword, department, status);
        request.setAttribute("cleaners", cleaners);
        request.setAttribute("keyword", keyword);
        request.setAttribute("department", department);
        request.setAttribute("status", status);
        request.getRequestDispatcher("cleaners.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Cleaner cleaner = cleanerDAO.getCleanerById(id);

            if (cleaner == null) {
                request.setAttribute("errorMessage", "Cleaner not found.");
                request.getRequestDispatcher("cleaners.jsp").forward(request, response);
                return;
            }

            request.setAttribute("cleaner", cleaner);
            request.getRequestDispatcher("editCleaner.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid cleaner ID.");
            request.getRequestDispatcher("cleaners.jsp").forward(request, response);
        }
    }

    private void insertCleaner(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String errorMessage = validateCleanerInput(request);

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("addCleaner.jsp").forward(request, response);
            return;
        }

        Cleaner cleaner = new Cleaner(
                request.getParameter("firstName").trim(),
                request.getParameter("lastName").trim(),
                request.getParameter("contactNumber"),
                request.getParameter("email"),
                request.getParameter("department"),
                "Active"
        );

        boolean success = cleanerDAO.addCleaner(cleaner);

        if (success) {
            response.sendRedirect("CleanerServlet?action=list");
        } else {
            request.setAttribute("errorMessage", "Failed to add cleaner. Please try again.");
            request.getRequestDispatcher("addCleaner.jsp").forward(request, response);
        }
    }

    private void updateCleaner(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String errorMessage = validateCleanerInput(request);

        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("editCleaner.jsp").forward(request, response);
            return;
        }

        try {
            Cleaner cleaner = new Cleaner();
            cleaner.setCleanerId(Integer.parseInt(request.getParameter("cleanerId")));
            cleaner.setFirstName(request.getParameter("firstName").trim());
            cleaner.setLastName(request.getParameter("lastName").trim());
            cleaner.setContactNumber(request.getParameter("contactNumber"));
            cleaner.setEmail(request.getParameter("email"));
            cleaner.setDepartment(request.getParameter("department"));
            cleaner.setStatus(request.getParameter("status"));

            boolean success = cleanerDAO.updateCleaner(cleaner);

            if (success) {
                response.sendRedirect("CleanerServlet?action=list");
            } else {
                request.setAttribute("errorMessage", "Failed to update cleaner. Please try again.");
                request.setAttribute("cleaner", cleaner);
                request.getRequestDispatcher("editCleaner.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid cleaner ID.");
            request.getRequestDispatcher("cleaners.jsp").forward(request, response);
        }
    }

    private void deleteCleaner(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            cleanerDAO.deleteCleaner(id);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid cleaner ID.");
        }

        response.sendRedirect("CleanerServlet?action=list");
    }

    // ---------- Validation ----------

    // Returns an error message if invalid, or null if input passes validation.
    private String validateCleanerInput(HttpServletRequest request) {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");

        if (firstName == null || firstName.trim().isEmpty()) {
            return "First name is required.";
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            return "Last name is required.";
        }
        if (email != null && !email.trim().isEmpty() && !email.matches("^[\\w.+-]+@[\\w-]+\\.[a-zA-Z]{2,}$")) {
            return "Please enter a valid email address.";
        }
        return null;
    }
}
