package com.campusskillconnect.model;

import java.sql.Timestamp;

/**
 * User — Represents a registered student in the system.
 *
 * This is the main entity of the application. Each user:
 *   - Belongs to one Institution and one Campus
 *   - Has a hashed password (never plain text)
 *   - Can have multiple Skills (stored in separate table)
 *   - Can send/receive SkillRequests
 *
 * Database table: users
 *
 * OOP CONCEPTS:
 * - Encapsulation (private fields + getters/setters)
 * - Constructors (no-arg + parameterized)
 * - Methods (getFullName() is a computed/derived method)
 */
public class User {

    // ── Private Fields (mapped to database columns) ─────────
    private int id;
    private String email;
    private String passwordHash;    // BCrypt hashed — NEVER plain text
    private String firstName;
    private String lastName;
    private int institutionId;      // FK → institutions.id
    private int campusId;           // FK → campuses.id
    private String course;          // e.g., "MCA", "B.Tech CSE"
    private int yearOfStudy;        // e.g., 1, 2, 3
    private String bio;             // Short self-description
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // ── Display-only fields (not in database) ───────────────
    // These are populated by JOIN queries for display purposes.
    // For example, search results show institution/campus names.
    private String institutionName;
    private String campusName;

    // ── Constructors ────────────────────────────────────────

    /** No-argument constructor */
    public User() {
    }

    /** Constructor for registration (before saving to DB, so no id yet) */
    public User(String email, String passwordHash, String firstName,
                String lastName, int institutionId, int campusId) {
        this.email = email;
        this.passwordHash = passwordHash;
        this.firstName = firstName;
        this.lastName = lastName;
        this.institutionId = institutionId;
        this.campusId = campusId;
    }

    // ── Custom Methods ──────────────────────────────────────

    /**
     * Returns the student's full name by combining first and last name.
     * This is a "derived" or "computed" method — it doesn't have
     * its own field, but calculates the value from existing fields.
     *
     * @return full name, e.g., "Rahul Sharma"
     */
    public String getFullName() {
        if (firstName == null && lastName == null) {
            return "";
        }
        if (lastName == null || lastName.isEmpty()) {
            return firstName;
        }
        return firstName + " " + lastName;
    }

    // ── Getters and Setters ─────────────────────────────────

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public int getInstitutionId() {
        return institutionId;
    }

    public void setInstitutionId(int institutionId) {
        this.institutionId = institutionId;
    }

    public int getCampusId() {
        return campusId;
    }

    public void setCampusId(int campusId) {
        this.campusId = campusId;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public int getYearOfStudy() {
        return yearOfStudy;
    }

    public void setYearOfStudy(int yearOfStudy) {
        this.yearOfStudy = yearOfStudy;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    // Display-only getters/setters (for JOIN query results)

    public String getInstitutionName() {
        return institutionName;
    }

    public void setInstitutionName(String institutionName) {
        this.institutionName = institutionName;
    }

    public String getCampusName() {
        return campusName;
    }

    public void setCampusName(String campusName) {
        this.campusName = campusName;
    }

    // ── toString() ──────────────────────────────────────────

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", email='" + email + '\'' +
                ", name='" + getFullName() + '\'' +
                ", course='" + course + '\'' +
                ", yearOfStudy=" + yearOfStudy +
                '}';
    }
}
