package com.campusskillconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.User;

/**
 * UserDAO — Data Access Object for the "users" table.
 *
 * WHAT IS A DAO?
 * ─────────────────────────────────────────────────────────────
 * A DAO (Data Access Object) is a class that handles ALL database
 * operations for one specific table. This keeps SQL code in one
 * place instead of scattering it throughout the application.
 *
 * Each public method in this class performs one database operation:
 *   - insertUser()    → INSERT (registration)
 *   - findByEmail()   → SELECT (login)
 *   - findById()      → SELECT (profile view)
 *   - updateProfile() → UPDATE (edit profile)
 *   - findBySkill()   → SELECT with JOIN (search feature)
 *
 * SECURITY:
 * All queries use PreparedStatement with "?" placeholders.
 * This prevents SQL Injection attacks. NEVER concatenate
 * user input directly into SQL strings!
 * ─────────────────────────────────────────────────────────────
 */
public class UserDAO {

    // Database connection provider
    private final DatabaseConnection dbConnection;

    /** Constructor — receives the database connection provider */
    public UserDAO() {
        this.dbConnection = new DatabaseConnection();
    }

    // ─────────────────────────────────────────────────────────
    // INSERT — Register a new user
    // ─────────────────────────────────────────────────────────

    /**
     * Inserts a new user into the database.
     * The password must already be hashed before calling this method!
     *
     * @param user the User object to insert (passwordHash must be set)
     * @return the auto-generated ID of the new user
     * @throws AppException if the insert fails (e.g., duplicate email)
     */
    public int insertUser(User user) throws AppException {
        String sql = "INSERT INTO users (email, password_hash, first_name, last_name, " +
                     "institution_id, campus_id, course, year_of_study, bio) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        // try-with-resources: Connection and PreparedStatement are
        // automatically closed when the block ends, even if an error occurs.
        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // Set the "?" placeholders with actual values
            // The numbers (1, 2, 3...) correspond to each "?" in order
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getPasswordHash());
            stmt.setString(3, user.getFirstName());
            stmt.setString(4, user.getLastName());
            stmt.setInt(5, user.getInstitutionId());
            stmt.setInt(6, user.getCampusId());
            stmt.setString(7, user.getCourse());
            stmt.setInt(8, user.getYearOfStudy());
            stmt.setString(9, user.getBio());

            // Execute the INSERT statement
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected == 0) {
                throw new AppException("Failed to insert user — no rows affected.");
            }

            // Retrieve the auto-generated ID
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int generatedId = generatedKeys.getInt(1);
                    user.setId(generatedId);
                    return generatedId;
                } else {
                    throw new AppException("Failed to retrieve generated user ID.");
                }
            }

        } catch (SQLException e) {
            // Check if it's a duplicate email error
            if (e.getMessage().contains("Duplicate entry")) {
                throw new AppException("A user with this email already exists.", e);
            }
            throw new AppException("Database error while inserting user: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // SELECT — Find user by email (used during login)
    // ─────────────────────────────────────────────────────────

    /**
     * Finds a user by their email address.
     * Used during login to retrieve the stored password hash for verification.
     *
     * @param email the email to search for
     * @return the User object if found, or null if no user has that email
     * @throws AppException if a database error occurs
     */
    public User findByEmail(String email) throws AppException {
        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToUser(rs);
                }
                return null; // No user found with this email
            }

        } catch (SQLException e) {
            throw new AppException("Database error while finding user by email: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // SELECT — Find user by ID (used for profile view)
    // ─────────────────────────────────────────────────────────

    /**
     * Finds a user by their unique ID.
     *
     * @param id the user's database ID
     * @return the User object if found, or null
     * @throws AppException if a database error occurs
     */
    public User findById(int id) throws AppException {
        String sql = "SELECT u.*, i.name AS institution_name, c.name AS campus_name " +
                     "FROM users u " +
                     "JOIN institutions i ON u.institution_id = i.id " +
                     "JOIN campuses c ON u.campus_id = c.id " +
                     "WHERE u.id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = mapResultSetToUser(rs);
                    // Also set the display names from the JOIN
                    user.setInstitutionName(rs.getString("institution_name"));
                    user.setCampusName(rs.getString("campus_name"));
                    return user;
                }
                return null;
            }

        } catch (SQLException e) {
            throw new AppException("Database error while finding user by ID: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // UPDATE — Update user profile
    // ─────────────────────────────────────────────────────────

    /**
     * Updates a user's profile information.
     * Does NOT update email or password (those have separate flows).
     *
     * @param user the User object with updated values
     * @throws AppException if the update fails
     */
    public void updateProfile(User user) throws AppException {
        String sql = "UPDATE users SET first_name = ?, last_name = ?, " +
                     "course = ?, year_of_study = ?, bio = ? " +
                     "WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getLastName());
            stmt.setString(3, user.getCourse());
            stmt.setInt(4, user.getYearOfStudy());
            stmt.setString(5, user.getBio());
            stmt.setInt(6, user.getId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new AppException("No user found with ID: " + user.getId());
            }

        } catch (SQLException e) {
            throw new AppException("Database error while updating profile: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // SEARCH — Find users who have a specific skill
    // ─────────────────────────────────────────────────────────

    /**
     * Searches for students who have a skill matching the search term.
     * Uses SQL LIKE with wildcards for partial matching.
     *
     * Example: searchBySkill("java") finds users with skills like
     * "Java Programming", "Advanced Java", "JavaScript", etc.
     *
     * @param skillName the skill to search for (partial match)
     * @return list of Users who have a matching skill
     * @throws AppException if a database error occurs
     */
    public List<User> searchBySkill(String skillName) throws AppException {
        // JOIN three tables to get user info + institution/campus names
        String sql = "SELECT DISTINCT u.*, i.name AS institution_name, " +
                     "c.name AS campus_name " +
                     "FROM users u " +
                     "JOIN skills s ON u.id = s.user_id " +
                     "JOIN institutions i ON u.institution_id = i.id " +
                     "JOIN campuses c ON u.campus_id = c.id " +
                     "WHERE s.skill_name LIKE ? " +
                     "ORDER BY u.first_name";

        List<User> users = new ArrayList<>();

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // "%" = wildcard in SQL. "%java%" matches anything containing "java"
            stmt.setString(1, "%" + skillName + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    User user = mapResultSetToUser(rs);
                    user.setInstitutionName(rs.getString("institution_name"));
                    user.setCampusName(rs.getString("campus_name"));
                    users.add(user);
                }
            }

        } catch (SQLException e) {
            throw new AppException("Database error while searching by skill: " + e.getMessage(), e);
        }

        return users;
    }

    // ─────────────────────────────────────────────────────────
    // HELPER — Convert a ResultSet row into a User object
    // ─────────────────────────────────────────────────────────

    /**
     * Maps a database ResultSet row to a User object.
     * This is a private helper method to avoid repeating code.
     *
     * @param rs the ResultSet positioned at a valid row
     * @return a User object populated with data from the row
     * @throws SQLException if a column cannot be read
     */
    private User mapResultSetToUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setEmail(rs.getString("email"));
        user.setPasswordHash(rs.getString("password_hash"));
        user.setFirstName(rs.getString("first_name"));
        user.setLastName(rs.getString("last_name"));
        user.setInstitutionId(rs.getInt("institution_id"));
        user.setCampusId(rs.getInt("campus_id"));
        user.setCourse(rs.getString("course"));
        user.setYearOfStudy(rs.getInt("year_of_study"));
        user.setBio(rs.getString("bio"));
        user.setCreatedAt(rs.getTimestamp("created_at"));
        user.setUpdatedAt(rs.getTimestamp("updated_at"));
        return user;
    }
}
