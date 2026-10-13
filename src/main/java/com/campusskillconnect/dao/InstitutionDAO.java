package com.campusskillconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.campusskillconnect.exception.AppException;
import com.campusskillconnect.model.Campus;
import com.campusskillconnect.model.Institution;

/**
 * InstitutionDAO — Data Access Object for institutions and campuses.
 *
 * This is a READ-ONLY DAO. Institutions and campuses are added
 * by the admin via SQL seed data (02_seed_data.sql), not through
 * the web application.
 *
 * Used by:
 *   - Registration page → populate institution dropdown
 *   - Registration page → populate campus dropdown (based on selected institution)
 *   - Profile page → show institution/campus names
 */
public class InstitutionDAO {

    private final DatabaseConnection dbConnection;

    public InstitutionDAO() {
        this.dbConnection = new DatabaseConnection();
    }

    // ─────────────────────────────────────────────────────────
    // Get all institutions (for dropdown lists)
    // ─────────────────────────────────────────────────────────

    /**
     * Returns all institutions in the system, sorted alphabetically.
     *
     * @return list of Institution objects
     * @throws AppException if a database error occurs
     */
    public List<Institution> getAllInstitutions() throws AppException {
        String sql = "SELECT * FROM institutions ORDER BY name";
        List<Institution> institutions = new ArrayList<>();

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Institution inst = new Institution();
                inst.setId(rs.getInt("id"));
                inst.setName(rs.getString("name"));
                inst.setCity(rs.getString("city"));
                inst.setState(rs.getString("state"));
                inst.setCreatedAt(rs.getTimestamp("created_at"));
                institutions.add(inst);
            }

        } catch (SQLException e) {
            throw new AppException("Database error while fetching institutions: " + e.getMessage(), e);
        }

        return institutions;
    }

    // ─────────────────────────────────────────────────────────
    // Get campuses for a specific institution
    // ─────────────────────────────────────────────────────────

    /**
     * Returns all campuses belonging to a specific institution.
     * Used to dynamically populate the campus dropdown when
     * a user selects an institution.
     *
     * @param institutionId the institution's database ID
     * @return list of Campus objects for that institution
     * @throws AppException if a database error occurs
     */
    public List<Campus> getCampusesByInstitution(int institutionId) throws AppException {
        String sql = "SELECT * FROM campuses WHERE institution_id = ? ORDER BY name";
        List<Campus> campuses = new ArrayList<>();

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, institutionId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Campus campus = new Campus();
                    campus.setId(rs.getInt("id"));
                    campus.setInstitutionId(rs.getInt("institution_id"));
                    campus.setName(rs.getString("name"));
                    campus.setAddress(rs.getString("address"));
                    campus.setCreatedAt(rs.getTimestamp("created_at"));
                    campuses.add(campus);
                }
            }

        } catch (SQLException e) {
            throw new AppException("Database error while fetching campuses: " + e.getMessage(), e);
        }

        return campuses;
    }

    /**
     * Alias method for getCampusesByInstitution.
     */
    public List<Campus> getCampusesByInstitutionId(int institutionId) throws AppException {
        return getCampusesByInstitution(institutionId);
    }

    // ─────────────────────────────────────────────────────────
    // Find a single institution by ID
    // ─────────────────────────────────────────────────────────

    /**
     * Finds an institution by its ID.
     *
     * @param id the institution's database ID
     * @return the Institution object, or null if not found
     * @throws AppException if a database error occurs
     */
    public Institution findById(int id) throws AppException {
        String sql = "SELECT * FROM institutions WHERE id = ?";

        try (Connection conn = dbConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Institution inst = new Institution();
                    inst.setId(rs.getInt("id"));
                    inst.setName(rs.getString("name"));
                    inst.setCity(rs.getString("city"));
                    inst.setState(rs.getString("state"));
                    inst.setCreatedAt(rs.getTimestamp("created_at"));
                    return inst;
                }
                return null;
            }

        } catch (SQLException e) {
            throw new AppException("Database error while finding institution: " + e.getMessage(), e);
        }
    }
}
