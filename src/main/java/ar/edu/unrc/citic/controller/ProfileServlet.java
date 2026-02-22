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
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet that handles user profile viewing and editing.
 * Requires authentication to access.
 *
 * @author Alvaro Olguin Armendariz
 * @version 1.0
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAOImpl();
    }

    /**
     * Handles GET requests - displays user profile form.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check authentication
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get current user from database
        int userId = (int) session.getAttribute("userId");
        User user = userDAO.findById(userId);

        if (user == null) {
            // User not found in database (shouldn't happen, but handle it)
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Check for deactivation error
        String error = request.getParameter("error");
        if ("deactivation_failed".equals(error)) {
            request.setAttribute("errors",
                    java.util.Collections.singletonList("Error al desactivar la cuenta. Por favor, intente nuevamente."));
        }

        // Set user as request attribute for the form
        request.setAttribute("user", user);
        request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
    }

    /**
     * Handles POST requests - processes profile update.
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

        // Get form parameters
        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dni = request.getParameter("dni");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String birthDateStr = request.getParameter("birthDate");
        String gender = request.getParameter("gender");

        List<String> errors = new ArrayList<>();

        // Validate required fields
        if (email == null || email.trim().isEmpty()) {
            errors.add("El email es requerido.");
        }
        if (firstName == null || firstName.trim().isEmpty()) {
            errors.add("El nombre es requerido.");
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            errors.add("El apellido es requerido.");
        }

        // Validate email format
        if (email != null && !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.add("El formato del email no es válido.");
        }

        // Check for duplicate email (only if changed)
        if (email != null && !email.trim().isEmpty() && !email.trim().equals(user.getEmail())) {
            User existingEmail = userDAO.findByEmail(email.trim());
            if (existingEmail != null) {
                errors.add("El email ya está en uso por otra cuenta.");
            }
        }

        // If there are errors, return to form
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
            return;
        }

        // Update user object
        user.setEmail(email.trim());
        user.setFirstName(firstName.trim());
        user.setLastName(lastName.trim());
        user.setDni(dni != null && !dni.trim().isEmpty() ? dni.trim() : null);
        user.setAddress(address != null && !address.trim().isEmpty() ? address.trim() : null);
        user.setPhone(phone != null && !phone.trim().isEmpty() ? phone.trim() : null);

        // Parse birth date
        if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
            try {
                user.setBirthDate(Date.valueOf(birthDateStr));
            } catch (IllegalArgumentException e) {
                errors.add("El formato de la fecha de nacimiento no es válido.");
                request.setAttribute("errors", errors);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
                return;
            }
        } else {
            user.setBirthDate(null);
        }

        user.setGender(gender);

        // Attempt to update user
        boolean updated = userDAO.update(user);

        if (updated) {
            // Update session data
            session.setAttribute("firstName", user.getFirstName());
            session.setAttribute("lastName", user.getLastName());
            session.setAttribute("email", user.getEmail());

            // Set success message
            request.setAttribute("successMessage", "Perfil actualizado exitosamente.");
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        } else {
            errors.add("Error al actualizar el perfil. Por favor, intente nuevamente.");
            request.setAttribute("errors", errors);
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/profile.jsp").forward(request, response);
        }
    }
}