package ar.edu.unrc.citic.controller;

import ar.edu.unrc.citic.dao.UserDAO;
import ar.edu.unrc.citic.dao.UserDAOImpl;
import ar.edu.unrc.citic.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Servlet that handles user account deactivation.
 * Uses soft delete pattern (sets is_active = false).
 * Requires authentication to access.
 *
 * @author Alvaro Olguin Armendariz
 * @version 1.0
 */
@WebServlet("/deactivate-account")
public class DeactivateAccountServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAOImpl();
    }

    /**
     * Handles POST requests - processes account deactivation.
     * GET requests are not allowed (prevents accidental deactivation via URL).
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        User user = userDAO.findById(userId);

        if (user == null) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Deactivate user (soft delete)
        user.setActive(false);
        boolean deactivated = userDAO.update(user);

        if (deactivated) {
            // Invalidate session
            session.invalidate();

            // Redirect to login with deactivation message
            response.sendRedirect(request.getContextPath() + "/login.jsp?deactivated=true");
        } else {
            // Deactivation failed - redirect back to profile with error
            response.sendRedirect(request.getContextPath() + "/profile?error=deactivation_failed");
        }
    }

    /**
     * GET requests not allowed for security.
     * Prevents accidental deactivation by visiting URL.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/profile");
    }
}