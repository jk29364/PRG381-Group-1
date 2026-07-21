package controller;

import dao.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReportDAO dao = new ReportDAO();

        try {
            int totalMaterials = 10; // dao.getTotalMaterials()
            int totalCleaners = 34;  // dao.getTotalCleaners()
            int totalIssuances = 3;  // dao.getTotalIssuances()

            request.setAttribute("totalMaterials", totalMaterials);
            request.setAttribute("totalCleaners", totalCleaners);
            request.setAttribute("totalIssuances", totalIssuances);

            request.getRequestDispatcher("dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException("Error loading dashboard", e);
        }
    }
}
