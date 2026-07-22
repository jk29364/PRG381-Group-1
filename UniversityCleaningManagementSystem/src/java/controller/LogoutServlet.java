package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Handles user logout by invalidating the current session.
 * Mapped to both GET and POST so it works whether logout is
 * triggered by a link (<a href="logout">) or a form button.
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        invalidateSessionAndRedirect(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        invalidateSessionAndRedirect(request, response);
    }

    private void invalidateSessionAndRedirect(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        // false = don't create a new session if one doesn't already exist
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp?loggedout=true");
    }
}