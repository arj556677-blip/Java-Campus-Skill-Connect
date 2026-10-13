package com.campusskillconnect.dao;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import com.campusskillconnect.exception.AppException;

/**
 * DatabaseConnection — Implements the Connectable interface to
 * provide MySQL database connections via JDBC.
 *
 * HOW IT WORKS:
 * ─────────────────────────────────────────────────────────────
 * 1. When this class is first used, the "static block" runs ONCE.
 *    It reads database settings from db.properties and loads the
 *    MySQL JDBC driver.
 *
 * 2. Every time getConnection() is called, it creates a NEW
 *    connection to MySQL using the loaded settings.
 *
 * 3. After using a connection, always close it with
 *    closeConnection() or try-with-resources.
 *
 * CONFIGURATION:
 *    Edit src/main/resources/db.properties to set your MySQL
 *    username and password.
 * ─────────────────────────────────────────────────────────────
 */
public class DatabaseConnection implements Connectable {

    // Database connection details (loaded from db.properties)
    private static String url;
    private static String user;
    private static String password;

    /*
     * STATIC INITIALIZER BLOCK
     * This block runs exactly ONCE — the first time Java loads
     * the DatabaseConnection class. It reads the db.properties
     * file and registers the MySQL JDBC driver.
     */
    static {
        try {
            // Load properties file from the classpath
            // (Maven puts src/main/resources/ on the classpath automatically)
            Properties props = new Properties();
            InputStream input = DatabaseConnection.class
                    .getClassLoader()
                    .getResourceAsStream("db.properties");

            if (input == null) {
                throw new RuntimeException(
                    "ERROR: db.properties file not found!\n" +
                    "Make sure it exists at: src/main/resources/db.properties"
                );
            }

            props.load(input);
            input.close();

            // Read the values from the properties file
            url = props.getProperty("db.url");
            user = props.getProperty("db.user");
            password = props.getProperty("db.password");

            // Load the MySQL JDBC driver class into memory
            // This tells Java: "I want to use MySQL"
            Class.forName("com.mysql.cj.jdbc.Driver");

            System.out.println("✓ Database driver loaded successfully.");
            System.out.println("  URL: " + url);

        } catch (Exception e) {
            // If anything goes wrong during initialization, the
            // application cannot function — so we throw a fatal error.
            throw new RuntimeException(
                "Failed to initialize DatabaseConnection: " + e.getMessage(), e
            );
        }
    }

    /**
     * Creates and returns a new connection to the MySQL database.
     *
     * IMPORTANT: The caller must close this connection when done!
     * Best practice: use try-with-resources:
     *
     *   try (Connection conn = dbConnection.getConnection()) {
     *       // use the connection...
     *   } // connection is automatically closed here
     *
     * @return a live JDBC Connection
     * @throws AppException if the connection cannot be established
     */
    @Override
    public Connection getConnection() throws AppException {
        try {
            return DriverManager.getConnection(url, user, password);
        } catch (SQLException e) {
            throw new AppException(
                "Failed to connect to database. Check db.properties settings.\n" +
                "URL: " + url + "\nUser: " + user,
                e
            );
        }
    }

    /**
     * Safely closes a database connection.
     * Does nothing if the connection is null or already closed.
     *
     * @param connection the connection to close
     */
    @Override
    public void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                if (!connection.isClosed()) {
                    connection.close();
                }
            } catch (SQLException e) {
                // Log the error but don't throw — this is a cleanup method
                System.err.println("Warning: Error closing database connection: " + e.getMessage());
            }
        }
    }
}
