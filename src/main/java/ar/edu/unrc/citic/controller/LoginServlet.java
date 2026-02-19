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
import java.sql.Timestamp;

/**
 * Servlet that handles user authentication.
 * Processes login form submissions and manages user sessions.
 *
 * @author Alvaro Olguin Armendariz
 * @version 1.0
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAOImpl();
    }

    /**
     * Handles GET requests - redirects to login page.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    /**
     * Handles POST requests - processes login form submission.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {

            request.setAttribute("errorMessage", "Por favor, complete todos los campos.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Attempt authentication
        User user = userDAO.authenticate(username.trim(), password);

        if (user != null) {
            // Authentication successful - create session
            HttpSession session = request.getSession(true);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("firstName", user.getFirstName());
            session.setAttribute("lastName", user.getLastName());
            session.setAttribute("role", user.getRole());
            session.setAttribute("email", user.getEmail());

            // Set session timeout to 30 minutes
            session.setMaxInactiveInterval(30 * 60);

            // Update last_login timestamp in database
            user.setLastLogin(new Timestamp(System.currentTimeMillis()));
            userDAO.update(user);

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/dashboard");

        } else {
            // Authentication failed
            request.setAttribute("errorMessage", "Usuario o contraseña incorrectos.");
            request.setAttribute("username", username); // Keep username in form
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}