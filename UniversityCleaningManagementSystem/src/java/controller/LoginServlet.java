package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;

/**
 * Handles user login.
 *
 * GET  -> forwards to the login form (login.jsp)
 * POST -> validates credentials against the database and, on success,
 *         stores the logged-in User in the HTTP session.
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Basic presence check before hitting the database at all.
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Username and password are required.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // DAO handles salt lookup + hash comparison; returns null on any failure.
        User authenticatedUser = userDAO.authenticate(username, password);

        if (authenticatedUser != null) {
            // ---------- Successful login: create a session ----------
            HttpSession session = request.getSession(true);
            session.setAttribute("user", authenticatedUser);
            session.setAttribute("role", authenticatedUser.getRole());

            // Optional: limit how long an idle session stays alive (in seconds).
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            response.sendRedirect("landingPage.jsp");
        } else {
            // ---------- Failed login: show a generic error ----------
            // Intentionally vague ("invalid username or password") rather than
            // saying which field was wrong, to avoid leaking which usernames exist.
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
