package ar.edu.unrc.citic.dao;

import ar.edu.unrc.citic.model.User;
import ar.edu.unrc.citic.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Implementation of UserDAO interface.
 * Handles all database operations for User entity.
 *
 * @author Alvaro Olguin Armendariz
 * @version 1.0
 */
public class UserDAOImpl implements UserDAO {

    /**
     * Finds a user by their ID.
     *
     * @param id User ID
     * @return User object if found, null otherwise
     */
    @Override
    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error finding user by ID: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Finds a user by their username.
     *
     * @param username Username to search for
     * @return User object if found, null otherwise
     */
    @Override
    public User findByUsername(String username) {
        String sql = "SELECT * FROM users WHERE username = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error finding user by username: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Finds a user by their email address.
     *
     * @param email Email to search for
     * @return User object if found, null otherwise
     */
    @Override
    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error finding user by email: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Retrieves all users from the database.
     *
     * @return List of all users
     */
    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY id";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }

        } catch (SQLException e) {
            System.err.println("Error retrieving all users: " + e.getMessage());
            e.printStackTrace();
        }

        return users;
    }

    /**
     * Creates a new user in the database.
     *
     * @param user User object to create
     * @return User object with generated ID, or null if creation failed
     */
    @Override
    public User create(User user) {
        String sql = "INSERT INTO users (username, email, password, first_name, last_name, dni, " +
                "address, phone, birth_date, gender, role, is_active) " +
                "VALUES (?, ?, SHA2(?, 256), ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());  // Will be hashed by SQL
            ps.setString(4, user.getFirstName());
            ps.setString(5, user.getLastName());
            ps.setString(6, user.getDni());
            ps.setString(7, user.getAddress());
            ps.setString(8, user.getPhone());
            ps.setDate(9, user.getBirthDate());
            ps.setString(10, user.getGender());
            ps.setString(11, user.getRole());
            ps.setBoolean(12, user.isActive());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        user.setId(generatedKeys.getInt(1));
                        return user;
                    }
                }
            }

        } catch (SQLException e) {
            System.err.println("Error creating user: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Updates an existing user in the database.
     *
     * @param user User object with updated information
     * @return true if update was successful, false otherwise
     */
    @Override
    public boolean update(User user) {
        String sql = "UPDATE users SET username = ?, email = ?, first_name = ?, last_name = ?, " +
                "dni = ?, address = ?, phone = ?, birth_date = ?, gender = ?, role = ?, " +
                "is_active = ? WHERE id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getFirstName());
            ps.setString(4, user.getLastName());
            ps.setString(5, user.getDni());
            ps.setString(6, user.getAddress());
            ps.setString(7, user.getPhone());
            ps.setDate(8, user.getBirthDate());
            ps.setString(9, user.getGender());
            ps.setString(10, user.getRole());
            ps.setBoolean(11, user.isActive());
            ps.setInt(12, user.getId());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Deletes a user from the database by ID.
     *
     * @param id User ID to delete
     * @return true if deletion was successful, false otherwise
     */
    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting user: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Authenticates a user by username and password.
     * Password is hashed with SHA2-256 before comparison.
     * Only active users can authenticate.
     *
     * @param username Username
     * @param password Plain text password (will be hashed by SQL)
     * @return User object if authentication successful, null otherwise
     */
    @Override
    public User authenticate(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = SHA2(?, 256) AND is_active = TRUE";

        try (Connection conn = DatabaseConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return extractUserFromResultSet(rs);
                }
            }

        } catch (SQLException e) {
            System.err.println("Error authenticating user: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Helper method to extract a User object from a ResultSet.
     *
     * @param rs ResultSet positioned at a user row
     * @return User object with data from ResultSet
     * @throws SQLException if column access fails
     */
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setDni(rs.getString("dni"));
        user.setAddress(rs.getString("address"));
        user.setPhone(rs.getString("phone"));
        user.setBirthDate(rs.getDate("birth_date"));
        user.setGender(rs.getString("gender"));
        user.setRole(rs.getString("role"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setLastLogin(rs.getTimestamp("last_login"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        user.setActive(rs.getBoolean("is_active"));
        return user;
    }
}