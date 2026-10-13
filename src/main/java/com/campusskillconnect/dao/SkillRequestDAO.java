package com.campusskillconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.SkillRequest;

/**
 * SkillRequestDAO — Data Access Object for the "skill_requests" table.
 *
 * Handles collaboration request operations:
 *   - sendRequest()        → Student A sends a request to Student B
 *   - getReceivedRequests() → Get requests sent TO a user (inbox)
 *   - getSentRequests()    → Get requests sent BY a user
 *   - updateStatus()       → Accept or reject a request
 *   - findById()           → Get a single request by ID
 */
public class SkillRequestDAO {

    private final DatabaseConnection dbConnection;

    public SkillRequestDAO() {
        this.dbConnection = new DatabaseConnection();
    }

    // ─────────────────────────────────────────────────────────
    // CREATE — Send a new collaboration request
    // ─────────────────────────────────────────────────────────

    /**
     * Inserts a new skill request into the database.
     *
     * @param request the SkillRequest to insert
     * @return the auto-generated ID
     * @throws AppException if the insert fails
     */
    public int sendRequest(SkillRequest request) throws AppException {
        String sql = "INSERT INTO skill_requests (from_user_id, to_user_id, skill_id, message, status) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, request.getFromUserId());
            stmt.setInt(2, request.getToUserId());
            stmt.setInt(3, request.getSkillId());
            stmt.setString(4, request.getMessage());
            stmt.setString(5, request.getStatus().name()); // PENDING

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new AppException("Failed to send request — no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int generatedId = generatedKeys.getInt(1);
                    request.setId(generatedId);
                    return generatedId;
                }
                throw new AppException("Failed to retrieve generated request ID.");
            }

        } catch (SQLException e) {
            throw new AppException("Database error while sending request: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // READ — Get requests received by a user (their inbox)
    // ─────────────────────────────────────────────────────────

    /**
     * Retrieves all collaboration requests sent TO a specific user.
     * Includes the sender's name and skill name via JOIN.
     *
     * @param userId the receiving user's ID
     * @return list of SkillRequest objects with display names populated
     * @throws AppException if a database error occurs
     */
    public List<SkillRequest> getReceivedRequests(int userId) throws AppException {
        // JOIN with users and skills to get display names
        String sql = "SELECT sr.*, " +
                     "CONCAT(fu.first_name, ' ', fu.last_name) AS from_user_name, " +
                     "CONCAT(tu.first_name, ' ', tu.last_name) AS to_user_name, " +
                     "s.skill_name AS skill_name " +
                     "FROM skill_requests sr " +
                     "JOIN users fu ON sr.from_user_id = fu.id " +
                     "JOIN users tu ON sr.to_user_id = tu.id " +
                     "JOIN skills s ON sr.skill_id = s.id " +
                     "WHERE sr.to_user_id = ? " +
                     "ORDER BY sr.created_at DESC";

        return executeRequestQuery(sql, userId);
    }

    // ─────────────────────────────────────────────────────────
    // READ — Get requests sent by a user
    // ─────────────────────────────────────────────────────────

    /**
     * Retrieves all collaboration requests sent BY a specific user.
     *
     * @param userId the sending user's ID
     * @return list of SkillRequest objects
     * @throws AppException if a database error occurs
     */
    public List<SkillRequest> getSentRequests(int userId) throws AppException {
        String sql = "SELECT sr.*, " +
                     "CONCAT(fu.first_name, ' ', fu.last_name) AS from_user_name, " +
                     "CONCAT(tu.first_name, ' ', tu.last_name) AS to_user_name, " +
                     "s.skill_name AS skill_name " +
                     "FROM skill_requests sr " +
                     "JOIN users fu ON sr.from_user_id = fu.id " +
                     "JOIN users tu ON sr.to_user_id = tu.id " +
                     "JOIN skills s ON sr.skill_id = s.id " +
                     "WHERE sr.from_user_id = ? " +
                     "ORDER BY sr.created_at DESC";

        return executeRequestQuery(sql, userId);
    }

    // ─────────────────────────────────────────────────────────
    // UPDATE — Accept or reject a request
    // ─────────────────────────────────────────────────────────

    /**
     * Updates the status of a skill request (ACCEPTED or REJECTED).
     *
     * @param requestId the request's database ID
     * @param status    the new status ("ACCEPTED" or "REJECTED")
     * @throws AppException if the update fails
     */
    public void updateStatus(int requestId, String status) throws AppException {
        String sql = "UPDATE skill_requests SET status = ? WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, requestId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new AppException("No request found with ID: " + requestId);
            }

        } catch (SQLException e) {
            throw new AppException("Database error while updating request status: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // READ — Find a single request by ID
    // ─────────────────────────────────────────────────────────

    /**
     * Finds a single request by its ID.
     *
     * @param id the request's database ID
     * @return the SkillRequest if found, or null
     * @throws AppException if a database error occurs
     */
    public SkillRequest findById(int id) throws AppException {
        String sql = "SELECT sr.*, " +
                     "CONCAT(fu.first_name, ' ', fu.last_name) AS from_user_name, " +
                     "CONCAT(tu.first_name, ' ', tu.last_name) AS to_user_name, " +
                     "s.skill_name AS skill_name " +
                     "FROM skill_requests sr " +
                     "JOIN users fu ON sr.from_user_id = fu.id " +
                     "JOIN users tu ON sr.to_user_id = tu.id " +
                     "JOIN skills s ON sr.skill_id = s.id " +
                     "WHERE sr.id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRequest(rs);
                }
                return null;
            }

        } catch (SQLException e) {
            throw new AppException("Database error while finding request: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // HELPERS
    // ─────────────────────────────────────────────────────────

    /**
     * Shared helper: Executes a request query with a single user ID parameter.
     * Used by getReceivedRequests() and getSentRequests() to avoid code duplication.
     */
    private List<SkillRequest> executeRequestQuery(String sql, int userId) throws AppException {
        List<SkillRequest> requests = new ArrayList<>();

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    requests.add(mapResultSetToRequest(rs));
                }
            }

        } catch (SQLException e) {
            throw new AppException("Database error while fetching requests: " + e.getMessage(), e);
        }

        return requests;
    }

    /**
     * Maps a database ResultSet row to a SkillRequest object.
     */
    private SkillRequest mapResultSetToRequest(ResultSet rs) throws SQLException {
        SkillRequest request = new SkillRequest();
        request.setId(rs.getInt("id"));
        request.setFromUserId(rs.getInt("from_user_id"));
        request.setToUserId(rs.getInt("to_user_id"));
        request.setSkillId(rs.getInt("skill_id"));
        request.setMessage(rs.getString("message"));
        request.setStatusFromString(rs.getString("status"));
        request.setCreatedAt(rs.getTimestamp("created_at"));
        request.setUpdatedAt(rs.getTimestamp("updated_at"));

        // Display-only fields from JOINs
        request.setFromUserName(rs.getString("from_user_name"));
        request.setToUserName(rs.getString("to_user_name"));
        request.setSkillName(rs.getString("skill_name"));

        return request;
    }
}
