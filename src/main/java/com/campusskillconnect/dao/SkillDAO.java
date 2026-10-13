package com.campusskillconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.Skill;

/**
 * SkillDAO — Data Access Object for the "skills" table.
 *
 * Handles all CRUD operations for student skills:
 *   C = Create (addSkill)
 *   R = Read   (findById, getSkillsByUserId)
 *   U = Update (updateSkill)
 *   D = Delete (deleteSkill)
 */
public class SkillDAO {

    private final DatabaseConnection dbConnection;

    public SkillDAO() {
        this.dbConnection = new DatabaseConnection();
    }

    // ─────────────────────────────────────────────────────────
    // CREATE — Add a new skill for a user
    // ─────────────────────────────────────────────────────────

    /**
     * Adds a new skill to a user's profile.
     *
     * @param skill the Skill object to insert
     * @return the auto-generated ID of the new skill
     * @throws AppException if the insert fails
     */
    public int addSkill(Skill skill) throws AppException {
        String sql = "INSERT INTO skills (user_id, skill_name, proficiency_level, description) " +
                     "VALUES (?, ?, ?, ?)";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setInt(1, skill.getUserId());
            stmt.setString(2, skill.getSkillName());
            stmt.setString(3, skill.getProficiencyLevel().name()); // Enum → String (e.g., "INTERMEDIATE")
            stmt.setString(4, skill.getDescription());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new AppException("Failed to add skill — no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int generatedId = generatedKeys.getInt(1);
                    skill.setId(generatedId);
                    return generatedId;
                }
                throw new AppException("Failed to retrieve generated skill ID.");
            }

        } catch (SQLException e) {
            throw new AppException("Database error while adding skill: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // READ — Get all skills for a specific user
    // ─────────────────────────────────────────────────────────

    /**
     * Retrieves all skills belonging to a user.
     *
     * @param userId the user's ID
     * @return list of Skill objects (empty list if the user has no skills)
     * @throws AppException if a database error occurs
     */
    public List<Skill> getSkillsByUserId(int userId) throws AppException {
        String sql = "SELECT * FROM skills WHERE user_id = ? ORDER BY skill_name";
        List<Skill> skills = new ArrayList<>();

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    skills.add(mapResultSetToSkill(rs));
                }
            }

        } catch (SQLException e) {
            throw new AppException("Database error while fetching skills: " + e.getMessage(), e);
        }

        return skills;
    }

    // ─────────────────────────────────────────────────────────
    // READ — Find a skill by its ID
    // ─────────────────────────────────────────────────────────

    /**
     * Finds a single skill by its ID.
     *
     * @param id the skill's database ID
     * @return the Skill object if found, or null
     * @throws AppException if a database error occurs
     */
    public Skill findById(int id) throws AppException {
        String sql = "SELECT * FROM skills WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToSkill(rs);
                }
                return null;
            }

        } catch (SQLException e) {
            throw new AppException("Database error while finding skill: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // UPDATE — Edit an existing skill
    // ─────────────────────────────────────────────────────────

    /**
     * Updates an existing skill's details.
     *
     * @param skill the Skill object with updated values
     * @throws AppException if the update fails
     */
    public void updateSkill(Skill skill) throws AppException {
        String sql = "UPDATE skills SET skill_name = ?, proficiency_level = ?, " +
                     "description = ? WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, skill.getSkillName());
            stmt.setString(2, skill.getProficiencyLevel().name());
            stmt.setString(3, skill.getDescription());
            stmt.setInt(4, skill.getId());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new AppException("No skill found with ID: " + skill.getId());
            }

        } catch (SQLException e) {
            throw new AppException("Database error while updating skill: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // DELETE — Remove a skill
    // ─────────────────────────────────────────────────────────

    /**
     * Deletes a skill by its ID.
     *
     * @param id the skill's database ID
     * @throws AppException if the delete fails
     */
    public void deleteSkill(int id) throws AppException {
        String sql = "DELETE FROM skills WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                throw new AppException("No skill found with ID: " + id);
            }

        } catch (SQLException e) {
            throw new AppException("Database error while deleting skill: " + e.getMessage(), e);
        }
    }

    // ─────────────────────────────────────────────────────────
    // HELPER — Convert a ResultSet row to a Skill object
    // ─────────────────────────────────────────────────────────

    private Skill mapResultSetToSkill(ResultSet rs) throws SQLException {
        Skill skill = new Skill();
        skill.setId(rs.getInt("id"));
        skill.setUserId(rs.getInt("user_id"));
        skill.setSkillName(rs.getString("skill_name"));
        skill.setProficiencyLevelFromString(rs.getString("proficiency_level"));
        skill.setDescription(rs.getString("description"));
        skill.setCreatedAt(rs.getTimestamp("created_at"));
        return skill;
    }
}
