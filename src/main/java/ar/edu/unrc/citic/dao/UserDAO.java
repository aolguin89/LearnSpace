package ar.edu.unrc.citic.dao;

import ar.edu.unrc.citic.model.User;

import java.util.List;

/**
 * Data Access Object interface for User entity.
 * Defines CRUD operations and authentication for users.
 *
 * @author Alvaro Olguin Armendariz
 * @version 1.0
 */
public interface UserDAO {

    /**
     * Finds a user by their ID.
     *
     * @param id User ID
     * @return User object if found, null otherwise
     */
    User findById(int id);

    /**
     * Finds a user by their username.
     *
     * @param username Username to search for
     * @return User object if found, null otherwise
     */
    User findByUsername(String username);

    /**
     * Finds a user by their email address.
     *
     * @param email Email to search for
     * @return User object if found, null otherwise
     */
    User findByEmail(String email);

    /**
     * Retrieves all users from the database.
     *
     * @return List of all users
     */
    List<User> findAll();

    /**
     * Creates a new user in the database.
     *
     * @param user User object to create
     * @return User object with generated ID, or null if creation failed
     */
    User create(User user);

    /**
     * Updates an existing user in the database.
     *
     * @param user User object with updated information
     * @return true if update was successful, false otherwise
     */
    boolean update(User user);

    /**
     * Deletes a user from the database by ID.
     *
     * @param id User ID to delete
     * @return true if deletion was successful, false otherwise
     */
    boolean delete(int id);

    /**
     * Authenticates a user by username and password.
     * Password is hashed with SHA2-256 before comparison.
     *
     * @param username Username
     * @param password Plain text password (will be hashed)
     * @return User object if authentication successful, null otherwise
     */
    User authenticate(String username, String password);
}