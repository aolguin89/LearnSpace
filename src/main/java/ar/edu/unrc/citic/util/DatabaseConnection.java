package ar.edu.unrc.citic.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Database connection utility using Singleton pattern.
 * Manages a single database connection instance for the entire application.
 * Configuration is loaded from db.properties file.
 *
 * @author Alvaro Olguin Armendariz
 * @version 1.0
 */
public class DatabaseConnection {

    /**
     * Singleton instance - volatile ensures thread-safe lazy initialization
     */
    private static volatile DatabaseConnection instance;

    /**
     * Database connection
     */
    private Connection connection;

    /**
     * Configuration properties
     */
    private Properties properties;

    /**
     * Private constructor to prevent external instantiation.
     * Loads database configuration from db.properties file.
     *
     * @throws RuntimeException if configuration cannot be loaded or connection fails
     */
    private DatabaseConnection() {
        try {
            loadProperties();
            establishConnection();
        } catch (IOException e) {
            throw new RuntimeException("Failed to load database configuration: " + e.getMessage(), e);
        } catch (SQLException e) {
            throw new RuntimeException("Failed to establish database connection: " + e.getMessage(), e);
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found: " + e.getMessage(), e);
        }
    }

    /**
     * Loads database configuration from db.properties file.
     *
     * @throws IOException if properties file cannot be read
     */
    private void loadProperties() throws IOException {
        properties = new Properties();
        InputStream input = getClass().getClassLoader().getResourceAsStream("db.properties");

        if (input == null) {
            throw new IOException("Unable to find db.properties file. " +
                    "Please copy db.properties.example to db.properties and configure your credentials.");
        }

        properties.load(input);
        input.close();
    }

    /**
     * Establishes connection to the database using loaded properties.
     *
     * @throws SQLException           if connection cannot be established
     * @throws ClassNotFoundException if JDBC driver is not found
     */
    private void establishConnection() throws SQLException, ClassNotFoundException {
        String url = properties.getProperty("db.url");
        String user = properties.getProperty("db.user");
        String password = properties.getProperty("db.password");
        String driver = properties.getProperty("db.driver");

        // Load JDBC driver
        Class.forName(driver);

        // Establish connection
        connection = DriverManager.getConnection(url, user, password);

        System.out.println("Database connection established successfully.");
    }

    /**
     * Returns the singleton instance of DatabaseConnection.
     * Uses double-checked locking with volatile for thread safety.
     *
     * @return the singleton DatabaseConnection instance
     */
    public static DatabaseConnection getInstance() {
        if (instance == null) {
            synchronized (DatabaseConnection.class) {
                if (instance == null) {
                    instance = new DatabaseConnection();
                }
            }
        }
        return instance;
    }

    /**
     * Returns the active database connection.
     * Validates connection before returning and reconnects if necessary.
     *
     * @return active Connection object
     * @throws SQLException if connection is closed and cannot be reopened
     */
    public Connection getConnection() throws SQLException {
        // Check if connection is still valid, reconnect if necessary
        if (connection == null || connection.isClosed()) {
            try {
                establishConnection();
            } catch (ClassNotFoundException e) {
                throw new SQLException("Failed to reconnect: " + e.getMessage(), e);
            }
        }
        return connection;
    }

    /**
     * Closes the database connection.
     * Should be called when the application shuts down.
     */
    public void closeConnection() {
        try {
            if (connection != null && !connection.isClosed()) {
                connection.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            System.err.println("Error closing database connection: " + e.getMessage());
        }
    }
}