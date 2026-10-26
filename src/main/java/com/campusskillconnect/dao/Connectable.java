package com.campusskillconnect.dao;

import java.sql.Connection;

import com.campusskillconnect.exception.AppException;

/**
 * Connectable — Interface for database connectivity.
 *
 * WHAT IS AN INTERFACE?
 * ─────────────────────────────────────────────────────────────
 * An interface is like a "contract" or "blueprint". It declares
 * WHAT methods a class must have, but not HOW they work.
 *
 * Any class that "implements" this interface MUST provide
 * actual code for every method declared here.
 *
 * WHY USE INTERFACES?
 * - Separates the "what" from the "how"
 * - Makes it easy to swap implementations later
 *   (e.g., switch from MySQL to PostgreSQL)
 * - Multiple classes can implement the same interface differently
 *
 * In this project:
 *   Connectable (interface)
 *       ↑
 *       implements
 *       ↑
 *   DatabaseConnection (concrete class that uses MySQL)
 * ─────────────────────────────────────────────────────────────
 */
public interface Connectable {

    /**
     * Opens and returns a database connection.
     *
     * @return a live JDBC Connection to the database
     * @throws AppException if the connection cannot be established
     */
    Connection getConnection() throws AppException;

    /**
     * Safely closes a database connection.
     * Does nothing if the connection is null or already closed.
     *
     * @param connection the connection to close
     */
    void closeConnection(Connection connection);
}
