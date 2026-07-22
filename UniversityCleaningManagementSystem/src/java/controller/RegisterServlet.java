package controller;

import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;
import util.ValidationUtil;

import java.io.IOException;

/**
 * Handles new user registration.
 *
 * GET  -> forwards to the registration form (register.jsp)
 * POST -> validates the submitted form, checks for duplicate
 *         username/email, hashes the password, and saves the new user.
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Simply show the empty registration form.
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ---------- 1. Read form data ----------
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String role = request.getParameter("role"); // expected: "Storekeeper" or "Supervisor"

        // ---------- 2. Validate input ----------
        String errorMessage = null;

        if (fullName == null || fullName.trim().isEmpty()) {
            errorMessage = "Full name is required.";
        } else if (!ValidationUtil.isValidUsername(username)) {
            errorMessage = "Username must be 3-20 characters (letters, numbers, underscore only).";
        } else if (!ValidationUtil.isValidEmail(email)) {
            errorMessage = "Please enter a valid email address.";
        } else if (!ValidationUtil.isValidPassword(password)) {
            errorMessage = "Password must be at least 8 characters and include "
                          + "an uppercase letter, a lowercase letter, and a digit.";
        } else if (password == null || !password.equals(confirmPassword)) {
            errorMessage = "Passwords do not match.";
        } else if (role == null || !(role.equals("Storekeeper") || role.equals("Supervisor"))) {
            // Must match the Users table's CHECK (role IN ('Storekeeper', 'Supervisor')) constraint.
            errorMessage = "Please select a valid role (Storekeeper or Supervisor).";
        } else if (userDAO.isUsernameTaken(username)) {
            errorMessage = "That username is already taken.";
        } else if (userDAO.isEmailTaken(email)) {
            errorMessage = "That email is already registered.";
        }

        // ---------- 3. If validation failed, redisplay the form with the error ----------
        if (errorMessage != null) {
            request.setAttribute("errorMessage", errorMessage);
            // Re-populate the form fields so the user doesn't have to retype everything.
            request.setAttribute("fullName", fullName);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("role", role);

            RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
            dispatcher.forward(request, response);
            return;
        }

        // ---------- 4. Build the User object and persist it ----------
        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password); // plain text here; UserDAO hashes it before saving
        newUser.setRole(role);         // "Storekeeper" or "Supervisor", as selected on the form

        boolean success = userDAO.registerUser(newUser);

        // ---------- 5. Redirect based on outcome ----------
        if (success) {
            // Redirect (not forward) after a successful POST to avoid
            // duplicate submissions if the user refreshes the page.
            response.sendRedirect("login.jsp?registered=true");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}