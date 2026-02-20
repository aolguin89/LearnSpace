package ar.edu.unrc.citic.controller;

import ar.edu.unrc.citic.dao.UserDAO;
import ar.edu.unrc.citic.dao.UserDAOImpl;
import ar.edu.unrc.citic.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet that handles user registration.
 * Processes registration form submissions and creates new user accounts.
 *
 * @author LearnSpace Team
 * @version 1.0
 */
@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAOImpl();
    }

    /**
     * Handles GET requests - displays registration form.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    /**
     * Handles POST requests - processes registration form submission.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get form parameters
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String dni = request.getParameter("dni");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String birthDateStr = request.getParameter("birthDate");
        String gender = request.getParameter("gender");

        List<String> errors = new ArrayList<>();

        // Validate required fields
        if (username == null || username.trim().isEmpty()) {
            errors.add("El nombre de usuario es requerido.");
        }
        if (email == null || email.trim().isEmpty()) {
            errors.add("El email es requerido.");
        }
        if (password == null || password.trim().isEmpty()) {
            errors.add("La contraseña es requerida.");
        }
        if (firstName == null || firstName.trim().isEmpty()) {
            errors.add("El nombre es requerido.");
        }
        if (lastName == null || lastName.trim().isEmpty()) {
            errors.add("El apellido es requerido.");
        }

        // Validate password match
        if (password != null && confirmPassword != null && !password.equals(confirmPassword)) {
            errors.add("Las contraseñas no coinciden.");
        }

        // Validate password length
        if (password != null && password.length() < 6) {
            errors.add("La contraseña debe tener al menos 6 caracteres.");
        }

        // Validate email format (basic)
        if (email != null && !email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.add("El formato del email no es válido.");
        }

        // Check for duplicate username
        if (username != null && !username.trim().isEmpty()) {
            User existingUser = userDAO.findByUsername(username.trim());
            if (existingUser != null) {
                errors.add("El nombre de usuario ya está en uso.");
            }
        }

        // Check for duplicate email
        if (email != null && !email.trim().isEmpty()) {
            User existingEmail = userDAO.findByEmail(email.trim());
            if (existingEmail != null) {
                errors.add("El email ya está registrado.");
            }
        }

        // If there are errors, return to form
        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.setAttribute("firstName", firstName);
            request.setAttribute("lastName", lastName);
            request.setAttribute("dni", dni);
            request.setAttribute("address", address);
            request.setAttribute("phone", phone);
            request.setAttribute("birthDate", birthDateStr);
            request.setAttribute("gender", gender);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User newUser = new User();
        newUser.setUsername(username.trim());
        newUser.setEmail(email.trim());
        newUser.setPassword(password); // Will be hashed by DAO
        newUser.setFirstName(firstName.trim());
        newUser.setLastName(lastName.trim());
        newUser.setDni(dni != null && !dni.trim().isEmpty() ? dni.trim() : null);
        newUser.setAddress(address != null && !address.trim().isEmpty() ? address.trim() : null);
        newUser.setPhone(phone != null && !phone.trim().isEmpty() ? phone.trim() : null);

        // Parse birthdate
        if (birthDateStr != null && !birthDateStr.trim().isEmpty()) {
            try {
                newUser.setBirthDate(Date.valueOf(birthDateStr));
            } catch (IllegalArgumentException e) {
                errors.add("El formato de la fecha de nacimiento no es válido.");
                request.setAttribute("errors", errors);
                request.getRequestDispatcher("/register.jsp").forward(request, response);
                return;
            }
        }

        newUser.setGender(gender);
        newUser.setRole("student"); // Default role
        newUser.setActive(true);

        // Attempt to create user
        User createdUser = userDAO.create(newUser);

        if (createdUser != null) {
            // Registration successful - redirect to login with success message
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=true");
        } else {
            // Registration failed
            errors.add("Error al crear la cuenta. Por favor, intente nuevamente.");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}